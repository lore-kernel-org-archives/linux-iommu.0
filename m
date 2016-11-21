From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: BUG at drivers/iommu/amd_iommu.c:1436!
Date: Mon, 21 Nov 2016 16:32:50 +0100
Message-ID: <20161121153250.GE2078@8bytes.org>
References: <838275de-6cac-93d8-ca04-54b06a24b3d4@compro.net>
	<20161117214141.GC2078@8bytes.org>
	<f4ababc2-64bf-fd0e-1d18-cb5963d23eb1@compro.net>
	<20161117220045.GD2078@8bytes.org>
	<b8260bfd-55c9-c029-1af1-e1ccc719dd3a@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b8260bfd-55c9-c029-1af1-e1ccc719dd3a-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 18, 2016 at 09:04:05AM -0500, Mark Hounschell wrote:
> OK. It's attached.

> [   45.033715] WARNING: CPU: 0 PID: 0 at lib/dma-debug.c:1158 check_unmap+0x4ef/0x990
> [   45.037651] 3c59x 0000:04:04.0: DMA-API: device driver failed to check map error[device address=0x00000000ffedf840] [size=1536 bytes] [mapped as single]

Okay, there is a dma-debug warning from the 3c59x driver. Can you please
blacklist this driver (or compile it out) and re-try? The dma-debug code
will only show the first warning and stop then. So any possible warnings
from your out-of-tree driver will not be shown as long as the 3c59x
driver is loaded.

Alternativly you can write 1 to dma-api/all_errors in debug-fs so that
it will show all errors. But I suggest to unload the 3com driver first
and then load your driver.


	Joerg
