From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Is adding offset to dma address is valid operation?
Date: Mon, 26 Mar 2018 14:31:15 +0100
Message-ID: <d49288da-ea0b-ac9c-923f-93b5e7672d29@arm.com>
References: <8be08248-174e-19c2-357d-7d31c60a90f7@chelsio.com>
	<5ea7def7-2daa-b4b1-17e7-47524746a61a@arm.com>
	<6986f4c8-a3c0-2483-6eae-cfb56eaee10a@chelsio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6986f4c8-a3c0-2483-6eae-cfb56eaee10a-ut6Up61K2wZBDgjK7y7TUQ@public.gmane.org>
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
To: Harsh Jain <harsh-ut6Up61K2wZBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 26/03/18 13:31, Harsh Jain wrote:
> 
> 
> On 26-03-2018 17:15, Robin Murphy wrote:
>> Hi Harsh,
>> 
>> On 26/03/18 10:55, Harsh Jain wrote:
>>> Hi,
>>> 
>>> Can we add  offset to dma address received from IOMMU in
>>> scatter/Gather list before sending it to H/W.
>>> 
>>> Address to HW = sg_dma_address(sg) + offset, where 0 < offset <
>>> sg_dma_len(sg).
>> 
>> sg_dma_address() should already account for sg->offset (i.e. the
>> start of the buffer within the page. If there's a DMA API
>> implementation failing to respect that then that's a bug.
>> 
>>> I need this operation to make sure our H/W does not receives
>>> entry of size greater than 2K.
>> 
>> If however it's just that you want to fragment a single SG entry
>> into multiple commaneds/descriptors/etc. internally to your driver,
>> then I can't see that being an issue as long as you don't visibly
>> modify the scatterlist itself. If there's a genuine length and/or
>> alignment limitation in the hardware, though, it would be better to
>> set up dev->dma_parms appropriately to describe them, such that the
>> subsystem responsible for generating the scatterlist respects the
>> appropriate constraints in the first place (and if it doesn't, then
>> that's another bug to fix).
> Can dma_parms  handle 2K size limit ? Because dma_map_sg() returns <=
> passed nents. But in my case nents will increase.

The point is that dma_map_sg() should still never increase nents, 
because the guy *creating* the scatterlist is also expected to respect 
dma_parms where it exists, such that nents would be appropriate to start 
with. That said, it does look like there are some places (e.g. the block 
layer) which may not cope properly with limits less than PAGE_SIZE, so I 
guess the reliability of dma_parms might depend on how much you want to 
go spelunking in core code :/

Robin.
