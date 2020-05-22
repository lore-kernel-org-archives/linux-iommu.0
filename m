Return-Path: <SRS0=4l6Q=7E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1792BC433DF
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 09:42:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF00720849
	for <iommu@archiver.kernel.org>; Fri, 22 May 2020 09:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF00720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 935718789E;
	Fri, 22 May 2020 09:42:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fGFO-fFwrC1N; Fri, 22 May 2020 09:42:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D852F87895;
	Fri, 22 May 2020 09:42:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA3C9C088B;
	Fri, 22 May 2020 09:42:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86155C0176
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 09:42:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6CC8D87898
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 09:42:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Pmu-SUxkf2I for <iommu@lists.linux-foundation.org>;
 Fri, 22 May 2020 09:42:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 687BD87895
 for <iommu@lists.linux-foundation.org>; Fri, 22 May 2020 09:42:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D4FC30E;
 Fri, 22 May 2020 02:42:49 -0700 (PDT)
Received: from [10.57.2.168] (unknown [10.57.2.168])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11AEE3F305;
 Fri, 22 May 2020 02:42:46 -0700 (PDT)
Subject: Re: [PATCH 09/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
To: Rob Herring <robh+dt@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
 <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <abca6ecb-5d93-832f-ff7c-de53bb6203f3@arm.com>
Date: Fri, 22 May 2020 10:42:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, PCI <linux-pci@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, linux-acpi@vger.kernel.org,
 Makarand Pawagi <makarand.pawagi@nxp.com>, Marc Zyngier <maz@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>,
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

On 2020-05-22 00:10, Rob Herring wrote:
> On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>>
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> The existing bindings cannot be used to specify the relationship
>> between fsl-mc devices and GIC ITSes.
>>
>> Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
>> msi-map property.
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> ---
>>   .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 30 +++++++++++++++++--
>>   1 file changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> index 9134e9bcca56..b0813b2d0493 100644
>> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> @@ -18,9 +18,9 @@ same hardware "isolation context" and a 10-bit value called an ICID
>>   the requester.
>>
>>   The generic 'iommus' property is insufficient to describe the relationship
>> -between ICIDs and IOMMUs, so an iommu-map property is used to define
>> -the set of possible ICIDs under a root DPRC and how they map to
>> -an IOMMU.
>> +between ICIDs and IOMMUs, so the iommu-map and msi-map properties are used
>> +to define the set of possible ICIDs under a root DPRC and how they map to
>> +an IOMMU and a GIC ITS respectively.
>>
>>   For generic IOMMU bindings, see
>>   Documentation/devicetree/bindings/iommu/iommu.txt.
>> @@ -28,6 +28,9 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
>>   For arm-smmu binding, see:
>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
>>
>> +For GICv3 and GIC ITS bindings, see:
>> +Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
>> +
>>   Required properties:
>>
>>       - compatible
>> @@ -119,6 +122,15 @@ Optional properties:
>>     associated with the listed IOMMU, with the iommu-specifier
>>     (i - icid-base + iommu-base).
>>
>> +- msi-map: Maps an ICID to a GIC ITS and associated iommu-specifier
>> +  data.
>> +
>> +  The property is an arbitrary number of tuples of
>> +  (icid-base,iommu,iommu-base,length).
> 
> I'm confused because the example has GIC ITS phandle, not an IOMMU.
> 
> What is an iommu-base?

Right, I was already halfway through writing a reply to say that all the 
copy-pasted "iommu" references here should be using the terminology from 
the pci-msi.txt binding instead.

>> +
>> +  Any ICID in the interval [icid-base, icid-base + length) is
>> +  associated with the listed GIC ITS, with the iommu-specifier
>> +  (i - icid-base + iommu-base).
>>   Example:
>>
>>           smmu: iommu@5000000 {
>> @@ -128,6 +140,16 @@ Example:
>>                  ...
>>           };
>>
>> +       gic: interrupt-controller@6000000 {
>> +               compatible = "arm,gic-v3";
>> +               ...
>> +               its: gic-its@6020000 {
>> +                       compatible = "arm,gic-v3-its";
>> +                       msi-controller;
>> +                       ...
>> +               };
>> +       };
>> +
>>           fsl_mc: fsl-mc@80c000000 {
>>                   compatible = "fsl,qoriq-mc";
>>                   reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
>> @@ -135,6 +157,8 @@ Example:
>>                   msi-parent = <&its>;

Side note: is it right to keep msi-parent here? It rather implies that 
the MC itself has a 'native' Device ID rather than an ICID, which I 
believe is not strictly true. Plus it's extra-confusing that it doesn't 
specify an ID either way, since that makes it look like the legacy PCI 
case that gets treated implicitly as an identity msi-map, which makes no 
sense at all to combine with an actual msi-map.

>>                   /* define map for ICIDs 23-64 */
>>                   iommu-map = <23 &smmu 23 41>;
>> +                /* define msi map for ICIDs 23-64 */
>> +                msi-map = <23 &its 23 41>;
> 
> Seeing 23 twice is odd. The numbers to the right of 'its' should be an
> ITS number space.

On about 99% of systems the values in the SMMU Stream ID and ITS Device 
ID spaces are going to be the same. Nobody's going to bother carrying 
*two* sets of sideband data across the interconnect if they don't have to ;)

Robin.

>>                   #address-cells = <3>;
>>                   #size-cells = <1>;
>>
>> --
>> 2.26.1
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
