From: "Shankar, Hari" <Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] On unmap, flush IOMMU TLB and return correct size
Date: Thu, 5 Sep 2013 04:05:32 +0000
Message-ID: <CE4D489F.41EE8%hshankar@netapp.com>
References: <1378182340.3246.19.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1378182340.3246.19.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
Content-Language: en-US
Content-ID: <86F4E6E55D2BFA468FF593FAF14A35BE-c5HhxtLuC0z3oGB3hsPCZA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Shankar, Hari" <Hari.Shankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
Cc: "Singh, Varinder" <Varinder.Singh-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Sundaram,
	Rajesh" <Rajesh.Sundaram-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "Kimmel,
	Jeff" <jeff.kimmel-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Spiller,
	John" <John.Spiller-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,
See inline,

On 9/2/13 9:25 PM, "Alex Williamson" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

>Hi Hari,
>
>On Mon, 2013-09-02 at 02:24 +0000, Shankar, Hari wrote:
>> Patch Description: The patch is for Intel IOMMU driver. It forces IOMMU
>>TLB flush for the particular domain and return correct unmap size when
>>intel_iommu_unmap() is called
>
>"Patch Description:" is unnecessary.  Look at other commits that have
>touched this file to get an idea how to format the subject and commit
>log:
>
>http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/drivers
>/iommu/intel-iommu.c
>
>Sign-off should go here, not below the patch.  Subject should include a
>subsystem, such as "iommu/intel:" or "intel-iommu:".  Also a good idea
>to provide some justification why this is necessary for stable (unmaps
>from userspace through vfio results in coherency issue...)
>
>> The patch is generated on Linux kernel version 3.6.11
>
>This should be noted, but not part of the commit message.  See section
>15 of SubmittingPatches and note the additional comments between the
>"---" marker and the beginning of the patch.
>
>> --- linux/drivers/iommu/intel-iommu.c.orig      2013-09-01
>>10:10:14.723958000 -0700
>> +++ linux/drivers/iommu/intel-iommu.c   2013-09-01 18:22:58.497578000
>>-0700
>> @@ -4060,14 +4060,31 @@ static size_t intel_iommu_unmap(struct i
>
>Tabs seem to have been clobbered in your patch, scripts/checkpatch.pl
>will note this for you.
>
>>  {
>>         struct dmar_domain *dmar_domain = domain->priv;
>>         int order;
>> +       struct intel_iommu *iommu;
>> +       unsigned long start_pfn, last_pfn;
>> +       unsigned int npages;
>> +       int iommu_id, num, ndomains;
>> 
>> -       order = dma_pte_clear_range(dmar_domain, iova >> VTD_PAGE_SHIFT,
>> -                           (iova + size - 1) >> VTD_PAGE_SHIFT);
>> +       start_pfn = iova >> VTD_PAGE_SHIFT;
>> +       last_pfn = (iova + size - 1) >> VTD_PAGE_SHIFT;
>> +       order = dma_pte_clear_range(dmar_domain, start_pfn, last_pfn);
>> +       last_pfn |= (1UL << order) - 1;
>> +       npages = last_pfn - start_pfn + 1;
>
>Doesn't order tell us npages more directly?  npages = 1UL << order?


[Hari] 1UL << order formula will not work for all cases. Jeff Kimmel
(cc'ed) has a good explanation for that. Jeff's response below,

<Jeff>
If start_pfn is always aligned modulo (1 << order),
then '1UL << order' would get the same npages value, but if
start_pfn is not guaranteed to have such alignment, then '1UL << order'
would
produce an incorrect npages value.  For example, start_pfn could fall in
some range that was mapped with small pages, but the range could end in a
region mapped with large pages.

</Jeff>

>
>> +       for_each_set_bit(iommu_id, dmar_domain->iommu_bmp,
>>g_num_of_iommus) {
>> +               iommu = g_iommus[iommu_id];
>> 
>> -       if (dmar_domain->max_addr == iova + size)
>> +               /*
>> +                * find bit position of dmar_domain
>> +                */
>> +               ndomains = cap_ndoms(iommu->cap);
>> +               for_each_set_bit(num, iommu->domain_ids, ndomains)
>> +                       if (iommu->domains[num] == dmar_domain)
>> +                               iommu_flush_iotlb_psi(iommu, num,
>> +                                                       start_pfn,
>>npages, 0);
>
>This second bitmap search seems unnecessary, I think
>iommu_flush_iotlb_psi wants dmar_domain->id as the second parameter in
>all cases, not num.  So this could be reduced to :
>
>for_each_set_bit(iommu_id, dmar_domain->iommu_bmp, g_num_of_iommus)
>	iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain->id, start_pfn,
>npages, 0);

[Hari] For VFIO, iommu_alloc_vm_domain() is called to get VM domain and
has DOMAIN_FLAG_VIRTUAL_MACHINE flag set. In this case, domain->id is
derived from static variable 'vm_domid' and not by using
find_first_zero_bit in iommu->domain_ids, which in-turn also claims a slot
on iommu->domains[] array, see iommu_attach_domain(). For domain with
DOMAIN_FLAG_VIRTUAL_MACHINE flag, domain id is actually derived later in
domain_context_mapping_one(), logic under 'if (domain->flags &
DOMAIN_FLAG_VIRTUAL_MACHINE'. As you can see domain->id for VM domain is
not the actual domain id and can also conflict with non VM domain as
vm_domid starts from 0. Using domain->id in the loop will give wrong
result. Using second loop and passing 'num' makes sure we always select
the right domain to flush.

Hari.

>
>> +       }
>> +       if (dmar_domain->max_addr <= iova + (npages << VTD_PAGE_SHIFT))
>>                 dmar_domain->max_addr = iova;
>> -
>> -       return PAGE_SIZE << order;
>> +       return npages << VTD_PAGE_SHIFT;
>>  }
>> 
>>  static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain
>>*domain,
>> 
>> Signed-off-by: Hari Shankar <hshankar-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>
>> cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>
>Please configure your mailer to drop the html version.  Thanks,
>
>Alex
>
