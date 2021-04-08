Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75015C433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:32:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6E061104
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 14:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6E061104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9A84606F0;
	Thu,  8 Apr 2021 14:32:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X0CC3A6R9ND8; Thu,  8 Apr 2021 14:32:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82D45606EC;
	Thu,  8 Apr 2021 14:32:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67CFDC000C;
	Thu,  8 Apr 2021 14:32:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A35AFC000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:32:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92B62841AA
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:32:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ukVOmhMl6nBZ for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 14:32:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04B18841A9
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 14:32:17 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C4F4610CC;
 Thu,  8 Apr 2021 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617892335;
 bh=dCSZUf5qRFCdJRNa1E7k/U97LHBatePsybZ6J/TrTNI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WZ4+rQV3FbcAYMb5Fm/QEPV+j+Gdzu8vGVFdO8/jXedrtE0tEjQtshrU8YUQdJFEt
 BXVSY3ETIYaEiHEniXLLgUdUNOW0L4xslVHgxN0jQ7EgSQCfV5/nmso3lKurEGpW9N
 Xt6X7fH7lH0H9+/au7QIfrT+vrpeNokml5M9kma5SjaOmf6E+pZdJ1njxkEgXf4ZUt
 +yJ54J51dKuRz0tW7jkAXz+4CzCUAFDeBn8LRABd7EPFxkWsvjesTAVtRgnGhX7LdB
 REUZXUg8xzxXls9mf0lV10fNZ+hl3DdAePTBxEWzAN/zr6kyNfpRoYqVdub29lfd0h
 QeT07+3E9iRxA==
Date: Thu, 8 Apr 2021 15:32:11 +0100
From: Will Deacon <will@kernel.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [RFC PATCH v4 10/15] iommu/io-pgtable-arm: Implement
 arm_lpae_unmap_pages()
Message-ID: <20210408143211.GE17998@willie-the-truck>
References: <20210408045241.27316-1-isaacm@codeaurora.org>
 <20210408045241.27316-11-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408045241.27316-11-isaacm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pratikp@codeaurora.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Wed, Apr 07, 2021 at 09:52:36PM -0700, Isaac J. Manjarres wrote:
> Implement the unmap_pages() callback for the ARM LPAE io-pgtable
> format.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Suggested-by: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 70 ++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index ea66b10c04c4..6700685f81d4 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -253,8 +253,8 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
>  
>  static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>  			       struct iommu_iotlb_gather *gather,
> -			       unsigned long iova, size_t size, int lvl,
> -			       arm_lpae_iopte *ptep);
> +			       unsigned long iova, size_t size, size_t pgcount,
> +			       int lvl, arm_lpae_iopte *ptep);
>  
>  static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>  				phys_addr_t paddr, arm_lpae_iopte prot,
> @@ -298,7 +298,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>  			size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>  
>  			tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
> -			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz,
> +			if (__arm_lpae_unmap(data, NULL, iova + i * sz, sz, 1,
>  					     lvl, tblp) != sz) {
>  				WARN_ON(1);
>  				return -EINVAL;
> @@ -526,14 +526,14 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>  				       struct iommu_iotlb_gather *gather,
>  				       unsigned long iova, size_t size,
>  				       arm_lpae_iopte blk_pte, int lvl,
> -				       arm_lpae_iopte *ptep)
> +				       arm_lpae_iopte *ptep, size_t pgcount)
>  {
>  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>  	arm_lpae_iopte pte, *tablep;
>  	phys_addr_t blk_paddr;
>  	size_t tablesz = ARM_LPAE_GRANULE(data);
>  	size_t split_sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
> -	int i, unmap_idx = -1;
> +	int i, unmap_idx_start = -1, num_entries = 0, max_entries;
>  
>  	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
>  		return 0;
> @@ -542,15 +542,18 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>  	if (!tablep)
>  		return 0; /* Bytes unmapped */
>  
> -	if (size == split_sz)
> -		unmap_idx = ARM_LPAE_LVL_IDX(iova, lvl, data);
> +	if (size == split_sz) {
> +		unmap_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
> +		max_entries = (tablesz >> ilog2(sizeof(pte))) - unmap_idx_start;
> +		num_entries = min_t(int, pgcount, max_entries);
> +	}
>  
>  	blk_paddr = iopte_to_paddr(blk_pte, data);
>  	pte = iopte_prot(blk_pte);
>  
>  	for (i = 0; i < tablesz / sizeof(pte); i++, blk_paddr += split_sz) {

Given that we already have a 'tablesz / sizeof(pte)' expression here, I'd be
inclined to have either a local variable or a macro helper to get at the
ptes_per_table value that you also need to compute max_entries.

>  		/* Unmap! */
> -		if (i == unmap_idx)
> +		if (i >= unmap_idx_start && i < (unmap_idx_start + num_entries))
>  			continue;
>  
>  		__arm_lpae_init_pte(data, blk_paddr, pte, lvl, 1, &tablep[i]);
> @@ -568,38 +571,45 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>  			return 0;
>  
>  		tablep = iopte_deref(pte, data);
> -	} else if (unmap_idx >= 0) {
> -		io_pgtable_tlb_add_page(&data->iop, gather, iova, size);
> -		return size;
> +	} else if (unmap_idx_start >= 0) {
> +		for (i = 0; i < num_entries; i++)
> +			io_pgtable_tlb_add_page(&data->iop, gather, iova + i * size, size);

I suppose we could add a count paramater to the iotlb gather stuff in
future too, but for now this is fine as this series is already pretty big.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
