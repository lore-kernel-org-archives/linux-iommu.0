From: Donald Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] intel_iommu,dmar: reserve mmio of IOMMU registers
Date: Fri,  9 Mar 2012 17:38:43 -0500
Message-ID: <1331332723-19522-1-git-send-email-ddutile@redhat.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: chrisw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Intel-iommu initialization doesn't currently reserve the memory used
for the IOMMU registers. This can allow the pci resource allocator
to assign a device BAR to the same address as the IOMMU registers.
This can cause some not so nice side affects when the driver
ioremap's that region.

Signed-off-by: Donald Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

v2: missed a release-mem after an iounmap() in v1, which
    caused the additional changes to add the phys_addr
    and variable register region size to be stored in the
    intel_iommu struct
---
 drivers/iommu/dmar.c        |   35 +++++++++++++++++++++++++++--------
 include/linux/intel-iommu.h |    3 ++-
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 35c1e17..0747c7f 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -581,7 +581,7 @@ int __init detect_intel_iommu(void)
 int alloc_iommu(struct dmar_drhd_unit *drhd)
 {
 	struct intel_iommu *iommu;
-	int map_size;
+	resource_size_t map_size;
 	u32 ver;
 	static int iommu_allocated = 0;
 	int agaw = 0;
@@ -599,10 +599,17 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
 	iommu->seq_id = iommu_allocated++;
 	sprintf (iommu->name, "dmar%d", iommu->seq_id);
 
-	iommu->reg = ioremap(drhd->reg_base_addr, VTD_PAGE_SIZE);
+	iommu->reg_phys = drhd->reg_base_addr;
+	iommu->reg_size = VTD_PAGE_SIZE;
+	if (!request_mem_region(iommu->reg_phys, iommu->reg_size, iommu->name)) {
+		printk(KERN_ERR "IOMMU: can't reserve memory\n");
+		goto error;
+	}
+
+	iommu->reg = ioremap(iommu->reg_phys, iommu->reg_size);
 	if (!iommu->reg) {
 		printk(KERN_ERR "IOMMU: can't map the region\n");
-		goto error;
+		goto err_release;
 	}
 	iommu->cap = dmar_readq(iommu->reg + DMAR_CAP_REG);
 	iommu->ecap = dmar_readq(iommu->reg + DMAR_ECAP_REG);
@@ -635,19 +642,26 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
 	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
 		cap_max_fault_reg_offset(iommu->cap));
 	map_size = VTD_PAGE_ALIGN(map_size);
-	if (map_size > VTD_PAGE_SIZE) {
+	if (map_size > iommu->reg_size) {
 		iounmap(iommu->reg);
-		iommu->reg = ioremap(drhd->reg_base_addr, map_size);
+		release_mem_region(iommu->reg_phys, iommu->reg_size);
+		iommu->reg_size = map_size;
+		if (!request_mem_region(iommu->reg_phys, iommu->reg_size, 
+					iommu->name)) {
+			printk(KERN_ERR "IOMMU: can't reserve memory\n");
+			goto error;
+		}
+		iommu->reg = ioremap(iommu->reg_phys, iommu->reg_size);
 		if (!iommu->reg) {
 			printk(KERN_ERR "IOMMU: can't map the region\n");
-			goto error;
+			goto err_release;
 		}
 	}
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
 	pr_info("IOMMU %d: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
 		iommu->seq_id,
-		(unsigned long long)drhd->reg_base_addr,
+		(unsigned long long)iommu->reg_phys,
 		DMAR_VER_MAJOR(ver), DMAR_VER_MINOR(ver),
 		(unsigned long long)iommu->cap,
 		(unsigned long long)iommu->ecap);
@@ -659,6 +673,8 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
 
  err_unmap:
 	iounmap(iommu->reg);
+ err_release:
+	release_mem_region(iommu->reg_phys, iommu->reg_size);
  error:
 	kfree(iommu);
 	return -1;
@@ -671,8 +687,11 @@ void free_iommu(struct intel_iommu *iommu)
 
 	free_dmar_iommu(iommu);
 
-	if (iommu->reg)
+	if (iommu->reg) {
 		iounmap(iommu->reg);
+		release_mem_region(iommu->reg_phys, iommu->reg_size);
+	}
+
 	kfree(iommu);
 }
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index e6ca56d..c6d132b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -308,6 +308,8 @@ enum {
 
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
+	resource_size_t reg_phys;
+	resource_size_t reg_size;
 	u64		cap;
 	u64		ecap;
 	u32		gcmd; /* Holds TE, EAFL. Don't need SRTP, SFL, WBF */
@@ -360,7 +362,6 @@ extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
 			       u64 addr, unsigned mask);
 
 extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
-
 extern int dmar_ir_support(void);
 
 #endif
-- 
1.7.1
