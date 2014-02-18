From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [RFC PATCH v4 01/10] driver core: export driver_probe_device()
Date: Mon, 17 Feb 2014 18:38:39 -0600
Message-ID: <1392683919.6733.660.camel@snotra.buserror.net>
References: <1391880580-471-1-git-send-email-a.motakis@virtualopensystems.com>
	<1391880580-471-2-git-send-email-a.motakis@virtualopensystems.com>
	<20140214222716.GA11838@kroah.com>
	<ba7597fd8c9f4d91bbccfb42e31a165e@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140215024725.GA2542@kroah.com>
	<7043e1edd9974de590dcb392cd8aff14@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140215173348.GA8056@kroah.com>
	<38f0473542954fe8b312a1f7b61a3d21@DM2PR03MB352.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <38f0473542954fe8b312a1f7b61a3d21-ufbTtyGzTTT8GZusEWM6WuO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoder Stuart-B08248 <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org" <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Sethi Varun-B16395 <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Kasatkin <d.kasatkin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Michal Hocko <mhocko-AlSwsSmVLrQ@public.gmane.org>, Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm77oxUfYCNXn@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, 2014-02-15 at 12:19 -0600, Yoder Stuart-B08248 wrote:
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org]
> > Sent: Saturday, February 15, 2014 11:34 AM
> > To: Yoder Stuart-B08248
> > Cc: Antonios Motakis; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> > kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-
> > kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org;
> > a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
> > jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bhushan Bharat-R65777; Wood
> > Scott-B07421; christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Sethi Varun-
> > B16395; will.deacon-5wv7dgnIgG8@public.gmane.org; Tejun Heo; Rafael J. Wysocki; Guenter Roeck;
> > Toshi Kani; Joe Perches; Dmitry Kasatkin; Michal Hocko; Bjorn Helgaas
> > Subject: Re: [RFC PATCH v4 01/10] driver core: export
> > driver_probe_device()
> > 
> > On Sat, Feb 15, 2014 at 04:33:44PM +0000, Stuart Yoder wrote:
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

Plus, it's semantically weird (a.k.a. a hack).  The user isn't trying to
bind an entire type of device to the vfio driver, but rather a specific
device.  Races and similar ugliness is often what you get when you try
to pile things on top of the wrong abstraction.  That you can hack
around the races with a userspace loop (and hope that no damage was done
by the wrong driver in the meantime -- packets sent, filesystems
automounted, other inappropriate I/O performed, driver unbind
bugs/unwillingness encountered, etc) is not a particularly satisfying
answer.  At best the race fixup will end up being a poorly tested code
path (if the person scripting userspace thinks of doing it at all).

It also doesn't "work today" because there is no new_id for platform
devices, and the matching situation for platform devices is more
complicated than on PCI, so it would be more awkward to implement and
more awkward to use.

We can apply enough grease and pound the square peg through the round
hole if we must, but we'd like to first exhaust our options for doing it
in a simple, straightforward, robust, and semantically sensible manner
-- especially since once we start supporting the new_id approach for
vfio binding on platform devices it'll be ABI that we're stuck with.

-Scott
