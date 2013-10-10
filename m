From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v10 20/20] iommu/exynos: add devices attached to the
	System MMU to an IOMMU group
Date: Thu, 10 Oct 2013 14:54:29 -0600
Message-ID: <1381438469.2796.58.camel@ul30vt.home>
References: <20131007105844.a260f37a9a941bed894adca3@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131007105844.a260f37a9a941bed894adca3-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Subash Patel <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2013-10-07 at 10:58 +0900, Cho KyongHo wrote:
> Patch written by Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>:
> 
> IOMMU groups are expected by certain users of the IOMMU API,
> e.g. VFIO. Since each device is behind its own System MMU, we
> can allocate a new IOMMU group for each device.
> 
> Reviewd-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  drivers/iommu/exynos-iommu.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 5025338..24505a0 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1028,6 +1028,32 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
>  	return phys;
>  }
>  
> +static int exynos_iommu_add_device(struct device *dev)
> +{
> +	struct iommu_group *group;
> +	int ret;
> +
> +	group = iommu_group_get(dev);

Seems reasonable, my only nit would be whether it's really an error to
get a group back from the above call.  If devices are always isolated
and IOMMU groups are always singleton, it would be an error to find one
already associated with the device.  Right?  Thanks,

Alex

> +
> +	if (!group) {
> +		group = iommu_group_alloc();
> +		if (IS_ERR(group)) {
> +			dev_err(dev, "Failed to allocate IOMMU group\n");
> +			return PTR_ERR(group);
> +		}
> +	}
> +
> +	ret = iommu_group_add_device(group, dev);
> +	iommu_group_put(group);
> +
> +	return ret;
> +}
> +
> +static void exynos_iommu_remove_device(struct device *dev)
> +{
> +	iommu_group_remove_device(dev);
> +}
> +
>  static struct iommu_ops exynos_iommu_ops = {
>  	.domain_init = &exynos_iommu_domain_init,
>  	.domain_destroy = &exynos_iommu_domain_destroy,
> @@ -1036,6 +1062,8 @@ static struct iommu_ops exynos_iommu_ops = {
>  	.map = &exynos_iommu_map,
>  	.unmap = &exynos_iommu_unmap,
>  	.iova_to_phys = &exynos_iommu_iova_to_phys,
> +	.add_device = &exynos_iommu_add_device,
> +	.remove_device = &exynos_iommu_remove_device,
>  	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>  };
>  
