Return-Path: <SRS0=4l6Q=7E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD50C433E1
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 14:34:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE5323403
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 14:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE5323403
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C1E988C7E;
	Fri, 22 May 2020 14:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lqMTEPvmO3fO; Fri, 22 May 2020 14:34:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B613E888F8;
	Fri, 22 May 2020 14:34:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7E6DC0863;
	Fri, 22 May 2020 14:34:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16518C0176
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 14:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F259588C7E
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 14:34:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xv9HgYjHpFjg for <iommu@lists.linux-foundation.org>;
 Fri, 22 May 2020 14:34:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 090A5888F8
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 14:34:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AEA0D6E;
 Fri, 22 May 2020 07:34:31 -0700 (PDT)
Received: from [10.57.2.168] (unknown [10.57.2.168])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E7D3F68F;
 Fri, 22 May 2020 07:34:29 -0700 (PDT)
Subject: Re: [PATCH 09/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
To: Rob Herring <robh+dt@kernel.org>,
 Diana Craciun OSS <diana.craciun@oss.nxp.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
 <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
 <abca6ecb-5d93-832f-ff7c-de53bb6203f3@arm.com>
 <ee7a5c04-814e-215f-ec74-52c2f3b881d0@oss.nxp.com>
 <CAL_JsqKf+cq9Nhs+M8ihC-Ls24YH-WEofW8H4kkFPWMhZw=unA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7f8d00ae-b225-a58d-8a11-e8c68edc877b@arm.com>
Date: Fri, 22 May 2020 15:34:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKf+cq9Nhs+M8ihC-Ls24YH-WEofW8H4kkFPWMhZw=unA@mail.gmail.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 PCI <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-05-22 15:08, Rob Herring wrote:
> On Fri, May 22, 2020 at 3:57 AM Diana Craciun OSS
> <diana.craciun@oss.nxp.com> wrote:
>>
>> On 5/22/2020 12:42 PM, Robin Murphy wrote:
>>> On 2020-05-22 00:10, Rob Herring wrote:
>>>> On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
>>>> <lorenzo.pieralisi@arm.com> wrote:
>>>>>
>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>
>>>>> The existing bindings cannot be used to specify the relationship
>>>>> between fsl-mc devices and GIC ITSes.
>>>>>
>>>>> Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
>>>>> msi-map property.
>>>>>
>>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>> ---
>>>>>    .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 30
>>>>> +++++++++++++++++--
>>>>>    1 file changed, 27 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>>>>> b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>>>>> index 9134e9bcca56..b0813b2d0493 100644
>>>>> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>>>>> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>>>>> @@ -18,9 +18,9 @@ same hardware "isolation context" and a 10-bit
>>>>> value called an ICID
>>>>>    the requester.
>>>>>
>>>>>    The generic 'iommus' property is insufficient to describe the
>>>>> relationship
>>>>> -between ICIDs and IOMMUs, so an iommu-map property is used to define
>>>>> -the set of possible ICIDs under a root DPRC and how they map to
>>>>> -an IOMMU.
>>>>> +between ICIDs and IOMMUs, so the iommu-map and msi-map properties
>>>>> are used
>>>>> +to define the set of possible ICIDs under a root DPRC and how they
>>>>> map to
>>>>> +an IOMMU and a GIC ITS respectively.
>>>>>
>>>>>    For generic IOMMU bindings, see
>>>>>    Documentation/devicetree/bindings/iommu/iommu.txt.
>>>>> @@ -28,6 +28,9 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
>>>>>    For arm-smmu binding, see:
>>>>>    Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
>>>>>
>>>>> +For GICv3 and GIC ITS bindings, see:
>>>>> +Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
>>>>>
>>>>> +
>>>>>    Required properties:
>>>>>
>>>>>        - compatible
>>>>> @@ -119,6 +122,15 @@ Optional properties:
>>>>>      associated with the listed IOMMU, with the iommu-specifier
>>>>>      (i - icid-base + iommu-base).
>>>>>
>>>>> +- msi-map: Maps an ICID to a GIC ITS and associated iommu-specifier
>>>>> +  data.
>>>>> +
>>>>> +  The property is an arbitrary number of tuples of
>>>>> +  (icid-base,iommu,iommu-base,length).
>>>>
>>>> I'm confused because the example has GIC ITS phandle, not an IOMMU.
>>>>
>>>> What is an iommu-base?
>>>
>>> Right, I was already halfway through writing a reply to say that all
>>> the copy-pasted "iommu" references here should be using the
>>> terminology from the pci-msi.txt binding instead.
>>
>> Right, will change it.
>>
>>>
>>>>> +
>>>>> +  Any ICID in the interval [icid-base, icid-base + length) is
>>>>> +  associated with the listed GIC ITS, with the iommu-specifier
>>>>> +  (i - icid-base + iommu-base).
>>>>>    Example:
>>>>>
>>>>>            smmu: iommu@5000000 {
>>>>> @@ -128,6 +140,16 @@ Example:
>>>>>                   ...
>>>>>            };
>>>>>
>>>>> +       gic: interrupt-controller@6000000 {
>>>>> +               compatible = "arm,gic-v3";
>>>>> +               ...
>>>>> +               its: gic-its@6020000 {
>>>>> +                       compatible = "arm,gic-v3-its";
>>>>> +                       msi-controller;
>>>>> +                       ...
>>>>> +               };
>>>>> +       };
>>>>> +
>>>>>            fsl_mc: fsl-mc@80c000000 {
>>>>>                    compatible = "fsl,qoriq-mc";
>>>>>                    reg = <0x00000008 0x0c000000 0 0x40>,    /* MC
>>>>> portal base */
>>>>> @@ -135,6 +157,8 @@ Example:
>>>>>                    msi-parent = <&its>;
>>>
>>> Side note: is it right to keep msi-parent here? It rather implies that
>>> the MC itself has a 'native' Device ID rather than an ICID, which I
>>> believe is not strictly true. Plus it's extra-confusing that it
>>> doesn't specify an ID either way, since that makes it look like the
>>> legacy PCI case that gets treated implicitly as an identity msi-map,
>>> which makes no sense at all to combine with an actual msi-map.
>>
>> Before adding msi-map, the fsl-mc code assumed that ICID and streamID
>> are equal and used msi-parent just to get the reference to the ITS node.
>> Removing msi-parent will break the backward compatibility of the already
>> existing systems. Maybe we should mention that this is legacy and not to
>> be used for newer device trees.
> 
> If ids are 1:1, then the DT should use msi-parent. If there is
> remapping, then use msi-map. A given system should use one or the
> other. I suppose if some ids are 1:1 and the msi-map was added to add
> additional support for ids not 1:1, then you could end up with both.
> That's fine in dts files, but examples should reflect the 'right' way.

Is that defined anywhere? The generic MSI binding just has some weaselly 
wording about buses:

"When #msi-cells is non-zero, busses with an msi-parent will require 
additional properties to describe the relationship between devices on 
the bus and the set of MSIs they can potentially generate."

which appears at odds with its own definition of msi-parent as including 
an msi-specifier (or at best very unclear about what value that 
specifier should take in this case).

The PCI MSI binding goes even further and specifically reserves 
msi-parent for cases where there is no sideband data. As far as I'm 
aware, the fact that the ITS driver implements a bodge for the "empty 
msi-parent even though #msi-cells > 0" case is merely a compatibility 
thing for old DTs from before this was really thought through, not an 
officially-specified behaviour.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
