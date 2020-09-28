Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F71DC4727E
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 14:59:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F16C21D7F
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 14:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTBK1Sto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F16C21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 96D9A203E7;
	Mon, 28 Sep 2020 14:59:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YdXiP7C8Tqhd; Mon, 28 Sep 2020 14:59:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AB890204E6;
	Mon, 28 Sep 2020 14:59:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 908C5C016F;
	Mon, 28 Sep 2020 14:59:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBCD6C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B1BE584E88
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:59:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yUwSbYq-g3yR for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 14:59:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E705184CC2
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:59:10 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A80C21974;
 Mon, 28 Sep 2020 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601305150;
 bh=5ymSvknDn6nUQNSDP3i0GXvhB11Sl5F2mvHL8TiNGAU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DTBK1StoSdAzLTkbX9Cbg2wlNIZTB/tA/FfgNDKflPWf7wT6VjOIhBjhNw2ZSd6Q6
 W5lOIasPWg6JKGHX3oU6h6mf+f3cmLN7xUjbUy+xTfncoWwgb8aVhuMFPP2n18zhnm
 vO0fOlie8+JkqEo8l6YX6+XX93iCzTrjUlBBDAu4=
Date: Mon, 28 Sep 2020 15:59:05 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable-arm: Support coherency for Mali
 LPAE
Message-ID: <20200928145904.GA11610@willie-the-truck>
References: <cover.1600780574.git.robin.murphy@arm.com>
 <8df778355378127ea7eccc9521d6427e3e48d4f2.1600780574.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8df778355378127ea7eccc9521d6427e3e48d4f2.1600780574.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, tomeu.vizoso@collabora.com, narmstrong@baylibre.com,
 khilman@baylibre.com, dri-devel@lists.freedesktop.org, steven.price@arm.com,
 iommu@lists.linux-foundation.org, alyssa.rosenzweig@collabora.com,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 jbrunet@baylibre.com
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

On Tue, Sep 22, 2020 at 03:16:48PM +0100, Robin Murphy wrote:
> Midgard GPUs have ACE-Lite master interfaces which allows systems to
> integrate them in an I/O-coherent manner. It seems that from the GPU's
> viewpoint, the rest of the system is its outer shareable domain, and so
> even when snoop signals are wired up, they are only emitted for outer
> shareable accesses. As such, setting the TTBR_SHARE_OUTER bit does
> indeed get coherent pagetable walks working nicely for the coherent
> T620 in the Arm Juno SoC.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index dc7bcf858b6d..b4072a18e45d 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -440,7 +440,13 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>  	}
>  
> -	if (prot & IOMMU_CACHE)
> +	/*
> +	 * Also Mali has its own notions of shareability wherein its Inner
> +	 * domain covers the cores within the GPU, and its Outer domain is
> +	 * "outside the GPU" (i.e. either the Inner or System domain in CPU
> +	 * terms, depending on coherency).
> +	 */
> +	if (prot & IOMMU_CACHE && data->iop.fmt != ARM_MALI_LPAE)
>  		pte |= ARM_LPAE_PTE_SH_IS;
>  	else
>  		pte |= ARM_LPAE_PTE_SH_OS;
> @@ -1049,6 +1055,9 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>  	cfg->arm_mali_lpae_cfg.transtab = virt_to_phys(data->pgd) |
>  					  ARM_MALI_LPAE_TTBR_READ_INNER |
>  					  ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
> +	if (cfg->coherent_walk)
> +		cfg->arm_mali_lpae_cfg.transtab |= ARM_MALI_LPAE_TTBR_SHARE_OUTER;
> +

Acked-by: Will Deacon <will@kernel.org>

I'm assuming I'm not the right person to merge this, and it needs to go
alongside the other patches in this series.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
