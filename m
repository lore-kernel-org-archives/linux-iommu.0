Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E748C432C2
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 15:46:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1599E21D7A
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 15:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Cp9O4DRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1599E21D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D15D1C64;
	Wed, 25 Sep 2019 15:46:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6958FBE4
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 15:46:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
	[207.171.190.10])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0815BB0
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
	t=1569426361; x=1600962361;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:mime-version: content-transfer-encoding;
	bh=cKL/ibsYjR04/0hV4O3LZDngJWoce0s7WOw94IF6iM4=;
	b=Cp9O4DRGNwFUc1GQm2dpM5fYj2f0/BBZlHbciecFhlEKJGp1kG+vaixa
	ERCixlyJRYF4SbihXlpwpKk47PtW3lP8pRuw/Knsewkw4lCCPH9xOwtiF
	eRg6p7eGHv6oydBjtExtc92TeN9HWfdaVAVRtLhqitESPMKwlpVKTKvdq 8=;
X-IronPort-AV: E=Sophos;i="5.64,548,1559520000"; d="scan'208";a="836745923"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO
	email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.22.34])
	by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
	25 Sep 2019 15:45:26 +0000
Received: from EX13MTAUEA001.ant.amazon.com
	(pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
	by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with
	ESMTPS id 23CDEA18E4; Wed, 25 Sep 2019 15:45:17 +0000 (UTC)
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
	EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server
	(TLS) id 15.0.1367.3; Wed, 25 Sep 2019 15:45:16 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
	EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server
	(TLS) id 15.0.1367.3; Wed, 25 Sep 2019 15:45:15 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
	EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id
	15.00.1367.000; Wed, 25 Sep 2019 15:45:15 +0000
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/6] iommu/amd: Remove domain->updated
Thread-Topic: [PATCH 1/6] iommu/amd: Remove domain->updated
Thread-Index: AQHVc6RpDD4zLOo3jUGJuNX4P9+dAKc8iSgA
Date: Wed, 25 Sep 2019 15:45:14 +0000
Message-ID: <7E6C7B56-442F-408E-B127-FE5CBE58A3F5@amazon.de>
References: <20190925132300.3038-1-joro@8bytes.org>
	<20190925132300.3038-2-joro@8bytes.org>
In-Reply-To: <20190925132300.3038-2-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.55]
Content-ID: <9CEBBDE7132FEB49A3F7EA1D8F478521@amazon.com>
MIME-Version: 1.0
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"jroedel@suse.de" <jroedel@suse.de>
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
From: "Sironi, Filippo via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Sironi, Filippo" <sironi@amazon.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org



> On 25. Sep 2019, at 06:22, Joerg Roedel <joro@8bytes.org> wrote:
> 
> From: Joerg Roedel <jroedel@suse.de>
> 
> This struct member was used to track whether a domain
> change requires updates to the device-table and IOMMU cache
> flushes. The problem is, that access to this field is racy
> since locking in the common mapping code-paths has been
> eliminated.
> 
> Move the updated field to the stack to get rid of all
> potential races and remove the field from the struct.
> 
> Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
> drivers/iommu/amd_iommu.c       | 49 +++++++++++++++++----------------
> drivers/iommu/amd_iommu_types.h |  1 -
> 2 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 7bdce3b10f3d..042854bbc5bc 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1458,10 +1458,11 @@ static void free_pagetable(struct protection_domain *domain)
>  * another level increases the size of the address space by 9 bits to a size up
>  * to 64 bits.
>  */
> -static void increase_address_space(struct protection_domain *domain,
> +static bool increase_address_space(struct protection_domain *domain,
> 				   gfp_t gfp)
> {
> 	unsigned long flags;
> +	bool ret = false;
> 	u64 *pte;
> 
> 	spin_lock_irqsave(&domain->lock, flags);
> @@ -1478,19 +1479,21 @@ static void increase_address_space(struct protection_domain *domain,
> 					iommu_virt_to_phys(domain->pt_root));
> 	domain->pt_root  = pte;
> 	domain->mode    += 1;
> -	domain->updated  = true;
> +
> +	ret = true;
> 
> out:
> 	spin_unlock_irqrestore(&domain->lock, flags);
> 
> -	return;
> +	return ret;
> }
> 
> static u64 *alloc_pte(struct protection_domain *domain,
> 		      unsigned long address,
> 		      unsigned long page_size,
> 		      u64 **pte_page,
> -		      gfp_t gfp)
> +		      gfp_t gfp,
> +		      bool *updated)
> {
> 	int level, end_lvl;
> 	u64 *pte, *page;
> @@ -1498,7 +1501,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
> 	BUG_ON(!is_power_of_2(page_size));
> 
> 	while (address > PM_LEVEL_SIZE(domain->mode))
> -		increase_address_space(domain, gfp);
> +		*updated = increase_address_space(domain, gfp) || *updated;
> 
> 	level   = domain->mode - 1;
> 	pte     = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
> @@ -1530,7 +1533,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
> 			for (i = 0; i < count; ++i)
> 				cmpxchg64(&lpte[i], __pte, 0ULL);
> 
> -			domain->updated = true;
> +			*updated = true;
> 			continue;
> 		}
> 
> @@ -1547,7 +1550,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
> 			if (cmpxchg64(pte, __pte, __npte) != __pte)
> 				free_page((unsigned long)page);
> 			else if (IOMMU_PTE_PRESENT(__pte))
> -				domain->updated = true;
> +				*updated = true;
> 
> 			continue;
> 		}
> @@ -1656,28 +1659,29 @@ static int iommu_map_page(struct protection_domain *dom,
> 			  gfp_t gfp)
> {
> 	struct page *freelist = NULL;
> +	bool updated = false;
> 	u64 __pte, *pte;
> -	int i, count;
> +	int ret, i, count;
> 
> 	BUG_ON(!IS_ALIGNED(bus_addr, page_size));
> 	BUG_ON(!IS_ALIGNED(phys_addr, page_size));
> 
> +	ret = -EINVAL;
> 	if (!(prot & IOMMU_PROT_MASK))
> -		return -EINVAL;
> +		goto out;
> 
> 	count = PAGE_SIZE_PTE_COUNT(page_size);
> -	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp);
> +	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp, &updated);
> 
> -	if (!pte) {
> -		update_domain(dom);
> -		return -ENOMEM;
> -	}
> +	ret = -ENOMEM;
> +	if (!pte)
> +		goto out;
> 
> 	for (i = 0; i < count; ++i)
> 		freelist = free_clear_pte(&pte[i], pte[i], freelist);
> 
> 	if (freelist != NULL)
> -		dom->updated = true;
> +		updated = true;
> 
> 	if (count > 1) {
> 		__pte = PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
> @@ -1693,12 +1697,16 @@ static int iommu_map_page(struct protection_domain *dom,
> 	for (i = 0; i < count; ++i)
> 		pte[i] = __pte;
> 
> -	update_domain(dom);
> +	ret = 0;
> +
> +out:
> +	if (updated)
> +		update_domain(dom);
> 
> 	/* Everything flushed out, free pages now */
> 	free_page_list(freelist);
> 
> -	return 0;
> +	return ret;
> }
> 
> static unsigned long iommu_unmap_page(struct protection_domain *dom,
> @@ -2399,15 +2407,10 @@ static void update_device_table(struct protection_domain *domain)
> 
> static void update_domain(struct protection_domain *domain)
> {
> -	if (!domain->updated)
> -		return;
> -
> 	update_device_table(domain);
> 
> 	domain_flush_devices(domain);
> 	domain_flush_tlb_pde(domain);
> -
> -	domain->updated = false;
> }
> 
> static int dir2prot(enum dma_data_direction direction)
> @@ -3333,7 +3336,6 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
> 
> 	/* Update data structure */
> 	domain->mode    = PAGE_MODE_NONE;
> -	domain->updated = true;
> 
> 	/* Make changes visible to IOMMUs */
> 	update_domain(domain);
> @@ -3379,7 +3381,6 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
> 
> 	domain->glx      = levels;
> 	domain->flags   |= PD_IOMMUV2_MASK;
> -	domain->updated  = true;
> 
> 	update_domain(domain);
> 
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index 9ac229e92b07..0186501ab971 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -475,7 +475,6 @@ struct protection_domain {
> 	int glx;		/* Number of levels for GCR3 table */
> 	u64 *gcr3_tbl;		/* Guest CR3 table */
> 	unsigned long flags;	/* flags to find out type of domain */
> -	bool updated;		/* complete domain flush required */
> 	unsigned dev_cnt;	/* devices assigned to this domain */
> 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
> };
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
