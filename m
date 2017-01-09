From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 3/4] iommu/exynos: Ensure that SYSMMU is added only
	once to its master device
Date: Mon, 9 Jan 2017 14:30:53 +0000
Message-ID: <fc7e0a6e-e65b-2a58-4c19-5bc31e36363c@arm.com>
References: <1483963436-29803-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20170109120412eucas1p27f3aab2d42712a9783d79bb4e06d01d5@eucas1p2.samsung.com>
	<1483963436-29803-4-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1483963436-29803-4-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

On 09/01/17 12:03, Marek Szyprowski wrote:
> This patch prepares Exynos IOMMU driver for deferred probing
> support. Once it gets added, of_xlate() callback might be called
> more than once for the same SYSMMU controller and master device
> (for example it happens when masters device driver fails with
> EPROBE_DEFER). This patch adds a check, which ensures that SYSMMU
> controller is added to its master device (owner) only once.

FWIW, I think it would be better to address that issue in the
probe-deferral code itself, rather than fixing up individual IOMMU
drivers. In fact, I *think* it's already covered in the latest version
of the of_iommu_configure() changes[1], specifically this bit:

	...
	if (fwspec) {
		if (fwspec->ops)
			return fwspec->ops;
	...

Which should ensure that a successful IOMMU configuration happens
exactly once between device creation and destruction.

That said, this patch would still add robustness against actual error
conditions, e.g. an erroneous DT which managed to specify the same
phandle twice, although making it "if (WARN_ON(entry == data))" might be
a good idea.

Robin.

[1]:https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg15333.html

> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/exynos-iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b0d537e6a445..8bf5a06a6c01 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1253,7 +1253,7 @@ static int exynos_iommu_of_xlate(struct device *dev,
>  {
>  	struct exynos_iommu_owner *owner = dev->archdata.iommu;
>  	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
> -	struct sysmmu_drvdata *data;
> +	struct sysmmu_drvdata *data, *entry;
>  
>  	if (!sysmmu)
>  		return -ENODEV;
> @@ -1272,6 +1272,10 @@ static int exynos_iommu_of_xlate(struct device *dev,
>  		dev->archdata.iommu = owner;
>  	}
>  
> +	list_for_each_entry(entry, &owner->controllers, owner_node)
> +		if (entry == data)
> +			return 0;
> +
>  	list_add_tail(&data->owner_node, &owner->controllers);
>  	data->master = dev;
>  
> 
