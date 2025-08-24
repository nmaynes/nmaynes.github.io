---
title: "2025 08 24 Claude and Docker Mcp Toolkit on Ubuntu"
date: 2025-08-24T12:29:12-04:00
slug: 2025-08-24-2025-08-24-claude-and-docker-mcp-toolkit-on-ubuntu
type: posts
draft: true
categories:
  - default
tags:
  - default
---
# How to Set Up Claude Desktop with Docker MCP Toolkit on Ubuntu

Getting Claude Desktop working with Docker Desktop's MCP (Model Context Protocol) toolkit on Ubuntu requires a few manual configuration steps. This guide walks you through the complete process, from installing both Docker Desktop and Claude Desktop to successfully connecting them via MCP integration.

## Prerequisites

- Ubuntu Linux system
- Basic familiarity with command line operations
- Git installed

## Step 1: Install Docker Desktop

First, install Docker Engine and then Docker Desktop:

```bash
# Add Docker's official GPG key
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Test Docker installation
sudo docker run hello-world

# Download and install Docker Desktop (download the .deb file first)
cd ~/Downloads
sudo apt-get install ./docker-desktop-amd64.deb
```

## Step 2: Install Claude Desktop

Clone and build Claude Desktop using the community repository:

```bash
# Navigate to your code directory
cd ~/Code

# Clone the Claude Desktop repository
git clone https://github.com/emsi/claude-desktop
cd claude-desktop

# Build and install Claude Desktop
./install-claude-desktop.sh
```

The script will automatically:
- Check for and install required dependencies
- Download and extract resources from the Windows version
- Create a proper Debian package
- Guide you through installation

Test that Claude Desktop works:
```bash
claude-desktop
```

## Step 3: Verify Docker MCP Components

Docker Desktop on Ubuntu includes MCP components, but they need to be discovered and configured. Let's check if the MCP components are installed:

```bash
# Check for MCP components in Docker directories
find ~/.docker -name "*mcp*" 2>/dev/null
```

You should see output similar to:
```
/home/username/.docker/mcp
/home/username/.docker/mcp/catalogs/docker-mcp.yaml  
/home/username/.docker/cli-plugins/docker-mcp
```

If you see these files, the MCP components are installed. Let's examine them:

```bash
# Check the MCP CLI plugin details
ls -la ~/.docker/cli-plugins/docker-mcp
file ~/.docker/cli-plugins/docker-mcp

# Check the MCP catalog file
cat ~/.docker/mcp/catalogs/docker-mcp.yaml

# See what's in the MCP directory
ls -la ~/.docker/mcp/
```

## Step 4: Test Docker MCP CLI

Verify that the Docker MCP CLI plugin is working:

```bash
# Test the MCP plugin
docker mcp --help
```

This should show the Docker MCP Toolkit CLI help with various subcommands like `catalog`, `client`, `config`, `gateway`, `server`, etc.

You can also check the current configuration:

```bash
# Check current MCP configuration
docker mcp config show

# List available MCP clients
docker mcp client list
```

## Step 5: Connect Claude Desktop to Docker MCP

This is the crucial step that makes the integration work. Use the Docker MCP CLI to automatically configure Claude Desktop:

```bash
# Connect Claude Desktop globally (system-wide)
docker mcp client connect claude-desktop --global
```

You should see output like:
```
=== System-wide MCP Configurations ===
 ● claude-desktop: connected
   MCP_DOCKER: Docker MCP Catalog (gateway server) (stdio)
 ● gordon: disconnected
You might have to restart 'claude-desktop'.
```

## Step 6: Verify Configuration

Check that the configuration file was created properly:

```bash
# View the Claude Desktop configuration
cat ~/.config/Claude/claude_desktop_config.json
```

The file should contain something like:
```json
{
  "mcpServers": {
    "docker": {
      "command": "docker",
      "args": ["mcp", "client", "connect"],
      "env": {}
    }
  }
}
```

You can also list the configured clients:

```bash
# List MCP client configurations
docker mcp client ls
```

## Step 7: Check Available MCP Servers and Tools

List available MCP servers and tools:

```bash
# Check available servers
docker mcp server list

# List all available MCP tools
docker mcp tools list
```

Initially, you might see servers like `aws-documentation`, `fetch`, `filesystem`, `time`, `wikipedia-mcp`, but no `docker` server.

If the `docker` server is not listed, you may need to add or enable it. After proper configuration, you should see:

```bash
docker mcp server list
# Should show: aws-documentation, docker, fetch, filesystem, sequentialthinking, time, wikipedia-mcp
```

## Step 8: Restart Claude Desktop

**Important**: Completely quit and restart Claude Desktop (don't just refresh):

1. Close Claude Desktop completely
2. Reopen the application

## Step 9: Test the Integration

Once Claude Desktop restarts, you can test the Docker integration by asking Claude to perform Docker operations:

- "Can you list my running Docker containers?"
- "Show me my Docker images"  
- "What's the status of my Docker services?"

Claude should now be able to execute Docker commands and provide real-time information about your Docker environment.

## Troubleshooting

### "Config not found" Error
If you see this error in Docker Desktop's MCP Toolkit screen, it usually means the MCP components aren't properly installed or the connection hasn't been established. Go back to Step 4 and ensure the global connection was successful.

### No Docker Tools Available
If Claude can't access Docker functionality after restarting, check:

1. Verify the Docker server appears in `docker mcp server list`
2. Ensure Claude Desktop was completely restarted
3. Check that Docker Desktop itself is running

### Permission Issues
Make sure your user has proper Docker permissions:

```bash
# Add your user to the docker group (if not already done)
sudo usermod -aG docker $USER
# Log out and back in for changes to take effect
```

## What You Can Do Now

With the integration working, Claude Desktop can help you:

- **Container Management**: List, start, stop, and inspect containers
- **Image Operations**: View images, check sizes, and manage repositories  
- **System Monitoring**: Check Docker system status and resource usage
- **Log Analysis**: Access and analyze container logs
- **Development Workflow**: Streamline Docker-based development tasks

## Conclusion

The Docker MCP integration transforms Claude Desktop into a powerful Docker management interface. While the setup on Ubuntu requires manual configuration (unlike the more automated experience on other platforms), the result is a seamless integration that makes Docker operations much more intuitive and accessible.

The key insight is that Docker Desktop's MCP toolkit exists on Ubuntu but requires the manual connection step using `docker mcp client connect claude-desktop --global` to properly configure the integration.

## Additional Resources

- [Docker MCP Toolkit Documentation](https://docs.docker.com/)
- [Claude Desktop for Linux (emsi/claude-desktop)](https://github.com/emsi/claude-desktop)  
- [Model Context Protocol Specification](https://github.com/modelcontextprotocol/specification)

---

*Have questions or run into issues? The Docker and Claude communities are generally helpful for troubleshooting these integrations.*