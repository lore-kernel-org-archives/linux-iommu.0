From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/3] iommu: Avoid DMA ops domain refcount contention
Date: Mon, 17 Sep 2018 12:20:04 +0100
Message-ID: <dbb9e48f-e31b-b8a1-0287-378c35e9fdb9@huawei.com>
References: <cover.1536764440.git.robin.murphy@arm.com>
	<20180914124858.GA4010@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180914124858.GA4010-5wv7dgnIgG8@public.gmane.org>
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
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 14/09/2018 13:48, Will Deacon wrote:
> Hi Robin,
>

Hi Robin,

I just spoke with Dongdong and we will test this version also so that we 
may provide a "Tested-by" tag.

Thanks,
John

> On Wed, Sep 12, 2018 at 04:24:11PM +0100, Robin Murphy wrote:
>> John raised the issue[1] that we have some unnecessary refcount contention
>> in the DMA ops path which shows scalability problems now that we have more
>> real high-performance hardware using iommu-dma. The x86 IOMMU drivers are
>> sidestepping this by stashing domain references in archdata, but since
>> that's not very nice for architecture-agnostic code, I think it's time to
>> look at a generic API-level solution.
>>
>> These are a couple of quick patches based on the idea I had back when
>> first implementing iommu-dma, but didn't have any way to justify at the
>> time. However, the reports of 10-25% better networking performance on v1
>> suggest that it's very worthwhile (and far more significant than I ever
>> would have guessed).
>>
>> As far as merging goes, I don't mind at all whether this goes via IOMMU,
>> or via dma-mapping provided Joerg's happy to ack it.
>
> I think it makes most sense for Joerg to take this series via his tree.
>
> Anyway, I've been running them on my TX2 box and things are happy enough,
> so:
>
> Tested-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
>
> Will
>
> .
>
