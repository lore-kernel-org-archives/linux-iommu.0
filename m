Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E6BC433EF
	for <iommu@archiver.kernel.org>; Tue, 11 Jan 2022 10:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43376410E7;
	Tue, 11 Jan 2022 10:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HEjhbXPnYd7R; Tue, 11 Jan 2022 10:57:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 534E9410D6;
	Tue, 11 Jan 2022 10:57:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 074B1C001E;
	Tue, 11 Jan 2022 10:57:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5E98C001E
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 10:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C20A4827B5
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 10:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vF5k7fJv-81g for <iommu@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 10:57:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C2E082779
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 10:57:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id B513E1F43A2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641898667;
 bh=4Xx25dZVWRIgjiwgBQ9ws1efyE6u+X7ng5PxPe/szBo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ls0AeaeadBnt9vvXShPZvY/2rtLJw8O9jmWta1Lim8DVtI/FPAmpZfHNS0mgvQfkx
 PB2X7xKgZ0LT3C7GE/TPFmBIQWJoBAC9XIQcZPNtS4JRt2NaBXPNAIOMHMPRjVn48e
 wIR4i1/CXZlM0OGuYBbO9oClgZ6bB5sFgSq5fQUvsNXxSDOC3PiMvi30a7Rm+NRWW2
 /KRQ/paz0m2S+BbgLk+W/+DJzSSZ5BAczihjlCiD+glsuGDf6ikWRw9aGio/dmrmpu
 aHK0KVAHsXR4Scjjldt+VGlB+pyFZm0qyxjGEcwaptUtwg45fWbCY/XXaZUKOFreWo
 1JZxisdeAP3Xg==
Subject: Re: [PATCH v9 09/15] drm/mediatek: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-10-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <c7e626f5-5ef9-83de-8b48-fb0252125811@collabora.com>
Date: Tue, 11 Jan 2022 11:57:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112105509.12010-10-yong.wu@mediatek.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, CK Hu <ck.hu@mediatek.com>,
 mingyuan.ma@mediatek.com, linux-media@vger.kernel.org,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 libo.kang@mediatek.com, yi.kuo@mediatek.com,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
 anan.sun@mediatek.com, acourbot@chromium.org, srv_heupstream@mediatek.com,
 yf.wang@mediatek.com, iommu@lists.linux-foundation.org,
 Philipp Zabel <p.zabel@pengutronix.de>, Robin Murphy <robin.murphy@arm.com>
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

Il 12/11/21 11:55, Yong Wu ha scritto:
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the drm device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> CC: CK Hu <ck.hu@mediatek.com>
> CC: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
