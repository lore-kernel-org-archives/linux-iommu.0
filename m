Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D62C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 11:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7095813E5;
	Mon, 14 Feb 2022 11:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E_P7-vrQtgMu; Mon, 14 Feb 2022 11:44:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F16AC813DF;
	Mon, 14 Feb 2022 11:44:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4B2BC001A;
	Mon, 14 Feb 2022 11:44:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FC76C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F79260DB2
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PP1xYDM7xxiK for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 11:44:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A466D60B5F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:44:00 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8F76A36D; Mon, 14 Feb 2022 12:43:58 +0100 (CET)
Date: Mon, 14 Feb 2022 12:43:57 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Check for error num after setting mask
Message-ID: <YgpAfVVhkNljJhJY@8bytes.org>
References: <20220106024302.2574180-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220106024302.2574180-1-jiasheng@iscas.ac.cn>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, will@kernel.org,
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

Adding more potential reviewers.

On Thu, Jan 06, 2022 at 10:43:02AM +0800, Jiasheng Jiang wrote:
> Because of the possible failure of the dma_supported(), the
> dma_set_mask_and_coherent() may return error num.
> Therefore, it should be better to check it and return the error if
> fails.
> 
> Fixes: 1c894225bf5b ("iommu/ipmmu-vmsa: IPMMU device is 40-bit bus master")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index aaa6a4d59057..7df5da44a004 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1003,7 +1003,9 @@ static int ipmmu_probe(struct platform_device *pdev)
>  	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
>  	mmu->features = of_device_get_match_data(&pdev->dev);
>  	memset(mmu->utlb_ctx, IPMMU_CTX_INVALID, mmu->features->num_utlbs);
> -	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
> +	if (ret)
> +		return ret;
>  
>  	/* Map I/O memory and request IRQ. */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -- 
> 2.25.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
