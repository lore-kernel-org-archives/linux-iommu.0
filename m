From: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC PATCH v4 01/10] driver core: export driver_probe_device()
Date: Thu, 20 Feb 2014 22:34:35 +0000
Message-ID: <b6374a0f30194969ba4622ff2f58ae65@DM2PR03MB352.namprd03.prod.outlook.com>
References: <1391880580-471-1-git-send-email-a.motakis@virtualopensystems.com>
	<1391880580-471-2-git-send-email-a.motakis@virtualopensystems.com>
	<20140214222716.GA11838@kroah.com>
	<ba7597fd8c9f4d91bbccfb42e31a165e@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140215024725.GA2542@kroah.com>
	<7043e1edd9974de590dcb392cd8aff14@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140215173348.GA8056@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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



> -----Original Message-----
> From: Yoder Stuart-B08248
> Sent: Saturday, February 15, 2014 12:19 PM
> To: 'Greg KH'
> Cc: Antonios Motakis; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org;
> a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
> jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bhushan Bharat-R65777; Wood
> Scott-B07421; christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Sethi Varun-
> B16395; will.deacon-5wv7dgnIgG8@public.gmane.org; Tejun Heo; Rafael J. Wysocki; Guenter Roeck;
> Toshi Kani; Joe Perches; Dmitry Kasatkin; Michal Hocko; Bjorn Helgaas
> Subject: RE: [RFC PATCH v4 01/10] driver core: export
> driver_probe_device()
> 
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org]
> > Sent: Saturday, February 15, 2014 11:34 AM
> > To: Yoder Stuart-B08248
> > Cc: Antonios Motakis; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> > kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-
> > kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org;
> > a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
> > jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bhushan Bharat-R65777;
> Wood
> > Scott-B07421; christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Sethi Varun-
> > B16395; will.deacon-5wv7dgnIgG8@public.gmane.org; Tejun Heo; Rafael J. Wysocki; Guenter
> Roeck;
> > Toshi Kani; Joe Perches; Dmitry Kasatkin; Michal Hocko; Bjorn Helgaas
> > Subject: Re: [RFC PATCH v4 01/10] driver core: export
> > driver_probe_device()
> >
> > On Sat, Feb 15, 2014 at 04:33:44PM +0000, Stuart Yoder wrote:
> > > > > Why?  driver_probe_device() allows a driver to explicitly bind
> > > > > to a specific device.   What is conceptually wrong with allowing
> > > > > that?
> > > >
> > > > Because that's not how a bus should work, and the fact that no
> other
> > > > subsystem in the kernel does that might be a hint you are trying to
> > do
> > > > something a bit "wrong" here.
> > >
> > > Let me try to succinctly as I can describe the problem we are trying
> to
> > > solve here...
> > >
> > > The vfio mechanism in the kernel (e.g. vfio-pci) allows devices to be
> > > exposed user space (via file descriptors), enabling user space
> > > drivers.  So, for example to export an e1000 card to user space, I do
> > > this:
> > >
> > >    echo 0001:03:00.0 >
> /sys/bus/pci/devices/0001:03:00.0/driver/unbind
> > >    echo 8086 10d3 > /sys/bus/pci/drivers/vfio-pci/new_id
> >
> > What's wrong with using the "bind" file instead?  That picks a specific
> > device and binds it to a specific driver.  Or have we been down this
> > path before?  :)
> 
> Yes we have :)  The "bind" file does not bypass device ID checks, so
> it wouldn't work without new_id or a wildcard match of some kind.
> 
> > And that is for a PCI "driver" not a totally separate bus, which it
> > looks like you are wanting to do here.
> 
> vfio-pci is a PCI driver, not a bus (drivers/vfio/pci/vfio_pci.c).
> 
> > > The first step unbinds the target device (0001:03:00.0) from the
> normal
> > > e1000 driver.
> > >
> > > The second step causes the vfio-pci driver to bind to device
> > 0001:03:00.0.
> > > This second step tells vfio-pci that it now handles e1000 device IDs,
> > > and the vfio-pci drivers registers with the PCI bus to handle '8086
> > 10d3'.
> > >
> > > That works, but it is ugly.  We now have 2 active drivers handling
> > > the same device type...which introduces various possible race
> > conditions.
> > >
> > > We never want vfio-pci to auto-bind to any new device that shows up
> > > on the PCI bus.  Binding a device to vfio-pci must be an explicit
> > > action by an administrator.
> >
> > Then use the "bind" file.
> 
> See above.
> 
> > > You mentioned previously that user space can sort out the problem
> > > of multiple drivers registered for handling the same device type.
> > > That is true, but doesn't help here.   We don't want vfio-pci
> > > to handle _all_ e1000 cards, just explicitly selected e1000 cards.
> > >
> > > We want the normal e1000 driver to be loaded and to bind to new
> > > devices that may be hot-plugged.
> >
> > I want a pony too...
> 
> It's not that difficult...this patch accomplishes it by
> simply allowing drivers to call driver_probe_device().
> 
> > > There are 2 proposed mechanisms that have been put forth, both of
> > > which you have now rejected:
> > >
> > >    1.  sysfs_bind_only flag was proposed which would allow a vfio
> > >        driver (like vfio-pci) to only bind by explicit request
> through
> > >        the sysfs 'bind' file.
> >
> > Why did I reject this?  What did the patch look like?
> 
> https://lkml.org/lkml/2013/12/3/253
> 
> 
> > >    2.  Have the vfio driver call driver_probe_device() to explicitly
> > bind
> > >        a particular device instance to the driver.  Only change we
> need
> > >        here is the EXPORT_SYMBOL.
> >
> > How are you going to prevent the driver from being bound to the device
> > in the core with this change?  How are you going to call this function?
> > When?  On what action of the user?
> 
> The vfio-pci driver would create a sysfs object "vfio_bind".
> 
> User would do:
>    echo 0001:03:00.0 > /sys/bus/pci/drivers/vfio-pci/vfio_bind
> 
> vfio-pci would call driver_probe_device() which binds
> the specific device to the vfio-pci driver...and there is
> no ambiguity.
> 
> > > Are you in principle opposed to any mechanism that would allow 2
> > drivers
> > > to be resident/active and allow a sysadmin to explicitly bind a
> > > particular device instance to the driver of their choice?
> >
> > No, that works today with the bind/unbind/new_id files, it's just that
> > you don't like it :)
> 
> We don't like it because of the ambiguities/race-conditions with
> the current situation.
> 
> A vfio driver, like vfio-pci, certainly is a bit different than a normal
> driver, in that it really is not device ID aware.  It simply passes
> through device resources (mappable regions, IRQs) to user space without
> interpreting or understanding them.  It is kind of a "meta" driver, but
> it is not a bus.  Every bus type would need its own vfio driver to
> do this type of device pass through.

Hi Greg,

Any further thoughts on this?

Thanks,
Stuart
