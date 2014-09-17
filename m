From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 04/13 v2] iommu/arm-smmu: Convert to iommu_capable() API
	function function
Date: Wed, 17 Sep 2014 10:53:12 +0200
Message-ID: <20140917085312.GE2533@suse.de>
References: <1409914384-21191-1-git-send-email-joro@8bytes.org>
	<1409914384-21191-5-git-send-email-joro@8bytes.org>
	<20140908165136.GW26030@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140908165136.GW26030-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Mon, Sep 08, 2014 at 05:51:36PM +0100, Will Deacon wrote:
> Hi Joerg,
> 
> [adding devicetree for the last paragraph]
> 
> On Fri, Sep 05, 2014 at 11:52:56AM +0100, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > 
> > Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c | 35 ++++++++++++++++++++++++++---------
> >  1 file changed, 26 insertions(+), 9 deletions(-)

Okay, so here is the updated patch:

>From b5d895980849ba1a46a5250cd4cc5f3f9f28235d Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Fri, 5 Sep 2014 10:49:34 +0200
Subject: [PATCH 04/13] iommu/arm-smmu: Convert to iommu_capable() API function

Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a83cc2a..f5cacf4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1526,20 +1526,20 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	return __pfn_to_phys(pte_pfn(pte)) | (iova & ~PAGE_MASK);
 }
 
-static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
-				   unsigned long cap)
+static bool arm_smmu_capable(enum iommu_cap cap)
 {
-	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	u32 features = smmu ? smmu->features : 0;
-
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
-		return features & ARM_SMMU_FEAT_COHERENT_WALK;
+		/*
+		 * Return false here until we have a way to find out whether the
+		 * SMMUs in the system a coherently connected and able to force
+		 * DMA coherency.
+		 */
+		return false;
 	case IOMMU_CAP_INTR_REMAP:
-		return 1; /* MSIs are just memory writes */
+		return true; /* MSIs are just memory writes */
 	default:
-		return 0;
+		return false;
 	}
 }
 
@@ -1609,6 +1609,7 @@ static void arm_smmu_remove_device(struct device *dev)
 }
 
 static const struct iommu_ops arm_smmu_ops = {
+	.capable	= arm_smmu_capable,
 	.domain_init	= arm_smmu_domain_init,
 	.domain_destroy	= arm_smmu_domain_destroy,
 	.attach_dev	= arm_smmu_attach_dev,
@@ -1616,7 +1617,6 @@ static const struct iommu_ops arm_smmu_ops = {
 	.map		= arm_smmu_map,
 	.unmap		= arm_smmu_unmap,
 	.iova_to_phys	= arm_smmu_iova_to_phys,
-	.domain_has_cap	= arm_smmu_domain_has_cap,
 	.add_device	= arm_smmu_add_device,
 	.remove_device	= arm_smmu_remove_device,
 	.pgsize_bitmap	= (SECTION_SIZE |
-- 
1.8.4.5
