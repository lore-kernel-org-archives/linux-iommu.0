Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C94FC433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 15:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 159FF60BC1;
	Tue,  4 Jan 2022 15:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zB2k0TT7cmYC; Tue,  4 Jan 2022 15:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EF0460D57;
	Tue,  4 Jan 2022 15:55:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE7D5C002F;
	Tue,  4 Jan 2022 15:55:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77DA6C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 740D360D57
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LPi5WCqEZtVw for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 15:55:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D6A3560BC1
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 7B7DE1F43593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641311743;
 bh=upNEy1clIYcieEGkiHOyHnuE/MQhUsIdtvTzDimiz1s=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=V82sh8VWBO3wAJ+QOR8LOcH9EIWvCTmuyD2qd+snO29gmBATlO2D8yuxJeVR72uCT
 bQl8zAYDqIFzx5ez1wBEjI8COPnUhuLwxc5iox7C4JDh+6Z/Gb3VYkB9PPKiXA9KA7
 l9oGspH0ttOhoGDeMyqWSvDVylcU/mrr9ote+Usp7DKFo4NlYs1nsiDYCoJN8VBW4r
 +DmW5l+zdXInZcJxLb8LT8PHn3xdomfL5cG3Ec5F0lXJVJyw13xiWlSsL1Kse5z3uX
 2ba7tzfCA1MWgaE/RzOEso3yMSEWv6FCi2ilrCn4s8Y3mPZxcU2Yh794u4L4aEBwes
 PpqjD6VlLUNpw==
Subject: Re: [PATCH v3 12/33] iommu/mediatek: Always tlb_flush_all when each
 PM resume
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-13-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <5228acea-3bf4-987a-caaf-11b90aa0beae@collabora.com>
Date: Tue, 4 Jan 2022 16:55:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-13-yong.wu@mediatek.com>
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
> Prepare for 2 HWs that sharing pgtable in different power-domains.
> 
> When there are 2 M4U HWs, it may has problem in the flush_range in which
> we get the pm_status via the m4u dev, BUT that function don't reflect the
> real power-domain status of the HW since there may be other HW also use
> that power-domain.
> 
> The function dma_alloc_attrs help allocate the iommu buffer which
> need the corresponding power domain since tlb flush is needed when
> preparing iova. BUT this function only is for allocating buffer,
> we have no good reason to request the user always call pm_runtime_get
> before calling dma_alloc_xxx. Therefore, we add a tlb_flush_all
> in the pm_runtime_resume to make sure the tlb always is clean.
> 
> Another solution is always call pm_runtime_get in the tlb_flush_range.
> This will trigger pm runtime resume/backup so often when the iommu
> power is not active at some time(means user don't call pm_runtime_get
> before calling dma_alloc_xxx), This may cause the performance drop.
> thus we don't use this.
> 
> In other case, the iommu's power should always be active via device
> link with smi.
> 
> The previous SoC don't have PM except mt8192. the mt8192 IOMMU is display's
> power-domain which nearly always is enabled. thus no need fix tags here.
> Prepare for mt8195.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
