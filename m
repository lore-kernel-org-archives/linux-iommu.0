Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E78BC433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 03:00:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0973961215
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 03:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0973961215
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C87F760719;
	Thu,  7 Oct 2021 03:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xebcfLTdWBTO; Thu,  7 Oct 2021 03:00:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD65360672;
	Thu,  7 Oct 2021 03:00:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86A2EC000F;
	Thu,  7 Oct 2021 03:00:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE6A6C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 03:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9EB1C8405B
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 03:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 866nEO3vPOSO for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 03:00:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EDDC8405E
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 03:00:23 +0000 (UTC)
X-UUID: b042151d92b5446492c6733a6cb81a1e-20211007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=JFzGo/WxNZB+Ws19Df4O4JzpkbbM9zmDRpzU+60snW8=; 
 b=P1WfJPTiCRORPrzv8PKqLG5Bb7JH3+uSwGUZed8BBYmRP8W93XyN9WGWHmPo5PaFC5CphRlOsVxCBMOKwQS4fBuXLdwhumhYPeDUT2rBwI/ypfmGzZP77pAi6yEAgtMCeNhkQ3UfgAP2/BkzOY0OGhKo1w8rENFZwBKCXSJx3mc=;
X-UUID: b042151d92b5446492c6733a6cb81a1e-20211007
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1664456728; Thu, 07 Oct 2021 11:00:18 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 7 Oct 2021 11:00:17 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Oct 2021 11:00:15 +0800
Message-ID: <111c6f3905f4349e6e30cde60bdc70672ee036b3.camel@mediatek.com>
Subject: Re: [PATCH v2 11/29] iommu/mediatek: Always pm_runtime_get while
 tlb flush
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>, Joerg Roedel
 <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>
Date: Thu, 7 Oct 2021 11:00:19 +0800
In-Reply-To: <11fe281d-4873-245b-f506-452900f33d3b@collabora.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
 <20210813065324.29220-12-yong.wu@mediatek.com>
 <11fe281d-4873-245b-f506-452900f33d3b@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, Nicolas
 Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, chao.hao@mediatek.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 2021-09-30 at 13:26 +0200, Dafna Hirschfeld wrote:
> 
> On 13.08.21 08:53, Yong Wu wrote:
> > Prepare for 2 HWs that sharing pgtable in different power-domains.
> > 
> > The previous SoC don't have PM. Only mt8192 has power-domain,
> > and it is display's power-domain which nearly always is enabled.
> 
> hi, I see that in mt1873.dtsi, many devices that uses the iommu have
> the
> 'power-domains' property.

Sorry, I didn't clarify this clear. I mean the iommu device don't have
this property rather than the other device.

> 
> > 
> > When there are 2 M4U HWs, it may has problem.
> > In this function, we get the pm_status via the m4u dev, but it
> > don't
> > reflect the real power-domain status of the HW since there may be
> > other
> > HW also use that power-domain.
> > 
> > Currently we could not get the real power-domain status, thus
> > always
> > pm_runtime_get here.
> > 
> > Prepare for mt8195, thus, no need fix tags here.
> > 
> > This patch may drop the performance, we expect the user could
> > pm_runtime_get_sync before dma_alloc_attrs which need tlb ops.
> > 
> 
> Could you explain this sentence a bit? should the user call
> pm_runtime_get_sync
> before calling dma_alloc_attrs?

In v3, I have removed this patch. Use [1] instead.

[1] 
https://lore.kernel.org/linux-mediatek/20210923115840.17813-13-yong.wu@mediatek.com/

Thanks.

> 
> Thanks,
> Dafna
> 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index add23a36a5e2..abc721a1da21 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -238,8 +238,11 @@ static void
> > mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
> >   
> >   	for_each_m4u(data, head) {
> >   		if (has_pm) {
> > -			if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > +			ret = pm_runtime_resume_and_get(data->dev);
> > +			if (ret < 0) {
> > +				dev_err(data->dev, "tlb flush: pm get
> > fail %d.\n", ret);
> >   				continue;
> > +			}
> >   		}
> >   
> >   		spin_lock_irqsave(&data->tlb_lock, flags);
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
