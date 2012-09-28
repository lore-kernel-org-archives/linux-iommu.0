From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] Intel IOMMU patch to reprocess RMRR info
Date: Fri, 28 Sep 2012 10:30:06 -0600
Message-ID: <1348849806.2320.359.camel@ul30vt.home>
References: <uh6q9m8bwu6c2jov69m2aivu.1348847561292@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <uh6q9m8bwu6c2jov69m2aivu.1348847561292-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, "Khan, Shuah" <shuah.khan-VXdhtT5mjnY@public.gmane.org>, "Mingarelli, Thomas" <Thomas.Mingarelli-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2012-09-28 at 16:52 +0100, David Woodhouse wrote:
> HP may have been shipping such things 'for a while' but it's never
> actually worked right, yes? This thread is about the patch that's
> intended to *fix* that?

I believe it currently works in non-passthrough mode since the RMRRs
stick for that.  It hasn't worked in passthrough mode since we disabled
swiotlb and started kicking 32bit dma mask devices out of the si domain.
It has probably never worked for VM usage if anyone has made the mistake
of attempting that.

> If they could just manage to make their firmware-owned DMA appear to
> be from a different PCIe device/function from the one the OS gets to
> own, that would make things "just work", right? Hell, their laptops
> already have Ricoh multi-function devices that do their DMA  from the
> 'wrong' function.... take that concept and make it useful...
> 
> If the DMA could be hidden from the IOMMU altogether, all the better.
> But at least coming from its own dedicated devfn would avoid the
> issues this patch attempts to solve.

Hmm, an RMRR for a non-existent device would cause problems when we try
to figure out the dma mask... if nothing else.  The proposal seems to
open pandora's box just a little further :-\  Maybe it would have to
live outside of device ranges claimed by the DRHDs, but that implies
physical topology changes.  Thanks,

Alex
