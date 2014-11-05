From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 09/10] drm/tegra: Add IOMMU support
Date: Wed, 5 Nov 2014 10:50:05 +0100
Message-ID: <20141105095003.GA12458@ulmo.nvidia.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
	<1403815790-8548-10-git-send-email-thierry.reding@gmail.com>
	<CAOw6vbJy6oy7cibH4f332UM=kS56KUMcnYdUTG0pEYXyQkFDoQ@mail.gmail.com>
	<CAOw6vbLFLrqWYB-4N50G7oucgMD+xd+QtdcMSzX4z7xRiU-vPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5277356299868273657=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOw6vbLFLrqWYB-4N50G7oucgMD+xd+QtdcMSzX4z7xRiU-vPQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sean Paul <seanpaul-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Allen Martin <amartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rhyland Klein <rklein@nvidia>
List-Id: iommu@lists.linux-foundation.org


--===============5277356299868273657==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2014 at 11:54:11AM -0400, Sean Paul wrote:
> On Tue, Sep 30, 2014 at 2:48 PM, Sean Paul <seanpaul-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> > On Thu, Jun 26, 2014 at 4:49 PM, Thierry Reding <thierry.reding@gmail.c=
om> wrote:
> >> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
[...]
> >>  static void tegra_bo_destroy(struct drm_device *drm, struct tegra_bo =
*bo)
> >>  {
> >> -       dma_free_writecombine(drm->dev, bo->gem.size, bo->vaddr, bo->p=
addr);
> >> +       if (!bo->pages)
> >> +               dma_free_writecombine(drm->dev, bo->gem.size, bo->vadd=
r,
> >> +                                     bo->paddr);
>=20
> One more thing. If tegra_bo_alloc fails, we'll have bo->vaddr =3D=3D NULL
> and bo->paddr =3D=3D ~0 here, which causes a crash.
>=20
> I posted https://lkml.org/lkml/2014/9/30/659 to check for the error
> condition in the mm code, but it seems like reviewer consensus is to
> check for this before calling free.
>=20
> As such, we'll need to make sure bo->vaddr !=3D NULL before calling
> dma_free_writecombine to avoid this situation.
>=20
> Would you prefer I send a patch up to fix this separately, or would
> you like to roll this into your next version?

I've rolled this check into my series because I touch that area of code
anyway.

Thanks for bringing it up.

Thierry

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUWfLLAAoJEN0jrNd/PrOhGdMP/jgzGHvv3uBF15GkJMhy8wdT
5DdyMqhvriyDDD3JykETF/i2O++tGUIGzZH4fZNwtJE/UGRASu8Qxiuk7e8MecFv
lxEWpRCUiVsDs8HC4Aw2E9s8pKKZ9a9PBTuLcxCoqUj5sIK/ds35Fmnuzsx2usft
H5cQ6Yu4ASajJL3bsTjX9+9BWh5okF6NvfnVqu3xF5QwB8MeJaSg2WIZf9FSLOc5
/TtunrbukX8HjJXygQcNZMYOM8cxhzcBrDGerHhXGPMNRVnprbXDkdN4CrRvHhcu
0kI0ig5DVqYJL2UJfFZodoTHy2fnskvf1QTZRxLtEBcqdR3YN885mKEP0F0Dvdw+
F2SFtj3HB2NwF7fX5omWwYWUa6FwOGbScXApGXQYH6nSvrSfvYfBopOTj9cfsoHb
LCQm1qxQJEIz0B83AYqi7EJ5UsPdaHo7xWOKAPsyYUUD0Gjttv49ICZAH92xyr2G
L1l2SbV6dXctvupjfszn5pkzpH2x2lvUyIooaEbDxr+LFUl+mDZ0RiEYG+hq2GGT
ht2nOR74nr80bq3PhyT/WfPBsm7k2BCTKVk2G/0ozNV8MVD//k8FvmSTXIr7Cgah
tDxrwz8Rg63AIDCbHSgkGERmXAhCCiJa+V2fzXNziRsdVlyBGLs3y8pK3j2Z0U0A
m70Q9GfLzPbbYQ5KpMoe
=bxPN
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

--===============5277356299868273657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5277356299868273657==--
