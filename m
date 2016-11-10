From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 05/07] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
Date: Thu, 10 Nov 2016 12:42:06 +0100
Message-ID: <20161110114206.GC9996@8bytes.org>
References: <20161019233533.10506.16810.sendpatchset@little-apple>
 <20161019233623.10506.49016.sendpatchset@little-apple>
 <941ff264-8f9f-e0e6-2b50-bdd3e19946e5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <941ff264-8f9f-e0e6-2b50-bdd3e19946e5@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 21, 2016 at 06:52:53PM +0100, Robin Murphy wrote:
> > -static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
> > -{
> > -	if (type != IOMMU_DOMAIN_UNMANAGED)
> > -		return NULL;
> 
> I *think* that if we did the initial check thus:
> 
> 	if (type != IOMMU_DOMAIN_UNMANAGED ||
> 	    (IS_ENABLED(CONFIG_IOMMU_DMA) && type != IOMMU_DOMAIN_DMA))
> 		return NULL;
> 
> it shouldn't be necessary to split the function at all - we then just
> wrap the {get,put}_cookie() bits in "if (type ==  IOMMU_DOMAIN_DMA)" and
> in the 32-bit ARM case they just don't run as that can never be true.

This would be a good improvement. Magnus, Robin, can either of you send
a follow-on patch to implement this suggestion? I have applied these
patches to my arm/renesas branch (not pushed yet). The patch can be
based on it.


	Joerg
