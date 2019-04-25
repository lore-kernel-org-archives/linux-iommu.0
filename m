From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
Date: Thu, 25 Apr 2019 11:19:12 -0700
Message-ID: <20190425111912.0e15eb7d@jacob-builder>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190424061903.GB30717@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424061903.GB30717@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Tue, 23 Apr 2019 23:19:03 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Apr 23, 2019 at 04:31:06PM -0700, Jacob Pan wrote:
> > The allocator doesn't really belong in drivers/iommu because some
> > drivers would like to allocate PASIDs for devices that aren't
> > managed by an IOMMU, using the same ID space as IOMMU. It doesn't
> > really belong in drivers/pci either since platform device also
> > support PASID. Add the allocator in drivers/base.  
> 
> I'd still add it to drivers/iommu, just selectable separately from the
> core iommu code..
Perhaps I misunderstood. If a driver wants to use IOASIDs w/o iommu
subsystem even turned on, how could selecting from the core iommu code
help? Could you elaborate on "selectable"?

>From VT-d's perspective, PASIDs are only used with IOMMU on. Jean
knows other use cases.

Jacob
