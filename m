From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 01/12] clk: tegra: Implement memory-controller clock
Date: Fri, 14 Nov 2014 10:14:48 +0100
Message-ID: <20141114091447.GA3810@ulmo>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
	<1415871157-21968-2-git-send-email-thierry.reding@gmail.com>
	<20141114015356.25314.26550@quantum>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9204001904539124189=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141114015356.25314.26550@quantum>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============9204001904539124189==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 05:53:56PM -0800, Mike Turquette wrote:
> Quoting Thierry Reding (2014-11-13 01:32:26)
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > The memory controller clock runs either at half or the same frequency as
> > the EMC clock.
> >=20
> > Reviewed-By: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> > Mike, as I said in the cover letter there are tight dependencies betwee=
n the
> > patches in this series, so I'd like to get your Acked-by on this one so=
 I can
> > take it through the Tegra tree along with the others.
>=20
> Acked-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Thanks Mike,
Thierry

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUZcgHAAoJEN0jrNd/PrOhMHYP/0TBFjBUpKHSZWMvC6KPfReq
oNBl+ovjOmHqTwzT6LOFIg3psalvBXaeOJJJD2ptVZ+6O9ybxWJwKOEpQvdpB+GU
gnt/gtCxlViU3yOyYPDGgFNcaE9+2lVNRZtCfIsk+77BiX4+VmTT92kkEo49viBL
FsMEL2TAXQaNeihrDkFvUy+H5ZFfinSyRefYLoz5zS8sZurzMxDqJYE0j8/PwZcV
C8by1XpvzPPGswU3Dl2J2LtslW/OP0aKMEWPu2PmKJ0A/f0NhwDJj2xu2nfakahe
1N5qhlyPzqXU/eRAX8/fg04Q3t+a+hBUkKd0WjdxUmYeqfjPb6JQsZOhQsY3k0Zx
mKGuHJ4v+kmrAZqYUmhaGV06Po8F8NkWfqE8nXL6p2nEhl/tWq9eycL4GzOpeSxZ
/M9Mx5mU3DIYEXsv8J3g8B5/jRoslVHGg9sUBE8e9fupa7HfVrGGvn1+lqtNyEa4
AiCPr1OQPNlB8Kd5nHjcK8gv5cd9G3rUEvNKa85p5Uawj9HC3vFzs7dBJvs8P49z
btJHyuRjKGRob8UqBixNmub38O1D4wAvrd0PV8esMSJS8RN+Y3XXj8TDTLVo8r8W
q/OrZgg1jexW6QYo/OHNLoIL6nZClZehi7Xgy1pbQfQ5IX/54WsMwsa/Na0+weBI
jvCbOBzqFQFtg9KQXrs4
=aXHN
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--===============9204001904539124189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9204001904539124189==--
