From: "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH v11 08/10] iommu/vt-d: assign new page table for dma_map
Date: Thu, 21 May 2015 16:40:11 +0800
Message-ID: <555D99EB.2030603@hp.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
	<1431337974-545-9-git-send-email-zhen-hual@hp.com>
	<20150520235242.GA2342@dhcp-17-102.nay.redhat.com>
	<555D3470.7060902@hp.com>
	<20150521065451.GA23661@dhcp-128-28.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150521065451.GA23661-0VdLhd/A9PlfpSRLqpFUpR/sF2h8X+2i0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: tom.vaden-VXdhtT5mjnY@public.gmane.org, rwright-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Li,
	ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Baoquan,
During driver being loaded and initialized, when there is a new dma
request, the function
                __get_valid_domain_for_dev
is called, and then new page is mapped.

Please check this:
struct dma_map_ops intel_dma_ops = {
         .alloc = intel_alloc_coherent,
         .free = intel_free_coherent,
         .map_sg = intel_map_sg,
         .unmap_sg = intel_unmap_sg,
         .map_page = intel_map_page,
         .unmap_page = intel_unmap_page,
         .mapping_error = intel_mapping_error,
};

You can also add dump_stack() in __get_valid_domain_for_dev to debug.

Thanks
Zhenhua

On 05/21/2015 02:54 PM, Baoquan He wrote:
> On 05/21/15 at 09:27am, Li, ZhenHua wrote:
>> Hi Baoquan,
>>
>> In the early version of this patchset, old page tables are used by new
>> kernel.  But as discussed, we need to make kernel use new pages when
>> there is a new dma request , so we need to unmap the pages which were
>> mapped in old kernel, and this is what this patch does.
>
> OK, just a new page table allocated in init_domain(), right? I thought a
> specific empty page-table is allocated for these new domains in kdump
> kernel.
>
>>
>> Thanks
>> Zhenhua
>>
>> On 05/21/2015 07:52 AM, Baoquan He wrote:
>>> On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
>>>> When a device driver issues the first dma_map command for a device, we
>>>> assign a new and empty page-table, thus removing all mappings from the
>>>> old kernel for the device.
>>>
>>> Hi Zhenhua,
>>>
>>>  From your patch I got it will remove all mappings, assign a new
>>> page-table. But I didn't got why you stress an empty page-table. Did I
>>> miss anything?
>>>
>>> Thanks
>>> Baoquan
>>>
>>>>
>>>> Signed-off-by: Li, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>
>>>> --
