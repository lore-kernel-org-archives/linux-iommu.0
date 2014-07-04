From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 01/10] iommu: Add IOMMU device registry
Date: Fri, 4 Jul 2014 15:47:10 +0200
Message-ID: <20140704134709.GA4203@ulmo>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
	<1403815790-8548-2-git-send-email-thierry.reding@gmail.com>
	<20140704110529.GF13434@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5568363894153179835=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140704110529.GF13434-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Allen Martin <amartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============5568363894153179835==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2014 at 01:05:30PM +0200, Joerg Roedel wrote:
> On Thu, Jun 26, 2014 at 10:49:41PM +0200, Thierry Reding wrote:
> > Add an IOMMU device registry for drivers to register with and implement
> > a method for users of the IOMMU API to attach to an IOMMU device. This
> > allows to support deferred probing and gives the IOMMU API a convenient
> > hook to perform early initialization of a device if necessary.
>=20
> Can you elaborate on why exactly you need this? The IOMMU-API is
> designed to hide any details from the user about the available IOMMUs in
> the system and which IOMMU handles which device. This looks like it is
> going in a completly different direction from that.

I need this primarily to properly serialize device probing order.
Without it the IOMMU may be probed later than its clients, in which case
the client drivers will assume that there is no IOMMU (iommu_present()
for the parent bus fails).

There are other ways around this, but I think we'll need to eventually
come up with something like this anyway. Consider for example what
happens when a device has master interfaces on two different IOMMUs. Not
only does the current model of having one and one only IOMMU per struct
bus_type break down, but also IOMMU masters will need a way to specify
which IOMMU they're talking to.

Thierry

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtrBdAAoJEN0jrNd/PrOhzl0P/iwj8bP8nXBSPf/py2sTO2lo
r6ME8Ag48kI8cccEXWQgDCmaw8mKPF8Tf6Wbtjzgd+aFSGuDyG5DdRu90yFGNYJz
y+WZapVkdCIVt2HhgtqrldVEi4+1Ins2PWP6iqzHp4SJ0NAFZwWMeTkHLEQQC3Wm
HrDBZJJ4SpS4SiNGElZ5cfmZOXHO1nPYMPdvDTFmRAtFpLgSvWrqEyoRGl6AKhip
t4VLiUUEd2Mi1hR1UwDVrKsUX4nz6KGFhUSHe49MaITkUHzAwZ6gdxIYBMcZ/G1b
09O2MBhJvtRMsGsCd7q4sa1dj5tDxTDn5kUz3BOyL2pAxeOIIH+f7RqHd3/AWBbv
djJlFR8nFmqo/DuwM00U+i40u3yLtJm8OWZOh15JKoIp64AWdjZ6GuMHRrM553wA
pRJIIYewjngLR8cLvC2s27bl0ZwQUjYP02rHZGlpqTKstAwnOcjhv8AW6gEijV7I
xgZLXqDBvf4aVZNeXSYCycxcndRjzQ4AG0WIdGBv+iloPkP4e7znMuVxvueiLMVq
EcPwYdRcwnSVLSaP+vk5WNYrM7Iml7xA8jZ42m3EK9SpFzVkqVG62h8+C8jzeJT3
EdmRD5GMqBdh60jpt58HZitnb9kHAujF1smMeRjxlcXGZNsQQy/shK6gHFcsfz71
OSkMzl9QvDDINi9jjBvG
=7jBS
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

--===============5568363894153179835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5568363894153179835==--
