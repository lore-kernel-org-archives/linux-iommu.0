From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Thu, 15 Jan 2015 09:28:44 +0100
Message-ID: <20150115082843.GB30799@ulmo>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<1417453034-21379-9-git-send-email-will.deacon@arm.com>
	<54B63028.3090701@nvidia.com> <20150114104610.GC4050@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0777784068354626429=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150114104610.GC4050-5wv7dgnIgG8@public.gmane.org>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============0777784068354626429==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 10:46:10AM +0000, Will Deacon wrote:
> On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
[...]
> > 2) Say you want to use the IOMMU API in your driver, and have an iommu=
=20
> > property in your device's DT node. If by chance your IOMMU is registere=
d=20
> > early, you will already have a mapping automatically created even befor=
e=20
> > your probe function is called. Can this be avoided? Is it even safe?
>=20
> Currently, I think you have to either teardown the ops manually or return
> an error from of_xlate. Thierry was also looking at this sort of thing,
> so it might be worth talking to him.

I already explained in earlier threads why I think this is a bad idea.
It's completely unnatural for any driver to manually tear down something
that it didn't want set up in the first place. It also means that you
have to carefully audit any users of these IOMMU APIs to make sure that
they do tear down. That doesn't sound like a good incremental approach,
as evidenced by the breakage that Alex and Heiko have encountered.

The solution for me has been to completely side-step the issue and not
register the IOMMU with the new mechanism at all. That is, there's no
=2Eof_xlate() implementation, which means that the ARM DMA API glue won't
try to be smart and use the IOMMU in ways it's not meant to be used.
This has several advantages, such as that I can also use the regular
driver model for suspend/resume of the IOMMU, and I get to enjoy the
benefits of devres in the IOMMU driver. Probe ordering is still a tiny
issue, but we can easily solve that using explicit initcall ordering
(which really isn't any worse than IOMMU_OF_DECLARE()).

Ideally of course I could use deferred probing to solve that. Hiroshi
and I posted patches to implement that over a year ago[0], but it was
mostly ignored after some, in my opinion, fruitful discussion.

That patch requires drivers to explicitly call iommu_attach() to
advertise that they want to use the IOMMU. This was done because a
previous attempt to call iommu_attach() from the driver core was
rejected on the sole argument that "it doesn't belong in the core",
without further explanation.

Note that with that approach things all happen at driver probe time, so
we can simply return -EPROBE_DEFER when the IOMMU isn't ready yet. At
the same time the IOMMU can be a regular driver just like any of the
other resource providers like clocks, regulators, etc.

That all said, I'm fine with the current situation, too. Nobody can
force the Tegra SMMU driver to register via IOMMU_OF_DECLARE() and I'm
actively recommending the use of the IOMMU API directly. That way we
get the control we need for drivers where it matters most (i.e. where
close control of the address space and switching of address spaces per
process are needed). Any other drivers, like USB or SDMMC simply use
the DMA API and get their buffers from a contiguous pool.

Thierry

[0]: https://lkml.org/lkml/2014/6/26/476

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUt3o7AAoJEN0jrNd/PrOhI+sQAIX3gMSf0ZP8k9cIIB5a10AC
b1FNnCIDAnjH18Ertv/S9aWcSE2nv7HyfXzcnjFr9m1FPZWD7m9iCTV5STZrtK6G
NbbSaKfnXcN1xPwunv/nMlY1DsLjQLm7SjqatL2JlDbMA07V3NaikBfiYIVrLz5q
M0l9ylKEz+AwjcoJUyfVlFwSQ9ruQqTxPWgOU0BiSuoCFOmv4uOavWJxnndZ6sFG
R4QifpaITve4Y16l15tEBMN6wB4hl1ORiBCvFoL3b67cY43JxQdpmHViZalV3PO0
AvghLV7uLHtBNdMs7V4Py+m3m3en/nSQS3+2vVtIEDvz5TVxKhzZBC1rQivXHNLj
YAx/iv5vsnwpVW6Gdgub6U3zvGpbTDzzbUhx7vc8QPMw9R19qZjPAIYJh2GdQYwG
fCs34sF87J29PoK/AiNfrdIoNVkTFiv1VYbM8jy6QtFkBE2cqvH2tjmRKUvICIfN
qz8pBvQp9SMx0u5ZdE16RC8/mdHES7JSulZrvWayTQxWz9d4Dzd7OoXAVCg4E6ES
pQS8m+kYJ/4BL2Y6YE/gqB3f9DJA19LFSFYQJQN05p/FZp7/UNiZC8nWsEz5GRhZ
R+WQ2GzPOmCGPb0PwnuacgSc3KLkN4R19lPnz91urbnkHnac5R2iMoxdH6686K3a
bH/QI9A7bdNQGs1bJWQi
=5vlm
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

--===============0777784068354626429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0777784068354626429==--
