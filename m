From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 09/18] iommu/vt-d: Enlightened PASID allocation
Date: Tue, 9 Apr 2019 09:34:13 -0700
Message-ID: <20190409093413.603b5333@jacob-builder>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1554767973-30125-10-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190409100859.GF9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409100859.GF9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 9 Apr 2019 13:08:59 +0300
Andriy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Apr 08, 2019 at 04:59:24PM -0700, Jacob Pan wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the
> > IOMMU driver should rely on the emulation software to allocate
> > and free PASID IDs. The Intel vt-d spec revision 3.0 defines a
> > register set to support this. This includes a capability register,
> > a virtual command register and a virtual response register. Refer
> > to section 10.4.42, 10.4.43, 10.4.44 for more information.
> > 
> > This patch adds the enlightened PASID allocation/free interfaces
> > via the virtual command register.  
> 
> > +	pr_debug("vcmd alloc pasid\n");  
> 
> Perhaps tracepoints should be in use?
> OTOH we have function tracer, so, this message in any case is a noise.
> And this is applicable to other similar cases.
> 

Agreed, I added that for debug purpose.

Thanks,

Jacob
