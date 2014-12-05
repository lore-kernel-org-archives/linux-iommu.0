From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 1/8] iommu: provide early initialisation hook for
	IOMMU drivers
Date: Fri, 5 Dec 2014 14:31:57 +0100
Message-ID: <20141205133156.GA25699@ulmo.nvidia.com>
References: <54806504.20507@arm.com> <20141204144925.GB31464@ulmo.nvidia.com>
	<54809D09.2050406@arm.com>
	<CACxGe6tpFHdP1-5NWiNVAqzXx-diN1xfRbu0AQDyVJ6AU_4RXg@mail.gmail.com>
	<5480B924.2010205@arm.com> <20141205121037.GI1630@arm.com>
	<5481A688.4030606@arm.com>
	<CACxGe6vppOQj-hJnqEEtLwDuSr4bzcbTgEFj8=x4ULu=yxswpg@mail.gmail.com>
	<20141205131815.GA18747@ulmo.nvidia.com>
	<CACxGe6vqstoCBiJ7TLvhNt+40TUJRB2ORoRKKtorhM-ETHXu0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7719830411248275186=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CACxGe6vqstoCBiJ7TLvhNt+40TUJRB2ORoRKKtorhM-ETHXu0A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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


--===============7719830411248275186==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 05, 2014 at 01:21:31PM +0000, Grant Likely wrote:
> On Fri, Dec 5, 2014 at 1:18 PM, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
 wrote:
> > On Fri, Dec 05, 2014 at 01:06:52PM +0000, Grant Likely wrote:
> >> On Fri, Dec 5, 2014 at 12:35 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> w=
rote:
> >> > Hi Will,
> >> >
> >> > On 05/12/14 12:10, Will Deacon wrote:
> >> > [...]
> >> >>>>
> >> >>>> Do you expect drivers to modify that *priv pointer after the ops
> >> >>>> structure is registered? I'd be very surprised if that was the use
> >> >>>> case. It's fine for the driver to register a non-const version, b=
ut
> >> >>>> once it is registered, the infrastructure can treat it as const f=
rom
> >> >>>> then on.
> >> >>>
> >> >>>
> >> >>> Possibly not - certainly my current port of the ARM SMMU which mak=
es use
> >> >>> of *priv is only ever reading it - although we did also wave around
> >> >>> reasons for mutable ops like dynamically changing the pgsize_bitma=
p and
> >> >>> possibly even swizzling individual ops for runtime reconfiguration=
=2E On
> >> >>> consideration though, I'd agree that things like that are mad enou=
gh to
> >> >>> stay well within individual drivers if they did ever happen, and
> >> >>> certainly shouldn't apply to this bit of the infrastructure at any=
 rate.
> >> >>
> >> >>
> >> >> I certainly need to update the pgsize_bitmap at runtime because I d=
on't
> >> >> know the supported page sizes until I've both (a) probed the hardwa=
re
> >> >> and (b) allocated page tables for a domain. We've already discussed
> >> >> moving the pgsize_bitmap out of the ops, but moving it somewhere wh=
ere
> >> >> it remains const doesn't really help.
> >> >
> >> >
> >> > We can safely cast the call to get_ops in the SMMU driver though, si=
nce
> >> > we'll know that we put a mutable per-instance ops in there in the fi=
rst
> >> > place. At least that way drivers that aren't taking advantage and ju=
st pass
> >> > their static const ops around shouldn't provoke warnings. I delibera=
tely
> >> > didn't touch anything beyond get_ops as that would be too disruptive.
> >> >
> >> >> Can I just take the patch that Grant acked, in the interest of gett=
ing
> >> >> something merged? As you say, there's plenty of planned changes in =
this
> >> >> area anyway. I plan to send Olof a pull request this afternoon.
> >> >
> >> >
> >> > Grant, Thierry? Personally I'm not fussed either way - the sooner so=
mething
> >> > goes in, the sooner I can carry on working at replacing it :D
> >>
> >> I've already acked it. Why are we still talking about it?  :-D
> >
> > Am I missing something? Why is there a need to rush things? Are there
> > actually drivers that depend on this that will be merged during the 3.19
> > merge window? It seems like that'd be cutting it really close given
> > where we are in the release cycle.
> >
> > If that's not the case, why even bother getting this hack into 3.19 if
> > nobody uses it and we're going to change it in 3.20 anyway?
>=20
> I also acked the non-hack version, the patch that doesn't try to make
> everything const. I assumed that was the one that we are talking about
> merging.

Actually not making everything const would be a hack. Drivers already
mark their struct iommu_ops as const.

But I'm more referring to the series as a whole. It seems like there are
various issues that still need to be ironed out, and there's committment
to do that before 3.20, so unless there are drivers that need any of the
unfinished patches for 3.19 I don't see why we should be merging them in
the first place.

If getting them into 3.19 is merely to resolve dependencies then it's
not going to work well anyway. Since this is all going to change in 3.20
anyway we'd likely have new dependencies that need to be handled, so
might just as well do it properly at that time.

Thierry

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUgbPMAAoJEN0jrNd/PrOhBogP/jB93qlvmsI2OrNLDBZqmeVP
rfFHPMeidTIuaepl6NK83uR7oeaj9yzSPUAFpxzLQbJ5f/kNKk32a/LVQo4r2p7u
ALo0QWy+AjV74HskIx7rZxIU5SBee/xXxBdDfMeFw7hGnBEk8gUGflPlOb3+gwZW
J81C+n8uWKvh6RA9ir03tKHI6Sv5sviCNnvcCmdyKGCcwkV29Ncqw/T/+RidhCxF
hbQHOFYAQ3n+E0obkDf3YgylUv7xwRkdn0lWHUtdOeGkldRjIBZQ2RL/4esm2Atq
7pu7g/0fBTGyia90mSjH9uUEtNHMhWwAZUTLKJiACvPkdVafI3UWn8QOREJVBnuy
CVi+xT7x4fhiU+KiFxmrW9+aKJ1TBl1ZssT5PZaz5jhuNY0Dl7YMkWK07PlaWcq/
/ipk8q5Gn0QXFYvK8+bvfPeSpGt8k1KPln7P4IBWd+5t0J3FhMwvThW0KoCw8NsD
e8QtIAkFv+8J5UNDcx8Ms0RJSEM+qyD0eGDNlLbica8y4hdME1mH7BwnjWiTT+dW
ywGRHPCxRp+EocBJ85zFxsXee0J4VZhBE8h+Wn64Rkbi0La/37lzSQHC9uacVQJb
FuqpgpM75VCRJvnsmuvpL43Bhuan+ZAmCjgCSeyaR0eTAr+DiKsYNp2Wsqz1j3hV
FOIPoHIuAeEvrkRD6G6r
=ELuk
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

--===============7719830411248275186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7719830411248275186==--
