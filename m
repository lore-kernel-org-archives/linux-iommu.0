From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 1/2] iommu/io-pgtable-arm: Convert to IOMMU API TLB sync
Date: Thu, 28 Sep 2017 15:55:01 +0100
Message-ID: <1eaf255a7a334b3b1b100da8b75b73d19c924860.1506610256.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Now that the core API issues its own post-unmap TLB sync call, push that
operation out from the io-pgtable-arm internals into the users. For now,
we leave the invalidation implicit in the unmap operation, since none of
the current users would benefit much from any change to that.

CC: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
CC: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: Wire up .flush_iotlb_all and cope with uninitialised domains

 drivers/iommu/arm-smmu-v3.c    | 10 ++++++++++
 drivers/iommu/arm-smmu.c       | 20 +++++++++++++++-----
 drivers/iommu/io-pgtable-arm.c |  7 +------
 drivers/iommu/ipmmu-vmsa.c     | 10 ++++++++++
 4 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e67ba6c40faf..ee0c7b73cff7 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1743,6 +1743,14 @@ arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 	return ops->unmap(ops, iova, size);
 }
 
+static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
+{
+	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
+
+	if (smmu)
+		__arm_smmu_tlb_sync(smmu);
+}
+
 static phys_addr_t
 arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 {
@@ -1963,6 +1971,8 @@ static struct iommu_ops arm_smmu_ops = {
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
 	.map_sg			= default_iommu_map_sg,
+	.flush_iotlb_all	= arm_smmu_iotlb_sync,
+	.iotlb_sync		= arm_smmu_iotlb_sync,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
 	.remove_device		= arm_smmu_remove_device,
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3bdb799d3b4b..e4a82d70d446 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -250,6 +250,7 @@ enum arm_smmu_domain_stage {
 struct arm_smmu_domain {
 	struct arm_smmu_device		*smmu;
 	struct io_pgtable_ops		*pgtbl_ops;
+	const struct iommu_gather_ops	*tlb_ops;
 	struct arm_smmu_cfg		cfg;
 	enum arm_smmu_domain_stage	stage;
 	struct mutex			init_mutex; /* Protects smmu pointer */
@@ -735,7 +736,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	enum io_pgtable_fmt fmt;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	const struct iommu_gather_ops *tlb_ops;
 
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
@@ -813,7 +813,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			ias = min(ias, 32UL);
 			oas = min(oas, 32UL);
 		}
-		tlb_ops = &arm_smmu_s1_tlb_ops;
+		smmu_domain->tlb_ops = &arm_smmu_s1_tlb_ops;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 		/*
@@ -833,9 +833,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 			oas = min(oas, 40UL);
 		}
 		if (smmu->version == ARM_SMMU_V2)
-			tlb_ops = &arm_smmu_s2_tlb_ops_v2;
+			smmu_domain->tlb_ops = &arm_smmu_s2_tlb_ops_v2;
 		else
-			tlb_ops = &arm_smmu_s2_tlb_ops_v1;
+			smmu_domain->tlb_ops = &arm_smmu_s2_tlb_ops_v1;
 		break;
 	default:
 		ret = -EINVAL;
@@ -863,7 +863,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
 		.ias		= ias,
 		.oas		= oas,
-		.tlb		= tlb_ops,
+		.tlb		= smmu_domain->tlb_ops,
 		.iommu_dev	= smmu->dev,
 	};
 
@@ -1259,6 +1259,14 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return ops->unmap(ops, iova, size);
 }
 
+static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (smmu_domain->tlb_ops)
+		smmu_domain->tlb_ops->tlb_sync(smmu_domain);
+}
+
 static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 					      dma_addr_t iova)
 {
@@ -1562,6 +1570,8 @@ static struct iommu_ops arm_smmu_ops = {
 	.map			= arm_smmu_map,
 	.unmap			= arm_smmu_unmap,
 	.map_sg			= default_iommu_map_sg,
+	.flush_iotlb_all	= arm_smmu_iotlb_sync,
+	.iotlb_sync		= arm_smmu_iotlb_sync,
 	.iova_to_phys		= arm_smmu_iova_to_phys,
 	.add_device		= arm_smmu_add_device,
 	.remove_device		= arm_smmu_remove_device,
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index e8018a308868..51e5c43caed1 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -609,7 +609,6 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 static int arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 			  size_t size)
 {
-	size_t unmapped;
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	arm_lpae_iopte *ptep = data->pgd;
 	int lvl = ARM_LPAE_START_LVL(data);
@@ -617,11 +616,7 @@ static int arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
 		return 0;
 
-	unmapped = __arm_lpae_unmap(data, iova, size, lvl, ptep);
-	if (unmapped)
-		io_pgtable_tlb_sync(&data->iop);
-
-	return unmapped;
+	return __arm_lpae_unmap(data, iova, size, lvl, ptep);
 }
 
 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 195d6e93ac71..af8140054273 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -619,6 +619,14 @@ static size_t ipmmu_unmap(struct iommu_domain *io_domain, unsigned long iova,
 	return domain->iop->unmap(domain->iop, iova, size);
 }
 
+static void ipmmu_iotlb_sync(struct iommu_domain *io_domain)
+{
+	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
+
+	if (domain->mmu)
+		ipmmu_tlb_flush_all(domain);
+}
+
 static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
 				      dma_addr_t iova)
 {
@@ -876,6 +884,8 @@ static const struct iommu_ops ipmmu_ops = {
 	.detach_dev = ipmmu_detach_device,
 	.map = ipmmu_map,
 	.unmap = ipmmu_unmap,
+	.flush_iotlb_all = ipmmu_iotlb_sync,
+	.iotlb_sync = ipmmu_iotlb_sync,
 	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = ipmmu_iova_to_phys,
 	.add_device = ipmmu_add_device_dma,
-- 
2.13.4.dirty
