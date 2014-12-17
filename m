From: Jerry Hoemann <jerry.hoemann@hp.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix dmar_domain leak in
 iommu_attach_device
Date: Wed, 17 Dec 2014 14:37:47 -0700
Message-ID: <20141217213747.GA11569@anatevka.fc.hp.com>
References: <1418813017-24888-1-git-send-email-joro@8bytes.org>
Reply-To: Jerry.Hoemann@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418813017-24888-1-git-send-email-joro@8bytes.org>
Sender: stable-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org, Myron Stowe <mstowe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 17, 2014 at 11:43:36AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Since commit 1196c2f a domain is only destroyed in the
> notifier path if it is hot-unplugged. This caused a
> domain leakage in iommu_attach_device when a driver was
> unbound from the device and bound to VFIO. In this case the
> device is attached to a new domain and unlinked from the old
> domain. At this point nothing points to the old domain
> anymore and its memory is leaked.
> Fix this by explicitly freeing the old domain in
> iommu_attach_domain.
> 
> Fixes: 1196c2f (iommu/vt-d: Fix dmar_domain leak in iommu_attach_device)
> Cc: <stable@vger.kernel.org> # v3.18
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/intel-iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 1232336..7610121 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4428,6 +4428,10 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>  				domain_remove_one_dev_info(old_domain, dev);
>  			else
>  				domain_remove_dev_info(old_domain);
> +
> +			if (!domain_type_is_vm_or_si(old_domain) &&
> +			     list_empty(&old_domain->devices))
> +				domain_exit(old_domain);
>  		}
>  	}
>  
> -- 
> 1.9.1

Joerg,

Before applying this change on a 3.18-rc7 kernel layered on a
RHEL 7.0 root disk, I was able to reproduce the memory
leak that Alex reported when powering on/off a VM w/ a PCI
device assigned to it.

After applying this change, I don't see the memory leak anymore.
Instrumentation shows the new code is being invoked during power on
of the VM.

Looks good.

Thanks!

Tested-by: Jerry Hoemann <jerry.hoemann@hp.com>
-- 

----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer              Hewlett-Packard

3404 E Harmony Rd. MS 36                        phone:  (970) 898-1022
Ft. Collins, CO 80528                           FAX:    (970) 898-0707
                                                email:  jerry.hoemann@hp.com
----------------------------------------------------------------------------
