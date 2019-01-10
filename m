From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: amdgpu/TTM oopses since merging swiotlb_dma_ops into the
	dma_direct code
Date: Thu, 10 Jan 2019 15:48:37 +0100
Message-ID: <20190110144837.GA10362@lst.de>
References: <61f8f660-005c-190c-c08f-b563de2eae18@daenzer.net>
	<20190110135741.GA9255@lst.de>
	<a3f0fd49-2286-ee2a-f0e8-dfe82aac73fb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a3f0fd49-2286-ee2a-f0e8-dfe82aac73fb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: Sibren Vasse <freedesktop-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 10, 2019 at 03:00:31PM +0100, Christian K=F6nig wrote:
>>  From the trace it looks like we git the case where swiotlb tries
>> to copy back data from a bounce buffer, but hits a dangling or NULL
>> pointer.  So a couple questions for the submitter:
>>
>>   - does the system have more than 4GB memory and thus use swiotlb?
>>     (check /proc/meminfo, and if something SWIOTLB appears in dmesg)
>>   - does the device this happens on have a DMA mask smaller than
>>     the available memory, that is should swiotlb be used here to start
>>     with?
>
> Rather unlikely. The device is an AMD GPU, so we can address memory up to =

> 1TB.

So we probably somehow got a false positive.

For now I'like the reported to confirm that the dma_direct_unmap_page+0x92
backtrace really is in the swiotlb code (I can't think of anything else,
but I'd rather be sure).

Second it would be great to print what the contents of io_tlb_start
and io_tlb_end are, e.g. by doing a printk_once in is_swiotlb_buffer,
maybe that gives a clue why we are hitting the swiotlb code here.
