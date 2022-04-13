Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC6BC433F5
	for <iommu@archiver.kernel.org>; Wed, 13 Apr 2022 22:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D375E60E0D;
	Wed, 13 Apr 2022 22:34:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0y8MX3Y64fUu; Wed, 13 Apr 2022 22:34:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 862C260AC3;
	Wed, 13 Apr 2022 22:34:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 621DEC002F;
	Wed, 13 Apr 2022 22:34:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37F93C002C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 22:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1206E60E0D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 22:34:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G-bFnri-ZuH5 for <iommu@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 22:34:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2FDE660AC3
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 22:34:32 +0000 (UTC)
Received: from [IPV6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1] (unknown
 [IPv6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 982E31F4762C;
 Wed, 13 Apr 2022 23:34:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1649889270;
 bh=YG/XPhnWizXt3303tJt/IxDGAZVOLwxkOEcrQ7Z9X1I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WuInoSFqyOdJAlFL2xvC3Fd06QpZKkwfuYrjwHkZTkD3PIQmFEM6al0EmXS+wSFGn
 JZoeP7y+9bvcUjK4SH7oYB9OEMOqkZTMeDzVxNGmHqkgDa0QqmsiVLGnrJ+zRtX1C9
 MUV82xVcb7MhPRF/M/j7O56roc/EOLNaJoQERHg6lx1P5tE8M0+rZDp7etRC029xfg
 MyoxvhheqezqCf0zOF5inflSCSTNOoB7aeRKetuaBlY7nhTNK9cIHW9vowIHJy0odE
 Bd4L9c6oS5vzxekRzWMhDNn/jwlaq7YcrmLPUn7Nmrj6LLiYUOvXQzQnQBs9KBmAG9
 2EMXQRqKGBMYA==
Message-ID: <9bb76a5b-d5d7-6f43-ed8a-e6782dda8568@collabora.com>
Date: Thu, 14 Apr 2022 01:34:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] drm/tegra: Stop using iommu_present()
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, thierry.reding@gmail.com
References: <1f7c304a79b8b8dd5d4716786cae7502a0cc31f5.1649684782.git.robin.murphy@arm.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <1f7c304a79b8b8dd5d4716786cae7502a0cc31f5.1649684782.git.robin.murphy@arm.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, jonathanh@nvidia.com
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

On 4/11/22 16:46, Robin Murphy wrote:
> Refactor the confusing logic to make it both clearer and more robust. If
> the host1x parent device does have an IOMMU domain then iommu_present()
> is redundantly true, while otherwise for the 32-bit DMA mask case it
> still doesn't say whether the IOMMU driver actually knows about the DRM
> device or not.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Fix logic for older SoCs and clarify.
> 
>  drivers/gpu/drm/tegra/drm.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index 9464f522e257..4f2bdab31064 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -1092,6 +1092,19 @@ static bool host1x_drm_wants_iommu(struct host1x_device *dev)
>  	struct host1x *host1x = dev_get_drvdata(dev->dev.parent);
>  	struct iommu_domain *domain;
>  
> +	/* For starters, this is moot if no IOMMU is available */
> +	if (!device_iommu_mapped(&dev->dev))
> +		return false;
> +
> +	/*
> +	 * Tegra20 and Tegra30 don't support addressing memory beyond the
> +	 * 32-bit boundary, so the regular GATHER opcodes will always be
> +	 * sufficient and whether or not the host1x is attached to an IOMMU
> +	 * doesn't matter.
> +	 */
> +	if (host1x_get_dma_mask(host1x) <= DMA_BIT_MASK(32))
> +		return true;
> +
>  	/*
>  	 * If the Tegra DRM clients are backed by an IOMMU, push buffers are
>  	 * likely to be allocated beyond the 32-bit boundary if sufficient
> @@ -1122,14 +1135,13 @@ static bool host1x_drm_wants_iommu(struct host1x_device *dev)
>  	domain = iommu_get_domain_for_dev(dev->dev.parent);
>  
>  	/*
> -	 * Tegra20 and Tegra30 don't support addressing memory beyond the
> -	 * 32-bit boundary, so the regular GATHER opcodes will always be
> -	 * sufficient and whether or not the host1x is attached to an IOMMU
> -	 * doesn't matter.
> +	 * At the moment, the exact type of domain doesn't actually matter.
> +	 * Only for 64-bit kernels might this be a managed DMA API domain, and
> +	 * then only on newer SoCs using arm-smmu, since tegra-smmu doesn't
> +	 * support default domains at all, and since those SoCs are the same
> +	 * ones with extended GATHER support, even if it's a passthrough domain
> +	 * it can still work out OK.
>  	 */
> -	if (!domain && host1x_get_dma_mask(host1x) <= DMA_BIT_MASK(32))
> -		return true;
> -
>  	return domain != NULL;
>  }
>  
> @@ -1149,7 +1161,7 @@ static int host1x_drm_probe(struct host1x_device *dev)
>  		goto put;
>  	}
>  
> -	if (host1x_drm_wants_iommu(dev) && iommu_present(&platform_bus_type)) {
> +	if (host1x_drm_wants_iommu(dev)) {
>  		tegra->domain = iommu_domain_alloc(&platform_bus_type);
>  		if (!tegra->domain) {
>  			err = -ENOMEM;

Robin, thank you for the updated version. The patch looks okay to me.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

A bit later I'll also will give it a test, just to be sure because we
had problems with that function in the past.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
