From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 07/16] iommu/amd: Add IRTE invalidation routine
Date: Fri, 28 Sep 2012 17:36:29 +0200
Message-ID: <20120928153629.GJ4009@amd.com>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
 <1348835046-3262-8-git-send-email-joerg.roedel@amd.com>
 <20120928142017.GE7483@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120928142017.GE7483@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 28, 2012 at 10:20:18AM -0400, Konrad Rzeszutek Wilk wrote:
> On Fri, Sep 28, 2012 at 02:23:57PM +0200, Joerg Roedel wrote:
> > +static void iommu_flush_irt_all(struct amd_iommu *iommu)
> > +{
> > +	u32 devid;
> > +
> > +	for (devid = 0; devid <= 0xffff; ++devid)
> 
> Should this be #define? Or perhaps based of sizeof?

I'll add a define for that. The 0xffff is a hardware constant, so sizeof
will not work.

> Is there a specific reason that it is u16 in the build_inv_irt but
> here it is u32?

Yes, with u16 the loop-counter will overflow and make it to an endless
loop.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
