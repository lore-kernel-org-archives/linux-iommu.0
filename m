From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] iommu: Constify struct iommu_ops
Date: Mon, 7 Jul 2014 10:40:12 +0200
Message-ID: <20140707084011.GB1958@8bytes.org>
References: <1403852592-10637-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403852592-10637-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 27, 2014 at 09:03:12AM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This structure is read-only data and should never be modified.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add missing hunk from include/device.h
> 
>  drivers/iommu/amd_iommu.c       |  4 ++--
>  drivers/iommu/arm-smmu.c        |  2 +-
>  drivers/iommu/exynos-iommu.c    |  2 +-
>  drivers/iommu/fsl_pamu_domain.c |  2 +-
>  drivers/iommu/intel-iommu.c     |  4 ++--
>  drivers/iommu/iommu.c           | 19 ++++++++++++++-----
>  drivers/iommu/ipmmu-vmsa.c      |  2 +-
>  drivers/iommu/msm_iommu.c       |  2 +-
>  drivers/iommu/omap-iommu.c      |  2 +-
>  drivers/iommu/shmobile-iommu.c  |  2 +-
>  drivers/iommu/tegra-gart.c      |  2 +-
>  drivers/iommu/tegra-smmu.c      |  2 +-
>  include/linux/device.h          |  2 +-
>  include/linux/iommu.h           |  4 ++--
>  14 files changed, 30 insertions(+), 21 deletions(-)

Applied, thanks.
