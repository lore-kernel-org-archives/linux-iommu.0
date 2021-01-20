Return-Path: <SRS0=mF+O=GX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED606C433DB
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 07:07:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2711E23158
	for <iommu@archiver.kernel.org>; Wed, 20 Jan 2021 07:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2711E23158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BD9AC8539A;
	Wed, 20 Jan 2021 07:07:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yNT_0I1IlMg1; Wed, 20 Jan 2021 07:07:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1AD798487A;
	Wed, 20 Jan 2021 07:07:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1653C088B;
	Wed, 20 Jan 2021 07:07:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6A36C013A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 07:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D48B38539A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 07:07:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fou4E1JhbDfz for <iommu@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 07:07:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0669E8487A
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 07:07:48 +0000 (UTC)
X-UUID: d215402292c340fd9231e5b15a45cd15-20210120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=7RvTVT3ZhF2//9ut8zBRcTtMoMnQZ6PraRA/7xI7g5A=; 
 b=EEYCvxW9aqWrq22wJ7JO+PtRe/lyQikyI1fboieN/YPKRChX3dQrGzma2TKVjn9eapJFV6/zXeYGV+lKPJ+iAgEbEkwEohRcGWVpg4J59JoHtrgzBiK+2GWuCNayX0Wk5wNO2L2vQ34xp+LEtIh4BuoTSTahVmIq735d9IowrrM=;
X-UUID: d215402292c340fd9231e5b15a45cd15-20210120
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1664373271; Wed, 20 Jan 2021 15:07:30 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 20 Jan 2021 15:07:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Jan 2021 15:07:25 +0800
Message-ID: <1611126445.19055.34.camel@mhfsdcap03>
Subject: Re: [PATCH v5 06/27] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
From: Yong Wu <yong.wu@mediatek.com>
To: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Jan 2021 15:07:25 +0800
In-Reply-To: <CAAFQd5A26tZo3gpsmqbRSa3x7a1KThzt9Jw74jWsqQGrBsabhw@mail.gmail.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-7-yong.wu@mediatek.com>
 <X+L9XpkoII7tw/tX@chromium.org> <1608809713.26323.262.camel@mhfsdcap03>
 <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
 <1610520301.31716.27.camel@mhfsdcap03>
 <CAAFQd5A26tZo3gpsmqbRSa3x7a1KThzt9Jw74jWsqQGrBsabhw@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 357884101786B8D869E28A6933E2F1ED2DF27EB10D840F46773425924AE913FE2000:8
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
 Robin Murphy <robin.murphy@arm.com>, "list@263.net:IOMMU DRIVERS
 <iommu@lists.linux-foundation.org>, Joerg  Roedel <joro@8bytes.org>,
 " <linux-arm-kernel@lists.infradead.org>
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

On Wed, 2021-01-20 at 13:15 +0900, Tomasz Figa wrote:
> On Wed, Jan 13, 2021 at 3:45 PM Yong Wu <yong.wu@mediatek.com> wrote:
> >
> > On Wed, 2021-01-13 at 14:30 +0900, Tomasz Figa wrote:
> > > On Thu, Dec 24, 2020 at 8:35 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > > >
> > > > On Wed, 2020-12-23 at 17:18 +0900, Tomasz Figa wrote:
> > > > > On Wed, Dec 09, 2020 at 04:00:41PM +0800, Yong Wu wrote:
> > > > > > This patch adds decriptions for mt8192 IOMMU and SMI.
> > > > > >
> > > > > > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > > > > > table format. The M4U-SMI HW diagram is as below:
> > > > > >
> > > > > >                           EMI
> > > > > >                            |
> > > > > >                           M4U
> > > > > >                            |
> > > > > >                       ------------
> > > > > >                        SMI Common
> > > > > >                       ------------
> > > > > >                            |
> > > > > >   +-------+------+------+----------------------+-------+
> > > > > >   |       |      |      |       ......         |       |
> > > > > >   |       |      |      |                      |       |
> > > > > > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > > > > > disp0   disp1   mdp    vdec                   IPE      IPE
> > > > > >
> > > > > > All the connections are HW fixed, SW can NOT adjust it.
> > > > > >
> > > > > > mt8192 M4U support 0~16GB iova range. we preassign different engines
> > > > > > into different iova ranges:
> > > > > >
> > > > > > domain-id  module     iova-range                  larbs
> > > > > >    0       disp        0 ~ 4G                      larb0/1
> > > > > >    1       vcodec      4G ~ 8G                     larb4/5/7
> > > > > >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> > > > >
> > > > > Why do we preassign these addresses in DT? Shouldn't it be a user's or
> > > > > integrator's decision to split the 16 GB address range into sub-ranges
> > > > > and define which larbs those sub-ranges are shared with?
> > > >
> > > > The problem is that we can't split the 16GB range with the larb as unit.
> > > > The example is the below ccu0(larb13 port9/10) is a independent
> > > > range(domain), the others ports in larb13 is in another domain.
> > > >
> > > > disp/vcodec/cam/mdp don't have special iova requirement, they could
> > > > access any range. vcodec also can locate 8G~12G. it don't care about
> > > > where its iova locate. here I preassign like this following with our
> > > > internal project setting.
> > >
> > > Let me try to understand this a bit more. Given the split you're
> > > proposing, is there actually any isolation enforced between particular
> > > domains? For example, if I program vcodec to with a DMA address from
> > > the 0-4G range, would the IOMMU actually generate a fault, even if
> > > disp had some memory mapped at that address?
> >
> > In this case. we will get fault in current SW setting.
> >
> 
> Okay, thanks.
> 
> > >
> > > >
> > > > Why set this in DT?, this is only for simplifying the code. Assume we
> > > > put it in the platform data. We have up to 32 larbs, each larb has up to
> > > > 32 ports, each port may be in different iommu domains. we should have a
> > > > big array for this..however we only use a macro to get the domain in the
> > > > DT method.
> > > >
> > > > When replying this mail, I happen to see there is a "dev->dev_range_map"
> > > > which has "dma-range" information, I think I could use this value to get
> > > > which domain the device belong to. then no need put domid in DT. I will
> > > > test this.
> > >
> > > My feeling is that the only part that needs to be enforced statically
> > > is the reserved IOVA range for CCUs. The other ranges should be
> > > determined dynamically, although I think I need to understand better
> > > how the hardware and your proposed design work to tell what would be
> > > likely the best choice here.
> >
> > I have removed the domid patch in v6. and get the domain id in [27/33]
> > in v6..
> >
> > About the other ranges should be dynamical, the commit message [30/33]
> > of v6 should be helpful. the problem is that we have a bank_sel setting
> > for the iova[32:33]. currently we preassign this value. thus, all the
> > ranges are fixed. If you adjust this setting, you can let vcodec access
> > 0~4G.
> 
> Okay, so it sounds like we effectively have four 4G address spaces and
> we can assign the master devices to them. I guess each of these
> address spaces makes for an IOMMU group.

Yes. Each a address spaces is an IOMMU group.

> 
> It's fine to pre-assign the devices to those groups for now, but it
> definitely shouldn't be hardcoded in DT, because it depends on the use
> case of the device. I'll take a look at v6, but it sounds like it
> should be fine if it doesn't take the address space assignment from DT
> anymore.

Thanks very much for your review.

> 
> >
> > Currently we have no interface to adjust this setting. Suppose we add a
> > new interface for this. It would be something like:
> >
> >    int mtk_smi_larb_config_banksel(struct device *larb, int banksel)
> >
> >    Then, all the MM drivers should call it before the HW works every
> > time, and its implement will be a bit complex since we aren't sure if
> > the larb has power at that time. the important thing is that the MM
> > devices have already not known which larb it connects with as we plan to
> > delete "mediatek,larb" in their dtsi nodes.
> 
> From the practical point of view, it doesn't look like setting this on
> a per-larb basis would make much sense. The reason to switch the
> bank_sel would be to decide which MM devices can share the same
> address space. This is a security aspect, because it effectively
> determines which devices are isolated from each other.
> 
> That said, I agree that for now we can just start with a fixed
> assignment. We can think of the API if there is a need to adjust the
> assignment.

Sorry for here. I forgot a thing here. that interface above still will
not be helpful. If we don't divide the whole 16GB ranges into 4
regions(let all the other ranges be dynamical), It won't work since we
can only adjust bank_sel with the larb as unit. This is a problem. there
are many ports in a larb. Take a example, the address for vcodec read
port is 32bits while the address for vcodec write port is 33bit, then it
will fail since we only have one bank_sel setting for one larb. Thus we
have to use current design.

> 
> >
> >    In current design, the MM device don't need care about it and 4GB
> > range is enough for them.
> >
> 
> Actually, is the current assignment correct?

Oh. In the code (patch [32/33] of v6), I put CCU0/1 in the cam/mdp
region which start at 8G since CCU0/1 is a module of camera.

> 
> domain-id  module     iova-range                  larbs
>    0       disp        0 ~ 4G                      larb0/1
>    1       vcodec      4G ~ 8G                     larb4/5/7
>    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
>    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
>    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> 
> Wouldn't CCU0 and CCU1 conflict with disp? 

About the conflict, I use patch [29/33] of v6 for this. I will reserve
this special iova region when the full domain(0-4G in this example)
initialize.

> Should perhaps disp be assigned 12G ~ 16G instead?

I think no need put it to 12G-16G, In previous SoC, we have only 4GB
ranges for whole MM engines. currently only cam/mdp domain exclude 128M
for CCU. it should be something wrong if this is not enough.

> 
> Best regards,
> Tomasz
> 
> > >
> > > Best regards,
> > > Tomasz
> > >
> > > >
> > > > Thanks.
> > > > >
> > > > > Best regards,
> > > > > Tomasz
> > > > >
> > > > > >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> > > > > >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > > > > >
> > > > > > The iova range for CCU0/1(camera control unit) is HW requirement.
> > > > > >
> > > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > ---
> > > > > >  .../bindings/iommu/mediatek,iommu.yaml        |  18 +-
> > > > > >  include/dt-bindings/memory/mt8192-larb-port.h | 240 ++++++++++++++++++
> > > > > >  2 files changed, 257 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> > > > > >
> > > > [snip]
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
