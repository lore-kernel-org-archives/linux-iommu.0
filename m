From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: fixes for 3.14
Date: Tue, 18 Feb 2014 19:21:37 +0000
Message-ID: <20140218192137.GJ2010@mudshark.cambridge.arm.com>
References: <20140210183232.GH12826@mudshark.cambridge.arm.com>
	<20140218175027.GE11432@8bytes.org>
	<20140218183626.GC2010@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140218183626.GC2010-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 18, 2014 at 06:36:26PM +0000, Will Deacon wrote:
> On Tue, Feb 18, 2014 at 05:50:27PM +0000, Joerg Roedel wrote:
> > I just did quick review of the changes. Was the SATA controller using
> > the IOMMU through the DMA-API? In this case you would need the IRQ-safe
> > spinlocks to avoid dead-locks because the DMA-API can be used from
> > IRQ-context.
> 
> Unfortunately, I don't know and since Calxeda has ceased to be, Andreas is
> no longer working on this (I suspect his email address also bounces).
> 
> I can send an additional patch using spin_*_irq{save,restore} for the
> domain->lock if you like?

FWIW, here's a diff you could apply as a fixup (or I can send a new pull
request if you prefer). It's slightly messy because I had to rename a
parameter in the page table functions (s/flag/prot/).

What do you reckon?

Will

--->8

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 489cbe4c26aa..76ad84637a0f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1253,7 +1253,7 @@ static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
 
 static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 				   unsigned long addr, unsigned long end,
-				   unsigned long pfn, int flags, int stage)
+				   unsigned long pfn, int prot, int stage)
 {
 	pte_t *pte, *start;
 	pteval_t pteval = ARM_SMMU_PTE_PAGE | ARM_SMMU_PTE_AF | ARM_SMMU_PTE_XN;
@@ -1275,28 +1275,28 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 
 	if (stage == 1) {
 		pteval |= ARM_SMMU_PTE_AP_UNPRIV | ARM_SMMU_PTE_nG;
-		if (!(flags & IOMMU_WRITE) && (flags & IOMMU_READ))
+		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
 			pteval |= ARM_SMMU_PTE_AP_RDONLY;
 
-		if (flags & IOMMU_CACHE)
+		if (prot & IOMMU_CACHE)
 			pteval |= (MAIR_ATTR_IDX_CACHE <<
 				   ARM_SMMU_PTE_ATTRINDX_SHIFT);
 	} else {
 		pteval |= ARM_SMMU_PTE_HAP_FAULT;
-		if (flags & IOMMU_READ)
+		if (prot & IOMMU_READ)
 			pteval |= ARM_SMMU_PTE_HAP_READ;
-		if (flags & IOMMU_WRITE)
+		if (prot & IOMMU_WRITE)
 			pteval |= ARM_SMMU_PTE_HAP_WRITE;
-		if (flags & IOMMU_CACHE)
+		if (prot & IOMMU_CACHE)
 			pteval |= ARM_SMMU_PTE_MEMATTR_OIWB;
 		else
 			pteval |= ARM_SMMU_PTE_MEMATTR_NC;
 	}
 
 	/* If no access, create a faulting entry to avoid TLB fills */
-	if (flags & IOMMU_EXEC)
+	if (prot & IOMMU_EXEC)
 		pteval &= ~ARM_SMMU_PTE_XN;
-	else if (!(flags & (IOMMU_READ | IOMMU_WRITE)))
+	else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
 		pteval &= ~ARM_SMMU_PTE_PAGE;
 
 	pteval |= ARM_SMMU_PTE_SH_IS;
@@ -1358,7 +1358,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
 
 static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 				   unsigned long addr, unsigned long end,
-				   phys_addr_t phys, int flags, int stage)
+				   phys_addr_t phys, int prot, int stage)
 {
 	int ret;
 	pmd_t *pmd;
@@ -1382,7 +1382,7 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 	do {
 		next = pmd_addr_end(addr, end);
 		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, end, pfn,
-					      flags, stage);
+					      prot, stage);
 		phys += next - addr;
 	} while (pmd++, addr = next, addr < end);
 
@@ -1391,7 +1391,7 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 
 static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 				   unsigned long addr, unsigned long end,
-				   phys_addr_t phys, int flags, int stage)
+				   phys_addr_t phys, int prot, int stage)
 {
 	int ret = 0;
 	pud_t *pud;
@@ -1415,7 +1415,7 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 	do {
 		next = pud_addr_end(addr, end);
 		ret = arm_smmu_alloc_init_pmd(smmu, pud, addr, next, phys,
-					      flags, stage);
+					      prot, stage);
 		phys += next - addr;
 	} while (pud++, addr = next, addr < end);
 
@@ -1424,10 +1424,10 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 
 static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 				   unsigned long iova, phys_addr_t paddr,
-				   size_t size, int flags)
+				   size_t size, int prot)
 {
 	int ret, stage;
-	unsigned long end;
+	unsigned long end, flags;
 	phys_addr_t input_mask, output_mask;
 	struct arm_smmu_cfg *root_cfg = &smmu_domain->root_cfg;
 	pgd_t *pgd = root_cfg->pgd;
@@ -1454,14 +1454,14 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	if (paddr & ~output_mask)
 		return -ERANGE;
 
-	spin_lock(&smmu_domain->lock);
+	spin_lock_irqsave(&smmu_domain->lock, flags);
 	pgd += pgd_index(iova);
 	end = iova + size;
 	do {
 		unsigned long next = pgd_addr_end(iova, end);
 
 		ret = arm_smmu_alloc_init_pud(smmu, pgd, iova, next, paddr,
-					      flags, stage);
+					      prot, stage);
 		if (ret)
 			goto out_unlock;
 
@@ -1470,7 +1470,7 @@ static int arm_smmu_handle_mapping(struct arm_smmu_domain *smmu_domain,
 	} while (pgd++, iova != end);
 
 out_unlock:
-	spin_unlock(&smmu_domain->lock);
+	spin_unlock_irqrestore(&smmu_domain->lock, flags);
 
 	return ret;
 }
