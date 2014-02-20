From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: fixes for 3.14
Date: Thu, 20 Feb 2014 12:29:19 +0100
Message-ID: <20140220112919.GG11432@8bytes.org>
References: <20140210183232.GH12826@mudshark.cambridge.arm.com>
	<20140218175027.GE11432@8bytes.org>
	<20140218183626.GC2010@mudshark.cambridge.arm.com>
	<20140218192137.GJ2010@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140218192137.GJ2010-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 18, 2014 at 07:21:37PM +0000, Will Deacon wrote:
> FWIW, here's a diff you could apply as a fixup (or I can send a new pull
> request if you prefer). It's slightly messy because I had to rename a
> parameter in the page table functions (s/flag/prot/).
> 
> What do you reckon?

Hmm, am I mistaken or do you only convert the mapping path? There is
another use of the smmu_domain->lock that has to be converted. See my
fix attached. Can the arm_smmu_devices_lock also be used in a DMA-API
path?
I also think that the parameter renaming should not be done in a fixup
patch, if you want it to be converted please include a renaming patch in
your updates for the next merge window.


	Joerg


>From e848d16b3129cc7234089d6917a0568b1b5f4acc Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Date: Thu, 20 Feb 2014 12:19:08 +0100
Subject: [PATCH] arm/smmu: Use irqsafe spinlock for domain lock

As the lock might be used through DMA-API which is allowed
in interrupt context.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6fe7922..1d9ab39 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1159,6 +1159,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_device *device_smmu = dev->archdata.iommu;
 	struct arm_smmu_master *master;
+	unsigned long flags;
 
 	if (!device_smmu) {
 		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
@@ -1169,7 +1170,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	 * Sanity check the domain. We don't currently support domains
 	 * that cross between different SMMU chains.
 	 */
-	spin_lock(&smmu_domain->lock);
+	spin_lock_irqsave(&smmu_domain->lock, flags);
 	if (!smmu_domain->leaf_smmu) {
 		/* Now that we have a master, we can finalise the domain */
 		ret = arm_smmu_init_domain_context(domain, dev);
@@ -1184,7 +1185,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			dev_name(device_smmu->dev));
 		goto err_unlock;
 	}
-	spin_unlock(&smmu_domain->lock);
+	spin_unlock_irqrestore(&smmu_domain->lock, flags);
 
 	/* Looks ok, so add the device to the domain */
 	master = find_smmu_master(smmu_domain->leaf_smmu, dev->of_node);
@@ -1194,7 +1195,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return arm_smmu_domain_add_master(smmu_domain, master);
 
 err_unlock:
-	spin_unlock(&smmu_domain->lock);
+	spin_unlock_irqrestore(&smmu_domain->lock, flags);
 	return ret;
 }
 
@@ -1396,6 +1397,7 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
 	pgd_t *pgd = root_cfg->pgd;
 	struct arm_smmu_device *smmu = root_cfg->smmu;
+	unsigned long irqflags;
 
 	if (root_cfg->cbar == CBAR_TYPE_S2_TRANS) {
 		stage = 2;
@@ -1418,7 +1420,7 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	if (paddr & ~output_mask)
 		return -ERANGE;
 
-	spin_lock(&smmu_domain->lock);
+	spin_lock_irqsave(&smmu_domain->lock, irqflags);
 	pgd += pgd_index(iova);
 	end = iova + size;
 	do {
@@ -1434,7 +1436,7 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	} while (pgd++, iova != end);
 
 out_unlock:
-	spin_unlock(&smmu_domain->lock);
+	spin_unlock_irqrestore(&smmu_domain->lock, irqflags);
 
 	return ret;
 }
-- 
1.7.9.5
