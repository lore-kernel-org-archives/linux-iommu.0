From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] iommu/exynos: Add default_domain check in
	iommu_attach_device
Date: Tue, 29 Nov 2016 17:48:23 +0100
Message-ID: <20161129164823.GD13850@8bytes.org>
References: <1479986420-30859-1-git-send-email-m.szyprowski@samsung.com>
	<1479986420-30859-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479986420-30859-5-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 24, 2016 at 12:20:19PM +0100, Marek Szyprowski wrote:
> This patch adds default_domain check before calling
> exynos_iommu_detach_device. This path was intended only to cope with
> default domains, which are automatically attached by the iommu core, so
> return error if user tries to attach device, which is already attached
> to other (non-default) domain.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/exynos-iommu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 426b1534d4d3..63d9358a6d9c 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -859,8 +859,17 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
>  	if (!has_sysmmu(dev))
>  		return -ENODEV;
>  
> -	if (owner->domain)
> +	if (owner->domain) {
> +		struct iommu_group *group = iommu_group_get(dev);
> +
> +		if (!group ||
> +		    owner->domain != iommu_group_default_domain(group)) {
> +			iommu_group_put(group);
> +			return -EINVAL;
> +		}
> +		iommu_group_put(group);
>  		exynos_iommu_detach_device(owner->domain, dev);
> +	}

Does this fix any actual bug? The iommu core should take care that the
above never happens. See __iommu_attach_group() function for details.



	Joerg
