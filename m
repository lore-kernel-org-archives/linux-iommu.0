From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
Date: Mon, 3 Dec 2012 11:36:12 -0600
Message-ID: <1354556172.2960.12@snotra>
References: <1353419697-31269-1-git-send-email-Varun.Sethi@freescale.com>
	<1353419697-31269-4-git-send-email-Varun.Sethi@freescale.com>
	<20121202140323.GO30633@8bytes.org>
	<C5ECD7A89D1DC44195F34B25E172658D2B2A51@039-SN2MPN1-013.039d.mgd.msft.net>
	<20121203172712.GA18368@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121203172712.GA18368@8bytes.org> (from joro@8bytes.org on
	Mon Dec  3 11:27:12 2012)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Sethi Varun-B16395 <B16395@freescale.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Wood Scott-B07421 <B07421@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Tabi Timur-B04825 <B04825@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On 12/03/2012 11:27:12 AM, Joerg Roedel wrote:
> On Mon, Dec 03, 2012 at 04:57:29PM +0000, Sethi Varun-B16395 wrote:
> >
> >
> > > -----Original Message-----
> > > From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> > > bounces@lists.linux-foundation.org] On Behalf Of Joerg Roedel
> > > Sent: Sunday, December 02, 2012 7:33 PM
> > > To: Sethi Varun-B16395
> > > Cc: linux-kernel@vger.kernel.org;  
> iommu@lists.linux-foundation.org; Wood
> > > Scott-B07421; linuxppc-dev@lists.ozlabs.org; Tabi Timur-B04825
> > > Subject: Re: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes
> > > required by fsl PAMU driver.
> > >
> > > Hmm, we need to work out a good abstraction for this.
> > >
> > > On Tue, Nov 20, 2012 at 07:24:56PM +0530, Varun Sethi wrote:
> > > > Added the following domain attributes required by FSL PAMU  
> driver:
> > > > 1. Subwindows field added to the iommu domain geometry  
> attribute.
> > >
> > > Are the Subwindows mapped with full size or do you map only parts  
> of the
> > > subwindows?
> > >
> > [Sethi Varun-B16395] It's possible to map a part of the subwindow  
> i.e.
> > size of the mapping can be less than the sub window size.
> 
> Yes, I know that this is possible. But do you plan to support that or  
> is
> it sufficient when the whole subwindow is mapped?

We do plan to support that.

-Scott
