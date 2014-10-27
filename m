From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH linux-next] iommu: add iommu for s390 platform
Date: Mon, 27 Oct 2014 17:25:02 +0100
Message-ID: <20141027162502.GB6202@8bytes.org>
References: <1413892645-37657-1-git-send-email-blaschka@linux.vnet.ibm.com>
	<20141022141728.GG10074@8bytes.org>
	<20141022154320.GA42442@tuxmaker.boeblingen.de.ibm.com>
	<20141023124115.GB10053@8bytes.org>
	<20141023140437.GA31009@tuxmaker.boeblingen.de.ibm.com>
	<20141027153201.517f4ff4@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141027153201.517f4ff4@thinkpad>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Cc: linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, Frank Blaschka <blaschka-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 27, 2014 at 03:32:01PM +0100, Gerald Schaefer wrote:
> Not sure if I understood the concept of IOMMU domains right. But if this
> is about having multiple devices in the same domain, so that iommu_ops->map
> will establish the _same_ DMA mapping on _all_ registered devices, then
> this should be possible.

Yes, this is what domains are about. A domain describes a set of DMA
mappings which can be assigned to multiple devices in parallel.

> We cannot have shared DMA tables because each device gets its own DMA table
> allocated during device initialization.

Is there some hardware reason for this or is that just an implementation
detail that can be changed. In other words, does the hardware allow to
use the same DMA table for multiple devices?

> But we could just keep all devices from one domain in a list and then
> call dma_update_trans() for all devices during iommu_ops->map/unmap.

This sounds complicated. Note that a device can be assigned to a domain that
already has existing mappings. In this case you need to make sure that
the new device inherits these mappings (and destroy all old mappings for
the device that possibly exist).

I think it is much easier to use the same DMA table for all devices in a
domain, if the hardware allows that.


	Joerg
