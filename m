From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] xtensa: remove partial support for DMA buffers in
	high memory
Date: Fri, 21 Sep 2018 10:42:48 -0700
Message-ID: <CAMo8BfKAqTf1O3nwYv4n=E14jNNn6r-jQ14FSGBYFTOOO5qg-A@mail.gmail.com>
References: <20180920171540.2657-1-hch@lst.de>
	<20180920171540.2657-2-hch@lst.de>
	<CAMo8BfKyW+3t+L+oQ+nDyEs8KcASPC8CeUP3QPoANQC=XKP9hg@mail.gmail.com>
	<20180920180833.GB27677@lst.de>
	<CAMo8BfL5KsmgLLmtdj05NgYOOR8H5LdU46+oA4xw-c-W_0nRfg@mail.gmail.com>
	<20180921065100.GA14246@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180921065100.GA14246-jcswGhMUV9g@public.gmane.org>
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
Cc: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joonsoo Kim <iamjoonsoo.kim-Hm3cg6mZ9cc@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 20, 2018 at 11:51 PM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> On Thu, Sep 20, 2018 at 12:08:28PM -0700, Max Filippov wrote:
>> I'm not familiar with the details of alloc_contig_range implementation, but
>> I don't see how gfp_mask is used to limit allocation to non-high memory.
>> So when alloc_contig_range gets start and end PFNs in high memory
>> (from the CMA region allocated in high memory) it just returns high memory
>> pages -- that's what I see.
>
> I can't see what prevents people from doing a CMA in high memory either,
> which is bad as except for arm non of the callers handles it completely
> (and that includes xtensa, more below).

So far it was useful and sufficient for us.

> xtensa is partially prepared for
> it as it can remap in dma_alloc, but it is missing handling in either
> the ->mmap or ->get_sgtable methods.

I'd rather implement the missing parts or put a WARN there if
implementing it is too hard or impossible than remove the existing
partial support.

-- 
Thanks.
-- Max
