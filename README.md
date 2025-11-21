# 5G MEC Research Platform v2

**Working OAI RFsim Setup with 5G Core, gNB, and UE**

## Architecture
┌─────────────────────────────────────────────────────────┐
│ 5G Core Network │
│ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐ │
│ │ AMF │ │ SMF │ │ UPF │ │ NRF │ │ UDR │ │ UDM │ │
│ └─────┘ └─────┘ └─────┘ └─────┘ └─────┘ └─────┘ │
│ ┌─────┐ ┌───────┐ │
│ │AUSF │ │ MySQL │ │
│ └─────┘ └───────┘ │
└─────────────────────────────────────────────────────────┘
│
│ N2/N3
↓
┌───────────────┐
│ gNB (RFsim) │
└───────────────┘
│
│ NR Uu (RF Simulator)
↓
┌───────────────┐
│ UE (x10) │
└───────────────┘

## Components

### RAN (Radio Access Network)
- **gNB**: OAI gNodeB with RF Simulator
- **UE**: OAI NR-UE (10 concurrent UEs supported)

### 5G Core Network
- **AMF**: Access and Mobility Management Function
- **SMF**: Session Management Function
- **UPF**: User Plane Function
- **NRF**: NF Repository Function
- **UDR**: Unified Data Repository
- **UDM**: Unified Data Management
- **AUSF**: Authentication Server Function

### Database
- **MySQL 8.0**: Subscriber database

## Quick Start

### Prerequisites
- Docker Engine 20.10+
- Docker Compose v2+
- Linux host (Ubuntu 20.04/22.04 recommended)

### Installation

1. **Clone Repository**
git clone git@github.com:Ajaychander19/5GMECv2.git
cd 5GMECv2/ran

2. **Start the Stack**

docker compose -f docker-compose.yaml up -d

3. **Verify All Services**

docker ps

4. **Check UE Connection**

docker logs rfsim5g-oai-nr-ue | grep -i "registration|rrc"
docker logs rfsim5g-oai-amf | grep -A 15 "UEs' Information"

text

### Stop the Stack

docker compose -f docker-compose.yaml down

## Image Versions

See [docs/IMAGE_VERSIONS.txt](docs/IMAGE_VERSIONS.txt) for exact Docker image tags.

- **RAN**: `develop` (latest)
- **Core**: `v2.1.10` (stable)
- **Database**: `8.0`

## Network Configuration

### Default Subnet
- **public_net**: `192.168.71.128/26`
- **traffic_net**: `192.168.72.128/26`

### Key IP Addresses
- MySQL: `192.168.71.131`
- AMF: `192.168.71.132`
- SMF: `192.168.71.133`
- UPF: `192.168.71.134`
- gNB: `192.168.71.140`
- UE1: `192.168.71.150`
- UE2-10: `192.168.71.151-159`

## Verified Working State

✅ gNB transmitting SSB/PBCH  
✅ UE synchronized and decoded SIB1  
✅ 4-Step RA procedure successful  
✅ RRC Setup Complete  
✅ 10 concurrent UEs connected  
✅ NAS Registration in progress  

## Troubleshooting

### Check Container Status
docker ps -a

### View Logs
gNB
docker logs rfsim5g-oai-gnb

UE
docker logs rfsim5g-oai-nr-ue

AMF
docker logs rfsim5g-oai-amf

MySQL
docker logs rfsim5g-mysql

### Common Issues

**MySQL fails to start:**
- Check that `oai_db.sql` and `mysql-healthcheck.sh` exist in `ran/`
- Verify file permissions

**gNB/UE fail with "config file not found":**
- Verify `conf_files/` directory exists
- Check volume mounts in `docker-compose.yaml`

**UE not connecting:**
- Check gNB logs for SSB transmission
- Verify network connectivity between containers
- Ensure IMSIs in compose match subscriber DB

## Directory Structure

5GMECv2/
├── ran/
│ ├── docker-compose.yaml # Main compose file
│ ├── mini_nonrf_config.yaml # Core NF configs
│ ├── oai_db.sql # Subscriber database
│ ├── mysql-healthcheck.sh # MySQL health check
│ └── conf_files/ # gNB and UE configs
├── docs/
│ └── IMAGE_VERSIONS.txt # Docker image versions
└── README.md # This file

## Contributing

Pull requests welcome! Please ensure:
1. All containers start successfully
2. UE can register with Core
3. Documentation is updated

## License

Research and educational use only.

## Acknowledgments

Based on:
- [OpenAirInterface 5G](https://openairinterface.org/)
- [OAI GitLab CI/CD Examples](https://gitlab.eurecom.fr/oai/openairinterface5g)

## Contact

For issues, open a GitHub issue or contact: [Your Contact]

---

**Status**: ✅ Production-Ready for MEC Research (as of 2025-11-21)
