From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/5] Introduce device_iommu_maped() function
Date: Thu, 6 Dec 2018 16:36:45 +0100
Message-ID: <20181206153644.GH16835@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
 <e34dcbe8-2f1b-31bb-2093-542361635cf5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e34dcbe8-2f1b-31bb-2093-542361635cf5@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 05, 2018 at 05:17:29PM +0000, Robin Murphy wrote:
> On 04/12/2018 17:24, Joerg Roedel wrote:

> Nice, we can also clean up a whole load of vague iommu_present() usage and
> even one or two odd iommu_get_domain_for_dev() calls once we have this.

Right, I didn't think of that yet, but it's certainly true.

> There looks to be one more here:
> 
> drivers/dma/sh/rcar-dmac.c: rcar_dmac_probe()

True, I added a patch for that too.

> Other than that and a minor comment on the OF/IORT part, though, for the
> whole series:
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks, I added you Acked-by to the 5 patches I posted here.


Regards,

	Joerg
