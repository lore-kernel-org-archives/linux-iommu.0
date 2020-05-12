Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62D7C54E4A
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:59:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6666206B8
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 09:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6666206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5A9C02C33C;
	Tue, 12 May 2020 09:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sjdnd6LRiyDD; Tue, 12 May 2020 09:59:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D73EC207A9;
	Tue, 12 May 2020 09:59:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C69A6C088A;
	Tue, 12 May 2020 09:59:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 248A9C016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 212128705B
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1tJ1JO3zLP3j for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 09:59:23 +0000 (UTC)
X-Greylist: delayed 00:05:49 by SQLgrey-1.7.6
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 260DB86BA4
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 09:59:23 +0000 (UTC)
Received: from penelope.horms.nl (tulip.horms.nl [83.161.246.101])
 by kirsty.vergenet.net (Postfix) with ESMTPA id AB32C25AD50;
 Tue, 12 May 2020 19:53:31 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 57B76717; Tue, 12 May 2020 11:53:29 +0200 (CEST)
Date: Tue, 12 May 2020 11:53:29 +0200
From: Simon Horman <horms@verge.net.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] iommu/renesas: fix unused-function warning
Message-ID: <20200512095329.GA18408@vergenet.net>
References: <20200508220224.688985-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200508220224.688985-1-arnd@arndb.de>
Organisation: Horms Solutions BV
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hai Nguyen Pham <hai.pham.ud@renesas.com>, Joerg Roedel <jroedel@suse.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Sat, May 09, 2020 at 12:02:16AM +0200, Arnd Bergmann wrote:
> gcc warns because the only reference to ipmmu_find_group
> is inside of an #ifdef:
> 
> drivers/iommu/ipmmu-vmsa.c:878:28: error: 'ipmmu_find_group' defined but not used [-Werror=unused-function]
> 
> Change the #ifdef to an equivalent IS_ENABLED().
> 
> Fixes: 6580c8a78424 ("iommu/renesas: Convert to probe/release_device() call-backs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  drivers/iommu/ipmmu-vmsa.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index fb7e702dee23..4c2972f3153b 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -903,11 +903,8 @@ static const struct iommu_ops ipmmu_ops = {
>  	.probe_device = ipmmu_probe_device,
>  	.release_device = ipmmu_release_device,
>  	.probe_finalize = ipmmu_probe_finalize,
> -#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
> -	.device_group = generic_device_group,
> -#else
> -	.device_group = ipmmu_find_group,
> -#endif
> +	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
> +			? generic_device_group : ipmmu_find_group,
>  	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
>  	.of_xlate = ipmmu_of_xlate,
>  };
> -- 
> 2.26.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
