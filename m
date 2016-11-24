From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/5] iommu/exynos: Add default_domain check in
	iommu_attach_device
Date: Thu, 24 Nov 2016 12:25:22 +0000
Message-ID: <6937b5da-23cf-d9bb-0b7c-d54171b02828@arm.com>
References: <1479986420-30859-1-git-send-email-m.szyprowski@samsung.com>
	<1479986420-30859-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

On 24/11/16 11:20, Marek Szyprowski wrote:
> This patch adds default_domain check before calling
> exynos_iommu_detach_device. This path was intended only to cope with
> default domains, which are automatically attached by the iommu core, so
> return error if user tries to attach device, which is already attached
> to other (non-default) domain.

I think this only applies to the current state of 32-bit ARM, where the
initial allocation of a default domain fails without CONFIG_IOMMU_DMA.
Since the device has a group, iommu_attach_device() will end up calling
into __iommu_attach_group(), which does this check before calling the
driver's .attach_dev:

	if (group->default_domain && group->domain != group->default_domain)
		return -EBUSY;

which if group->default_domain is non-NULL would make the new check
below redundant unless owner->domain can change independently of
dev->iommu_group->domain, but that sounds like it would be a bigger
problem anyway.

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

Similarly, I think this prevents reattaching to a default domain from
iommu_detach_device(), since __iommu_detach_group() won't call
.detach_dev first if default_domain is non-NULL, therefore owner->domain
is presumably still pointing to the outgoing non-default domain.

Robin.

> +			iommu_group_put(group);
> +			return -EINVAL;
> +		}
> +		iommu_group_put(group);
>  		exynos_iommu_detach_device(owner->domain, dev);
> +	}
>  
>  	mutex_lock(&owner->rpm_lock);
>  
> 
