From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 0/3] iommu: Avoid DMA ops domain refcount contention
Date: Fri, 17 Aug 2018 12:30:31 +0100
Message-ID: <74796f9d-5320-ea26-630a-207f4c537c55@arm.com>
References: <cover.1534250425.git.robin.murphy@arm.com>
	<20180817072415.GA22241@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180817072415.GA22241-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17/08/18 08:24, Christoph Hellwig wrote:
> I plan to make the arm iommu dma ops generic and move them to
> drivers/iommu for the 4.20 merge window.

You mean 32-bit arm? The only place that code should move to is 
/dev/null ;) - the plan has always been to convert it to use groups and 
default domains so it can just plug iommu-dma in. The tricky bit is 
either weaning the users of the private arm_iommu_*() API onto generic 
IOMMU API usage, or at least implementing transitional wrappers in a way 
that doesn't break anything.

>  Because of that it would
> be great to create a stable branch or even pull this in through
> the dma-mapping tree entirely.

FWIW I might still need to tweak the first patch depending on how we 
choose to resolve the interaction between DMA ops and unmanaged 
domains[1] - if we want to add fallback paths to iommu-dma instead of 
swizzling device ops then the assumptions for this hook change and it 
will need to reference group->domain rather than group->default_domain.

Robin.


[1] 
https://www.mail-archive.com/dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org/msg230275.html
