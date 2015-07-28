From: Sudeep Dutt <sudeep.dutt@intel.com>
Subject: Re: [PATCH char-misc-next 10/19] lib: convert iova.c into a library
Date: Tue, 28 Jul 2015 10:01:00 -0700
Message-ID: <1438102860.6314.49.camel@localhost>
References: <cover.1438040669.git.ashutosh.dixit@intel.com>
	 <8131ebc8ecb5ef13ef0aa4c49dabe9694f0e410f.1438040669.git.ashutosh.dixit@intel.com>
	 <20150728100340.GR10969@8bytes.org> <55B75C69.30200@arm.com>
	 <1438094293.26913.177.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438094293.26913.177.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Nikhil Rao <nikhil.rao@intel.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Harish Chegondi <harish.chegondi@intel.com>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, "Dutt, Sudeep" <sudeep.dutt@intel.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-07-28 at 15:38 +0100, David Woodhouse wrote:
> On Tue, 2015-07-28 at 11:41 +0100, Robin Murphy wrote:
> > On 28/07/15 11:03, Joerg Roedel wrote:
> > > On Mon, Jul 27, 2015 at 04:57:32PM -0700, Ashutosh Dixit wrote:
> > > > From: Harish Chegondi <harish.chegondi@intel.com>
> > > > 
> > > > This patch converts iova.c into a library, moving it from
> > > > drivers/iommu/ to lib/, and exports its virtual address 
> > > > allocation and
> > > > management functions so that other modules can reuse them.
> > > > 
> > > > Cc: Joerg Roedel <joro@8bytes.org>
> > > > Reviewed-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com
> > > > >
> > > > Reviewed-by: Sudeep Dutt <sudeep.dutt@intel.com>
> > > > Signed-off-by: Harish Chegondi <harish.chegondi@intel.com>
> > > 
> > > Where is this going to be used outside of the IOMMU world?
> > > 

We are using the IOVA generator in the SCIF driver posted @
http://thread.gmane.org/gmane.linux.kernel/2005895 under
drivers/misc/mic/scif

> > 
> > ...and how does it relate to the patches from Sakari (+CC) doing much 
> > the same thing[1]?
> 

The patch series from Sakari does the right thing by moving the IOVA
cache management to the IOVA library. We will simply drop this current
patch as it is incorrect.

> I merged Sakari's patches into the intel-iommu git tree today, FWIW.
> 
> If there's really a need to move it from drivers/iommu/ to lib/ then we
> could feasibly do that too.
> 

The patch series from Sakari should work perfectly for us. We will post
a v2 of the current SCIF patch series without this IOVA patch and modify
the SCIF driver to use the newly added iova_cache_get(..) and
iova_cache_put(..) APIs once it is available in Linus's tree. It would
make it easier for us to integrate if Sakari's patches reach mainline
soon.

It might be cleaner to move IOVA to lib/ in the longer term since we
will have multiple driver subsystems using it, but it should work just
fine for now.

Thanks for the review!

Sudeep Dutt
