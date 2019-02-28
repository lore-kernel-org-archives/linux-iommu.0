From: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH 1/1] iommu: Bind process address spaces to devices
Date: Thu, 28 Feb 2019 14:04:49 -0800
Message-ID: <20190228220449.GA12682@araj-mobl1.jf.intel.com>
References: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
 <20190220142759.33308-2-jean-philippe.brucker@arm.com>
 <20190226111743.GK20740@8bytes.org>
 <20190227134129.51ad42ac@jacob-builder>
 <20190228140950.GD1594@8bytes.org>
 <20190228131549.6c0e5fad@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190228131549.6c0e5fad@jacob-builder>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, christian.koenig@amd.com, kevin.tian@intel.com, baolu.lu@linux.intel.com, alex.williamson@redhat.com, Ashok Raj <ashok.raj@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 28, 2019 at 01:15:49PM -0800, Jacob Pan wrote:
> On Thu, 28 Feb 2019 15:09:50 +0100
> Joerg Roedel <joro@8bytes.org> wrote:
> 
> > Hi Jacob,
> > 
> > On Wed, Feb 27, 2019 at 01:41:29PM -0800, Jacob Pan wrote:
> > > On Tue, 26 Feb 2019 12:17:43 +0100
> > > Joerg Roedel <joro@8bytes.org> wrote:  
> > 
> > > Just trying to understand how to use this API.
> > > So if we bind the same mm to two different devices, we should get
> > > two different iommu_sva handle, right?
> > > I think intel-svm still needs a flag argument for supervisor pasid
> > > etc. Other than that, I think both interface should work for vt-d.  
> > 
> > I second Jean's question here, is supervisor pasid still needed with
> > scalable mode? What is the use-case and which mm_struct will be used
> > for supervisor accesses?
> > 
> I will delegate this to Ashok.

Supervisor PASID is still required for some kernel clients. Some of our
IB folks had asked for it. Current implementation uses init_mm, but
we know this is dangerous. Plus since the kernel has no support for
mmu_notifiers for kernel memory we were not able to invalidate
device tlb after memory was freed.

Suppose we could just build regular page-tables much like how the map/unmap
does today, but bind it with a Supervisor PASID. This way we don't open
up the kimono to the device, but only open select portions on request.

we haven't spent enough time on it lately, but will focus once the core
pieces are completed for the baseline support for Scalable mode.
