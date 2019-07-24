Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D1CC7618F
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 10:30:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F4221743
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 10:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F4221743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4CF0ECBA;
	Wed, 24 Jul 2019 10:30:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6B64FCB5
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 10:30:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7A052224
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 10:30:28 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Jul 2019 03:30:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,302,1559545200"; d="scan'208";a="172260139"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
	by orsmga003.jf.intel.com with ESMTP; 24 Jul 2019 03:30:25 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
	id 3BBF122217; Wed, 24 Jul 2019 13:30:28 +0300 (EEST)
Date: Wed, 24 Jul 2019 13:30:28 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] media: staging: ipu3: Enable IOVA API only when IOMMU
	support is enabled
Message-ID: <20190724103027.GD21370@paasikivi.fi.intel.com>
References: <20190722134749.21580-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190722134749.21580-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devel@driverdev.osuosl.org, linux-media@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, hverkuil-cisco@xs4all.nl,
	digetx@gmail.com, mchehab@kernel.org, yong.zhi@intel.com
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

Hi Yue,

On Mon, Jul 22, 2019 at 09:47:49PM +0800, YueHaibing wrote:
> If IOMMU_SUPPORT is not set, ipu3 driver may select IOMMU_IOVA to m.
> But for many drivers, they use "select IOMMU_IOVA if IOMMU_SUPPORT"
> in the Kconfig, for example, CONFIG_TEGRA_VDE is set to y but IOMMU_IOVA
> is m, then the building fails like this:
> 
> drivers/staging/media/tegra-vde/iommu.o: In function `tegra_vde_iommu_map':
> iommu.c:(.text+0x41): undefined reference to `alloc_iova'
> iommu.c:(.text+0x56): undefined reference to `__free_iova'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 7fc7af649ca7 ("media: staging/intel-ipu3: Add imgu top level pci device driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/media/ipu3/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/ipu3/Kconfig b/drivers/staging/media/ipu3/Kconfig
> index 4b51c67..b7df18f 100644
> --- a/drivers/staging/media/ipu3/Kconfig
> +++ b/drivers/staging/media/ipu3/Kconfig
> @@ -4,7 +4,7 @@ config VIDEO_IPU3_IMGU
>  	depends on PCI && VIDEO_V4L2
>  	depends on MEDIA_CONTROLLER && VIDEO_V4L2_SUBDEV_API
>  	depends on X86
> -	select IOMMU_IOVA
> +	select IOMMU_IOVA if IOMMU_SUPPORT

This doesn't seem right: the ipu3-cio2 driver needs IOMMU_IOVA
independently of IOMMU_SUPPORT.

Looking at tegra-vde, it seems to depend on IOMMU_SUPPORT but that's not
declared in its Kconfig entry. I wonder if adding that would be the right
way to fix this.

Cc'ing the IOMMU list.

>  	select VIDEOBUF2_DMA_SG
>  	help
>  	  This is the Video4Linux2 driver for Intel IPU3 image processing unit,

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
