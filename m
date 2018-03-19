From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v5 0/7] vfio/type1: Add support for valid iova list
	management
Date: Mon, 19 Mar 2018 12:12:47 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191085BED@SHSMSX101.ccr.corp.intel.com>
References: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19108585F@SHSMSX101.ccr.corp.intel.com>
	<5FC3163CFD30C246ABAA99954A238FA838675F3C@FRAEML521-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838675F3C-WFPaWmAhWqtUuCJht5byYAK1hpo4iccwjNknBlVQO8k@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: "xuwei (O)" <xuwei5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Shameerali Kolothum Thodi
> [mailto:shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org]
> 
> Hi Kevin,
> 
> Thanks for taking a look at this series.
> 
> > -----Original Message-----
> > From: Tian, Kevin [mailto:kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> > Sent: Monday, March 19, 2018 8:29 AM
> > To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>;
> > alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> > pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
> > Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; xuwei (O)
> > <xuwei5-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>;
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > Subject: RE: [PATCH v5 0/7] vfio/type1: Add support for valid iova list
> > management
> >
> > > From: Shameer Kolothum
> > > Sent: Friday, March 16, 2018 12:35 AM
> > >
> > > This series introduces an iova list associated with a vfio
> > > iommu. The list is kept updated taking care of iommu apertures,
> > > and reserved regions. Also this series adds checks for any conflict
> > > with existing dma mappings whenever a new device group is attached
> to
> > > the domain.
> > >
> > > User-space can retrieve valid iova ranges using
> VFIO_IOMMU_GET_INFO
> > > ioctl capability chains. Any dma map request outside the valid iova
> > > range will be rejected.
> >
> > GET_INFO is done at initialization time which is good for cold attached
> > devices. If a hotplugged device may cause change of valid iova ranges
> > at run-time, then there could be potential problem (which however is
> > difficult for user space or orchestration stack to figure out in advance)
> > Can we do some extension like below to make hotplug case cleaner?
> 
> As I understand, in case a hotplugged device results in an update to the
> valid
> Iova ranges then the Qemu, vfio_connect_container() -->
> memory_listner_register()
> will fail if there is a conflict as patch #4 checks for invalid dma map requests.

OK, possibly Qemu can do another GET_INFO upon any dma map 
error to get latest ranges and then allocate a new valid iova to
redo the map. this should work if valid ranges shrink due to new
hotplugged device. But if hot-removing a device may result in
more valid ranges, so far there is no way for Qemu to pick up.
I'm not sure whether we want to go that far though...

> 
> Not sure, your concern is preventing hotplug much before this happens or
> not.
> 

yes, my earlier thought is more to catch the problem in attach phase.

Thanks
Kevin
