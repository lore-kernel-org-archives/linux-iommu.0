From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 6/7] arm: call iommu_init before
	of_platform_populate
Date: Tue, 23 Sep 2014 10:59:47 +0200
Message-ID: <20140923085946.GP30514@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<3261451.zpO6MVx5yo@wuerfel> <20140923070238.GH30514@ulmo>
	<3765297.6j3Rv68iqn@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8969136699200683140=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3765297.6j3Rv68iqn@wuerfel>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============8969136699200683140==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAnxKwVhzStH6fSc"
Content-Disposition: inline


--eAnxKwVhzStH6fSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2014 at 09:44:25AM +0200, Arnd Bergmann wrote:
> On Tuesday 23 September 2014 09:02:39 Thierry Reding wrote:
>=20
> > > I see two problems with using deferred probing here:=20
> > >=20
> > > - we don't actually need to defer the probing but the binding to the =
driver
> > >   when no dma ops are set, but it seems silly to even create the devi=
ce
> > >   before we can find out which ops it should use.
> >=20
> > What does device creation have to do with anything? Surely a device
> > won't need IOMMU services before the device is bound to a driver.
>=20
> The problem is that the driver will start using the IOMMU as soon
> as it calls dma_map_*, but that happens at runtime, not necessarily
> during the probe function.

But it won't call dma_map_*() before probe, right? If this is done in
the core we can defer probing before the driver's probe is called, so
there shouldn't be an issue.

> So we can get into the weird situation that probe() returns success,
> but then you can't use the device yet because you don't know whether
> it is supposed to use an IOMMU or not.

Of course any such solution would only work under the assumption that
the driver (or core) knows what it's doing and doesn't call dma_map_*()
until IOMMU support has properly been set up.

For DMA/IOMMU integration users I'd expect the core to set everything up
before proceeding to calling the driver's .probe() function. For others
they will need a way to either explicitly check for the IOMMU master
interface or have the core do that for them (similar to how it would do
that for DMA/IOMMU integration users).

> > >   The reason is that a driver does not actively ask for an IOMMU as i=
t would
> > >   for other subsystems (gpio, led, dmaengine, ...).
> >=20
> > Actually it does. At least in some cases. If you want to use the IOMMU
> > API directly you'd call something like iommu_present() on the bus type
> > and then allocate an IOMMU domain and attach to it. Unfortunately the
> > API seems to have been designed under the assumption that IOMMU will
> > have been registered before any users, so the API doesn't propagate any
> > meaningful errors.
>=20
> That's just a special case that does not even work as it should yet,

Of course it works. I count at least 3 drivers in mainline (and 1 local)
that do exactly this.

> please don't confuse the matter more by talking about drivers that
> use the IOMMU API explicitly, this series has very little to do with
> that.

It has everything to do with it. If we go and implement everything in
terms of DMA/IOMMU then we leave out all other users. Depending on who
you talk to the direct IOMMU users are the actually important ones.

> > Also, even if in other cases the drivers don't actively ask for an IOMMU
> > that doesn't mean that they couldn't be made to. For drivers that use
> > the DMA/IOMMU integration layer this is probably not practicable, but
> > there is no reason the core couldn't do it.
>=20
> We intentionally have an abstraction that is meant to let you write drive=
rs
> without knowing about iommu, swiotlb or coherency, these are all hidden
> behind the dma_map_ops implementation.

Perhaps I'm missing something then. How can you associate two devices
with the same domain with dma_map_ops?

Thierry

--eAnxKwVhzStH6fSc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUITaCAAoJEN0jrNd/PrOhgycP/A/jas68DBgcAyvFfgP73FuB
TGNPcJA+Lf0DgVU1Sx5SzhmGWoX3lyT9iafGkY9gnzRc74AihqiRW4LW1/sYsMfs
5YZnXVFSScbPk5o2NlBAYf5QqcF0hezROsWpGIXRHteRP3rfUqq23hy37OeBQcrg
EfxBnqHmURnnugbMyEuDkDm0yRfTnXZ/PXGXfqaNgcbbix5MfPf1HkFoNLIAPko2
gmZjXe8ftw8SiGqpDdsjoELCbVCygBNve/6hS1zJwScapnsMUQ9td7kjTAasQWKQ
8tMG9bHhnnXUvP8Wov+/aUBSr7GERi+gOmSuDP2wPKoA0YjZocDbZ3+eb/1DPE7Z
2KHMJ5kdGo4AAeXYS/3f48cwm9+Go7jN7GWPbTsMvOwQAsRFN/a9YW7TmGi3VtKT
ECeHpJjOYQoSA7jrP/3Ruq3JO1GYNjFN/ls8V91uHSbMGWuOJWw4FFcdioN/edc1
vu1hOUarqBHyBdV01naQi7mOQUP9pYhBjQcez90Aktnl/rnhKrs+YD0Xv1he7we+
FbGU5ch43AI0VBBvKZX80lKaTL5pIr4wEc51qNMDVaj3Rd9LX913iNP/fD0oReoK
aGq5Y+msQaTCnfcxBPf+TS038XQ26mqUpUy/e0wXMtihw+7hEU90Ys27c6SBH82g
BtNJoYWhi3zp6A768Zcy
=alu2
-----END PGP SIGNATURE-----

--eAnxKwVhzStH6fSc--

--===============8969136699200683140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8969136699200683140==--
