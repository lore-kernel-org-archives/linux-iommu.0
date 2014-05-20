From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Tue, 20 May 2014 15:17:43 +0200
Message-ID: <20140520131741.GB6240@ulmo>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<10711669.TTjp9L4tTG@wuerfel> <20140520120242.GA20995@ulmo>
	<8663464.40PHEumOar@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5289394219679310704=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8663464.40PHEumOar@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============5289394219679310704==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2014 at 02:41:18PM +0200, Arnd Bergmann wrote:
> On Tuesday 20 May 2014 14:02:43 Thierry Reding wrote:
[...]
> > Couldn't a single-master IOMMU be windowed?
>=20
> Ah, yes. That would actually be like an IBM pSeries, which has a windowed
> IOMMU but uses one window per virtual machine. In that case, the window c=
ould
> be a property of the iommu node though, rather than part of the address
> in the link.

Does that mean that the IOMMU has one statically configured window which
is the same for each virtual machine? That would require some other
mechanism to assign separate address spaces to each virtual machine,
wouldn't it? But I suspect that if the IOMMU allows that it could be
allocated dynamically at runtime.

> > Multiple-master IOMMU with fixed associations:
> > ----------------------------------------------
> >=20
> > 	/* multiple-master IOMMU */
> > 	iommu {
> > 		/*
> > 		 * Masters are statically associated with this IOMMU and
> > 		 * address translation is always enabled.
> > 		 */
> > 		#iommu-cells =3D <0>;
> > 	};
>=20
> copied wrong? I guess you mean #address-cells=3D<0>/#size-cells=3D<0> her=
e.

Yes, I obviously wasn't careful when I copied this over.

> > Multiple-master device:
> > -----------------------
> >=20
> > 	/* single-master IOMMU */
> > 	iommu@1 {
> > 		reg =3D <1>;
> > 		#address-cells =3D <0>;
> > 		#size-cells =3D <0>;
> > 	};
> >=20
> > 	/* multiple-master IOMMU */
> > 	iommu@2 {
> > 		reg =3D <2>;
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <0>;
> > 	};
> >=20
> > 	/* device with two master interfaces */
> > 	master {
> > 		iommus =3D <&/iommu@1>,    /* master of the single-master IOMMU */
> > 			 <&/iommu@2 42>; /* ID 42 in multiple-master IOMMU */
> > 	};
[...]
> > Does that sound about right?
>=20
> Yes, sounds great. I would probably leave out the Multiple-master device
> from the examples, since that seems to be a rather obscure case.

Agreed. We can easily add such examples if/when such device start to
appear.

> I would like to add an explanation about dma-ranges to the binding:
>=20
> 8<--------
> The parent bus of the iommu must have a valid "dma-ranges" property
> describing how the physical address space of the IOMMU maps into
> memory.

With physical address space you mean the addresses after translation,
not the I/O virtual addresses, right? But even so, how will this work
when there are multiple IOMMU devices? What determines which IOMMU is
mapped via which entry?

Perhaps having multiple IOMMUs implies that there will have to be some
partitioning of the parent address space to make sure two IOMMUs don't
translate to the same ranges?

> A device with an "iommus" property will ignore the "dma-ranges" property
> of the parent node and rely on the IOMMU for translation instead.

Do we need to consider the case where an IOMMU listed in iommus isn't
enabled (status =3D "disabled")? In that case presumably the device would
either not function or may optionally continue to master onto the parent
untranslated.

> Using an "iommus" property in bus device nodes with "dma-ranges"
> specifying how child devices relate to the IOMMU is a possible extension
> but is not recommended until this binding gets extended.

Just for my understanding, bus device nodes with iommus and dma-ranges
properties could be equivalently written by explicitly moving the iommus
properties into the child device nodes, right? In which case they should
be the same as the other examples. So that concept is a convenience
notation to reduce duplication, but doesn't fundamentally introduce any
new concept.

Thierry

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe1X1AAoJEN0jrNd/PrOhw2AP/0kYSab+pFlzjCheuDxcxTfO
il6uxOSKaRyYRnFp76OURJC6ZIFf8ECGL6D9V2hRcuk2RRxF2FuBASfd4++fX9dK
glub917sELunRZR0gGMNExNifZ4Io5Qsrj7EeiQl+0ihy90BpD0QMf6BEABAgB0t
U4AEIvRDySzMqu1/Ir5+bs7j2iTVcUWSm4XX4Jbx1aiy2qChw+6kIThhXMo8VQdi
rq48CFwdDOf4jSMAu34IcodFrU9LF1LnKOL038OpFvWLlNJlWT5wkkLIDXSUq0d0
vOjVCdq0iQek7h4Gv1HqfNiv9By4urSLQ1yUVMyEhCVR6uSJuETi7kBD0b5kCBJ5
O3xipNMsZrwMw9HlLQlw4M7ryrmOQHsAt2H2rJvTW7syyoCgKmOX9G6SDsIwlYI3
VLU9njysqsOy3GKtXoUSLREEZZtPjkAP8hulTuqsUepsFk3+o6kD2OL0IG28mOQl
jeD+bSGpuXlTwjhyfJCSvITbF2F90IX4lHS9dbcPOnAuzxoH5DghyWj5o2zgkxLz
tJJz/SWqs6B6y1FV3ELz5QW9iXUM/2U4bBTNW4or+y48XuF+ylIczG1dq1niu5VC
76yhfrJLvGUi9vZR4uLnwH/Y8lUgYRmbn0YP5pEg20px/iviT6M02ieJhlRMR0ZG
4JeRke89T0UhHrMA7o0V
=Y3iW
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

--===============5289394219679310704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5289394219679310704==--
