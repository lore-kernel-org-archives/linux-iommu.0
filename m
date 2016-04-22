From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 01/10] iommu: Add DOMAIN_ATTR_MSI_MAPPING attribute
Date: Fri, 22 Apr 2016 17:33:19 +0200
Message-ID: <571A443F.6020204@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
	<1461084994-2355-2-git-send-email-eric.auger@linaro.org>
	<57177A4E.4090804@arm.com> <5717A738.9090904@linaro.org>
	<571A0B78.6070509@arm.com> <571A1273.9060808@linaro.org>
	<571A3A10.70601@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <571A3A10.70601-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, eric.auger-qxv4g6HH51o@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Ho Robin,
On 04/22/2016 04:49 PM, Robin Murphy wrote:
> On 22/04/16 13:00, Eric Auger wrote:
>> Hi Robin,
>> On 04/22/2016 01:31 PM, Robin Murphy wrote:
>>> On 20/04/16 16:58, Eric Auger wrote:
>>>> Hi Robin,
>>>> On 04/20/2016 02:47 PM, Robin Murphy wrote:
>>>>> Hi Eric,
>>>>>
>>>>> On 19/04/16 17:56, Eric Auger wrote:
>>>>>> Introduce a new DOMAIN_ATTR_MSI_MAPPING domain attribute. If
>>>>>> supported,
>>>>>> this means the MSI addresses need to be mapped in the IOMMU.
>>>>>>
>>>>>> x86 IOMMUs typically don't expose the attribute since on x86, MSI
>>>>>> write
>>>>>> transaction addresses always are within the 1MB PA region
>>>>>> [FEE0_0000h -
>>>>>> FEF0_000h] window which directly targets the APIC configuration
>>>>>> space and
>>>>>> hence bypass the sMMU. On ARM and PowerPC however MSI transactions
>>>>>> are
>>>>>> conveyed through the IOMMU.
>>>>>
>>>>> What's stopping us from simply inferring this from the domain's IOMMU
>>>>> not advertising interrupt remapping capabilities?
>>>> My current understanding is it is not possible:
>>>> on x86 CAP_INTR_REMAP is not systematically exposed (the feature can be
>>>> disabled) and MSIs are never mapped in the IOMMU I think.
>>>
>>> Not sure I follow - if the feature is disabled such that the IOMMU
>>> doesn't isolate MSIs, then it's no different a situation from the
>>> SMMU, no?
>>
>> sorry I understood you wanted to use IOMMU_CAP_INTR_REMAP as the sole
>> criteria to detect whether MSI mapping was requested.
>>>
>>> My point was that this logic:
>>>
>>>      if (IOMMU_CAP_INTR_REMAP)
>>>          we're good
>>>      else if (DOMAIN_ATTR_MSI_MAPPING)
>>>          if (acquire_msi_remapping_resources(domain))
>>>              we're good
>>>          else
>>>              oh no!
>>>      else
>>>          oh no!
>>>
>>> should be easily reducible to this:
>>>
>>>      if (IOMMU_CAP_INTR_REMAP)
>>>          we're good
>>>      else if (acquire_msi_remapping_resources(domain))
>>
>> But Can't we imagine a mix of smmus on the same platform, some
>> requesting MSI mapping and some which don't. As soon as an smmu requires
>> MSI mapping, CONFIG_IOMMU_DMA_RESERVED is set and
>> acquire_msi_remapping_resources(domain) will be implemented & succeed.
>> Doesn't it lead to a wrong decision. Do I miss something, or do you
>> consider this situation as far-fetched?
> 
> Sorry, what was implicit there was that the imaginary
> acquire_msi_remapping_resources(*IOMMU* domian) call still involves
> going all the way down to check for MSI_FLAG_IRQ_REMAPPING in the
> relevant place.
> 
> Either way, now that I consider it further, a flag on the IOMMU domain
> is not just unnecessary, I think it's actually fundamentally incorrect:
> picture a system which for some crazy reason has both a GICv3 ITS plus
> some other dumb v2m-like MMIO-SPI bridge - whether a device's MSI domain
> targets the (safe) ITS or the (unsafe) bridge isn't a property of the
> IOMMU domain it's trying to attach to; if you can't rely on the IOMMU
> itself to isolate MSIs, then you can only know whether to allow or
> reject any given group by inspecting every device in that group to make
> sure they all have isolation provided by their MSI domains and that the
> IOMMU domain has all the relevant doorbell mappings ready.

Yes we discussed that (inspection of all devices) with Alex already and
we concluded it was too complex for the benefits. What is currently
implemented in vfio_iommu_type1 to figure out whether IRQs are safe is:
- either the smmu domain implements IRQ remapping (x86 case) or
- the interrupt controller implements IRQ remapping (arm case)

as a result, assigning a device connected to a GICv2m is unsafe and
assigning a device connected to an ITS is safe.

the fact an IOVA is available or not impacts the assignment
functionality but not really the safety (iommu faults).
> 
> I guess the allow_unsafe_interrupts case might complicate matters beyond
> the logic I sketched out, because then we might actually care about the
> difference between "is isolation provided?" and "are sufficient
> IOVA/descriptor resources available?", but the main point still stands.

So just to make sure I did not misunderstand you, since we are talking
about orthogonal concepts:
1) requirement to map the MSI in the IOMMU
2) capability to isolate MSI,

we eventually
- keep the IOMMU domain attribute, DOMAIN_ATTR_MSI_MAPPING that tells
whether the MSI need to be mapped
- we keep the MSI domain attribute that tells whether the interrupt
controller implements MSI isolation?
- we remove IRQ_REMAPPING cap from arm-smmus

Best Regards

Eric
> 
> Robin.
> 
>> Thanks
>>
>> Eric
>>
>>>          we're good
>>>      else
>>>          oh no!    // Don't care whether the domain ran out of
>>>              // resources or simply doesn't support it,
>>>              // either way we can't proceed.
>>>
>>> Robin.
>>>
>>>> Best Regards
>>>>
>>>> Eric
>>>>>
>>>>> Robin.
>>>>>
>>>>>> Signed-off-by: Bharat Bhushan <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>>>>> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> v4 -> v5:
>>>>>> - introduce the user in the next patch
>>>>>>
>>>>>> RFC v1 -> v1:
>>>>>> - the data field is not used
>>>>>> - for this attribute domain_get_attr simply returns 0 if the
>>>>>> MSI_MAPPING
>>>>>>      capability if needed or <0 if not.
>>>>>> - removed struct iommu_domain_msi_maps
>>>>>> ---
>>>>>>     include/linux/iommu.h | 1 +
>>>>>>     1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>>>>> index 62a5eae..b3e8c5b 100644
>>>>>> --- a/include/linux/iommu.h
>>>>>> +++ b/include/linux/iommu.h
>>>>>> @@ -113,6 +113,7 @@ enum iommu_attr {
>>>>>>         DOMAIN_ATTR_FSL_PAMU_ENABLE,
>>>>>>         DOMAIN_ATTR_FSL_PAMUV1,
>>>>>>         DOMAIN_ATTR_NESTING,    /* two stages of translation */
>>>>>> +    DOMAIN_ATTR_MSI_MAPPING, /* Require MSIs mapping in iommu */
>>>>>>         DOMAIN_ATTR_MAX,
>>>>>>     };
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 
