Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A37C3815B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E039E20784
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 17:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E039E20784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9C0348614E;
	Wed, 15 Apr 2020 17:31:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ZGgoaNy5jA8; Wed, 15 Apr 2020 17:31:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 58FFA86148;
	Wed, 15 Apr 2020 17:31:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C9B4C089E;
	Wed, 15 Apr 2020 17:31:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0EA7C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 17:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A3C7821511
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 17:31:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0lrEOSzN+G8X for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 17:31:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 7A94F214E6
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 17:31:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 753D41FB;
 Wed, 15 Apr 2020 10:31:52 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D6613F68F;
 Wed, 15 Apr 2020 10:31:46 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
 <20200325125109.GA5430@red-moon.cambridge.arm.com>
 <499fbf9a-416f-d7c7-0655-881d92138a6c@nxp.com>
 <20200414143211.GA14905@red-moon.cambridge.arm.com>
 <d37ca4e3-58cb-9d6f-3a98-5e4a21ca948b@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <78086898-d54f-63d0-f1f4-301ef2a8ea83@arm.com>
Date: Wed, 15 Apr 2020 18:31:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d37ca4e3-58cb-9d6f-3a98-5e4a21ca948b@nxp.com>
Content-Language: en-GB
Cc: calvin.johnson@nxp.com, ard.biesheuvel@linaro.org, maz@kernel.org,
 pankaj.bansal@nxp.com, diana.craciun@oss.nxp.com, jon@solid-run.com,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 cristian.sovaiala@nxp.com, jason@lakedaemon.net, V.Sethi@nxp.com,
 ioana.ciornei@nxp.com, tglx@linutronix.de, makarand.pawagi@nxp.com,
 linux-arm-kernel@lists.infradead.org, Stuart.Yoder@arm.com
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

On 2020-04-15 4:44 pm, Laurentiu Tudor wrote:
> 
> 
> On 4/14/2020 5:32 PM, Lorenzo Pieralisi wrote:
>> On Wed, Mar 25, 2020 at 06:48:55PM +0200, Laurentiu Tudor wrote:
>>> Hi Lorenzo,
>>>
>>> On 3/25/2020 2:51 PM, Lorenzo Pieralisi wrote:
>>>> On Thu, Feb 27, 2020 at 12:05:39PM +0200, laurentiu.tudor@nxp.com wrote:
>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>
>>>>> The devices on this bus are not discovered by way of device tree
>>>>> but by queries to the firmware. It makes little sense to trick the
>>>>> generic of layer into thinking that these devices are of related so
>>>>> that we can get our dma configuration. Instead of doing that, add
>>>>> our custom dma configuration implementation.
>>>>>
>>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>> ---
>>>>>   drivers/bus/fsl-mc/fsl-mc-bus.c | 31 ++++++++++++++++++++++++++++++-
>>>>>   1 file changed, 30 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>> index 36eb25f82c8e..eafaa0e0b906 100644
>>>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>> @@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>>>>>   static int fsl_mc_dma_configure(struct device *dev)
>>>>>   {
>>>>>   	struct device *dma_dev = dev;
>>>>> +	struct iommu_fwspec *fwspec;
>>>>> +	const struct iommu_ops *iommu_ops;
>>>>> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
>>>>> +	int ret;
>>>>> +	u32 icid;
>>>>>   
>>>>>   	while (dev_is_fsl_mc(dma_dev))
>>>>>   		dma_dev = dma_dev->parent;
>>>>>   
>>>>> -	return of_dma_configure(dev, dma_dev->of_node, 0);
>>>>> +	fwspec = dev_iommu_fwspec_get(dma_dev);
>>>>> +	if (!fwspec)
>>>>> +		return -ENODEV;
>>>>> +	iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
>>>>> +	if (!iommu_ops)
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	icid = mc_dev->icid;
>>>>> +	ret = iommu_fwspec_add_ids(dev, &icid, 1);
>>>>
>>>> I see. So with this patch we would use the MC named component only to
>>>> retrieve the iommu_ops
>>>
>>> Right. I'd also add that the implementation tries to follow the existing
>>> standard .dma_configure implementations, e.g. of_dma_configure +
>>> of_iommu_configure. I'd also note that similarly to the ACPI case, this
>>> MC FW device is probed as a platform device in the DT scenario, binding
>>> here [1].
>>> A similar approach is used for the retrieval of the msi irq domain, see
>>> following patch.
>>>
>>>> - the streamid are injected directly here bypassing OF/IORT bindings translations altogether.
>>>
>>> Actually I've submitted a v2 [2] that calls into .of_xlate() to allow
>>> the smmu driver to do some processing on the raw streamid coming from
>>> the firmware. I have not yet tested this with ACPI but expect it to
>>> work, however, it's debatable how valid is this approach in the context
>>> of ACPI.
>>
>> Actually, what I think you need is of_map_rid() (and an IORT
>> equivalent, that I am going to write - generalizing iort_msi_map_rid()).
>>
>> Would that be enough to enable IORT "normal" mappings in the MC bus
>> named components ?
>>
> 
> At a first glance, looks like this could very well fix the ACPI
> scenario, but I have some unclarities on the approach:
>   * are we going to rely in DT and ACPI generic layers even if these
> devices are not published / enumerated through DT or ACPI tables?

Assuming you mean the DPRC devices rather than the MC itself, then yes; 
in that sense it's exactly the same as how we treat 
dynamically-discovered PCI devices.

>   * the firmware manages and provides discrete streamids for the devices
> it exposes so there's no translation involved. There's no
>     requestor_id / input_id involved but it seems that we would still do
> some kind of translation relying for this on the DT/ACPI functions.

Wrong - last time I looked, what that firmware actually manages are 
*ICIDs* for the devices, not SMMU Stream IDs or GIC Device IDs; what 
DT/ACPI specifies is a translation from ICID to Stream ID/Device ID. The 
ICID is very much the requester/input ID for that translation. Yes, in 
practice the "translation" is effectively always a trivial identity 
mapping, but conceptually it most definitely exists. Yes, the subtlety 
is incredibly easy to overlook because it's basically drawing a 
distinction between one end of some wires vs. the other end, but it matters.

(and of course "trivial 1:1 translation" isn't even true in the case of 
SMMU Stream ID values, since IIRC they are really composed of 5 
different inputs, only one of which is (part of) the incoming ICID)

>   * MC firmware has its own stream_id (e.g. on some chips 0x4000, others
> 0xf00, so outside the range of stream_ids used for the mc devices)
>     while for the devices on this bus, MC allocates stream_ids from a
> range (e.g. 0x17 - 0x3f). Is it possible to describe this in the IORT table?

If it represents a unique ICID allocated to the MC itself, then sure, it 
simply goes through the mapping like anything else. Just like a PCI host 
bridge owns requester ID 0:0.0 and thus whatever Stream ID/Device ID 
that might map to.

If (for the sake of argument, because AIUI everything is an ICID in this 
particular case) it's some hard-wired thing that exists in Stream 
ID/Device ID space only, then it's a little trickier, but still in 
scope. In DT we have a lovely distinction between between "originating 
from the node" and "translated through the node", e.g. "msi-parent" vs. 
"msi-map"; IORT is not quite as clear-cut, but there are at least a few 
options. If the valid input ID space is smaller than 32 bits, then the 
"Named Component as bridge" binding could simply define special 
out-of-range values to represent IDs originating from the bridge itself, 
such that the NC driver knows what to do and from IORT's point of view 
everything is just a normal mapping. Alternatively there's already the 
example of SMMUv3 where we can have a mix of the normal mappings from 
Stream ID to Device ID for the upstream masters plus a single mapping 
for the SMMU's own Device ID - admittedly that depends on the additional 
SMMUv3-specific Device ID Mapping Index property, but if necessary it 
might be workable to have a de-facto interface for NCs that only 
considers single mappings when configuring the NC itself, and only 
considers normal mappings when configuring its children. Or maybe define 
a new mapping flag or NC property if there's a real need to specify such 
a situation unambiguously at the IORT level.

>   * Regarding the of_map_rid() use you mentioned, I was planning to
> decouple the mc bus from the DT layer by dropping the use of
> of_map_rid(), see patch 4.
> I briefly glanced over the iort code and spotted this static function:
> iort_iommu_xlate(). Wouldn't it also help, of course after making it public?

I won't speak for Lorenzo or claim we've agreed on an approach at all 
(not least because in all honesty we haven't really discussed it beyond 
these various email threads), but FWIW my vision is that ultimately the 
DT/ACPI code would expose a *_dma_configure() interface that takes an 
optional input ID, or (perhaps more likely) an explicit pair of 
interfaces for "configure this regular device" and "configure this 
device based on this 'host' device and this ID", and it becomes the bus 
code's responsibility to pass the right device(s) and deal with multiple 
IDs (i.e. for starters all the PCI alias stuff goes back to the PCI code 
where it really should be, rather than having multiple copies of magic 
PCI awareness deep down in DT/ACPI code).

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
