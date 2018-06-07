From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 0/7] vfio/type1: Add support for valid iova list
	management
Date: Thu, 7 Jun 2018 09:05:40 -0600
Message-ID: <20180607090540.3e7b6946@w520.home>
References: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
	<20180524122032.724676b9@w520.home>
	<5FC3163CFD30C246ABAA99954A238FA8386EE591@FRAEML521-MBX.china.huawei.com>
	<20180525145408.2938a9ec@w520.home>
	<20180605110304.33e14b0d@w520.home>
	<5FC3163CFD30C246ABAA99954A238FA8386F783C@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8386F783C-WFPaWmAhWqtUuCJht5byYAK1hpo4iccwjNknBlVQO8k@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "xuwei (O)" <xuwei5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 6 Jun 2018 06:52:08 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:

> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> > Sent: 05 June 2018 18:03
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > Cc: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org;
> > kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> > foundation.org; Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; John Garry
> > <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; xuwei (O) <xuwei5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; Joerg Roedel
> > <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> > Subject: Re: [PATCH v6 0/7] vfio/type1: Add support for valid iova list
> > management
> > 
> > [Cc +dwmw2]
> > 
> > On Fri, 25 May 2018 14:54:08 -0600
> > Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >   
> > > On Fri, 25 May 2018 08:45:36 +0000
> > > Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>  
> > wrote:  
> > >  
> > > > Yes, the above changes related to list empty cases looks fine to me.  
> > >
> > > Thanks Shameer, applied to my next branch with the discussed fixes for
> > > v4.18 (modulo patch 4/7 which Joerg already pushed for v4.17).  Thanks,  
> > 
> > Hi Shameer,
> > 
> > We're still hitting issues with this.  VT-d marks reserved regions for
> > any RMRR ranges, which are IOVA ranges that the BIOS requests to be
> > identity mapped for a device.  These are indicated by these sorts of
> > log entries on boot:
> > 
> >  DMAR: Setting RMRR:
> >  DMAR: Setting identity map for device 0000:00:02.0 [0xbf800000 - 0xcf9fffff]
> >  DMAR: Setting identity map for device 0000:00:1a.0 [0xbe8d1000 - 0xbe8dffff]
> >  DMAR: Setting identity map for device 0000:00:1d.0 [0xbe8d1000 - 0xbe8dffff]
> > 
> > So while for an unaffected device, I see very usable ranges for QEMU,
> > such as:
> > 
> > 	00: 0000000000000000 - 00000000fedfffff
> > 	01: 00000000fef00000 - 01ffffffffffffff
> > 
> > If I try to assign the previously assignable 00:02.0 IGD graphics
> > device, I get:
> > 
> > 	00: 0000000000000000 - 00000000bf7fffff
> > 	01: 00000000cfa00000 - 00000000fedfffff
> > 	02: 00000000fef00000 - 01ffffffffffffff
> > 
> > And we get a fault when QEMU tries the following mapping:
> > 
> > vfio_dma_map(0x55f790421a20, 0x100000, 0xbff00000, 0x7ff163f00000)
> > 
> > bff00000 clearly extends into the gap starting at bf800000.  VT-d is
> > rather split-brained about RMRRs, typically we'd exclude devices from
> > assignment at all for relying on RMRRs and these reserved ranges
> > would be a welcome mechanism to avoid conflicts with those ranges, but
> > for RMRR ranges covering IGD and USB devices we've decided that we
> > don't need to honor the RMRR (see device_is_rmrr_locked()), but it's
> > still listed as a reserved range and bites us here.  
> 
> Ah..:(. This looks similar to the pci window range reporting issue faced in
> the arm world. I see the RFC you have sent out to ignore these "known" 
> RMRRs. Hope we will be able to resolve this soon.

In the meantime, it seems that I need to drop the iova list from my
branch for v4.18, I don't think it makes much sense to expose to
userspace if we cannot also enforce it and it seems like it presents API
issues if we were to expose the iova list without enforcement and later
try to enforce it.  Sorry I didn't catch this earlier.  Thanks,

Alex
