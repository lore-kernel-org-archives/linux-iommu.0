From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 1/8] iommu: provide early initialisation hook for
	IOMMU drivers
Date: Fri, 5 Dec 2014 14:18:17 +0100
Message-ID: <20141205131815.GA18747@ulmo.nvidia.com>
References: <54805312.6000402@arm.com>
	<CACxGe6uR5J4Cjdh_xYhBPoQRgeYwHPv5=AnuRmQKSD3yZrMK9Q@mail.gmail.com>
	<54806504.20507@arm.com> <20141204144925.GB31464@ulmo.nvidia.com>
	<54809D09.2050406@arm.com>
	<CACxGe6tpFHdP1-5NWiNVAqzXx-diN1xfRbu0AQDyVJ6AU_4RXg@mail.gmail.com>
	<5480B924.2010205@arm.com> <20141205121037.GI1630@arm.com>
	<5481A688.4030606@arm.com>
	<CACxGe6vppOQj-hJnqEEtLwDuSr4bzcbTgEFj8=x4ULu=yxswpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7418810144733633594=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CACxGe6vppOQj-hJnqEEtLwDuSr4bzcbTgEFj8=x4ULu=yxswpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============7418810144733633594==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2014 at 01:06:52PM +0000, Grant Likely wrote:
> On Fri, Dec 5, 2014 at 12:35 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrot=
e:
> > Hi Will,
> >
> > On 05/12/14 12:10, Will Deacon wrote:
> > [...]
> >>>>
> >>>> Do you expect drivers to modify that *priv pointer after the ops
> >>>> structure is registered? I'd be very surprised if that was the use
> >>>> case. It's fine for the driver to register a non-const version, but
> >>>> once it is registered, the infrastructure can treat it as const from
> >>>> then on.
> >>>
> >>>
> >>> Possibly not - certainly my current port of the ARM SMMU which makes =
use
> >>> of *priv is only ever reading it - although we did also wave around
> >>> reasons for mutable ops like dynamically changing the pgsize_bitmap a=
nd
> >>> possibly even swizzling individual ops for runtime reconfiguration. On
> >>> consideration though, I'd agree that things like that are mad enough =
to
> >>> stay well within individual drivers if they did ever happen, and
> >>> certainly shouldn't apply to this bit of the infrastructure at any ra=
te.
> >>
> >>
> >> I certainly need to update the pgsize_bitmap at runtime because I don't
> >> know the supported page sizes until I've both (a) probed the hardware
> >> and (b) allocated page tables for a domain. We've already discussed
> >> moving the pgsize_bitmap out of the ops, but moving it somewhere where
> >> it remains const doesn't really help.
> >
> >
> > We can safely cast the call to get_ops in the SMMU driver though, since
> > we'll know that we put a mutable per-instance ops in there in the first
> > place. At least that way drivers that aren't taking advantage and just =
pass
> > their static const ops around shouldn't provoke warnings. I deliberately
> > didn't touch anything beyond get_ops as that would be too disruptive.
> >
> >> Can I just take the patch that Grant acked, in the interest of getting
> >> something merged? As you say, there's plenty of planned changes in this
> >> area anyway. I plan to send Olof a pull request this afternoon.
> >
> >
> > Grant, Thierry? Personally I'm not fussed either way - the sooner somet=
hing
> > goes in, the sooner I can carry on working at replacing it :D
>=20
> I've already acked it. Why are we still talking about it?  :-D

Am I missing something? Why is there a need to rush things? Are there
actually drivers that depend on this that will be merged during the 3.19
merge window? It seems like that'd be cutting it really close given
where we are in the release cycle.

If that's not the case, why even bother getting this hack into 3.19 if
nobody uses it and we're going to change it in 3.20 anyway?

Thierry

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUgbCXAAoJEN0jrNd/PrOhM6sP/iipNaat11ny3D4QxuAnfM85
6E2sFcJOVtNpRt/PKKwCqGrumy3bQobh93Hd7xU4/10Ef2YluLpnE904sq5u6Hyi
X0l6R29NDtLbjXUXWlq2iDKiYpHEHWeC85zmChPOI3XRcKU5KhyWA1cb63UUD2YZ
X/UDcXDsZl/j7aboEQI+O6F+fXqH7DVWXDXG/vt49IrjcEmO7AZMEgOewbc+zmke
0wv55SjWYYf3NPXmQRBMpgk1Kz0hDS3/vHZv787EvMSmQ1/GqOVYneq4kx/wRaz3
bmkEm6X5GRD+5rgQh4knV43ApJsVZiXhJ5QeFDEMWtdeRHJXgSyzvgGfAAK4pdtr
LfNxTyDDgyMZGQhlp1kMbsq54OiDoebzEzdvyKb7KMTEkcsE5rB6GKqR1OHJQlsz
YJwH/1BIoD/jtQl3QN/6goU9B+14OdEl+uqXUcYAxkh3DjjbW51Me6Zf9Bq2dt8i
keABe+TxeJ7ZZNmprPugX0YbOspzWEyIyWQWjlm+6RO1OH+/E4fUHBElMfGP5XsT
x2p/rdyncbxuKq6doKRyOLlWIhTBoQKzL0I2EJM8Roj9ZmHk/CMJGOwMs23gLocl
NTXjAfD91w8iSCdeztiKGOHYG/whj9iG0/BEQgW5cM+9GkcKmGIMK2f6ikgGSASi
jCVVi4DIp3IVrfpJsPKd
=p8zf
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

--===============7418810144733633594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7418810144733633594==--
