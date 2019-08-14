Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9E2C433FF
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 18:06:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1657F214C6
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 18:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vaMyS1BJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1657F214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 023BFDC8;
	Wed, 14 Aug 2019 18:06:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F3DFADC6
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 18:06:01 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B10D38D
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 18:06:01 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 00F632084F;
	Wed, 14 Aug 2019 18:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565805961;
	bh=puKdRnZ9LG6uknCkDTCLnECmpG0XfmA88XteJcC0jh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vaMyS1BJywCuDwrnch6OBd8r5eplRXAp4jPYZAuzOJ7M2Q7m57u/Q3LLBrxhyTg4t
	zPflWXiqZbT87UNk22LqQOg8kMAO5LgWrwosJI3QzshH1I43CmAVV85deRIvPqgGdd
	P7pWTMZwpaVohqULOWsxSX4oRe6JjKSd6yaRjMgw=
Date: Wed, 14 Aug 2019 19:05:57 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 04/15] iommu/arm-smmu: Rework cb_base handling
Message-ID: <20190814180556.5asp5qflrxxjipal@willie-the-truck>
References: <cover.1565369764.git.robin.murphy@arm.com>
	<f4dccad78815ca0a2dd7926be7052759d099b920.1565369764.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f4dccad78815ca0a2dd7926be7052759d099b920.1565369764.git.robin.murphy@arm.com>
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

On Fri, Aug 09, 2019 at 06:07:41PM +0100, Robin Murphy wrote:
> To keep register-access quirks manageable, we want to structure things
> to avoid needing too many individual overrides. It seems fairly clean to
> have a single interface which handles both global and context registers
> in terms of the architectural pages, so the first preparatory step is to
> rework cb_base into a page number rather than an absolute address.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index d9a93e5f422f..463bc8d98adb 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -95,7 +95,7 @@
>  #endif
>  
>  /* Translation context bank */
> -#define ARM_SMMU_CB(smmu, n)	((smmu)->cb_base + ((n) << (smmu)->pgshift))
> +#define ARM_SMMU_CB(smmu, n)	((smmu)->base + (((smmu)->cb_base + (n)) << (smmu)->pgshift))
>  
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
> @@ -168,8 +168,8 @@ struct arm_smmu_device {
>  	struct device			*dev;
>  
>  	void __iomem			*base;
> -	void __iomem			*cb_base;
> -	unsigned long			pgshift;
> +	unsigned int			cb_base;

I think this is now a misnomer. Would you be able to rename it cb_pfn or
something, please?

Otherwise, this seems fine.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
