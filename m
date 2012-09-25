From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: linux-next: Tree for Sept 24 (iommu)
Date: Tue, 25 Sep 2012 12:16:28 +0200
Message-ID: <20120925101628.GX2505@amd.com>
References: <20120925005328.f748dfa3d077cebb345a4291@canb.auug.org.au>
 <5060D876.5030209@xenotime.net>
 <1348543405.2320.146.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1348543405.2320.146.camel@ul30vt.home>
Sender: linux-next-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, iommu@lists.linux-foundation.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 24, 2012 at 09:23:25PM -0600, Alex Williamson wrote:
> On Mon, 2012-09-24 at 15:02 -0700, Randy Dunlap wrote:
> > On 09/24/2012 07:53 AM, Stephen Rothwell wrote:
> > 
> > > Hi all,
> > > 
> > > Today was a train wreck, with lots of new conflicts across several trees
> > > and a few build failures as well.
> > > 
> > > Changes since 201209021:
> > > 
> > 
> > 
> > 
> > on i386:
> > 
> > drivers/built-in.o: In function `iommu_group_remove_device':
> > (.text+0x74cb10): multiple definition of `iommu_group_remove_device'
> > arch/x86/built-in.o:(.text+0x140d0): first defined here
> ...
> 
> 
> Here's a patch to get it past this.  It still doesn't fully build, but
> the rest isn't iommu related.  Thanks,

Applied, thanks.

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
