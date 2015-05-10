From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Date: Sun, 10 May 2015 17:37:53 -0400
Message-ID: <554FCFB1.2090208@redhat.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
	<20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
	<551E56F6.60503@hp.com>
	<20150403092111.GG22579@dhcp-128-53.nay.redhat.com>
	<20150405015453.GB1562@dhcp-17-102.nay.redhat.com>
	<20150407034622.GB7213@localhost.localdomain>
	<5523E5DB.2090001@redhat.com>
	<20150507140029.GC4559@localhost.localdomain>
	<554B75D6.1060204@redhat.com>
	<20150508012118.GA4809@dhcp-128-4.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150508012118.GA4809-0VdLhd/A9PlTxLCkMk2GaBcY2uh10dtjAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Li,
	ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/07/2015 09:21 PM, Dave Young wrote:
> On 05/07/15 at 10:25am, Don Dutile wrote:
>> On 05/07/2015 10:00 AM, Dave Young wrote:
>>> On 04/07/15 at 10:12am, Don Dutile wrote:
>>>> On 04/06/2015 11:46 PM, Dave Young wrote:
>>>>> On 04/05/15 at 09:54am, Baoquan He wrote:
>>>>>> On 04/03/15 at 05:21pm, Dave Young wrote:
>>>>>>> On 04/03/15 at 05:01pm, Li, ZhenHua wrote:
>>>>>>>> Hi Dave,
>>>>>>>>
>>>>>>>> There may be some possibilities that the old iommu data is corrupted by
>>>>>>>> some other modules. Currently we do not have a better solution for the
>>>>>>>> dmar faults.
>>>>>>>>
>>>>>>>> But I think when this happens, we need to fix the module that corrupted
>>>>>>>> the old iommu data. I once met a similar problem in normal kernel, the
>>>>>>>> queue used by the qi_* functions was written again by another module.
>>>>>>>> The fix was in that module, not in iommu module.
>>>>>>>
>>>>>>> It is too late, there will be no chance to save vmcore then.
>>>>>>>
>>>>>>> Also if it is possible to continue corrupt other area of oldmem because
>>>>>>> of using old iommu tables then it will cause more problems.
>>>>>>>
>>>>>>> So I think the tables at least need some verifycation before being used.
>>>>>>>
>>>>>>
>>>>>> Yes, it's a good thinking anout this and verification is also an
>>>>>> interesting idea. kexec/kdump do a sha256 calculation on loaded kernel
>>>>>> and then verify this again when panic happens in purgatory. This checks
>>>>>> whether any code stomps into region reserved for kexec/kernel and corrupt
>>>>>> the loaded kernel.
>>>>>>
>>>>>> If this is decided to do it should be an enhancement to current
>>>>>> patchset but not a approach change. Since this patchset is going very
>>>>>> close to point as maintainers expected maybe this can be merged firstly,
>>>>>> then think about enhancement. After all without this patchset vt-d often
>>>>>> raised error message, hung.
>>>>>
>>>>> It does not convince me, we should do it right at the beginning instead of
>>>>> introduce something wrong.
>>>>>
>>>>> I wonder why the old dma can not be remap to a specific page in kdump kernel
>>>>> so that it will not corrupt more memory. But I may missed something, I will
>>>>> looking for old threads and catch up.
>>>>>
>>>>> Thanks
>>>>> Dave
>>>>>
>>>> The (only) issue is not corruption, but once the iommu is re-configured, the old,
>>>> not-stopped-yet, dma engines will use iova's that will generate dmar faults, which
>>>> will be enabled when the iommu is re-configured (even to a single/simple paging scheme)
>>>> in the kexec kernel.
>>>>
>>>
>>> Don, so if iommu is not reconfigured then these faults will not happen?
>>>
>> Well, if iommu is not reconfigured, then if the crash isn't caused by
>> an IOMMU fault (some systems have firmware-first catch the IOMMU fault & convert
>> them into NMI_IOCK), then the DMA's will continue into the old kernel memory space.
>
> So NMI_IOCK is one reason to cause kernel hang, I think I'm still not clear about
> what does re-configured means though. DMAR faults will happen originally this is the old
> behavior but we are removing the faults by alowing DMA continuing into old memory
> space.
>
A flood of faults occur when the 2nd kernel (re-)configures the IOMMU because
the second kernel effectively clears/disable all DMA except RMRRs, so any DMA from 1st kernel will flood
the system with faults.  Its the flood of dmar faults that eventually wedges &/or crashes the system
while trying to take a kdump.

>>
>>> Baoquan and me has a confusion below today about iommu=off/intel_iommu=off:
>>>
>>> intel_iommu_init()
>>> {
>>> ...
>>>
>>>         dmar_table_init();
>>>
>>>         disable active iommu translations;
>>>
>>>         if (no_iommu || dmar_disabled)
>>>                  goto out_free_dmar;
>>>
>>> ...
>>> }
>>>
>>> Any reason not move no_iommu check to the begining of intel_iommu_init function?
>>>
>> What does that do/help?
>
> Just do not know why the previous handling is necessary with iommu=off, shouldn't
> we do noting and return earlier?
>
> Also there is a guess, dmar faults appears after iommu_init, so not sure if the codes
> before dmar_disabled checking have some effect about enabling the faults messages.
>
> Thanks
> Dave
>
