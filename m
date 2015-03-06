From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: move pgsize_bitmap from struct iommu_ops to
	struct iommu_domain
Date: Fri, 06 Mar 2015 13:56:08 +0200
Message-ID: <3242222.7VyhtFfsx7@avalon>
References: <1425641688-26438-1-git-send-email-will.deacon@arm.com>
	<1425641688-26438-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1425641688-26438-2-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

Thank you for the patch.

On Friday 06 March 2015 11:34:47 Will Deacon wrote:
> struct iommu_ops contains function pointers for IOMMU driver callbacks
> in order to implement the core IOMMU API. Amongst these pointers is
> an unsigned long pgsize_bitmap field, which is problematic because the
> set of supported page sizes is not necessarily the same across all
> instances of a given IOMMU type in the system. Furthermore, the set of
> supported page sizes may be restricted following domain initialisation
> when a particular page table format is chosen for the domain.
> 
> This patch moves the field from iommu_ops into the iommu_domain and
> updates all users accordingly.
> 
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c       |  2 +-
>  drivers/iommu/arm-smmu.c        | 12 +++++-------
>  drivers/iommu/exynos-iommu.c    |  3 ++-
>  drivers/iommu/intel-iommu.c     |  2 +-
>  drivers/iommu/iommu.c           | 16 ++++++++--------
>  drivers/iommu/ipmmu-vmsa.c      |  2 +-
>  drivers/iommu/msm_iommu.c       |  3 ++-
>  drivers/iommu/omap-iommu.c      |  3 ++-
>  drivers/iommu/rockchip-iommu.c  |  2 +-
>  drivers/iommu/shmobile-iommu.c  |  2 +-
>  drivers/iommu/tegra-gart.c      |  2 +-
>  drivers/iommu/tegra-smmu.c      |  3 +--
>  drivers/vfio/vfio_iommu_type1.c |  2 +-
>  include/linux/iommu.h           |  6 +-----
>  14 files changed, 28 insertions(+), 32 deletions(-)

[snip]

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 10186cac7716..cd867b255b99 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -469,6 +469,7 @@ static int ipmmu_domain_init(struct iommu_domain
> *io_domain)
> 
>  	io_domain->priv = domain;
>  	domain->io_domain = io_domain;
> +	domain->pgsize_bitmap = SZ_2M | SZ_64K | SZ_4K;

You're changing the bitmap, was it intended ?

>  	return 0;
>  }
> @@ -747,7 +748,6 @@ static const struct iommu_ops ipmmu_ops = {
>  	.iova_to_phys = ipmmu_iova_to_phys,
>  	.add_device = ipmmu_add_device,
>  	.remove_device = ipmmu_remove_device,
> -	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
>  };
> 
>  /* ------------------------------------------------------------------------ 

-- 
Regards,

Laurent Pinchart
