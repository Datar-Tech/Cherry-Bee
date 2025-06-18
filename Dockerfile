# Network Connectivity Test Dockerfile
# This dockerfile runs various tests to diagnose network issues in corporate environments

FROM ubuntu:22.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install basic networking tools first (if possible)
RUN echo "=== PHASE 1: Installing basic tools ===" && \
    apt-get update -y || echo "Initial apt-get update failed" && \
    apt-get install -y curl wget dnsutils iputils-ping net-tools traceroute || echo "Tool installation failed"

# Test 1: Basic network connectivity
RUN echo "=== TEST 1: Basic Network Connectivity ===" && \
    echo "Testing DNS resolution:" && \
    nslookup google.com || echo "DNS resolution failed" && \
    echo "Testing ping to Google:" && \
    ping -c 3 8.8.8.8 || echo "Ping to 8.8.8.8 failed" && \
    echo "Testing ping to Google DNS:" && \
    ping -c 3 google.com || echo "Ping to google.com failed"

# Test 2: Ubuntu repository connectivity
RUN echo "=== TEST 2: Ubuntu Repository Connectivity ===" && \
    echo "Testing archive.ubuntu.com:" && \
    curl -I http://archive.ubuntu.com/ || echo "HTTP request to archive.ubuntu.com failed" && \
    curl -I https://archive.ubuntu.com/ || echo "HTTPS request to archive.ubuntu.com failed" && \
    echo "Testing security.ubuntu.com:" && \
    curl -I http://security.ubuntu.com/ || echo "HTTP request to security.ubuntu.com failed" && \
    echo "Testing ports.ubuntu.com:" && \
    curl -I http://ports.ubuntu.com/ || echo "HTTP request to ports.ubuntu.com failed"

# Test 3: DNS server tests
RUN echo "=== TEST 3: DNS Server Tests ===" && \
    echo "Current DNS configuration:" && \
    cat /etc/resolv.conf && \
    echo "Testing with Google DNS:" && \
    nslookup archive.ubuntu.com 8.8.8.8 || echo "Google DNS lookup failed" && \
    echo "Testing with Cloudflare DNS:" && \
    nslookup archive.ubuntu.com 1.1.1.1 || echo "Cloudflare DNS lookup failed"

# Test 4: Repository mirror tests
RUN echo "=== TEST 4: Repository Mirror Tests ===" && \
    echo "Testing US mirror:" && \
    curl -I http://us.archive.ubuntu.com/ || echo "US mirror failed" && \
    echo "Testing UK mirror:" && \
    curl -I http://gb.archive.ubuntu.com/ || echo "UK mirror failed" && \
    echo "Testing German mirror:" && \
    curl -I http://de.archive.ubuntu.com/ || echo "German mirror failed"

# Test 5: Port connectivity tests
RUN echo "=== TEST 5: Port Connectivity Tests ===" && \
    echo "Testing HTTP (port 80):" && \
    timeout 10 bash -c "</dev/tcp/archive.ubuntu.com/80" && echo "Port 80 accessible" || echo "Port 80 blocked" && \
    echo "Testing HTTPS (port 443):" && \
    timeout 10 bash -c "</dev/tcp/archive.ubuntu.com/443" && echo "Port 443 accessible" || echo "Port 443 blocked"

# Test 6: Apt configuration and sources
RUN echo "=== TEST 6: Apt Configuration ===" && \
    echo "Current sources.list:" && \
    cat /etc/apt/sources.list && \
    echo "Apt configuration:" && \
    apt-config dump || echo "Apt config dump failed"

# Test 7: Try apt update with verbose output
RUN echo "=== TEST 7: Detailed Apt Update Test ===" && \
    apt-get update -o Debug::pkgAcquire::Worker=1 -o Debug::Acquire::http=1 || echo "Verbose apt update failed"

# Test 8: Try different repositories
RUN echo "=== TEST 8: Alternative Repository Test ===" && \
    echo "Backing up original sources.list" && \
    cp /etc/apt/sources.list /etc/apt/sources.list.backup && \
    echo "Trying with different mirror:" && \
    sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list && \
    apt-get update || echo "Alternative mirror failed" && \
    echo "Restoring original sources.list" && \
    cp /etc/apt/sources.list.backup /etc/apt/sources.list

# Test 9: Network interface and routing information
RUN echo "=== TEST 9: Network Interface Information ===" && \
    echo "Network interfaces:" && \
    ip addr show || ifconfig || echo "Network interface check failed" && \
    echo "Routing table:" && \
    ip route show || route -n || echo "Routing table check failed"

# Test 10: HTTP headers and response details
RUN echo "=== TEST 10: Detailed HTTP Response Test ===" && \
    echo "Detailed curl to archive.ubuntu.com:" && \
    curl -v -L http://archive.ubuntu.com/ubuntu/dists/jammy/Release 2>&1 || echo "Detailed curl failed" && \
    echo "Testing with different user agent:" && \
    curl -v -H "User-Agent: apt/2.4.0" http://archive.ubuntu.com/ubuntu/dists/jammy/Release 2>&1 || echo "User agent test failed"

# Test 11: Certificate and SSL tests
RUN echo "=== TEST 11: SSL Certificate Tests ===" && \
    echo "Testing SSL connection:" && \
    openssl s_client -connect archive.ubuntu.com:443 -servername archive.ubuntu.com < /dev/null || echo "SSL test failed"

# Final test: Try a simple package installation
RUN echo "=== FINAL TEST: Package Installation ===" && \
    apt-get update && \
    apt-get install -y vim && \
    echo "Package installation successful!" || echo "Package installation failed - this is the main issue"

# Display final summary
RUN echo "=== DIAGNOSTIC SUMMARY ===" && \
    echo "If you see this message, the container built successfully!" && \
    echo "Check the output above for any failed tests to identify the network issue." && \
    echo "Common issues:" && \
    echo "- DNS resolution failures indicate DNS problems" && \
    echo "- Port connectivity failures indicate firewall issues" && \
    echo "- SSL certificate errors indicate corporate certificate filtering" && \
    echo "- 403 errors on specific repositories indicate content filtering"

# Keep container running for interactive debugging if needed
CMD ["/bin/bash"]