Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923D7C433E6
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 06:34:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610A92067D
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 06:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mBna305Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610A92067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1772A893B3;
	Mon, 13 Jul 2020 06:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mtMCqhKtyjaq; Mon, 13 Jul 2020 06:34:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BCF2D89383;
	Mon, 13 Jul 2020 06:34:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90A1BC0894;
	Mon, 13 Jul 2020 06:34:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D55AC0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 06:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1E86820554
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 06:34:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0RTvkT3wLLAv for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 06:34:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by silver.osuosl.org (Postfix) with ESMTP id F2F51204D1
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 06:34:06 +0000 (UTC)
X-UUID: 9a50178f7b1a490d86b7c429d9e75fb9-20200713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=u1YVFUhNBChKn3hVAOGio4nlm710e7A413UQV7bi/Ys=; 
 b=mBna305ZK72/GAJFpSATHv/bBo7ihIxjO/BiQjY68gvNJjMyTwZaYxhg1gg7hlVcufyTnx4jLrnPx0lG9BafwVyIYu7l2fvDbBUEDf4rb9L86GcJWC68uuLLJfnYS6/aCjNYW28ECjTDwbI3aimpbmD1V4Ze0fkIRSIjMd4NAd4=;
X-UUID: 9a50178f7b1a490d86b7c429d9e75fb9-20200713
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1851266747; Mon, 13 Jul 2020 14:28:53 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 13 Jul 2020 14:28:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jul 2020 14:28:51 +0800
Message-ID: <1594621684.16172.22.camel@mhfsdcap03>
Subject: Re: [PATCH 01/21] dt-binding: memory: mediatek: Add a common
 larb-port header file
From: Yong Wu <yong.wu@mediatek.com>
To: Pi-Hsun Shih <pihsun@chromium.org>
Date: Mon, 13 Jul 2020 14:28:04 +0800
In-Reply-To: <CANdKZ0dwsaP=s8AgRbDx2_0y4JmPnF-X0Rb=4vor2MWCYWfGKw@mail.gmail.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-2-yong.wu@mediatek.com>
 <9e21288c-07da-88b0-2dbb-bd9a2a4d529b@gmail.com>
 <CANdKZ0dwsaP=s8AgRbDx2_0y4JmPnF-X0Rb=4vor2MWCYWfGKw@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B2F7F870170CA2A9C5CE3E2AE2DE382AD28F42E6BD22B1BEE765926AC2E33B272000:8
X-MTK: N
Cc: Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?=
 <youlin.pei@mediatek.com>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 cui.zhang@mediatek.com, srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

On Mon, 2020-07-13 at 13:43 +0800, Pi-Hsun Shih wrote:
> On Mon, Jul 13, 2020 at 2:06 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> >
> >
> >
> > On 11/07/2020 08:48, Yong Wu wrote:
> > > Put all the macros about smi larb/port togethers, this is a preparing
> > > patch for extending LARB_NR and adding new dom-id support.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >   include/dt-bindings/memory/mt2712-larb-port.h  |  2 +-
> > >   include/dt-bindings/memory/mt6779-larb-port.h  |  2 +-
> > >   include/dt-bindings/memory/mt8173-larb-port.h  |  2 +-
> > >   include/dt-bindings/memory/mt8183-larb-port.h  |  2 +-
> > >   include/dt-bindings/memory/mtk-smi-larb-port.h | 15 +++++++++++++++
> > >   5 files changed, 19 insertions(+), 4 deletions(-)
> > >   create mode 100644 include/dt-bindings/memory/mtk-smi-larb-port.h
> > >
> > > ...
> > > diff --git a/include/dt-bindings/memory/mtk-smi-larb-port.h b/include/dt-bindings/memory/mtk-smi-larb-port.h
> > > new file mode 100644
> > > index 000000000000..2ec7fe5ce4e9
> > > --- /dev/null
> > > +++ b/include/dt-bindings/memory/mtk-smi-larb-port.h
> > > @@ -0,0 +1,15 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (c) 2020 MediaTek Inc.
> > > + * Author: Yong Wu <yong.wu@mediatek.com>
> > > + */
> > > +#ifndef __DTS_MTK_IOMMU_PORT_H_
> > > +#define __DTS_MTK_IOMMU_PORT_H_
> > > +
> > > +#define MTK_LARB_NR_MAX                      16
> >
> > include/soc/mediatek/smi.h has the very same define.
> > Should smi.h include this file?
> >
> > Regards,
> > Matthias
> >
> 
> Looks like this is being addressed in patch 5 in this series ([05/21]
> iommu/mediatek: Use the common mtk-smi-larb-port.h)
> That said, should that patch be merged into this one?

At the beginning, I really did like this. But checkpatch will complain
like that:

WARNING:DT_SPLIT_BINDING_PATCH: DT binding docs and includes should be a
separate patch. See:
Documentation/devicetree/bindings/submitting-patches.rst

> 
> 
> 
> > > +
> > > +#define MTK_M4U_ID(larb, port)               (((larb) << 5) | (port))
> > > +#define MTK_M4U_TO_LARB(id)          (((id) >> 5) & 0xf)
> > > +#define MTK_M4U_TO_PORT(id)          ((id) & 0x1f)
> > > +
> > > +#endif
> > >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
