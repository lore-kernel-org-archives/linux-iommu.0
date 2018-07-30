From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] sparc: use generic dma_noncoherent_ops
Date: Mon, 30 Jul 2018 21:41:18 +0200
Message-ID: <20180730194118.GA31658@ravnborg.org>
References: <20180730161723.9445-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180730161723.9445-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph.

On Mon, Jul 30, 2018 at 06:17:23PM +0200, Christoph Hellwig wrote:
> Switch to the generic noncoherent direct mapping implementation.
> 
> This removes the previous sync_single_for_device implementation, which
> looks bogus given that no syncing is happening in the similar but more
> important map_single case.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> Acked-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
> ---
>  Makefile                             |   2 +-
>  arch/sparc/Kconfig                   |   2 +
>  arch/sparc/include/asm/dma-mapping.h |   5 +-
>  arch/sparc/kernel/ioport.c           | 193 +++++----------------------
>  4 files changed, 36 insertions(+), 166 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 85f3481a56d6..8a3fd0c4a76e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -368,7 +368,7 @@ HOST_LOADLIBES := $(HOST_LFS_LIBS)
>  # Make variables (CC, etc...)
>  AS		= $(CROSS_COMPILE)as
>  LD		= $(CROSS_COMPILE)ld
> -CC		= $(CROSS_COMPILE)gcc
> +CC		= sparc64-linux-gnu-gcc-8
>  CPP		= $(CC) -E
>  AR		= $(CROSS_COMPILE)ar
>  NM		= $(CROSS_COMPILE)nm
This sneaked in by accident...

	Sam
