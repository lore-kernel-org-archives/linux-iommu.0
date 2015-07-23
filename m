From: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/1] vfio-pci/iommu: Detach iommu group on remove path
Date: Thu, 23 Jul 2015 15:27:52 +0200
Message-ID: <20150723152752.5454e4b4@thinkpad>
References: <1437500646-18031-1-git-send-email-gerald.schaefer@de.ibm.com>
	<1437500646-18031-2-git-send-email-gerald.schaefer@de.ibm.com>
	<1437584075.5211.34.camel@redhat.com>
	<1437585057.5211.38.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437585057.5211.38.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 22 Jul 2015 11:10:57 -0600
Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Wed, 2015-07-22 at 10:54 -0600, Alex Williamson wrote:
> > On Tue, 2015-07-21 at 19:44 +0200, Gerald Schaefer wrote:
> > > When a user completes the VFIO_SET_IOMMU ioctl and the vfio-pci
> > > device is removed thereafter (before any other ioctl like
> > > VFIO_GROUP_GET_DEVICE_FD), then the detach_dev callback of the
> > > underlying IOMMU API is never called.
> > > 
> > > This patch adds a call to vfio_group_try_dissolve_container() to
> > > the remove path, which will trigger the missing detach_dev
> > > callback in this scenario.
> > > 
> > > Signed-off-by: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  drivers/vfio/vfio.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> > > index 2fb29df..9c5c784 100644
> > > --- a/drivers/vfio/vfio.c
> > > +++ b/drivers/vfio/vfio.c
> > > @@ -711,6 +711,8 @@ static bool vfio_dev_present(struct
> > > vfio_group *group, struct device *dev) return true;
> > >  }
> > >  
> > > +static void vfio_group_try_dissolve_container(struct vfio_group
> > > *group); +
> > >  /*
> > >   * Decrement the device reference count and wait for the device
> > > to be
> > >   * removed.  Open file descriptors for the device... */
> > > @@ -785,6 +787,7 @@ void *vfio_del_group_dev(struct device *dev)
> > >  		}
> > >  	} while (ret <= 0);
> > >  
> > > +	vfio_group_try_dissolve_container(group);
> > >  	vfio_group_put(group);
> > >  
> > >  	return device_data;
> > 
> > 
> > This won't work, vfio_group_try_dissolve_container() decrements
> > container_users, which an unused device is not.  Imagine if we had
> > more than one device in the iommu group, one device is removed and
> > the container is dissolved despite the user holding a reference and
> > other viable devices remaining.  Additionally, from an isolation
> > perspective, an unbind from vfio-pci should not pull the device out
> > of the iommu domain, it's part of the domain because it's not
> > isolated and that continues even after unbind.
> > 
> > I think what you want to do is detach a device from the iommu domain
> > only when it's being removed from iommu group, such as through
> > iommu_group_remove_device().  We already have a bit of an asymmetry
> > there as iommu_group_add_device() will add devices to the currently
> > active iommu domain for the group, but iommu_group_remove_device()
> > does not appear to do the reverse.  Thanks,
> 
> BTW, VT-d on x86 avoids a leak using its own notifier_block,
> drivers/iommu/intel-iommu.c:device_notifier() catches
> BUS_NOTIFY_REMOVED_DEVICE and removes the device from the domain (the
> domain_exit() there is only used for non-IOMMU-API domains).  It's
> possible that's the only IOMMU driver that avoids a leak due to the
> scenario you describe.  Thanks,

Thanks, that's good to know, so as a last resort I could also use the
notifier to work around the issue. But x86 seems to be the only arch
using this notifier so far, so a general fix would be nice.
