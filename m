From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] iommu/vt-d: Exclude known RMRRs from reserved ranges
Date: Thu, 7 Jun 2018 09:01:57 -0600
Message-ID: <20180607090157.5458a2ae@w520.home>
References: <20180605190400.22732.2998.stgit@gimli.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D1911F88AD@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1911F88AD-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 6 Jun 2018 05:29:58 +0000
"Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> > From: Alex Williamson
> > Sent: Wednesday, June 6, 2018 3:07 AM
> > 
> > device_is_rmrr_locked() allows graphics and USB devices to participate
> > in the IOMMU API despite, and ignoring their RMRR association, however
> > intel_iommu_get_resv_regions() still includes the RMRRs as unavailable
> > IOVA space for the device.  Are we ignoring the RMRR for these devices
> > or are we not?  If vfio starts consuming reserved regions, perhaps we
> > no longer need to consider devices with RMRRs excluded from the IOMMU
> > API interface, but we have a transitional problem that these allowed
> > devices still impose incompatible IOVA restrictions per the reserved
> > region reporting.  Dive further down the rabbit hole by also ignoring
> > RMRRs for "known" devices in the reserved region reporting.  
> 
> intel_iommu_get_resv_regions is used not just for IOMMU API. I'm
> afraid doing so will make RMRR completely ignored, even in normal
> DMA API path...

Well, I'm a bit stuck then, we have existing IOMMU API users that
ignore these ranges and in fact conflict with these ranges blocking us
from restricting mappings within these ranges.  My impression is that
IOMMU reserved ranges should only be ranges which have some fundamental
limitation in the IOMMU, not simply mappings for which firmware has
requested an identity mapped range.  The latter should simply be a
pre-allocation of the IOVA space, for the cases where we choose to
honor the RMRR.  Thanks,

Alex

> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/intel-iommu.c |   35 +++++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
> > 
> > If this is the approach we want to take, I could pull this in via the
> > vfio tree, along with Shameer's patches which expose an IOVA list and
> > enforce it to userspace, otherwise I'm afraid Shameer's patches will
> > be blocked a while longer.  Thanks,
> > 
> > Alex
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 749d8f235346..f312f93199c5 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -2864,19 +2864,24 @@ static bool device_has_rmrr(struct device *dev)
> >   * any use of the RMRR regions will be torn down before assigning the
> > device
> >   * to a guest.
> >   */
> > -static bool device_is_rmrr_locked(struct device *dev)
> > +static bool rmrr_is_ignored(struct device *dev)
> >  {
> > -	if (!device_has_rmrr(dev))
> > -		return false;
> > -
> >  	if (dev_is_pci(dev)) {
> >  		struct pci_dev *pdev = to_pci_dev(dev);
> > 
> >  		if (IS_USB_DEVICE(pdev) || IS_GFX_DEVICE(pdev))
> > -			return false;
> > +			return true;
> >  	}
> > 
> > -	return true;
> > +	return false;
> > +}
> > +
> > +static bool device_is_rmrr_locked(struct device *dev)
> > +{
> > +	if (!device_has_rmrr(dev))
> > +		return false;
> > +
> > +	return !rmrr_is_ignored(dev);
> >  }
> > 
> >  static int iommu_should_identity_map(struct device *dev, int startup)
> > @@ -5141,17 +5146,19 @@ static void
> > intel_iommu_get_resv_regions(struct device *device,
> >  	struct device *i_dev;
> >  	int i;
> > 
> > -	rcu_read_lock();
> > -	for_each_rmrr_units(rmrr) {
> > -		for_each_active_dev_scope(rmrr->devices, rmrr-  
> > >devices_cnt,  
> > -					  i, i_dev) {
> > -			if (i_dev != device)
> > -				continue;
> > +	if (!rmrr_is_ignored(device)) {
> > +		rcu_read_lock();
> > +		for_each_rmrr_units(rmrr) {
> > +			for_each_active_dev_scope(rmrr->devices,
> > +						  rmrr->devices_cnt, i, i_dev)
> > {
> > +				if (i_dev != device)
> > +					continue;
> > 
> > -			list_add_tail(&rmrr->resv->list, head);
> > +				list_add_tail(&rmrr->resv->list, head);
> > +			}
> >  		}
> > +		rcu_read_unlock();
> >  	}
> > -	rcu_read_unlock();
> > 
> >  	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
> >  				      IOAPIC_RANGE_END -
> > IOAPIC_RANGE_START + 1,  
> 
