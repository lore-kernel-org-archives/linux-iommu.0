Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1BCC31E40
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 10:56:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE65621783
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 10:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyVS7gmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE65621783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 81884EAF;
	Thu, 15 Aug 2019 10:56:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 03601D1A
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 10:56:08 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B297967F
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 10:56:07 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 06C0121744;
	Thu, 15 Aug 2019 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565866567;
	bh=dsvbwhM91K+mxTLiSJ4SAk9JzF9IdMrk/WuDkDXupdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WyVS7gmVGAYle4zAnMuu8ny0ra2EWnqmRiJmr4nsudfTE5drfVcZE5fOFnV6CnpOz
	yjWUHEmkCXY/4Y5EARRa0EHcijYz5hzweyCdvJipEDSXGzIZybaFEdkM9ongJKDagE
	4Ym2PB//p4/6y8bdgZZUtIn43dL6NgX8TWYKPl+Y=
Date: Thu, 15 Aug 2019 11:56:03 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 05/15] iommu/arm-smmu: Split
	arm_smmu_tlb_inv_range_nosync()
Message-ID: <20190815105602.hk53orjumysfezff@willie-the-truck>
References: <cover.1565369764.git.robin.murphy@arm.com>
	<33a49ca158509c95d50b0d3f9cba03bba2facdf3.1565369764.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33a49ca158509c95d50b0d3f9cba03bba2facdf3.1565369764.git.robin.murphy@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
	gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org
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

On Fri, Aug 09, 2019 at 06:07:42PM +0100, Robin Murphy wrote:
> Since we now use separate iommu_gather_ops for stage 1 and stage 2
> contexts, we may as well divide up the monolithic callback into its
> respective stage 1 and stage 2 parts.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 66 ++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 29 deletions(-)

This will conflict with my iommu API batching stuff, but I can sort that
out if/when it gets queued by Joerg.

> -		if (cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
> -			iova &= ~12UL;
> -			iova |= cfg->asid;
> -			do {
> -				writel_relaxed(iova, reg);
> -				iova += granule;
> -			} while (size -= granule);
> -		} else {
> -			iova >>= 12;
> -			iova |= (u64)cfg->asid << 48;
> -			do {
> -				writeq_relaxed(iova, reg);
> -				iova += granule >> 12;
> -			} while (size -= granule);
> -		}
> -	} else {
> -		reg += leaf ? ARM_SMMU_CB_S2_TLBIIPAS2L :
> -			      ARM_SMMU_CB_S2_TLBIIPAS2;
> -		iova >>= 12;
> +	if (cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
> +		iova &= ~12UL;

Oh baby. You should move code around more often, so I'm forced to take a
second look!

Can you cook a fix for this that we can route separately, please? I see
it also made its way into qcom_iommu.c...

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
