Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFF4C433EF
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 15:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F7EB60BCD;
	Tue,  4 Jan 2022 15:53:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yrXdvrzTh6zi; Tue,  4 Jan 2022 15:53:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B46160D67;
	Tue,  4 Jan 2022 15:53:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E711EC002F;
	Tue,  4 Jan 2022 15:53:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CF21C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9703160D5A
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zzfgCmr7Tl6v for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 15:53:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0EBD460D4B
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:53:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 9B5961F434D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641311615;
 bh=cNd00AijAfU8AatU+tmQmAubCvXlTu/1+TRUQDeo7LM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=g6GxEklG4TK7WDuq2pOGWIgsJtmf/+d2GHHTWjJqo/k62gdnCM4B5DAwJABs1ZseM
 3UtMnPU2JL/kaqN0H1hJzeWHmmhtJnjNXoYoeDuZElLzWXq0IV0ju8o++FA3aGD4Cu
 yolSNexqk4GIrSLDpWPTGrRKBkiY5jz01m1C7Niui2CDC+/Gw5fbi85aRvZX1a/vT+
 FmDN3IHE9S9DO12KsnDSG2iXOrMYPp2LxeSv8WrbusQJBz7B8M46rTpGMs0HZG+YCg
 Qu2XWsKK9QjpzGD+5DrqAbn4pHzY2IJUD6GAKHLEhyN12SyAw30L6D+8F9swCc2R0T
 hOZas5YenRVgg==
Subject: Re: [PATCH v3 29/33] iommu/mediatek: Change the domid to
 iova_region_id
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-30-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <bd0a2a6f-5edc-e036-d82a-81dffe31e293@collabora.com>
Date: Tue, 4 Jan 2022 16:53:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-30-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, yen-chang.chen@mediatek.com,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
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

Il 23/09/21 13:58, Yong Wu ha scritto:
> Prepare for adding bankid, also no functional change.
> 
> In the previous SoC, each a iova_region is a domain; In the multi-banks
> case, each a bank is a domain, then the original function name
> "mtk_iommu_get_domain_id" is not proper. Use "iova_region_id" instead of
> "domain_id".
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
