From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 01/22] [HACK] of: dev_node has struct device pointer
Date: Tue, 16 Jul 2013 16:16:30 -0700
Message-ID: <20130716231629.GA12189@dhcp-172-17-186-34.nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-2-git-send-email-hdoyu@nvidia.com>
 <51E5CFBF.5080407@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51E5CFBF.5080407-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2013 at 04:57:03PM -0600, Stephen Warren wrote:
> On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> > To prevent of_platform_populate() from trying to populate duplicate
> > devices if a device has been already populated.
>=20
> You need to send drivers/of patches to the DT maintainer and
> devicetree-discuss mailing list.
>=20
> > Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> > Need to take care of early_platform_devices, or alternative solution.
>=20
> I assume that's a TODO item... Are you planning on fleshing out this
> patch to address that issue?

There was some more discussion about it, which can be found in the
following thread:

	https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-June/036934.html

That's one of the last messages and it should have most of the
background. If not you may have to walk up the thread for more context.
In a nutshell I raised the question as to why we can't simply call
of_platform_populate() earlier and side-step all the workarounds that
have found their way into the kernel to side-step the issue of their not
being a struct device associated with the struct device_node.

If of_platform_populate() can be made to run early, then we can restore
a whole lot of consistency in how "early" drivers on an OF kernel work.

Thierry

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJR5dRNAAoJEN0jrNd/PrOhI34P/As6cnuKkK0vSgCAqf9P4Jm8
H8VOToIu/BrmJoeuthnDcd0aCXp6o6g+w4NuCDjfPpj/64izOm5S0dtdlRI1BiRH
VEVPqsxW6AsucuSUThCRAPWhSoQPCNOcKcJAltmGAVTQqNCbExC0YGT7cnoU2mPS
FalYvmaSWiEgsjk/joIbb4+PvRdPppp+G7+fZYeFtcpB/F/V2F+Eyjt1+aPYOfFR
GeESl+YY7qrHYCyTI/rKIaMLe3WpFFHPHHPPNrwop0LOmXhmvhEszHrYSuhctLmN
LIDnlz33jT+Og8soJyt+GtlFvFOsz4Mpkczprogr/1wIOjESm3SaSA+7Zdqsw0uO
DxemIWJplkhGRtAFsMkZ4v0sSUFAppRIfciO159vPgUkR6fIZkyIoGJqdxH3RD7w
UdZER0X/kPGIatqjr1IFCCouLuCUs4lTvGRP3Yg+s8kr/Mwh5T/tpYvMHP0KMPpk
moLj1PIyGNo33C2oWs/FGVYul9sH0kA1pjhrHfS24BouNn80Q7gEu8RoVKk58ogo
lX926gmhK74Vcd5QyuA6ibleDFWDlwk6Vpv4grrr/cZPoA/5dSXr2Ri808nFxBHx
lhoiFr5+hNILnDUPp7KPzQUdylIZGMLwT7jpI58VOaZoBjTMniwMUkpjcsvCsbEW
5san+TeU+KOInl81Qb9H
=rUnH
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
