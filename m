Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F375CC433EF
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 09:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7373B41499;
	Thu,  2 Jun 2022 09:26:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Uxmslzlr3ZR; Thu,  2 Jun 2022 09:26:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EA80F41497;
	Thu,  2 Jun 2022 09:26:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B80E5C0032;
	Thu,  2 Jun 2022 09:26:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22163C002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 09:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 098D182B81
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 09:26:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vebtv7yPkIS8 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:26:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABF6682B1B
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 09:26:27 +0000 (UTC)
X-UUID: a6acc6b7c4cb4109a56c71315cd17c46-20220602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5, REQID:1e05d194-4848-463e-84bc-860c4bf27875, OB:10,
 L
 OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
 TION:release,TS:45
X-CID-INFO: VERSION:1.1.5, REQID:1e05d194-4848-463e-84bc-860c4bf27875, OB:10,
 LOB
 :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:45
X-CID-META: VersionHash:2a19b09, CLOUDID:b4b3e337-9855-4915-a138-f5705f1f3d02,
 C
 OID:e2b011970263,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,QS:0,BEC:nil
X-UUID: a6acc6b7c4cb4109a56c71315cd17c46-20220602
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 661290087; Thu, 02 Jun 2022 17:26:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 2 Jun 2022 17:26:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jun 2022 17:26:20 +0800
Message-ID: <cf1fa83c5b6e76fe11768d9efc2374a9c45d4ba5.camel@mediatek.com>
Subject: Re: [PATCH 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
To: Macpaul Lin <macpaul.lin@mediatek.com>, Fabien Parent
 <fparent@baylibre.com>
Date: Thu, 2 Jun 2022 17:26:19 +0800
In-Reply-To: <6b6c4cfc-6f20-0eda-4a0d-31d993341ae8@mediatek.com>
References: <20220530180328.845692-1-fparent@baylibre.com>
 <8ac7a6766c635412b408cb5295ddb3da37541140.camel@mediatek.com>
 <59cedd50-4141-e589-11ae-b8d1a017eb46@mediatek.com>
 <6b6c4cfc-6f20-0eda-4a0d-31d993341ae8@mediatek.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, Kidd-KW Chen <Kidd-KW.Chen@mediatek.com>,
 Macross Chen <macross.chen@mediatek.com>, linux-kernel@vger.kernel.org, Bear
 Wang <bear.wang@mediatek.com>, iommu@lists.linux-foundation.org, Rob
 Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Andy Hsieh <Andy.Hsieh@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Pablo Sun <pablo.sun@mediatek.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, 2022-06-02 at 16:42 +0800, Macpaul Lin wrote:
> On 6/2/22 4:27 PM, Macpaul Lin wrote:
> > On 6/2/22 2:18 PM, Yong Wu wrote:
> > > On Mon, 2022-05-30 at 20:03 +0200, Fabien Parent wrote:
> > > > Add IOMMU binding documentation for the MT8365 SoC.
> > > > 
> > > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > > > ---
> > > >   .../bindings/iommu/mediatek,iommu.yaml        |  2 +
> > > >   include/dt-bindings/memory/mt8365-larb-port.h | 96
> > > > +++++++++++++++++++
> > > >   2 files changed, 98 insertions(+)
> > > >   create mode 100644 include/dt-bindings/memory/mt8365-larb-
> > > > port.h
> > > 
> > > [snip...]
> > > 
> > > > +#ifndef _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
> > > > +#define _DT_BINDINGS_MEMORY_MT8365_LARB_PORT_H_
> > > > +
> > > > +#include <dt-bindings/memory/mtk-memory-port.h>
> > > > +
> > > > +#define M4U_LARB0_ID            0
> > > > +#define M4U_LARB1_ID            1
> > > > +#define M4U_LARB2_ID            2
> > > > +#define M4U_LARB3_ID            3
> > > > +#define M4U_LARB4_ID            4
> > > > +#define M4U_LARB5_ID            5
> > > > +#define M4U_LARB6_ID            6
> > > > +#define M4U_LARB7_ID            7
> > > 
> > > Remove these. they are no used, right?
> > 
> > AIOT and customers are using the modules and their related IOMMU
> > modules.
> > DISP0, VENC, VDEC, ISP (CAMSYS), and APU (as far as I know, which
> > should 
> > be VP6?) were all supported.
> 
> Dear Yong,
> How about to replace the following definitions?
> 
> For example, replace
> #define M4U_PORT_DISP_OVL0		MTK_M4U_ID(0, 0)
> to
> #define M4U_PORT_DISP_OVL0              MTK_M4U_ID(M4U_LARB0_ID , 0)

Yes. It is ok.

> 
> > > 
> > > > +
> > > > +/* larb0 */
> > > > +#define M4U_PORT_DISP_OVL0        MTK_M4U_ID(0, 0)
> > > > +#define M4U_PORT_DISP_OVL0_2L    MTK_M4U_ID(0, 1)
> > > 
> > > [...]
> > > 
> > > > 
> > > > +/* larb4 */
> > > > +#define M4U_PORT_APU_READ        MTK_M4U_ID(0, 0)
> > > > +#define M4U_PORT_APU_WRITE        MTK_M4U_ID(0, 1)
> > > 
> > > Please remove these two APU definitions. currently these are not
> > > supported.
> > 
> > Kidd, please help to check if APU use these definitions with Yong.
> > However, I think these are all available to the customers.
> > 
> > Thanks
> > Macpaul Lin
> 
> Thanks
> Macpaul Lin

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
