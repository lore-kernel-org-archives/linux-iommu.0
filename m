From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Thu, 15 Jan 2015 09:30:06 +0100
Message-ID: <20150115083005.GC30799@ulmo>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<54B63028.3090701@nvidia.com> <20150114104610.GC4050@arm.com>
	<4122226.MTzV1JgdDD@phil> <20150114191749.GL4050@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3759751077568576855=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150114191749.GL4050-5wv7dgnIgG8@public.gmane.org>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============3759751077568576855==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 07:17:50PM +0000, Will Deacon wrote:
> On Wed, Jan 14, 2015 at 01:51:36PM +0000, Heiko St=C3=BCbner wrote:
> > Am Mittwoch, 14. Januar 2015, 10:46:10 schrieb Will Deacon:
> > > On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
> > > > On 12/02/2014 01:57 AM, Will Deacon wrote:
> > > > > This patch plumbs the existing ARM IOMMU DMA infrastructure (whic=
h isn't
> > > > > actually called outside of a few drivers) into arch_setup_dma_ops=
, so
> > > > > that we can use IOMMUs for DMA transfers in a more generic fashio=
n.
> > > > >=20
> > > > > Since this significantly complicates the arch_setup_dma_ops funct=
ion,
> > > > > it is moved out of line into dma-mapping.c. If CONFIG_ARM_DMA_USE=
_IOMMU
> > > > > is not set, the iommu parameter is ignored and the normal ops are=
 used
> > > > > instead.
> > > >=20
> > > > A series for IOMMU support with Tegra/Nouveau ceased to work after =
this
> > > > patch.
> > >=20
> > > Which series? This code shouldn't even be executed unless you start u=
sing
> > > of_xlate and the generic bindings.
> > >=20
> > > > The Tegra IOMMU is not registered by the time the DT is parsed,
> > > > and thus all devices end up without the proper DMA ops set up becau=
se
> > > > the phandle to the IOMMU cannot be resolved.
> > >=20
> > > You might want to look at the patches posted for the exynos, renesas =
and ARM
> > > SMMUs for some hints in how to use the new API.
> > >=20
> > > > Subsequently calling arm_iommu_create_mapping() and
> > > > arm_iommu_attach_device() from the driver (as I used to do until 3.=
18)
> > > > does not help since the call to set_dma_ops() has been moved out of
> > > > arm_iommu_attach_device(). Therefore there seems to be no way for a=
 device
> > > > to gets its correct DMA ops unless the IOMMU is ready by the time t=
he DT
> > > > is parsed.
> > > >=20
> > > > Also potentially affected by this are the Rockchip DRM and OMAP3 ISP
> > > > drivers, which follow the same pattern.
> > >=20
> > > I don't understand why any code currently in mainline should be affec=
ted.
> > > Please can you elaborate on the failure case?
> >=20
> > As Alexandre suspected the new Rockchip drm code seems to be affected by
> > this. I hadn't played with the drm code before last weekend and was then
> > stumbling over different iommu related issues. As I hadn't to much cont=
act
> > with iommus till now I didn't get very far.
> >=20
> > But with Alexandre's bandaid patch of adding
> > 	set_dma_ops(dev, &iommu_ops);
> > to arm_iommu_attach_device both problems go away.
> >=20
> >=20
> > So to elaborate on the two failure cases:
>=20
> Aha, I see what you mean now -- the issue is that attaching to an IOMMU
> domain no longer swizzles the DMA ops. Furthermore, we also need to take
> into account the coherency of the device, which we didn't do before (and
> assumedly "worked" because all of the users happened to be non-coherent).
>=20
> Maybe we just need to add something like arm_iommu_swizzle_dma_ops, so
> that direct users of the arm_iommu_* API can manage things manually?

Why does this even have to be an ARM-specific API? Couldn't this equally
well be generic across all platforms so that we get unified handling of
IOMMU through the DMA API?

Thierry

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUt3qNAAoJEN0jrNd/PrOhMrkP/jvAXQ5FcHiU+8gBiEEARP+O
03sPtAJStLBYEyQRGaqZDWolWTqplUpl1lOzlAgtfV6rxsUhUc/ik1BbBaG+ifx4
cUAmhlmnUW3NtWBq90zYhcJyYLU1zsNmXNxBIk7Dy+34VYTJBEsZ0wbEWFVZLvBP
ODGHPOuAelaYka4SO5xZJgsCQWZGJgnMX2xE/1+Au6+HQIKmqGI+Dy0qJrmyDGl5
zJB54Ak010bnrW2IHdK3y6gmeC0cSsK4mjYwj9DfyCHSsTGXe/5oQI/0MqLKeqpZ
wiBG40Fu/t7N3zd5SZTzBxSKoyCPhrJdBNVe+biiMgYq9c+cH1jU/dPBVlgm8606
aaKl6F3lf54bfd5cJO8gIgq+eoWsJ6VNGzNjHxdDmDwR7ejRRxRidHO/Uwa9n4u2
S07e/LrrzyM7EPhCbbVvemcHlBGddHMI7iRS2DlmIfM7VO79S0H/WlcC+XY/Hpw5
CDoTToji73oYIk2PhWMBLJXr386Kz3kxMenOtSsXBojArcy3T48jmO4eSEgl3VNQ
p6tk78+omGRxQJpotYhSyP6qoyo78A4g2gYo2MzwxYtmaBcYhqGO1QFYC2zOFkBT
M/u+MwRitq9IYzHxHct/WMxC/+iaRD7AJNxQQynYa5c/495MiU96vlyRIAopRnT9
ciBAYGWyHZxHgznWMnTZ
=dzCI
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--

--===============3759751077568576855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3759751077568576855==--
