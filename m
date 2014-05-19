From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Mon, 19 May 2014 22:59:46 +0200
Message-ID: <20140519205945.GE30737@mithrandir>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<4391809.OTRCiJQXS4@wuerfel> <20140519125336.GA9466@ulmo>
	<14622654.QO8kH1AoTT@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7490390074023746523=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <14622654.QO8kH1AoTT@wuerfel>
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


--===============7490390074023746523==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2014 at 08:34:07PM +0200, Arnd Bergmann wrote:
> On Monday 19 May 2014 14:53:37 Thierry Reding wrote:
> > On Mon, May 19, 2014 at 12:26:35PM +0200, Arnd Bergmann wrote:
> > > On Friday 16 May 2014 14:23:18 Thierry Reding wrote:
> > > > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > >=20
> > > > This commit introduces a generic device tree binding for IOMMU devi=
ces.
> > > > Only a very minimal subset is described here, but it is enough to c=
over
> > > > the requirements of both the Exynos System MMU and Tegra SMMU as
> > > > discussed here:
> > > >=20
> > > >     https://lkml.org/lkml/2014/4/27/346
> > > >=20
> > > > More advanced functionality such as the dma-ranges property can eas=
ily
> > > > be added in a backwards-compatible way. In the absence of a dma-ran=
ges
> > > > property it should be safe to default to the whole address space.
> > > >=20
> > >=20
> > > The basic binding looks fine, but I'd like it to be more explicit
> > > about dma-ranges. Most importantly, what does "the whole address spac=
e"
> > > mean?
> >=20
> > The whole point was to leave out any mention of dma-ranges from the
> > binding until we've figured out more of the puzzle.
> >=20
> > So what I was trying to avoid was another lengthy discussion on the
> > topic of dma-ranges. Oh well... =3D)
>=20
> I think that can't work, because we need a way to specify the
> ranges for some iommu drivers. We have to make sure we at least
> don't prevent it from working.

That was precisely why I wanted to let this out of the binding for now
so that we can actually focus on making existing hardware work rather
than speculate about what we may or may not need.

If you think the current minimal binding will cause future use-cases to
break, then we should change it to avoid that. What you're proposing is
to make the binding more complex on the assumption that we'll get it
right.

Wouldn't it be safer to keep things to the bare minimum necessary to
represent hardware that we have access to and understand now, rather
than speculating about what may be necessary at some point. I'd much
prefer to add complexity on an as-needed basis and when we have a better
understand of where we're headed.

> > > Finally, it makes no sense to use the dma-ranges property of the mast=
er's
> > > parent bus, because that bus isn't actually involved in the translati=
on.
> >=20
> > My understanding here is mostly based on the OpenFirmware working group
> > proposal for the dma-ranges property[0]. I'll give another example to
> > try and clarify how I had imagined this to work:
> >=20
> > 	/ {
> > 		#address-cells =3D <2>;
> > 		#size-cells =3D <2>;
> >=20
> > 		iommu {
> > 			/*
> > 			 * This is somewhat unusual (or maybe not) in that we
> > 			 * need 2 cells to represent the size of an address
> > 			 * space that is 32 bits long.
> > 			 */
> > 			#address-cells =3D <1>;
> > 			#size-cells =3D <2>;
>=20
> You should never need #size-cells > #address-cells

That was always my impression as well. But how then do you represent the
full 4 GiB address space in a 32-bit system? It starts at 0 and ends at
4 GiB - 1, which makes it 4 GiB large. That's:

	<0 1 0>

With #address-cells =3D <1> and #size-cells =3D <1> the best you can do is:

	<0 0xffffffff>

but that's not accurate.

> > 			#iommu-cells =3D <1>;
> > 		};
> >=20
> > 		master {
> > 			iommus =3D <&/iommu 42>;
> > 			/*
> > 			 * Map I/O addresses 0 - 4 GiB to physical addresses
> > 			 * 2 GiB - 6 GiB.
> > 			 */
> > 			dma-ranges =3D <0x00000000 0 0x80000000 1 0>;
> > 		};
> > 	};
> >=20
> > This is somewhat incompatible with [0] in that #address-cells used to
> > parse the child address must be taken from the iommu node rather than
> > the child node. But that seems to me to be the only reasonable thing
> > to do, because after all the IOMMU creates a completely new address
> > space for the master.
> >=20
> > [0]: http://www.openfirmware.org/ofwg/proposals/Closed/Accepted/410-it.=
txt
>=20
> I don't think you can have a dma-ranges without a #address-cells and
> #size-cells property in the same node. In your example, I'd also expect
> a child node below 'master' that then interprets the address space
> made up by dma-ranges.

Okay, so what Dave and you have been saying strongly indicates that
dma-ranges isn't the right thing to use here.

> As a comment on the numbers in your example, I don't expect to ever
> see a 4GB IOMMU address space that doesn't start at an offset. Instead
> I'd expect either addresses that encode a device ID, or those that
> are just a subset of the parent address space, with non-overlapping
> bus addresses for each master.

As I understand the Tegra SMMU allows each of the clients to be assigned
a separate address space (4 GiB on earlier generations and 16 GiB on new
generations) and all addresses in each address space can be mapped to
arbitrary physical addresses.

> > > My preferred option would be to always put the address range into
> > > the iommu descriptor, using the iommu's #address-cells.
> >=20
> > That could become impossible to parse. I'm not sure if such hardware
> > actually exists, but if for some reason we have to split the address
> > range into two, then there's no longer any way to determine the size
> > needed for the specifier.
> >=20
> > On the other hand what you propose makes it easy to represent multiple
> > master interfaces on a device. With a separate dma-ranges property how
> > can you define which ranges apply to which of the master interfaces?
>=20
> Well, you could have multiple links to the same IOMMU if you want to=20
> do that, and define that there must be at least one dma-ranges entry
> for each IOMMU entry (although not necessarily the other way round,
> you could have direct ranges in addition to translated ones.
>=20
> > Then again if address ranges can't be broken up in the first place, then
> > dma-ranges could be considered to be one entry per IOMMU in the iommus
> > property.
>=20
> Let me do another example, with the address merged into the iommu
> references:
>=20
> / {
> 	#address-cells =3D <2>; // 64-bit address
> 	#size-cells =3D <2>;
>=20
> 	iommu@a {
> 		#address-cells =3D <2>; // 1 cell ID, 1 cell address
> 		#size-cells =3D <1>;
>=20
> 		// no need for #iommu-cells
> 	};
>=20
>=20
> 	master@b {
> 		iommus =3D <&/iommu@a // iommu
> 			0x23  	     // ID
> 			0x40000000   // window start
> 			0x10000000>; //window size
> 	};
> };
>=20
> A disadvantage of this model would be that for all ARM SMMU users, we'd
> have to always list a 4GB address space, which is kind of redundant.

Isn't that the equivalent of the "whole address space" default that I
mentioned in the commit message? Could this be handled with
#address-cells =3D <1> and #size-cells =3D <0> in the iommu node? That way
the only cell that needs to be specified in iommus would be the ID and
the redundant address space could be simply omitted from DT since it
would be implied by the compatible string.

Thierry

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTenDBAAoJEN0jrNd/PrOhyJMQALlqWBD/o11SfVlrp0WiRDpT
gfTikfeG3tYa5lBQNiW5lv2lWyn5MeHxspIwQk2hY3oodAAUTZZLU6EAB4QphYKa
IEFPHkxRdUfa684VUphYbCt6lFjVtwysKEtCUvxyOpeJki9DtpdHBL+x1HB15HBn
gIJFA+gLA2iZpzQc40IwKTrKp4HUq0Pv+jKz+4YJUTthHcojfYuYX8cFTNixyFcE
w61TIhn4JG67qx32rmfz3o1hbUJmZ0ZjawLEhzAG3TCBmxg2jbbVIYygke5qSfcs
o0kt5z7v9zfHFYj6iLB63uIatwKXzKoql5BtLcGxTKeqn8tY/S8N7QZkOm+jBQcA
jtP0WIh7UMuxCNXWLMDG9kZZWlvICC7nDcn/jPbMM5ew2ZxE6K7qrZ7tAMwGtwcP
2abXwLtFl2Fzvz76bADv23mqsJ5Q4v59yWOg+cFx/41DD0mbfRxbXtNecaVRWL0I
wgZgrcJ4pfdEkfcAlULCI1rYjdYTqq8f8eqZQno7L2gUDBlzbdvjBgXK4xzhuEWL
01+jB5pnZGRQXvarNa8krRNyzuNn9jx18RTLV+MuqCODRWcllAeGncf6cdZiYK2w
So2pJ9xuPOPJmmRBf1BSXxSt5KjvPldyGezxtpbw44fxSYBk5IRyH96yJYVxZ+/6
b6NEv2VPguh05Al+XL6k
=M1gh
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--

--===============7490390074023746523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7490390074023746523==--
