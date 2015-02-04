From: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Subject: Re: dma_alloc_coherent - cma - and IOMMU question
Date: Wed, 04 Feb 2015 14:32:22 -0500
Message-ID: <54D273C6.4000909@compro.net>
References: <loom.20150130T194501-225@post.gmane.org>
	<1422648686.22865.258.camel@redhat.com>
	<54CBF290.7050707@compro.net>
	<1422654680.22865.277.camel@redhat.com>
	<54CF9F73.5080803@compro.net>
	<1422898536.22865.382.camel@redhat.com>
	<20150204141519.GL3702@8bytes.org>
Reply-To: markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150204141519.GL3702-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/04/2015 09:15 AM, Joerg Roedel wrote:
> On Mon, Feb 02, 2015 at 10:35:36AM -0700, Alex Williamson wrote:
>> [cc +joerg]
>>
>> On Mon, 2015-02-02 at 11:01 -0500, Mark Hounschell wrote:
>>>   From what I understand of CMA, and it seems provable to me, is that
>>> dma_alloc_coherent allocates my 8MB buffer from CMA defined on the
>>> cmdline. Without CMA specified on the cmdline, dma_alloc_coherent
>>> definitely fails to allocate an 8MB contiguous buffer. From what I've
>>> read about it, it is supposed to transparently "just work" when
>>> dma_alloc_coherent is used?
>>
>> Yes, if you're running with the software iotlb (aka. bounce buffers),
>> then dma_ops->alloc is x86_swiotlb_alloc_coherent(), which calls
>> dma_generic_alloc_coherent(), which attempts to use CMA via
>> dma_alloc_from_contiguous().
>>
>> If you look at the same path with AMD-Vi, dma_ops->alloc is
>> amd_iommu.c:alloc_coherent(), which simply uses __get_free_pages() to
>> allocate the buffer.  I don't see any CMA integration along that path.
>> If you were using Intel VT-d, then the buffer is again allocated with
>> dma_alloc_from_contiguous() and should use CMA.  This was added in
>> kernel v3.16, but no corresponding AMD-Vi change was added.  Joerg, this
>> might be an easily fixed oversight.
>
> Right, CMA is not yet integrated in the AMD IOMMU driver, nobody asked
> fot it until now :) I will add that fall-back there for big allocations.
>
>
> 	Joerg
>
>

Hi Joerg,

Is device to device (crossing pci busses) or even pci-e to pci-e support 
there or in the future?

Thanks and Regards
Mark
