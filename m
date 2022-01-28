Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584ABC433EF
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 13:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E285040286;
	Fri, 28 Jan 2022 13:04:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1hDNKL_dO7DC; Fri, 28 Jan 2022 13:04:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B28C404CA;
	Fri, 28 Jan 2022 13:04:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C7B1C0021;
	Fri, 28 Jan 2022 13:04:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F058DC000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 13:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E554740B3A
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 13:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WFvWJekeRKRf for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 13:04:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id BBE97404CA
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 13:04:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE9DA11D4;
 Fri, 28 Jan 2022 05:04:18 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E4173F766;
 Fri, 28 Jan 2022 05:04:13 -0800 (PST)
Message-ID: <29deffd6-aac4-f085-bcd5-f5a2d02784a8@arm.com>
Date: Fri, 28 Jan 2022 13:04:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC PATCH] component: Add common helpers for compare/release
 functions
Content-Language: en-GB
To: Yong Wu <yong.wu@mediatek.com>, dri-devel@lists.freedesktop.org
References: <20220128081101.27837-1-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220128081101.27837-1-yong.wu@mediatek.com>
Cc: David Airlie <airlied@linux.ie>, Liviu Dudau <liviu.dudau@arm.com>,
 Sebastian Reichel <sre@kernel.org>,
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
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-01-28 08:11, Yong Wu wrote:
[...]
> diff --git a/include/linux/component.h b/include/linux/component.h
> index 16de18f473d7..5a7468ea827c 100644
> --- a/include/linux/component.h
> +++ b/include/linux/component.h
> @@ -2,6 +2,8 @@
>   #ifndef COMPONENT_H
>   #define COMPONENT_H
>   
> +#include <linux/device.h>
> +#include <linux/of.h>
>   #include <linux/stddef.h>
>   
>   
> @@ -82,6 +84,22 @@ struct component_master_ops {
>   	void (*unbind)(struct device *master);
>   };
>   
> +/* A set common helpers for compare/release functions */
> +static inline int compare_of(struct device *dev, void *data)
> +{
> +	return dev->of_node == data;
> +}

Note that this is effectively just device_match_of_node(), although I 
guess there is an argument that having a nice consistent set of 
component_match API helpers might be worth more than a tiny code saving 
by borrowing one from a different API.

Either way, however, I don't think there's any good argument for 
instantiating separate copies of these functions in every driver that 
uses them. If they're used as callbacks then they can't actually be 
inlined anyway, so they may as well be exported from component.c as 
normal so that the code really is shared (plus then there's nice 
symmetry with the aforementioned device_match API helpers too).

Thanks,
Robin.

> +static inline void release_of(struct device *dev, void *data)
> +{
> +	of_node_put(data);
> +}
> +
> +static inline int compare_dev(struct device *dev, void *data)
> +{
> +	return dev == data;
> +}
> +
>   void component_master_del(struct device *,
>   	const struct component_master_ops *);
>   
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index eff200a07d9f..992132cbfb9f 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -4417,16 +4417,6 @@ static const struct component_master_ops wcd938x_comp_ops = {
>   	.unbind = wcd938x_unbind,
>   };
>   
> -static int wcd938x_compare_of(struct device *dev, void *data)
> -{
> -	return dev->of_node == data;
> -}
> -
> -static void wcd938x_release_of(struct device *dev, void *data)
> -{
> -	of_node_put(data);
> -}
> -
>   static int wcd938x_add_slave_components(struct wcd938x_priv *wcd938x,
>   					struct device *dev,
>   					struct component_match **matchptr)
> @@ -4442,8 +4432,7 @@ static int wcd938x_add_slave_components(struct wcd938x_priv *wcd938x,
>   	}
>   
>   	of_node_get(wcd938x->rxnode);
> -	component_match_add_release(dev, matchptr, wcd938x_release_of,
> -				    wcd938x_compare_of,	wcd938x->rxnode);
> +	component_match_add_release(dev, matchptr, release_of, compare_of, wcd938x->rxnode);
>   
>   	wcd938x->txnode = of_parse_phandle(np, "qcom,tx-device", 0);
>   	if (!wcd938x->txnode) {
> @@ -4451,8 +4440,7 @@ static int wcd938x_add_slave_components(struct wcd938x_priv *wcd938x,
>   		return -ENODEV;
>   	}
>   	of_node_get(wcd938x->txnode);
> -	component_match_add_release(dev, matchptr, wcd938x_release_of,
> -				    wcd938x_compare_of,	wcd938x->txnode);
> +	component_match_add_release(dev, matchptr, release_of, compare_of, wcd938x->txnode);
>   	return 0;
>   }
>   
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
