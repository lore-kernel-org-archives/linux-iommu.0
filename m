Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92675C43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 08:09:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36CE061360;
	Thu, 23 Jun 2022 08:09:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 36CE061360
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KLQbayg2LLG3; Thu, 23 Jun 2022 08:09:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1712060B32;
	Thu, 23 Jun 2022 08:09:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1712060B32
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F32ADC0032;
	Thu, 23 Jun 2022 08:09:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64D87C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EEC08418E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:09:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EEC08418E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nCH5HUBx2FCR for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:09:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FB0683FFB
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8FB0683FFB
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:09:30 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B77B4447; Thu, 23 Jun 2022 10:09:28 +0200 (CEST)
Date: Thu, 23 Jun 2022 10:09:27 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v1 4/7] iommu/amd: Initial support for AMD IOMMU v2 page
 table
Message-ID: <YrQft/Gp/4VuQnHl@8bytes.org>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
 <20220603112107.8603-5-vasant.hegde@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220603112107.8603-5-vasant.hegde@amd.com>
Cc: iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Jun 03, 2022 at 04:51:04PM +0530, Vasant Hegde wrote:
> +/* Allocate page table */
> +static u64 *v2_alloc_pte(u64 *pgd, unsigned long iova,
> +			 unsigned long pg_size, bool *updated)
> +{
> +	u64 *pte, *page;
> +	int level, end_level;
> +
> +	BUG_ON(!is_power_of_2(pg_size));
> +
> +	level = get_pgtable_level() - 1;
> +	end_level = page_size_to_level(pg_size);
> +	pte = &pgd[PM_LEVEL_INDEX(level, iova)];
> +	iova = PAGE_SIZE_ALIGN(iova, PAGE_SIZE);
> +
> +	while (level >= end_level) {
> +		u64 __pte, __npte;
> +
> +		__pte = *pte;
> +
> +		if (IOMMU_PTE_PRESENT(__pte) && is_large_pte(__pte)) {
> +			/* Unmap large pte */
> +			cmpxchg64(pte, *pte, 0ULL);
> +			*updated = true;
> +			continue;
> +		}
> +
> +		if (!IOMMU_PTE_PRESENT(__pte)) {
> +			page = alloc_pgtable_page();
> +			if (!page)
> +				return NULL;
> +
> +			__npte = set_pgtable_attr(page);
> +			/* pte could have been changed somewhere. */
> +			if (cmpxchg64(pte, __pte, __npte) != __pte)
> +				free_pgtable_page(page);
> +			else if (IOMMU_PTE_PRESENT(__pte))
> +				*updated = true;
> +
> +			continue;
> +		}
> +
> +		level -= 1;
> +		pte = get_pgtable_pte(__pte);
> +		pte = &pte[PM_LEVEL_INDEX(level, iova)];
> +	}

I know that the V1 page-table code also uses loops for the allocation
path, but the main reason there is the variable amount of page-table
levels. The v2 page-tables have a fixed amount levels, so it is better
to unroll this loop here (and other loops iterating over page-table
levels). This makes the code more clear.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
