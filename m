From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation
 descriptor support
Date: Mon, 3 Dec 2018 17:23:35 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D838AB@SHSMSX104.ccr.corp.intel.com>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-5-baolu.lu@linux.intel.com>
 <20181203134856.lui4us4ejm4d5avz@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203134856.lui4us4ejm4d5avz@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Monday, December 3, 2018 5:49 AM
> To: Lu Baolu <baolu.lu@linux.intel.com>
> Subject: Re: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
> support
> 
> On Wed, Nov 28, 2018 at 11:54:41AM +0800, Lu Baolu wrote:
> > -
> > -	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
> 0);
> > +	/*
> > +	 * Need two pages to accommodate 256 descriptors of 256 bits each
> > +	 * if the remapping hardware supports scalable mode translation.
> > +	 */
> > +	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
> > +				     !!ecap_smts(iommu->ecap));
> 
> 
> Same here, does the allocation really need GFP_ATOMIC?

still leave to Baolu.

> 
> >  struct q_inval {
> >  	raw_spinlock_t  q_lock;
> > -	struct qi_desc  *desc;          /* invalidation queue */
> > +	void		*desc;          /* invalidation queue */
> >  	int             *desc_status;   /* desc status */
> >  	int             free_head;      /* first free entry */
> >  	int             free_tail;      /* last free entry */
> 
> Why do you switch the pointer to void* ?

In this patch, there is some code like the code below. It calculates
destination address of memcpy with qi->desc. If it's still struct qi_desc
pointer, the calculation result would be wrong.

+			memcpy(desc, qi->desc + (wait_index << shift),
+			       1 << shift);

The change of the calculation method is to support 128 bits invalidation
descriptors and 256 invalidation descriptors in this unified code logic.

Also, the conversation between Baolu and me may help.

https://lore.kernel.org/patchwork/patch/1006756/

> 
> 	Joerg

Thanks,
Yi Liu
