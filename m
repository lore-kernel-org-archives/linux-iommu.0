Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D96C432C2
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 06:18:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D972146E
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 06:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1BGpvWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D972146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 602ACB09;
	Thu, 26 Sep 2019 06:18:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 111D2408
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 06:18:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
	[205.139.110.61])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4D59F8A0
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 06:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1569478689;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=z6IgwqGl9UvJ4xVglEB6grHSGrzx+z6kvbQXSxgHkAM=;
	b=K1BGpvWByerfte6pK6Jd3ng4bGX5pctHXsWysXa85QuTJn+ZM/GAgnMvCGFwcWYvzXFIYZ
	hYnwP8pxDkuS7EV0m9YwBa9nkCdYyDlcYILEgm9C7RHst+i0g3xe86vMr6KpBGt2wCW65P
	FoZeW8SIARVIEHSbxTWsX01ezo1iCsM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
	[209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-196-VIgYXletP-eUl5dAALsdqg-1; Thu, 26 Sep 2019 02:18:08 -0400
Received: by mail-io1-f72.google.com with SMTP id q18so2703054ios.8
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 23:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=G0pA5gf1SqiUP4jckDLg7x2aKqYiCt1lYdw1Je/sA9c=;
	b=enQEsQbiUn3uCrKOlBVH7nWzg64KS16DPQF5+QNvLILknkOOX2L17wAPXpFTVkRjEe
	L4hJxWBj8XN8iJVazd1DTntRtGAXUK46wRgramLah97dtO/PsuMcWUnzH1rOd/b8cdDc
	/M0jwlfX/UEM+o1eyh/DfhfHF+N5GdDVXF3FJRi95Ezyu0x5us3RpycWEPTXBbgBsiLq
	BtYyU25hN+D6zHVP7pcykX8J3SP7nhXg1kGSu/mAzsroJsHEt50lAm8U7bbXnq5aTxwJ
	WEHxzKeaYiklRYA24HrLjQLwLB2c9def9NMNDPjYSqjZ+v2huIOzgQYWn8J9LuGKs5Ga
	5pmA==
X-Gm-Message-State: APjAAAUXR1EAE1ztjodYtJHDjXijuvDuO0ackLAAp5TjElL/Azi+t5I6
	oBX6IkPyKGRp13WGfEqvpt3Au/N3WZg0AiphV1JacX4GyjVKR0IAbH2E6nB0VTrMEWSW6p4gkZf
	arllTPKUwPFfb0LiUhVISqzBIuvsnIg==
X-Received: by 2002:a02:712b:: with SMTP id n43mr2197240jac.2.1569478687468;
	Wed, 25 Sep 2019 23:18:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzZ17RyHwHqn6A9i6D2R0wAVBun8TZL9D4RmlJ+LkqhJy9ZBnLLJUW04jxYpM5w7C8muzdLFA==
X-Received: by 2002:a02:712b:: with SMTP id n43mr2197213jac.2.1569478687085;
	Wed, 25 Sep 2019 23:18:07 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id p16sm291634iln.35.2019.09.25.23.18.05
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 25 Sep 2019 23:18:06 -0700 (PDT)
Date: Wed, 25 Sep 2019 23:18:04 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/6] iommu/amd: Remove domain->updated
Message-ID: <20190926061804.jaletrg437j4j2yh@cantor>
References: <20190925132300.3038-1-joro@8bytes.org>
	<20190925132300.3038-2-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20190925132300.3038-2-joro@8bytes.org>
User-Agent: NeoMutt/20180716
X-MC-Unique: VIgYXletP-eUl5dAALsdqg-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: Filippo Sironi <sironi@amazon.de>, iommu@lists.linux-foundation.org,
	jroedel@suse.de
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed Sep 25 19, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>This struct member was used to track whether a domain
>change requires updates to the device-table and IOMMU cache
>flushes. The problem is, that access to this field is racy
>since locking in the common mapping code-paths has been
>eliminated.
>
>Move the updated field to the stack to get rid of all
>potential races and remove the field from the struct.
>
>Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
>Signed-off-by: Joerg Roedel <jroedel@suse.de>
>---
> drivers/iommu/amd_iommu.c       | 49 +++++++++++++++++----------------
> drivers/iommu/amd_iommu_types.h |  1 -
> 2 files changed, 25 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 7bdce3b10f3d..042854bbc5bc 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -1458,10 +1458,11 @@ static void free_pagetable(struct protection_domain *domain)
>  * another level increases the size of the address space by 9 bits to a size up
>  * to 64 bits.
>  */
>-static void increase_address_space(struct protection_domain *domain,
>+static bool increase_address_space(struct protection_domain *domain,
> 				   gfp_t gfp)
> {
> 	unsigned long flags;
>+	bool ret = false;
> 	u64 *pte;
>
> 	spin_lock_irqsave(&domain->lock, flags);
>@@ -1478,19 +1479,21 @@ static void increase_address_space(struct protection_domain *domain,
> 					iommu_virt_to_phys(domain->pt_root));
> 	domain->pt_root  = pte;
> 	domain->mode    += 1;
>-	domain->updated  = true;
>+
>+	ret = true;
>
> out:
> 	spin_unlock_irqrestore(&domain->lock, flags);
>
>-	return;
>+	return ret;
> }
>
> static u64 *alloc_pte(struct protection_domain *domain,
> 		      unsigned long address,
> 		      unsigned long page_size,
> 		      u64 **pte_page,
>-		      gfp_t gfp)
>+		      gfp_t gfp,
>+		      bool *updated)
> {
> 	int level, end_lvl;
> 	u64 *pte, *page;
>@@ -1498,7 +1501,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
> 	BUG_ON(!is_power_of_2(page_size));
>
> 	while (address > PM_LEVEL_SIZE(domain->mode))
>-		increase_address_space(domain, gfp);
>+		*updated = increase_address_space(domain, gfp) || *updated;
>
> 	level   = domain->mode - 1;
> 	pte     = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
>@@ -1530,7 +1533,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
> 			for (i = 0; i < count; ++i)
> 				cmpxchg64(&lpte[i], __pte, 0ULL);
>
>-			domain->updated = true;
>+			*updated = true;
> 			continue;
> 		}
>
>@@ -1547,7 +1550,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
> 			if (cmpxchg64(pte, __pte, __npte) != __pte)
> 				free_page((unsigned long)page);
> 			else if (IOMMU_PTE_PRESENT(__pte))
>-				domain->updated = true;
>+				*updated = true;
>
> 			continue;
> 		}
>@@ -1656,28 +1659,29 @@ static int iommu_map_page(struct protection_domain *dom,
> 			  gfp_t gfp)
> {
> 	struct page *freelist = NULL;
>+	bool updated = false;
> 	u64 __pte, *pte;
>-	int i, count;
>+	int ret, i, count;
>
> 	BUG_ON(!IS_ALIGNED(bus_addr, page_size));
> 	BUG_ON(!IS_ALIGNED(phys_addr, page_size));
>
>+	ret = -EINVAL;
> 	if (!(prot & IOMMU_PROT_MASK))
>-		return -EINVAL;
>+		goto out;
>
> 	count = PAGE_SIZE_PTE_COUNT(page_size);
>-	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp);
>+	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp, &updated);
>
>-	if (!pte) {
>-		update_domain(dom);
>-		return -ENOMEM;
>-	}
>+	ret = -ENOMEM;
>+	if (!pte)
>+		goto out;
>
> 	for (i = 0; i < count; ++i)
> 		freelist = free_clear_pte(&pte[i], pte[i], freelist);
>
> 	if (freelist != NULL)
>-		dom->updated = true;
>+		updated = true;
>
> 	if (count > 1) {
> 		__pte = PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
>@@ -1693,12 +1697,16 @@ static int iommu_map_page(struct protection_domain *dom,
> 	for (i = 0; i < count; ++i)
> 		pte[i] = __pte;
>
>-	update_domain(dom);
>+	ret = 0;
>+
>+out:
>+	if (updated)
>+		update_domain(dom);
>
> 	/* Everything flushed out, free pages now */
> 	free_page_list(freelist);
>
>-	return 0;
>+	return ret;
> }
>
> static unsigned long iommu_unmap_page(struct protection_domain *dom,
>@@ -2399,15 +2407,10 @@ static void update_device_table(struct protection_domain *domain)
>
> static void update_domain(struct protection_domain *domain)
> {
>-	if (!domain->updated)
>-		return;
>-
> 	update_device_table(domain);
>
> 	domain_flush_devices(domain);
> 	domain_flush_tlb_pde(domain);
>-
>-	domain->updated = false;
> }
>
> static int dir2prot(enum dma_data_direction direction)
>@@ -3333,7 +3336,6 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
>
> 	/* Update data structure */
> 	domain->mode    = PAGE_MODE_NONE;
>-	domain->updated = true;
>
> 	/* Make changes visible to IOMMUs */
> 	update_domain(domain);
>@@ -3379,7 +3381,6 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
>
> 	domain->glx      = levels;
> 	domain->flags   |= PD_IOMMUV2_MASK;
>-	domain->updated  = true;
>
> 	update_domain(domain);
>
>diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
>index 9ac229e92b07..0186501ab971 100644
>--- a/drivers/iommu/amd_iommu_types.h
>+++ b/drivers/iommu/amd_iommu_types.h
>@@ -475,7 +475,6 @@ struct protection_domain {
> 	int glx;		/* Number of levels for GCR3 table */
> 	u64 *gcr3_tbl;		/* Guest CR3 table */
> 	unsigned long flags;	/* flags to find out type of domain */
>-	bool updated;		/* complete domain flush required */
> 	unsigned dev_cnt;	/* devices assigned to this domain */
> 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
> };
>-- 
>2.17.1
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
