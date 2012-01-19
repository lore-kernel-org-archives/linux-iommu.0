From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Thu, 19 Jan 2012 17:16:48 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D038749__20447.8587992073$1327042522$gmane$org@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1326983405-319-1-git-send-email-joerg.roedel@amd.com>
	<1326983405-319-3-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1326983405-319-3-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Hiroshi DOYU <Hiroshi.DOYU-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Joerg Roedel
> Sent: Thursday, January 19, 2012 8:00 PM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Cc: Ohad Ben-Cohen; Tony Lindgren; Hiroshi DOYU; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Laurent Pinchart; Wood Scott-B07421; David Brown;
> David Woodhouse
> Subject: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
> 
> Implement the attribute itself and add the code for the AMD IOMMU driver.
> 
> Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c |    4 ++++
>  drivers/iommu/iommu.c     |   19 ++++++++++++++++---
>  include/linux/iommu.h     |   11 ++++++++++-
>  3 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c index
> cce1f03..421c3e6 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3030,6 +3030,10 @@ static int amd_iommu_domain_init(struct
> iommu_domain *dom)
> 
>  	dom->priv = domain;
> 
> +	dom->geometry.aperture_start = 0;
> +	dom->geometry.aperture_end   = ~0ULL;
> +	dom->geometry.force_aperture = true;
> +
>  	return 0;
> 
>  out_free:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c index
> ef54718..3d0b0bf 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -345,10 +345,23 @@ EXPORT_SYMBOL_GPL(iommu_device_group);
>  int iommu_domain_get_attr(struct iommu_domain *domain,
>  			  enum iommu_attr attr, void *data)
>  {
> -	if (!domain->ops->domain_get_attr)
> -		return -EINVAL;
> +	struct iommu_domain_geometry *geometry;
> +	int ret = 0;
> +
> +	switch (attr) {
> +	case DOMAIN_ATTR_GEOMETRY:
> +		geometry  = data;
> +		*geometry = domain->geometry;
> +
> +		break;
> +	default:
> +		if (!domain->ops->domain_get_attr)
> +			return -EINVAL;
> 
> -	return domain->ops->domain_get_attr(domain, attr, data);
> +		ret = domain->ops->domain_get_attr(domain, attr, data);
> +	}
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_get_attr);
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> 32d0de1..3f971b3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -37,16 +37,24 @@ struct iommu_domain;  typedef int
> (*iommu_fault_handler_t)(struct iommu_domain *,
>  				struct device *, unsigned long, int);
> 
> +struct iommu_domain_geometry {
> +	u64 aperture_start;	/* First address that can be mapped    */
> +	u64 aperture_end;	/* Last address that can be mapped     */
> +	bool force_aperture;	/* DMA only allowed in mappable range? */
> +};
> +
>  struct iommu_domain {
>  	struct iommu_ops *ops;
>  	void *priv;
>  	iommu_fault_handler_t handler;
> +	struct iommu_domain_geometry geometry;
>  };
In case of our iommu implementation the iommu_domain_geometry would include additional attributes. Why can't we let the geometry be
Implementation dependent?

-Varun
