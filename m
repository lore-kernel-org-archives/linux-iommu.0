From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Sat, 30 Jun 2012 20:04:13 +0200
Message-ID: <20120630180413.GB23990@avionic-0098.adnet.avionic-design.de>
References: <4FEA6E09.30800@nvidia.com>
	<23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>
	<4FEA7472.7050201@nvidia.com>
	<20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
	<20120627155907.871b2a506374b7db14c202c4@nvidia.com>
	<20120627140809.GD19319@avionic-0098.mockup.avionic-design.de>
	<20120627172914.30a2ccfd1344161ca7724722@nvidia.com>
	<20120627144414.GA20681@avionic-0098.mockup.avionic-design.de>
	<20120628091853.d4c3d85749f9d41a5dfafd28@nvidia.com>
	<4FEC8A82.9090202@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1152004875887831677=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4FEC8A82.9090202-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1152004875887831677==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 28, 2012 at 10:46:58AM -0600, Stephen Warren wrote:
> On 06/28/2012 12:18 AM, Hiroshi Doyu wrote:
> > On Wed, 27 Jun 2012 16:44:14 +0200
> > Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> >=20
> >>> I think that "coherent_pool" can be used only when the amount of
> >>> contiguous memory is short in your system. Otherwise even unnecessary.
> >>>
> >>> Could you explain a bit more why you want carveout size on per-board =
basis?
> >>
> >> In the ideal case I would want to not have a carveout size at all.
> >> However there may be situations where you need to make sure some driver
> >> can allocate a given amount of memory. Having to specify this using a
> >> kernel command-line parameter is cumbersome because it may require
> >> changes to the bootloader or whatever. So if you know that a particular
> >> board always needs 128 MiB of carveout, then it makes sense to specify
> >> it on a per-board basis.
> >=20
> > Hm...I could understand somewhat;) but DT can also specify "bootargs"
> > in dts file, which can support per-board-wide spec too, like the above
> > sum of carveout needed from all drivers. I just want to avoid
> > introducing a new parameter additionaly if we can make use of the
> > existing mechanism.
>=20
> The bootargs in the DT file is usually provided by (over-written by) the
> bootloader. If we start requiring lots of random kernel command-line
> arguments, that makes it more effort for the user of the bootloader
> (e.g. distribution bootloader scripts, etc.) to create the kernel
> command-line. I'd prefer to avoid that as much as possible. That said,
> using a standardized command-line option that is (or will be) used by
> all (ARM?) SoCs for the same purpose is reasonable, because there's
> commonality there.

I propose we stick with the default CMA settings for now and see where
we end up. No need to jump the gun.

Thierry

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP7z+dAAoJEN0jrNd/PrOhOqEP/j45tHQYsH2mLF0xwfG2pyl/
YVtTRIyAZeBXcaggibN/FC2GkX8348uReKnHRdLxfI92eROksZzQDwMHx9fIXXyz
Dhr+NEWV9gkjN3HQ9i+uPt0pFFL5qDDmn/p08tPGdqLtFCP5TtW4hxiW1LQ2cJy9
CgA9CyM8WHbRVTLGVofk6t8PxTwETajAHBuNyIOjaKOrV4Om6En3gP7X0ADlzjhJ
ayA2+x30mnJMAJ+p0rbT02HPQJ509aSXUOMdZewrUUwTaD35wJmpsmFc4QOz/n0g
pFxtqaYyvB/JDNGlFBAnqYNLC4wuDYKXilEsGQnAkCbXmYhiOWAaNtMxaXPLzbXz
bEkbL7zPYX+pV0QqwCLjGieZyR3xQpL871/xNXX+E97Ba4k4QI3cZHbbD3KHlDv5
55aFqhU12f1StYSMDPbiqqp49oVtfGkJVZNuzyjj3xgUz+VfQAKP51yycFZCplKF
CTnV1IY965OOTw4tYMRN2Ik0FjVNDCXj6zB6QTV3uQQuPzpIpmYgBpL7GYMRAhUW
u3SxBGUyGgdUC9B7sAeB6wlAxIMnuv0XFWd6gT0Fqn1yVAdB+WyviM/CYFG09QTQ
fJsVXUU/JX1VdKkUy8TcE59cod0onrA3sfMGNdhhWSAYAnXJxiWhLd/VSQGR9IlG
a5U36vS/bLitRmYExJ7z
=TLUo
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

--===============1152004875887831677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1152004875887831677==--
