Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A996DC433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 16:33:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A4A6142A
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 16:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38A4A6142A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1E2D60E6D;
	Wed, 29 Sep 2021 16:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tCFcd3jbtRI; Wed, 29 Sep 2021 16:33:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E8FE060E8F;
	Wed, 29 Sep 2021 16:33:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A75BAC000F;
	Wed, 29 Sep 2021 16:33:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CFB9C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD1A460E8F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:33:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fR7MswXGzbd for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 16:33:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE9EC60E6D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 16:33:11 +0000 (UTC)
Received: from [IPv6:2a02:810a:880:f54:fd5c:7cb1:aaa8:78b1] (unknown
 [IPv6:2a02:810a:880:f54:fd5c:7cb1:aaa8:78b1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3A3C31F4473B;
 Wed, 29 Sep 2021 17:33:08 +0100 (BST)
Subject: Re: [PATCH v8 03/12] iommu/mediatek: Add probe_defer for smi-larb
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20210929013719.25120-1-yong.wu@mediatek.com>
 <20210929013719.25120-4-yong.wu@mediatek.com>
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <33a8b313-ad1b-d307-7e8c-2fdebdc6f1a7@collabora.com>
Date: Wed, 29 Sep 2021 18:33:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929013719.25120-4-yong.wu@mediatek.com>
Content-Language: en-US
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, anthony.huang@mediatek.com,
 youlin.pei@mediatek.com, Evan Green <evgreen@chromium.org>,
 Eizan Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Frank Wunderlich <frank-w@public-files.de>, yi.kuo@mediatek.com,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 anan.sun@mediatek.com, srv_heupstream@mediatek.com, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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



On 29.09.21 03:37, Yong Wu wrote:
> Prepare for adding device_link.
> 
> The iommu consumer should use device_link to connect with the
> smi-larb(supplier). then the smi-larb should run before the iommu
> consumer. Here we delay the iommu driver until the smi driver is ready,
> then all the iommu consumers always are after the smi driver.
> 
> When there is no this patch, if some consumer drivers run before
> smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
> device_link_add, then device_links_driver_bound will use WARN_ON
> to complain that the link_status of supplier is not right.
> 
> device_is_bound may be more elegant here. but it is not allowed to
> EXPORT from https://lore.kernel.org/patchwork/patch/1334670/.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623
> ---
>   drivers/iommu/mtk_iommu.c    | 2 +-
>   drivers/iommu/mtk_iommu_v1.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index d837adfd1da5..d5848f78a677 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -844,7 +844,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   			id = i;
>   
>   		plarbdev = of_find_device_by_node(larbnode);
> -		if (!plarbdev) {
> +		if (!plarbdev || !plarbdev->dev.driver) {
>   			of_node_put(larbnode);
>   			return -EPROBE_DEFER;

if plarbdev is null doesn't that mean that the device does not exist?
so we should return -ENODEV in that case?

thanks,
Dafna

>   		}
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 1467ba1e4417..4d7809432239 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -602,7 +602,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   		}
>   
>   		plarbdev = of_find_device_by_node(larbnode);
> -		if (!plarbdev) {
> +		if (!plarbdev || !plarbdev->dev.driver) {
>   			of_node_put(larbnode);
>   			return -EPROBE_DEFER;
>   		}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
