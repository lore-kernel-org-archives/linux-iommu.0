From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFT] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Wed, 16 Mar 2016 17:57:47 +0100
Message-ID: <20160316165747.GN1990@wotan.suse.de>
References: <1458079926-18716-1-git-send-email-mcgrof@kernel.org>
 <CAFCwf13RT9VyzhJ4AhAGd1ndd8f=Cd0TRnnRcDwBGHbOzyc5BQ@mail.gmail.com>
 <20160316101457.GC2195@8bytes.org>
 <CAFCwf13LM+snV1Hi+hE4yHHRKRTzoySNHNesM+2vxAKFYzvqVg@mail.gmail.com>
 <20160316161736.GL1990@wotan.suse.de>
 <20160316163900.GD2195@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160316163900.GD2195@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Oded Gabbay <oded.gabbay@gmail.com>, iommu@lists.linux-foundation.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 16, 2016 at 05:39:00PM +0100, Joerg Roedel wrote:
> On Wed, Mar 16, 2016 at 05:17:37PM +0100, Luis R. Rodriguez wrote:
> > On Wed, Mar 16, 2016 at 12:16:57PM +0200, Oded Gabbay wrote:
> > > In theory it should, but I would prefer that it would be tested on
> > > actual hardware.
> > 
> > Hence, RFT. Anyone have hardware to test ? And would the other hack
> > mentioned need to be reverted first ?
> 
> Yes, the other hack needs to be reverted first to see if this one helps.

I'm afraid I am not sure where that hack is, can someone construct a patch to
revert that so this is a proper RFT series ?

  Luis
