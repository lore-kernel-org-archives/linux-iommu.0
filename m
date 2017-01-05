From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 02/10] iommu/of: Prepare for deferred IOMMU configuration
Date: Thu, 5 Jan 2017 13:52:29 +0000
Message-ID: <7cd7bcfb-abae-2948-c3f8-230c0d9c9db6@arm.com>
References: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
	<1480465344-11862-3-git-send-email-sricharan@codeaurora.org>
	<20161130161723.GA9042@red-moon>
	<c89825aa-c75f-8493-fe92-7cc97f525bc7@arm.com>
	<20161201112917.GA9680@red-moon>
	<003601d2672e$91744b40$b45ce1c0$@codeaurora.org>
	<20170105122714.GA30449@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170105122714.GA30449@red-moon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/01/17 12:27, Lorenzo Pieralisi wrote:
> On Thu, Jan 05, 2017 at 02:04:37PM +0530, Sricharan wrote:
>> Hi Robin/Lorenzo,
>>
>>> Hi Robin,Lorenzo,
>>>
>>>> On Wed, Nov 30, 2016 at 04:42:27PM +0000, Robin Murphy wrote:
>>>>> On 30/11/16 16:17, Lorenzo Pieralisi wrote:
>>>>>> Sricharan, Robin,
>>>>>>
>>>>>> I gave this series a go on ACPI and apart from an SMMU v3 fix-up
>>>>>> it seems to work, more thorough testing required though.
>>>>>>
>>>>>> A key question below.
>>>>>>
>>>>>> On Wed, Nov 30, 2016 at 05:52:16AM +0530, Sricharan R wrote:
>>>>>>> From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>>>>>>
>>>>>>> IOMMU configuration represents unchanging properties of the hardware,
>>>>>>> and as such should only need happen once in a device's lifetime, but
>>>>>>> the necessary interaction with the IOMMU device and driver complicates
>>>>>>> exactly when that point should be.
>>>>>>>
>>>>>>> Since the only reasonable tool available for handling the inter-device
>>>>>>> dependency is probe deferral, we need to prepare of_iommu_configure()
>>>>>>> to run later than it is currently called (i.e. at driver probe rather
>>>>>>> than device creation), to handle being retried, and to tell whether a
>>>>>>> not-yet present IOMMU should be waited for or skipped (by virtue of
>>>>>>> having declared a built-in driver or not).
>>>>>>>
>>>>>>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>>>>>>> ---
>>>>>>>  drivers/iommu/of_iommu.c | 30 +++++++++++++++++++++++++++++-
>>>>>>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>>>>>>> index ee49081..349bd1d 100644
>>>>>>> --- a/drivers/iommu/of_iommu.c
>>>>>>> +++ b/drivers/iommu/of_iommu.c
>>>>>>> @@ -104,12 +104,20 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
>>>>>>>  	int err;
>>>>>>>
>>>>>>>  	ops = iommu_get_instance(fwnode);
>>>>>>> -	if (!ops || !ops->of_xlate)
>>>>>>> +	if ((ops && !ops->of_xlate) ||
>>>>>>> +	    (!ops && !of_match_node(&__iommu_of_table, iommu_spec->np)))
>>>>>>
>>>>>> IIUC of_match_node() here is there to check there is a driver compiled
>>>>>> in for this device_node (aka compatible string in OF world), correct ?
>>>>>
>>>>> Yes - specifically, it's checking the magic table for a matching
>>>>> IOMMU_OF_DECLARE entry.
>>>>>
>>>>>> If that's the case (and I think that's what Sricharan was referring to
>>>>>> in his ACPI query) I need to cook-up something on the ACPI side to
>>>>>> emulate the OF linker table behaviour (or anyway to detect a driver is
>>>>>> actually in the kernel), it is not that difficult but it is key to know,
>>>>>> I will give it some thought to make it as clean as possible.
>>>>>
>>>>> I didn't think this would be a concern for ACPI, since IORT works much
>>>>> the same way the current of_iommu_init_fn/of_platform_device_create()
>>>>> bodges in drivers so for DT. If you can only discover SMMUs from IORT,
>>>>> then iort_init_platform_devices() will have already created every SMMU
>>>>> that's going to exist before discovering other devices from wherever
>>>>> they come from, thus you could never get into the situation of probing a
>>>>> device without its SMMU being ready (if it's ever going to be). Is that
>>>>> not right?
>>>>
>>>> It is right, my point and question is: we are probing a device and we
>>>> have to know whether it is worth deferring its IOMMU DMA setup. On DT,
>>>> through of_match_node(&__iommu_of_table, iommu_device_node) we check at
>>>> once that:
>>>>
>>>> 1 - A device for the IOMMU exists
>>>>
>>>> AND
>>>>
>>>> 2 - A driver for the IOMMU is compiled in the kernel
>>>>
>>>> Is this correct ? As you said (1) is not a concern on ACPI IORT (because
>>>> we create the IOMMU device before _any_ other device so either the IOMMU
>>>> device is there or it will never be by the time master devices are
>>>> probed), but for (2) I need to slightly change how the IORT linker entry
>>>> work to make sure we can detect a driver is actually compiled in the
>>>> kernel, it is easy, I was just asking if my understanding was correct
>>>> and I think that was what Sricharan was referring to in his query.
>>>>
>>>
>>> Yes right, this was what i was looking for in the ACPI case and putting this
>>> in the iort_iommu_xlate was needed to return EPROBE_DEFER when the
>>> driver is not yet been probed.
>>
>> With the thinking of taking this series through, would it be fine if i
>> cleanup the pci configure hanging outside and push it in to
>> of/acpi_iommu configure respectively ? This time with all neeeded for
>> ACPI added as well.  Also on the last post of V4, Lorenzo commented
>> that it worked for him, although still the of_match_node equivalent in
>> ACPI has to be added. If i can get that, then i will add that as well
>> to make this complete.
> 
> Question: I had a look into this and instead of fiddling about with the
> linker script entries in ACPI (ie IORT_ACPI_DECLARE - which I hope this
> patchset would help remove entirely), I think that the only check we
> need in IORT is, depending on what type of SMMU a given device is
> connected to, to check if the respective SMMU driver is compiled in the
> kernel and it will be probed, _eventually_.
> 
> As Robin said, by the time a device is probed the respective SMMU
> devices are already created and registered with IORT kernel code or
> they will never be, so to understand if we should defer probing
> SMMU device creation is _not_ really a problem in ACPI.
> 
> To check if a SMMU driver is enabled, do we really need a linker
> table ?
> 
> Would not a check based on eg:
> 
> /**
>  * @type: IOMMU IORT node type of the IOMMU a device is connected to
>  */
> static bool iort_iommu_driver_enabled(u8 type)
> {
> 	switch (type) {
> 	case ACPI_IORT_SMMU_V3:
> 		return IS_ENABLED(CONFIG_ARM_SMMU_V3);

IS_BUILTIN(...)

> 	case ACPI_IORT_SMMU:
> 		return IS_ENABLED(CONFIG_ARM_SMMU);
> 	default:
> 		pr_warn("Unknown IORT SMMU type\n");

Might displaying the actual value be helfpul for debugging a broken IORT
table?

> 		return false;
> 	}
> }
> 
> be sufficient (it is a bit gross, agreed, but it is to understand if
> that's all we need) ? Is there anything I am missing ?
> 
> Let me know, I will put together a patch for you I really do not
> want to block your series for this trivial niggle.

Other than that, though, I like it :) IORT has a small, strictly
bounded, set of supported devices, so I really don't see the need to go
overboard putting it on parity with DT when something this neat and
simple will suffice.

Robin.

> 
> Thanks,
> Lorenzo
> 
