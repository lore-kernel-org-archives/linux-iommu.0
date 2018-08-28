From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 06/19] dt-bindings: memory: tegra: Squash tegra20-gart
	into tegra20-mc
Date: Tue, 28 Aug 2018 12:47:55 +0200
Message-ID: <20180828104755.GC9386@ulmo>
References: <20180818155430.5586-1-digetx@gmail.com>
	<20180818155430.5586-7-digetx@gmail.com>
	<20180820191209.GA28618@bogus>
	<b46cac22-9b31-9aa7-7eca-4725156346bb@gmail.com>
	<4538309b-fcb3-73ee-04e3-6cefcedd376d@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5878688527189627948=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4538309b-fcb3-73ee-04e3-6cefcedd376d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============5878688527189627948==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 20, 2018 at 10:35:54PM +0300, Dmitry Osipenko wrote:
> On 20.08.2018 22:27, Dmitry Osipenko wrote:
> > On 20.08.2018 22:12, Rob Herring wrote:
> >> On Sat, Aug 18, 2018 at 06:54:17PM +0300, Dmitry Osipenko wrote:
> >>> Splitting GART and Memory Controller wasn't a good decision that was =
made
> >>> back in the day. Given that the GART driver hasn't ever been used by
> >>> anything in the kernel, we decided that it will be better to correct =
the
> >>> mistakes of the past and merge two bindings into a single one. In a r=
esult
> >>
> >> As a result...
> >>
> >>> there is a DT ABI change for the Memory Controller that allows not to
> >>> break newer kernels using older DT by introducing a new required prop=
erty,
> >>> the memory clock. Adding the new clock property also puts the tegra20=
-mc
> >>> binding in line with the bindings of the later Tegra generations.
> >>
> >> I don't understand this part. It looks to me like you are breaking=20
> >> compatibility. The driver failing to probe with an old DT is okay?
> >=20
> > Yes, DT compatibility is broken. New driver won't probe/load with the o=
ld DT,
> > that's what we want.
> >=20
> >> OS's like OpenSUSE use new DTs with older kernel versions, so you shou=
ld=20
> >> consider how to not break them as well. I guess if all this is optiona=
l=20
> >> or has been unused, then there shouldn't be a problem.
> >=20
> > That's interesting.. Memory Controller isn't optional, I guess we could=
 change
> > compatible to "nvidia,tegra20-mc-gart".
>=20
> * I meant it's not optional in a sense that it's enabled in kernels confi=
g by
> default and driver is functional, but it's okay if MC driver will stop to=
 probe
> with older kernels as it is used only for reporting memory errors.

Yeah, we don't really regress at runtime. The errors reported by the
current driver are very rare, and even if you encounter them, they're
pretty cryptic, so I think this is one of the exceptional cases where
breaking the ABI "for the greater good" is acceptable.

Thierry

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluFKFsACgkQ3SOs138+
s6GS/A/9FhKnGuXL6ULi7ClHQ6T1WzcoA6pRh6hBKmB9PF5mRwBVTSXS8Gp8rcP5
V3UPHXcmSvNY9nhIaBUUehhYzlscsbnwcXeSsOmZ9j82WeVblDAZc5410/vXI5HE
8/lUptmH735FWQvDvadSNAknz482xvZ6FyAP7eXwYUK9Zx1x59EfP7BVfotVrk4O
hjeUYZuhyLc5vz3Cnu7Rs+dCjNIabr/cRGENZP7HNpZoRwePtjoplk3xtkZg5riL
PQpPgVUueHEo5Wk1IhpKXoroNfRKBTY0im65Qmf9k4/SdPp0ewEFaUsvD96k5sFV
5sIApSAr3KubixXCgNQke+kRFYM120pT4ybGAi7/VN414t9vJu5QKcDRj3qFGqaY
7NscjWhSk1kHFgpsgyqs72RZWklA8BbxU1WSQQbRHdPgdwVv0mHCWtzPG/sXD5sh
ImrJcREiVXmNwvQMPwquSiY5xNueH6avqPxdaHwYz4CECrzKihiasLXg8hfIE/2L
Xf+2MGJ95qv5ZpoFBR6JPYgiR+JLhi90UE2iRJZpFuwCjIPTY6l1yPHpobB5wJVP
2zXAiAU3teTmip6K4lx+pFs/YN48OaOGlAHeTGZCr9M2ZxqBZsw2DsKnq8WC5Nn9
d2SJ31Cj2vJGBSQtOnKAqPIvamEC67kLk8tG10pOSM1AIZV2WZ4=
=9ErX
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--

--===============5878688527189627948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5878688527189627948==--
