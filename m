Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7854FC433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 05:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A42F415A7;
	Wed, 16 Feb 2022 05:55:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zXiB5fNtwy5Y; Wed, 16 Feb 2022 05:55:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 033CE415A1;
	Wed, 16 Feb 2022 05:55:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3D6BC001A;
	Wed, 16 Feb 2022 05:55:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF2B4C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 05:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1CD940154
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 05:55:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k5jXsnEJOXQa for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 05:55:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6DCA4010E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 05:55:06 +0000 (UTC)
X-UUID: c07bc4593c3b447483f06278c4671c7e-20220216
X-UUID: c07bc4593c3b447483f06278c4671c7e-20220216
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 138608058; Wed, 16 Feb 2022 13:55:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 16 Feb 2022 13:55:01 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 13:54:59 +0800
Message-ID: <d9637b40196873f392ac9cebfe369106a6f0eee7.camel@mediatek.com>
Subject: Re: [PATCH v4 08/35] iommu/mediatek: Use kmalloc for protect buffer
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Wed, 16 Feb 2022 13:54:59 +0800
In-Reply-To: <ca47becf-adc9-f11e-5e59-03f203920344@collabora.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
 <20220125085634.17972-9-yong.wu@mediatek.com>
 <ca47becf-adc9-f11e-5e59-03f203920344@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: yf.wang@mediatek.com, yen-chang.chen@mediatek.com,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 xueqi.zhang@mediatek.com, mingyuan.ma@mediatek.com, devicetree@vger.kernel.org,
 chengci.xu@mediatek.com, libo.kang@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org,
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

On Thu, 2022-01-27 at 12:08 +0100, AngeloGioacchino Del Regno wrote:
> Il 25/01/22 09:56, Yong Wu ha scritto:
> > No need zero for the protect buffer that is only accessed by the
> > IOMMU HW
> > translation fault happened.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> 
> I would rather keep this a devm_kzalloc instead... the cost is very
> minimal and
> this will be handy when new hardware will be introduced, as it may
> require a bigger
> buffer: in that case, "older" platforms will use only part of it and
> we may get
> garbage data at the end.

Currently this is to avoid zero 512 bytes for all the platforms.

Sorry, I don't understand why it is unnecessary when the new hardware
requires a bigger buffer. If the buffer becomes bigger, then clearing
it to 0 need more cost. then this patch is more helpful?

The content in this buffer is garbage, we won't care about or analyse
it.

> 
> Regards,
> Angelo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
