From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [RFC PATCH 1/1] vfio-pci/iommu: Detach iommu group on remove
 path
Date: Thu, 23 Jul 2015 15:03:05 +0200
Message-ID: <20150723150305.1b12865e@thinkpad>
References: <1437500646-18031-1-git-send-email-gerald.schaefer@de.ibm.com>
	<1437500646-18031-2-git-send-email-gerald.schaefer@de.ibm.com>
	<1437584075.5211.34.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1437584075.5211.34.camel@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 22 Jul 2015 10:54:35 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 2015-07-21 at 19:44 +0200, Gerald Schaefer wrote:
> > When a user completes the VFIO_SET_IOMMU ioctl and the vfio-pci
> > device is removed thereafter (before any other ioctl like
> > VFIO_GROUP_GET_DEVICE_FD), then the detach_dev callback of the
> > underlying IOMMU API is never called.
> > 
> > This patch adds a call to vfio_group_try_dissolve_container() to
> > the remove path, which will trigger the missing detach_dev callback
> > in this scenario.
> > 
> > Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > ---
> >  drivers/vfio/vfio.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> > index 2fb29df..9c5c784 100644
> > --- a/drivers/vfio/vfio.c
> > +++ b/drivers/vfio/vfio.c
> > @@ -711,6 +711,8 @@ static bool vfio_dev_present(struct vfio_group
> > *group, struct device *dev) return true;
> >  }
> >  
> > +static void vfio_group_try_dissolve_container(struct vfio_group
> > *group); +
> >  /*
> >   * Decrement the device reference count and wait for the device to
> > be
> >   * removed.  Open file descriptors for the device... */
> > @@ -785,6 +787,7 @@ void *vfio_del_group_dev(struct device *dev)
> >  		}
> >  	} while (ret <= 0);
> >  
> > +	vfio_group_try_dissolve_container(group);
> >  	vfio_group_put(group);
> >  
> >  	return device_data;
> 
> 
> This won't work, vfio_group_try_dissolve_container() decrements
> container_users, which an unused device is not.  Imagine if we had
> more than one device in the iommu group, one device is removed and the
> container is dissolved despite the user holding a reference and other
> viable devices remaining.  Additionally, from an isolation
> perspective, an unbind from vfio-pci should not pull the device out
> of the iommu domain, it's part of the domain because it's not
> isolated and that continues even after unbind.
> 
> I think what you want to do is detach a device from the iommu domain
> only when it's being removed from iommu group, such as through
> iommu_group_remove_device().  We already have a bit of an asymmetry
> there as iommu_group_add_device() will add devices to the currently
> active iommu domain for the group, but iommu_group_remove_device()
> does not appear to do the reverse.  Thanks,

Interesting, I haven't noticed this asymmetry so far, do you mean
something like this:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f286090..82ac8b3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -447,6 +447,9 @@ rename:
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
 
+static void __iommu_detach_device(struct iommu_domain *domain,
+				  struct device *dev);
+
 /**
  * iommu_group_remove_device - remove a device from it's current group
  * @dev: device to be removed
@@ -466,6 +469,8 @@ void iommu_group_remove_device(struct device *dev)
 				     IOMMU_GROUP_NOTIFY_DEL_DEVICE,
dev); 
 	mutex_lock(&group->mutex);
+	if (group->domain)
+		__iommu_detach_device(group->domain, dev);
 	list_for_each_entry(tmp_device, &group->devices, list) {
 		if (tmp_device->dev == dev) {
 			device = tmp_device;

This would also fix the issue in my scenario, but like before that
doesn't need to mean it is the correct fix. Adding the iommu list and
maintainer to cc.

Joerg, what do you think? (see https://lkml.org/lkml/2015/7/21/635 for
the problem description)

