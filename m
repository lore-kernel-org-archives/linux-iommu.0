From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/5] amd_iommu: Refactor IOMMU group and support
	virtual aliases
Date: Tue, 09 Oct 2012 13:33:30 -0600
Message-ID: <1349811210.2759.300.camel@ul30vt.home>
References: <20121009044057.16302.44577.stgit@bling.home>
	<20121009202738.7e047e64@brain.lan>
	<1349807739.2759.292.camel@ul30vt.home>
	<20121009205758.45c9fcc0@brain.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121009205758.45c9fcc0-mGxavARqDwv/PtFMR13I2A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Florian Dazinger <florian-Q0TRQrZM+Zzk1uMJSBkQmQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2012-10-09 at 20:57 +0200, Florian Dazinger wrote:
> Am Tue, 09 Oct 2012 12:35:39 -0600
> schrieb Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> 
> > On Tue, 2012-10-09 at 20:27 +0200, Florian Dazinger wrote:
> > > Am Mon, 08 Oct 2012 22:49:28 -0600
> > > schrieb Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> > > 
> > > > This series is meant to refactor IOMMU group support in amd_iommu
> > > > to properly support virtual aliases.  If multiple devices alias to
> > > > the same virtual alias, they should be grouped together.  This code
> > > > also verifies whether the alias should be the root of the group vs
> > > > devices above the alias.
> > > > 
> > > > This seems to do the right thing on my system, but that's not saying
> > > > a lot since it doesn't do anything interesting with aliases.  I'd
> > > > appreciate if Joerg and Florian could test this on their systems.
> > > > Thanks,
> > > > 
> > > > Alex
> > > > 
> > > > ---
> > > > 
> > > > Alex Williamson (5):
> > > >       amd_iommu: Properly account for virtual aliases in IOMMU groups
> > > >       amd_iommu: Split IOMMU group allocation and attach
> > > >       amd_iommu: Split upstream bus device lookup
> > > >       amd_iommu: Split IOMMU Group topology walk
> > > >       amd_iommu: Split IOMMU group initialization
> > > > 
> > > > 
> > > >  drivers/iommu/amd_iommu.c       |  184 ++++++++++++++++++++++++++++++---------
> > > >  drivers/iommu/amd_iommu_types.h |    1 
> > > >  2 files changed, 142 insertions(+), 43 deletions(-)
> > > > 
> > > 
> > > patch #5 does not apply cleanly on top of 3.6, I had to edit
> > > amd_iommu_types.h manually (easy enough), apart from that, it is
> > > working fine!
> > 
> > Thanks Florian.  Would you mind also reporting
> > 'find /sys/kernel/iommu_groups' for both stock 3.6 and with this series
> > applied?  I think we want to find that devices 07:00.0 and 08:04.0 are
> > grouped together and I'd like to verify whether that actually works.
> > Thanks,
> > 
> > Alex
> 
> shure... there does not seem to be much difference?
> 
> with stock 3.6:
> /sys/kernel/iommu_groups/19                                                                                                                                                                                                                
> /sys/kernel/iommu_groups/19/devices                                                                                                                                                                                                        
> /sys/kernel/iommu_groups/19/devices/0000:07:00.0                                                                                                                                                                                           
> /sys/kernel/iommu_groups/20                                                                                                                                                                                                                
> /sys/kernel/iommu_groups/20/devices                                                                                                                                                                                                        
> /sys/kernel/iommu_groups/20/devices/0000:08:04.0 
> 
> 
> 3.6 + your patch-series:
> 3.6 with your patch-series:
> /sys/kernel/iommu_groups/19
> /sys/kernel/iommu_groups/19/devices
> /sys/kernel/iommu_groups/19/devices/0000:07:00.0
> /sys/kernel/iommu_groups/20
> /sys/kernel/iommu_groups/20/devices
> /sys/kernel/iommu_groups/20/devices/0000:08:04.0

Ok, I was thinking we'd see these last two devices together, but on
second thought this is exactly what the alias is telling us, ie. it can
distinguish a DMA from a device on bus 08 from a DMA from 07:00.0
itself, but it cannot distinguish between devices on bus 08 (hopefully
that's actually true).  If you somehow had a device 08:05.0 you would
see a new group 21 with just that device on stock 3.6 whereas with the
patches you should see 08:05.0 added to group 20.  If we plugged this
same card into an Intel VT-d system, the grouping would be done as I was
thinking with both 07:00.0 and 08:04.0 being in group 19.  Thanks again
for your testing,

Alex
