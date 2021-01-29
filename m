Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0BBC433E6
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 11:45:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C6664E7C
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 11:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C6664E7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC9208716B;
	Fri, 29 Jan 2021 11:45:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SsoXzVP+g3+6; Fri, 29 Jan 2021 11:45:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0B9BB8715E;
	Fri, 29 Jan 2021 11:45:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5EB0C0FA8;
	Fri, 29 Jan 2021 11:45:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D08EC08A1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 11:45:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 27B9F872E6
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 11:45:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w0EsZnpj0uLt for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 11:45:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7DD47872E5
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 11:45:48 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id a10so12528354ejg.10
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ly79g/brjlF90XJZ8f32qw6QQEvN2fFo38sAbG4157w=;
 b=hfD8I+URxWErW2IQNuAWHZBGOr5YTPKlcet18G24LKXu+YDiYELIIynQR0B3LOYp7J
 d0S2KNdT3O0Ibut5msXHDYERh5fHIK/4O4EQc2AUKIb21wYIJ1XQ6/QoxemfeMlnALly
 ZWBLldJqWHiVXXfWGS46SzmiETHK5+LHNUtUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ly79g/brjlF90XJZ8f32qw6QQEvN2fFo38sAbG4157w=;
 b=jLCR9rXNdh6SI6jPpHYbEK00+EYAwLpgEEKPnd5cySLm8HK6IbS8T4ij2GjxBBJfHO
 UHPMn1KFEm1155Tpv3mT9x+TthYCxrDMVt4c0R25k7TIWYcZ9vZxDWywfgvhOh2CB8gr
 Su5Z6KcVcZfI+Wc5nsIy483A6M566Cv/0j5xH3KnU91vlzxBsX8z/klcrytEmspLGehp
 odacL4jyYGZZmY8QnxeW2NJEM+1qhsvLJVrZYv9dwBWR478rJutOZId+9WqckwQ7lQOk
 /zEfMXp1g7OwQXPe/FAu7O8EjnRDSqsh5hZ2b4DxPhQurSxuhEo0J0E8Oo0FiZH4A4Mz
 Y+ZA==
X-Gm-Message-State: AOAM533AAkvRZ7rk/4TEN3B1E0Vgw6ObsvtV7bBCkzjcRUfY+V53LYk9
 ieFPZj30jz8KkhEpYrzKsD1jrHaHvYuErQ==
X-Google-Smtp-Source: ABdhPJycsLhi7g6v+SPlmzDTFHwtzsP8digj7vRSGXW7QFyqfeP/dR7mBlGP1FOh6yMFfgx2pN2ddg==
X-Received: by 2002:a17:906:1f03:: with SMTP id
 w3mr4087268ejj.463.1611920746350; 
 Fri, 29 Jan 2021 03:45:46 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com.
 [209.85.221.48])
 by smtp.gmail.com with ESMTPSA id cf26sm4484923edb.14.2021.01.29.03.45.44
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 03:45:45 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id g10so8536150wrx.1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 03:45:44 -0800 (PST)
X-Received: by 2002:a05:6000:12c7:: with SMTP id
 l7mr4056870wrx.103.1611920743992; 
 Fri, 29 Jan 2021 03:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-7-yong.wu@mediatek.com>
 <X+L9XpkoII7tw/tX@chromium.org> <1608809713.26323.262.camel@mhfsdcap03>
 <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
 <1610520301.31716.27.camel@mhfsdcap03>
 <CAAFQd5A26tZo3gpsmqbRSa3x7a1KThzt9Jw74jWsqQGrBsabhw@mail.gmail.com>
 <1611126445.19055.34.camel@mhfsdcap03>
 <CAAFQd5C3G=eE+dwOK0Vg=tcSR8LFWWG1YDta3=9nZ1G0Bv7dcA@mail.gmail.com>
 <1611560007.3184.39.camel@mhfsdcap03>
In-Reply-To: <1611560007.3184.39.camel@mhfsdcap03>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 29 Jan 2021 20:45:30 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A6rAL5iLt0iSDxNPQq5TgZ9=ZJQSkGG3GKwv+FPk9p3g@mail.gmail.com>
Message-ID: <CAAFQd5A6rAL5iLt0iSDxNPQq5TgZ9=ZJQSkGG3GKwv+FPk9p3g@mail.gmail.com>
Subject: Re: [PATCH v5 06/27] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, linux-devicetree <devicetree@vger.kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>,
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

On Mon, Jan 25, 2021 at 4:34 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Mon, 2021-01-25 at 13:18 +0900, Tomasz Figa wrote:
> > On Wed, Jan 20, 2021 at 4:08 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > On Wed, 2021-01-20 at 13:15 +0900, Tomasz Figa wrote:
> > > > On Wed, Jan 13, 2021 at 3:45 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > > > >
> > > > > On Wed, 2021-01-13 at 14:30 +0900, Tomasz Figa wrote:
> > > > > > On Thu, Dec 24, 2020 at 8:35 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > > > > > >
> > > > > > > On Wed, 2020-12-23 at 17:18 +0900, Tomasz Figa wrote:
> > > > > > > > On Wed, Dec 09, 2020 at 04:00:41PM +0800, Yong Wu wrote:
> > > > > > > > > This patch adds decriptions for mt8192 IOMMU and SMI.
> > > > > > > > >
> > > > > > > > > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > > > > > > > > table format. The M4U-SMI HW diagram is as below:
> > > > > > > > >
> > > > > > > > >                           EMI
> > > > > > > > >                            |
> > > > > > > > >                           M4U
> > > > > > > > >                            |
> > > > > > > > >                       ------------
> > > > > > > > >                        SMI Common
> > > > > > > > >                       ------------
> > > > > > > > >                            |
> > > > > > > > >   +-------+------+------+----------------------+-------+
> > > > > > > > >   |       |      |      |       ......         |       |
> > > > > > > > >   |       |      |      |                      |       |
> > > > > > > > > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > > > > > > > > disp0   disp1   mdp    vdec                   IPE      IPE
> > > > > > > > >
> > > > > > > > > All the connections are HW fixed, SW can NOT adjust it.
> > > > > > > > >
> > > > > > > > > mt8192 M4U support 0~16GB iova range. we preassign different engines
> > > > > > > > > into different iova ranges:
> > > > > > > > >
> > > > > > > > > domain-id  module     iova-range                  larbs
> > > > > > > > >    0       disp        0 ~ 4G                      larb0/1
> > > > > > > > >    1       vcodec      4G ~ 8G                     larb4/5/7
> > > > > > > > >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> > > > > > > >
> > > > > > > > Why do we preassign these addresses in DT? Shouldn't it be a user's or
> > > > > > > > integrator's decision to split the 16 GB address range into sub-ranges
> > > > > > > > and define which larbs those sub-ranges are shared with?
> > > > > > >
> > > > > > > The problem is that we can't split the 16GB range with the larb as unit.
> > > > > > > The example is the below ccu0(larb13 port9/10) is a independent
> > > > > > > range(domain), the others ports in larb13 is in another domain.
> > > > > > >
> > > > > > > disp/vcodec/cam/mdp don't have special iova requirement, they could
> > > > > > > access any range. vcodec also can locate 8G~12G. it don't care about
> > > > > > > where its iova locate. here I preassign like this following with our
> > > > > > > internal project setting.
> > > > > >
> > > > > > Let me try to understand this a bit more. Given the split you're
> > > > > > proposing, is there actually any isolation enforced between particular
> > > > > > domains? For example, if I program vcodec to with a DMA address from
> > > > > > the 0-4G range, would the IOMMU actually generate a fault, even if
> > > > > > disp had some memory mapped at that address?
> > > > >
> > > > > In this case. we will get fault in current SW setting.
> > > > >
> > > >
> > > > Okay, thanks.
> > > >
> > > > > >
> > > > > > >
> > > > > > > Why set this in DT?, this is only for simplifying the code. Assume we
> > > > > > > put it in the platform data. We have up to 32 larbs, each larb has up to
> > > > > > > 32 ports, each port may be in different iommu domains. we should have a
> > > > > > > big array for this..however we only use a macro to get the domain in the
> > > > > > > DT method.
> > > > > > >
> > > > > > > When replying this mail, I happen to see there is a "dev->dev_range_map"
> > > > > > > which has "dma-range" information, I think I could use this value to get
> > > > > > > which domain the device belong to. then no need put domid in DT. I will
> > > > > > > test this.
> > > > > >
> > > > > > My feeling is that the only part that needs to be enforced statically
> > > > > > is the reserved IOVA range for CCUs. The other ranges should be
> > > > > > determined dynamically, although I think I need to understand better
> > > > > > how the hardware and your proposed design work to tell what would be
> > > > > > likely the best choice here.
> > > > >
> > > > > I have removed the domid patch in v6. and get the domain id in [27/33]
> > > > > in v6..
> > > > >
> > > > > About the other ranges should be dynamical, the commit message [30/33]
> > > > > of v6 should be helpful. the problem is that we have a bank_sel setting
> > > > > for the iova[32:33]. currently we preassign this value. thus, all the
> > > > > ranges are fixed. If you adjust this setting, you can let vcodec access
> > > > > 0~4G.
> > > >
> > > > Okay, so it sounds like we effectively have four 4G address spaces and
> > > > we can assign the master devices to them. I guess each of these
> > > > address spaces makes for an IOMMU group.
> > >
> > > Yes. Each a address spaces is an IOMMU group.
> > >
> > > >
> > > > It's fine to pre-assign the devices to those groups for now, but it
> > > > definitely shouldn't be hardcoded in DT, because it depends on the use
> > > > case of the device. I'll take a look at v6, but it sounds like it
> > > > should be fine if it doesn't take the address space assignment from DT
> > > > anymore.
> > >
> > > Thanks very much for your review.
> > >
> >
> > Hmm, I had a look at v6 and it still has the address spaces hardcoded
> > in the DTS.
>
> sorry. I didn't get here. where do you mean. or help reply in v6.
>
> I only added the preassign list as comment in the file
> (dt-binding/memory/mt8192-larb-port.h). I thought our iommu consumer may
> need it when they use these ports. they need add dma-ranges property if
> its iova is over 4GB.

That's exactly the problem. v6 simply replaced one way to describe the
policy (domain ID) with another (dma-ranges). However, DT is not the
right place to describe policies, because it's the place to describe
hardware in a way agnostic from policies and use cases. In other
words, DT must not impose using the hardware in one way or another.

For example, we have two different companies that want to ship
products based on this SoC - A and B. Company A may want to put MDP
and camera in the same address space, but company B instead would
prefer MDP to be in the same address space as video. Because this
decision is stored in DT, one of them will have to change and rebuild
their kernel and maintain a downstream patch.

My suggestion to follow here would be to:
 - stop using dma-ranges for this purpose,
 - add an array in the MTK IOMMU driver that has a default map between
larbs and domains, e.g.

static u8 mt8192_domain_map[NUM_DOMAINS][NUM_LARBS] = {
   [0] = { 0 , 1, 0xff },
   [1] = { 4, 5, 7, 0xff },
   [2] = { 2, 9, 11, 13, 14, 16, 17, 18, 19, 20, 0xff },
};

 - add a kernel command line parameter that allows overriding of this map, e.g.

mtk_iommu.domain_map="0:0,1:1:4,5,7:2:2,9,11,13,14,16,17,18,19,20"

would be equivalent to the array above. Same could be also given by a
Kconfig entry if one can't or doesn't want to add extra command line
parameters.

Would something like this work?

>
> > Could we move the fixed assignment to the MTK IOMMU driver code instead,
> > so that it can be easily adjusted as the kernel code
> > evolves without the need to update the DTS?
> >
> > > >
> > > > >
> > > > > Currently we have no interface to adjust this setting. Suppose we add a
> > > > > new interface for this. It would be something like:
> > > > >
> > > > >    int mtk_smi_larb_config_banksel(struct device *larb, int banksel)
> > > > >
> > > > >    Then, all the MM drivers should call it before the HW works every
> > > > > time, and its implement will be a bit complex since we aren't sure if
> > > > > the larb has power at that time. the important thing is that the MM
> > > > > devices have already not known which larb it connects with as we plan to
> > > > > delete "mediatek,larb" in their dtsi nodes.
> > > >
> > > > From the practical point of view, it doesn't look like setting this on
> > > > a per-larb basis would make much sense. The reason to switch the
> > > > bank_sel would be to decide which MM devices can share the same
> > > > address space. This is a security aspect, because it effectively
> > > > determines which devices are isolated from each other.
> > > >
> > > > That said, I agree that for now we can just start with a fixed
> > > > assignment. We can think of the API if there is a need to adjust the
> > > > assignment.
> > >
> > > Sorry for here. I forgot a thing here. that interface above still will
> > > not be helpful. If we don't divide the whole 16GB ranges into 4
> > > regions(let all the other ranges be dynamical), It won't work since we
> > > can only adjust bank_sel with the larb as unit. This is a problem. there
> > > are many ports in a larb. Take a example, the address for vcodec read
> > > port is 32bits while the address for vcodec write port is 33bit, then it
> > > will fail since we only have one bank_sel setting for one larb.
> >
> > That's exactly why I proposed to have the API operate based on the
> > struct device, rather than individual DMA ports. Although I guess the
> > CCU case is different, because it's the same larb as the camera.
> >
> > Anyway, I agree that we don't have to come up with such an API right now.
>
> Thanks for the confirm.
>
> >
> > > Thus we
> > > have to use current design.
> > >
> > > >
> > > > >
> > > > >    In current design, the MM device don't need care about it and 4GB
> > > > > range is enough for them.
> > > > >
> > > >
> > > > Actually, is the current assignment correct?
> > >
> > > Oh. In the code (patch [32/33] of v6), I put CCU0/1 in the cam/mdp
> > > region which start at 8G since CCU0/1 is a module of camera.
> > >
> > > >
> > > > domain-id  module     iova-range                  larbs
> > > >    0       disp        0 ~ 4G                      larb0/1
> > > >    1       vcodec      4G ~ 8G                     larb4/5/7
> > > >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> > > >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> > > >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > > >
> > > > Wouldn't CCU0 and CCU1 conflict with disp?
> > >
> > > About the conflict, I use patch [29/33] of v6 for this. I will reserve
> > > this special iova region when the full domain(0-4G in this example)
> > > initialize.
> > >
> > > > Should perhaps disp be assigned 12G ~ 16G instead?
> > >
> > > I think no need put it to 12G-16G, In previous SoC, we have only 4GB
> > > ranges for whole MM engines. currently only cam/mdp domain exclude 128M
> > > for CCU. it should be something wrong if this is not enough.
> > >
> >
> > Indeed, space is not a problem, but from the security point of view
> > it's undesirable. I believe CCU would be running proprietary firmware,
> > so it should be isolated as much as possible from other components.
>
> CCU are in the same larb with camera. Thus, it also need locate the same
> iova range with camera.

What are larb13 and larb14 used by besides CCU? Is it possible to put
them in a separate address space from other camera larbs?

Best regards,
Tomasz

>
> > And, after all, why waste the remaining 4G of address space?
> >
> > Best regards,
> > Tomasz
> >
> > > >
> > > > Best regards,
> > > > Tomasz
> > > >
> > > > > >
> > > > > > Best regards,
> > > > > > Tomasz
> > > > > >
> > > > > > >
> > > > > > > Thanks.
> > > > > > > >
> > > > > > > > Best regards,
> > > > > > > > Tomasz
> > > > > > > >
> > > > > > > > >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> > > > > > > > >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > > > > > > > >
> > > > > > > > > The iova range for CCU0/1(camera control unit) is HW requirement.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > > > > ---
> > > > > > > > >  .../bindings/iommu/mediatek,iommu.yaml        |  18 +-
> > > > > > > > >  include/dt-bindings/memory/mt8192-larb-port.h | 240 ++++++++++++++++++
> > > > > > > > >  2 files changed, 257 insertions(+), 1 deletion(-)
> > > > > > > > >  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> > > > > > > > >
> > > > > > > [snip]
> > > > >
> > >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
