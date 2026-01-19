# Open WebUI Dockerfile for Choreo

# Version

v0.7.1

# Releases

## [0.7.1] - 2026-01-09

### Fixed

- ⚡ Improved reliability for low-spec and SQLite deployments. Fixed page timeouts by disabling database session sharing by default, improving stability for resource-constrained environments. Users can re-enable via 'DATABASE_ENABLE_SESSION_SHARING=true' if needed.
