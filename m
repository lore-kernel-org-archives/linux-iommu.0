Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9733CC433DB
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 13:53:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D006146D
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 13:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D006146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 779F886BBE;
	Thu, 28 Jan 2021 13:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uIvx2FDkcW6T; Thu, 28 Jan 2021 13:53:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D418B86BAB;
	Thu, 28 Jan 2021 13:53:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6A0DC0FA7;
	Thu, 28 Jan 2021 13:53:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 584D8C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5244C872A4
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-vucIiNzbzc for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 13:53:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9904387299
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:53:08 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B54264DD6;
 Thu, 28 Jan 2021 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611841988;
 bh=bK1letrBP538RMIL8R6DRz5OUru3EJx+i9lre8QlJFk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o95+Fbcrfa9UIY8Ozwzh1Upq0c+CV9heuPUrfxFlDf4/YSJf5A5B3sM8NVEpEN4S0
 tKLYNFyluOXrvehYPIi3FV7mscKjmzw4KPqzKvVU9F05cryU2KGa6LdU3rQCTL1dmM
 +FielnAES+TIXOw5kaZgNGqjTbNF+Qs/KUSr94cXp93yw897AkF85a5KObXvSZ/TSI
 uNEfN+9xzrJcfktIfGcM5CAgBTRr/FrHohdvSbzHw5ksKFx+xFJdt0MRucaP5LiM8R
 vSskg0GgrnN1pFVKPBzpiI/+FAdUJoMf70iwyD7gLhfT1ocvXml4Nm15UHK/1KGwus
 ZfUmm7n5sxsGA==
Date: Thu, 28 Jan 2021 13:53:03 +0000
From: Will Deacon <will@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC 5/9] iommu/io-pgtable-arm: Hook up map_sg()
Message-ID: <20210128135302.GA2416@willie-the-truck>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
 <161177765310.1311.13604114123927933039.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161177765310.1311.13604114123927933039.stgit@manet.1015granger.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: isaacm@codeaurora.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com
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

On Wed, Jan 27, 2021 at 03:00:53PM -0500, Chuck Lever wrote:
> From: Isaac J. Manjarres <isaacm@codeaurora.org>
> 
> Implement the map_sg io-pgtable op for the ARM LPAE io-pgtable
> code, so that IOMMU drivers can call it when they need to map
> a scatter-gather list.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  drivers/iommu/io-pgtable-arm.c |   86 ++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommu.c          |   12 +++---
>  include/linux/iommu.h          |    8 ++++
>  3 files changed, 101 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 87def58e79b5..0c11529442b8 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -473,6 +473,91 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	return ret;
>  }
>  
> +static int arm_lpae_map_by_pgsize(struct io_pgtable_ops *ops,
> +				  unsigned long iova, phys_addr_t paddr,
> +				  size_t size, int iommu_prot, gfp_t gfp,
> +				  size_t *mapped)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> +	arm_lpae_iopte *ptep = data->pgd;
> +	int ret, lvl = data->start_level;
> +	arm_lpae_iopte prot = arm_lpae_prot_to_pte(data, iommu_prot);
> +	unsigned int min_pagesz = 1 << __ffs(cfg->pgsize_bitmap);
> +	long iaext = (s64)(iova + size - 1) >> cfg->ias;
> +	size_t pgsize;
> +
> +	if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
> +		pr_err("unaligned: iova 0x%lx pa %pa size 0x%zx min_pagesz 0x%x\n",
> +		       iova, &paddr, size, min_pagesz);
> +		return -EINVAL;
> +	}
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> +		iaext = ~iaext;
> +	if (WARN_ON(iaext || (paddr + size - 1) >> cfg->oas))
> +		return -ERANGE;
> +
> +	while (size) {
> +		pgsize = iommu_pgsize(cfg->pgsize_bitmap, iova | paddr, size);
> +		ret = __arm_lpae_map(data, iova, paddr, pgsize, prot, lvl, ptep,
> +				     gfp);
> +		if (ret)
> +			return ret;
> +
> +		iova += pgsize;
> +		paddr += pgsize;
> +		*mapped += pgsize;
> +		size -= pgsize;
> +	}
> +
> +	return 0;
> +}
> +
> +static int arm_lpae_map_sg(struct io_pgtable_ops *ops, unsigned long iova,
> +			   struct scatterlist *sg, unsigned int nents,
> +			   int iommu_prot, gfp_t gfp, size_t *mapped)
> +{
> +
> +	size_t len = 0;
> +	unsigned int i = 0;
> +	int ret;
> +	phys_addr_t start;
> +
> +	*mapped = 0;
> +
> +	/* If no access, then nothing to do */
> +	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> +		return 0;
> +
> +	while (i <= nents) {
> +		phys_addr_t s_phys = sg_phys(sg);
> +
> +		if (len && s_phys != start + len) {
> +			ret = arm_lpae_map_by_pgsize(ops, iova + *mapped, start,
> +						     len, iommu_prot, gfp,
> +						     mapped);
> +
> +			if (ret)
> +				return ret;
> +
> +			len = 0;
> +		}
> +
> +		if (len) {
> +			len += sg->length;
> +		} else {
> +			len = sg->length;
> +			start = s_phys;
> +		}
> +
> +		if (++i < nents)
> +			sg = sg_next(sg);
> +	}
> +
> +	return 0;
> +}

Although I really like the idea of reducing the layering here, I think we
need to figure out a way to reduce the amount of boiler-plate that ends up
in the pgtable code. Otherwise it's pretty unmaintainable.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
