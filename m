From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Mon, 14 Jul 2014 08:24:29 +0200
Message-ID: <20140714062428.GC2081@ulmo>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<20140712093917.GD18601@arm.com>
	<CAF6AEGutHp+3f3iPA+jjaRkqq=5T_vytZ_ESoSqsQ4RHZ8F8yQ@mail.gmail.com>
	<201407121422.02078.arnd@arndb.de>
	<CAF6AEGs7=3UByP2DLm-uwU03wr7M14x2t-0hLX-VPJ6_eZbU3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0742829637110114099=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAF6AEGs7=3UByP2DLm-uwU03wr7M14x2t-0hLX-VPJ6_eZbU3g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============0742829637110114099==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2014 at 08:57:31AM -0400, Rob Clark wrote:
> On Sat, Jul 12, 2014 at 8:22 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
[...]
> > The way that Thierry's binding does that is the obvious solution to thi=
s,
> > and it mirrors what we do in practically every other subsystem. I defin=
itely
> > want the SMMU to change before anybody starts using it in a real system,
> > which we fortunately do not have yet.
>=20
> hmm, well if some of the things I need for (like this or batching
> mappings) are too weird and gpu specific, I'm willing to duplicate the
> IOMMU driver in drm/msm.  It really isn't so much code, and that gives
> me a lot more more flexibility to do crazy things... at some point I'm
> probably going to want to do context switches by banging the IOMMU
> registers directly from the gpu.

If the IOMMU API doesn't provide for what you need, then perhaps it's
time to enhance it? We do that all the time in other parts of the
kernel, why should IOMMU be special?

It seems to me like context switching for per-process address space
isolation is one of the important features of an IOMMU. If the current
API doesn't let you do that then we should think of ways how it can be
improved. And if it doesn't do it fast enough, then we should equally
find ways to speed it up.

This is part of why I think it would be good to have explicit objects
associated with IOMMU contexts. That would give us a good place to add
caching for this kind of situation. Currently we're required to handle
most of this in drivers (map from struct device to context, ...).

Thierry

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTw3ecAAoJEN0jrNd/PrOhllsP/0whPnL6702VkDlPpAixjHP5
+OlYxfOT2jq0i53kyyqU2zhyn7L9wDnSLrqozvLD3TEdX+qxKKqiIMl8t1wSeT/P
hBoi8mtjxAAcOR/Ip5Hxl6T4OduLADaDVfsA3ox/wpz3fd9XveHBYqogM0md8vbw
8G5OafkQKOm60H/U9W++zeZRXxBEhenSkrazP4+5z7VNJSd5wQ/eQ01f7utMvJAe
c886gQLlNh6bccRsDWqQ91qL/sYbFN0vjgyauBwFxaPzJeQh5QpFN6WoUj5aUe3b
e3J/zNvnb7Pr9CqzA/3prmXc12ZGARIzAEUnwTWXz0zUM0Khs1Y7lTC5mRAEpyiy
3pTH4oDoWye6VuXtNeWqJUWfl7g9wfOP9/tWS4KmWpZg5ZGOVWN0XThHHk6/9iWd
44ta//jqbewjNHTIu3nlqTsqfMKKANuddmzpGipn4ap/CAz98Dl3IlU2fESM+5c3
UkckwetgVTj7pmwUpywUmyC7nbLD/MBOOSj9VWPv0Yw/GfyQRTLRP//iLMx1lefL
4zRqj1F6qL1lJsiHNlJ/9IQwRUmIZMfU0h7tTrnZI+TNpAvlBPQDVgso5/uVNNjf
IGEbgLjDUqKVXtfmIQ8573k7vvrNv/QdtIX+NLjCXKwmmhLDI236J2eE4ntyfedA
9PqClBrpwDTMzs7CRMTK
=EgGu
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--

--===============0742829637110114099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0742829637110114099==--
