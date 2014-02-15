From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [RFC PATCH v4 01/10] driver core: export driver_probe_device()
Date: Fri, 14 Feb 2014 18:47:25 -0800
Message-ID: <20140215024725.GA2542@kroah.com>
References: <1391880580-471-1-git-send-email-a.motakis@virtualopensystems.com>
	<1391880580-471-2-git-send-email-a.motakis@virtualopensystems.com>
	<20140214222716.GA11838@kroah.com>
	<ba7597fd8c9f4d91bbccfb42e31a165e@DM2PR03MB352.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ba7597fd8c9f4d91bbccfb42e31a165e-ufbTtyGzTTT8GZusEWM6WuO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
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
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org" <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Kasatkin <d.kasatkin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Michal Hocko <mhocko-AlSwsSmVLrQ@public.gmane.org>, Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>, "a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 14, 2014 at 11:00:31PM +0000, Stuart Yoder wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org]
> > Sent: Friday, February 14, 2014 4:27 PM
> > To: Antonios Motakis
> > Cc: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org;
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; Yoder Stuart-
> > B08248; kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org;
> > kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bhushan Bharat-R65777; Wood Scott-B07421;
> > christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Sethi Varun-B16395;
> > will.deacon-5wv7dgnIgG8@public.gmane.org; Tejun Heo; Rafael J. Wysocki; Guenter Roeck; Toshi
> > Kani; Joe Perches; Dmitry Kasatkin; Michal Hocko; Bjorn Helgaas
> > Subject: Re: [RFC PATCH v4 01/10] driver core: export
> > driver_probe_device()
> > 
> > On Sat, Feb 08, 2014 at 06:29:31PM +0100, Antonios Motakis wrote:
> > > From: Kim Phillips <kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > >
> > > Needed by drivers, such as the vfio platform driver [1], seeking to
> > > bypass bind_store()'s driver_match_device(), and bind to any device
> > > via a private sysfs bind file.
> > >
> > > [1] https://lkml.org/lkml/2013/12/11/522
> > >
> > > note: the EXPORT_SYMBOL is needed because vfio-platform can be built
> > > as a module.
> > 
> > No code outside of drivers/base/ should be calling this function
> 
> Why?  driver_probe_device() allows a driver to explicitly bind
> to a specific device.   What is conceptually wrong with allowing
> that?

Because that's not how a bus should work, and the fact that no other
subsystem in the kernel does that might be a hint you are trying to do
something a bit "wrong" here.

greg k-h
