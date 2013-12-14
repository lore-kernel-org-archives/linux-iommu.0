From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv7 04/12] driver/core: populate devices in order for IOMMUs
Date: Sat, 14 Dec 2013 13:24:22 +0100
Message-ID: <20131214122421.GB17467@mithrandir>
References: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
 <1386835033-4701-5-git-send-email-hdoyu@nvidia.com>
 <20131212113920.70E8BC40637@trevor.secretlab.ca>
 <20131213021402.GB14192@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131213021402.GB14192-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 06:14:02PM -0800, Greg KH wrote:
> On Thu, Dec 12, 2013 at 11:39:20AM +0000, Grant Likely wrote:
> > On Thu, 12 Dec 2013 09:57:05 +0200, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wro=
te:
> > > IOMMU devices on the bus need to be poplulated first, then iommu
> > > master devices are done later.
> > >=20
> > > With CONFIG_OF_IOMMU, "iommus=3D" DT binding would be used to identify
> > > whether a device can be an iommu msater or not. If a device can, we'll
> > > defer to populate that device till an iommu device is populated. Then,
> > > those deferred iommu master devices are populated and configured with
> > > help of the already populated iommu device.
> > >=20
> > > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> > > ---
> > > This is related to the following discussion:
> > >   [RFC PATCH] Documentation: devicetree: add description for generic =
bus properties
> > >   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November=
/215042.html
> > >=20
> > > v6:
> > > Spinned off only driver core part from:
> > >   [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
> > >=20
> > > v5:
> > > Use "iommus=3D" binding instread of arm,smmu's "#stream-id-cells".
> > >=20
> > > v4:
> > > This is newly added, and the successor of the following RFC:
> > >   [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
> > >   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/0069=
14.html
> > >=20
> > > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > ---
> > >  drivers/base/dd.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > index 0605176..0605f52 100644
> > > --- a/drivers/base/dd.c
> > > +++ b/drivers/base/dd.c
> > > @@ -25,6 +25,7 @@
> > >  #include <linux/async.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/pinctrl/devinfo.h>
> > > +#include <linux/of_iommu.h>
> > > =20
> > >  #include "base.h"
> > >  #include "power/power.h"
> > > @@ -273,6 +274,10 @@ static int really_probe(struct device *dev, stru=
ct device_driver *drv)
> > > =20
> > >  	dev->driver =3D drv;
> > > =20
> > > +	ret =3D of_iommu_attach(dev);
> > > +	if (ret)
> > > +		goto probe_failed;
> > > +
> >=20
> > As discussed before, I really don't think hooking in to dd.c is the
> > right thing to do here, and certainly not as a device tree specific
> > function. ACPI or PCI described devices may have the same constraints
> > and those won't have DT descriptions.
>=20
> I agree, this shouldn't be in the driver core.

Okay, so what would be an alternative? Grant's objection makes sense and
we could easily just wrap the call to of_iommu_attach() within a generic
iommu_attach() that could decide at runtime which exact implementation
to call, depending on whether the device is DT, ACPI, PCI or whatnot.

If we don't want something like that in the core either, then the only
other alternative would be to call this from each driver. However given
the desire to handle IOMMUs completely transparently for device drivers
that would be missing the point.

Perhaps moving this into platform_drv_probe() would be more acceptable?
That's still somewhat core, but maybe suburban enough.

Thierry

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSrE31AAoJEN0jrNd/PrOhTFAQAJwhB7d45pZi7mbXjE0KNNu+
emxJSt0KyCxhOF1KhuFyQm5AiCTheujCh09fPArF7gpC//dMS5inXcJA4Fw6XZ7X
DE3TwgKFuWrYa5VVApog4NASPa492h5yeUoKgI0o6IOsb4VtXuayalHv3Frlu1We
y2Te9j0j31dM9bFbFCkY7lOwIKPlEkyJXG3Lo/QsPRrFo59KZ+oDUOoahfZnugfM
YVWZvSiZKbxalMKzY0NnQTlIkmcIVzRRPKHTBwByUHSntBP4XnaEtoLC2b9dAB5C
MjQCMcKvH9eMJ4ikW/ghrHSuD/mdJq+dpOf/xCUF1mrb/A794IiHPT3+5hLwyC5A
MHklNssE9ymxK3Issrrff4fqSmi2gIYul/PIKblT3ZWjEJQsIYj4EZ4noHeKtYez
emgIHusxz3j8W7+ETvAibngQPnPOqfPW+8py+mdGyjWp7Yu/XBL3tBXrUyCUh8/j
8VOl/lpSA8nJKG/4S1+wQwo0FGe0FUXImZW23uT918aW6bL2zz/IxjA11ldZnNVt
1DUexQ7LpAJPyJcE5bBWujcUOhrwlEr7Ueu6kMrT+Rj5Km+tOFyYAxvl/vi6tHJ3
AZNwMaMSWHm0qpauCn6Rsj7DWox17oZV7PoN81LazIp59e3ppTmbxOMaaci8ZW7l
2cmGwRTaNqan+kiBeASC
=hL7S
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
