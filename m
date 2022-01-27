Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B79C433F5
	for <iommu@archiver.kernel.org>; Thu, 27 Jan 2022 11:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99A3A610A4;
	Thu, 27 Jan 2022 11:25:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jh-aEYfQq7Eh; Thu, 27 Jan 2022 11:25:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 971F2610A3;
	Thu, 27 Jan 2022 11:25:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F5BCC001A;
	Thu, 27 Jan 2022 11:25:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DA64C000B
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:25:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DD8D610A3
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:25:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bm4_8ppEHNP0 for <iommu@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 11:25:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5136F60EFD
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:25:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id AEB611F450C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1643282705;
 bh=tb/UqL1WfiQAsAVHo/IniIBGl5T6FOXpUra+9byZHPc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=dft+9zu4GosFe6lxR39lR/MXp7jg3zPW2DtXn/dflw38u9vvZM78dQ5jY/0A017oD
 RFlQ6Z7xd/ozv/Z3skQN1bh2hlysrSmcb3/msYFmCeOEiCPHVxTB4zLUNx2QRzULhI
 AhMoRQg1muZEhghItNzPsFD/q6UnAiwLQbL+Fa/ldy5D+CukNzsMzJaFNIFkFiIGpA
 3ue0MYIHoRdRnvf8heLxYDBw3jTLQ2DwJUANSEe4ZJ3XCFcAq22UiA2/E8B04nKG+y
 0vQIWR9DZP+Sid58n5T4ROvgxpDuZS/oWmuRskX/YeIWPMZ+cDrODepj59j+Uz0A8y
 xg1rgB2f5TO+A==
Subject: Re: [PATCH v4 35/35] iommu/mediatek: mt8195: Enable multi banks for
 infra iommu
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
 <20220125085634.17972-36-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <35ddad90-a13b-0370-a218-87887f47c0da@collabora.com>
Date: Thu, 27 Jan 2022 12:25:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-36-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
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

Il 25/01/22 09:56, Yong Wu ha scritto:
> Enable the multi-bank functions for infra-iommu. We put PCIE in bank0
> and USB in the last bank(bank4). and we don't use the other banks
> currently, disable them.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
