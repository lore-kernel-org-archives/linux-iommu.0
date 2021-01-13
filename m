Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89638C433E0
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 06:45:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BF323125
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 06:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BF323125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4FACA8715D;
	Wed, 13 Jan 2021 06:45:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u88HRq89BBiw; Wed, 13 Jan 2021 06:45:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 76DBC87153;
	Wed, 13 Jan 2021 06:45:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11CCBC088B;
	Wed, 13 Jan 2021 06:45:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2226C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 06:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B5C48857EB
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 06:45:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FdiqDqHBHYLd for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 06:45:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by whitealder.osuosl.org (Postfix) with ESMTP id 17B8C857CB
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 06:45:25 +0000 (UTC)
X-UUID: 580253d790c849719131d94f76d9bc20-20210113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=XzZvJXXejeb6vuCxcQ/ZYBYhWXSlgg5if1eYN0e4A+w=; 
 b=W1hGBIY9oFs+oXLjHCMyj9x0racvFR3UFoVUPfnJ32ySrSytxdGEJ0eJAuVffdCXVDMfqXspnKRCfwNprzUUcA83Igbkurt1VrdjddFgB8lItVVDRMLEItaaZ6+RBA+tpKxOxnC6hSi1Nh6UYM63quc3na95mn5uZuwpjJcOHJs=;
X-UUID: 580253d790c849719131d94f76d9bc20-20210113
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1159364968; Wed, 13 Jan 2021 14:45:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 13 Jan 2021 14:45:02 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jan 2021 14:45:01 +0800
Message-ID: <1610520301.31716.27.camel@mhfsdcap03>
Subject: Re: [PATCH v5 06/27] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
From: Yong Wu <yong.wu@mediatek.com>
To: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 13 Jan 2021 14:45:01 +0800
In-Reply-To: <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-7-yong.wu@mediatek.com>
 <X+L9XpkoII7tw/tX@chromium.org> <1608809713.26323.262.camel@mhfsdcap03>
 <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F266EF73A8C9243F1CE89A1C9FC11853CFFC4FF9CB30643997D3F962D9E21E3A2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, linux-devicetree <devicetree@vger.kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
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

On Wed, 2021-01-13 at 14:30 +0900, Tomasz Figa wrote:
> On Thu, Dec 24, 2020 at 8:35 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > On Wed, 2020-12-23 at 17:18 +0900, Tomasz Figa wrote:
> > > On Wed, Dec 09, 2020 at 04:00:41PM +0800, Yong Wu wrote:
> > > > This patch adds decriptions for mt8192 IOMMU and SMI.
> > > >
> > > > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > > > table format. The M4U-SMI HW diagram is as below:
> > > >
> > > >                           EMI
> > > >                            |
> > > >                           M4U
> > > >                            |
> > > >                       ------------
> > > >                        SMI Common
> > > >                       ------------
> > > >                            |
> > > >   +-------+------+------+----------------------+-------+
> > > >   |       |      |      |       ......         |       |
> > > >   |       |      |      |                      |       |
> > > > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > > > disp0   disp1   mdp    vdec                   IPE      IPE
> > > >
> > > > All the connections are HW fixed, SW can NOT adjust it.
> > > >
> > > > mt8192 M4U support 0~16GB iova range. we preassign different engines
> > > > into different iova ranges:
> > > >
> > > > domain-id  module     iova-range                  larbs
> > > >    0       disp        0 ~ 4G                      larb0/1
> > > >    1       vcodec      4G ~ 8G                     larb4/5/7
> > > >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> > >
> > > Why do we preassign these addresses in DT? Shouldn't it be a user's or
> > > integrator's decision to split the 16 GB address range into sub-ranges
> > > and define which larbs those sub-ranges are shared with?
> >
> > The problem is that we can't split the 16GB range with the larb as unit.
> > The example is the below ccu0(larb13 port9/10) is a independent
> > range(domain), the others ports in larb13 is in another domain.
> >
> > disp/vcodec/cam/mdp don't have special iova requirement, they could
> > access any range. vcodec also can locate 8G~12G. it don't care about
> > where its iova locate. here I preassign like this following with our
> > internal project setting.
> 
> Let me try to understand this a bit more. Given the split you're
> proposing, is there actually any isolation enforced between particular
> domains? For example, if I program vcodec to with a DMA address from
> the 0-4G range, would the IOMMU actually generate a fault, even if
> disp had some memory mapped at that address?

In this case. we will get fault in current SW setting.

> 
> >
> > Why set this in DT?, this is only for simplifying the code. Assume we
> > put it in the platform data. We have up to 32 larbs, each larb has up to
> > 32 ports, each port may be in different iommu domains. we should have a
> > big array for this..however we only use a macro to get the domain in the
> > DT method.
> >
> > When replying this mail, I happen to see there is a "dev->dev_range_map"
> > which has "dma-range" information, I think I could use this value to get
> > which domain the device belong to. then no need put domid in DT. I will
> > test this.
> 
> My feeling is that the only part that needs to be enforced statically
> is the reserved IOVA range for CCUs. The other ranges should be
> determined dynamically, although I think I need to understand better
> how the hardware and your proposed design work to tell what would be
> likely the best choice here.

I have removed the domid patch in v6. and get the domain id in [27/33]
in v6..

About the other ranges should be dynamical, the commit message [30/33]
of v6 should be helpful. the problem is that we have a bank_sel setting
for the iova[32:33]. currently we preassign this value. thus, all the
ranges are fixed. If you adjust this setting, you can let vcodec access
0~4G.

Currently we have no interface to adjust this setting. Suppose we add a
new interface for this. It would be something like:

   int mtk_smi_larb_config_banksel(struct device *larb, int banksel)
  
   Then, all the MM drivers should call it before the HW works every
time, and its implement will be a bit complex since we aren't sure if
the larb has power at that time. the important thing is that the MM
devices have already not known which larb it connects with as we plan to
delete "mediatek,larb" in their dtsi nodes.

   In current design, the MM device don't need care about it and 4GB
range is enough for them.

> 
> Best regards,
> Tomasz
> 
> >
> > Thanks.
> > >
> > > Best regards,
> > > Tomasz
> > >
> > > >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> > > >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > > >
> > > > The iova range for CCU0/1(camera control unit) is HW requirement.
> > > >
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../bindings/iommu/mediatek,iommu.yaml        |  18 +-
> > > >  include/dt-bindings/memory/mt8192-larb-port.h | 240 ++++++++++++++++++
> > > >  2 files changed, 257 insertions(+), 1 deletion(-)
> > > >  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> > > >
> > [snip]

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
