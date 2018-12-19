From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH dma-mapping tree] arm64: default to the direct mapping
	in get_arch_dma_ops
Date: Wed, 19 Dec 2018 18:00:34 +0100
Message-ID: <20181219170034.GA26129@lst.de>
References: <20181214150240.26427-1-hch@lst.de>
	<3a6c8eff-a5dd-6a17-71ed-f480df3801d8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3a6c8eff-a5dd-6a17-71ed-f480df3801d8-5wv7dgnIgG8@public.gmane.org>
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
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 19, 2018 at 04:59:03PM +0000, Robin Murphy wrote:
> On 14/12/2018 15:02, Christoph Hellwig wrote:
>> Otherwise the direct mapping won't work at all given that a NULL
>> dev->dma_ops causes a fallback.  Note that we already explicitly set
>> dev->dma_ops to dma_dummy_ops for dma-incapable devices, so this
>> fallback should not be needed anyway.
>
> Sorry, I'd somehow completely missed that you'd sent a proper patch for 
> this - indeed it looks like the right change to make.
>
> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Thanks.  I've added this given that I hadn't pushed out the tree yet.
