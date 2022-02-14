Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0542C433FE
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 08:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5529460B28;
	Mon, 14 Feb 2022 08:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fm8dE1UwqcgP; Mon, 14 Feb 2022 08:03:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B83C607CA;
	Mon, 14 Feb 2022 08:03:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBBFFC001A;
	Mon, 14 Feb 2022 08:03:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0393C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 08:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FEDF813F9
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 08:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6xcUYd4Io1F4 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:03:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9A6D813A7
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 08:03:14 +0000 (UTC)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <heiko@sntech.de>)
 id 1nJWKA-0006vg-Ok; Mon, 14 Feb 2022 09:03:06 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 13/23] drm/rockchip: Make use of the helper
 component_compare_dev
Date: Mon, 14 Feb 2022 09:03:04 +0100
Message-ID: <3640952.nfqboWGjmy@diego>
In-Reply-To: <20220214060819.7334-14-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
 <20220214060819.7334-14-yong.wu@mediatek.com>
MIME-Version: 1.0
Cc: Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-rockchip@lists.infradead.org, Sandy Huang <hjc@rock-chips.com>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Am Montag, 14. Februar 2022, 07:08:09 CET schrieb Yong Wu:
> Use the common compare helper from component.
> =

> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: "Heiko St=A8=B9bner" <heiko@sntech.de>
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> =

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/dr=
m/rockchip/rockchip_drm_drv.c
> index bec207de4544..3c2f2d6ecc36 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -290,11 +290,6 @@ int rockchip_drm_endpoint_is_subdriver(struct device=
_node *ep)
>  	return false;
>  }
>  =

> -static int compare_dev(struct device *dev, void *data)
> -{
> -	return dev =3D=3D (struct device *)data;
> -}
> -
>  static void rockchip_drm_match_remove(struct device *dev)
>  {
>  	struct device_link *link;
> @@ -321,7 +316,7 @@ static struct component_match *rockchip_drm_match_add=
(struct device *dev)
>  				break;
>  =

>  			device_link_add(dev, d, DL_FLAG_STATELESS);
> -			component_match_add(dev, &match, compare_dev, d);
> +			component_match_add(dev, &match, component_compare_dev, d);
>  		} while (true);
>  	}
>  =

> =





_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
