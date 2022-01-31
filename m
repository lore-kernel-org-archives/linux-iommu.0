Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFCEC433F5
	for <iommu@archiver.kernel.org>; Mon, 31 Jan 2022 10:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCC6660C2D;
	Mon, 31 Jan 2022 10:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zaWb6BfntIO2; Mon, 31 Jan 2022 10:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9CD5B60BD6;
	Mon, 31 Jan 2022 10:57:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B0B5C0011;
	Mon, 31 Jan 2022 10:57:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92B00C000B
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 10:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 71B8440566
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 10:57:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S9YGC9NGdfDR for <iommu@lists.linux-foundation.org>;
 Mon, 31 Jan 2022 10:57:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86B62404EB
 for <iommu@lists.linux-foundation.org>; Mon, 31 Jan 2022 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643626647; x=1675162647;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=ZdENkAwNTJtD0Npkluazkuj5//kfgKoLfVNh1OSJ8Us=;
 b=G2/f5EW9iabG8hkLAMWkBLrSworB1oiqC0mWyrlHLic7ucEfKFE8GZDf
 jn+UgvFk3KtjFvKBsFi6fvld9O7qbi92U7Ix7X9wGm9b9v7NLax5TX/ZI
 /u0ugDbx6sEv9uCqIBMRpXrTZWqz81N0kCgjWmg+SA/+HPnKuEAxybO+J
 xesfwdCYp2uikVee7I4rIbiqXNauwB0CS0hCdXL0OyIxgwg4CYxavRXG7
 UpSxvxqaQgbFUHflifk4zPsxGFqrDEnzRICMr6bHUdd/8sGzsvbFGYECL
 3/k0DsElVt0mqbIWv9/DmiEOdIRgB05BnSjS/6cLTfQlbc99dv/Yymtpa Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="333795281"
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; d="scan'208";a="333795281"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2022 02:57:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,330,1635231600"; d="scan'208";a="481712993"
Received: from ylian16-mobl1.ccr.corp.intel.com (HELO localhost)
 ([10.252.16.100])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2022 02:57:19 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Daniel Vetter <daniel@ffwll.ch>, Yong Wu <yong.wu@mediatek.com>
Subject: Re: [RFC PATCH] component: Add common helpers for compare/release
 functions
In-Reply-To: <YfRtGF3v+BwH5RkG@phenom.ffwll.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220128081101.27837-1-yong.wu@mediatek.com>
 <YfRtGF3v+BwH5RkG@phenom.ffwll.local>
Date: Mon, 31 Jan 2022 12:57:16 +0200
Message-ID: <878ruww4tv.fsf@intel.com>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 James Wang <james.qian.wang@arm.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 srv_heupstream@mediatek.com, Stephen Boyd <sboyd@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, iommu@lists.linux-foundation.org,
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

On Fri, 28 Jan 2022, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Fri, Jan 28, 2022 at 04:11:01PM +0800, Yong Wu wrote:
>> The component requires the compare/release functions, there are so many
>> copy in current kernel. Just define three common helpers for them.
>> No functional change.
>> 
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>> ---
>> Base on v5.17-rc1
>> ---
>>  .../gpu/drm/arm/display/komeda/komeda_drv.c    |  5 -----
>>  drivers/gpu/drm/arm/hdlcd_drv.c                |  7 +------
>>  drivers/gpu/drm/armada/armada_drv.c            |  5 -----
>>  drivers/gpu/drm/drm_of.c                       |  8 +-------
>>  drivers/gpu/drm/etnaviv/etnaviv_drv.c          |  7 -------
>>  drivers/gpu/drm/exynos/exynos_drm_drv.c        |  5 -----
>>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c    |  5 -----
>>  drivers/gpu/drm/imx/imx-drm-core.c             |  4 ++--
>>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c      |  5 -----
>>  drivers/gpu/drm/mcde/mcde_drv.c                |  7 +------
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.c         |  5 -----
>>  drivers/gpu/drm/meson/meson_drv.c              |  8 --------
>>  drivers/gpu/drm/msm/msm_drv.c                  |  9 ---------
>>  drivers/gpu/drm/omapdrm/dss/dss.c              |  8 +-------
>>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c    |  5 -----
>>  drivers/gpu/drm/sti/sti_drv.c                  |  5 -----
>>  drivers/gpu/drm/sun4i/sun4i_drv.c              |  9 ---------
>>  drivers/gpu/drm/vc4/vc4_drv.c                  |  5 -----
>>  drivers/iommu/mtk_iommu.h                      | 10 ----------
>>  drivers/power/supply/ab8500_charger.c          |  8 +-------
>>  drivers/video/fbdev/omap2/omapfb/dss/dss.c     |  8 +-------
>>  include/linux/component.h                      | 18 ++++++++++++++++++
>>  sound/soc/codecs/wcd938x.c                     | 16 ++--------------
>
> Seems like a neat idea. Please add kerneldoc for the new functions you're
> adding (bonus point for an example in there) and make sure it all renders
> correctly in
>
> $ make htmldoc
>
> Also please split up the patch series per-driver and add the maintainers
> to each patches' Cc: list. With that I think this should be ready for
> merging.

Aren't the function names perhaps a bit short and generic for the global
namespace though? If you encounter compare_of, release_of, or
compare_dev in code, component.h is not where you'd expect to find them.

BR,
Jani.


>> diff --git a/include/linux/component.h b/include/linux/component.h
>> index 16de18f473d7..5a7468ea827c 100644
>> --- a/include/linux/component.h
>> +++ b/include/linux/component.h
>> @@ -2,6 +2,8 @@
>>  #ifndef COMPONENT_H
>>  #define COMPONENT_H
>>  
>> +#include <linux/device.h>
>> +#include <linux/of.h>
>>  #include <linux/stddef.h>
>>  
>>  
>> @@ -82,6 +84,22 @@ struct component_master_ops {
>>  	void (*unbind)(struct device *master);
>>  };
>>  
>> +/* A set common helpers for compare/release functions */
>> +static inline int compare_of(struct device *dev, void *data)
>> +{
>> +	return dev->of_node == data;
>> +}
>> +
>> +static inline void release_of(struct device *dev, void *data)
>> +{
>> +	of_node_put(data);
>> +}
>> +
>> +static inline int compare_dev(struct device *dev, void *data)
>> +{
>> +	return dev == data;
>> +}
>> +
>>  void component_master_del(struct device *,
>>  	const struct component_master_ops *);
>>  

-- 
Jani Nikula, Intel Open Source Graphics Center
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
