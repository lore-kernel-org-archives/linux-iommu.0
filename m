From: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v1 1/1] iommu/vt-d: Enable PRI only if the device enables
 PASID.
Date: Thu, 7 Feb 2019 13:22:54 -0800
Message-ID: <20190207212254.GA1647@otc-nc-03>
References: <142748f6a00153f9926fe2a9dc30cf3cd89164cd.1549408090.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0faf4f6a5bbd8cbee84aa78c40ab15216c2b8f0e.camel@infradead.org>
 <20190207210936.GH103220@otc-nc-03>
 <9393b9b2c15564ee84b627a73fb34bd17ebe4a7f.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9393b9b2c15564ee84b627a73fb34bd17ebe4a7f.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 07, 2019 at 09:15:24PM +0000, David Woodhouse wrote:
> On Thu, 2019-02-07 at 13:09 -0800, Raj, Ashok wrote:
> > You are right.. they are completely orthogonal. We just don't have
> > a way to handle the page-requests for request without PASID's.
> > 
> > There are some of the vIOMMU work to pass the PRI to who owns
> > the device, and we can certainly relax it then. This is just to reflect
> > what support exists today. FWIW, even the native driver maybe be able
> > to resolve this if supported.
> 
> As things stand, if a device makes a PRI request without a PASID, it'll
> get told that we didn't manage to bring the page in for it. Which is
> true.

That's true...it does seem to be covered already.. I can't remember
why I thought this was required :-(.. 

We can drop this patch.
> 
> What's the actual problem being fixed by this patch? Yes, we're going
> to want to hook up a way to pass the PRI to the right place... but why
> add *another* thing that's just going to have to be fixed, by reverting
> this patch?
> 
