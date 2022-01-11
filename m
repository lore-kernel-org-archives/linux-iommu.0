Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D22C4167B
	for <iommu@archiver.kernel.org>; Tue, 11 Jan 2022 10:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6905A60D6B;
	Tue, 11 Jan 2022 10:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U1FsL7yNp5NW; Tue, 11 Jan 2022 10:57:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1D6AF60B6B;
	Tue, 11 Jan 2022 10:57:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EB6EC0076;
	Tue, 11 Jan 2022 10:57:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 423BCC001E
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 10:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2151460A7B
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 10:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kfgWQZj7eiTD for <iommu@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 10:57:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 396AD60AA3
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 10:57:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 47C8A1F43A30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641898668;
 bh=z7dhA4q/V4tftc+cZa+nBqU+2vdxSivbhiKy1h+7qtQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RRaYOVQpussaCc+0yRBL6RBG5qsxzVLHCsJN2oZEWUjvH48V2MO743x7hHveXauoF
 +3Nha4N37fz8qj+kkWoc+sjcU3rEDzW3vnYJbVCqfjC1Jv2SI4Q6zDZ/SnkzbZPV5x
 OlxczaXehAvI/3oePC6t5A90g330Z/J5+sFtMLG5VbhN933DtEr9MMwqfhbINiJaCp
 N6cyz5EWmr2G8xsfA7HPK07hnVgeonTE77IrbWGCKc94cmXSnuco7AMQQLVPsnF2Tf
 EMkhNj53mj8kA9OBp4UXrXGHXfz/W1TxYphtIJNijCt/kSZ72W8xMJOeSFAZlb5Wx6
 IgspKKiIJdMzQ==
Subject: Re: [PATCH v9 08/15] drm/mediatek: Add pm runtime support for ovl and
 rdma
To: Yong Wu <yong.wu@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 David Airlie <airlied@linux.ie>, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-9-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <ae5c8350-75c1-b90e-3bad-78c19154d7bd@collabora.com>
Date: Tue, 11 Jan 2022 11:57:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112105509.12010-9-yong.wu@mediatek.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>,
 Yongqiang Niu <yongqiang.niu@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
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
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Prepare for smi cleaning up "mediatek,larb".
> 
> Display use the dispsys device to call pm_rumtime_get_sync before.
> This patch add pm_runtime_xx with ovl and rdma device whose nodes has
> "iommus" property, then display could help pm_runtime_get for smi via
> ovl or rdma device.
> 
> CC: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> (Yong: Use pm_runtime_resume_and_get instead of pm_runtime_get_sync)
> Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
