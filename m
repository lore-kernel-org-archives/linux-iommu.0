From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 31 Jul 2014 13:14:54 +0200
Message-ID: <20140731111453.GA11955@ulmo>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<20140730152646.GC20162@leverpostej>
	<CAOesGMi3zM1-cqmeGddJ69RNXx0ktFm_zXO_yq7N0EeA3HNrUQ@mail.gmail.com>
	<20140730181842.GG20162@leverpostej> <20140731100905.GA7458@ulmo>
	<20140731105017.GB22994@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0165621258106789330=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140731105017.GB22994@leverpostej>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============0165621258106789330==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2014 at 11:50:17AM +0100, Mark Rutland wrote:
> On Thu, Jul 31, 2014 at 11:09:06AM +0100, Thierry Reding wrote:
> > On Wed, Jul 30, 2014 at 07:18:42PM +0100, Mark Rutland wrote:
> > [...]
> > > > >> +
> > > > >> +Multiple-master IOMMU with configurable DMA window:
> > > > >> +---------------------------------------------------
> > > > >> +
> > > > >> +     / {
> > > > >> +             #address-cells =3D <1>;
> > > > >> +             #size-cells =3D <1>;
> > > > >> +
> > > > >> +             iommu {
> > > > >> +                     /* master ID, address and length of DMA wi=
ndow */
> > > > >> +                     #iommu-cells =3D <4>;
> > > > >> +             };
> > > > >> +
> > > > >> +             master {
> > > > >> +                     /* master ID 42, 4 GiB DMA window starting=
 at 0 */
> > > > >> +                     iommus =3D <&/iommu  42  0  0x1 0x0>;
> > > > >
> > > > > Is this that window is from the POV of the master, i.e. the maste=
r can
> > > > > address 0x0 to 0xffffffff when generating transactions, and these=
 get
> > > > > translated somehow?
> > > > >
> > > > > Or is this the physical addresses to allocate to the master?
> > > >=20
> > > > It needs to be clarified in the documentation, but as far as I know=
 it
> > > > is the DMA address space that is used.
> > >=20
> > > Ok. So that's pre-translation, from the POV of the master?
> >=20
> > Correct. It represents the window of the IOMMU's addressable I/O virtual
> > address space that should be assigned to this particular master.
> >=20
> > > If we don't have that knowledge about the master already (e.g. based =
on
> > > the compatible string), surely we always need that information in a
> > > given iommu-specifier format? Otherwise certain iommus won't be able =
to
> > > handle masters with limited addressing only due to limitations of the=
ir
> > > binding.
> >=20
> > This is only used for what's often called a windowed IOMMU. Many IOMMUs
> > (non-windowed) typically allow only a complete address space to be
> > assigned to a master without additional control over subregions. So this
> > is really a property/capability of the IOMMU rather than the masters
> > themselves.
>=20
> I'm not sure I follow, but I'm happy to wait until we have the first
> windowed IOMMU using this binding. I'll try to get myself up to speed in
> the mean time.

As I understand it, a windowed IOMMU manages a given I/O virtual address
space (only one or perhaps even several). Each such address space is the
complete range that the IOMMU can take as inputs from any master. For
purposes of virtualization and process separation it can subdivide this
address space into subranges, so that each context can only access that
given range of virtual I/O addresses. I suspect that this works by
setting up a mapping between that range and the context's master ID(s).
And I also suppose it could be possible for the DMA windows to be truly
configurable within the IOMMU or for specific devices to be assigned a
fixed window.

Simpler IOMMUs (Tegra uses one of those for example) know only address
spaces. That is each address space can be assigned to one or more
masters. But each master can always access the whole address space and
accesses cannot be restricted to subregions thereof.

So from a memory protection point of view the difference is that for
non-windowed IOMMUs translations will fault only if no mapping has been
set up for the I/O virtual address being accessed, whereas for windowed
IOMMUs translations can in addition also fault if they access an I/O
virtual addresses outside of the range that they've been assigned.

Does that help? Note that I've never dealt with windowed IOMMUs myself,
so this is largely based on what I scooped up in previous discussions
with Arnd.

Thierry

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2iUtAAoJEN0jrNd/PrOhhyYP/idsFANwRuln/m9YRqBJchql
nhE8TlmdbateiHmAsSH1+cUGMysvJEENqnK48yveLAHVlTnjKrhIKC5Z038OsCJX
uyxWns5PbTMcfqtGobdPEOgOwqf5lTnXL+FRFCBaCzMC/W+EeZBawmEVY7fVuPxK
qTQoyhYYNEchGovGVrQcyUtUNJZWZIdyWcy/OesTD4zXOccgLzxjLyYOqhiv62F+
rTLn/woHsbLVgTU50t6Q3HpOm9LWYStfQk7PeaiiwJPVg77v/Ns0LA8AToj7WuPX
eBKrbkGRocq3xo5Edghh/NfmjavrKtU4my4HrrZjgF7uYZIY+zQb/diUfMhvHd1e
B96H5S8MCa1zJpBiqGpLUInYkf3F0OUW52QbkBOUaNIaYDUTPg7VPn4LHv+BhnM3
VjGs1MYFijcz1WwAwSMqVmLGrLwcu28oCkla0hSKrO09MGIEFS59DXIJcriTY+lL
Ce628gnZNU0NDpQzeHk/gIElwflanoMzJjpkGtOqHccf9HHyUsyfkrQlzQE/zk1w
1dyzde2n4miho3M0V5GWjKGpmR1LLGronA8AYlpt7pRCmZBuizZe+GEvvOddObxJ
gBkeBdNhtx7B/tRATfGdaSiZKX4EnZ5zFeqQuICeAevTjxB0rs0ULjRzj99CqLna
jOqy2xRyl+aaPuYN7TF8
=M/bv
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--

--===============0165621258106789330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0165621258106789330==--
