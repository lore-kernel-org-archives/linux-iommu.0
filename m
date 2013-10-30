From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Wed, 30 Oct 2013 23:41:09 +0100
Message-ID: <20131030224108.GA6939@mithrandir>
References: <20131024.122115.1035609747068925560.hdoyu@nvidia.com>
	<20131025001038.77299C403B6@trevor.secretlab.ca>
	<20131025075652.GB19622@ulmo.nvidia.com>
	<20131025.112549.2040849946958069337.hdoyu@nvidia.com>
	<20131025091104.GG19622@ulmo.nvidia.com>
	<52718122.9000206@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6242130081978548520=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52718122.9000206-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============6242130081978548520==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2013 at 03:58:58PM -0600, Stephen Warren wrote:
> On 10/25/2013 03:11 AM, Thierry Reding wrote:
> ...
> > So my proposed solution for the IOMMU case is to treat it the same
> > as any other resources. Perhaps resource isn't the right word, but
> > at the core the issue is the same. A device requires the services
> > of an IOMMU so that it can be put into the correct address space.
> > If the IOMMU is not available yet it cannot do that, so we simply
> > return -EPROBE_DEFER and cause the probe to be retried later.
>=20
> Personally, I view deferred probe as being used when one device
> requires either a resource /or/ a service provided by another, not
> /just/ when there's a resource dependency. Hence, I think it fits
> perfectly here.
>=20
> So I agree with Thierry: In other words, I think the solution is for
> all devices that are affected by an IOMMU to have a property such as:
>=20
> iommu =3D <&iommu_phandle iommu_specifier>;
>=20
> (and the DT node for the IOMMU will contain e.g. an #iommu-cells property)
>=20
> ... and for the driver to explicitly parse that property, and wait
> until the driver for iommu_phandle is ready. Exactly the same as any
> other resource/service dependency.
>=20
> That will solve all the problems.
>=20
> The only downside is that every driver needs to contain code to parse
> that property. However, I think that's just one function call; the
> actual implementation of that function can be unified somewhere inside
> core code in drivers/iommu/.

My earlier proposal for deferred interrupt reference resolution actually
tries to solve that problem within the core. Essentially what it does is
add a new function that gets called right before the driver's .probe()
function, so that it can parse standard resources and services from DT,
such as the interrupts property. This could theoretically be done for
other resources such as reg as well, but it really only matters where
the resource can be dynamic (as is the case for interrupts).

In this case I would envision a standard OF function to associate a
device with its IOMMU. Perhaps something like:

	int of_iommu_attach(struct device *dev);

That could be called by the core independent of the specific device and
IOMMU. IOMMU-specifics can probably be handled using .of_xlate(), quite
in a similar way to GPIO or regulators.

That way drivers can remain agnostic of the IOMMU while still being able
to take advantage of deferred probing.

Thierry

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScYsEAAoJEN0jrNd/PrOhPNwP/ibmJheoZvtqXlRiu0u2nynA
vzhiKaJrOsL5LbSVa+F9IAmjX8CJkvSl/WzrKWRSeSgkUmvSterOFrkEQWnRtfP/
t74mXFBTiATcm81BZcUk9PXKBCjFIE3VwiwIT6/IpVvrjcDv27R3S2tAbk+hPtdc
jqz9Je3HSufMHAr0CNUHrhi/IlZrBzZaXIkyV19IQZAdryP5tiBaLUUOtmTYgA6Y
vLOlhtz/M9zlO3sx/GKosR77fM6bQoykN2ouVu3LDpOBuilB2zxaz52jxnglaDBZ
lDUJap6LxlMGovTg2WhsYy8EpdB9mTiDPHq65xWZujYbbJ5JYwNnBpNpYCNZZaSz
oOw1nom+QMafzmaYqIVn/VVctVcLnPq7JcHV7LBsK2bVqNRoSPM65Ufj3Hdww+wY
ZDoF6blxF0tYGPMEWm28qYe4TTAnax2R7Xl0koC+5YQg3lc8IxtdVtSfB98vT32D
WYVj5UhRT0D9OEpPQZokpKJeEdjY7I7jsEvxigLOfGJm8dR9mB84jgfAFctJN21D
e7OCPJvNpLeO0eGs16aPoB+6lVuzwZE0aJFTT9q+BrfziWkjtlgFNXXvcxKVysOS
E/jJom++d2M2Dktyr5VJjeCIk37b6Hpr4fD2krEAUixT3d8CxIQCDOyo1EB4FDaL
Yj/SZqpXVQgbeW50NzLn
=6oOF
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============6242130081978548520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6242130081978548520==--
