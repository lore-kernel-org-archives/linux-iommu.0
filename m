From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
Date: Tue, 10 Jul 2018 20:02:32 +0200
Message-ID: <20180710180232.GA26285@lst.de>
References: <cover.1531239284.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1531239284.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> These patches attempt to deal with this in the simplest way possible by
> generalising the specific quirk for 32-bit bridges into an arbitrary
> mask which can then also be plumbed into the firmware code. In the
> interest of being minimally invasive, I've only included a point fix
> for the IOMMU issue as seen on arm64 - there may be further tweaks
> needed in DMA ops to catch all possible incarnations of this problem,
> but this initial RFC is mostly about the impact beyond the dma-mapping
> subsystem itself.

Thanks, this looks very nice to me.

In fact it probably solves the RISC-V/Xiling problem as well if we can
just add the dma-ranges property to the device tree for the affected
systems.  Palmer, do you know how easily the DT could be updated for
that case?

> 
> Robin.
> 
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/580804.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-December/474443.html
> 
> Robin Murphy (4):
>   dma-mapping: Generalise dma_32bit_limit flag
>   ACPI/IORT: Set bus DMA mask as appropriate
>   of/device: Set bus DMA mask as appropriate
>   iommu/dma: Respect bus DMA limit for IOVAs
> 
>  arch/x86/kernel/pci-dma.c | 2 +-
>  drivers/acpi/arm64/iort.c | 1 +
>  drivers/iommu/dma-iommu.c | 3 +++
>  drivers/of/device.c       | 1 +
>  include/linux/device.h    | 6 +++---
>  kernel/dma/direct.c       | 2 +-
>  6 files changed, 10 insertions(+), 5 deletions(-)
> 
> -- 
> 2.17.1.dirty
---end quoted text---
