Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C551C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 10:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2534A60E2A;
	Mon, 14 Feb 2022 10:03:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7OU5oZ3PxkLm; Mon, 14 Feb 2022 10:03:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1FCB560C09;
	Mon, 14 Feb 2022 10:03:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1591C001A;
	Mon, 14 Feb 2022 10:03:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55280C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 10:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 436354018B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 10:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uymX_MSUUqa9 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 10:03:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from aposti.net (aposti.net [89.234.176.197])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83CFA4016F
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 10:03:17 +0000 (UTC)
Date: Mon, 14 Feb 2022 10:03:01 +0000
From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 06/23] drm/ingenic: Make use of the helper
 component_compare_of
To: Yong Wu <yong.wu@mediatek.com>
Message-Id: <19HA7R.NEIIBC5SNORY1@crapouillou.net>
In-Reply-To: <20220214060819.7334-7-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com>
 <20220214060819.7334-7-yong.wu@mediatek.com>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Sebastian Reichel <sre@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 James Wang <james.qian.wang@arm.com>, linux-mips@vger.kernel.org,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 srv_heupstream@mediatek.com, Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

Le lun., f=E9vr. 14 2022 at 14:08:02 +0800, Yong Wu =

<yong.wu@mediatek.com> a =E9crit :
> Use the common compare helper from component.
> =

> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: linux-mips@vger.kernel.org
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> =

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c =

> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index b4943a56be09..23b8f012b418 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -1322,11 +1322,6 @@ static int =

> ingenic_drm_bind_with_components(struct device *dev)
>  	return ingenic_drm_bind(dev, true);
>  }
> =

> -static int compare_of(struct device *dev, void *data)
> -{
> -	return dev->of_node =3D=3D data;
> -}
> -
>  static void ingenic_drm_unbind(struct device *dev)
>  {
>  	struct ingenic_drm *priv =3D dev_get_drvdata(dev);
> @@ -1360,7 +1355,7 @@ static int ingenic_drm_probe(struct =

> platform_device *pdev)
>  	if (!np)
>  		return ingenic_drm_bind(dev, false);
> =

> -	drm_of_component_match_add(dev, &match, compare_of, np);
> +	drm_of_component_match_add(dev, &match, component_compare_of, np);
>  	of_node_put(np);
> =

>  	return component_master_add_with_match(dev, &ingenic_master_ops, =

> match);
> --
> 2.18.0
> =



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
