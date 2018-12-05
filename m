From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
 support
Date: Wed, 5 Dec 2018 16:56:46 +0100
Message-ID: <20181205155646.GD16835@8bytes.org>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-5-baolu.lu@linux.intel.com>
 <20181203134856.lui4us4ejm4d5avz@8bytes.org>
 <A2975661238FB949B60364EF0F2C257439D838AB@SHSMSX104.ccr.corp.intel.com>
 <3b0eadd2-b99f-98d6-594f-0419f0542789@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3b0eadd2-b99f-98d6-594f-0419f0542789@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, David Woodhouse <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 04, 2018 at 02:13:31PM +0800, Lu Baolu wrote:
> The existing code uses GFP_ATOMIC, this patch only changes the size of
> the allocated desc_page.
> 
> I don't think we really need GFP_ATOMIC here (and also for some other
> places). I will clean up them in a separated patch.

Okay, thanks.

> > In this patch, there is some code like the code below. It calculates
> > destination address of memcpy with qi->desc. If it's still struct qi_desc
> > pointer, the calculation result would be wrong.
> > 
> > +			memcpy(desc, qi->desc + (wait_index << shift),
> > +			       1 << shift);
> > 
> > The change of the calculation method is to support 128 bits invalidation
> > descriptors and 256 invalidation descriptors in this unified code logic.
> > 
> > Also, the conversation between Baolu and me may help.
> > 
> > https://lore.kernel.org/patchwork/patch/1006756/
> 
> Yes. We need to support different descriptor size.

Okay, pointer arithmetic on void* isn't well defined in the C standard,
afaik. But it should work with GCC, so it's probably fine.

Unrelated to this patch-set, the whole qi management code needs some
cleanups, it queues a sync after every command and has very tricky
locking. This patch-set further complicates matters there, so it is
probably time for a clean re-write of that part?

Regards,

	Joerg
