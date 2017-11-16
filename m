From: nick klingsman <nick.klingsman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel-iommu: Possible memory corruption due to deferred iommu
	flush
Date: Fri, 17 Nov 2017 01:57:19 +0200
Message-ID: <CAGkh+Xd-mwYT75-sFWbjxKCOu5H0QhZFBKNELZxBytWpnORnZw@mail.gmail.com>
References: <CAGkh+XfVC0Ki0T88qdKke4Hsp2nyAZewRupEOLTds+1i4eBQYQ@mail.gmail.com>
	<20171116225226.GA53404@otc-nc-03>
	<CAGkh+XesX-yFnU_3q2=t6Zcju_zE3wN7EZoBswQnfc_cZ9qZxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAGkh+XesX-yFnU_3q2=t6Zcju_zE3wN7EZoBswQnfc_cZ9qZxQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17 November 2017 at 01:54, nick klingsman <nick.klingsman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi Ashok,
>
> On 17 November 2017 at 00:52, Raj, Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>> On Thu, Nov 16, 2017 at 12:20:47PM +0200, nick klingsman wrote:
>>> * Note: Please 'CC'/Reply my email as I'm not subscribed to the list yet.
>>>
>>> Hi,
>>>
>>> During __iommu_flush_iotlb() we set the WD (WriteDrain) bit if the
>>> iommu supports cap_write_drain(). This part of the logic exists from
>>> day one of the code and later even added to QI logic.
>>>
>>> Back than, when we dma_unmap_xxx() we 'synchronically' did the
>>> iommu_flush() and within it the the Write-Drain logic.
>>>
>>> However, today, we do a batch-flush  which means that all/most calls
>>> to dma_unmap() don't perform the Write-Drain.
>>>
>>> Questions:
>>>
>>> 1. If WD is a must, how come the batch-flush doesn't cause any memory
>>> corruption ? For example:
>>>    a. dma_map_page(100, from_device)
>>>    b. Device writes data to device
>>>    c. dma_unmap_page() -> batched and not sync-flushed
>>>    d. Possible BUG ? Data read before the write is drained can be stale ?
>>
>> __iommu_flush_iotlb() will do DMA_TLB_WRITE_DRAIN.. so that's actually
>> done even in the batched more.
>
>
> That's the point.. this is not 'batched' mode. Its "deferred" mode.
> the flush occurs *async* to the dma_unmap() call by the driver.
>
> In my example, after the dma_unmap() @ 'c', the flush didn't yet
> occured and so is the Write Drain request.
>

Oh - now I understand the confusion. Although the subject said 'deferred'
I used the word 'Batched' in the email body. I meant 'deferred'. Not batching.
If it was only batching, than it would make sens as 'Ashok' pointed out.

>
>>
>>>
>>> 2. If WD is not needed, why do we do it ? Why do we effect IOMMU work
>>> with unneeded actions (in the most critical fast path of map/unmap) ?
>>>
>>>
>>> Thanks,
>>> Nick
>>> _______________________________________________
>>> iommu mailing list
>>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
