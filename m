From: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 05/18] iommu: introduce device fault data
Date: Tue, 9 Apr 2019 13:03:15 +0300
Message-ID: <20190409100315.GD9224@smile.fi.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1554767973-30125-6-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554767973-30125-6-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Liu@smile.fi.intel.com, Yi L <yi.l.liu@linux.intel.com>, Eric Auger <eric.auger@redhat.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 08, 2019 at 04:59:20PM -0700, Jacob Pan wrote:
> Device faults detected by IOMMU can be reported outside the IOMMU
> subsystem for further processing. This patch introduces
> a generic device fault data structure.
> 
> The fault can be either an unrecoverable fault or a page request,
> also referred to as a recoverable fault.
> 
> We only care about non internal faults that are likely to be reported
> to an external subsystem.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

JFYI: we have a Co-developed-by tag as well for better granularity of what
certain person/people did.

-- 
With Best Regards,
Andy Shevchenko
