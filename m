From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/tegra-gart: Add support for struct iommu_device
Date: Thu, 17 Aug 2017 15:52:30 +0200
Message-ID: <20170817135230.GF6854@ulmo>
References: <1502317752-8792-1-git-send-email-joro@8bytes.org>
	<1502317752-8792-3-git-send-email-joro@8bytes.org>
	<66711b72-455f-8ec1-e6f7-5946480dde14@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0831096526300649418=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <66711b72-455f-8ec1-e6f7-5946480dde14-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============0831096526300649418==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
Content-Disposition: inline


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 01:21:52AM +0300, Dmitry Osipenko wrote:
> Hello Joerg,
>=20
> On 10.08.2017 01:29, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> >=20
> > Add a struct iommu_device to each tegra-gart and register it
> > with the iommu-core. Also link devices added to the driver
> > to their respective hardware iommus.
> >=20
> > Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > ---
> >  drivers/iommu/tegra-gart.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
>=20
> Reviewed-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> > diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> > index 29bafc6..b62f790 100644
> > --- a/drivers/iommu/tegra-gart.c
> > +++ b/drivers/iommu/tegra-gart.c
>=20
> [snip]
>=20
> > @@ -449,6 +472,9 @@ static int tegra_gart_remove(struct platform_device=
 *pdev)
> >  {
>=20
> BTW, GART's driver can't be build as a module, so this function is pretty=
 much a
> dead code. Probably worth considering its removal.

Technically you can unbind the driver via sysfs, in which case this
function would still be called. That said, all sorts of things will
probably start to crash when you do that. I'd like to think that we
will eventually be able to deal with this sanely (there's some work
in progress to establish stronger links between devices, so that we
can sanely deal with this kind of dependency), so I think it's okay
to keep this around in case we ever get there.

I don't have any objections to making the driver unloadable if that
is what everyone else prefers, though. In that case, however, there
are more steps involved than just removing the ->remove() callback.

Thierry

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmVn50ACgkQ3SOs138+
s6G+pw/+N47d0Q/FBFSXF7asDzpRdB2WCkDDmdOY1c6Nhy1CJGstMCeKNZVkfq2q
T0j4ze0ZcXOQhzQ+lT4Wm0eGZltdxHsSECzOyj4yyQDiS8GAIPccLRsOsDXuchoQ
IHqCsmBXJ87XNT2l+BHHloMx6OvC7cCpDTFk2YKFTR1h+2blbW7epj+wSUepVQc1
eJhtF4tNtHK8tm1dcYdckcMYRDfHHU50zqn3cg8WfuD5JTMMWRILa2lJ5UMFVHk9
ptnvMbtMuXfXXvtZ48XX1q67rVfToqHoYpMtfOXwYtpDh4PkdYZOXOBc9tTC8vLh
tK57C2HiRFBLqcnIA+ci1xM4OUnhvuFVDaquMBJgsbQq1iaSPmrbGrYgP2YuH8Ga
HIgEZyFha7c+jHW0+7tfiSSM5lGmDMBPXWmTU0UXKgiQyY7sgbckBMBjDey6MMcY
VCwcAuKBvk2jirIomviR2y6EUPc1kEwzgJneTevmjSHUHj+9zscq3v7EfZiJVqNM
SQ1v476KBXhrpb6V9xVq4I809jjfVXUWhHQ4eS+HcjxOtQtCtnKpjTCbyXTgPmCr
TTePo8ZhzlwKhdQEv2N8N9XzfTlSG/IWFdpiO0ptHtEXYw6d9XJ1ncZovRh2k4RR
ioY5CCLKXpNYQfQSLgQdGjw1jFEwCR8KiumxKW8xtojHNRswgA0=
=PK8v
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--

--===============0831096526300649418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0831096526300649418==--
