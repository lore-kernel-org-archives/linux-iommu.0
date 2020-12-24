Return-Path: <SRS0=QH76=F4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E20C433DB
	for <iommu@archiver.kernel.org>; Thu, 24 Dec 2020 11:35:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93082168B
	for <iommu@archiver.kernel.org>; Thu, 24 Dec 2020 11:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93082168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6FEE387363;
	Thu, 24 Dec 2020 11:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vo9+V-YegDQn; Thu, 24 Dec 2020 11:35:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D05CD871D4;
	Thu, 24 Dec 2020 11:35:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A696EC1787;
	Thu, 24 Dec 2020 11:35:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2062FC0893
 for <iommu@lists.linux-foundation.org>; Thu, 24 Dec 2020 11:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0BAEB861F1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Dec 2020 11:35:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V4m3fsRbfDcU for <iommu@lists.linux-foundation.org>;
 Thu, 24 Dec 2020 11:35:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 300B0855CE
 for <iommu@lists.linux-foundation.org>; Thu, 24 Dec 2020 11:35:20 +0000 (UTC)
X-UUID: d2f4bc1ac7aa4538af11bd7268bde150-20201224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=SB6oEobDBkSXNK3qQS8llstfz4w4FiszNJyh08p/o70=; 
 b=b4ubeLixjdrOVZuT5ZP0vIQ+pKXyOF/DCoIMil/U8zWo0KD9xDHoaI69tcmsot1NWH6xYsOP5U1e5y6VBnR8wluf0t9VZeIAuDYdiKggZjoJDwWczYan4YWx2jCs+HDYjGm3xPHRANmFZG39+MynBrQiLkLAoPHlandlRIH57tY=;
X-UUID: d2f4bc1ac7aa4538af11bd7268bde150-20201224
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 458351113; Thu, 24 Dec 2020 19:35:14 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 24 Dec 2020 19:35:12 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Dec 2020 19:35:12 +0800
Message-ID: <1608809713.26323.262.camel@mhfsdcap03>
Subject: Re: [PATCH v5 06/27] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
From: Yong Wu <yong.wu@mediatek.com>
To: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 24 Dec 2020 19:35:13 +0800
In-Reply-To: <X+L9XpkoII7tw/tX@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-7-yong.wu@mediatek.com>
 <X+L9XpkoII7tw/tX@chromium.org>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 43E145A43742A33FB0F432294A8D8B05C5B400A4B9E3095EC85B6369A76296B42000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, 2020-12-23 at 17:18 +0900, Tomasz Figa wrote:
> On Wed, Dec 09, 2020 at 04:00:41PM +0800, Yong Wu wrote:
> > This patch adds decriptions for mt8192 IOMMU and SMI.
> > 
> > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > table format. The M4U-SMI HW diagram is as below:
> > 
> >                           EMI
> >                            |
> >                           M4U
> >                            |
> >                       ------------
> >                        SMI Common
> >                       ------------
> >                            |
> >   +-------+------+------+----------------------+-------+
> >   |       |      |      |       ......         |       |
> >   |       |      |      |                      |       |
> > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > disp0   disp1   mdp    vdec                   IPE      IPE
> > 
> > All the connections are HW fixed, SW can NOT adjust it.
> > 
> > mt8192 M4U support 0~16GB iova range. we preassign different engines
> > into different iova ranges:
> > 
> > domain-id  module     iova-range                  larbs
> >    0       disp        0 ~ 4G                      larb0/1
> >    1       vcodec      4G ~ 8G                     larb4/5/7
> >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> 
> Why do we preassign these addresses in DT? Shouldn't it be a user's or
> integrator's decision to split the 16 GB address range into sub-ranges
> and define which larbs those sub-ranges are shared with?

The problem is that we can't split the 16GB range with the larb as unit.
The example is the below ccu0(larb13 port9/10) is a independent
range(domain), the others ports in larb13 is in another domain.

disp/vcodec/cam/mdp don't have special iova requirement, they could
access any range. vcodec also can locate 8G~12G. it don't care about
where its iova locate. here I preassign like this following with our
internal project setting.

Why set this in DT?, this is only for simplifying the code. Assume we
put it in the platform data. We have up to 32 larbs, each larb has up to
32 ports, each port may be in different iommu domains. we should have a
big array for this..however we only use a macro to get the domain in the
DT method.

When replying this mail, I happen to see there is a "dev->dev_range_map"
which has "dma-range" information, I think I could use this value to get
which domain the device belong to. then no need put domid in DT. I will
test this.

Thanks.
> 
> Best regards,
> Tomasz
> 
> >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > 
> > The iova range for CCU0/1(camera control unit) is HW requirement.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/iommu/mediatek,iommu.yaml        |  18 +-
> >  include/dt-bindings/memory/mt8192-larb-port.h | 240 ++++++++++++++++++
> >  2 files changed, 257 insertions(+), 1 deletion(-)
> >  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> > 
[snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
