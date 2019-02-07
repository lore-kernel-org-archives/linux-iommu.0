From: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v1 1/1] iommu/vt-d: Enable PRI only if the device enables
 PASID.
Date: Thu, 7 Feb 2019 13:09:36 -0800
Message-ID: <20190207210936.GH103220@otc-nc-03>
References: <142748f6a00153f9926fe2a9dc30cf3cd89164cd.1549408090.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0faf4f6a5bbd8cbee84aa78c40ab15216c2b8f0e.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0faf4f6a5bbd8cbee84aa78c40ab15216c2b8f0e.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 07, 2019 at 08:08:06PM +0000, David Woodhouse wrote:
> On Thu, 2019-02-07 at 10:44 -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > Intel IOMMU Page Request Services (PRS) only works with devices which
> > supports/uses PASID. So enable PRI only if the device also enables
> > PASID support. For more details, Please check the implementation of PRQ
> > handler(prq_event_thread()) in intel-svm driver.
> > 
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Hm, that shouldn't be true. PRI and PASID support are orthogonal.
> 
> If we get a PRI request without PASID, we should currently report it as
> non-serviced which is the right thing to do. We can hook this up to KVM
> etc. to actually allow paging of guests with devices attached, *if* the
> devices attached to those guests support PRI.
> 
> Nothing fundamentally stops us using PRI without PASID support.

You are right.. they are completely orthogonal. We just don't have
a way to handle the page-requests for request without PASID's.

There are some of the vIOMMU work to pass the PRI to who owns
the device, and we can certainly relax it then. This is just to reflect
what support exists today. FWIW, even the native driver maybe be able
to resolve this if supported.

> 
> 
