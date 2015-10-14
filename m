From: Jay Cornwall <jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org>
Subject: Re: [PATCH RESEND] iommu/amd: Fix BUG when faulting a PROT_NONE VMA
Date: Wed, 14 Oct 2015 11:56:00 -0500
Message-ID: <0528b4ee6c9af3fa326880eb18cf13b8@jcornwall.me>
References: <1444729963-13815-1-git-send-email-jay@jcornwall.me>
	<20151014091015.GJ27420@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151014091015.GJ27420-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2015-10-14 04:10, Joerg Roedel wrote:
> Hi Jay,
> 
> On Tue, Oct 13, 2015 at 04:52:43AM -0500, Jay Cornwall wrote:
>> handle_mm_fault indirectly triggers a BUG in do_numa_page when given
>> a VMA without read/write/execute access. Check this condition in 
>> do_fault.
>> 
>> do_fault -> handle_mm_fault -> handle_pte_fault -> do_numa_page
>> 
>>   mm/memory.c
>>   3147  static int do_numa_page(struct mm_struct *mm, struct 
>> vm_area_st...
>>   ....
>>   3159  /* A PROT_NONE fault should not end up here */
>>   3160  BUG_ON(!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)));
> 
> Thanks for the fix! Next time please Cc me directly on patches for AMD
> IOMMU code, so I see your patches earlier.
> 
> Also this looks relevant for stable, can you find out which stable
> kernels need this fix too?

Sure.

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v4.1+

-- 
Jay Cornwall
