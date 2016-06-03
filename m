From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 0/7] Generic DT bindings for PCI IOMMUs and ARM SMMUv3
Date: Fri,  3 Jun 2016 18:15:35 +0100
Message-ID: <cover.1464966939.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi all,

Compared to v1[1] this is more or less a repost of the core parts, although
patch 1 is new. I still need to take the horrible SMMUv2 code out back and
shoot it (there turned out to be some subtle nasties in v1), so in the
meantime I picked up the SMMUv3 ticket to fill in as it was rather more
straightforward. I'll be reworking SMMUv2 on top of these patches (modulo
any feedback) to post in another week or so.

Note that patch 6 might not be plausible to queue just yet as it ends up
looking like a regression due to deficiencies elsewhere - the virtio block
device on the SMMUv3 Fast Model blows up because virtio doesn't use the DMA
API appropriately on a host (although hacking vring_use_dma_api() suffices),
and MSIs are still an open problem - I could really do with focusing on that
with Eric, so it'd be nice to get as much of this out of the way as I can :)

Branch at git://linux-arm.org/linux-rm iommu/generic-v2

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/12454

Mark Rutland (1):
  Docs: dt: add PCI IOMMU map bindings

Robin Murphy (6):
  iommu/of: Respect disabled IOMMUs
  of/irq: Break out msi-map lookup (again)
  iommu/of: Handle iommu-map property for PCI
  iommu/arm-smmu: Implement of_xlate() for SMMUv3
  iommu/arm-smmu: Finish off SMMUv3 default domain support
  iommu/arm-smmu: Support non-PCI devices with SMMUv3

 .../devicetree/bindings/pci/pci-iommu.txt          | 171 ++++++++++++
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/arm-smmu-v3.c                        | 300 +++++++++------------
 drivers/iommu/of_iommu.c                           |  73 +++--
 drivers/of/irq.c                                   |  70 +----
 drivers/of/of_pci.c                                | 102 +++++++
 include/linux/of_pci.h                             |   8 +
 7 files changed, 460 insertions(+), 266 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-iommu.txt

-- 
2.8.1.dirty
