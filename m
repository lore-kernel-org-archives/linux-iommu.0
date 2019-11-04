Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CADCA9EC9
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 23:40:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8511320663
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 23:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EbFPcpNb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZIIqA4Ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8511320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5E03DC97;
	Mon,  4 Nov 2019 23:40:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6B73FC6D
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 23:40:11 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D2B9367F
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 23:40:10 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9DAA360D7C; Mon,  4 Nov 2019 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572910810;
	bh=XRZOS9iE7bkA+MdchCOi3kyQapjc8vlTcLgpjwNC+bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbFPcpNbmVbQHaEUXvMAFN0oJWFeP+NvTZHnCEEmzATW3BQsLm/xgRbuBtf/lsoOM
	AA9RpUFNpiEV+niGdn3RzYo1dThEJGs41xbKPSAlCnPy80KcnBHjGvI1+3JVKYkHxf
	NDx5uBS/GFZqKgv5dwSth5Fan6T8f+xozXZn3xbc=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 85E0060CDD;
	Mon,  4 Nov 2019 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1572910809;
	bh=XRZOS9iE7bkA+MdchCOi3kyQapjc8vlTcLgpjwNC+bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIIqA4NiRmX7nZv+Z3KIH1nGER0A+y/FE30pI24dLIzyDeehKLUAxGZS4CLEQPdDt
	fxpQKNhcWJlJD3PSv0v3sMTFDTR0fFjWqLywf3REqb0VWx02ukC4VeuENQpgLcZ8L/
	+axH+bZku7bRe+HfqAKbACj7kHprxOXwD0akrtPU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85E0060CDD
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 4 Nov 2019 16:40:06 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 10/10] iommu/io-pgtable-arm: Prepare for TTBR1 usage
Message-ID: <20191104234006.GC16446@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
	iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
References: <cover.1572024119.git.robin.murphy@arm.com>
	<9ec05935de3f1c1da5d1780201147ed40e129295.1572024120.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9ec05935de3f1c1da5d1780201147ed40e129295.1572024120.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
	linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 25, 2019 at 07:08:39PM +0100, Robin Murphy wrote:
> Now that we can correctly extract top-level indices without relying on
> the remaining upper bits being zero, the only remaining impediments to
> using a given table for TTBR1 are the address validation on map/unmap
> and the awkward TCR translation granule format. Add a quirk so that we
> can do the right thing at those points.

This looks great.  I have one comment about the TCR.A1 bit below but otherwise
this is sane. My immediate todo this week and next is to try to get something
spun up and working on the db845 for verification.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++------
>  include/linux/io-pgtable.h     |  4 ++++
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 9b1912ede000..e53edff56e54 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -107,6 +107,10 @@
>  #define ARM_LPAE_TCR_TG0_64K		1
>  #define ARM_LPAE_TCR_TG0_16K		2
>  
> +#define ARM_LPAE_TCR_TG1_16K		1
> +#define ARM_LPAE_TCR_TG1_4K		2
> +#define ARM_LPAE_TCR_TG1_64K		3
> +
>  #define ARM_LPAE_TCR_SH0_SHIFT		12
>  #define ARM_LPAE_TCR_SH_NS		0
>  #define ARM_LPAE_TCR_SH_OS		2
> @@ -466,6 +470,7 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	arm_lpae_iopte *ptep = data->pgd;
>  	int ret, lvl = data->start_level;
>  	arm_lpae_iopte prot;
> +	long iaext = (long)iova >> cfg->ias;
>  
>  	/* If no access, then nothing to do */
>  	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> @@ -474,7 +479,9 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
>  		return -EINVAL;
>  
> -	if (WARN_ON(iova >> data->iop.cfg.ias || paddr >> data->iop.cfg.oas))
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> +		iaext = ~iaext;
> +	if (WARN_ON(iaext || paddr >> cfg->oas))
>  		return -ERANGE;
>  
>  	prot = arm_lpae_prot_to_pte(data, iommu_prot);
> @@ -640,11 +647,14 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>  	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>  	arm_lpae_iopte *ptep = data->pgd;
> +	long iaext = (long)iova >> cfg->ias;
>  
>  	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
>  		return 0;
>  
> -	if (WARN_ON(iova >> data->iop.cfg.ias))
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
> +		iaext = ~iaext;
> +	if (WARN_ON(iaext))
>  		return 0;
>  
>  	return __arm_lpae_unmap(data, gather, iova, size, data->start_level, ptep);
> @@ -780,9 +790,11 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>  	u64 reg;
>  	struct arm_lpae_io_pgtable *data;
>  	typeof(&cfg->arm_lpae_s1_cfg.tcr) tcr = &cfg->arm_lpae_s1_cfg.tcr;
> +	bool tg1;
>  
>  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
> -			    IO_PGTABLE_QUIRK_NON_STRICT))
> +			    IO_PGTABLE_QUIRK_NON_STRICT |
> +			    IO_PGTABLE_QUIRK_ARM_TTBR1))
>  		return NULL;
>  
>  	data = arm_lpae_alloc_pgtable(cfg);
> @@ -800,15 +812,16 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>  		tcr->orgn = ARM_LPAE_TCR_RGN_NC;
>  	}
>  
> +	tg1 = cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1;
>  	switch (ARM_LPAE_GRANULE(data)) {
>  	case SZ_4K:
> -		tcr->tg = ARM_LPAE_TCR_TG0_4K;
> +		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_4K : ARM_LPAE_TCR_TG0_4K;
>  		break;
>  	case SZ_16K:
> -		tcr->tg = ARM_LPAE_TCR_TG0_16K;
> +		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_16K : ARM_LPAE_TCR_TG0_16K;
>  		break;
>  	case SZ_64K:
> -		tcr->tg = ARM_LPAE_TCR_TG0_64K;
> +		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_64K : ARM_LPAE_TCR_TG0_64K;
>  		break;
>  	}

The comment in one of the previous patches about the ASID in TTBR1 triggered
something in my brain. v2 TCR A1,bit[22] controls from which TTBR the ASID is
used I'm not sure if that qualifies as a quirk here or if it should be entirely
handled within arm_smmu_lpae_tcr() but I thought I should point it out.

>  
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 6ae104cedfd7..d7c5cb685e50 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -83,12 +83,16 @@ struct io_pgtable_cfg {
>  	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
>  	 *	on unmap, for DMA domains using the flush queue mechanism for
>  	 *	delayed invalidation.
> +	 *
> +	 * IO_PGTABLE_QUIRK_ARM_TTBR1: (ARM LPAE format) Configure the table
> +	 *	for use in the upper half of a split address space.
>  	 */
>  	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
>  	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
>  	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
>  	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT	BIT(3)
>  	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(4)
> +	#define IO_PGTABLE_QUIRK_ARM_TTBR1	BIT(5)
>  	unsigned long			quirks;
>  	unsigned long			pgsize_bitmap;
>  	unsigned int			ias;
> -- 
> 2.21.0.dirty
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
