From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: fix leak in arm_smmu_flush_pgtable
Date: Thu, 05 Mar 2015 18:44:29 +0000
Message-ID: <54F8A40D.5030608@arm.com>
References: <1425514685-23831-1-git-send-email-mitchelh@codeaurora.org>	<54F83235.70700@arm.com>
	<vnkwsidjtkv1.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <vnkwsidjtkv1.fsf-Yf+dfxj6toJBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 05/03/15 17:28, Mitchel Humpherys wrote:
> On Thu, Mar 05 2015 at 02:38:45 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> Hi Mitch,
>>
>> On 05/03/15 00:18, Mitchel Humpherys wrote:
>>> We're currently mapping a page in arm_smmu_flush_pgtable without ever
>>> unmapping it.  Fix this by calling dma_unmap_page on the returned dma
>>> address.  Since the only reason we're calling dma_map_page is to make
>>> sure it actually gets flushed out to RAM, we can just call
>>> dma_unmap_page immediately following the map.
>>>
>>> Without this, eventually swiotlb runs out of memory and starts printing
>>> things like:
>>>
>>>       [   35.545076] arm-smmu d00000.arm,smmu: swiotlb buffer is full (sz: 128 bytes)
>>>
>>
>> So, you have non-coherent SMMUs too ;) The real problem is that the SMMU's
>> DMA mask is wrong (as it happens I've just given Will a patch to fix that)
>> - this is really just doing a whole bunch of unnecessary work (two memory
>> copies and two cache flushes, one of which isn't even flushing the right
>> area) to hide the problem. With an appropriate DMA mask set,
>> swiotlb_map_page becomes a no-op and we fall through to the cache flush
>> without ever allocating anything.
>
> Yeah I noticed that as well...  But isn't this still incorrect usage of
> the API (DMA-API-HOWTO.txt seems to indicate that calls to map should
> always be balanced with calls to unmap)?  What we really want to do here
> is just call __dma_map_area directly, but the comment on that guy
> expressly forbids it...  Not sure what's worse, abusing the DMA API or
> disobeying that comment?

Actually, I think we've figured out a fairly nice way to make the core 
io-pgtbl code more DMA-API aware, so we can make all the appropriate 
calls for the way we're actually using the page tables - I'm having a go 
at a patch now...

Robin.
