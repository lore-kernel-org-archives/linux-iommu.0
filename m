From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/5] dma-direct: implement complete bus_dma_mask handling
Date: Thu, 27 Sep 2018 17:41:36 +0100
Message-ID: <b87ef7ac-81fc-c649-7ffb-73017ec99790@arm.com>
References: <20180920185247.20037-1-hch@lst.de>
	<20180920185247.20037-5-hch@lst.de>
	<a7626d1b-4dd8-abc4-0ab0-21ab7e5d1a4c@arm.com>
	<20180927153252.GE10566@lst.de>
	<967e98b1-99ab-8f95-4c89-6156ce489b93@arm.com>
	<20180927162737.GA11974@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180927162737.GA11974-jcswGhMUV9g@public.gmane.org>
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

On 27/09/18 17:27, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 05:14:56PM +0100, Robin Murphy wrote:
>>> This just seemed more readable to me than min_not_zero, but if others
>>> prefer min_not_zero I can switch.
>>
>> Nah, just checking whether there were any intentionally different
>> assumptions compared to the couple of other places in the patch where
>> min_not_zero() *is* used. If it's purely a style thing then no worries
>> (personally I'd have written it yet another way anyway).
> 
> I'm curious: how would you have written it?

Come to think of it, I actually already have, in iommu-dma:

	if (dev->bus_dma_mask)
		mask &= dev->bus_dma_mask;

but of course it's not so pretty for those cases where you don't already 
have the local variable ready to go.

Robin.
