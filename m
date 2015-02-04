From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: Re: dma_alloc_coherent - cma - and IOMMU question
Date: Wed, 04 Feb 2015 09:12:23 -0500
Message-ID: <54D228C7.9020100@compro.net>
References: <loom.20150130T194501-225@post.gmane.org>		
	<1422648686.22865.258.camel@redhat.com>
	<54CBF290.7050707@compro.net>	
	<1422654680.22865.277.camel@redhat.com>
	<54CF9F73.5080803@compro.net>
	<1422898536.22865.382.camel@redhat.com>
Reply-To: markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422898536.22865.382.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/02/2015 12:35 PM, Alex Williamson wrote:
> [cc +joerg]
>
> On Mon, 2015-02-02 at 11:01 -0500, Mark Hounschell wrote:
>> On 01/30/2015 04:51 PM, Alex Williamson wrote:
>>> On Fri, 2015-01-30 at 16:07 -0500, Mark Hounschell wrote:
>>>> On 01/30/2015 03:11 PM, Alex Williamson wrote:
>>>>> On Fri, 2015-01-30 at 19:12 +0000, Mark Hounschell wrote:
>>>>>> I've posted the following email to vger.kernel.org but got no response. I am
>>>>>> trying to adapt some of our out of kernel GPL drivers to use the AMD IOMMU.
>>>>>> Here is what I posted to LKML
>>>>>>
>>>>>> "start quote"
>>>>>>
>>>>>> Sorry for the noise. I've read everything DMA in the kernel Doc dir and
>>>>>> searched the web to no avail. So I thought I might get some useful info here.
>>>>>>
>>>>>> I'm currently using a 3.18.3 (x86_64) kernel on an AMD platform. I am
>>>>>> currently doing 8MB DMAs to and from our device using the in kernel CMA
>>>>>> "cma=64M@0-4G" with no problems. This device is not DAC or scatter/gather
>>>>>> capable so the in kernel CMA has been great and replaced our old bigphysarea
>>>>>> usage.
>>>>>>
>>>>>> We simply use dma_alloc_coherent and pass the dma_addr_t *dma_handle
>>>>>> returned from the dma_alloc_coherent function to our device as the "bus/pci"
>>>>>> address to use.
>>>>>>
>>>>>> We also use remap_pfn_range on that dma_addr_t *dma_handle returned from
>>>>>> the dma_alloc_coherent function to mmap userland to the buffer. All is good
>>>>>> until I enable the IOMMU. I then either get IO_PAGE_FAULTs, the DMA just
>>>>>> quietly never completes or the system gets borked.
>>>>>
>>>>> The dma_addr_t is an I/O virtual address (IOVA), it's the address the
>>>>> *device* uses to access the buffer returned by dma_alloc_coherent.  If
>>>>> you mmap that address through /dev/mem, you're getting the processor
>>>>> view of the address, which is not IOMMU translated.  Only the device
>>>>> uses the dma_addr_t, processor accesses need to use the returned void*,
>>>>> or some sort of virt_to_phys() version of that to allow userspace to
>>>>> mmap it through devmem.  Without an IOMMU, the dma_addr_t is simply a
>>>>> virt_to_bus() translation of the void* buffer, so the code happens to
>>>>> work, but is still and incorrect usage of the DMA API.
>>>>>
>>>>
>>>> Thanks Alex,
>>>>
>>>> Are you saying the WITH an IOMMU that dma_addr_t is NOT simply a
>>>> virt_to_bus() translation of the void* buffer?
>>>
>>> Yes
>>>
>>>> This is what I am doing. Returning dma_usr_addr to userland.
>>>>
>>>> dma_usr_addr = (char *)dma_alloc_coherent(NULL, size, dma_pci_addr, GFP_KERNEL);
>>>>
>>>> remap_pfn_range(vma, vma->vm_start, dma_pci_addr >> PAGE_SHIFT,
>>>>                                 size, vma->vm_page_prot);
>>>>
>>>> So what is incorrect/wrong here. I just checked and even with IOMMU enabled
>>>> dma_pci_addr ==  virt_to_bus(dma_usr_addr)
>>>
>>> You're passing NULL to dma_alloc_coherent as the device.  That's
>>> completely invalid when a real IOMMU is present.  When you do that, you
>>> take a code path in amd_iommu that simply allocates a buffer and returns
>>> __pa() of that buffer as the DMA address.  So the IOMMU isn't programmed
>>> for the device AND userspace is mapping the wrong range.  This explains
>>> the page faults below.  You need to to also use dma_user_addr in place
>>> of dma_pci_addr in the remap_pfn_range.
>>>
>>>> And can I assume that support is there for the IOMMU , CMA, and dma_alloc_coherent
>>>> as long as I figure out what I'm doing wrong?
>>>
>>> If you pass an actual device to dma_alloc_coherent, then the IOMMU
>>> should be programmed correctly.  I don't know how CMA fits into your
>>> picture since dma_alloc_coherent allocates a buffer independent of CMA.
>>> Wouldn't you need to allocate the buffer from the CMA pool and then call
>>> dma_map_page() on it in order to use CMA?  Thanks,
>>>
>>
>> Thanks for that Alex.
>>
>>   From what I understand of CMA, and it seems provable to me, is that
>> dma_alloc_coherent allocates my 8MB buffer from CMA defined on the
>> cmdline. Without CMA specified on the cmdline, dma_alloc_coherent
>> definitely fails to allocate an 8MB contiguous buffer. From what I've
>> read about it, it is supposed to transparently "just work" when
>> dma_alloc_coherent is used?
>
> Yes, if you're running with the software iotlb (aka. bounce buffers),
> then dma_ops->alloc is x86_swiotlb_alloc_coherent(), which calls
> dma_generic_alloc_coherent(), which attempts to use CMA via
> dma_alloc_from_contiguous().
>
> If you look at the same path with AMD-Vi, dma_ops->alloc is
> amd_iommu.c:alloc_coherent(), which simply uses __get_free_pages() to
> allocate the buffer.  I don't see any CMA integration along that path.
> If you were using Intel VT-d, then the buffer is again allocated with
> dma_alloc_from_contiguous() and should use CMA.  This was added in
> kernel v3.16, but no corresponding AMD-Vi change was added.  Joerg, this
> might be an easily fixed oversight.
>

Hi Alex,

Has this possibly been fixed in 3.19?

Thanks
Mark
