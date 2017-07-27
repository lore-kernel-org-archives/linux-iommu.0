From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v8 01/13] iommu/amd: Detect pre enabled translation
Date: Thu, 27 Jul 2017 17:04:45 +0200
Message-ID: <20170727150445.GJ3610@suse.de>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
 <1500627551-12930-2-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500627551-12930-2-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 21, 2017 at 04:58:59PM +0800, Baoquan He wrote:
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index 294a409e283b..d15966b62b33 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -417,6 +417,7 @@ extern struct kmem_cache *amd_iommu_irq_cache;
>  #define APERTURE_PAGE_INDEX(a)	(((a) >> 21) & 0x3fULL)
>  
>  
> +

Forgot to remove that from the diff?

>  /*
>   * This struct is used to pass information about
>   * incoming PPR faults around.
> @@ -435,6 +436,8 @@ struct iommu_domain;
>  struct irq_domain;
>  struct amd_irte_ops;
>  
> +#define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
> +
>  /*
>   * This structure contains generic data for  IOMMU protection domains
>   * independent of their use.
