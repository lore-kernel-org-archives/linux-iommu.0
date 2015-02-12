From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Kernel Oops: iommu related?
Date: Thu, 12 Feb 2015 19:08:46 +0100
Message-ID: <20150212180846.GD29106@8bytes.org>
References: <54DCE8A6.4000608@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54DCE8A6.4000608-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 12, 2015 at 12:53:42PM -0500, Mark Hounschell wrote:
> This happens immediately after unloading one of our out of kernel GPL drivers.
> The driver has done NOTHING other than load at bootup.  I'm running a 3.18.7
> kernel (x86_64) on an AMD platform. I can't see anything obviously wrong in our
> driver. It works fine when the iommu is disabled. This particular machine has 7 of
> our cards in it. Four in one expansion rack and 3 in another. The 2 PCI expansion
> racks use pci-e interface cards installed in the MB.
> 
> Feb 12 10:47:15 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000ae640 flags=0x0070]
> Feb 12 10:47:15 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000ae660 flags=0x0070]
> Feb 12 10:47:15 harley kernel: AMD-Vi: Event logged [IO_PAGE_FAULT device=0f:00.0 domain=0x0000 address=0x00000000000ae670 flags=0x0070]
> Feb 12 10:47:27 harley kernel: ------------[ cut here ]------------
> Feb 12 10:47:27 harley kernel: WARNING: CPU: 3 PID: 0 at drivers/iommu/amd_iommu.c:2637 dma_ops_domain_unmap.part.13+0x65/0x70()

This warning indicates that some driver is unmapping a dma range that
was not mapped previously (meaning that a pte in the io-page-tables is
zeroed out).
The reason for this (and the IO_PAGE_FAULTs) you see are almost
certainly because some driver does not use the DMA-API correctly.


	Joerg
