From: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: mechanism to allow a driver to bind to any device
Date: Mon, 31 Mar 2014 18:32:43 +0000
Message-ID: <5f50fe2931784cadba54604c8f12863d@DM2PR03MB352.namprd03.prod.outlook.com>
References: <1391880580-471-1-git-send-email-a.motakis@virtualopensystems.com>
	<1391880580-471-2-git-send-email-a.motakis@virtualopensystems.com>
	<20140214222716.GA11838@kroah.com>
	<ba7597fd8c9f4d91bbccfb42e31a165e@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140215024725.GA2542@kroah.com>
	<7043e1edd9974de590dcb392cd8aff14@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140215173348.GA8056@kroah.com>
	<b6374a0f30194969ba4622ff2f58ae65@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140220224337.GA20097@kroah.com>
	<54cd150235ba4954becdd12f725c5ebd@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140326144025.GA18387@phenom.dumpdata.com>
	<D45FC8F2-7807-4BBB-A253-8EFCD091D6BD@suse.de>
	<1395850862.632.247.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395850862.632.247.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org" <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Michal Hocko <mhocko-AlSwsSmVLrQ@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "Rafael J.
	Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Kasatkin <d.kasatkin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEmy65B3kUBaIG@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Wednesday, March 26, 2014 11:21 AM
> To: Alexander Graf
> Cc: Konrad Rzeszutek Wilk; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org;
> will.deacon-5wv7dgnIgG8@public.gmane.org; Yoder Stuart-B08248; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> Michal Hocko; Bjorn Helgaas; Sethi Varun-B16395;
> kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org; Rafael J. Wysocki; Guenter Roeck; Dmitry
> Kasatkin; Joe Perches; Wood Scott-B07421; Antonios Motakis;
> tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; Toshi Kani; Greg KH;
> a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Tejun
> Heo; christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
> Subject: Re: mechanism to allow a driver to bind to any device
> 
> On Wed, 2014-03-26 at 23:06 +0800, Alexander Graf wrote:
> >
> > > Am 26.03.2014 um 22:40 schrieb Konrad Rzeszutek Wilk
> <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>:
> > >
> > >> On Wed, Mar 26, 2014 at 01:40:32AM +0000, Stuart Yoder wrote:
> > >> Hi Greg,
> > >>
> > >> We (Linaro, Freescale, Virtual Open Systems) are trying get an issue
> > >> closed that has been perculating for a while around creating a
> mechanism
> > >> that will allow kernel drivers like vfio can bind to devices of any
> type.
> > >>
> > >> This thread with you:
> > >> http://www.spinics.net/lists/kvm-arm/msg08370.html
> > >> ...seems to have died out, so am trying to get your response
> > >> and will summarize again.  Vfio drivers in the kernel (regardless of
> > >> bus type) need to bind to devices of any type.  The driver's
> function
> > >> is to simply export hardware resources of any type to user space.
> > >>
> > >> There are several approaches that have been proposed:
> > >
> > > You seem to have missed the one I proposed.
> > >>
> > >>   1.  new_id -- (current approach) the user explicitly registers
> > >>       each new device type with the vfio driver using the new_id
> > >>       mechanism.
> > >>
> > >>       Problem: multiple drivers will be resident that handle the
> > >>       same device type...and there is nothing user space hotplug
> > >>       infrastructure can do to help.
> > >>
> > >>   2.  "any id" -- the vfio driver could specify a wildcard match
> > >>       of some kind in its ID match table which would allow it to
> > >>       match and bind to any possible device id.  However,
> > >>       we don't want the vfio driver grabbing _all_ devices...just
> the ones we
> > >>       explicitly want to pass to user space.
> > >>
> > >>       The proposed patch to support this was to create a new flag
> > >>       "sysfs_bind_only" in struct device_driver.  When this flag
> > >>       is set, the driver can only bind to devices via the sysfs
> > >>       bind file.  This would allow the wildcard match to work.
> > >>
> > >>       Patch is here:
> > >>       https://lkml.org/lkml/2013/12/3/253
> > >>
> > >>   3.  "Driver initiated explicit bind" -- with this approach the
> > >>       vfio driver would create a private 'bind' sysfs object
> > >>       and the user would echo the requested device into it:
> > >>
> > >>       echo 0001:03:00.0 > /sys/bus/pci/drivers/vfio-pci/vfio_bind
> > >>
> > >>       In order to make that work, the driver would need to call
> > >>       driver_probe_device() and thus we need this patch:
> > >>       https://lkml.org/lkml/2014/2/8/175
> > >
> > > 4). Use the 'unbind' (from the original device) and 'bind' to vfio
> driver.
> >
> > This is approach 2, no?
> >
> > >
> > > Which I think is what is currently being done. Why is that not
> sufficient?
> >
> > How would 'bind to vfio driver' look like?
> >
> > > The only thing I see in the URL is " That works, but it is ugly."
> > > There is some mention of race but I don't see how - if you do the
> 'unbind'
> > > on the original driver and then bind the BDF to the VFIO how would
> you get
> > > a race?
> >
> > Typically on PCI, you do a
> >
> >   - add wildcard (pci id) match to vfio driver
> >   - unbind driver
> >   -> reprobe
> >   -> device attaches to vfio driver because it is the least recent
> match
> >   - remove wildcard match from vfio driver
> >
> > If in between you hotplug add a card of the same type, it gets attached
> to vfio - even though the logical "default driver" would be the device
> specific driver.
> 
> I've mentioned drivers_autoprobe in the past, but I'm not sure we're
> really factoring it into the discussion.  drivers_autoprobe allows us to
> toggle two points:
> 
> a) When a new device is added whether we automatically give drivers a
> try at binding to it
> 
> b) When a new driver is added whether it gets to try to bind to anything
> in the system
> 
> So we do have a mechanism to avoid the race, but the problem is that it
> becomes the responsibility of userspace to:
> 
> 1) turn off drivers_autoprobe
> 2) unbind/new_id/bind/remove_id
> 3) turn on drivers_autoprobe
> 4) call drivers_probe for anything added between 1) & 3)
> 
> Is the question about the ugliness of the current solution whether it's
> unreasonable to ask userspace to do this?

It's probably not unreasonable... I did not understand the
drivers_autoprobe mechanism until now...didn't realize we had that.

> What we seem to be asking for above is more like an autoprobe flag per
> driver where there's some way for this special driver to opt out of auto
> probing.

Yes, that is basically it.  In fact perhaps using 'autoprobe' in
the name of the sysfs object would have been better and more clear
than 'sysfs_bind_only'.

> Option 2. in Stuart's list does this by short-cutting ID
> matching so that a "match" is only found when using the sysfs bind path,
> option 3. enables a way for a driver to expose their own sysfs entry
> point for binding.  The latter feels particularly chaotic since drivers
> get to make-up their own bind mechanism.
> 
> Another twist I'll throw in is that devices can be hot added to IOMMU
> groups that are in-use by userspace.  When that happens we'd like to be
> able to disable driver autoprobe of the device to avoid a host driver
> automatically binding to the device.  I wonder if instead of looking at
> the problem from the driver perspective, if we were to instead look at
> it from the device perspective if we might find a solution that would
> address both.  For instance, if devices had a driver_probe_id property
> that was by default set to their bus specific ID match ("$VENDOR
> $DEVICE" on PCI) could we use that to write new match IDs so that a
> device could only bind to a given driver?  Effectively we could then
> bind either using the current method of adding to the list of IDs a
> driver will match of changing the ID that a device would match.  Does
> that get us anywhere?  Thanks,

[Saw your follow-on post on the above and will comment there...]

Stuart
