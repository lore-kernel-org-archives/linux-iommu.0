From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/7] iommu: Fix DMA alias problems
Date: Fri, 4 Jul 2014 12:36:53 +0200
Message-ID: <20140704103653.GU26537@8bytes.org>
References: <20140703154428.8112.97562.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140703154428.8112.97562.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 03, 2014 at 09:51:12AM -0600, Alex Williamson wrote:
> Alex Williamson (7):
>       iommu: Remove pci.h
>       iommu/fsl: Use iommu_group_get_for_dev() for IOMMU groups
>       iommu/intel: Update to use PCI DMA aliases
>       iommu/intel: Use iommu_group_get_for_dev()
>       iommu/amd: Use iommu_group_get_for_dev()
>       iommu/amd: Update to use PCI DMA aliases
>       iommu: Create central IOMMU group lookup/creation interface
> 
> 
>  drivers/iommu/amd_iommu.c           |  214 +++++++-----------------
>  drivers/iommu/amd_iommu_types.h     |    1 
>  drivers/iommu/fsl_pamu_domain.c     |   66 --------
>  drivers/iommu/intel-iommu.c         |  307 +++++++++++++----------------------
>  drivers/iommu/intel_irq_remapping.c |   55 ++++--
>  drivers/iommu/iommu.c               |  182 +++++++++++++++++++++
>  drivers/iommu/pci.h                 |   29 ---
>  include/linux/iommu.h               |    1 
>  8 files changed, 398 insertions(+), 457 deletions(-)
>  delete mode 100644 drivers/iommu/pci.h

Applied to the core branch, thanks Alex.
