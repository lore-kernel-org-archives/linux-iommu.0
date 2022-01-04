Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A376DC433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 15:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A0C94090E;
	Tue,  4 Jan 2022 15:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Snto7Hxz4mKr; Tue,  4 Jan 2022 15:55:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EA915400A8;
	Tue,  4 Jan 2022 15:55:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7209C002F;
	Tue,  4 Jan 2022 15:55:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0246C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A093782890
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wI66L1P2uDFZ for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 15:55:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 071D98278F
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id B35BF1F43596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641311736;
 bh=hboQ0UccWWyk5yTva3vHB8Cda2X22RbuvWrIz+nuRK0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jLTzurliT0qIfOEFzR+9yaEiggyTlVDteq69iaFHhXMe8uFqk2zHh2aulUfvN+eIg
 k7s26VHxvNBid6ge3PydVg4I1l7MhtyaSm8eZ1uzjkbtBEqnOCezKT4mutXdYzJF3p
 yFNOimKCbDeoVsquuTZnUGfe9lyGqArZZWEnYZCnJ91KNTcb0UdMYqG5HLMAiDlu+/
 FtCOevYZYrTp4XiEN2UZ1PVHRu05pijNG5pnJnJpaMu3evgJVo69bhxpCq9HN9yMUk
 duT1HwvMYclEr7TQ5ysvYIyKT9/jPSMeYFIw6xkpCNiITpRXV/WIMzVvC1q2d7OvqC
 psbjEotdH+jlw==
Subject: Re: [PATCH v3 14/33] iommu/mediatek: Always enable output PA over
 32bits in isr
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-15-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <ea6a6cf3-9215-f7f9-d049-afaa3f58a7cd@collabora.com>
Date: Tue, 4 Jan 2022 16:55:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-15-yong.wu@mediatek.com>
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
> Currently the output PA[32:33] is contained by the flag IOVA_34.
> This is not right. the iova_34 has no relation with pa[32:33], the 32bits
> iova still could map to pa[32:33]. Move it out from the flag.
> 
> No need fix tag since currently only mt8192 use the calulation and it
> always has this IOVA_34 flag.
> 
> Prepare for the IOMMU that still use IOVA 32bits but its dram size may be
> over 4GB.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
