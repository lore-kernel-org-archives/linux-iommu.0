From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 7/9] vfio/mdev: Add iommu related member in mdev_device
Date: Wed, 27 Mar 2019 12:16:25 -0600
Message-ID: <20190327121625.4a8db805@x1.home>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
	<20190325013036.18400-8-baolu.lu@linux.intel.com>
	<b45dabe5-04ef-0e05-db25-c8edf111e355@nvidia.com>
	<VI1PR0501MB2271172964AFA3CDD6F1B02CD1580@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <VI1PR0501MB2271172964AFA3CDD6F1B02CD1580-o1MPJYiShEx8vvm6e75m2MDSnupUy6xnnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Parav Pandit <parav-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Cc: "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 27 Mar 2019 14:17:57 +0000
Parav Pandit <parav-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org> wrote:

> > -----Original Message-----
> > From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <linux-kernel-  
> > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> On Behalf Of Kirti Wankhede  
> > Sent: Tuesday, March 26, 2019 4:33 AM
> > To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>;
> > David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>; Alex Williamson
> > <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org;
> > jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; Jean-Philippe Brucker <jean-  
> > philippe.brucker-5wv7dgnIgG8@public.gmane.org>; yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org;  
> > peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org; xin.zeng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org;
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> > kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; Neo Jia
> > <cjia-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > Subject: Re: [PATCH v8 7/9] vfio/mdev: Add iommu related member in
> > mdev_device
> > 
> > 
> > 
> > On 3/25/2019 7:00 AM, Lu Baolu wrote:  
> > > A parent device might create different types of mediated devices. For
> > > example, a mediated device could be created by the parent device with
> > > full isolation and protection provided by the IOMMU. One usage case
> > > could be found on Intel platforms where a mediated device is an
> > > assignable subset of a PCI, the DMA requests on behalf of it are all
> > > tagged with a PASID. Since IOMMU supports PASID-granular translations
> > > (scalable mode in VT-d 3.0), this mediated device could be
> > > individually protected and isolated by an IOMMU.
> > >
> > > This patch adds a new member in the struct mdev_device to indicate
> > > that the mediated device represented by mdev could be isolated and
> > > protected by attaching a domain to a device represented by
> > > mdev->iommu_device. It also adds a helper to add or set the iommu
> > > device.
> > >
> > > * mdev_device->iommu_device
> > >   - This, if set, indicates that the mediated device could
> > >     be fully isolated and protected by IOMMU via attaching
> > >     an iommu domain to this device. If empty, it indicates
> > >     using vendor defined isolation, hence bypass IOMMU.
> > >
> > > * mdev_set/get_iommu_device(dev, iommu_device)
> > >   - Set or get the iommu device which represents this mdev
> > >     in IOMMU's device scope. Drivers don't need to set the
> > >     iommu device if it uses vendor defined isolation.
> > >
> > > Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > Suggested-by: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > Suggested-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> > > ---
> > >  drivers/vfio/mdev/mdev_core.c    | 18 ++++++++++++++++++
> > >  drivers/vfio/mdev/mdev_private.h |  1 +
> > >  include/linux/mdev.h             | 14 ++++++++++++++
> > >  3 files changed, 33 insertions(+)
> > >
> > > diff --git a/drivers/vfio/mdev/mdev_core.c
> > > b/drivers/vfio/mdev/mdev_core.c index b96fedc77ee5..1b6435529166
> > > 100644
> > > --- a/drivers/vfio/mdev/mdev_core.c
> > > +++ b/drivers/vfio/mdev/mdev_core.c
> > > @@ -390,6 +390,24 @@ int mdev_device_remove(struct device *dev, bool  
> > force_remove)  
> > >  	return 0;
> > >  }
> > >
> > > +int mdev_set_iommu_device(struct device *dev, struct device
> > > +*iommu_device) {
> > > +	struct mdev_device *mdev = to_mdev_device(dev);
> > > +
> > > +	mdev->iommu_device = iommu_device;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(mdev_set_iommu_device);
> > > +
> > > +struct device *mdev_get_iommu_device(struct device *dev) {
> > > +	struct mdev_device *mdev = to_mdev_device(dev);
> > > +
> > > +	return mdev->iommu_device;
> > > +}
> > > +EXPORT_SYMBOL(mdev_get_iommu_device);
> > > +
> > >  static int __init mdev_init(void)
> > >  {
> > >  	return mdev_bus_register();
> > > diff --git a/drivers/vfio/mdev/mdev_private.h
> > > b/drivers/vfio/mdev/mdev_private.h
> > > index 379758c52b1b..bfb7b22a7cb6 100644
> > > --- a/drivers/vfio/mdev/mdev_private.h
> > > +++ b/drivers/vfio/mdev/mdev_private.h
> > > @@ -34,6 +34,7 @@ struct mdev_device {
> > >  	struct list_head next;
> > >  	struct kobject *type_kobj;
> > >  	bool active;
> > > +	struct device *iommu_device;
> > >  };
> > >  
> This is not a performance path, but it is a good practice to create naturally aligned/packed structures.
> You should define struct device *iommu_device; before bool active.

Agreed, if someone wants to fixup before commit or if there's another
spin please do so, otherwise we can adjust it in a trivial follow-up
patch.  Thanks,

Alex
