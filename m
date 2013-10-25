From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 25 Oct 2013 09:56:55 +0200
Message-ID: <20131025075652.GB19622@ulmo.nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
	<1382092020-13170-2-git-send-email-hdoyu@nvidia.com>
	<20131024085531.680A4C4039D@trevor.secretlab.ca>
	<20131024.122115.1035609747068925560.hdoyu@nvidia.com>
	<20131025001038.77299C403B6@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8986220187826947549=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131025001038.77299C403B6-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============8986220187826947549==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 01:10:38AM +0100, Grant Likely wrote:
> On Thu, 24 Oct 2013 11:21:15 +0200, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > Hi Grant,
> >=20
> > Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote @ Thu, 24 Oct 2013 10:55:3=
1 +0200:
> > ....
> > > > diff --git a/include/linux/of.h b/include/linux/of.h
> > > > index f95aee3..638a88a 100644
> > > > --- a/include/linux/of.h
> > > > +++ b/include/linux/of.h
> > > > @@ -60,6 +60,7 @@ struct device_node {
> > > >  	struct	kref kref;
> > > >  	unsigned long _flags;
> > > >  	void	*data;
> > > > +	struct device *dev;		/* Set only after populated */
> > >=20
> > > Is this being used merely to indicate that a device has been processed
> > > by of_platform_device_create()? Or do you intend to dereference this
> > > pointer? I've avoided putting the struct device in to the device_node
> > > structure up to this point simply becuase there aren't any good clues
> > > for what /kind/ of device it actually points to. I worry that bad
> > > assumptions will get made when other subsystems try to use the
> > > same pointer. ie. if one subsystem creates its own device and sets th=
is
> > > pointer, and then of_platform_device_create() comes along behind, sees
> > > that it is already created, and then returns a platform_device pointer
> > > *for something that isn't a struct platform_device*. This is very bad.
> > >=20
> > > Instead of using a pointer to the struct device, would a flag be
> > > sufficient for your purposes? Would it be fine to return NULL if the
> > > device has already been created?
> >=20
> > Yes, a flag would be enough for this purpose.
> >=20
> > This patch is a part of HACK to control device instanciation order. We
> > have an IOMMU device(platform) which needs to be instanciated earlier
> > than other (platform)devices so that IOMMU driver would configure them
> > as IOMMU'able device.
>=20
> Ideally the drivers depending on the IOMMU would return -EPROBE_DEFER if
> the IOMMU driver isn't set up so that you don't need to play games with
> probe order. Creating certain platform devices early is a really ugly
> and fragile solution.
>=20
> Besides, probe order of device drivers is far more about link order of
> the kernel than it is about when of_platform_device_create() is called.
> Fiddling with the initcall level on the IOMMU driver (while not
> recommended) may very well have the effect you desire.

This is actually "the other problem that I'm aware of that could benefit
=66rom [interrupt resolution at probe time]". My idea was that once we had
a way within the driver core to resolve interrupt references at probe
time it could be used for potentially many other resources as well. Some
of the resources like GPIOs and regulators are obviously not something
that the core can or should be requesting, but mostly resources that you
don't actually need to control after probing (such as interrupts) would
be a good fit because otherwise people would write the same boilerplate
over and over again.

IOMMUs seem to me to be in that same category. As far as I can tell, an
IOMMU driver registers the IOMMU for a given bus, upon which every
device can simply be used (mostly transparently) with that IOMMU. While
I haven't figured out how exactly, I'm pretty sure we can take advantage
of the resolution of resources at probe time within the core to both
keep drivers from having to do anything in particular and at the same
time have code to determine if the IOMMU driver hasn't been probed yet
and return -EPROBE_DEFER appropriately.

I suspect that there will be enough differences between the various
IOMMU implementations that we won't be able to have a unified binding
(especially for how to associate devices with a particular virtual
address space), but perhaps that could be solved with something like an
=2Eof_xlate() that IOMMU drivers implement, much like we've done with most
other subsystems too.

The binding for Tegra's IOMMU currently only uses the HW IDs (or a mask)
to put a device into a given address space, but I think that could be
easily extended to something like:

	memory-clients =3D <&iommu MASK>;

Or similar. If other information is required, we could encode that into
a multi-cell specifier. Perhaps we could even leave away the phandle
since typically there will only be a single IOMMU in the system?

Does that sound reasonable? Hiroshi is much more familiar with IOMMUs,
so I'd like to get his opinion on the above as well.

Grant, I wonder if it might be more useful if I concentrate on solving
this problem first, before tackling the interrupt reference resolution.
I expect this to be able to use the same core functionality, so it could
be used as a less invasive means of introducing some pieces we can later
reuse. Also this only adds new functionality and doesn't touch anything
that currently works, so there's less (i.e. no) risk of breaking any
existing functionality.

Thierry

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaiREAAoJEN0jrNd/PrOhxosP/jGIA1Cudv8Bft1t+kugMW3J
xSOTVBMB1LTNM0eD9fKtEdSgwVE6+1/xTBJtOd3LeLE9P0SpFQVi98k8B5cTXI++
i9B2Pn+a9ndbibQ4KZ5GCbeS0Ai6E2QMhtOCqJx8YvTSxxykf0zDDQG6FOIIaCpA
QinTPlzrGj23Kp7vaRaT0jgB7mxpwZf7cY60FPILVbU+R7Akw16EdDuLj3fTouvW
VS+lcJ1MLhmZevJ2cntjFIg3ShMeFaFd61lRPBQiPuoRAlWYRTkYr10ejejKq4WO
ZuxP0WwIyCwnB+YNvAfEguHbLKxNzG1m+hEdoRmRR8xDfqE3FYVeZSbEalPNZpxj
SWaaxtZQvaTjmO/3yu8S90lFFdXKusJ5aqgqGdhAtk9CPqKFeEoVHKlukQ57kW2c
+2u9Pujju/0uOynmLsLXXnHoCEzAWu/Fgjkmn9Hkj3Lc2ayXEWBcKTO0rJCgRKNX
oukMKwoUxSRvcQ9bykKihir0r7i4MHOnJpHQOmdwEDGVcQ4CSkiGLtnHeDkiDOLW
XpCYo+wT5SJN2dce/4F5gRWkPtadad+/k4+phMBuMny1Jo1LW1JyhChDcaSr35HK
//YJ7zLh6zoDIk600VX3c3WGoFSki70NJj6MtAXwQ6jmTNjvVCBxB7gKnsyGn3Il
jrI5+Z6QH/qCqGEDo6iv
=OCj4
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--

--===============8986220187826947549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8986220187826947549==--
