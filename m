Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940A2C32753
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 17:20:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681122084D
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 17:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x2iO+k3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681122084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1D898DC6;
	Wed, 14 Aug 2019 17:20:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 60EBBDC1
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 17:20:37 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 791C576D
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 17:20:35 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C575B2084D;
	Wed, 14 Aug 2019 17:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803235;
	bh=dt28HiKeDA9L5mGvly1JScUvZrWg1DeQplEWd5mOXVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x2iO+k3qoVbzAWsj9n4cmCZJpdzYPI/bRqvYH5bbDp/N0s2sKO6LvHdfx/1XWmbNW
	Bk8/fUmRIQ7U9AqwZDhyub7FlgLSvSb8wGg/FtwC1CEF6pjFd3Gm/ktqXgn0Z5FmXa
	ZvutSr2KnRj5UzSjttcADHwPeZqs9Qj+v0SPIpS8=
Date: Wed, 14 Aug 2019 18:20:30 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 01/15] iommu/arm-smmu: Convert GR0 registers to bitfields
Message-ID: <20190814172030.accr7azgkkkwumt2@willie-the-truck>
References: <cover.1565369764.git.robin.murphy@arm.com>
	<910cad718be01904db20ce73d8d54e7481290136.1565369764.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <910cad718be01904db20ce73d8d54e7481290136.1565369764.git.robin.murphy@arm.com>
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

On Fri, Aug 09, 2019 at 06:07:38PM +0100, Robin Murphy wrote:
> FIELD_PREP remains a terrible name, but the overall simplification will
> make further work on this stuff that much more manageable. This also
> serves as an audit of the header, wherein we can impose a consistent
> grouping and ordering of the offset and field definitions
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu-regs.h | 126 ++++++++++++++++------------------
>  drivers/iommu/arm-smmu.c      |  51 +++++++-------
>  2 files changed, 84 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> index 1c278f7ae888..d189f025537a 100644
> --- a/drivers/iommu/arm-smmu-regs.h
> +++ b/drivers/iommu/arm-smmu-regs.h
> @@ -10,111 +10,101 @@
>  #ifndef _ARM_SMMU_REGS_H
>  #define _ARM_SMMU_REGS_H
>  
> +#include <linux/bits.h>
> +
>  /* Configuration registers */
>  #define ARM_SMMU_GR0_sCR0		0x0
> -#define sCR0_CLIENTPD			(1 << 0)
> -#define sCR0_GFRE			(1 << 1)
> -#define sCR0_GFIE			(1 << 2)
> -#define sCR0_EXIDENABLE			(1 << 3)
> -#define sCR0_GCFGFRE			(1 << 4)
> -#define sCR0_GCFGFIE			(1 << 5)
> -#define sCR0_USFCFG			(1 << 10)
> -#define sCR0_VMIDPNE			(1 << 11)
> -#define sCR0_PTM			(1 << 12)
> -#define sCR0_FB				(1 << 13)
> -#define sCR0_VMID16EN			(1 << 31)
> -#define sCR0_BSU_SHIFT			14
> -#define sCR0_BSU_MASK			0x3
> +#define sCR0_VMID16EN			BIT(31)
> +#define sCR0_BSU			GENMASK(15, 14)
> +#define sCR0_FB				BIT(13)
> +#define sCR0_PTM			BIT(12)
> +#define sCR0_VMIDPNE			BIT(11)
> +#define sCR0_USFCFG			BIT(10)
> +#define sCR0_GCFGFIE			BIT(5)
> +#define sCR0_GCFGFRE			BIT(4)
> +#define sCR0_EXIDENABLE			BIT(3)
> +#define sCR0_GFIE			BIT(2)
> +#define sCR0_GFRE			BIT(1)
> +#define sCR0_CLIENTPD			BIT(0)
>  
>  /* Auxiliary Configuration register */
>  #define ARM_SMMU_GR0_sACR		0x10
>  
>  /* Identification registers */
>  #define ARM_SMMU_GR0_ID0		0x20
> +#define ID0_S1TS			BIT(30)
> +#define ID0_S2TS			BIT(29)
> +#define ID0_NTS				BIT(28)
> +#define ID0_SMS				BIT(27)
> +#define ID0_ATOSNS			BIT(26)
> +#define ID0_PTFS_NO_AARCH32		BIT(25)
> +#define ID0_PTFS_NO_AARCH32S		BIT(24)
> +#define ID0_CTTW			BIT(14)
> +#define ID0_NUMIRPT			GENMASK(23, 16)

nit: assuming this should be above ID0_CTTW so things are in descending
bit order?

Other than that, looks good to me.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
