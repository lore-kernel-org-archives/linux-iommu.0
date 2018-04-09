From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC v2 2/2] base: dma-mapping: Postpone page_to_pfn() on mmap()
Date: Mon, 9 Apr 2018 12:11:22 +0100
Message-ID: <7da3f31e-e4ad-7f1a-e66c-0d3e0fb8b27d@arm.com>
References: <1510679286-6988-1-git-send-email-jacopo+renesas@jmondi.org>
	<1510679286-6988-3-git-send-email-jacopo+renesas@jmondi.org>
	<ea4f2d82-6a27-a7c1-091f-6230cfd988a3@arm.com>
	<20180409072547.GU20945@w540>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180409072547.GU20945@w540>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: jacopo mondi <jacopo-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
Cc: dalias-8zAoT0mYgF4@public.gmane.org, ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacopo,

On 09/04/18 08:25, jacopo mondi wrote:
> Hi Robin, Laurent,
>      a long time passed, sorry about this.
> 
> On Wed, Nov 15, 2017 at 01:38:23PM +0000, Robin Murphy wrote:
>> On 14/11/17 17:08, Jacopo Mondi wrote:
>>> On SH4 architecture, with SPARSEMEM memory model, translating page to
>>> pfn hangs the CPU. Post-pone translation to pfn after
>>> dma_mmap_from_dev_coherent() function call as it succeeds and make page
>>> translation not necessary.
>>>
>>> This patch was suggested by Laurent Pinchart and he's working to submit
>>> a proper fix mainline. Not sending for inclusion at the moment.
>>
>> Y'know, I think this patch does have some merit by itself - until we know
>> that cpu_addr *doesn't* represent some device-private memory which is not
>> guaranteed to be backed by a struct page, calling virt_to_page() on it is
>> arguably semantically incorrect, even if it might happen to be benign in
>> most cases.
> 
> I still need to carry this patch in my trees to have a working dma memory mapping
> on SH4 platforms. My understanding from your comment is that there may
> be a way forward for this patch, do you still think the same? Have you
> got any suggestion on how to improve this eventually for inclusion?

As before, the change itself does seem reasonable; it might be worth 
rewording the commit message in more general terms rather than making it 
sound like an SH-specific workaround (which I really don't think it is), 
but otherwise I'd say just repost it as a non-RFC patch.

Robin.

> 
> Thanks
>     j
> 
>>
>> Robin.
>>
>>> Suggested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>>> Signed-off-by: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
>>> ---
>>>   drivers/base/dma-mapping.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
>>> index e584edd..73d64d3 100644
>>> --- a/drivers/base/dma-mapping.c
>>> +++ b/drivers/base/dma-mapping.c
>>> @@ -227,8 +227,8 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>>>   #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
>>>   	unsigned long user_count = vma_pages(vma);
>>>   	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>> -	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
>>>   	unsigned long off = vma->vm_pgoff;
>>> +	unsigned long pfn;
>>>
>>>   	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>>
>>> @@ -236,6 +236,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>>>   		return ret;
>>>
>>>   	if (off < count && user_count <= (count - off)) {
>>> +		pfn = page_to_pfn(virt_to_page(cpu_addr));
>>>   		ret = remap_pfn_range(vma, vma->vm_start,
>>>   				      pfn + off,
>>>   				      user_count << PAGE_SHIFT,
>>> --
>>> 2.7.4
>>>
>>> _______________________________________________
>>> iommu mailing list
>>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>>
