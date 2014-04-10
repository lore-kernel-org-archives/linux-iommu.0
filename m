From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] PCI: Introduce new device binding path using
	pci_dev.driver_override
Date: Thu, 10 Apr 2014 16:16:12 -0600
Message-ID: <1397168172.3142.62.camel@ul30vt.home>
References: <20140401161851.18815.31108.stgit@bling.home>
	<9b087b78bf9e41628cca2bd9e6f6a1c2@DM2PR03MB352.namprd03.prod.outlook.com>
	<1397164516.3142.51.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1397164516.3142.51.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "mhocko-AlSwsSmVLrQ@public.gmane.org" <mhocko-AlSwsSmVLrQ@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org" <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "d.kasatkin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <d.kasatkin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "toshi.kani-VXdhtT5mjnY@public.gmane.org" <toshi.kani-VXdhtT5mjnY@public.gmane.org>g
List-Id: iommu@lists.linux-foundation.org

On Thu, 2014-04-10 at 15:15 -0600, Alex Williamson wrote:
> On Thu, 2014-04-10 at 20:52 +0000, Stuart Yoder wrote:
> > > Another advantage to this approach is that we can specify a driver
> > > override to force a specific binding or prevent any binding.  For
> > > instance when an IOMMU group is exposed to userspace through VFIO
> > > we require that all devices within that group are owned by VFIO.
> > > However, devices can be hot-added into an IOMMU group, in which case
> > > we want to prevent the device from binding to any driver (preferred
> > > driver = "none") or perhaps have it automatically bind to vfio-pci.
> > > With driver_override it's a simple matter for this field to be set
> > > internally when the device is first discovered to prevent driver
> > > matches.
> > 
> > Alex, I think the patch looks good, but did have a question about
> > the hot-adding device scenario above.   How do you get the "field to
> > be set internally when the device is first discovered"?   What
> > hook is there to do that prior to the driver match processing?
> 
> Devices already need to be added to iommu groups prior to driver probe
> which happens either by the iommu driver calling bus_register_notifier()
> and looking for BUS_NOTIFY_ADD_DEVICE or they can register an add_device
> callback in their iommu_ops and let the iommu subsystem register the
> notifier.  When a device is then added to an iommu group, there is yet
> another notifier.  vfio calls iommu_group_register_notifier() and gets
> told via IOMMU_GROUP_NOTIFY_ADD_DEVICE when a device is added to a
> group.  We currently have a WARN_ON when a device is added to a live
> group - vfio_group_nb_add_dev().  I expect we'd just replace that with
> detecting the bus_type of the device and allocating a string with the
> proper vfio driver for the bus.  Thanks,

For instance, the below should work for PCI devices.  I imagine we'd
also want to print out some useful log message for this as well.
Thanks,

Alex

--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -486,7 +486,14 @@ static int vfio_group_nb_add_dev(struct vfio_group *group, 
        if (!atomic_read(&group->container_users))
                return 0;
 
-       /* TODO Prevent device auto probing */
+       /* Only let PCI devices added to a live group bind to "vfio-pci" */
+       if (dev_is_pci(dev)) {
+               struct pci_dev *pdev = to_pci_dev(dev);
+               pdev->driver_override = kstrdup("vfio-pci", GFP_KERNEL);
+               if (pdev->driver_override)
+                       return 0;
+       }
+
        WARN("Device %s added to live group %d!\n", dev_name(dev),
             iommu_group_id(group->iommu_group));
 
