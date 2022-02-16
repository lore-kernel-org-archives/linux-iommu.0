Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5793C433FE
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 08:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E31141615;
	Wed, 16 Feb 2022 08:11:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5gP9Cl5TG0l; Wed, 16 Feb 2022 08:11:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E0FA41604;
	Wed, 16 Feb 2022 08:11:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 231D5C0011;
	Wed, 16 Feb 2022 08:11:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4C5AC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 08:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A268460AE6
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 08:11:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id udobumXoGFjL for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:11:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0A2F60AA0
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 08:11:51 +0000 (UTC)
X-UUID: a6b76a8b6fc2411d975007c926b4c662-20220216
X-UUID: a6b76a8b6fc2411d975007c926b4c662-20220216
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 328284359; Wed, 16 Feb 2022 16:11:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Wed, 16 Feb 2022 16:11:43 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 16:11:42 +0800
Message-ID: <75a08f8d97e112f6c584f7b62934aa178eca8bc4.camel@mediatek.com>
Subject: Re: [PATCH v4 08/35] iommu/mediatek: Use kmalloc for protect buffer
To: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 16 Feb 2022 16:11:42 +0800
In-Reply-To: <CAAFQd5Cqg2xPwtzcom_EZ1tw1tOBsND_i1YAQCO4kF=+eWePBQ@mail.gmail.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
 <20220125085634.17972-9-yong.wu@mediatek.com>
 <ca47becf-adc9-f11e-5e59-03f203920344@collabora.com>
 <d9637b40196873f392ac9cebfe369106a6f0eee7.camel@mediatek.com>
 <CAAFQd5Cqg2xPwtzcom_EZ1tw1tOBsND_i1YAQCO4kF=+eWePBQ@mail.gmail.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: yf.wang@mediatek.com, yen-chang.chen@mediatek.com, Will
 Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 xueqi.zhang@mediatek.com, mingyuan.ma@mediatek.com, devicetree@vger.kernel.org,
 chengci.xu@mediatek.com, libo.kang@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, 2022-02-16 at 14:59 +0900, Tomasz Figa wrote:
> On Wed, Feb 16, 2022 at 2:55 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > 
> > On Thu, 2022-01-27 at 12:08 +0100, AngeloGioacchino Del Regno
> > wrote:
> > > Il 25/01/22 09:56, Yong Wu ha scritto:
> > > > No need zero for the protect buffer that is only accessed by
> > > > the
> > > > IOMMU HW
> > > > translation fault happened.
> > > > 
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > 
> > > I would rather keep this a devm_kzalloc instead... the cost is
> > > very
> > > minimal and
> > > this will be handy when new hardware will be introduced, as it
> > > may
> > > require a bigger
> > > buffer: in that case, "older" platforms will use only part of it
> > > and
> > > we may get
> > > garbage data at the end.
> > 
> > Currently this is to avoid zero 512 bytes for all the platforms.
> > 
> > Sorry, I don't understand why it is unnecessary when the new
> > hardware
> > requires a bigger buffer. If the buffer becomes bigger, then
> > clearing
> > it to 0 need more cost. then this patch is more helpful?
> > 
> > The content in this buffer is garbage, we won't care about or
> > analyse
> > it.
> 
> I think we should zero it for security reasons regardless of any
> other
> aspects. With this patch it's leaking kernel data to the hardware.
> 
> At the same time, we're talking here about something executed just 1
> time when the driver probes. I don't think the cost would really
> matter.

OK. I will remove this patch in next version.

Thanks.

> 
> Best regards,
> Tomasz
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
