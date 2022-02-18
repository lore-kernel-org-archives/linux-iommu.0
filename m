Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C04C433F5
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 12:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04CC240BEA;
	Fri, 18 Feb 2022 12:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wtVPlH7DiQym; Fri, 18 Feb 2022 12:52:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A4751405CB;
	Fri, 18 Feb 2022 12:52:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87FCBC0021;
	Fri, 18 Feb 2022 12:52:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B51C2C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1773611A3
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pif_dfObLz5x for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 12:52:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B5096119D
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 8FB211F46910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1645188761;
 bh=7bVmllsSdo+zEWIfNE+5yNbesylSATeKRH84GE8XJgE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=n0/DAjtxFTgTEf0bWouyCh2A3lkCBOWFQdTJkWoafSl7oIAzgiSpDM8Jr3N3wPkpm
 cvjyL/C3QpVE4cCm/sJxaDj6tmLopwNOwhbrdFqXoNTEpH9dr3HSXXmA/ObhAPbRFX
 7bJNy0HqO2YA8CNEPXZW/NEyC36qqgt4vv9BzZzlvGbs/rfNRYIvGGnSZ/4Mcw82RE
 EZQDW9ihRPTketCFdo2fwNRfDI0SnamcobthmwBNzgRLs8YrbrYfpcdOOQu9vmfl8f
 3oCCmpoalIvSYmyADkRseoS0jgMPZc73OtTahhJavj6RRGmG/zWy7GlnJJ2s1Gew3L
 /8tDPN2MnzCwA==
Message-ID: <d138f7b9-bfa1-8628-5c5c-aca5c9af48a6@collabora.com>
Date: Fri, 18 Feb 2022 13:52:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 32/34] iommu/mediatek: Initialise/Remove for multi bank
 dev
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <20220217113453.13658-33-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217113453.13658-33-yong.wu@mediatek.com>
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
> The registers for each bank of the IOMMU base are in order, delta is
> 0x1000. Initialise the base for each bank.
> 
> For all the previous SoC, we only have bank0. thus use "do {} while()"
> to allow bank0 always go.
> 
> When removing the device, Not always all the banks are initialised, it
> depend on if there is masters for that bank.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
