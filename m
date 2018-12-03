From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
 support
Date: Mon, 3 Dec 2018 14:48:56 +0100
Message-ID: <20181203134856.lui4us4ejm4d5avz@8bytes.org>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-5-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128035449.10226-5-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 28, 2018 at 11:54:41AM +0800, Lu Baolu wrote:
> -
> -	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO, 0);
> +	/*
> +	 * Need two pages to accommodate 256 descriptors of 256 bits each
> +	 * if the remapping hardware supports scalable mode translation.
> +	 */
> +	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
> +				     !!ecap_smts(iommu->ecap));


Same here, does the allocation really need GFP_ATOMIC?

>  struct q_inval {
>  	raw_spinlock_t  q_lock;
> -	struct qi_desc  *desc;          /* invalidation queue */
> +	void		*desc;          /* invalidation queue */
>  	int             *desc_status;   /* desc status */
>  	int             free_head;      /* first free entry */
>  	int             free_tail;      /* last free entry */

Why do you switch the pointer to void* ?


	Joerg
