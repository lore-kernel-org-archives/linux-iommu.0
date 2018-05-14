From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 3/3] arm64: Force swiotlb bounce buffering for
	non-coherent DMA with large CWG
Date: Mon, 14 May 2018 15:57:03 +0100
Message-ID: <20180514145703.celnlobzn3uh5tc2@localhost>
References: <20180511135547.34521-1-catalin.marinas@arm.com>
	<20180511135547.34521-4-catalin.marinas@arm.com>
	<20180512123829.GA8024@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180512123829.GA8024-jcswGhMUV9g@public.gmane.org>
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
Cc: Yang Li <pku.leo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, May 12, 2018 at 02:38:29PM +0200, Christoph Hellwig wrote:
> On Fri, May 11, 2018 at 02:55:47PM +0100, Catalin Marinas wrote:
> > On systems with a Cache Writeback Granule (CTR_EL0.CWG) greater than
> > ARCH_DMA_MINALIGN, DMA cache maintenance on sub-CWG ranges is not safe,
> > leading to data corruption. If such configuration is detected, the
> > kernel will force swiotlb bounce buffering for all non-coherent devices.
> 
> Per the previous discussion I understand that so far this is a
> purely theoretical condition. 

That's what we think, at least for publicly available hardware.

> Given that I'd rather avoid commiting this patch and just refuse too
> boot in this case.

I'll keep it to a WARN_TAINT() for now. Given that the warn triggers
only when cache_line_size() > ARCH_DMA_MINALIGN and we keep this
constant unchanged (128), it shouldn't be much different from our
current assumptions and no-one complained of DMA corruption so far.

> In a merge window or two I plan to have a noncoherent flag in struct
> device, at which point we can handle this entirely in common code.

Sounds ok, looking forward to this.

Thanks.

-- 
Catalin
