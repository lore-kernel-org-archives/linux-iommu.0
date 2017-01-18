From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 00/18] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
	reserved regions
Date: Wed, 18 Jan 2017 14:02:45 +0100
Message-ID: <9ee8a03b-3231-bb58-1c64-e7f2f76ed5b9@redhat.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
	<e1e6d9cf-5fb8-e118-3a47-4c6be77c21a3@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e1e6d9cf-5fb8-e118-3a47-4c6be77c21a3-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

On 13/01/2017 14:59, Tomasz Nowicki wrote:
> Hello Eric,
> 
> On 11.01.2017 10:41, Eric Auger wrote:
>> Following LPC discussions, we now report reserved regions through
>> the iommu-group sysfs reserved_regions attribute file.
>>
>> Reserved regions are populated through the IOMMU get_resv_region
>> callback (former get_dm_regions), now implemented by amd-iommu,
>> intel-iommu and arm-smmu:
>> - the intel-iommu reports the [0xfee00000 - 0xfeefffff] MSI window
>>   as a reserved region and RMRR regions as direct-mapped regions.
>> - the amd-iommu reports device direct mapped regions, the MSI region
>>   and HT regions.
>> - the arm-smmu reports the MSI window (arbitrarily located at
>>   0x8000000 and 1MB large).
>>
>> Unsafe interrupt assignment is tested by enumerating all MSI irq
>> domains and checking MSI remapping is supported in the above hierarchy.
>> This check is done in case we detect the iommu translates MSI
>> (an IOMMU_RESV_MSI window exists). Otherwise the IRQ remapping
>> capability is checked at IOMMU level. Obviously this is a defensive
>> IRQ safety assessment: Assuming there are several MSI controllers
>> in the system and at least one does not implement IRQ remapping,
>> the assignment will be considered as unsafe (even if this controller
>> is not acessible from the assigned devices).
>>
>> The series first patch stems from Robin's branch:
>> http://linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/misc
>>
>>
>> Best Regards
>>
>> Eric
>>
>> Git: complete series available at
>> https://github.com/eauger/linux/tree/v4.10-rc3-reserved-v8
> 
> I tested the series on ThunderX with internal 10G VNIC and Intel IXGBE
> NIC. Please feel free to add my:
> Tested-by: Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>

Thank you for your review. I will respin tomorrow adding the comment we
discussed in [PATCH v8 14/18] irqdomain: irq_domain_check_msi_remap.

I will also apply Bharat's Tested-by, your T-b and your R-b's.

Thanks

Eric
> 
> Thanks,
> Tomasz
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
