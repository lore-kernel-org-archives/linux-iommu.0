From: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC PATCH v4 01/10] driver core: export driver_probe_device()
Date: Sat, 15 Feb 2014 16:33:44 +0000
Message-ID: <7043e1edd9974de590dcb392cd8aff14@DM2PR03MB352.namprd03.prod.outlook.com>
References: <1391880580-471-1-git-send-email-a.motakis@virtualopensystems.com>
	<1391880580-471-2-git-send-email-a.motakis@virtualopensystems.com>
	<20140214222716.GA11838@kroah.com>
	<ba7597fd8c9f4d91bbccfb42e31a165e@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140215024725.GA2542@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140215024725.GA2542-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org" <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Kasatkin <d.kasatkin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Michal Hocko <mhocko-AlSwsSmVLrQ@public.gmane.org>, Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>, "a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> > Why?  driver_probe_device() allows a driver to explicitly bind
> > to a specific device.   What is conceptually wrong with allowing
> > that?
> 
> Because that's not how a bus should work, and the fact that no other
> subsystem in the kernel does that might be a hint you are trying to do
> something a bit "wrong" here.

Let me try to succinctly as I can describe the problem we are trying to
solve here...

The vfio mechanism in the kernel (e.g. vfio-pci) allows devices to be
exposed user space (via file descriptors), enabling user space
drivers.  So, for example to export an e1000 card to user space, I do
this:

   echo 0001:03:00.0 > /sys/bus/pci/devices/0001:03:00.0/driver/unbind
   echo 8086 10d3 > /sys/bus/pci/drivers/vfio-pci/new_id

The first step unbinds the target device (0001:03:00.0) from the normal
e1000 driver.

The second step causes the vfio-pci driver to bind to device 0001:03:00.0.
This second step tells vfio-pci that it now handles e1000 device IDs,
and the vfio-pci drivers registers with the PCI bus to handle '8086 10d3'. 

That works, but it is ugly.  We now have 2 active drivers handling
the same device type...which introduces various possible race conditions.

We never want vfio-pci to auto-bind to any new device that shows up
on the PCI bus.  Binding a device to vfio-pci must be an explicit
action by an administrator.

You mentioned previously that user space can sort out the problem
of multiple drivers registered for handling the same device type.
That is true, but doesn't help here.   We don't want vfio-pci
to handle _all_ e1000 cards, just explicitly selected e1000 cards.

We want the normal e1000 driver to be loaded and to bind to new
devices that may be hot-plugged.

There are 2 proposed mechanisms that have been put forth, both of
which you have now rejected:

   1.  sysfs_bind_only flag was proposed which would allow a vfio
       driver (like vfio-pci) to only bind by explicit request through
       the sysfs 'bind' file.

   2.  Have the vfio driver call driver_probe_device() to explicitly bind
       a particular device instance to the driver.  Only change we need
       here is the EXPORT_SYMBOL.

Are you in principle opposed to any mechanism that would allow 2 drivers
to be resident/active and allow a sysadmin to explicitly bind a 
particular device instance to the driver of their choice?

Thanks,
Stuart
