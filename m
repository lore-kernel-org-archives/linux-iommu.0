Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2266C3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 14:18:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A896A2339E
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 14:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A896A2339E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 52DB34709;
	Thu, 29 Aug 2019 14:18:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B622D4739
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 11:46:48 +0000 (UTC)
X-Greylist: delayed 00:07:09 by SQLgrey-1.7.6
Received: from lb2-smtp-cloud8.xs4all.net (lb2-smtp-cloud8.xs4all.net
	[194.109.24.25])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B35B61FB
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 11:46:47 +0000 (UTC)
Received: from [192.168.2.10] ([46.9.232.237])
	by smtp-cloud8.xs4all.net with ESMTPA
	id 3Im4iRJpeDqPe3Im8iNmv5; Thu, 29 Aug 2019 13:39:36 +0200
Subject: Re: [PATCH] media: staging: tegra-vde: Disable building with
	COMPILE_TEST
To: YueHaibing <yuehaibing@huawei.com>, digetx@gmail.com, mchehab@kernel.org, 
	gregkh@linuxfoundation.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	robin.murphy@arm.com
References: <20190826133140.13456-1-yuehaibing@huawei.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <7f73bcac-f52d-f1b3-324c-e9b551c5378b@xs4all.nl>
Date: Thu, 29 Aug 2019 13:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826133140.13456-1-yuehaibing@huawei.com>
Content-Language: en-US
X-CMAE-Envelope: MS4wfPiBAm9/CVG2yl/RYcmSeabFSsF5/VsS8tiz/yGOIjYSnJaD/MkFj3fN12HeAtoQBMQlQLOy1rQ4hH9Pk3PGKlkkJ9Zl8plyc55GSSz4G1+ppVvvtxVa
	cgqxOaIHdmGI6Lir3V57kld0PdyIGCK03wiHOkje13kc0gv/PhnX5+C3LrfxdHi2CMNt74bKZcw6PfwDuhW1UOnvKmy1QH8JUr++Y9Auceu48WZ6AknahDMp
	y+nvVNlAWPrJV2LqEleB77la5ICht/YcDItL8/YHiyeJqDySBIvEVXGwJL4Xi9NZpZ9Wxt1uH4KbBobOQixOSOlTcNw+jzMsIe+bJEk17cuyRCrooBbp13+w
	rAVl2YjzGamD7FhK930GFNdNmk8AkL+TW8oiCNcUOr/eA3es3KvvOT/pXVSQjB8VA9jwGGPoUNhHSHDpq4csgibDV9Sq8D6Biv12lEVTn+0Gyp3CGn8lifj1
	NQ04G6sIObCBPw4TuYqOc3L6nn1zCZs6e0K9+DpBNqD0AuyfSDTX/sC8t2V3/1Ij0sv2jB60jtfqjR0cWtBhZHW6dO+mED2Z2qpLMcnRImy9u654a5b4EY9U
	8oU=
X-Mailman-Approved-At: Thu, 29 Aug 2019 14:18:00 +0000
Cc: linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
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

On 8/26/19 3:31 PM, YueHaibing wrote:
> If COMPILE_TEST is y and IOMMU_SUPPORT is n, selecting TEGRA_VDE
> to m will set IOMMU_IOVA to m, this fails the building of
> TEGRA_HOST1X and DRM_TEGRA which is y like this:
> 
> drivers/gpu/host1x/cdma.o: In function `host1x_cdma_init':
> cdma.c:(.text+0x66c): undefined reference to `alloc_iova'
> cdma.c:(.text+0x698): undefined reference to `__free_iova'
> 
> drivers/gpu/drm/tegra/drm.o: In function `tegra_drm_unload':
> drm.c:(.text+0xeb0): undefined reference to `put_iova_domain'
> drm.c:(.text+0xeb4): undefined reference to `iova_cache_put'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 6b2265975239 ("media: staging: tegra-vde: Fix build error")
> Fixes: b301f8de1925 ("media: staging: media: tegra-vde: Add IOMMU support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/media/tegra-vde/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/tegra-vde/Kconfig b/drivers/staging/media/tegra-vde/Kconfig
> index ba49ea5..a41d30c 100644
> --- a/drivers/staging/media/tegra-vde/Kconfig
> +++ b/drivers/staging/media/tegra-vde/Kconfig
> @@ -1,9 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config TEGRA_VDE
>  	tristate "NVIDIA Tegra Video Decoder Engine driver"
> -	depends on ARCH_TEGRA || COMPILE_TEST
> +	depends on ARCH_TEGRA

What happens if you drop this change,

>  	select DMA_SHARED_BUFFER
> -	select IOMMU_IOVA if (IOMMU_SUPPORT || COMPILE_TEST)
> +	select IOMMU_IOVA if IOMMU_SUPPORT

but keep this change?

iova.h has stubs that are used if IOMMU_IOVA is not set, so it should
work when compile testing this tegra-vde driver.

Haven't tried it, but making sure that compile testing keep working is
really important.

Regards,

	Hans

>  	select SRAM
>  	help
>  	    Say Y here to enable support for the NVIDIA Tegra video decoder
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
