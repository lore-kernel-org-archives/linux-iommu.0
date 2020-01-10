Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49713C33CA4
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:37:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEAC20721
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2XxQPPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEAC20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E6E90884B2;
	Fri, 10 Jan 2020 15:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZyIabNxbN0UU; Fri, 10 Jan 2020 15:37:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6491D884A0;
	Fri, 10 Jan 2020 15:37:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B4F6C1D7D;
	Fri, 10 Jan 2020 15:37:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A085C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EB94B22115
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qAhJ2gLYysQE for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 15:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 0412C20337
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:37:41 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2AC2720721;
 Fri, 10 Jan 2020 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578670660;
 bh=zXVssYwWECjGiR0d/pu9mtfbN4xQSeBYcBoiAkhN+Sk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e2XxQPPn1rUecm4cocUTcNk9jz8dttgjlyNbvF/TcrhkKo65kGINE+g8mg0jesWo9
 KNllrFedI+/6+llWCUj8PbPmBMQlQr2NyKfEDUWZYJ4N3sMi1tZPpW6VSotybjo94e
 /kXHDpPtAJuu2dUGkXY/6Q4+Xa+ujyMLedpzD5BY=
Date: Fri, 10 Jan 2020 15:37:37 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Improve attribute handling
Message-ID: <20200110153736.GA24322@willie-the-truck>
References: <dee4fff7765629ca5d215af1105b5f98b32f073a.1578669544.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dee4fff7765629ca5d215af1105b5f98b32f073a.1578669544.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Fri, Jan 10, 2020 at 03:21:51PM +0000, Robin Murphy wrote:
> By VMSA rules, using Normal Non-Cacheable type with a shareability
> attribute of anything other than Outer Shareable is liable to lead into
> unpredictable territory. Although the SMMU architectures seem to give
> some slightly stronger guarantees of Non-Cacheable output types becoming
> implicitly Outer Shareable in most cases, we may as well be explicit and
> not take any chances. It's also weird that LPAE attribute handling is
> currently split between prot_to_pte() and init_pte() given that it can
> all be statically determined up-front. Thus, collect *all* the LPAE
> attributes into prot_to_pte() in order to logically pick the
> shareability based on the incoming IOMMU API prot value, and tweak the
> short-descriptor code to stop setting TTBR0.NOS for Non-Cacheable walks.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c |  7 +++----
>  drivers/iommu/io-pgtable-arm.c     | 17 +++++++++++------
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 7c3bd2c3cdca..7d6a8622f2e6 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -823,10 +823,9 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
>  	wmb();
>  
>  	/* TTBRs */
> -	cfg->arm_v7s_cfg.ttbr[0] = virt_to_phys(data->pgd) |
> -				   ARM_V7S_TTBR_S | ARM_V7S_TTBR_NOS |
> -				   (cfg->coherent_walk ?
> -				   (ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
> +	cfg->arm_v7s_cfg.ttbr[0] = virt_to_phys(data->pgd) | ARM_V7S_TTBR_S |
> +				   (cfg->coherent_walk ? (ARM_V7S_TTBR_NOS |
> +				    ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |

Ha, I just sent a broken version of this out myself, but with you as the
author ;)

I'll merge this hunk into that patch, if you don't mind?

> +	if (prot & IOMMU_CACHE)
> +		pte |= ARM_LPAE_PTE_SH_IS;
> +	else
> +		pte |= ARM_LPAE_PTE_SH_OS;
> +
>  	if (prot & IOMMU_NOEXEC)
>  		pte |= ARM_LPAE_PTE_XN;
>  
> +	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
> +		pte |= ARM_LPAE_PTE_NS;
> +
> +	if (data->iop.fmt != ARM_MALI_LPAE)
> +		pte |= ARM_LPAE_PTE_AF;
> +

I left these last two where they were, just because they're not driven
directly from the IOMMU prot encoding. However, I don't mind moving them,
but let's do that as a separate patch.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
