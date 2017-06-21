From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v8 3/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #126
Date: Wed, 21 Jun 2017 10:30:39 +0100
Message-ID: <2e334fe2-864e-d2b9-1699-20aee5d26007@arm.com>
References: <1497968259-16390-1-git-send-email-gakula@caviumnetworks.com>
 <1497968259-16390-4-git-send-email-gakula@caviumnetworks.com>
 <20170620180038.GC28035@arm.com>
 <CANHdaiYb8gG5+OjiSBkSGfyNnt4=WDze08qW1JXA9-F66HE9ZA@mail.gmail.com>
 <20170621090835.GD3768@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170621090835.GD3768@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Geetha Akula <geethasowjanya.akula@gmail.com>
Cc: Geetha sowjanya <gakula@caviumnetworks.com>, Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, jcm@redhat.com, linux-kernel@vger.kernel.org, Robert Richter <robert.richter@cavium.com>, Catalin Marinas <catalin.marinas@arm.com>, Sunil Goutham <sgoutham@cavium.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, devel@acpica.org, Linu Cherian <linu.cherian@cavium.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh@kernel.org>, Geetha Sowjanya <geet>
List-Id: iommu@lists.linux-foundation.org

On 21/06/17 10:08, Will Deacon wrote:
> Hi Geetha,
> 
> On Wed, Jun 21, 2017 at 12:09:45PM +0530, Geetha Akula wrote:
>> On Tue, Jun 20, 2017 at 11:30 PM, Will Deacon <will.deacon@arm.com> wrote:
>>> On Tue, Jun 20, 2017 at 07:47:39PM +0530, Geetha sowjanya wrote:
>>>> From: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
>>>>
>>>> Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
>>>> lines for gerror, eventq and cmdq-sync.
>>>>
>>>> SHARED_IRQ option is set as a errata workaround, which allows to share the irq
>>>> line by register single irq handler for all the interrupts.
>>>>
>>>> Signed-off-by: Geetha sowjanya <gakula@caviumnetworks.com>
>>>> ---
>>>>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    5 ++
>>>>  drivers/iommu/arm-smmu-v3.c                        |   73 ++++++++++++++++----
>>>>  2 files changed, 64 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>>> index 6ecc48c..44b40e0 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>>>> @@ -55,6 +55,11 @@ the PCIe specification.
>>>>                     Set for Caviun ThunderX2 silicon that doesn't support
>>>>                     SMMU page1 register space.
>>>>
>>>> +- cavium,cn9900-broken-unique-irqline
>>>> +                    : Use single irq line for all the SMMUv3 interrupts.
>>>> +                   Set for Caviun ThunderX2 silicon that doesn't support
>>>> +                   MSI and also doesn't have unique irq lines for gerror,
>>>> +                   eventq and cmdq-sync.
>>>
>>> I think we're better off just supporting a new (optional) named interrupt
>>> as "combined", and then allowing that to be used instead of the others.
>>
>> Are you suggesting to have new name irq "combined" like gerror ?
>> If yes, then this won't be possible with apci. We need to update iort spec to
>> add new name irq.
> 
> I'm mainly talking about the DT binding here, but I don't see why you
> can't hack drivers/acpi/arm64/iort.c like you did for the other erratum and
> have it register a single interrupt called "combined" based on the model
> number.
> 
>>>> +                                     arm_smmu_shared_irq_thread,
>>>> +                                     IRQF_ONESHOT | IRQF_SHARED,
>>>
>>> Why do you need IRQF_SHARED here?
>>
>>
>> +devm_request_threaded_irq(smmu->dev, irq,
>> +                                       arm_smmu_combined_irq_handler,
>> +                                       arm_smmu_combined_irq_thread,
>> +                                       IRQF_SHARED,
>> +                                       "arm-smmu-v3-combined-irq", smmu);
>>
>> On multi-node system, node1 SMMU's share irq lines with node0 SMMU's.
> 
> How does that work? Are these really MSIs under the hood? If so, why didn't
> you just build them as... MSIs?

More specifically, I suspect that they are made out of message-signalled
SPIs, targeting the GIC distributor directly... That's the only way I
can imagine it has been built... If I'm right, we probably have the
firmware programming the same SPI number in both nodes.

But of course, that's pure speculation.

	M.
-- 
Jazz is not dead. It just smells funny...
