From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Thu, 31 Jul 2014 10:39:25 +0200
Message-ID: <20140731083923.GA31218@ulmo>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<20140730152646.GC20162@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2096379634685627895=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140730152646.GC20162@leverpostej>
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
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2096379634685627895==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2014 at 04:26:47PM +0100, Mark Rutland wrote:
> Hi Thierry,
>=20
> This looks sane to me.
>=20
> I just have a few questions below which are hopefully simple/stupid.
>=20
> On Fri, Jul 04, 2014 at 04:29:17PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > This commit introduces a generic device tree binding for IOMMU devices.
> > Only a very minimal subset is described here, but it is enough to cover
> > the requirements of both the Exynos System MMU and Tegra SMMU as
> > discussed here:
> >=20
> >     https://lkml.org/lkml/2014/4/27/346
> >=20
> > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> > Changes in v4:
> > - clarify that disabling an IOMMU DT node may not disable translation
> > - be more explicit that examples are only examples
> > - add multi-ID master example
> >=20
> > Changes in v3:
> > - use #iommu-cells instead of #address-cells/#size-cells
> > - drop optional iommu-names property
> >=20
> > Changes in v2:
> > - add notes about "dma-ranges" property (drop note from commit message)
> > - document priorities of "iommus" property vs. "dma-ranges" property
> > - drop #iommu-cells in favour of #address-cells and #size-cells
> > - remove multiple-master device example
> >=20
> >  Documentation/devicetree/bindings/iommu/iommu.txt | 172 ++++++++++++++=
++++++++
> >  1 file changed, 172 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/iommu.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Docume=
ntation/devicetree/bindings/iommu/iommu.txt
> > new file mode 100644
> > index 000000000000..464a81eaaf61
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
> > @@ -0,0 +1,172 @@
> > +This document describes the generic device tree binding for IOMMUs and=
 their
> > +master(s).
> > +
> > +
> > +IOMMU device node:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +An IOMMU can provide the following services:
> > +
> > +* Remap address space to allow devices to access physical memory range=
s that
> > +  they otherwise wouldn't be capable of accessing.
> > +
> > +  Example: 32-bit DMA to 64-bit physical addresses
> > +
> > +* Implement scatter-gather at page level granularity so that the devic=
e does
> > +  not have to.
> > +
> > +* Provide system protection against "rogue" DMA by forcing all accesse=
s to go
> > +  through the IOMMU and faulting when encountering accesses to unmapped
> > +  address regions.
> > +
> > +* Provide address space isolation between multiple contexts.
> > +
> > +  Example: Virtualization
> > +
> > +Device nodes compatible with this binding represent hardware with some=
 of the
> > +above capabilities.
> > +
> > +IOMMUs can be single-master or multiple-master. Single-master IOMMU de=
vices
> > +typically have a fixed association to the master device, whereas multi=
ple-
> > +master IOMMU devices can translate accesses from more than one master.
> > +
> > +The device tree node of the IOMMU device's parent bus must contain a v=
alid
> > +"dma-ranges" property that describes how the physical address space of=
 the
> > +IOMMU maps to memory. An empty "dma-ranges" property means that there =
is a
> > +1:1 mapping from IOMMU to memory.
> > +
> > +Required properties:
> > +--------------------
> > +- #iommu-cells: The number of cells in an IOMMU specifier needed to en=
code an
> > +  address.
> > +
> > +The meaning of the IOMMU specifier is defined by the device tree bindi=
ng of
> > +the specific IOMMU. Below are a few examples of typical use-cases:
> > +
> > +- #iommu-cells =3D <0>: Single master IOMMU devices are not configurab=
le and
> > +  therefore no additional information needs to be encoded in the speci=
fier.
> > +  This may also apply to multiple master IOMMU devices that do not all=
ow the
> > +  association of masters to be configured. Note that an IOMMU can by d=
esign
> > +  be multi-master yet only expose a single master in a given configura=
tion.
> > +  In such cases the number of cells will usually be 1 as in the next c=
ase.
> > +- #iommu-cells =3D <1>: Multiple master IOMMU devices may need to be c=
onfigured
> > +  in order to enable translation for a given master. In such cases the=
 single
> > +  address cell corresponds to the master device's ID. In some cases mo=
re than
> > +  one cell can be required to represent a single master ID.
> > +- #iommu-cells =3D <4>: Some IOMMU devices allow the DMA window for ma=
sters to
> > +  be configured. The first cell of the address in this may contain the=
 master
> > +  device's ID for example, while the second cell could contain the sta=
rt of
> > +  the DMA window for the given device. The length of the DMA window is=
 given
> > +  by the third and fourth cells.
> > +
> > +Note that these are merely examples and real-world use-cases may use d=
ifferent
> > +definitions to represent their individual needs. Always refer to the s=
pecific
> > +IOMMU binding for the exact meaning of the cells that make up the spec=
ifier.
> > +
> > +
> > +IOMMU master node:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Devices that access memory through an IOMMU are called masters. A devi=
ce can
> > +have multiple master interfaces (to one or more IOMMU devices).
> > +
> > +Required properties:
> > +--------------------
> > +- iommus: A list of phandle and IOMMU specifier pairs that describe th=
e IOMMU
> > +  master interfaces of the device. One entry in the list describes one=
 master
> > +  interface of the device.
> > +
> > +When an "iommus" property is specified in a device tree node, the IOMM=
U will
> > +be used for address translation. If a "dma-ranges" property exists in =
the
> > +device's parent node it will be ignored. An exception to this rule is =
if the
> > +referenced IOMMU is disabled, in which case the "dma-ranges" property =
of the
> > +parent shall take effect. Note that merely disabling a device tree nod=
e does
> > +not guarantee that the IOMMU is really disabled since the hardware may=
 not
> > +have a means to turn off translation.
> > +
> > +
> > +Notes:
> > +=3D=3D=3D=3D=3D=3D
> > +
> > +One possible extension to the above is to use an "iommus" property alo=
ng with
> > +a "dma-ranges" property in a bus device node (such as PCI host bridges=
). This
> > +can be useful to describe how children on the bus relate to the IOMMU =
if they
> > +are not explicitly listed in the device tree (e.g. PCI devices). Howev=
er, the
> > +requirements of that use-case haven't been fully determined yet. Imple=
menting
> > +this is therefore not recommended without further discussion and exten=
sion of
> > +this binding.
> > +
> > +
> > +Examples:
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Single-master IOMMU:
> > +--------------------
> > +
> > +	iommu {
> > +		#iommu-cells =3D <0>;
> > +	};
> > +
> > +	master {
> > +		iommus =3D <&/iommu>;
>=20
> Nit: this should be iommus =3D <&{/iommu}>, or it's not valid dts syntax.

Done.

> > +	};
> > +
> > +Multiple-master IOMMU with fixed associations:
> > +----------------------------------------------
> > +
> > +	/* multiple-master IOMMU */
> > +	iommu {
> > +		/*
> > +		 * Masters are statically associated with this IOMMU and
> > +		 * address translation is always enabled.
> > +		 */
> > +		#iommu-cells =3D <0>;
>=20
> I don't follow why translation being always enabled is relevant to the
> example; that would seem to be independent from the binding.
>=20
> Surely the key point is that with no way to distinguish devices, they
> presumably share the same translations?

Both aspects are important I think. For #iommu-cells =3D <0> there is no
way for the IOMMU driver to know how to enable translation for a given
device. So it must be either always on or always off.

I guess one could say that this is implicit if all masters share the
same translations. And I guess translations don't always have to be on
or off technically. Let me try to rephrase this:

		/*
		 * Masters are statically associated with this IOMMU and share
		 * the same address translations because the IOMMU does not
		 * have sufficient information to distinguish between masters.
		 *
		 * Consequently address translation is always on or off for
		 * all masters at any given point in time.
		 */

Does that sound better?

Thierry

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2gC7AAoJEN0jrNd/PrOhHRwP/jmPWuU4FOmLtSPMOIWBF1/p
yZepQOa+zlEfICdVMyM1VTMgrYFCFjFdB1lhc2NAEgcyN3i3E6s7tp+IWmpZKlIz
54b2rIimsNA3arFYnyKlfDGo5C4RrSE58RQTrGk5USFbOQf1Ma0pweus5xihvQE1
S+0rU/HBAAYw1rpveWU2AYCxcRuSvhU8B24FaQE0NjDR9YSsdinGXzjlKV5g1ZTz
alPK/jNLSMwkFbtUQui5C8t/s/Sw0dNFNipVbynSW4uVUGPbCmIXDeMnSsIAXRdn
JZeCXJoHxr4/3QqgtqOk+LoPHAU0VWpBTzxxEF0IgDLziryz4yFyUbsAm7/tzRXe
iBdesuzXLLMX1td0Ev0tENr98Q+XOQkjCfUeWGbC691sNyPlSb4NuQxCHgTJ/p96
GoFSLjm4xgjGeCI3W5P3askRm+7CxlTgBDLm6U4wRWAfo9waPlE1vpPytFSXprUt
VYNN6xHNp0tmlWmOeSbta2PpbuqBx6I9NMXS70FWbV3uOnV2WqM2nETHrQwkTe4D
fHV8q1LH81FV0EoZwXS3GhXPD7j6r/q082eoYUwqe7m8IMCizhE2/Cph9O0lgHpj
aSSMK2DUHzdiOEh8V2uT6Z1+d1MErWP+Tb1VMCgC0CHNR82yAIjGbJ5MxBu7tLE7
cIH0TH01mjptG9i62enm
=bfvD
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

--===============2096379634685627895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2096379634685627895==--
