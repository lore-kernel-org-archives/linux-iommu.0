From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFC PATCH] iommu/vt-d: Exclude known RMRRs from reserved ranges
Date: Tue, 3 Jul 2018 10:46:28 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83870DFE9@FRAEML521-MBX.china.huawei.com>
References: <20180605190400.22732.2998.stgit@gimli.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D1911F88AD@SHSMSX101.ccr.corp.intel.com>
	<20180607090157.5458a2ae@w520.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D1911FD12E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1911FD12E-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

> -----Original Message-----
> From: Tian, Kevin [mailto:kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> Sent: 08 June 2018 03:56
> To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Shameerali Kolothum
> Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Subject: RE: [RFC PATCH] iommu/vt-d: Exclude known RMRRs from reserved
> ranges
> 
> > From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> > Sent: Thursday, June 7, 2018 11:02 PM
> >
> > On Wed, 6 Jun 2018 05:29:58 +0000
> > "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >
> > > > From: Alex Williamson
> > > > Sent: Wednesday, June 6, 2018 3:07 AM
> > > >
> > > > device_is_rmrr_locked() allows graphics and USB devices to participate
> > > > in the IOMMU API despite, and ignoring their RMRR association,
> > however
> > > > intel_iommu_get_resv_regions() still includes the RMRRs as unavailable
> > > > IOVA space for the device.  Are we ignoring the RMRR for these devices
> > > > or are we not?  If vfio starts consuming reserved regions, perhaps we
> > > > no longer need to consider devices with RMRRs excluded from the
> > IOMMU
> > > > API interface, but we have a transitional problem that these allowed
> > > > devices still impose incompatible IOVA restrictions per the reserved
> > > > region reporting.  Dive further down the rabbit hole by also ignoring
> > > > RMRRs for "known" devices in the reserved region reporting.
> > >
> > > intel_iommu_get_resv_regions is used not just for IOMMU API. I'm
> > > afraid doing so will make RMRR completely ignored, even in normal
> > > DMA API path...
> >
> > Well, I'm a bit stuck then, we have existing IOMMU API users that
> > ignore these ranges and in fact conflict with these ranges blocking us
> > from restricting mappings within these ranges.  My impression is that
> > IOMMU reserved ranges should only be ranges which have some
> > fundamental
> > limitation in the IOMMU, not simply mappings for which firmware has
> > requested an identity mapped range.  The latter should simply be a
> > pre-allocation of the IOVA space, for the cases where we choose to
> > honor the RMRR.  Thanks,
> >
> 
> Then possibly need introduce a different interface for pre-allocation
> scenario, if above definition of reserved ranges is agreed. Currently
> two categories are both called reserved resources, e.g. IOMMU_RESV
> _DIRECT for rmrr and IOMMU_RESV_MSI for MSI...

Sorry, but I just thought of checking on the future plans/directions for solving
this issue(Unfortunately vfio iova list series depends on this).

Please let me know if there is any plans for a v2 soon.

Much appreciated,
Shameer
