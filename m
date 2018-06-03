From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dma-coherent: Add one parameter to save available
	coherent memory
Date: Sun, 3 Jun 2018 10:12:17 +0800
Message-ID: <CAMz4kuLHigZJhk8E53v8k8DR59EARvC6CdkQ0+oAwTRjYKu=cw@mail.gmail.com>
References: <c5765cf69bf222757463ba2653ac760b42b785e6.1527745258.git.baolin.wang@linaro.org>
	<1d02b2e1-dd1c-af2a-e980-29aef4aa0c00@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1d02b2e1-dd1c-af2a-e980-29aef4aa0c00-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 1 June 2018 at 01:25, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> On 31/05/18 06:55, Baolin Wang wrote:
>>
>> It is incorrect to use mem->size to valid if there are enough coherent
>> memory to allocate in __dma_alloc_from_coherent(), since some devices
>> may mark some occupied coherent memory by
>> dma_mark_declared_memory_occupied().
>>
>> So we can introduce one 'avail' parameter to save the available device
>> coherent memory, to valid if we have enough coherent memory for the device
>> to allocate.
>
>
> We already have dma_mem->size stored for other reasons, so there's little
> harm in using it for a rough sanity check to short-circuit the odd
> allocation which cannot possibly succeed, but adding machinery purely for
> the sake an ever-so-slightly more accurate, but still far from exhaustive,
> check doesn't really seem worth it.
>
> Even if size <= dma_mem->avail there's still no guarantee that the
> allocation will actually succeed, so what benefit does the explicit
> accounting provide?
>

Yes, it can not guarantee one successful allocation, but it can avoid
some redundant bitmap operation and reducing the preempt-disable time
if we have not enough memory by checking the actual available coherent
memory. By the way, I think we should also add check in
dma_mark_declared_memory_occupied() and __dma_mmap_from_coherent().

-- 
Baolin.wang
Best Regards
