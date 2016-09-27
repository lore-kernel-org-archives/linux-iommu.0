From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 00/11] KVM PCIe/MSI passthrough on ARM/ARM64: re-design with
	transparent MSI mapping
Date: Tue, 27 Sep 2016 20:48:27 +0000
Message-ID: <1475009318-2617-1-git-send-email-eric.auger@redhat.com>
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
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Following Robin's series [1] addressing MSI IOMMU mapping for devices
attached to a DMA ops domain, my previous 3 part series (v12) lost most
of its consistency. msi-iommu API role now is handled at dma-iommu level
while MSI doorbell registration API only is used for security assessment.
Also MSI layer part is not needed anymore since mapping directly is
done in the compose callback.

Here I propose an alternative approach, based on [1]. This approach
was discussed at the KVM forum with Christoffer Dall and Marc Zyngier,
and was suggested by Christoffer. The idea is we could let the iommu
layer transparently allocate MSI frame IOVAs in the holes left between
UNMANAGED iova slots, set by the iommu-api user.

This series introduces a new IOMMU domain type that allows mixing of
unmanaged and managed IOVA slots. We define an IOVA domain whose
aperture covers the GPA address range. Each time the IOMMU-API
user maps iova/pa, we reserve the IOVA range to prevent the iova
allocator from using it for MSI mapping.

This simplifies the user part which does not need anymore to provide an
IOVA aperture anymore.

The current series does not address the interrupt safety assessment,
which may be considered as a separate issue. Currently the assignemnt
is considered as unsafe, on ARM (even with a GICv3 ITS).

Please let me know what is your feeling wrt this alternative approach.

dependency:
[1] [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
http://www.spinics.net/lists/arm-kernel/msg531110.html

Best Regards

Eric

Testing:
- functional on ARM64 AMD Overdrive HW (single GICv2m frame). Lack of contexts
  prevents me from testing multiple assignment.

Git: complete series available at
https://github.com/eauger/linux/tree/generic-v7-pcie-passthru-redesign-rfc
previous: https://github.com/eauger/linux/tree/v4.7-rc7-passthrough-v12

the above branch includes a temporary patch to work around a ThunderX pci
bus reset crash (which I think unrelated to this series):
"vfio: pci: HACK! workaround thunderx pci_try_reset_bus crash"
Do not take this one for other platforms.


Eric Auger (10):
  iommu: Add iommu_domain_msi_geometry and DOMAIN_ATTR_MSI_GEOMETRY
  iommu: Introduce IOMMU_CAP_TRANSLATE_MSI capability
  iommu: Introduce IOMMU_DOMAIN_MIXED
  iommu/dma: iommu_dma_(un)map_mixed
  iommu/arm-smmu: Allow IOMMU_DOMAIN_MIXED domain allocation
  iommu: Use IOMMU_DOMAIN_MIXED typed domain when IOMMU translates MSI
  vfio/type1: Sets the IOVA window in case MSI IOVA need to be allocated
  vfio/type1: Reserve IOVAs for IOMMU_DOMAIN_MIXED domains
  iommu/arm-smmu: Do not advertise IOMMU_CAP_INTR_REMAP
  iommu/arm-smmu: Advertise IOMMU_CAP_TRANSLATE_MSI

Robin Murphy (1):
  iommu/dma: Allow MSI-only cookies

 drivers/iommu/arm-smmu-v3.c     |  8 +++-
 drivers/iommu/arm-smmu.c        |  8 +++-
 drivers/iommu/dma-iommu.c       | 91 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c           | 10 ++++-
 drivers/vfio/vfio_iommu_type1.c | 48 ++++++++++++++++++----
 include/linux/dma-iommu.h       | 27 ++++++++++++
 include/linux/iommu.h           | 23 +++++++++++
 7 files changed, 203 insertions(+), 12 deletions(-)

-- 
1.9.1
