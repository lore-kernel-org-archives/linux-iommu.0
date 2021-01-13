Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDF0C433E0
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 05:30:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EF823133
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 05:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EF823133
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 56E1F858FC;
	Wed, 13 Jan 2021 05:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Urr9tnkFqFoG; Wed, 13 Jan 2021 05:30:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B5C0F858C6;
	Wed, 13 Jan 2021 05:30:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8A36C0893;
	Wed, 13 Jan 2021 05:30:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50BB8C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 05:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2D84D203F8
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 05:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UokS66aECyG4 for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 05:30:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by silver.osuosl.org (Postfix) with ESMTPS id 77FF8203EE
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 05:30:41 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id ga15so1317240ejb.4
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 21:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3eSHLU0tsnB/8YZodS1JHYyVuvZP1q+Jh72EF+LlqTo=;
 b=kH9y5HDmn14mKPIgiSh0+j61km8jiNYl7Jz2izQAcbV/5id9R9NlXd1WoPfZ4Cqp12
 DC2YZgYFU3CAG0ZYQdxFQiMKzJqP8Q+nkXFfCI9yrpeJDZ6lzD4Ld6GCkOfgQtLnoGLA
 KxDo2CyZ1EsNF43VAwEawZpbStfqt1FOzQm8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3eSHLU0tsnB/8YZodS1JHYyVuvZP1q+Jh72EF+LlqTo=;
 b=ILTET91GaHcyVfZs/HrRBREVBiZckKEU/xqrO6POSc1BGz+wLi/H3yZjHpMyyCrDUt
 WgokhAHamJspDTAj+Qtg5xF9UZGgM9SHkKXDyqW5oMeQNxqMZmkMxqI3c7TwvdCIr23d
 90+5u9oUIh0MSPgJzghcd4lPSaED5L3QCnIZ7yccF7IOPtN+p6vp6GpQ0cXGxe+4n5Xd
 xdoxIUim1tj4xGa6MkIEwlSFPjxQRTY50AAEDHuQoAJHNYvSstbvxxyFgrTQ6o1yMCJY
 Pvko//0SVMDW48ygn4xZIqoPmaMq5DaOIoetIKxOf/yZ+HirNrDQ6u2nwf+CLS8CTQRF
 JbTg==
X-Gm-Message-State: AOAM533+XE9FP8xwhR9sVV8N/atCc1P9yYpSbJ1yBiSxf++I7TOXsf3y
 hl81brPSHAJ0vnva0jER/4H4SHZYbPUTH71V
X-Google-Smtp-Source: ABdhPJxNHnchpBqKxV0UduKwK2bdM+/1wz7iNsmOOcGyR3KJKQT1BS7Y75JWWAimAOvR/IcQS9nbxQ==
X-Received: by 2002:a17:906:b0c2:: with SMTP id
 bk2mr327592ejb.223.1610515839566; 
 Tue, 12 Jan 2021 21:30:39 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com.
 [209.85.128.49])
 by smtp.gmail.com with ESMTPSA id r18sm326504edx.41.2021.01.12.21.30.37
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jan 2021 21:30:38 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id i63so400404wma.4
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 21:30:37 -0800 (PST)
X-Received: by 2002:a7b:c773:: with SMTP id x19mr382042wmk.127.1610515837254; 
 Tue, 12 Jan 2021 21:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-7-yong.wu@mediatek.com>
 <X+L9XpkoII7tw/tX@chromium.org> <1608809713.26323.262.camel@mhfsdcap03>
In-Reply-To: <1608809713.26323.262.camel@mhfsdcap03>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 13 Jan 2021 14:30:24 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
Message-ID: <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/27] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
To: Yong Wu <yong.wu@mediatek.com>
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
 Robin Murphy <robin.murphy@arm.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>
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

On Thu, Dec 24, 2020 at 8:35 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2020-12-23 at 17:18 +0900, Tomasz Figa wrote:
> > On Wed, Dec 09, 2020 at 04:00:41PM +0800, Yong Wu wrote:
> > > This patch adds decriptions for mt8192 IOMMU and SMI.
> > >
> > > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > > table format. The M4U-SMI HW diagram is as below:
> > >
> > >                           EMI
> > >                            |
> > >                           M4U
> > >                            |
> > >                       ------------
> > >                        SMI Common
> > >                       ------------
> > >                            |
> > >   +-------+------+------+----------------------+-------+
> > >   |       |      |      |       ......         |       |
> > >   |       |      |      |                      |       |
> > > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > > disp0   disp1   mdp    vdec                   IPE      IPE
> > >
> > > All the connections are HW fixed, SW can NOT adjust it.
> > >
> > > mt8192 M4U support 0~16GB iova range. we preassign different engines
> > > into different iova ranges:
> > >
> > > domain-id  module     iova-range                  larbs
> > >    0       disp        0 ~ 4G                      larb0/1
> > >    1       vcodec      4G ~ 8G                     larb4/5/7
> > >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> >
> > Why do we preassign these addresses in DT? Shouldn't it be a user's or
> > integrator's decision to split the 16 GB address range into sub-ranges
> > and define which larbs those sub-ranges are shared with?
>
> The problem is that we can't split the 16GB range with the larb as unit.
> The example is the below ccu0(larb13 port9/10) is a independent
> range(domain), the others ports in larb13 is in another domain.
>
> disp/vcodec/cam/mdp don't have special iova requirement, they could
> access any range. vcodec also can locate 8G~12G. it don't care about
> where its iova locate. here I preassign like this following with our
> internal project setting.

Let me try to understand this a bit more. Given the split you're
proposing, is there actually any isolation enforced between particular
domains? For example, if I program vcodec to with a DMA address from
the 0-4G range, would the IOMMU actually generate a fault, even if
disp had some memory mapped at that address?

>
> Why set this in DT?, this is only for simplifying the code. Assume we
> put it in the platform data. We have up to 32 larbs, each larb has up to
> 32 ports, each port may be in different iommu domains. we should have a
> big array for this..however we only use a macro to get the domain in the
> DT method.
>
> When replying this mail, I happen to see there is a "dev->dev_range_map"
> which has "dma-range" information, I think I could use this value to get
> which domain the device belong to. then no need put domid in DT. I will
> test this.

My feeling is that the only part that needs to be enforced statically
is the reserved IOVA range for CCUs. The other ranges should be
determined dynamically, although I think I need to understand better
how the hardware and your proposed design work to tell what would be
likely the best choice here.

Best regards,
Tomasz

>
> Thanks.
> >
> > Best regards,
> > Tomasz
> >
> > >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> > >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > >
> > > The iova range for CCU0/1(camera control unit) is HW requirement.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/iommu/mediatek,iommu.yaml        |  18 +-
> > >  include/dt-bindings/memory/mt8192-larb-port.h | 240 ++++++++++++++++++
> > >  2 files changed, 257 insertions(+), 1 deletion(-)
> > >  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> > >
> [snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
