Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61986C3A5A1
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 22:34:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2462322CE8
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 22:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JBDxn7rb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JBDxn7rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2462322CE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DC08DD9E;
	Mon, 19 Aug 2019 22:34:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 858AFCDF
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 22:34:43 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 08A0767F
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 22:34:43 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C921D602A8; Mon, 19 Aug 2019 22:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1566254082;
	bh=k/EgUsTzu4RwsB7lsqAa1G7TslPF7mLAqK9TxAyERwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBDxn7rbFeImSLClHBcuxI7/RRnsGc308ub4SDdRiNnXkQ/UF0xvB7Gf55FMK/3AU
	8WxCO2t4LgdAnD6CTWru3+FT3aMwhbtpQdBNWEzOVkFXUZPpy/hjVzWVCPWe4XSZIH
	isukimzdOdt+jBWF92u49gHsKfP5UocDMrwZcVIM=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
	[199.106.103.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: jcrouse@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 669F7602A8;
	Mon, 19 Aug 2019 22:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1566254082;
	bh=k/EgUsTzu4RwsB7lsqAa1G7TslPF7mLAqK9TxAyERwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBDxn7rbFeImSLClHBcuxI7/RRnsGc308ub4SDdRiNnXkQ/UF0xvB7Gf55FMK/3AU
	8WxCO2t4LgdAnD6CTWru3+FT3aMwhbtpQdBNWEzOVkFXUZPpy/hjVzWVCPWe4XSZIH
	isukimzdOdt+jBWF92u49gHsKfP5UocDMrwZcVIM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 669F7602A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Mon, 19 Aug 2019 16:34:39 -0600
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 4/4] iommu/io-pgtable-arm: Prepare for TTBR1 usage
Message-ID: <20190819223439.GG28465@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
	joro@8bytes.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, robdclark@gmail.com
References: <cover.1566238530.git.robin.murphy@arm.com>
	<6596469d5fa1e918145fdd4e6b1a3ad67f7cde2e.1566238530.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6596469d5fa1e918145fdd4e6b1a3ad67f7cde2e.1566238530.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: will@kernel.org, iommu@lists.linux-foundation.org,
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

On Mon, Aug 19, 2019 at 07:19:31PM +0100, Robin Murphy wrote:
> Now that callers are free to use a given table for TTBR1 if they wish
> (all they need do is shift the provided attributes when constructing
> their final TCR value), the only remaining impediment is the address
> validation on map/unmap. The fact that the LPAE address space split is
> symmetric makes this easy to accommodate - by simplifying the current
> range checks into explicit tests that address bits above IAS are all
> zero, it then follows straightforwardly to add the inverse test to
> allow the all-ones case as well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 09cb20671fbb..f39c50356351 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -475,13 +475,13 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	arm_lpae_iopte *ptep = data->pgd;
>  	int ret, lvl = ARM_LPAE_START_LVL(data);
>  	arm_lpae_iopte prot;
> +	long iaext = (long)iova >> data->iop.cfg.ias;
>  
>  	/* If no access, then nothing to do */
>  	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
>  		return 0;
>  
> -	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias) ||
> -		    paddr >= (1ULL << data->iop.cfg.oas)))
> +	if (WARN_ON((iaext && ~iaext) || paddr >> data->iop.cfg.oas))
>  		return -ERANGE;
>  
>  	prot = arm_lpae_prot_to_pte(data, iommu_prot);

We'll want to cast away the sign extended bits before mapping the iova, this
might be a good patch for that too as long as we are calculating the iaext.

> @@ -647,8 +647,9 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>  	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>  	arm_lpae_iopte *ptep = data->pgd;
>  	int lvl = ARM_LPAE_START_LVL(data);
> +	long iaext = (long)iova >> data->iop.cfg.ias;
>  
> -	if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
> +	if (WARN_ON(iaext && ~iaext))
>  		return 0;
>  
>  	return __arm_lpae_unmap(data, iova, size, lvl, ptep);

And here too.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
