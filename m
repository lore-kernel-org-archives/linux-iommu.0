Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC71EC432C2
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 15:58:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E5B021D7A
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 15:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="RlFo9744"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5B021D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 43864CDE;
	Wed, 25 Sep 2019 15:58:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F3F46C5C
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 15:58:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CB561B0
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 15:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1569427086; x=1600963086;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:mime-version: content-transfer-encoding;
	bh=Ah5I9SMrgQY3/7fl5DWAp+JAIVjb0vGyVX6vQnkmi7s=;
	b=RlFo9744GVA6DmBRu7cZTl4c7zKqoA33SsNF1sLjPxymrd3WzbIJWwhv
	yROy+/iiQ6ffXLVcKuvMgMjhpfJB4eWOolNNmprtPX7kDfhn50yOyw+Ji
	YAKsasRZaB1DNLbzzqFR0VzW5AQmLlPzgkNP50S5X/y47Z4vmwFuRB0VD c=;
X-IronPort-AV: E=Sophos;i="5.64,548,1559520000"; d="scan'208";a="417600309"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
	email-inbound-relay-2a-8549039f.us-west-2.amazon.com)
	([10.124.125.6])
	by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP;
	25 Sep 2019 15:58:05 +0000
Received: from EX13MTAUEA001.ant.amazon.com
	(pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
	by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (Postfix) with
	ESMTPS id 32D51A1D78; Wed, 25 Sep 2019 15:58:05 +0000 (UTC)
Received: from EX13D02EUC002.ant.amazon.com (10.43.164.14) by
	EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server
	(TLS) id 15.0.1367.3; Wed, 25 Sep 2019 15:58:04 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
	EX13D02EUC002.ant.amazon.com (10.43.164.14) with Microsoft SMTP Server
	(TLS) id 15.0.1367.3; Wed, 25 Sep 2019 15:58:03 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
	EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id
	15.00.1367.000; Wed, 25 Sep 2019 15:58:03 +0000
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 6/6] iommu/amd: Lock code paths traversing
	protection_domain->dev_list
Thread-Topic: [PATCH 6/6] iommu/amd: Lock code paths traversing
	protection_domain->dev_list
Thread-Index: AQHVc6RwFs/7Mw0asUextINlodLu5ac8jL2A
Date: Wed, 25 Sep 2019 15:58:03 +0000
Message-ID: <E176CEB2-E9E0-4CFA-9F43-E3E0488598E8@amazon.de>
References: <20190925132300.3038-1-joro@8bytes.org>
	<20190925132300.3038-7-joro@8bytes.org>
In-Reply-To: <20190925132300.3038-7-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.196]
Content-ID: <79AF31B24E544A48AE65E7A29723320B@amazon.com>
MIME-Version: 1.0
Precedence: Bulk
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"jroedel@suse.de" <jroedel@suse.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: "Sironi, Filippo via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Sironi, Filippo" <sironi@amazon.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org



> On 25. Sep 2019, at 06:23, Joerg Roedel <joro@8bytes.org> wrote:
> 
> From: Joerg Roedel <jroedel@suse.de>
> 
> The traversing of this list requires protection_domain->lock to be taken
> to avoid nasty races with attach/detach code. Make sure the lock is held
> on all code-paths traversing this list.
> 
> Reported-by: Filippo Sironi <sironi@amazon.de>
> Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> drivers/iommu/amd_iommu.c | 25 ++++++++++++++++++++++++-
> 1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index bac4e20a5919..9c26976a0f99 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1334,8 +1334,12 @@ static void domain_flush_np_cache(struct protection_domain *domain,
> 		dma_addr_t iova, size_t size)
> {
> 	if (unlikely(amd_iommu_np_cache)) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&domain->lock, flags);
> 		domain_flush_pages(domain, iova, size);
> 		domain_flush_complete(domain);
> +		spin_unlock_irqrestore(&domain->lock, flags);
> 	}
> }
> 
> @@ -1700,8 +1704,13 @@ static int iommu_map_page(struct protection_domain *dom,
> 	ret = 0;
> 
> out:
> -	if (updated)
> +	if (updated) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&dom->lock, flags);
> 		update_domain(dom);
> +		spin_unlock_irqrestore(&dom->lock, flags);
> +	}
> 
> 	/* Everything flushed out, free pages now */
> 	free_page_list(freelist);
> @@ -1857,8 +1866,12 @@ static void free_gcr3_table(struct protection_domain *domain)
> 
> static void dma_ops_domain_flush_tlb(struct dma_ops_domain *dom)
> {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dom->domain.lock, flags);
> 	domain_flush_tlb(&dom->domain);
> 	domain_flush_complete(&dom->domain);
> +	spin_unlock_irqrestore(&dom->domain.lock, flags);
> }
> 
> static void iova_domain_flush_tlb(struct iova_domain *iovad)
> @@ -2414,6 +2427,7 @@ static dma_addr_t __map_single(struct device *dev,
> {
> 	dma_addr_t offset = paddr & ~PAGE_MASK;
> 	dma_addr_t address, start, ret;
> +	unsigned long flags;
> 	unsigned int pages;
> 	int prot = 0;
> 	int i;
> @@ -2451,8 +2465,10 @@ static dma_addr_t __map_single(struct device *dev,
> 		iommu_unmap_page(&dma_dom->domain, start, PAGE_SIZE);
> 	}
> 
> +	spin_lock_irqsave(&dma_dom->domain.lock, flags);
> 	domain_flush_tlb(&dma_dom->domain);
> 	domain_flush_complete(&dma_dom->domain);
> +	spin_unlock_irqrestore(&dma_dom->domain.lock, flags);
> 
> 	dma_ops_free_iova(dma_dom, address, pages);
> 
> @@ -2481,8 +2497,12 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
> 	}
> 
> 	if (amd_iommu_unmap_flush) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&dma_dom->domain.lock, flags);
> 		domain_flush_tlb(&dma_dom->domain);
> 		domain_flush_complete(&dma_dom->domain);
> +		spin_unlock_irqrestore(&dma_dom->domain.lock, flags);
> 		dma_ops_free_iova(dma_dom, dma_addr, pages);
> 	} else {
> 		pages = __roundup_pow_of_two(pages);
> @@ -3246,9 +3266,12 @@ static bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
> static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
> {
> 	struct protection_domain *dom = to_pdomain(domain);
> +	unsigned long flags;
> 
> +	spin_lock_irqsave(&dom->lock, flags);
> 	domain_flush_tlb_pde(dom);
> 	domain_flush_complete(dom);
> +	spin_unlock_irqrestore(&dom->lock, flags);
> }
> 
> static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
> -- 
> 2.17.1
> 

Reviewed-by: Filippo Sironi <sironi@amazon.de>



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
