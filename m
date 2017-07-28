From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v8 01/13] iommu/amd: Detect pre enabled translation
Date: Fri, 28 Jul 2017 10:31:00 +0800
Message-ID: <20170728023100.GF24304@x1>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
 <1500627551-12930-2-git-send-email-bhe@redhat.com>
 <20170727150445.GJ3610@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170727150445.GJ3610@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 07/27/17 at 05:04pm, Joerg Roedel wrote:
> On Fri, Jul 21, 2017 at 04:58:59PM +0800, Baoquan He wrote:
> > diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> > index 294a409e283b..d15966b62b33 100644
> > --- a/drivers/iommu/amd_iommu_types.h
> > +++ b/drivers/iommu/amd_iommu_types.h
> > @@ -417,6 +417,7 @@ extern struct kmem_cache *amd_iommu_irq_cache;
> >  #define APERTURE_PAGE_INDEX(a)	(((a) >> 21) & 0x3fULL)
> >  
> >  
> > +
> 
> Forgot to remove that from the diff?

Many thanks for your reviewing and great suggestions, Joerg!

Will withdraw this change in this patch.

> 
> >  /*
> >   * This struct is used to pass information about
> >   * incoming PPR faults around.
> > @@ -435,6 +436,8 @@ struct iommu_domain;
> >  struct irq_domain;
> >  struct amd_irte_ops;
> >  
> > +#define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
> > +
> >  /*
> >   * This structure contains generic data for  IOMMU protection domains
> >   * independent of their use.
