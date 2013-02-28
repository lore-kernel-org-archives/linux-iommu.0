From: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH v2 4/4] iommu/amd: Remove calc_devid() and use PCI_DEVID()
	from pci
Date: Wed, 27 Feb 2013 17:07:30 -0700
Message-ID: <1362010050.2808.37.camel@lorien2>
Reply-To: shuah.khan-VXdhtT5mjnY@public.gmane.org
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: jiang.liu-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, shemminger-ZtmgI6mnKB3QT0dZR+AlfA@public.gmane.org, paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, linasvepstas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Change to remove calc_devid() and use PCI_DEVID() from pci instead.

Signed-off-by: Shuah Khan <shuah.khan-VXdhtT5mjnY@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |    2 +-
 drivers/iommu/amd_iommu_init.c  |    6 +++---
 drivers/iommu/amd_iommu_types.h |    7 -------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c1c74e0..38c1392 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -173,7 +173,7 @@ static inline u16 get_device_id(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	return calc_devid(pdev->bus->number, pdev->devfn);
+	return PCI_DEVID(pdev->bus->number, pdev->devfn);
 }
 
 static struct iommu_dev_data *get_dev_data(struct device *dev)
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index faf10ba..582b5df 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -406,7 +406,7 @@ static int __init find_last_devid_on_pci(int bus, int dev, int fn, int cap_ptr)
 	u32 cap;
 
 	cap = read_pci_config(bus, dev, fn, cap_ptr+MMIO_RANGE_OFFSET);
-	update_last_devid(calc_devid(MMIO_GET_BUS(cap), MMIO_GET_LD(cap)));
+	update_last_devid(PCI_DEVID(MMIO_GET_BUS(cap), MMIO_GET_LD(cap)));
 
 	return 0;
 }
@@ -1128,9 +1128,9 @@ static int iommu_init_pci(struct amd_iommu *iommu)
 	pci_read_config_dword(iommu->dev, cap_ptr + MMIO_MISC_OFFSET,
 			      &misc);
 
-	iommu->first_device = calc_devid(MMIO_GET_BUS(range),
+	iommu->first_device = PCI_DEVID(MMIO_GET_BUS(range),
 					 MMIO_GET_FD(range));
-	iommu->last_device = calc_devid(MMIO_GET_BUS(range),
+	iommu->last_device = PCI_DEVID(MMIO_GET_BUS(range),
 					MMIO_GET_LD(range));
 
 	if (!(iommu->cap & (1 << IOMMU_CAP_IOTLB)))
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index a07882f..ec36cf6 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -701,13 +701,6 @@ extern int amd_iommu_max_glx_val;
  */
 extern void iommu_flush_all_caches(struct amd_iommu *iommu);
 
-/* takes bus and device/function and returns the device id
- * FIXME: should that be in generic PCI code? */
-static inline u16 calc_devid(u8 bus, u8 devfn)
-{
-	return (((u16)bus) << 8) | devfn;
-}
-
 static inline int get_ioapic_devid(int id)
 {
 	struct devid_map *entry;
-- 
1.7.9.5
