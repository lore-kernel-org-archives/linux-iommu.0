From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] documentation: iommu: add description of ARM System MMU
	binding
Date: Mon, 08 Apr 2013 10:03:54 -0700
Message-ID: <5162F87A.7070409@codeaurora.org>
References: <1365094259-24847-1-git-send-email-will.deacon@arm.com>
	<515F37C1.4000109@codeaurora.org>
	<20130408092535.GA17476@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130408092535.GA17476-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 4/8/2013 2:25 AM, Will Deacon wrote:
> Hi Olav,
> 
> On Fri, Apr 05, 2013 at 09:44:49PM +0100, Olav Haugan wrote:
>> On 4/4/2013 9:50 AM, Will Deacon wrote:
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>> new file mode 100644
>>> index 0000000..938325f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>>> @@ -0,0 +1,61 @@
>>> +* ARM System MMU Architecture Implementation
>>> +
>>> +ARM SoCs may contain an implementation of the ARM System Memory
>>> +Management Unit Architecture, which can be used to provide 1 or 2 stages
>>> +of address translation to bus masters external to the CPU.
>>> +
>>> +The SMMU may also raise interrupts in response to various fault
>>> +conditions.
>>> +
>>> +** System MMU required properties:
>>> +
>>> +- compatible    : Should be one of "arm,smmu-v1" or "arm,smmu-v2"
>>> +                  depending on the version of the architecture
>>> +                  implemented.
>>> +
>>> +- reg           : Base address and size of the SMMU.
>>> +
>>> +- #global-interrupts : The number of global interrupts exposed by the
>>> +                       device.
>>> +
>>> +- interrupts    : Interrupt list, with the first #global-irqs entries
>>> +                  corresponding to the global interrupts and any
>>> +                  following entries corresponding to context interrupts,
>>> +                  specified in order of their indexing by the SMMU.
>>> +
>>> +- mmu-masters   : A list of phandles to device nodes representing bus
>>> +                  masters for which the SMMU can provide a translation.
>>
>> I am not sure I understand the use of mmu-masters. I would imagine that
>> the bus masters themselves would have phandles to their respective SMMUs
>> that provides the translation.
> 
> The problem with that is when you have chained SMMUs. E.g., a separate SMMU
> for stage 1 and stage 2, where the StreamIDs are not the same going into the
> second SMMU on the chain. The set of masters and StreamIDs coming into a
> system MMU is really a property of that system MMU, and is determined at
> integration time.
> 
>>> +
>>> +- stream-ids    : A list of 16-bit values corresponding to the StreamIDs
>>> +                  for the devices listed in the mmu-masters property.
>>> +                  This list must be same length as mmu-masters, so
>>> +                  masters with multiple stream-ids will have multiple
>>> +                  entries in mmu-masters.
>>> +
>>
>> Why are the stream IDs (SIDs) coupled with the bus masters in this way?
>> You are probably following a different pattern than we do. Our SMMU
>> driver programs the SMMU SIDs and does not really know or care which
>> mmu-master it belongs to.
> 
> Generally, the StreamIDs are fixed in hardware (as a function of various AXI
> bits -- see the SMMU integration guide) and cannot be set by software.
> Furthermore, when the StreamIDs have an implicit effect on IOMMU domain
> configuration, since stream-matching may not be always be able to identify a
> master uniquely.

Let me clarify what I mean by "our SMMU driver programs the SMMU SIDs".
What I meant to say is that our SMMU driver programs the SID into the
Stream Match Register (SMR) to route the transactions to the correct
context bank based on the SID.

>> Please see my comments above. I would like to work with you on defining
>> the bindings for System MMU. We have had System MMU DT bindings for some
>> time and I'd like to share what we are doing in hope that we can merge
>> something that works for all of us.
>>
>> We use some of the same properties but we have a lot more. We also model
>> the context banks as children of each SMMU in an object-oriented way.
> 
> Hmm, what you have looks really... complicated. Why do you need so much stuff?

Yes, some of the stuff is implementation specific.

>> Here is our current binding for SMMUv1:
>>
>> * Qualcomm MSM IOMMU v1
>>
>> Required properties:
>> - compatible : one of:
>> 	- "qcom,msm-smmu-v1"
>> - reg : offset and length of the register set for the device. Optional
>> 	offset and length for clock register for additional clock that
>> 	needs to be turned on for access to this IOMMU.
>> - reg-names: "iommu_base", "clk_base" (optional)
> 
> Since I'm just working on a software model, I've not gone near clocks.
> However, clocks are fairly well understood so we could easily add those
> later if they're needed.
> 
>> - label: name of this IOMMU instance.
> 
> What?

This is mostly used for debugging allowing us to log a name that is more
user friendly instead of something like "fda64000.qcom,iommu" as the
device name. We also use this to create debugfs directory with a user
friendly name.

> 
>> Optional properties:
>> - qcom,iommu-secure-id : Secure identifier for the IOMMU block
>> - vdd-supply : vdd-supply: phandle to GDSC regulator controlling this IOMMU.
>> - qcom,alt-vdd-supply : Alternative regulator needed to access IOMMU
>>   configuration registers.
>> - interrupts : should contain the performance monitor overflow interrupt
>> number.
>> - qcom,iommu-enable-halt : Enable halt of the IOMMU before programming
>> certain	registers
>> - qcom,iommu-pmu-ngroups: Number of Performance Monitor Unit (PMU) groups.
>> - qcom,iommu-pmu-ncounters: Number of PMU counters per group.
>> - qcom,iommu-pmu-event-classes: List of event classes supported.
>> - qcom,needs-alt-core-clk : boolean to enable the secondary core clock
>> for access to the IOMMU configuration registers
>> - qcom,iommu-bfb-regs : An array of unsigned 32-bit integers
>> corresponding to BFB register addresses that need to be configured for
>> performance tuning purposes. If this property is present, the
>> qcom,iommu-bfb-data must also be present. Register addresses are
>> specified as an offset from the base of the IOMMU hardware block. This
>> property may be omitted if no BFB register configuration needs to be
>> done for a particular IOMMU hardware instance. The registers specified
>> by this property shall fall within the IOMMU implementation-defined
>> register region.
>> - qcom,iommu-bfb-data : An array of unsigned 32-bit integers
>> representing the values to be programmed into the corresponding
>> registers given by the qcom,iommu-bfb-regs property. If this property is
>> present, the qcom,iommu-bfb-regs property shall also be present, and the
>> lengths of both properties shall be the same.
> 
> This really looks specific to your implementation/integration and I can't
> see that we'd want this in the binding to be honest. It would be good to
> have PMU support in the future, but I've not thought about that part yet.

Yes, some of this is specific to our implementation. However, the
properties related to regulators and PMU are not specific I believe. How
do you do handle regulators?

>> - List of sub nodes, one for each of the translation context banks
>> supported.
>>   Each sub node has the following required properties:
>>
>>   - reg : offset and length of the register set for the context bank.
> 
> Why do you need this? The structure of the context banks is well defined by
> the SMMU architecture.

Since we specify the context banks as children of the IOMMU we specify
the address of each node. I believe you should be specifying the "reg"
property for the nodes when you do this.

>>   - interrupts : should contain the context bank interrupt.
>>   - qcom,iommu-ctx-sids : List of stream identifiers associated with
>> this translation context.
> 
> StreamIDs aren't statically associated with a translation context. Why do
> you put them here? Also, how do this interact with stream matching?

We put the StreamIDs in the context bank to tell our driver that these
StreamIDs should be programmed into the Stream Match Register (SMR) to
route the transactions bearing these StreamIDs to this context bank. We
don't really change the SID2CB mapping during run-time. It is set during
compile time.

>>   - label : Name of the context bank
> 
> Again: what?

Same idea as the label in the IOMMU parent node. We also use this to
allow clients to find context bank devices to attach to based on the name.

>> Optional sub-node properties:
>>    - qcom,secure-context : boolean indicating that a context is secure
>>  and programmed by the secure environment.
> 
> Why does Linux care about this?

Linux cares about this because if we are doing content protection using
one of the context banks then the context bank is programmed by the
secure environment and not accessible/programmable by the HLOS.

> 
>> Please let me know your thoughts on this.
> 
> I'd really rather start off small, and describe precisely what we need to
> get architecturally-compliant SMMUs off the ground. Then, as the code grows
> to use more features (PM, PMU, ...) then we can extend the binding.
> Otherwise, we paint ourselves into a corner with the binding before we've
> developed any driver code.

Sure, I did not mean to add implementation specific stuff to upstream
bindings. Does it makes sense to you thought the way we modeled context
banks as child nodes?

Thanks,

Olav Haugan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
