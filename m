From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
	helpers
Date: Tue, 18 Sep 2018 23:26:38 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19130EAD7@SHSMSX101.ccr.corp.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
	<20180830040922.30426-9-baolu.lu@linux.intel.com>
	<c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
	<a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
	<04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D191300D35@SHSMSX101.ccr.corp.intel.com>
	<c285871d-2ea0-5878-c7ac-ffa4ba8256ee@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D191305A74@SHSMSX101.ccr.corp.intel.com>
	<f46bcf5f-002b-4269-a750-c4254c9fc89f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f46bcf5f-002b-4269-a750-c4254c9fc89f-5wv7dgnIgG8@public.gmane.org>
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti
	Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Bie, Tiwei" <tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kumar, Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org]
> Sent: Tuesday, September 18, 2018 11:52 PM
> =

> On 15/09/2018 03:36, Tian, Kevin wrote:
> >> 4) Userspace opens another mdev.
> >> -> iommu.c calls domain->ops->attach_dev(domain2, dev)
> >
> > another mdev in same VFIO container or different? I assume the
> > latter since you mentioned a new domain2.
> =

> I was thinking a different VFIO container actually. I used domain2 to
> try to make the example clearer
> =

> >> 1)? When the container is closed, VFIO calls
> >> iommu_detach_device(domain2, parent_dev)
> >> -> iommu.c calls default_domain->ops->attach_dev(default_domain,
> dev)
> >> Given that auxiliary domains are attached, the IOMMU driver could
> deduce
> >> that this actually means "detach an auxiliary domain". But which one?
> >
> > I didn't get this one. There is no need to stick to 1) behavior for
> > 4), i.e. below is expected:
> > =A0=A0=A0=A0=A0=A0=A0 domain2->ops->detach_dev(domain2, dev)
> =

> But in order to get that, the IOMMU core needs to know that domain2 is
> auxiliary. Otherwise, detach_dev is never called when a default_domain
> is present for the parent dev.
> =

> I guess one solution is to add an "auxiliary" attribute to iommu_domain,
> so __iommu_detach_group would do something like:

this doesn't work. same domain can be also attached to another physical
device as non-aux domain (e.g. passthrough) at the same time (vfio-pci
device and vfio-mdev device in same container), then default domain =

tweak is required in that case. "aux" takes effect only per-device, not =

per-domain.

> =

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 7113fe398b70..2b3e9b91aee7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1786,10 +1786,11 @@ static void __iommu_detach_group(struct
> iommu_domain *domain,
>  {
>  	int ret;
> =

> -	if (!group->default_domain) {
> +	if (!group->default_domain || domain->auxiliary) {
>  		__iommu_group_for_each_dev(group, domain,
>  					   iommu_group_do_detach_device);
> -		group->domain =3D NULL;
> +		if (!domain->auxiliary)
> +			group->domain =3D NULL;
>  		return;
>  	}
> =

> Not sure who would set this "auxiliary" attribute... Maybe the IOMMU
> driver, when attaching the domain to a device that has auxiliary mode
> enabled?
> =

> > why cannot ARM implement a detach_dev for aux_domain too? My
> > feeling is that default domain twist is only for switch between 1/2/3
> > in concept.
> =

> If the core actually calls it, we can implement detach_dev :) The
> problem is that the core never calls detach_dev when default_domain is
> present (affects any IOMMU driver that relies on default_domain,
> including AMD), and even in case 4) the default_domain is present for
> the parent device

Then can we change that core logic so detach_dev is invoked in all
cases? yes there will be some changes in vendor drivers, but I expect
this change trivial (especially considering the gain in IOMMU API
simplicity side as described below).

> =

> >> So the proposed interface doesn't seem to work as is. If we want to use
> >> iommu_attach/detach_device for auxiliary domains, the existing
> behavior
> >> of iommu.c, and IOMMU drivers that rely on it, have to change. Any
> >> change I can think of right now seems more daunting than introducing a
> >> different path for auxiliary domains, like iommu_attach_aux_domain for
> >> example.
> >>
> >
> > introducing *aux* specific API will cause different VFIO code path to
> > handle RID-based and PASID-based mdev, since RID-based still needs
> > to use normal attach_domain that way.
> =

> The PASID-based mdev still requires a special case to retrieve the
> allocated PASID and program it in the parent device, so VFIO will need
> to know the difference between the two
> =


that retrieve/program is down by parent driver, instead of VFIO.

Thanks
Kevin
