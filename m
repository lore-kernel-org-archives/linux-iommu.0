From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] arm64: remove dummy_dma_ops
Date: Fri, 3 Aug 2018 16:05:22 +0100
Message-ID: <55940a06-4418-287c-1a6c-3db18a0e3ddd@arm.com>
References: <20180802121318.5785-1-hch@lst.de>
	<bbb22836-8f2f-5b2f-4801-342643fd9c1b@arm.com>
	<20180802124328.GA24812@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180802124328.GA24812-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/08/18 13:43, Christoph Hellwig wrote:
> On Thu, Aug 02, 2018 at 01:32:17PM +0100, Robin Murphy wrote:
>> On 02/08/18 13:13, Christoph Hellwig wrote:
>>> Returning NULL from get_arch_dma_ops makes all DMA mapping routines
>>> retourn sensible errors, so remove the dummy ops.
>>
>> Does it? AFAICS all of the non-optional callbacks will still either
>> BUG_ON(!ops) or blindly dereference the null pointer. Have I lost track of
>> another cleanup patch somewhere?
> 
> First thing any driver needs to do is dma_set_mask, which first calls
> dma_supported:
> 
> static inline int dma_supported(struct device *dev, u64 mask)
> {
>          const struct dma_map_ops *ops = get_dma_ops(dev);
> 
> 	if (!ops)
> 		return 0;
> 	...
> }
> 

Yeah, apart from all the drivers that don't. After last week's fun I'm 
not putting any reliance in that assumption ;)

Of course, the combination of a cheeky legacy driver assuming 32-bit DMA 
*and* busted firmware failing to describe that device properly should be 
rare enough that this change is almost certainly a non-issue in 
practice, but I'm still never going to say I love it.

Robin.
