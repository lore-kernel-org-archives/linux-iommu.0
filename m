From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 0/3] arm64: IOMMU-backed DMA mapping
Date: Thu, 15 Oct 2015 17:04:43 +0200
Message-ID: <20151015150443.GA26332@8bytes.org>
References: <cover.1443718557.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1443718557.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 01, 2015 at 08:13:57PM +0100, Robin Murphy wrote:
> Robin Murphy (3):
>   iommu: Implement common IOMMU ops for DMA mapping
>   arm64: Add IOMMU dma_ops
>   arm64: Hook up IOMMU dma_ops
> 
>  arch/arm64/Kconfig                   |   1 +
>  arch/arm64/include/asm/dma-mapping.h |  15 +-
>  arch/arm64/mm/dma-mapping.c          | 457 ++++++++++++++++++++++++++++++
>  drivers/iommu/Kconfig                |   7 +
>  drivers/iommu/Makefile               |   1 +
>  drivers/iommu/dma-iommu.c            | 524 +++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h            |  85 ++++++
>  include/linux/iommu.h                |   1 +
>  8 files changed, 1083 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/iommu/dma-iommu.c
>  create mode 100644 include/linux/dma-iommu.h

Applied to the core branch.
