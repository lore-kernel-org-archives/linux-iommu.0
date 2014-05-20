From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Tue, 20 May 2014 14:02:43 +0200
Message-ID: <20140520120242.GA20995@ulmo>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<5759340.gycj7cP1t3@wuerfel> <20140520110536.GA10302@ulmo>
	<10711669.TTjp9L4tTG@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2261608275536795131=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <10711669.TTjp9L4tTG@wuerfel>
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


--===============2261608275536795131==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2014 at 01:15:48PM +0200, Arnd Bergmann wrote:
> On Tuesday 20 May 2014 13:05:37 Thierry Reding wrote:
> > On Tue, May 20, 2014 at 12:04:54PM +0200, Arnd Bergmann wrote:
> > > On Monday 19 May 2014 22:59:46 Thierry Reding wrote:
> > > > On Mon, May 19, 2014 at 08:34:07PM +0200, Arnd Bergmann wrote:
[...]
> > > > > You should never need #size-cells > #address-cells
> > > >=20
> > > > That was always my impression as well. But how then do you represen=
t the
> > > > full 4 GiB address space in a 32-bit system? It starts at 0 and end=
s at
> > > > 4 GiB - 1, which makes it 4 GiB large. That's:
> > > >=20
> > > > 	<0 1 0>
> > > >=20
> > > > With #address-cells =3D <1> and #size-cells =3D <1> the best you ca=
n do is:
> > > >=20
> > > > 	<0 0xffffffff>
> > > >=20
> > > > but that's not accurate.
> > >=20
> > > I think we've done both in the past, either extended #size-cells or
> > > taken 0xffffffff as a special token. Note that in your example,
> > > the iommu actually needs #address-cells =3D <2> anyway.
> >=20
> > But it needs #address-cells =3D <2> only to encode an ID in addition to
> > the address. If this was a single-master IOMMU then there'd be no need
> > for the ID.
>=20
> Right. But for a single-master IOMMU, there is no need to specify
> any additional data, it could have #address-cells=3D<0> if we take the
> optimization you suggested.

Couldn't a single-master IOMMU be windowed?

> > I'm not sure I understand the need for 0x100 (all IDs) entry above. If
> > bus1's iommus property applies to all devices on the bus, why can't the
> > ID 0xb be listed in the iommus property?
> >=20
> > 	bus1 {
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <1>;
> > 		ranges;
> > 		iommus =3D <&{/iommu} 0xb 0  0x1 0x0>; // 4GB ID '0xb'
> > 		dma-ranges =3D <0  0xb 0  0x1 0x0>;
> >=20
> > 		anothermaster {
> > 			...
> > 		};
> > 	};
>=20
> It depends on how the address is interpreted, but we could make this
> a valid case too.
>=20
> > In which case I guess dma-ranges would be redundant.
>=20
> No, because the iommus property doesn't translate the address range, it
> just creates a new address space. bus1 and iommu in the example have
> different #address-cells, so you definitely need a non-empty ranges
> property.

Ah, now I get it.

> > > The main advantage I think would be for IOMMUs that use the PCI b/d/f
> > > numbers as IDs. These can have #address-cells=3D<3>, #size-cells=3D<2>
> > > and have an empty dma-ranges property in the PCI host bridge node,
> > > and interpret this as using the same encoding as the PCI BARs in
> > > the ranges property.
> >=20
> > I'm somewhat confused here, since you said earlier:
> >=20
> > > After giving the ranges stuff some more thought, I have come to the
> > > conclusion that using #iommu-cells should work fine for almost
> > > all cases, including windowed iommus, because the window is not
> > > actually needed in the device, but only in the iommu, wihch is of cou=
rse
> > > free to interpret the arguments as addresses.
> >=20
> > But now you seem to be saying that we should still be using the
> > #address-cells and #size-cells properties in the IOMMU node to determine
> > the length of the specifier.
>=20
> I probably wasn't clear. I think we can make it work either way, but
> my feeling is that using #address-cells/#size-cells gives us a nicer
> syntax for the more complex cases.

Okay, so in summary we'd have something like this for simple cases:

Required properties:
--------------------
- #address-cells: The number of cells in an IOMMU specifier needed to encode
  an address.
- #size-cells: The number of cells in an IOMMU specifier needed to represent
  the length of an address range.

Typical values for the above include:
- #address-cells =3D <0>, size-cells =3D <0>: Single master IOMMU devices a=
re not
  configurable and therefore no additional information needs to be encoded =
in
  the specifier. This may also apply to multiple master IOMMU devices that =
do
  not allow the association of masters to be configured.
- #address-cells =3D <1>, size-cells =3D <0>: Multiple master IOMMU devices=
 may
  need to be configured in order to enable translation for a given master. =
In
  such cases the single address cell corresponds to the master device's ID.
- #address-cells =3D <2>, size-cells =3D <2>: Some IOMMU devices allow the =
DMA
  window for masters to be configured. The first cell of the address in this
  may contain the master device's ID for example, while the second cell cou=
ld
  contain the start of the DMA window for the given device. The length of t=
he
  DMA window is specified by two additional cells.

Examples:
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Single-master IOMMU:
--------------------

	iommu {
		#address-cells =3D <0>;
		#size-cells =3D <0>;
	};

	master {
		iommus =3D <&/iommu>;
	};

Multiple-master IOMMU with fixed associations:
----------------------------------------------

	/* multiple-master IOMMU */
	iommu {
		/*
		 * Masters are statically associated with this IOMMU and
		 * address translation is always enabled.
		 */
		#iommu-cells =3D <0>;
	};

	/* static association with IOMMU */
	master@1 {
		reg =3D <1>;
		iommus =3D <&/iommu>;
	};

	/* static association with IOMMU */
	master@2 {
		reg =3D <2>;
		iommus =3D <&/iommu>;
	};

Multiple-master IOMMU:
----------------------

	iommu {
		/* the specifier represents the ID of the master */
		#address-cells =3D <1>;
		#size-cells =3D <0>;
	};

	master {
		/* device has master ID 42 in the IOMMU */
		iommus =3D <&/iommu 42>;
	};

Multiple-master device:
-----------------------

	/* single-master IOMMU */
	iommu@1 {
		reg =3D <1>;
		#address-cells =3D <0>;
		#size-cells =3D <0>;
	};

	/* multiple-master IOMMU */
	iommu@2 {
		reg =3D <2>;
		#address-cells =3D <1>;
		#size-cells =3D <0>;
	};

	/* device with two master interfaces */
	master {
		iommus =3D <&/iommu@1>,    /* master of the single-master IOMMU */
			 <&/iommu@2 42>; /* ID 42 in multiple-master IOMMU */
	};

Multiple-master IOMMU with configurable DMA window:
---------------------------------------------------

	/ {
		#address-cells =3D <1>;
		#size-cells =3D <1>;

		iommu {
			/* master ID, address of DMA window */
			#address-cells =3D <2>;
			#size-cells =3D <2>;
		};

		master {
			/* master ID 42, 4 GiB DMA window starting at 0 */
			iommus =3D <&/iommu  42 0  0x1 0x0>;
		};
	};

Does that sound about right?

Thierry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe0RiAAoJEN0jrNd/PrOhf/8P/3HamFbOceUu0UPNhJ9Isyb4
EthYY/OdxkPiaIzznEUq2mXcEKpfCywPqme89OsovHbnKyToqs2ZqT1kJdtA3Van
YfuhZ132VOiTSrx0ZHFdT8aaYNVIVzhSWsEUUn4AbeEpFUvBuMYjkCn6LRLIcQo+
W728gXNgTKL2kK5/VWB1+H+UI8kpO9vCrmWLHKIEZ3jfb443WX9JWtMUuOK4E4up
ia0xdu9RxL6bS38cy/kyr17/t+lsXuZ36iy4WDeif7hde67zBG4IEB6DoiyVPVe4
kkrJwg7AUfApONagAQ9ojvWQJs+ueVYFkvXsqYfQCYD9s9ZilaF9MwKMmrxQIkB5
VKafeFBPmarLNNcaa0x/mqPaO48lUKherOT8l/0cwBK1aivVwWk0OMiVxJTkL3ch
9Ui6gmtU6DlAJHOJZSfmL2+05aftU4rNBcovSFiZrFvGPxuNduyxpO0bQa+3h8TD
A6Anaw5h29utlmSBqmhh+Gx4Cf5XgOht9H38IKST4DjHErrrNjhXVq63OU1YZ76M
GbmDrsgeolvb8j/VvaBmkm6RSgU2tB6xUjvkfhkEtlBSztFXqfH0oQAvhZ97sLje
TI+mHoqQnZ6MGGBSTLbGGzKybqfUSTKw5PYUdaH1pi1HQGRirVd53wdplTIY4Xgx
g/mUJ9w4Dnaua92wOFDk
=d3Rt
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

--===============2261608275536795131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2261608275536795131==--
