Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF40BC433FE
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 12:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82374610C5;
	Fri, 18 Feb 2022 12:52:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6cC3QMz9xBU; Fri, 18 Feb 2022 12:52:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7CAE56119D;
	Fri, 18 Feb 2022 12:52:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 579B7C0021;
	Fri, 18 Feb 2022 12:52:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C98FC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 684EE40BEA
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JUdA-OE6cnDP for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 12:52:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CF3840AB7
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id BB9231F46910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1645188755;
 bh=NFXnrBefp/J/5Gr6/ZFXtadzPDXIH73osHYu1ilvrI4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=T9yMUZQcsLCccMxiGNCW3eVpLugQ11wDo+tAUv6bZ4gs0UHcel9POp4VISzkzON0L
 dJOk2+ORvjNaNvEiQiUvatcRJMplsu2pVnHLcqoT356YzirB7LamiXv3jT+qinx5DE
 qnxBS6Z/bjpZ2pxHiHoMteRWww1ZTAof+bjqGBAEr6I/kI2GLQasjNrlykQYeRYnCi
 E6U2DxZQMjVhhP9eg7UsspUKqozH93Kp8d4kgqH/gNsrjSy8RyMDgcC2UO8vo0JrmU
 jolB5zRsIxdgFAIueGs6+FR3sUfVsiVfpF0jNWS9MODY2wYYsPOJs6R58Iw81W/iaY
 v+rmihOeKnUxw==
Message-ID: <325255a5-4ece-bf3d-a994-d19689b49c2d@collabora.com>
Date: Fri, 18 Feb 2022 13:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 26/34] iommu/mediatek: Remove mtk_iommu.h
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <20220217113453.13658-27-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217113453.13658-27-yong.wu@mediatek.com>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org
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

Il 17/02/22 12:34, Yong Wu ha scritto:
> Currently there is only compare_of/release_of/a suspend structure in the
> header file. I think it is no need to keep a header file only for these.
> Move these into the c file and rm this header file.
> 
> I think there should be a common helper for compare_of and release_of.
> There is many copy in drm, it should be another topic.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/iommu/mtk_iommu.c    | 25 ++++++++++++++++++++-
>   drivers/iommu/mtk_iommu.h    | 42 ------------------------------------
>   drivers/iommu/mtk_iommu_v1.c | 21 +++++++++++++++---
>   3 files changed, 42 insertions(+), 46 deletions(-)
>   delete mode 100644 drivers/iommu/mtk_iommu.h
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
