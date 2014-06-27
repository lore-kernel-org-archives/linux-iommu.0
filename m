From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 04/10] memory: Add Tegra124 memory controller support
Date: Fri, 27 Jun 2014 13:08:12 +0200
Message-ID: <20140627110811.GD2797@ulmo>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
	<1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
	<20140627124638.7ec150cca163c89727b8953f@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1763454004634767336=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140627124638.7ec150cca163c89727b8953f-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi DOyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Allen Martin <AMartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOJiIJoWrK/4GQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1763454004634767336==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2014 at 12:46:38PM +0300, Hiroshi DOyu wrote:
>=20
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
>=20
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >
> > The memory controller on NVIDIA Tegra124 exposes various knobs that can
> > be used to tune the behaviour of the clients attached to it.
> >
> > Currently this driver sets up the latency allowance registers to the HW
> > defaults. Eventually an API should be exported by this driver (via a
> > custom API or a generic subsystem) to allow clients to register latency
> > requirements.
> >
> > This driver also registers an IOMMU (SMMU) that's implemented by the
> > memory controller.
> >
> > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/memory/Kconfig                   |    9 +
> >  drivers/memory/Makefile                  |    1 +
> >  drivers/memory/tegra124-mc.c             | 1945 ++++++++++++++++++++++=
++++++++
> >  include/dt-bindings/memory/tegra124-mc.h |   30 +
> >  4 files changed, 1985 insertions(+)
> >  create mode 100644 drivers/memory/tegra124-mc.c
> >  create mode 100644 include/dt-bindings/memory/tegra124-mc.h
>=20
> I prefer reusing the existing SMMU and having MC and SMMU separated
> since most of SMMU code are not different from functionality POV, and
> new MC features are quite independent of SMMU.
>=20
> If it's really convenient to combine MC and SMMU into one driver, we
> could move "drivers/iomm/tegra-smmu.c" here first, and add MC features
> on the top of it.

I'm not sure if we can do that, since the tegra-smmu driver is
technically used by Tegra30 and Tegra114. We've never really made use of
it, but there are device trees in mainline releases that contain the
separate SMMU node.

Perhaps one of the DT folks can comment on whether it would be possible
to break compatibility with existing DTs in this case, given that the
SMMU on Tegra30 and Tegra114 have never been used.

Either way, I do see advantages in incremental patches, but at the same
time the old driver and architecture was never enabled (therefore not
tested either) upstream and as shown by the Tegra DRM example can't cope
with more complex cases. So I'm not completely convinced that an
incremental approach would be the best here.

Thierry

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTrVCbAAoJEN0jrNd/PrOhvbwP/jRt3vshZDONx45I9YYV8PGt
zzvV3YoYcDqCeHLXPVZNC/HRv4oLQ3yNJK91vUt9Zgc8kGEose9FZaYYvC76OtMZ
XcCvXhSGo3N8wy+4SvIovdVC2FXEzZfRPiizoL5vuyBlwHhb2emaBJwjEJaWk7GI
j4EtmVMnXv/11VSYiwAkyV9bkRYyaQZ6i7PNB0gmj9TH2RmFAIbNsRbHhPo/dovN
oKf8+tXQZmoGAey64URLlTfXZFU1P5Fz9ejNbF6ZD3mf8GyRghRjk3ypxl/2oUH9
RqVFhWnEeqH3723V3uMOgFrIRz2QgTUS8GFrHPmH2LWdYAFBmW3h3RfOzvJXlnvQ
yZkcOV7+8kNOXuxWLZG3+tj6QHD+jbhAk8qS9/HSKYPm5Lp6YsUCmf/f3dsyUgRZ
JCittXDjBZgkJA8aq4l/om7Ts6IOPWVK+2TwRv3w3wgxjzno6krN5i42kGCy4s41
nRIWUfXxOwe3VVE2WUA5ukKRc/ON8JPUZZ1SLQfnPmnMgqo1+jGkR7LViDv1yit7
U/Y3Dgl/ihIWOJBYmVUhg3G6M1e7DZJdshIHbcj4adIxOPUK/wqbtc8h6l4uCqh1
tzgCra21tMiqWzW9n6To7EK/Sqe2+W9gcQnTo4bsidUXM4F31UAMGpKr6T6jKNiW
j0FMUh6TTRPRhp/b8RgY
=m2wZ
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--

--===============1763454004634767336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1763454004634767336==--
