From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 01/19] [HACK] of: dev_node has struct device pointer
Date: Fri, 25 Oct 2013 15:46:58 +0200
Message-ID: <20131025134651.GC1551@ulmo.nvidia.com>
References: <20131024.122115.1035609747068925560.hdoyu@nvidia.com>
	<20131025001038.77299C403B6@trevor.secretlab.ca>
	<20131025075652.GB19622@ulmo.nvidia.com>
	<20131025.112202.47792301040951621.hdoyu@nvidia.com>
	<20131025132051.GD9999@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0693683813122427891=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131025132051.GD9999-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============0693683813122427891==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2013 at 02:20:51PM +0100, Will Deacon wrote:
> On Fri, Oct 25, 2013 at 09:22:02AM +0100, Hiroshi Doyu wrote:
> > Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Fri, 25 Oct 2013 09:5=
6:55 +0200:
> >=20
> > > I suspect that there will be enough differences between the various
> > > IOMMU implementations that we won't be able to have a unified binding
> > > (especially for how to associate devices with a particular virtual
> > > address space), but perhaps that could be solved with something like =
an
> > > .of_xlate() that IOMMU drivers implement, much like we've done with m=
ost
> > > other subsystems too.
> > >=20
> > > The binding for Tegra's IOMMU currently only uses the HW IDs (or a ma=
sk)
> > > to put a device into a given address space, but I think that could be
> > > easily extended to something like:
> > >=20
> > > 	memory-clients =3D <&iommu MASK>;
> > >=20
> > > Or similar. If other information is required, we could encode that in=
to
> > > a multi-cell specifier. Perhaps we could even leave away the phandle
> > > since typically there will only be a single IOMMU in the system?
> > >=20
> > > Does that sound reasonable? Hiroshi is much more familiar with IOMMUs,
> > > so I'd like to get his opinion on the above as well.
> >=20
> > I think that the above may be possible, but I'd like to listen from
> > other IOMMU SOC maintainers.
> >=20
> > A brief explanation for "memory-clients":
> >=20
> > In tegra, every H/W has its own memory-client ID, and it can be
> > associated to any address spaces. The above "memory-cilents" is used
> > to indicate which ID a device has in DT. If the other SOC IOMMUs need
> > this kind of "memory-clients", this would be standarized. Any comment?
> >=20
> > At least arm-smmu seems to have the following. multiple IOMMUs can be
> > handled with this.
> >=20
> >=20
> > - smmu-parent   : When multiple SMMUs are chained together, this
> >                   property can be used to provide a phandle to the
> >                   parent SMMU (that is the next SMMU on the path going
> >                   from the mmu-masters towards memory) node for this
> >                   SMMU.
>=20
> This property is for the case when IOMMUs are connected in series, which =
is
> fairly horrendous. However, it is extremely common to have multiple IOMMU
> instances within an Soc (Exynos SoCs have one IOMMU per device iirc), so
> that certainly needs to be handled.

Okay, in that case perhaps some sort of generic binding should mandate
the phandle, even for systems that only have a single one. I suspect a
generic variant of smmu-parent (iommu-parent?) would also be useful to
describe setups with cascaded IOMMUs.

Thierry

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSanZLAAoJEN0jrNd/PrOhoZoP/2na7ElR6ejRScDZranhwy2H
Rm4fs+u4KB8sOQOj8DBfMR1EDQaJ+1zL1xPeVGFK2c0QdHKopg8+LlYu9VKqhd9D
MSFroyVwnaGBCDsGz58hMfcxFc3tjlrD/t7gGM/perAjnRwgAuBijtX5S2F2jYFs
pToJVVxnvfh6DolIh58/Am/0P3R3y7IoTGKhHmYhmUlnVde1mSM5t7OB4blWwe4F
3ejmVJQEyc0Q/Cx+AUYo3FoyRfslzAAq2LEioJK6leOs2mj9RMkc39NASzCTrm0r
e9Tu+2GYkkA4P6dx+DTBl9XDFv5l+Q7vl30eO8LkNGfkrYiqgg5eS0fnITBKOtVG
kVhbjOT/CTXqPixMpckacmnUegpdQjplFVAUgVF8TshR2dNCjrnIszwaxiSWWi0Z
E+J3Fke88IRSJAIaeB05NkLJwjbt7ktJblcMBz/QJbwOXzvwjF3+sn9s12oisBJ4
jJoh0Ehexkkur6Aap7aXhq0Gboea4vPPLIblQyLmbXkWPdRxhQcjr7zQwFgklu+R
6qq3nwAOUnAH/yaxdXrwbNEuheS3ARb2aBP8vPq+G85DRdjprlW7PQxDF38Knrie
iqmMVFW1bIoC6WIP3+6ufL77QbQ1x3rJvkNn/BVqfY1zfI7q8IfiMGWm8/6GJ0Bl
3tYJvaiMNT7vjLPsLInm
=XWQV
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--

--===============0693683813122427891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0693683813122427891==--
