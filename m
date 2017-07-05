From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB invalidate
	propagation
Date: Wed, 5 Jul 2017 05:32:24 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D257F9@SHSMSX101.ccr.corp.intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<20170512155843.5abeb4bd@t450s.home> <20170514105507.GB22110@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170514105507.GB22110-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Liu, Yi L [mailto:yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Sunday, May 14, 2017 6:55 PM
> 
> On Fri, May 12, 2017 at 03:58:43PM -0600, Alex Williamson wrote:
> > On Wed, 26 Apr 2017 18:12:04 +0800
> > "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >
> > > From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > >
> > > This patch adds VFIO_IOMMU_TLB_INVALIDATE to propagate IOMMU
> TLB
> > > invalidate request from guest to host.
> > >
> > > In the case of SVM virtualization on VT-d, host IOMMU driver has
> > > no knowledge of caching structure updates unless the guest
> > > invalidation activities are passed down to the host. So a new
> > > IOCTL is needed to propagate the guest cache invalidation through
> > > VFIO.
> > >
> > > Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > ---
> > >  include/uapi/linux/vfio.h | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 6b97987..50c51f8 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -564,6 +564,15 @@ struct vfio_device_svm {
> > >
> > >  #define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE +
> 22)
> > >
> > > +/* For IOMMU TLB Invalidation Propagation */
> > > +struct vfio_iommu_tlb_invalidate {
> > > +	__u32	argsz;
> > > +	__u32	length;
> > > +	__u8	data[];
> > > +};
> > > +
> > > +#define VFIO_IOMMU_TLB_INVALIDATE	_IO(VFIO_TYPE, VFIO_BASE +
> 23)
> >
> > I'm kind of wondering why this isn't just a new flag bit on
> > vfio_device_svm, the data structure is so similar.  Of course data
> > needs to be fully specified in uapi.
> 
> Hi Alex,
> 
> For this part, it depends on using opaque structure or not. The following
> link mentioned it in [Open] session.
> 
> http://www.spinics.net/lists/kvm/msg148798.html
> 
> If we pick the full opaque solution for iommu tlb invalidate propagation.
> Then I may add a flag bit on vfio_device_svm and also add definition in
> uapi as you suggested.
> 

there is another benefit to keep it as a separate command. For now
we only need to invalidate 1st level translation (GVA->GPA) for SVM,
since 1st level page table is provided by guest while directly walked
by IOMMU. It's possible some vendor may also choose to implement
a nested 2nd level translation (e.g. GIOVA->GPA->HPA) then hardware
can directly walk guest GIOVA page table thus explicit invalidation is
also required. We'd better not to limit invalidation interface with 
svm structure.

Thanks
Kevin
