From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: mechanism to allow a driver to bind to any device
Date: Wed, 26 Mar 2014 22:42:44 +0100
Message-ID: <CAG8rG2zD2SHBZ9CjHZ-JMvYh5Zx=0n2ndrSh+Tx-nsMk_8uw4w@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54cd150235ba4954becdd12f725c5ebd-ufbTtyGzTTT8GZusEWM6WuO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
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
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org" <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Kasatkin <d.kasatkin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Michal Hocko <mhocko-AlSwsSmVLrQ@public.gmane.org>, Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Joe
List-Id: iommu@lists.linux-foundation.org

(Resend because of html)

On Wed, Mar 26, 2014 at 2:40 AM, Stuart Yoder
<stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> Hi Greg,
>
> We (Linaro, Freescale, Virtual Open Systems) are trying get an issue
> closed that has been perculating for a while around creating a mechanism
> that will allow kernel drivers like vfio can bind to devices of any type.
>
> This thread with you:
> http://www.spinics.net/lists/kvm-arm/msg08370.html
> ...seems to have died out, so am trying to get your response
> and will summarize again.  Vfio drivers in the kernel (regardless of
> bus type) need to bind to devices of any type.  The driver's function
> is to simply export hardware resources of any type to user space.
>
> There are several approaches that have been proposed:
>
>    1.  new_id -- (current approach) the user explicitly registers
>        each new device type with the vfio driver using the new_id
>        mechanism.
>
>        Problem: multiple drivers will be resident that handle the
>        same device type...and there is nothing user space hotplug
>        infrastructure can do to help.
>

Of note is that new_id doesn't work particularly well for platform
devices. Before trying any of the other two solutions, a nasty hack
was applied on the device tree used with the system in order to let
vfio-platform match with a specific device, which is certainly not an
acceptable solution.

Implementing wildcard matching quickly reveals the problems mentioned,
which motivates the other two approaches.

>    2.  "any id" -- the vfio driver could specify a wildcard match
>        of some kind in its ID match table which would allow it to
>        match and bind to any possible device id.  However,
>        we don't want the vfio driver grabbing _all_ devices...just the ones we
>        explicitly want to pass to user space.
>
>        The proposed patch to support this was to create a new flag
>        "sysfs_bind_only" in struct device_driver.  When this flag
>        is set, the driver can only bind to devices via the sysfs
>        bind file.  This would allow the wildcard match to work.
>
>        Patch is here:
>        https://lkml.org/lkml/2013/12/3/253
>
>    3.  "Driver initiated explicit bind" -- with this approach the
>        vfio driver would create a private 'bind' sysfs object
>        and the user would echo the requested device into it:
>
>        echo 0001:03:00.0 > /sys/bus/pci/drivers/vfio-pci/vfio_bind
>
>        In order to make that work, the driver would need to call
>        driver_probe_device() and thus we need this patch:
>        https://lkml.org/lkml/2014/2/8/175
>
>
> Would like your comment on these options-- option #3 is preferred
> and is literally a 2 line patch.

I would definitely agree with approach #3, for which Kim has already
provided a patch. Not having this would make using VFIO with platform
devices really inelegant and strange.

>
> Thanks,
> Stuart



-- 
Antonios Motakis
Virtual Open Systems
