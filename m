Return-Path: <SRS0=z+Ry=HS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D88C433DB
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 15:10:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3CD64DEC
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 15:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3CD64DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 59FB485198;
	Tue, 16 Feb 2021 15:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6MltOXbOIpql; Tue, 16 Feb 2021 15:10:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E0923851AD;
	Tue, 16 Feb 2021 15:10:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC034C0893;
	Tue, 16 Feb 2021 15:10:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFE6CC013A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 15:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D139387146
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 15:10:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XdkJ7URj-mDr for <iommu@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 15:10:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id E20EE87143
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 15:10:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23AB831B;
 Tue, 16 Feb 2021 07:10:34 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6293C3F694;
 Tue, 16 Feb 2021 07:10:32 -0800 (PST)
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
To: Rob Herring <robh@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <20210203090727.789939-1-zhang.lyra@gmail.com>
 <20210203090727.789939-2-zhang.lyra@gmail.com>
 <20210204232549.GA1305874@robh.at.kernel.org>
 <CAAfSe-tQ+7GuO1PgYa=9wqrpVf3N4br=bn8gJcaEJmnYpc1sxA@mail.gmail.com>
 <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4b88182c-f3fb-20d5-de6f-7fd6eddbcba7@arm.com>
Date: Tue, 16 Feb 2021 15:10:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com>
Content-Language: en-GB
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>
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

On 2021-02-10 19:21, Rob Herring wrote:
> On Fri, Feb 5, 2021 at 1:21 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>>
>> Hi Rob,
>>
>> On Fri, 5 Feb 2021 at 07:25, Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Wed, Feb 03, 2021 at 05:07:26PM +0800, Chunyan Zhang wrote:
>>>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>>>>
>>>> This iommu module can be used by Unisoc's multimedia devices, such as
>>>> display, Image codec(jpeg) and a few signal processors, including
>>>> VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
>>>>
>>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>>>> ---
>>>>   .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
>>>>   1 file changed, 72 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
>>>> new file mode 100644
>>>> index 000000000000..4fc99e81fa66
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
>>>> @@ -0,0 +1,72 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +# Copyright 2020 Unisoc Inc.
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Unisoc IOMMU and Multi-media MMU
>>>> +
>>>> +maintainers:
>>>> +  - Chunyan Zhang <zhang.lyra@gmail.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - sprd,iommu-v1
>>>> +
>>>> +  "#iommu-cells":
>>>> +    const: 0
>>>> +    description:
>>>> +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
>>>> +      additional information needs to associate with its master device.
>>>> +      Please refer to the generic bindings document for more details,
>>>> +      Documentation/devicetree/bindings/iommu/iommu.txt
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +    description:
>>>> +      Not required if 'sprd,iommu-regs' is defined.
>>>> +
>>>> +  clocks:
>>>> +    description:
>>>> +      Reference to a gate clock phandle, since access to some of IOMMUs are
>>>> +      controlled by gate clock, but this is not required.
>>>> +
>>>> +  sprd,iommu-regs:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>> +    description:
>>>> +      Reference to a syscon phandle plus 1 cell, the syscon defines the
>>>> +      register range used by the iommu and the media device, the cell
>>>> +      defines the offset for iommu registers. Since iommu module shares
>>>> +      the same register range with the media device which uses it.
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - "#iommu-cells"

OK, so apparently the hardware is not quite as trivial as my initial 
impression, and you should have interrupts as well.

>>>> +
>>>> +oneOf:
>>>> +  - required:
>>>> +      - reg
>>>> +  - required:
>>>> +      - sprd,iommu-regs
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    iommu_disp: iommu-disp {
>>>> +      compatible = "sprd,iommu-v1";
>>>> +      sprd,iommu-regs = <&dpu_regs 0x800>;
>>>
>>> If the IOMMU is contained within another device, then it should just be
>>> a child node of that device.
>>
>> Yes, actually IOMMU can be seen as a child of multimedia devices, I
>> considered moving IOMMU under into multimedia device node, but
>> multimedia devices need IOMMU when probe[1], so I dropped that idea.
> 
> Don't design your binding around working-around linux issues.

Having stumbled across the DRM driver patches the other day, I now see 
where this is coming from, and it's even worse than that - this whole 
binding seems to be largely working around bad driver design.

>> And they share the same register base, e.g.
>>
>> +               mm {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <2>;
>> +                       #size-cells = <2>;
>> +                       ranges;
>> +
>> +                       dpu_regs: syscon@63000000 {
> 
> Drop this node.
> 
>> +                               compatible = "sprd,sc9863a-dpuregs", "syscon";
>> +                               reg = <0 0x63000000 0 0x1000>;
>> +                       };
>> +
>> +                       dpu: dpu@63000000 {
>> +                               compatible = "sprd,sharkl3-dpu";
>> +                               sprd,disp-regs = <&dpu_regs>;
> 
> reg = <0 0x63000000 0 0x800>;

In fact judging by the other driver it looks like the length only needs 
to be 0x200 here (but maybe there's more to come in future).

>> +                               iommus = <&iommu_dispc>;
>> +                       };
>> +
>> +                       iommu_dispc: iommu@63000000 {
>> +                               compatible = "sprd,iommu-v1";
>> +                               sprd,iommu-regs = <&dpu_regs 0x800>;
> 
> reg = <0 0x63000800 0 0x800>;

...and this one looks to need less than 0x80, even :)

> 
>> +                               #iommu-cells = <0>;
> 
> Though given it seems there is only 1 client and this might really be
> just 1 h/w block, you don't really need to use the iommu binding at
> all. The DPU should be able to instantiate it's own IOMMU device.
> There's other examples of this such as mali GPU though that is all one
> driver, but that's a Linux implementation detail.

FWIW that's really a very different situation - the MMUs in a Mali GPU 
are fundamental parts of its internal pipelines and would never make 
sense to handle as separate devices (if it were even feasible to try). 
An IOMMU like this one is typically a logically-distinct block stuck to 
the external bus interface of any old device, rewriting transactions 
that said device has already issued - it's telling that it needs to 
allocate the prot_page scratchpad for "faulting" transactions to still 
flow somewhere, implying that it's not even involved enough to be able 
to terminate them.

As such I think it *does* make complete sense to describe even 
"dedicated" IOMMUs like this one, Rockchip, Exynos, etc. in DT. 
Otherwise you'd be effectively forcing OSes to turn half their 
display/media drivers into mini board files with secret knowledge of 
which blocks are integrated with IOMMUs on which SoCs.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
