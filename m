From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Date: Thu, 19 Apr 2018 01:52:02 +0000
Message-ID: <1524102722.10902.1.camel@hxt-semitech.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
         <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
         <1523664612.2747.13.camel@intel.com>
         <efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
         <1524031122.4031.5.camel@hxt-semitech.com>
         <1524036520.2747.31.camel@intel.com>
         <1524040290.4031.25.camel@hxt-semitech.com>
         <1524082659.2747.37.camel@intel.com>
         <151f3396-959b-86f6-e056-58d38682d858@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <151f3396-959b-86f6-e056-58d38682d858@amd.com>
Content-Language: en-US
Content-ID: <156E9AA99371004CA43B33CE2A76ADFD@hxt-semitech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "sohil.mehta@intel.com" <sohil.mehta@intel.com>, "gary.hook@amd.com" <gary.hook@amd.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "ghook@amd.com" <ghook@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi, Gary,

On Wed, 2018-04-18 at 16:51 -0400, Hook, Gary wrote:
> On 4/18/2018 4:16 PM, Mehta, Sohil wrote:
> > 
> > On Wed, 2018-04-18 at 08:31 +0000, Yang, Shunyong wrote:
> > > 
> > > Maybe the original design is to call debugfs_initialized() before
> > > calling debugfs_create_xxx()?
> > I am unaware of the original design. Someone else would probably
> > have
> > more context. However, looking at other places in the kernel where
> > debugfs_create_xx() is used, the common convention seems to be to
> > avoid
> > calling debugfs_initialized().
> > 
> >   Sohil
> > 
> debugfs_initialized() was introduced in commit c0f92ba99 back in 
> 2.6.30-rc1. It was intended as a helper, not as a gatekeeper, which
> is 
> why one doesn't see it used. Given that my use in this proposed patch
> is 
> straightforward, I'm not seeing the need here. I had just seen some 
> other code that used it, and copied the model.
> 
> Unless someone comes along to say, yes, use it, I'll not.
> 

I agree with you and Sohil on removing the unnecessary function
calling.

Thanks.
Shunyong.


> Gary
