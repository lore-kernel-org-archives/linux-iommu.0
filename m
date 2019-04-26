From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
Date: Fri, 26 Apr 2019 09:58:46 -0700
Message-ID: <20190426095846.76a68f1f@jacob-builder>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190424061903.GB30717@infradead.org>
        <20190425111912.0e15eb7d@jacob-builder>
        <856b0457-bd2f-c2af-fdeb-45fe0bd3136b@arm.com>
        <20190426122115.GA29449@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426122115.GA29449@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, "christian.koenig@amd.com" <christian.koenig@amd.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Fri, 26 Apr 2019 05:21:15 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Apr 26, 2019 at 12:47:43PM +0100, Jean-Philippe Brucker wrote:
> > >> On Tue, Apr 23, 2019 at 04:31:06PM -0700, Jacob Pan wrote:  
> > >>> The allocator doesn't really belong in drivers/iommu because
> > >>> some drivers would like to allocate PASIDs for devices that
> > >>> aren't managed by an IOMMU, using the same ID space as IOMMU.
> > >>> It doesn't really belong in drivers/pci either since platform
> > >>> device also support PASID. Add the allocator in
> > >>> drivers/base.    
> > >>
> > >> I'd still add it to drivers/iommu, just selectable separately
> > >> from the core iommu code..  
> > > Perhaps I misunderstood. If a driver wants to use IOASIDs w/o
> > > iommu subsystem even turned on, how could selecting from the core
> > > iommu code help? Could you elaborate on "selectable"?  
> > 
> > How about doing the same as CONFIG_IOMMU_IOVA? The code is in
> > drivers/iommu but can be selected by non-IOMMU_API users,
> > independently of CONFIG_IOMMU_SUPPORT. It's true that this
> > allocator will mostly be used by IOMMU drivers.  
> 
> That is exactly what I meant!

Make sense, will do that in the next round. Thanks!
