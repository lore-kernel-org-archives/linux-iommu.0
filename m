Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A74FC433FE
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 12:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BAA1611B4;
	Fri, 18 Feb 2022 12:52:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Or8bIzIcrOwG; Fri, 18 Feb 2022 12:52:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5290D6119D;
	Fri, 18 Feb 2022 12:52:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC3EC0021;
	Fri, 18 Feb 2022 12:52:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39BFDC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27EB6611A7
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sHJYI_VfHlT7 for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 12:52:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1455D610C5
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 284BB1F469B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1645188751;
 bh=yHDbz65IOr6g3ppelLD5Jk+jL9V5d6x0E66r5ToMDm0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k08DZUBBKIVt/8PeW/wF/8J22fbzm3781RPF5QTXz8x3CXocP5/mXRKIzO4QnW5B2
 S4NmCmD7rbrNkwFQfWBmZS0y3PVU14zr9OEy6XVok0x8GGwGxS5wa45X3uqcVdPSaV
 ODPoqGXYiGjccJ0BhbpqB8fhxQNKjMh1qsWeLnn+GwaET4hLQGucbOb/NjNofqMobG
 xXARnFdQ1Zo1qeg3EUqyzUVau4fJcw7TifDm2A4FjacZ2eCOv/l31E6Qtoc/M7s61f
 KNlDmFx1BJdfV+/nvOof1oaNJa5z3+6mecEMB/5crGF2vTuCGAEVFRJKCE5Rls2/Tt
 Yn2KpWDJJfldw==
Message-ID: <b0099ae4-922d-8096-0b6a-ec3595c65b7a@collabora.com>
Date: Fri, 18 Feb 2022 13:52:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 25/34] iommu/mediatek: Separate mtk_iommu_data for v1
 and v2
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <20220217113453.13658-26-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217113453.13658-26-yong.wu@mediatek.com>
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
> Prepare for adding the structure "mtk_iommu_bank_data". No functional
> change. The mtk_iommu_domain in v1 and v2 are different, we could not add
> current data as bank[0] in v1 simplistically.
> 
> Currently we have no plan to add new SoC for v1, in order to avoid affect
> v1 when we add many new features for v2, I totally separate v1 and v2 in
> this patch, there are many structures only for v2.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/iommu/mtk_iommu.c    | 82 +++++++++++++++++++++++++++++++++---
>   drivers/iommu/mtk_iommu.h    | 81 -----------------------------------
>   drivers/iommu/mtk_iommu_v1.c | 29 +++++++++++++
>   3 files changed, 106 insertions(+), 86 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
