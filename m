Return-Path: <SRS0=Rmex=HD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A62C433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 10:44:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237DC64E94
	for <iommu@archiver.kernel.org>; Mon,  1 Feb 2021 10:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237DC64E94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CDF778459B;
	Mon,  1 Feb 2021 10:44:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bwEaxzuPvZlr; Mon,  1 Feb 2021 10:44:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 40145844AA;
	Mon,  1 Feb 2021 10:44:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28000C0174;
	Mon,  1 Feb 2021 10:44:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87C2BC013A
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 10:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8327F8643B
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 10:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ABRJHsGYobQ for <iommu@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 10:44:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 58B9E8619F
 for <iommu@lists.linux-foundation.org>; Mon,  1 Feb 2021 10:44:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91BE7101E;
 Mon,  1 Feb 2021 02:44:27 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 181C33FA1C;
 Mon,  1 Feb 2021 02:44:23 -0800 (PST)
Subject: Re: [PATCH v5 06/27] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
To: Tomasz Figa <tfiga@chromium.org>, Yong Wu <yong.wu@mediatek.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-7-yong.wu@mediatek.com> <X+L9XpkoII7tw/tX@chromium.org>
 <1608809713.26323.262.camel@mhfsdcap03>
 <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
 <1610520301.31716.27.camel@mhfsdcap03>
 <CAAFQd5A26tZo3gpsmqbRSa3x7a1KThzt9Jw74jWsqQGrBsabhw@mail.gmail.com>
 <1611126445.19055.34.camel@mhfsdcap03>
 <CAAFQd5C3G=eE+dwOK0Vg=tcSR8LFWWG1YDta3=9nZ1G0Bv7dcA@mail.gmail.com>
 <1611560007.3184.39.camel@mhfsdcap03>
 <CAAFQd5A6rAL5iLt0iSDxNPQq5TgZ9=ZJQSkGG3GKwv+FPk9p3g@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <bf443749-8627-5d1d-d52f-64553391d1ed@arm.com>
Date: Mon, 1 Feb 2021 10:44:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5A6rAL5iLt0iSDxNPQq5TgZ9=ZJQSkGG3GKwv+FPk9p3g@mail.gmail.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, linux-devicetree <devicetree@vger.kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-01-29 11:45, Tomasz Figa wrote:
> On Mon, Jan 25, 2021 at 4:34 PM Yong Wu <yong.wu@mediatek.com> wrote:
>>
>> On Mon, 2021-01-25 at 13:18 +0900, Tomasz Figa wrote:
>>> On Wed, Jan 20, 2021 at 4:08 PM Yong Wu <yong.wu@mediatek.com> wrote:
>>>>
>>>> On Wed, 2021-01-20 at 13:15 +0900, Tomasz Figa wrote:
>>>>> On Wed, Jan 13, 2021 at 3:45 PM Yong Wu <yong.wu@mediatek.com> wrote:
>>>>>>
>>>>>> On Wed, 2021-01-13 at 14:30 +0900, Tomasz Figa wrote:
>>>>>>> On Thu, Dec 24, 2020 at 8:35 PM Yong Wu <yong.wu@mediatek.com> wrote:
>>>>>>>>
>>>>>>>> On Wed, 2020-12-23 at 17:18 +0900, Tomasz Figa wrote:
>>>>>>>>> On Wed, Dec 09, 2020 at 04:00:41PM +0800, Yong Wu wrote:
>>>>>>>>>> This patch adds decriptions for mt8192 IOMMU and SMI.
>>>>>>>>>>
>>>>>>>>>> mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
>>>>>>>>>> table format. The M4U-SMI HW diagram is as below:
>>>>>>>>>>
>>>>>>>>>>                            EMI
>>>>>>>>>>                             |
>>>>>>>>>>                            M4U
>>>>>>>>>>                             |
>>>>>>>>>>                        ------------
>>>>>>>>>>                         SMI Common
>>>>>>>>>>                        ------------
>>>>>>>>>>                             |
>>>>>>>>>>    +-------+------+------+----------------------+-------+
>>>>>>>>>>    |       |      |      |       ......         |       |
>>>>>>>>>>    |       |      |      |                      |       |
>>>>>>>>>> larb0   larb1  larb2  larb4     ......      larb19   larb20
>>>>>>>>>> disp0   disp1   mdp    vdec                   IPE      IPE
>>>>>>>>>>
>>>>>>>>>> All the connections are HW fixed, SW can NOT adjust it.
>>>>>>>>>>
>>>>>>>>>> mt8192 M4U support 0~16GB iova range. we preassign different engines
>>>>>>>>>> into different iova ranges:
>>>>>>>>>>
>>>>>>>>>> domain-id  module     iova-range                  larbs
>>>>>>>>>>     0       disp        0 ~ 4G                      larb0/1
>>>>>>>>>>     1       vcodec      4G ~ 8G                     larb4/5/7
>>>>>>>>>>     2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
>>>>>>>>>
>>>>>>>>> Why do we preassign these addresses in DT? Shouldn't it be a user's or
>>>>>>>>> integrator's decision to split the 16 GB address range into sub-ranges
>>>>>>>>> and define which larbs those sub-ranges are shared with?
>>>>>>>>
>>>>>>>> The problem is that we can't split the 16GB range with the larb as unit.
>>>>>>>> The example is the below ccu0(larb13 port9/10) is a independent
>>>>>>>> range(domain), the others ports in larb13 is in another domain.
>>>>>>>>
>>>>>>>> disp/vcodec/cam/mdp don't have special iova requirement, they could
>>>>>>>> access any range. vcodec also can locate 8G~12G. it don't care about
>>>>>>>> where its iova locate. here I preassign like this following with our
>>>>>>>> internal project setting.
>>>>>>>
>>>>>>> Let me try to understand this a bit more. Given the split you're
>>>>>>> proposing, is there actually any isolation enforced between particular
>>>>>>> domains? For example, if I program vcodec to with a DMA address from
>>>>>>> the 0-4G range, would the IOMMU actually generate a fault, even if
>>>>>>> disp had some memory mapped at that address?
>>>>>>
>>>>>> In this case. we will get fault in current SW setting.
>>>>>>
>>>>>
>>>>> Okay, thanks.
>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Why set this in DT?, this is only for simplifying the code. Assume we
>>>>>>>> put it in the platform data. We have up to 32 larbs, each larb has up to
>>>>>>>> 32 ports, each port may be in different iommu domains. we should have a
>>>>>>>> big array for this..however we only use a macro to get the domain in the
>>>>>>>> DT method.
>>>>>>>>
>>>>>>>> When replying this mail, I happen to see there is a "dev->dev_range_map"
>>>>>>>> which has "dma-range" information, I think I could use this value to get
>>>>>>>> which domain the device belong to. then no need put domid in DT. I will
>>>>>>>> test this.
>>>>>>>
>>>>>>> My feeling is that the only part that needs to be enforced statically
>>>>>>> is the reserved IOVA range for CCUs. The other ranges should be
>>>>>>> determined dynamically, although I think I need to understand better
>>>>>>> how the hardware and your proposed design work to tell what would be
>>>>>>> likely the best choice here.
>>>>>>
>>>>>> I have removed the domid patch in v6. and get the domain id in [27/33]
>>>>>> in v6..
>>>>>>
>>>>>> About the other ranges should be dynamical, the commit message [30/33]
>>>>>> of v6 should be helpful. the problem is that we have a bank_sel setting
>>>>>> for the iova[32:33]. currently we preassign this value. thus, all the
>>>>>> ranges are fixed. If you adjust this setting, you can let vcodec access
>>>>>> 0~4G.
>>>>>
>>>>> Okay, so it sounds like we effectively have four 4G address spaces and
>>>>> we can assign the master devices to them. I guess each of these
>>>>> address spaces makes for an IOMMU group.
>>>>
>>>> Yes. Each a address spaces is an IOMMU group.
>>>>
>>>>>
>>>>> It's fine to pre-assign the devices to those groups for now, but it
>>>>> definitely shouldn't be hardcoded in DT, because it depends on the use
>>>>> case of the device. I'll take a look at v6, but it sounds like it
>>>>> should be fine if it doesn't take the address space assignment from DT
>>>>> anymore.
>>>>
>>>> Thanks very much for your review.
>>>>
>>>
>>> Hmm, I had a look at v6 and it still has the address spaces hardcoded
>>> in the DTS.
>>
>> sorry. I didn't get here. where do you mean. or help reply in v6.
>>
>> I only added the preassign list as comment in the file
>> (dt-binding/memory/mt8192-larb-port.h). I thought our iommu consumer may
>> need it when they use these ports. they need add dma-ranges property if
>> its iova is over 4GB.
> 
> That's exactly the problem. v6 simply replaced one way to describe the
> policy (domain ID) with another (dma-ranges). However, DT is not the
> right place to describe policies, because it's the place to describe
> hardware in a way agnostic from policies and use cases. In other
> words, DT must not impose using the hardware in one way or another.
> 
> For example, we have two different companies that want to ship
> products based on this SoC - A and B. Company A may want to put MDP
> and camera in the same address space, but company B instead would
> prefer MDP to be in the same address space as video. Because this
> decision is stored in DT, one of them will have to change and rebuild
> their kernel and maintain a downstream patch.

Well, in most cases Company A and Company B will be building their own 
products around the SoC, so will each have their own downstream DTS 
anyway. Even if they're buying complete hardware from an OEM and just 
shipping it with custom software configurations, it's still quite likely 
that they'd have their own DTS tweaks for branding and possibly other 
firmware-related things.

Also note that expected use-cases frequently *are* reflected in DT - 
pretty much every use of the "linux,shared-dma-pool" reserved-memory 
binding, for instance. In fact memory carveouts in general are usually 
just software policy rather than any kind of hardware or firmware 
description. There are also plenty of DT properties for actual hardware 
that imply "this is how you need to configure me" rather than just "this 
is what I can do", so the distinction between "describing the platform" 
and "telling software what to do" isn't as clear-cut as we'd like it to be.

While I'm also not entirely convinced that "dma-ranges" is the perfect 
tool for the job - as opposed to less abstraction via a larb property or 
extra IOMMU specifier cell - it is at least descriptive to the DMA and 
IOMMU subsystems as well as the driver, and can draw a direct parallel 
to how some PCI host bridge drivers handle inbound windows. In many 
cases those just need to be programmed *somehow*, so "dma-ranges" is set 
in the DTS or inserted by the bootloader, and the kernel driver parses 
that then programs the hardware to match. It seems like we're doing a 
directly comparable thing here.

Robin.

> My suggestion to follow here would be to:
>   - stop using dma-ranges for this purpose,
>   - add an array in the MTK IOMMU driver that has a default map between
> larbs and domains, e.g.
> 
> static u8 mt8192_domain_map[NUM_DOMAINS][NUM_LARBS] = {
>     [0] = { 0 , 1, 0xff },
>     [1] = { 4, 5, 7, 0xff },
>     [2] = { 2, 9, 11, 13, 14, 16, 17, 18, 19, 20, 0xff },
> };
> 
>   - add a kernel command line parameter that allows overriding of this map, e.g.
> 
> mtk_iommu.domain_map="0:0,1:1:4,5,7:2:2,9,11,13,14,16,17,18,19,20"
> 
> would be equivalent to the array above. Same could be also given by a
> Kconfig entry if one can't or doesn't want to add extra command line
> parameters.
> 
> Would something like this work?
> 
>>
>>> Could we move the fixed assignment to the MTK IOMMU driver code instead,
>>> so that it can be easily adjusted as the kernel code
>>> evolves without the need to update the DTS?
>>>
>>>>>
>>>>>>
>>>>>> Currently we have no interface to adjust this setting. Suppose we add a
>>>>>> new interface for this. It would be something like:
>>>>>>
>>>>>>     int mtk_smi_larb_config_banksel(struct device *larb, int banksel)
>>>>>>
>>>>>>     Then, all the MM drivers should call it before the HW works every
>>>>>> time, and its implement will be a bit complex since we aren't sure if
>>>>>> the larb has power at that time. the important thing is that the MM
>>>>>> devices have already not known which larb it connects with as we plan to
>>>>>> delete "mediatek,larb" in their dtsi nodes.
>>>>>
>>>>>  From the practical point of view, it doesn't look like setting this on
>>>>> a per-larb basis would make much sense. The reason to switch the
>>>>> bank_sel would be to decide which MM devices can share the same
>>>>> address space. This is a security aspect, because it effectively
>>>>> determines which devices are isolated from each other.
>>>>>
>>>>> That said, I agree that for now we can just start with a fixed
>>>>> assignment. We can think of the API if there is a need to adjust the
>>>>> assignment.
>>>>
>>>> Sorry for here. I forgot a thing here. that interface above still will
>>>> not be helpful. If we don't divide the whole 16GB ranges into 4
>>>> regions(let all the other ranges be dynamical), It won't work since we
>>>> can only adjust bank_sel with the larb as unit. This is a problem. there
>>>> are many ports in a larb. Take a example, the address for vcodec read
>>>> port is 32bits while the address for vcodec write port is 33bit, then it
>>>> will fail since we only have one bank_sel setting for one larb.
>>>
>>> That's exactly why I proposed to have the API operate based on the
>>> struct device, rather than individual DMA ports. Although I guess the
>>> CCU case is different, because it's the same larb as the camera.
>>>
>>> Anyway, I agree that we don't have to come up with such an API right now.
>>
>> Thanks for the confirm.
>>
>>>
>>>> Thus we
>>>> have to use current design.
>>>>
>>>>>
>>>>>>
>>>>>>     In current design, the MM device don't need care about it and 4GB
>>>>>> range is enough for them.
>>>>>>
>>>>>
>>>>> Actually, is the current assignment correct?
>>>>
>>>> Oh. In the code (patch [32/33] of v6), I put CCU0/1 in the cam/mdp
>>>> region which start at 8G since CCU0/1 is a module of camera.
>>>>
>>>>>
>>>>> domain-id  module     iova-range                  larbs
>>>>>     0       disp        0 ~ 4G                      larb0/1
>>>>>     1       vcodec      4G ~ 8G                     larb4/5/7
>>>>>     2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
>>>>>     3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
>>>>>     4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
>>>>>
>>>>> Wouldn't CCU0 and CCU1 conflict with disp?
>>>>
>>>> About the conflict, I use patch [29/33] of v6 for this. I will reserve
>>>> this special iova region when the full domain(0-4G in this example)
>>>> initialize.
>>>>
>>>>> Should perhaps disp be assigned 12G ~ 16G instead?
>>>>
>>>> I think no need put it to 12G-16G, In previous SoC, we have only 4GB
>>>> ranges for whole MM engines. currently only cam/mdp domain exclude 128M
>>>> for CCU. it should be something wrong if this is not enough.
>>>>
>>>
>>> Indeed, space is not a problem, but from the security point of view
>>> it's undesirable. I believe CCU would be running proprietary firmware,
>>> so it should be isolated as much as possible from other components.
>>
>> CCU are in the same larb with camera. Thus, it also need locate the same
>> iova range with camera.
> 
> What are larb13 and larb14 used by besides CCU? Is it possible to put
> them in a separate address space from other camera larbs?
> 
> Best regards,
> Tomasz
> 
>>
>>> And, after all, why waste the remaining 4G of address space?
>>>
>>> Best regards,
>>> Tomasz
>>>
>>>>>
>>>>> Best regards,
>>>>> Tomasz
>>>>>
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Tomasz
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>> Tomasz
>>>>>>>>>
>>>>>>>>>>     3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
>>>>>>>>>>     4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
>>>>>>>>>>
>>>>>>>>>> The iova range for CCU0/1(camera control unit) is HW requirement.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>>>>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>>>>>>>> ---
>>>>>>>>>>   .../bindings/iommu/mediatek,iommu.yaml        |  18 +-
>>>>>>>>>>   include/dt-bindings/memory/mt8192-larb-port.h | 240 ++++++++++++++++++
>>>>>>>>>>   2 files changed, 257 insertions(+), 1 deletion(-)
>>>>>>>>>>   create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
>>>>>>>>>>
>>>>>>>> [snip]
>>>>>>
>>>>
>>>
>>> _______________________________________________
>>> Linux-mediatek mailing list
>>> Linux-mediatek@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
