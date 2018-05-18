From: Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
Subject: Re: add swiotlb support for riscv
Date: Fri, 18 May 2018 16:31:36 -0700 (PDT)
Message-ID: <mhng-268a981e-4623-4e88-baf3-09cb0fbaca25@palmer-si-x1c4>
References: <20180516144302.823-1-hch@lst.de>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180516144302.823-1-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 16 May 2018 07:42:59 PDT (-0700), Christoph Hellwig wrote:
> Current 64-bit RISC-V cores don't have any iommu support, so they need
> iommu support when used with more than 4GB DRAM (or even just address
> space depending on the SBI).  This wires the support up based on
> earlier patches from Palmer.

Yep: the FU540-C000 has a feature where DRAM is always mapped at 2GiB physical, 
so if we have more than 2GiB of DRAM (we have 8GiB on the only board it'll 
probably ever be attached to) then we need swiotlb to do 32-bit DMA.

> Note that the patches are on to of the dma mapping tree as they require
> the swiotlb Kconfig consolidation, and should probably merged through
> that tree as well.
>
> Git tree:
>
>     git://git.infradead.org/users/hch/misc.git riscv-swiotlb
>
> Gitweb:
>
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/riscv-swiotlb

Ah, great!  This is much cleaner than our current implementation, which isn't 
based on the generic stuff :).  I'm happy to have these through that tree if it 
makes the merging easier, feel free to add an

    Acked-by: Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>

and/or a

    Reviewed-by: Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>

on all 3 of these patches if that helps.  I'm going to park them on my 
next-swiotlb branch so I can use them, but I won't submit them myself unless 
someone says something.
