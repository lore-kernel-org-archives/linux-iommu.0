From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V2 1/3] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Wed, 8 Feb 2017 19:15:37 +0530
Message-ID: <000301d28211$a5233a90$ef69afb0$@codeaurora.org>
References: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
	<1486055420-19671-2-git-send-email-sricharan@codeaurora.org>
	<20170202174218.GO31394@leverpostej>
	<017701d281f9$927c5fb0$b7751f10$@codeaurora.org>
	<20170208114002.GD15459@leverpostej>
	<018401d28207$34db60a0$9e9221e0$@codeaurora.org>
	<b55359d8-2665-aef0-3215-53a0e8f21bcd@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b55359d8-2665-aef0-3215-53a0e8f21bcd-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>, 'Mark Rutland' <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

>>>>> On Thu, Feb 02, 2017 at 10:40:18PM +0530, Sricharan R wrote:
>>>>>> +- clock-names:    Should be a pair of "smmu_iface_clk" and "smmu_bus_clk"
>>>>>> +                  required for smmu's register group access and interface
>>>>>> +                  clk for the smmu's underlying bus access.
>>>>>> +
>>>>>> +- clocks:         Phandles for respective clocks described by clock-names.
>>>>>
>>>>> Which SMMU implementations are those clock-names valid for?
>>>>>
>>>>> The SMMU architecture specifications do not architect the clocks, which
>>>>> are implemementation-specific.
>>>>>
>>>>> AFAICT, this doesn't match MMU-400 or MMU-500.
>>>>
>>>> Ok, should be more specific. Infact QCOM has MMU-500 and also
>>>> a smmu v2 implementation which is fully compatible with
>>>> "arm,smmu-v2", with the clocks being controlled by the soc's
>>>> clock controller. i was trying to define these clock bindings
>>>> so that its works across socs.
>>>
>>> I don't think we can do that, if we don't know precisely what those
>>> clocks are used for.
>>>
>>> i.e. we'd need a compatible string for the QCOM SMMUv2 variant, which
>>> would imply the set of clocks.
>>>
>>
>> Ok, this was what i was trying to do for V3 and will actually put it
>> this way.
>
>Clocks are not architectural, so it only makes sense to associate them
>with an implementation-specific compatible string. There's also no

ok, it for this the QCOM specific implementation binding is tried(going to).

>guarantee that different microarchitectures have equivalent internal
>clock domains - I'm not sure if "the SMMU's underlying bus access" is
>meant to refer to accesses *by* the SMMU, i.e. page table walks,
>accesses *through* the SMMU by upstream masters, or both

In the above QCOM case, it is actually both. Its the same path for both the
page table walker and upstream masters.

>differences are rather significant. I'd also note that an MMU-500
>configuration may have up to *33* clocks.
>
>Either way, the QCOM implementation deserves its own compatible if only
>for the sake of the imp-def gaps in the architecture (e.g. FSR.SS
>behaviour WRT to IRQs as touched upon in the other thread).
>

Ok, slightly unclear, so you mean then *clocks* are not good enough reason
to have a new compatible ?

Regards,
 Sricharan





>Robin.
>
>>>> But just thinking if it would scale well for any other soc that is
>>>> compatible with arm,smmu-v2 driver and wants to handle clocks in the
>>>> future ?
>>>
>>> I don't think we can have our cake and eat it here. Either we handle the
>>> clock management for each variant, or we don't do it at all. We have no
>>> idea what requirements a future variant might have w.r.t. the management
>>> of clocks we don't know about yet.
>>>
>>
>> Right, at this point, this is first soc which adds the clocks in to the driver.
>> Feels if the clocks are initialized and enabled/disabled as a part of some
>> implementation specific callbacks, that would help always because that is
>> the part which is going to different for each implementation and patches 2,3
>> would remain common. Finally, as you have suggested will introduce new
>> SMMU binding in the case of QCOM and will try to handle clocks specifically for that
>> implementation and see how it looks.
>>
>> Regards,
>>  Sricharan
