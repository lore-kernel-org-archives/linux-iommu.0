From: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 00/12] DMA-API/PCI map_peer_resource support for
	peer-to-peer
Date: Wed, 22 Jul 2015 16:39:45 -0500
Message-ID: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terence Ripperda <tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "David S.
	Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

This is the fourth version of a patchset to add the DMA APIs necessary to
map and unmap a PCI device's BAR to and from another PCI device's IOVA
domain. This enables PCI peer-to-peer traffic on x86 platforms where an
IOMMU is enabled (this requires that peer-to-peer traffic be supported by
the underlying chipset as well, of course).

Thanks,
Will

v4:
- added HAS_DMA_P2P Kconfig option to guard new APIs, which are only
  supported on x86 with this patch series
- added a new dma_peer_addr_t type to handle future platform support
  where the dma_peer_addr_t needs to have the same width as the bus
  address, which can be wider than the dma_addr_t returned by other
  DMA APIs
- added a new dma_peer_mapping_error() and associated PCI wrapper to
  detect errors returned via dma_map_peer_resource() API and its
  PCI wrapper
- modified the interface of the new API to explicitly take the peer
  device as an argument
- renamed the (un)map_resource APIs to (un)map_peer_resource, since
  they directly receive a 'peer' argument now
- modified the new PCI interface to take the BAR index instead of the
  actual struct resource
- modified the pci-nommu implementation to perform topology and ACS
  checks before allowing
- modified both the AMD and Intel IOMMU implementations to require
  that both devices be behind the same host bridge
- exposed a couple of preexisting PCI utility functions to aid in the
  topology checks for all of the x86 implementations

v3: http://www.spinics.net/lists/linux-pci/msg41703.html
- changed dma_map_resource() to BUG() if the map_resource DMA op is not
  provided, instead of returning 0
- updated documentation to remove requirement to check for 0 return value
  as an error
- remove const keyword from struct dma_map_ops in new DMA APIs for
  consistency with other APIs

v2: http://www.spinics.net/lists/linux-pci/msg41192.html
- added documentation for the new DMA APIs
- fixed physical-to-bus address conversion in the nommu implementation

v1: http://www.spinics.net/lists/linux-pci/msg40747.html



Will Davis (12):
  lib/Kconfig: add HAS_DMA_P2P for peer-to-peer support
  linux/types.h: Add dma_peer_addr_t type
  dma-debug: add checking for map/unmap_peer_resource
  DMA-API: Introduce dma_(un)map_peer_resource
  dma-mapping: pci: add pci_(un)map_peer_resource
  DMA-API: Add peer resource mapping documentation
  pci: expose pci_find_host_bridge()
  iommu/amd: Implement (un)map_peer_resource
  iommu/vt-d: implement (un)map_peer_resource
  pci: add pci_find_common_upstream_dev()
  x86: add pci-nommu implementation of map_peer_resource
  x86: declare support for DMA P2P

 Documentation/DMA-API-HOWTO.txt          | 46 ++++++++++++++-
 Documentation/DMA-API.txt                | 36 ++++++++++--
 arch/x86/Kconfig                         |  1 +
 arch/x86/include/asm/dma-mapping.h       | 18 +++++-
 arch/x86/kernel/pci-nommu.c              | 96 +++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu.c                | 99 +++++++++++++++++++++++++++-----
 drivers/iommu/intel-iommu.c              | 38 ++++++++++++
 drivers/pci/host-bridge.c                | 19 +-----
 drivers/pci/search.c                     | 25 ++++++++
 include/asm-generic/dma-mapping-common.h | 43 ++++++++++++++
 include/asm-generic/pci-dma-compat.h     | 23 ++++++++
 include/linux/dma-debug.h                | 39 ++++++++++++-
 include/linux/dma-mapping.h              | 12 ++++
 include/linux/pci.h                      |  9 +++
 include/linux/types.h                    | 13 ++++-
 lib/Kconfig                              |  5 ++
 lib/dma-debug.c                          | 86 ++++++++++++++++++++++++++-
 17 files changed, 564 insertions(+), 44 deletions(-)

-- 
2.4.6
