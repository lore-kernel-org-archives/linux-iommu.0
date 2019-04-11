Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CD3C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 08:32:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499382083E
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 08:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499382083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ECDB3237D;
	Thu, 11 Apr 2019 08:32:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AEA342377
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 08:32:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 31C18F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 08:32:44 +0000 (UTC)
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
	by kirsty.vergenet.net (Postfix) with ESMTPA id 0F07E25AD6D;
	Thu, 11 Apr 2019 18:32:43 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
	id 06D51940356; Thu, 11 Apr 2019 10:32:40 +0200 (CEST)
Date: Thu, 11 Apr 2019 10:32:40 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 4/6] iommu/ipmmu-vmsa: Move num_utlbs to SoC-specific
	features
Message-ID: <20190411083240.jxv3xoasrg3vx5zh@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
	<20190403182148.18058-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190403182148.18058-5-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Magnus Damm <damm+renesas@opensource.se>,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411083240.U34K9kTLXyhS5IDbTMkIYFLvahgGIEXWOdLhyy9vRKg@z>

On Wed, Apr 03, 2019 at 08:21:46PM +0200, Geert Uytterhoeven wrote:
> The maximum number of micro-TLBs per IPMMU instance is not fixed, but
> depends on the SoC type.  Hence move it from struct ipmmu_vmsa_device to
> struct ipmmu_features, and set up the correct value for both R-Car Gen2
> and Gen3 SoCs.
> 
> Note that currently no code uses this value.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Are there any plans to use num_utlbs in the driver or anywhere else in the
kernel? If not, perhaps it should be removed?

> ---
> v2:
>   - Add Reviewed-by.
> ---
>  drivers/iommu/ipmmu-vmsa.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 87acf86f295fac0d..3fa57627b1e35562 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -42,6 +42,7 @@ struct ipmmu_features {
>  	bool use_ns_alias_offset;
>  	bool has_cache_leaf_nodes;
>  	unsigned int number_of_contexts;
> +	unsigned int num_utlbs;
>  	bool setup_imbuscr;
>  	bool twobit_imttbcr_sl0;
>  	bool reserved_context;
> @@ -53,7 +54,6 @@ struct ipmmu_vmsa_device {
>  	struct iommu_device iommu;
>  	struct ipmmu_vmsa_device *root;
>  	const struct ipmmu_features *features;
> -	unsigned int num_utlbs;
>  	unsigned int num_ctx;
>  	spinlock_t lock;			/* Protects ctx and domains[] */
>  	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
> @@ -972,6 +972,7 @@ static const struct ipmmu_features ipmmu_features_default = {
>  	.use_ns_alias_offset = true,
>  	.has_cache_leaf_nodes = false,
>  	.number_of_contexts = 1, /* software only tested with one context */
> +	.num_utlbs = 32,
>  	.setup_imbuscr = true,
>  	.twobit_imttbcr_sl0 = false,
>  	.reserved_context = false,
> @@ -981,6 +982,7 @@ static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
>  	.use_ns_alias_offset = false,
>  	.has_cache_leaf_nodes = true,
>  	.number_of_contexts = 8,
> +	.num_utlbs = 48,
>  	.setup_imbuscr = false,
>  	.twobit_imttbcr_sl0 = true,
>  	.reserved_context = true,
> @@ -1033,7 +1035,6 @@ static int ipmmu_probe(struct platform_device *pdev)
>  	}
>  
>  	mmu->dev = &pdev->dev;
> -	mmu->num_utlbs = 48;
>  	spin_lock_init(&mmu->lock);
>  	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
>  	mmu->features = of_device_get_match_data(&pdev->dev);
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
