From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Mon, 19 Jan 2015 17:21:14 +0100
Message-ID: <20150119162111.GA7751@ulmo.nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<2804479.ZFl06ysk3j@avalon> <20150119123623.GB7312@ulmo.nvidia.com>
	<2253719.6TRpaaEdiI@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3249539649699674950=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2253719.6TRpaaEdiI@wuerfel>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============3249539649699674950==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 04:52:41PM +0100, Arnd Bergmann wrote:
> On Monday 19 January 2015 13:36:24 Thierry Reding wrote:
> > On Fri, Jan 16, 2015 at 01:18:21AM +0200, Laurent Pinchart wrote:
> > > On Thursday 15 January 2015 11:12:17 Will Deacon wrote:
> > > > On Thu, Jan 15, 2015 at 08:28:44AM +0000, Thierry Reding wrote:
> > > > > On Wed, Jan 14, 2015 at 10:46:10AM +0000, Will Deacon wrote:
> > > > > > On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wro=
te:
> > > > > [...]
> > > > >=20
> > > > >>> 2) Say you want to use the IOMMU API in your driver, and have a=
n iommu
> > > > >>> property in your device's DT node. If by chance your IOMMU is
> > > > >>> registered early, you will already have a mapping automatically
> > > > >>> created even before your probe function is called. Can this be
> > > > >>> avoided? Is it even safe?
> > > > >>=20
> > > > >> Currently, I think you have to either teardown the ops manually =
or
> > > > >> return an error from of_xlate. Thierry was also looking at this =
sort of
> > > > >> thing, so it might be worth talking to him.
> > > > >=20
> > > > > I already explained in earlier threads why I think this is a bad =
idea.
> > > > > It's completely unnatural for any driver to manually tear down so=
mething
> > > > > that it didn't want set up in the first place. It also means that=
 you
> > > > > have to carefully audit any users of these IOMMU APIs to make sur=
e that
> > > > > they do tear down. That doesn't sound like a good incremental app=
roach,
> > > > > as evidenced by the breakage that Alex and Heiko have encountered.
> > > >=20
> > > > Well, perhaps we hide that behind a get_iommu API or something. We =
*do*
> > > > need this manual teardown step to support things like VFIO, so it m=
akes
> > > > sense to reuse it for other users too imo.
> > > >=20
> > > > > The solution for me has been to completely side-step the issue an=
d not
> > > > > register the IOMMU with the new mechanism at all. That is, there'=
s no
> > > > > .of_xlate() implementation, which means that the ARM DMA API glue=
 won't
> > > > > try to be smart and use the IOMMU in ways it's not meant to be us=
ed.
> > >=20
> > > That will break when someone will want to use the same IOMMU type for=
 devices=20
> > > that use the DMA mapping API to hide the IOMMU. That might not be the=
 case for=20
> > > your IOMMU today, but it's pretty fragile, we need to fix it.
> >=20
> > No, there's absolutely no issue here. It simply means that you can't do
> > this on Tegra. So far I'm not sure I even see an advantage in using the
> > IOMMU for devices that don't care about it anyway. Consider the example
> > of the SD/MMC or HDA. They typically allocate fairly small buffers, the
> > order of a single page typically. They can simply use memory handed out
> > by the CMA.
> >=20
> > So as long as we don't add a .of_xlate() implementation or instantiate
> > via the IOMMU_OF_DECLARE() mechanism we simply don't support IOMMU-over-
> > DMA on Tegra.
>=20
> It breaks as soon as you have a system with memory above the 4GB boundary,
> which is the whole point of iommus for most users.

Why does it break? The IOMMU API simply gets a list of pages and gets
the physical addresses from those pages when it maps them to the IO
virtual addresses. How is .of_xlate() or of_iommu_configure() related?

> CMA does not work for streaming mappings, only for the coherent API.

Why not? And if it doesn't I'm not sure we currently care on Tegra since
we've gotten away with using CMA just fine so far.

Thierry

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUvS73AAoJEN0jrNd/PrOhRm8P/ioAn43xLsdQofS8RF1iAvUL
CCHBpvPTGeTQpXjKRiEztIXaGDUaj0tZz384aa/SKmPVVryI4C6OkTw3JNLXjNdn
1yx6PKMTOzoglvUYMuwAVe4jOq2burkTdlluuijQasgnBVmupl+X5ARXTZNwfDzp
hhqKvMplQfaBhssZjOLjoSlm5Hy763ECFEd0DMFqZR5H4meeOiTCkPT95vbgV4tc
7mamb4kIs2rZ/JbXMZhL12iMTt4CNQaedGoorMr5vWtDwWbyEfBFkagMmY6hunUF
XR6cBP9UtsM/SBGWMkzMTHSLAyTHWXJzaFfoNd7VKs1NgsmU4phm4rhg3WFe4ra7
ce8trFhnRtTtJGXjOlu2e89ehHhUux5pNEl36lED+L/mM3b2ilBJDDYawhM9i633
pZsIb5nddE6n6ARThoVpZHq9/XDwIJaJcvBYBblLSctZzvm3IMuQzHv+f/EV3bUw
X3q6rodf4pd3VqC0D22aySWLRzlu2EedbQw8F6EG13oqVDj+/DUblpgp3rrBg7hF
gcdP4D5q3bzhrAJHnt7cY4cJVFhduudaL39WUq0R2st18l74ZUFqtg8U+g9pDTNc
62a+aZqezMzjU3fEMTbxH6e8dIXa++ky0dnkLu1+bi8cmapMHxVjOgX9QAHvsoei
QPwAKy4tqMR7uLSgwUg0
=sS29
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

--===============3249539649699674950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3249539649699674950==--
