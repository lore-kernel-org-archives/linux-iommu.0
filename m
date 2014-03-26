From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: mechanism to allow a driver to bind to any device
Date: Wed, 26 Mar 2014 22:39:57 +0100
Message-ID: <CAG8rG2xCvCGJWwZTnkia5GD3BVJZB9SmKOm79T6Q1FnhgB+urw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============8558066464007294575=="
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

--===============8558066464007294575==
Content-Type: multipart/alternative; boundary=047d7b5d3610984c2404f5895097

--047d7b5d3610984c2404f5895097
Content-Type: text/plain; charset=ISO-8859-1

Hello,


On Wed, Mar 26, 2014 at 2:40 AM, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>wrote:

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
>
Of note is that new_id doesn't work particularly well for platform devices.
Before trying any of the other two solutions, a nasty hack was applied on
the device tree used with the system in order to let vfio-platform match
with a specific device, which is certainly not an acceptable solution.

Implementing wildcard matching quickly reveals the problems mentioned,
which motivates the other two approaches.


>    2.  "any id" -- the vfio driver could specify a wildcard match
>        of some kind in its ID match table which would allow it to
>        match and bind to any possible device id.  However,
>        we don't want the vfio driver grabbing _all_ devices...just the
> ones we
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
>

I would definitely agree with approach #3, for which Kim has already
provided a patch. Not having this would make using VFIO with platform
devices really inelegant and strange.


>
> Thanks,
> Stuart
>



-- 
Antonios Motakis
Virtual Open Systems

--047d7b5d3610984c2404f5895097
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><div class=3D"gmail_extra"><br><br><div class=3D=
"gmail_quote">On Wed, Mar 26, 2014 at 2:40 AM, Stuart Yoder <span dir=3D"lt=
r">&lt;<a href=3D"mailto:stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org" target=3D"_blank">stua=
rt.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Greg,<br>
<br>
We (Linaro, Freescale, Virtual Open Systems) are trying get an issue<br>
closed that has been perculating for a while around creating a mechanism<br=
>
that will allow kernel drivers like vfio can bind to devices of any type.<b=
r>
<br>
This thread with you:<br>
<a href=3D"http://www.spinics.net/lists/kvm-arm/msg08370.html" target=3D"_b=
lank">http://www.spinics.net/lists/kvm-arm/msg08370.html</a><br>
...seems to have died out, so am trying to get your response<br>
and will summarize again. =A0Vfio drivers in the kernel (regardless of<br>
bus type) need to bind to devices of any type. =A0The driver&#39;s function=
<br>
is to simply export hardware resources of any type to user space.<br>
<br>
There are several approaches that have been proposed:<br>
<br>
=A0 =A01. =A0new_id -- (current approach) the user explicitly registers<br>
=A0 =A0 =A0 =A0each new device type with the vfio driver using the new_id<b=
r>
=A0 =A0 =A0 =A0mechanism.<br>
<br>
=A0 =A0 =A0 =A0Problem: multiple drivers will be resident that handle the<b=
r>
=A0 =A0 =A0 =A0same device type...and there is nothing user space hotplug<b=
r>
=A0 =A0 =A0 =A0infrastructure can do to help.<br>
<br></blockquote><div><br></div><div>Of note is that new_id doesn&#39;t wor=
k particularly well for platform devices. Before trying any of the other tw=
o solutions, a nasty hack was applied on the device tree used with the syst=
em in order to let vfio-platform match with a specific device, which is cer=
tainly not an acceptable solution.<br>

</div><div><br></div><div>Implementing wildcard matching quickly reveals th=
e problems mentioned, which motivates the other two approaches.<br></div><d=
iv>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">


=A0 =A02. =A0&quot;any id&quot; -- the vfio driver could specify a wildcard=
 match<br>
=A0 =A0 =A0 =A0of some kind in its ID match table which would allow it to<b=
r>
=A0 =A0 =A0 =A0match and bind to any possible device id. =A0However,<br>
=A0 =A0 =A0 =A0we don&#39;t want the vfio driver grabbing _all_ devices...j=
ust the ones we<br>
=A0 =A0 =A0 =A0explicitly want to pass to user space.<br>
<br>
=A0 =A0 =A0 =A0The proposed patch to support this was to create a new flag<=
br>
=A0 =A0 =A0 =A0&quot;sysfs_bind_only&quot; in struct device_driver. =A0When=
 this flag<br>
=A0 =A0 =A0 =A0is set, the driver can only bind to devices via the sysfs<br=
>
=A0 =A0 =A0 =A0bind file. =A0This would allow the wildcard match to work.<b=
r>
<br>
=A0 =A0 =A0 =A0Patch is here:<br>
=A0 =A0 =A0 =A0<a href=3D"https://lkml.org/lkml/2013/12/3/253" target=3D"_b=
lank">https://lkml.org/lkml/2013/12/3/253</a><br>
<br>
=A0 =A03. =A0&quot;Driver initiated explicit bind&quot; -- with this approa=
ch the<br>
=A0 =A0 =A0 =A0vfio driver would create a private &#39;bind&#39; sysfs obje=
ct<br>
=A0 =A0 =A0 =A0and the user would echo the requested device into it:<br>
<br>
=A0 =A0 =A0 =A0echo 0001:03:00.0 &gt; /sys/bus/pci/drivers/vfio-pci/vfio_bi=
nd<br>
<br>
=A0 =A0 =A0 =A0In order to make that work, the driver would need to call<br=
>
=A0 =A0 =A0 =A0driver_probe_device() and thus we need this patch:<br>
=A0 =A0 =A0 =A0<a href=3D"https://lkml.org/lkml/2014/2/8/175" target=3D"_bl=
ank">https://lkml.org/lkml/2014/2/8/175</a><br>
<br>
<br>
Would like your comment on these options-- option #3 is preferred<br>
and is literally a 2 line patch.<br></blockquote><div><br></div><div>I woul=
d definitely agree with approach #3, for which Kim has already provided a p=
atch. Not having this would make using VFIO with platform devices really in=
elegant and strange.<br>

</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks,<br>
Stuart<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>Antonios Motakis<br>Vir=
tual Open Systems
</div></div>

--047d7b5d3610984c2404f5895097--

--===============8558066464007294575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8558066464007294575==--
