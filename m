From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/15] iommu: Introduce iommu domain types
Date: Fri, 30 Jan 2015 13:22:34 +0100
Message-ID: <20150130122233.GA3702@8bytes.org>
References: <1422316305-19216-1-git-send-email-joro@8bytes.org>
	<1422316305-19216-3-git-send-email-joro@8bytes.org>
	<20150128141934.GP1569@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150128141934.GP1569-5wv7dgnIgG8@public.gmane.org>
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
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Wed, Jan 28, 2015 at 02:19:34PM +0000, Will Deacon wrote:
> > +/* This are the possible domain-types */
> > +enum iommu_domain_type {
> > +	IOMMU_DOMAIN_DMA,	/* Domain used for DMA-API */
> > +	IOMMU_DOMAIN_IDENTITY,	/* Identity mapped domain  */
> 
> What happens if somebody calls map or unmap on an identity-mapping domain?
> Can we catch that in the IOMMU core before calling the IOMMU driver? That
> also implies we need something extra to parameterise the attributes for
> the mapping (e.g. cacheable, read-only) and also potentially the address
> range.

The domain type is only used by the IOMMU drivers to do be able to enter
special allocation paths (the AMD-Vi driver for example could allocate a
special internal domain type for IOMMU_DOMAIN_DMA).
But I think you are right, a couple of the current domain attributes we
have could be moved here, turning the domain-type into a bit-field. So
we could have bits for PAGING, CACHABLE, DMA_API and NESTING and build
the domain types above from those bits.

> > +	IOMMU_DOMAIN_UNMANAGED, /* Domain mappings are managed by a third party
> > +				   user (like KVM or VFIO) */
> 
> We already have the domain attributes (iommu_attr) to describe features
> of a domain. Is there really a need for this extra type, or can we extend
> the attribute set and allow for domain allocation with attributes?

I don't think that domains attributed will become obsolete with this
domain-type field. Some of the attributes should stay there for now,
like all the PAMU specific stuff. But I agree, some could be moved over.

	
	Joerg
