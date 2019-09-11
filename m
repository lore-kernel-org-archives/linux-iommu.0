Return-Path: <SRS0=UwG5=XG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2A4C5ACAE
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 11:34:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102FE2089F
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 11:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102FE2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BC3921361;
	Wed, 11 Sep 2019 11:34:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3A0E5135F
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 11:34:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4CDEC894
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 11:34:20 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 455B7386; Wed, 11 Sep 2019 13:34:18 +0200 (CEST)
Date: Wed, 11 Sep 2019 13:34:16 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Filippo Sironi <sironi@amazon.de>
Subject: Re: iommu/amd: Flushing and locking fixes
Message-ID: <20190911113415.GA25943@8bytes.org>
References: <1568137765-20278-1-git-send-email-sironi@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568137765-20278-1-git-send-email-sironi@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Filippo,

On Tue, Sep 10, 2019 at 07:49:20PM +0200, Filippo Sironi wrote:
> This patch series introduce patches to take the domain lock whenever we call
> functions that end up calling __domain_flush_pages.  Holding the domain lock is
> necessary since __domain_flush_pages traverses the device list, which is
> protected by the domain lock.
> 
> The first patch in the series adds a completion right after an IOTLB flush in
> attach_device.

Thanks for pointing out these locking issues and your fixes. I have been
looking into it a bit and it seems there is more problems to take care
of.

The first problem is the racy access to domain->updated, which is best
fixed by moving that info onto the stack don't keep it in the domain
structure.

Other than that, I think your patches are kind of the big hammer
approach to fix it. As they are, they destroy the scalability of the
dma-api path. So we need something more fine-grained, also if we keep in
mind that the actual cases where we need to flush something in the
dma-api path are very rare. The default should be to not take any lock
in that path.

How does the attached patch look to you? It is completly untested but
should give an idea of a better way to fix these locking issues.

Regards,

	Joerg

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 61de81965c44..bb93a2bbb73d 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1435,9 +1435,10 @@ static void free_pagetable(struct protection_domain *domain)
  * another level increases the size of the address space by 9 bits to a size up
  * to 64 bits.
  */
-static void increase_address_space(struct protection_domain *domain,
+static bool increase_address_space(struct protection_domain *domain,
 				   gfp_t gfp)
 {
+	bool updated = false;
 	unsigned long flags;
 	u64 *pte;
 
@@ -1455,27 +1456,30 @@ static void increase_address_space(struct protection_domain *domain,
 					iommu_virt_to_phys(domain->pt_root));
 	domain->pt_root  = pte;
 	domain->mode    += 1;
-	domain->updated  = true;
+	updated		 = true;
 
 out:
 	spin_unlock_irqrestore(&domain->lock, flags);
 
-	return;
+	return updated;
 }
 
 static u64 *alloc_pte(struct protection_domain *domain,
 		      unsigned long address,
 		      unsigned long page_size,
 		      u64 **pte_page,
-		      gfp_t gfp)
+		      gfp_t gfp,
+		      bool *updated)
 {
 	int level, end_lvl;
 	u64 *pte, *page;
 
 	BUG_ON(!is_power_of_2(page_size));
 
+	*updated = false;
+
 	while (address > PM_LEVEL_SIZE(domain->mode))
-		increase_address_space(domain, gfp);
+		*updated = increase_address_space(domain, gfp) || *updated;
 
 	level   = domain->mode - 1;
 	pte     = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
@@ -1501,7 +1505,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
 			if (cmpxchg64(pte, __pte, __npte) != __pte)
 				free_page((unsigned long)page);
 			else if (pte_level == PAGE_MODE_7_LEVEL)
-				domain->updated = true;
+				*updated = true;
 
 			continue;
 		}
@@ -1617,6 +1621,7 @@ static int iommu_map_page(struct protection_domain *dom,
 	struct page *freelist = NULL;
 	u64 __pte, *pte;
 	int i, count;
+	bool updated;
 
 	BUG_ON(!IS_ALIGNED(bus_addr, page_size));
 	BUG_ON(!IS_ALIGNED(phys_addr, page_size));
@@ -1625,7 +1630,7 @@ static int iommu_map_page(struct protection_domain *dom,
 		return -EINVAL;
 
 	count = PAGE_SIZE_PTE_COUNT(page_size);
-	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp);
+	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp, &updated);
 
 	if (!pte)
 		return -ENOMEM;
@@ -1634,7 +1639,7 @@ static int iommu_map_page(struct protection_domain *dom,
 		freelist = free_clear_pte(&pte[i], pte[i], freelist);
 
 	if (freelist != NULL)
-		dom->updated = true;
+		updated = true;
 
 	if (count > 1) {
 		__pte = PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
@@ -1650,7 +1655,8 @@ static int iommu_map_page(struct protection_domain *dom,
 	for (i = 0; i < count; ++i)
 		pte[i] = __pte;
 
-	update_domain(dom);
+	if (updated)
+		update_domain(dom);
 
 	/* Everything flushed out, free pages now */
 	free_page_list(freelist);
@@ -2041,6 +2047,13 @@ static int __attach_device(struct iommu_dev_data *dev_data,
 	/* Attach alias group root */
 	do_attach(dev_data, domain);
 
+	/*
+	 * We might boot into a crash-kernel here. The crashed kernel
+	 * left the caches in the IOMMU dirty. So we have to flush
+	 * here to evict all dirty stuff.
+	 */
+	domain_flush_tlb_pde(domain);
+
 	ret = 0;
 
 out_unlock:
@@ -2162,13 +2175,6 @@ static int attach_device(struct device *dev,
 	ret = __attach_device(dev_data, domain);
 	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
 
-	/*
-	 * We might boot into a crash-kernel here. The crashed kernel
-	 * left the caches in the IOMMU dirty. So we have to flush
-	 * here to evict all dirty stuff.
-	 */
-	domain_flush_tlb_pde(domain);
-
 	return ret;
 }
 
@@ -2352,17 +2358,21 @@ static void update_device_table(struct protection_domain *domain)
 	}
 }
 
-static void update_domain(struct protection_domain *domain)
+static void __update_domain(struct protection_domain *domain)
 {
-	if (!domain->updated)
-		return;
-
 	update_device_table(domain);
 
 	domain_flush_devices(domain);
 	domain_flush_tlb_pde(domain);
+}
 
-	domain->updated = false;
+static void update_domain(struct protection_domain *domain)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	__update_domain(domain);
+	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
 static int dir2prot(enum dma_data_direction direction)
@@ -3221,9 +3231,12 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
 
+	spin_lock_irqsave(&dom->lock, flags);
 	domain_flush_tlb_pde(dom);
 	domain_flush_complete(dom);
+	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
 static void amd_iommu_iotlb_range_add(struct iommu_domain *domain,
@@ -3285,10 +3298,9 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 
 	/* Update data structure */
 	domain->mode    = PAGE_MODE_NONE;
-	domain->updated = true;
 
 	/* Make changes visible to IOMMUs */
-	update_domain(domain);
+	__update_domain(domain);
 
 	/* Page-table is not visible to IOMMU anymore, so free it */
 	free_pagetable(domain);
@@ -3331,9 +3343,8 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 
 	domain->glx      = levels;
 	domain->flags   |= PD_IOMMUV2_MASK;
-	domain->updated  = true;
 
-	update_domain(domain);
+	__update_domain(domain);
 
 	ret = 0;
 
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 64edd5a9694c..143e1bf70c40 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -475,7 +475,6 @@ struct protection_domain {
 	int glx;		/* Number of levels for GCR3 table */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
-	bool updated;		/* complete domain flush required */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 };
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
