Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14F3C433F5
	for <iommu@archiver.kernel.org>; Tue, 30 Nov 2021 07:39:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32AEC817AC;
	Tue, 30 Nov 2021 07:39:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WzkC51fA2rKZ; Tue, 30 Nov 2021 07:39:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CFBAB817A9;
	Tue, 30 Nov 2021 07:39:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0218C001C;
	Tue, 30 Nov 2021 07:39:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1D8EC000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 07:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB3B5400D4
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 07:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4_FLwyVnBTZQ for <iommu@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 07:39:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BEC5400BA
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 07:39:38 +0000 (UTC)
X-UUID: 5e34d209e07845409dbf0a369eb1f88d-20211130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=v5F5DipMsGe/EhJ3XkNJOo99cD9se6MaFiuPADUCFXA=; 
 b=Wt0hcqgHxMtmKtTWDC2cPfglu7dEFhsII8AagJ29qZOhveaGYWXKlBS50jY4XivSzjgOjdKLpFEorUIoFuSAYYrQ4dC5tSTwukPQ0LPlr5HNaJ4pU4Xly7DGwH/5tVIrF9Z0hzlNXBMbkeIupebrYdzB0JXiVe6VOkJbktMb5JM=;
X-UUID: 5e34d209e07845409dbf0a369eb1f88d-20211130
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1413280488; Tue, 30 Nov 2021 15:39:31 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 30 Nov 2021 15:39:29 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Nov 2021 15:39:28 +0800
Message-ID: <128eb1874127b2b9b42a7419e26090d1d192666f.camel@mediatek.com>
Subject: Re: [PATCH v3 12/33] iommu/mediatek: Always tlb_flush_all when each
 PM resume
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Date: Tue, 30 Nov 2021 15:39:27 +0800
In-Reply-To: <c5ded58b-a53a-3089-f8a5-c264f8ab9463@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-13-yong.wu@mediatek.com>
 <c4be1a14-c257-81b7-4a2b-f7e68c32de88@collabora.com>
 <5c4dd67ae7c81721d8cfd2c3b23b7c6df493cb5a.camel@mediatek.com>
 <4dd4cf8d-0f52-afae-f7d9-8e3cfdf3b729@collabora.com>
 <c69e03b4781dd9014393e0ff47767c58c846a722.camel@mediatek.com>
 <c5ded58b-a53a-3089-f8a5-c264f8ab9463@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, sebastian.reichel@collabora.com,
 yen-chang.chen@mediatek.com, Fabien Parent <fparent@baylibre.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, yf.wang@mediatek.com,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Collabora Kernel ML <kernel@collabora.com>, Will
 Deacon <will@kernel.org>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sat, 2021-11-27 at 12:11 +0200, Dafna Hirschfeld wrote:
> 
> On 10.11.21 09:50, Yong Wu wrote:
> > On Wed, 2021-11-10 at 07:29 +0200, Dafna Hirschfeld wrote:
> > > 
> > > On 10.11.21 04:20, Yong Wu wrote:
> > > > On Tue, 2021-11-09 at 14:21 +0200, Dafna Hirschfeld wrote:
> > > > > Hi
> > > > > This patch is needed in order to update the tlb when a device
> > > > > is
> > > > > powered on.
> > > > > Could you send this patch alone without the whole series so
> > > > > it
> > > > > get
> > > > > accepted easier?
> > > > 
> > > > Which SoC are you testing on? In previous SoC, the IOMMU HW
> > > > don't
> > > > have
> > > > power-domain, and we have a "has_pm"[1] in the tlb function for
> > > > that
> > > > case. The "has_pm" should be always 0 for the previous SoC like
> > > > mt8173,
> > > > it should always tlb synchronize.
> > > > 
> > > > thus, Could you help share more about your issue? In which case
> > > > it
> > > > lack
> > > > the necessary tlb operation. At least, We need confirm if it
> > > > needs
> > > > a
> > > > "Fixes" tags if sending this patch alone.
> > > 
> > > Hi,
> > > I work with the mtk-vcodec driver on mt8173. As you wrote, the
> > > iommu
> > > doesn't
> > > have a power-domain and so when allocating buffers before the
> > > device
> > > is powered
> > > on, there is the warning
> > > "Partial TLB flush timed out, falling back to full flush"
> > > flooding the log buf.
> > 
> > oh. Thanks very much for your information. Get it now.
> > 
> > This issue should be introduced by the:
> > 
> > b34ea31fe013 ("iommu/mediatek: Always enable the clk on resume")
> 
> Hi, reverting this commit didn't solve those warnings,
> I think this is because in the function mtk_iommu_attach_device
> the first call to pm_runtime_resume_and_get does not turn the clks on
> since m4u_dom is not yet initialize. And then mtk_iommu_attach_device
> calls pm_runtime_put right after mtk_iommu_hw_init is called
> (where the clks are turned on)

oh. Right. this is also related with the patch of "Add power-domain
operation".

The current problem is that there is a redundant log of "Partial TLB
flush timed out" in mt8173. We need fix this issue firstly. Are you
going to prepare the patches again? If not, I could help this. You
could help confirm them if you are free.

Thanks.

> 
> thanks,
> Dafna
> 
> 
> > 
> > tlb failed due to the bclk is not enabled. Could you help try that
> > after reverting this?
> > 
> > > 
> > > Sebastian Reichel suggested to remove the 'if(has_pm)' check to
> > > avoid
> > > this warning,
> > > and avoid flushing the tlb if the device is off:
> > > 
> > > [1] http://ix.io/3Eyr
> > > 
> > > This fixes the warning, but then the tlb is not flushed in sync,
> > > Therefore the tlb should be flushed when the device is resumed.
> > > 
> > > So the two patches (the one suggested in the link [1] and this
> > > patch)
> > > should be sent together as a 2-patch series.
> > 
> > then this is reasonable. You could help this into a new patchset if
> > you
> > are free(add Fixes tag).
> > 
> > Thanks.
> > 
> > > 
> > > Thanks,
> > > Dafna
> > > 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
