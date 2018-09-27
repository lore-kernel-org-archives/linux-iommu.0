From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
Date: Thu, 27 Sep 2018 16:38:31 +0100
Message-ID: <2b98d7b2-bf74-ccc9-881a-a91e2c9949c3@arm.com>
References: <20180920185247.20037-1-hch@lst.de>
	<20180920185247.20037-4-hch@lst.de>
	<fd524731-a0aa-b970-d320-fe209b9c68f6@arm.com>
	<20180927153028.GD10566@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180927153028.GD10566-jcswGhMUV9g@public.gmane.org>
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
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 27/09/18 16:30, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 03:30:20PM +0100, Robin Murphy wrote:
>>>    +static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64
>>> dma_mask,
>>> +		u64 *phys_mask)
>>> +{
>>> +	if (force_dma_unencrypted())
>>> +		*phys_mask = __dma_to_phys(dev, dma_mask);
>>> +	else
>>> +		*phys_mask = dma_to_phys(dev, dma_mask);
>>
>> Maybe make phys_to_dma_direct() take u64 instead of phys_addr_t so we can
>> reuse it here?
> 
> This is a dma_to_phys and not a phys_to_dma.

Ugh, clearly it's time to stop reviewing patches for today... sorry :(

Robin.
