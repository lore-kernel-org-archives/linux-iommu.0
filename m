Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2545C433ED
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 12:16:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F07613C2
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 12:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F07613C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51CFB842DE;
	Tue,  6 Apr 2021 12:16:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TQCtF-YwiNUg; Tue,  6 Apr 2021 12:16:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C4E4842B0;
	Tue,  6 Apr 2021 12:16:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18A4DC000C;
	Tue,  6 Apr 2021 12:16:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB76FC000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 12:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D46140519
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 12:15:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 489DpRoV00sa for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 12:15:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C050B401F7
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 12:15:57 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51DE3613BD;
 Tue,  6 Apr 2021 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617711357;
 bh=bA/5RMPS+MqCFEq4ueYRVrnW78xgwbC/GxYc9ETEp5w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t8PA10JOPbGpErhN9KYxRfyRA5RxhZebXDKVG1cSnArPl4XiDEpL1bdC1iWkI5W8U
 HmJ+dVDKxIzaWEQE8AgrMvLktpF4cTERyUDy7HPgqwF2hZvnnXAHwB+PGkDEf3Ceun
 Bu10Zl9uBqfPngYliBe2hLiu8IFiOhkIvpI4owaaAIfysJtKGPnc+6OcPaar+Yip20
 F8N/011c+zFO8N5UUWmndnEKE/t3R4DPUjPrqNbsDW0PO7LCwIaJbA7W1dX0ieqFG+
 q0kZSOXnnCqYB//oBM/Y85ftsREPwx3VLMNFPhAioO8OJ5WFk5Mqt0FvZkDOLi++Jn
 F/xOXoTkoZ+2A==
Date: Tue, 6 Apr 2021 13:15:53 +0100
From: Will Deacon <will@kernel.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [RFC PATCH v3 09/12] iommu/io-pgtable-arm: Implement
 arm_lpae_unmap_pages()
Message-ID: <20210406121552.GF13747@willie-the-truck>
References: <20210405191112.28192-1-isaacm@codeaurora.org>
 <20210405191112.28192-10-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210405191112.28192-10-isaacm@codeaurora.org>
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

On Mon, Apr 05, 2021 at 12:11:09PM -0700, Isaac J. Manjarres wrote:
> Implement the unmap_pages() callback for the ARM LPAE io-pgtable
> format.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Suggested-by: Will Deacon <will@kernel.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 124 +++++++++++++++++++++++++++------
>  1 file changed, 104 insertions(+), 20 deletions(-)

[...]

> +static size_t arm_lpae_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
> +				   size_t pgsize, size_t pgcount,
> +				   struct iommu_iotlb_gather *gather)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> +	arm_lpae_iopte *ptep = data->pgd;
> +	long iaext = (s64)iova >> cfg->ias;
> +	size_t unmapped = 0, unmapped_page;
> +	int last_lvl;
> +	size_t table_size, pages, tbl_offset, max_entries;
> +
> +	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize || !pgcount))
> +		return 0;
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> +		iaext = ~iaext;
> +	if (WARN_ON(iaext))
> +		return 0;
> +
> +	/*
> +	 * Calculating the page table size here helps avoid situations where
> +	 * a page range that is being unmapped may be mapped at the same level
> +	 * but not mapped by the same tables. Allowing such a scenario to
> +	 * occur can complicate the logic in arm_lpae_split_blk_unmap().
> +	 */
> +	last_lvl = ARM_LPAE_BLOCK_SIZE_LVL(pgsize, data);
> +
> +	if (last_lvl == data->start_level)
> +		table_size = ARM_LPAE_PGD_SIZE(data);
> +	else
> +		table_size = ARM_LPAE_GRANULE(data);
> +
> +	max_entries = table_size / sizeof(*ptep);
> +
> +	while (pgcount) {
> +		tbl_offset = ARM_LPAE_LVL_IDX(iova, last_lvl, data);
> +		pages = min_t(size_t, pgcount, max_entries - tbl_offset);
> +		unmapped_page = __arm_lpae_unmap(data, gather, iova, pgsize,
> +						 pages, data->start_level,
> +						 ptep);
> +		if (!unmapped_page)
> +			break;
> +
> +		unmapped += unmapped_page;
> +		iova += unmapped_page;
> +		pgcount -= pages;
> +	}

Robin has some comments on the first version of this patch, and I don't think you
addressed them:

https://lore.kernel.org/r/b93fa0b1-e2a4-1aad-8b88-4d0dfecdfef7@arm.com

I'm inclined to agree that iterating here doesn't make a lot of sense --
we've already come back out of the page-table walk, so I think we should
just return to the caller (who is well prepared to handle a partial unmap).
Same for the map side of things.

If we get numbers showing that this is causing a performance issue, then
we should rework the page-table code to handle this at the lower level
(because I doubt the loop that you have is really worse than returning to
the caller anyway).

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
