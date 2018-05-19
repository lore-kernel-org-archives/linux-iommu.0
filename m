From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: add swiotlb support for riscv
Date: Sat, 19 May 2018 08:35:34 +0200
Message-ID: <20180519063534.GA17809@lst.de>
References: <20180516144302.823-1-hch@lst.de>
	<mhng-268a981e-4623-4e88-baf3-09cb0fbaca25@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <mhng-268a981e-4623-4e88-baf3-09cb0fbaca25@palmer-si-x1c4>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
Cc: linux-riscv-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 18, 2018 at 04:31:36PM -0700, Palmer Dabbelt wrote:
>>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/riscv-swiotlb
>
> Ah, great!  This is much cleaner than our current implementation, which 
> isn't based on the generic stuff :).  I'm happy to have these through that 
> tree if it makes the merging easier, feel free to add an
>
>    Acked-by: Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
>
> and/or a
>
>    Reviewed-by: Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
>
> on all 3 of these patches if that helps.  I'm going to park them on my 
> next-swiotlb branch so I can use them, but I won't submit them myself 
> unless someone says something.

I think it is indeed easiest if I pull them into the dma-mapping tree.

Feel free the keep them in a riscv branch as well, but remember that
they depend on other patches in the dma-mapping tree that consolidate
the SWIOTLB Kconfig symbol.
