From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Report smmu type in dmesg
Date: Thu, 9 Mar 2017 12:25:46 +0000
Message-ID: <56bfa59e-b387-90e8-c2cc-1628495bf2af@arm.com>
References: <20170306135833.21455-1-rrichter@cavium.com>
	<d055d4c2-4d06-caba-4d84-21c22718fe76@arm.com>
	<20170307140607.GY16822@rric.localdomain>
	<bdf70e78-5ffd-4458-f485-4a508705e3e6@arm.com>
	<20170309120206.GP16822@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170309120206.GP16822-vWBEXY7mpu582hYKe6nXyg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robert Richter <robert.richter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/03/17 12:02, Robert Richter wrote:
> On 07.03.17 18:41:33, Robin Murphy wrote:
>> On 07/03/17 14:06, Robert Richter wrote:
>>> On 06.03.17 18:22:08, Robin Murphy wrote:
>>>> On 06/03/17 13:58, Robert Richter wrote:
>>>>> The ARM SMMU detection especially depends from system firmware. For
>>>>> better diagnostic, log the detected type in dmesg.
>>>>
>>>> This paragraph especially depends from grammar. I think.
>>>
>>> Thanks for the mail on you. :)
>>>
>>>>
>>>>> The smmu type's name is now stored in struct arm_smmu_type and ACPI
>>>>> code is modified to use that struct too. Rename ARM_SMMU_MATCH_DATA()
>>>>> macro to ARM_SMMU_TYPE() for better readability.
>>>>>
>>>>> Signed-off-by: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>>>>> ---
>>>>>  drivers/iommu/arm-smmu.c | 61 ++++++++++++++++++++++++------------------------
>>>>>  1 file changed, 30 insertions(+), 31 deletions(-)
>>>>
>>>> That seems a relatively invasive diffstat for the sake of printing a
>>>> string once at boot time to what I can only assume is a small audience
>>>> of firmware developers who find "cat
>>>> /sys/firmware/devicetree/base/iommu*/compatible" (or the ACPI
>>>> equivalent) too hard ;)
>>>
>>> Reading firmware data is not really a solution as you don't know what
>>> the driver is doing with it. The actual background of this patch is to
>>> be sure a certain workaround was enabled in the kernel. ARM's cpu
>>> errata framework does this nicely. In case of smmus we just have the
>>> internal model implementation type which is not visible in the logs.
>>> Right now, there is no way to figure that out without knowing fw
>>> specifics and kernel sources.
>>
>> Ah, now it starts to become clear. In that case, if we want to confirm
>> the presence of specific workarounds, we should actually _confirm the
>> presence of specific workarounds_. I'd have no complaint with e.g. this:
>>
>> -----8<-----
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index f7411109670f..9e50a092632c 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1934,6 +1934,8 @@ static int arm_smmu_device_cfg_probe(struct
>> arm_smmu_device *smmu)
>>                         atomic_add_return(smmu->num_context_banks,
>>                                           &cavium_smmu_context_count);
>>                 smmu->cavium_id_base -= smmu->num_context_banks;
>> +               dev_notice(smmu->dev, "\tusing ASID/VMID offset %u\n",
>> +                          smmu->cavium_id_base);
>>         }
>>
>>         /* ID2 */
>> ----->8-----
>>
>> and the equivalent for other things, if need be. If you just print "hey,
>> this is SMMU-x", the user is in fact no better off, since they would
>> then still have to go and look at the source for whatever kernel they're
>> running to find out which particular workarounds for SMMU-x bugs that
>> particular kernel implements.
> 
> I don't understand why you don't want to expose in some way the smmu
> type. There are a lot of things that can go wrong, esp. with firmware,
> to detect the proper smmu type.

Because there is only one reason for which detecting the "proper SMMU
type" matters - implementation-specific workarounds for areas in which a
given hardware implementation deviates from the architecture assumed by
the driver.

OK, let's print the model name. Now, if I give you this:

[    0.475009] arm-smmu 2b500000.iommu: probing hardware configuration...
[    0.481650] arm-smmu 2b500000.iommu: ARM MMU-401 r0p0 with:
[    0.486436] arm-smmu 2b500000.iommu: 	stage 2 translation
[    0.491925] arm-smmu 2b500000.iommu: 	coherent table walk
[    0.497420] arm-smmu 2b500000.iommu: 	stream matching with 32
register groups
[    0.504678] arm-smmu 2b500000.iommu: 	4 context banks (4 stage-2 only)
[    0.511312] arm-smmu 2b500000.iommu: 	Supported page sizes: 0x60211000
[    0.517943] arm-smmu 2b500000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA

please tell me which hardware problems this system has kernel
workarounds in place for, and which it doesn't. If you want another
hint, the version is 4.11.0-rc1+. Note the "+".

Robin.

> The above change is not a general solution too for reporting the
> enablement of smmu errata workarounds. The check could be done
> multiple times and in the fast path. For the particular problem the
> above would work, but still some message on the type detected would be
> fine. I could rework my patch in a way that .name is not permanently
> stored in struct arm_smmu_device.
> 
> -Robert
> 
