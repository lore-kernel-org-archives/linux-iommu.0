From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
Date: Tue, 23 Apr 2019 23:19:03 -0700
Message-ID: <20190424061903.GB30717@infradead.org>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 23, 2019 at 04:31:06PM -0700, Jacob Pan wrote:
> The allocator doesn't really belong in drivers/iommu because some
> drivers would like to allocate PASIDs for devices that aren't managed by
> an IOMMU, using the same ID space as IOMMU. It doesn't really belong in
> drivers/pci either since platform device also support PASID. Add the
> allocator in drivers/base.

I'd still add it to drivers/iommu, just selectable separately from the
core iommu code..
