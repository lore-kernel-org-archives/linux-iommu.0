From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Mon, 19 Jan 2015 13:31:00 +0100
Message-ID: <20150119123058.GA7312@ulmo.nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<5043167.LEiljZnGai@avalon> <20150119111202.GD32131@arm.com>
	<1984907.uTqFPJnJpV@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2261885391895680101=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1984907.uTqFPJnJpV@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2261885391895680101==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 01:34:24PM +0200, Laurent Pinchart wrote:
> Hi Will,
>=20
> On Monday 19 January 2015 11:12:02 Will Deacon wrote:
> > On Sun, Jan 18, 2015 at 11:18:51AM +0000, Laurent Pinchart wrote:
> > > On Sunday 18 January 2015 15:54:34 Alexandre Courbot wrote:
> > >> On 01/16/2015 08:18 AM, Laurent Pinchart wrote:
> > >>> On Thursday 15 January 2015 11:12:17 Will Deacon wrote:
> > >>>> On Thu, Jan 15, 2015 at 08:28:44AM +0000, Thierry Reding wrote:
> > >>>>> On Wed, Jan 14, 2015 at 10:46:10AM +0000, Will Deacon wrote:
> > >>>>>> On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrot=
e:
> > >>>>> [...]
> > >>>>>=20
> > >>>>>>> 2) Say you want to use the IOMMU API in your driver, and have an
> > >>>>>>> iommu property in your device's DT node. If by chance your IOMMU
> > >>>>>>> is registered early, you will already have a mapping automatica=
lly
> > >>>>>>> created even before your probe function is called. Can this be
> > >>>>>>> avoided? Is it even safe?
> > >>>>>>=20
> > >>>>>> Currently, I think you have to either teardown the ops manually =
or
> > >>>>>> return an error from of_xlate. Thierry was also looking at this
> > >>>>>> sort of thing, so it might be worth talking to him.
> > >>>>>=20
> > >>>>> I already explained in earlier threads why I think this is a bad
> > >>>>> idea. It's completely unnatural for any driver to manually tear d=
own
> > >>>>> something that it didn't want set up in the first place. It also
> > >>>>> means that you have to carefully audit any users of these IOMMU A=
PIs
> > >>>>> to make sure that they do tear down. That doesn't sound like a go=
od
> > >>>>> incremental approach, as evidenced by the breakage that Alex and
> > >>>>> Heiko have encountered.
> > >>>>=20
> > >>>> Well, perhaps we hide that behind a get_iommu API or something. We
> > >>>> *do* need this manual teardown step to support things like VFIO, so
> > >>>> it makes sense to reuse it for other users too imo.
> > >>>>=20
> > >>>>> The solution for me has been to completely side-step the issue and
> > >>>>> not register the IOMMU with the new mechanism at all. That is,
> > >>>>> there's no .of_xlate() implementation, which means that the ARM D=
MA
> > >>>>> API glue won't try to be smart and use the IOMMU in ways it's not
> > >>>>> meant to be used.
> > >>>=20
> > >>> That will break when someone will want to use the same IOMMU type f=
or
> > >>> devices that use the DMA mapping API to hide the IOMMU. That might =
not
> > >>> be the case for your IOMMU today, but it's pretty fragile, we need =
to
> > >>> fix it.
> > >>>=20
> > >>>>> This has several advantages, such as that I can also use the regu=
lar
> > >>>>> driver model for suspend/resume of the IOMMU, and I get to enjoy =
the
> > >>>>> benefits of devres in the IOMMU driver. Probe ordering is still a
> > >>>>> tiny issue, but we can easily solve that using explicit initcall
> > >>>>> ordering (which really isn't any worse than IOMMU_OF_DECLARE()).
> > >>>>=20
> > >>>> That's a pity. I'd much rather extend what we currently have to
> > >>>> satisfy your use-case. Ho-hum.
> > >>>=20
> > >>> Assuming we want the IOMMU to be handled transparently for the
> > >>> majority of devices I only see two ways to fix this,
> > >>>=20
> > >>> The first way is to create a default DMA mapping unconditionally and
> > >>> let drivers that can't live with it tear it down. That's what is
> > >>> implemented today.
> > >>=20
> > >> I strongly support Thierry's point that drivers should not have to t=
ear
> > >> down things they don't need. The issue we are facing today is a very
> > >> good illustration of why one should not have to do this.
> > >>=20
> > >> Everybody hates to receive unsollicited email with a link that says =
"to
> > >> unsubscribe, click here". Let's not import that unpleasant culture i=
nto
> > >> the kernel.
> > >>=20
> > >> I am arriving late in this discussion, but what is wrong with asking
> > >> drivers to explicitly state that they want the DMA API to be backed =
by
> > >> the IOMMU instead of forcibly making it work that way?
> > >=20
> > > The vast majority of the drivers are not IOMMU-aware. We would thus n=
eed
> > > to add a call at the beginning of the probe function of nearly every
> > > driver that can perform DMA to state that the driver doesn't need to
> > > handle any IOMMU that might be present in the system itself. I don't =
think
> > > that's a better solution.
> > >=20
> > > Explicitly tearing down mappings in drivers that want to manage IOMMUs
> > > isn't a solution I like either. A possibly better solution would be to
> > > call a function to state that the DMA mapping API shouldn't not handle
> > > IOMMUs. Something like
> > >
> > > 	dma_mapping_ignore_iommu(dev);
> > >=20
> > > at the beginning of the probe function of such drivers could do. The
> > > function would perform behind the scene all operations needed to tear
> > > down everything that shouldn't have been set up.
> >=20
> > An alternative would be to add a flag to platform_driver, like we have =
for
> > "prevent_deferred_probe" which is something like "prevent_dma_configure=
".
>=20
> That's a solution I have proposed (albeit as a struct device_driver field=
, but=20
> that's a small detail), so I'm fine with it :-)

I think Marek had proposed something similar initially as well. I don't
see an immediate downside to that solution. It's still somewhat ugly in
that a lot of stuff is set up before it's known to actually be used at
all, but it seems like there's some consensus that this can be improved
later on, so I have no objections to such a patch.

Of course that doesn't solve the current breakage for the Rockchip DRM
and OMAP ISP drivers.

There's an additional issue with this automatic type of setting up
mapping: on Tegra quite a few devices can use the IOMMU. Among those are
SD/MMC controllers, HDA, SATA and things like the AHB bus. Creating a
separate domain (=3D=3D address space) for each of those devices is wasteful
and there's currently no way to make them use a single virtual address
space. Each of them really has no use for a full 4 GiB of address space.
My earliest attempt to implement that was as a policy decision within
the IOMMU driver, but that wasn't very well received.

I'm now wondering whether the same could be done using this new type of
flag. Perhaps it can be assumed that every driver that doesn't want its
IOMMU master hooked up to the DMA API can (and will) manually manage the
virtual address space. Conversely every driver that wants to use the DMA
API to abstract away the existence of an IOMMU could be considered part
of the group where a separate domain isn't necessary.

Thierry

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUvPkCAAoJEN0jrNd/PrOh8HMP/3q6Nu7JfhGly1LxOtBLOIgl
WcwhFLkwvpPvOtT1fql/dNCh1uk0kcmGDwrONcGUGeqsEmjVqy02pudWZyWIvjDr
KcQ/AjAUYlVbJSH/09BSAHluZTAd6lP8DY4yNdxMDkFUBXmZk/joTUQgKFgq10KM
sSi8MCBgya4WAe1OMDrEpdaTpGBkkvxa0ICSl+3g+rK6Yp777hAF8+hihnDGcxkJ
Pe+r57OM79H/I0OP1oHcttE0xXeHvlSOdwH8IU1LfMNLH8dNEzC5dk+0/CCkcnrM
a2dudq+RnG2KB/P889P/Ifgdxgv/O6LLdLDx63NnL/xd31RCGdDz5BP/nvkb7YA7
DwXXzVZF+2XF4frQdsWHttShJhz8tTN8UR0UMWU8TvVJ12YSO42D2b2c8es56qqf
4Uj7XsJwfbGZW7niqbs6FwCDxeVkbuSYXZYZ4RfTYHc+FfWxmQrr96p33V8zxAPI
Uqz8ujuv9W41dWJsSAAWuQoThAGiY94btNtm5UYiwiHPIduM25gp0BW6vl4gwDTU
CQXs/WIoGphwmBRh5xGIoRK3jve8qNcU7HQB7NlN6d2U/5ZSjvfyEs3ShqV3vGkw
bEL9KqPnEU8M9J4yQ03t3RHb9uxusKzqkk1AR6ci6xYUk0fiZSMbflXPwBrrRhum
kXSJzeFOZhaCrGSyiPzf
=DCXD
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

--===============2261885391895680101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2261885391895680101==--
