Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5037DC433ED
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 11:54:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F242B613BD
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 11:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F242B613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC37083B8E;
	Tue,  6 Apr 2021 11:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HkQSo8sQ-4PS; Tue,  6 Apr 2021 11:54:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id A392983AD1;
	Tue,  6 Apr 2021 11:54:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 792D7C000B;
	Tue,  6 Apr 2021 11:54:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEF53C000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FCAB83A3A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:54:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QmpF2gfpopzj for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 11:54:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E72D8001F
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 11:54:02 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6757B613B3;
 Tue,  6 Apr 2021 11:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617710041;
 bh=FLeSsbLGeBLtqZkfvWRI5YQcQsnaI6eFsqJu2Yc4PJQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xw/82FklvCfBJz+OnBy2/5/xcDauG0uxmlHHzpwOZ8S5KqEin71n27LfhlbUqg5er
 DA1SYBDp5utuoUbi5HnCd0SYoiTNz+1LPzoVjsdu4PHYjnBBbU7I+Lx6e7s3N27VA0
 bOg6m3OcCsu1nXu1kU2SQozLequYbtmgDrKTwKehLqtUGHdW1HdNpZjo8uuBaQt4ny
 G6FFGteOjuLiX7y1xharOKpvlfke90Z+ttRSz/2rFMoClJbIPlYnXuXattUuioEnBk
 sp6UcksOz6MlyO1NvSAszxLjUYd7+7noo3FnIPx2ZEFmwNy5O0JNWmxpLvv0WKwCX2
 p/Xx76RkgaGPg==
Date: Tue, 6 Apr 2021 12:53:56 +0100
From: Will Deacon <will@kernel.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [RFC PATCH v3 06/12] iommu: Split 'addr_merge' argument to
 iommu_pgsize() into separate parts
Message-ID: <20210406115355.GC13747@willie-the-truck>
References: <20210405191112.28192-1-isaacm@codeaurora.org>
 <20210405191112.28192-7-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210405191112.28192-7-isaacm@codeaurora.org>
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

On Mon, Apr 05, 2021 at 12:11:06PM -0700, Isaac J. Manjarres wrote:
> From: Will Deacon <will@kernel.org>
> 
> The 'addr_merge' parameter to iommu_pgsize() is a fabricated address
> intended to describe the alignment requirements to consider when
> choosing an appropriate page size. On the iommu_map() path, this address
> is the logical OR of the virtual and physical addresses.
> 
> Subsequent improvements to iommu_pgsize() will need to check the
> alignment of the virtual and physical components of 'addr_merge'
> independently, so pass them in as separate parameters and reconstruct
> 'addr_merge' locally.
> 
> No functional change.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>  drivers/iommu/iommu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 9006397b6604..a3bbf7e310b0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2357,12 +2357,13 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>  }
>  EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
>  
> -static size_t iommu_pgsize(struct iommu_domain *domain,
> -			   unsigned long addr_merge, size_t size)
> +static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
> +			   phys_addr_t paddr, size_t size)
>  {
>  	unsigned int pgsize_idx;
>  	unsigned long pgsizes;
>  	size_t pgsize;
> +	phys_addr_t addr_merge = paddr | iova;

Huh, so this was 'unsigned long' before and, given that the pgsize_bitmap
on the domain is also unsigned long, then I think that's fine. So using
that would mean you don't need GENMASK_ULL for this guy either.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
