Return-Path: <SRS0=Lu7X=XA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3A1C3A5A5
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 11:43:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F66D20870
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 11:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F66D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 072DB1757;
	Thu,  5 Sep 2019 11:43:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D67381736
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 11:43:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 10FD5A9
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 11:43:47 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id 2F75BAD07;
	Thu,  5 Sep 2019 11:43:42 +0000 (UTC)
Date: Thu, 5 Sep 2019 13:43:39 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Qian Cai <cai@lca.pw>
Subject: Re: [RFC PATCH] iommu/amd: fix a race in increase_address_space()
Message-ID: <20190905114339.GC5457@suse.de>
References: <1567632262-21284-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1567632262-21284-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: don.brace@microsemi.com, iommu@lists.linux-foundation.org,
	esc.storagedev@microsemi.com, hch@lst.de, linux-kernel@vger.kernel.org
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

Hi Qian,

On Wed, Sep 04, 2019 at 05:24:22PM -0400, Qian Cai wrote:
> 	if (domain->mode == PAGE_MODE_6_LEVEL)
> 		/* address space already 64 bit large */
> 		return false;
> 
> This gives a clue that there must be a race between multiple concurrent
> threads in increase_address_space().

Thanks for tracking this down, there is a race indeed.

> +	mutex_lock(&domain->api_lock);
>  	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
>  				 size, DMA_BIDIRECTIONAL, dma_mask);
> +	mutex_unlock(&domain->api_lock);
>  
>  	if (*dma_addr == DMA_MAPPING_ERROR)
>  		goto out_free;
> @@ -2696,7 +2698,9 @@ static void free_coherent(struct device *dev, size_t size,
>  
>  	dma_dom = to_dma_ops_domain(domain);
>  
> +	mutex_lock(&domain->api_lock);
>  	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
> +	mutex_unlock(&domain->api_lock);

But I think the right fix is to lock the operation in
increase_address_space() directly, and not the calls around it, like in
the diff below. It is untested, so can you please try it and report back
if it fixes your issue?

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b607a92791d3..1ff705f16239 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1424,18 +1424,21 @@ static void free_pagetable(struct protection_domain *domain)
  * another level increases the size of the address space by 9 bits to a size up
  * to 64 bits.
  */
-static bool increase_address_space(struct protection_domain *domain,
+static void increase_address_space(struct protection_domain *domain,
 				   gfp_t gfp)
 {
+	unsigned long flags;
 	u64 *pte;
 
-	if (domain->mode == PAGE_MODE_6_LEVEL)
+	spin_lock_irqsave(&domain->lock, flags);
+
+	if (WARN_ON_ONCE(domain->mode == PAGE_MODE_6_LEVEL))
 		/* address space already 64 bit large */
-		return false;
+		goto out;
 
 	pte = (void *)get_zeroed_page(gfp);
 	if (!pte)
-		return false;
+		goto out;
 
 	*pte             = PM_LEVEL_PDE(domain->mode,
 					iommu_virt_to_phys(domain->pt_root));
@@ -1443,7 +1446,10 @@ static bool increase_address_space(struct protection_domain *domain,
 	domain->mode    += 1;
 	domain->updated  = true;
 
-	return true;
+out:
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	return;
 }
 
 static u64 *alloc_pte(struct protection_domain *domain,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
