From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [RFC PATCH v3 7/7] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Mon, 22 Sep 2014 12:22:26 +0300
Message-ID: <5834409.n6nGqbdKJT@avalon>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-8-git-send-email-will.deacon@arm.com>
	<20140922091934.GH1470@ulmo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7296105388498064766=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140922091934.GH1470@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============7296105388498064766==
Content-Type: multipart/signed; boundary="nextPart156822020.ggMBeqBzl4"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart156822020.ggMBeqBzl4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Monday 22 September 2014 11:19:35 Thierry Reding wrote:
> On Fri, Sep 12, 2014 at 05:34:55PM +0100, Will Deacon wrote:
> [...]
>=20
> > +static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_ba=
se, u64
> > size) +{
> > +=09struct dma_iommu_mapping *mapping;
> > +
> > +=09mapping =3D arm_iommu_create_mapping(dev->bus, dma_base, size);=

>=20
> If I understand correctly this will be called for each device that ha=
s
> an IOMMU master interface and will end up creating a new mapping for
> each of the devices. Each of these mappings will translate to a domai=
n
> in the IOMMU API, which in turn is a separate address space.
>=20
> How do you envision to support use-cases where a set of devices need =
to
> share a single domain? This is needed for example in DRM where SoCs
> often have a set of hardware blocks (each with its own master interfa=
ce)
> that compose the display device. On Tegra for example there are two
> display controllers that need access to the same IOVA domain so that
> they can scan out framebuffers.

Or simply for IOMMUs that serve multiple masters and support a single d=
omain=20
only.

=2D-=20
Regards,

Laurent Pinchart

--nextPart156822020.ggMBeqBzl4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUH+pYAAoJEIkPb2GL7hl18Q8H/34VwIwtgOZy5NwVnSSbPjKy
cW8rafXr98M7KpS1+QdDCiDK2HpEn9iz343ZxvmyMYgcX8Oj+j+Q82rzGwYcmmfC
dYjHiURPKE1jHM/1ntenGu505z9Tn2/p6gfvlp2shF51AHGiFLtjgehkZcHoaKuX
JFRBT/X4ljNBAkU/Ib1kz+lS7Hxm1+LNiDQvtqX2C5fz3QfCU69nOHbfZFoze1U7
Qrm/ZYNt3ArlOlwjjzvLhNnM2s8NjjjvFhUqDcCyMJN6FiyBPXfv1kem4OvXmhEy
vFdtkwsGQS1/LhR+z8p4dvAQGSxjornrk+Ydyy3pFwiiFOD+H3HMyTvA7wolZyc=
=eFMr
-----END PGP SIGNATURE-----

--nextPart156822020.ggMBeqBzl4--


--===============7296105388498064766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7296105388498064766==--
