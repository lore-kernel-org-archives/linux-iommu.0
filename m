From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 1/2] iommu/exynos: add devices attached to the System
	MMU to an IOMMU group
Date: Fri, 26 Jul 2013 10:18:31 +0530
Message-ID: <CAK9yfHw1Q9tmARR9W9WGaW5hhzcSQ5CV13Ct=7LT8pj85tBMBA@mail.gmail.com>
References: <1374766502-14823-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1374766502-14823-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Antonios,

On 25 July 2013 21:04, Antonios Motakis
<a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org> wrote:
> IOMMU groups are expected by certain users of the IOMMU API,
> e.g. VFIO. Since each device is behind its own System MMU, we
> can allocate a new IOMMU group for each device.
>
> This patch depends on Cho KyongHo's patch series titled "[PATCH v7 00/12]
> iommu/exynos: Fixes and Enhancements of System MMU driver with DT",
> applied on a Linux 3.10.1 kernel.

This kind of meta information should go after the "---" line below.

It has been tested on the Arndale board.
>
> Changes since in v2:
> - Removed possibility for minor memory leak in case of
>   misbehaving platform drivers
>
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  drivers/iommu/exynos-iommu.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 51d43bb..c7dd4b5 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1134,6 +1134,32 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
>         return phys;
>  }
>
> +static int exynos_iommu_add_device(struct device *dev)
> +{
> +       struct iommu_group *group;
> +       int ret;
> +
> +       group = iommu_group_get(dev);
> +
> +       if (!group) {
> +               group = iommu_group_alloc();
> +               if (IS_ERR(group)) {
> +                       dev_err(dev, "Failed to allocate IOMMU group\n");
> +                       return PTR_ERR(group);
> +               }
> +       }
> +
> +       ret = iommu_group_add_device(group, dev);
> +       iommu_group_put(group);
> +
> +       return ret;
> +}
> +
> +static void exynos_iommu_remove_device(struct device *dev)
> +{
> +       iommu_group_remove_device(dev);
> +}
> +
>  static struct iommu_ops exynos_iommu_ops = {
>         .domain_init = &exynos_iommu_domain_init,
>         .domain_destroy = &exynos_iommu_domain_destroy,
> @@ -1142,6 +1168,8 @@ static struct iommu_ops exynos_iommu_ops = {
>         .map = &exynos_iommu_map,
>         .unmap = &exynos_iommu_unmap,
>         .iova_to_phys = &exynos_iommu_iova_to_phys,
> +       .add_device     = exynos_iommu_add_device,
> +       .remove_device  = exynos_iommu_remove_device,
>         .pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>  };
>
> --
> 1.8.1.2
>



-- 
With warm regards,
Sachin
