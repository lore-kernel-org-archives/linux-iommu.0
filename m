Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE131C433FE
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 15:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D14F40903;
	Mon,  6 Dec 2021 15:00:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BZcr9jIZBnOD; Mon,  6 Dec 2021 15:00:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D268040943;
	Mon,  6 Dec 2021 15:00:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACF1FC001E;
	Mon,  6 Dec 2021 15:00:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E361BC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6CCB40289
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:00:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AV5LrcgeUVhN for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 15:00:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3ECB1400C9
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:00:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 4FBD11F44803
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638802808; bh=GdCGPmly0UuQ6WjSsNws2p+iDG85TsB+eBdXAeJYWKo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=K0fNGcFVKt7O287APEpkAIFNWACJowOJtubES7YzU18wZK9tNnX6ZS0kbADSNKC+Y
 am0NkVRHfnoQTQJlzPZjKnz30qgm4Whf1fMoJ36ZW7tuuwUON8yNfV5KB1fLGF4qLz
 wRT4fRML+iDArFocVdBPGhXWssHAcEDtuY3zEl7XnqGMC9g8Nu3Z34O6qjezjYx2+p
 Jm3G8SkDOksXBYgZgWNmR8ZXro02agCanHvdBQG3jB7N6mGf3ioJSxk1lPrjf/msEu
 rhasgGlGOHR52V1irMnWJcut59XIHV0ggwnbxyB9JXfc+GJvqg6CTW6oYAXy015cKw
 WjK2fAddW3VRw==
Subject: Re: [PATCH 4/4] memory: mtk-smi: mt8186: Add smi support
To: Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-5-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <417ec223-b49a-c8dc-c53a-7831cca4d2d1@collabora.com>
Date: Mon, 6 Dec 2021 16:00:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211203064027.14993-5-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, anthony.huang@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Il 03/12/21 07:40, Yong Wu ha scritto:
> Add mt8186 SMI support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>


Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
