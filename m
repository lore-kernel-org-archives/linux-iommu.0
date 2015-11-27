From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 RESEND 2/3] iommu/hisilicon: Add hi6220-SoC smmu driver
Date: Fri, 27 Nov 2015 13:02:03 +0100
Message-ID: <20151127120203.GI24300@8bytes.org>
References: <1447986309-47548-1-git-send-email-puck.chen@hisilicon.com>
 <1447986309-47548-3-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447986309-47548-3-git-send-email-puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, puck.chen-Dw/NWeUnuQfQT0dZR+AlfA@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 20, 2015 at 10:25:08AM +0800, Chen Feng wrote:
> +config HI6220_IOMMU
> +	bool "Hi6220 IOMMU Support"
> +	depends on ARM64
> +	select IOMMU_API
> +	select IOMMU_IOVA
> +	help
> +	  Enable IOMMU Driver for hi6220 SoC. The IOMMU API and IOMMU IOVA
> +	  is also selected.

The last sentence is of little help for the user. Better put the reasons
in here when a user should select this option.

> +	/*set axi id*/

Coding style nit: Please write these oneline comments with spaces, like
this:

	/* set axi id */

> +static int hi6220_smmu_attach_dev(struct iommu_domain *domain,
> +				  struct device *dev)
> +{
> +	dev->archdata.iommu = &iova_allocator;
> +
> +	return 0;
> +}
> +
> +static void hi6220_smmu_detach_dev(struct iommu_domain *domain,
> +				   struct device *dev)
> +{
> +	dev->archdata.iommu = NULL;
> +}

This basically means that this driver only supports one domain, right?
That is not compatible with the iommu-api requirements.

You need to create an iommu-group per smmu in your system and put all
devices translated by this smmu in that group. And then you must change
your code to allow attaching/detaching this iommu-group to different
domains.


	Joerg

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
