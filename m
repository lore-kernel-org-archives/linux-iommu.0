From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 03/16] iommu: introduce iommu invalidate API function
Date: Wed, 11 Oct 2017 11:51:26 +0200
Message-ID: <20171011095126.GD30803@8bytes.org>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1507244624-39189-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20171010133542.juag7cwbivlb56sl@8bytes.org>
 <20171010150953.4095a045@jacob-builder>
 <A2975661238FB949B60364EF0F2C257439AF5F37@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439AF5F37@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, "Liu@8bytes.org" <Liu@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 11, 2017 at 07:54:32AM +0000, Liu, Yi L wrote:
> I agree that iommu_invalidate() is too generic. Additionally, also
> better to avoid making it svm specific.

I also don't like to name the functions after the Intel feature, but I
failed to come up with a better alternative so far. The only one I can
come up with for now would be 'iovm', so the function name would be
iommu_iovm_invalidate().

On the other side, the ARM guys also already call the feature set
'SVM', despite it being ambiguous and Intel specific. I don't have a
strong opinion on the naming.

> The reason we introduce this API is in vSVM case is that guest owns
> the first level page table(vtd). If we use similar mechanism for
> vIOVA, then we also need to passdown guest's vIOVA tlb flush.
> 
> Since it is to expose an API for iommu tlb flushes requests from
> userspace/guest which is out of iommu. How about naming it as
> iommu_tlb_external_invalidate()?

If you only read the function name, 'external' could mean everything. It
is not clear from the name when to use this function. So something like
iommu_iovm_invalidate() is better.


	Joerg
