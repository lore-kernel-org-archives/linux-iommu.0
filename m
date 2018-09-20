From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] xtensa: remove partial support for DMA buffers in
	high memory
Date: Thu, 20 Sep 2018 12:08:28 -0700
Message-ID: <CAMo8BfL5KsmgLLmtdj05NgYOOR8H5LdU46+oA4xw-c-W_0nRfg@mail.gmail.com>
References: <20180920171540.2657-1-hch@lst.de>
	<20180920171540.2657-2-hch@lst.de>
	<CAMo8BfKyW+3t+L+oQ+nDyEs8KcASPC8CeUP3QPoANQC=XKP9hg@mail.gmail.com>
	<20180920180833.GB27677@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180920180833.GB27677-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 20, 2018 at 11:08 AM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> On Thu, Sep 20, 2018 at 10:44:55AM -0700, Max Filippov wrote:
>> Hi Christoph,
>>
>> On Thu, Sep 20, 2018 at 10:15 AM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
>> > This reverts commit 6137e4166004e2ec383ac05d5ca15831f4668806.
>> >
>> > We explicitly clear GFP_HIGHMEM from the allowed dma flags at the beginning
>> > of the function (and the generic dma_alloc_attr function calling us does the
>> > same!), so this code just adds dead wood.
>>
>> No, not really: dma_alloc_from_contiguous does not accept flags (only
>> no_warn bit)
>> and may return arbitrary pages. That's the case that this code is handling.
>
> dma_alloc_from_contiguous calls cma_alloc to do the actual
> allocation, and that uses alloc_contig_range with the GFP_KERNEL
> flag.  How do you end up getting highmem patches from it?

I'm not familiar with the details of alloc_contig_range implementation, but
I don't see how gfp_mask is used to limit allocation to non-high memory.
So when alloc_contig_range gets start and end PFNs in high memory
(from the CMA region allocated in high memory) it just returns high memory
pages -- that's what I see.

-- 
Thanks.
-- Max
