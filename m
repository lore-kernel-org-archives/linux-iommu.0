Return-Path: <SRS0=DplC=LI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE99C48BE8
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 08:36:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF96E61380
	for <iommu@archiver.kernel.org>; Mon, 14 Jun 2021 08:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF96E61380
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B2D1403EA;
	Mon, 14 Jun 2021 08:36:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7_WbNbFCpBv9; Mon, 14 Jun 2021 08:36:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 379E4403C3;
	Mon, 14 Jun 2021 08:36:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E40C8C000E;
	Mon, 14 Jun 2021 08:36:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79760C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 08:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57AE96089F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 08:36:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lQODPB0wUSNl for <iommu@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 08:36:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD005605BC
 for <iommu@lists.linux-foundation.org>; Mon, 14 Jun 2021 08:36:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8F7461370;
 Mon, 14 Jun 2021 08:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623659775;
 bh=gAds2DSRUgeIv4sXDXp+KcQsXS8BItWPveSU8A0iVNw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GdF8d7Nc73ERCj4tKtd+EKrDaEZ8yJ+F4aspVmBPc26cxK39nB+ihm0IMhEfiv/TU
 1gVxIUDZ/DHzr4FI1RPcTRHYoY/RdE97a/vpCp2MAIcs554WO1B2fK1X0ubBbDt6Ug
 bqh/0hJVYLgGtx8gxV9sFUCXus7xfic8wZey1N0mya/hfKuuydHhT7oZTdqQXSwhK3
 3s4Y9E3px/QQPetqjhsFsJ/RVtYbfjLAqvQIoOYAA+wiNOQwAiDkiIyP848beGgwhB
 TTwaL3jiAdcG+02kBU6O5ItNZ7b77cipnHWwE25PPy7w304pYBubjq75QeXYFaT6cw
 jjy9xl4KgeLug==
Date: Mon, 14 Jun 2021 09:36:10 +0100
From: Will Deacon <will@kernel.org>
To: Dong Aisheng <aisheng.dong@nxp.com>
Subject: Re: [PATCH 1/1] dma: coherent: check no-map property for arm64
Message-ID: <20210614083609.GA18701@willie-the-truck>
References: <20210611131056.3731084-1-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210611131056.3731084-1-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: dongas86@gmail.com, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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

[+Catalin]

On Fri, Jun 11, 2021 at 09:10:56PM +0800, Dong Aisheng wrote:
> Coherent dma on ARM64 also can't work with mapped system ram,
> that means 'no-map' property must be specified in dts.
> Add the missing check for ARM64 platforms as well.
> Besides 'no-map' checking, 'linux,dma-default' feature is also
> enabled for ARM64 along with this patch.

Please can you explain _why_ it can't work? We don't need to tear down
aliases from the linear map for the streaming DMA API, so why is this
case different? Also, coherent devices wouldn't need this either way,
would they? What problem are you solving here?

Thanks,

Will

> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  kernel/dma/coherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 5b5b6c7ec7f2..d1831da7afba 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -356,7 +356,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
>  	if (of_get_flat_dt_prop(node, "reusable", NULL))
>  		return -EINVAL;
>  
> -#ifdef CONFIG_ARM
> +#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
>  	if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
>  		pr_err("Reserved memory: regions without no-map are not yet supported\n");
>  		return -EINVAL;
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
