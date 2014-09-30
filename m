From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/2] iopoll: Introduce memory-mapped IO polling macros
Date: Tue, 30 Sep 2014 08:04:43 +0200
Message-ID: <20140930060442.GF29874@ulmo>
References: <1411874849-343-1-git-send-email-mitchelh@codeaurora.org>
	<1411874849-343-2-git-send-email-mitchelh@codeaurora.org>
	<20140929083136.GG12506@ulmo>
	<vnkwmw9il6ft.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0149921722164149123=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <vnkwmw9il6ft.fsf-Yf+dfxj6toJBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============0149921722164149123==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Content-Disposition: inline


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2014 at 09:47:34AM -0700, Mitchel Humpherys wrote:
> On Mon, Sep 29 2014 at 01:31:37 AM, Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > On Sat, Sep 27, 2014 at 08:27:28PM -0700, Mitchel Humpherys wrote:
> >> From: Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >>=20
> >> It is sometimes necessary to poll a memory-mapped register until its
> >> value satisfies some condition. Introduce a family of convenience macr=
os
> >> that do this. Tight-loop and sleeping versions are provided with and
> >> without timeouts.
> >>=20
> >> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> >> Signed-off-by: Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >> ---
> >>  include/linux/iopoll.h | 77 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 77 insertions(+)
> >>  create mode 100644 include/linux/iopoll.h
> >
> > It would be good to provide a changelog with each new version of the
> > patch. As it is I now have v2 and v3 of this patch in my inbox and I
> > have no idea what the differences are, so I'd need to download both
> > and run them through interdiff to find out.
>=20
> Yeah I put the changelog in the cover letter.  There were no changes on
> this patch, though I admit that wasn't entirely clear now re-reading the
> cover letter text.  I also didn't account for the fact that you probably
> aren't reading the whole series since I only Cc'd you on this patch, not
> the whole series.  In any case, I probably shouldn't have re-sent the
> whole series after one minor modification to one patch in the series.

No worries, thanks for clarifying.

Thierry

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUKkf5AAoJEN0jrNd/PrOhfGcP/jNwdsdaqV8Cuv+NjxR+1Vut
l3YCUpXDW3Y6IyzjXQIdydjAa9zgO4FwKIq24x0vks/SSJQ3WsXJSZx9FmUY+b7Z
8VtslQEK1rr9k9oNKfVkVp7e3c/Y7RrTJvqWR4Pq3f3oF9QzuwXKUdJ/IsO+ZL8A
oOQIqTqM5anW/szmdl2kUVtDLh1R9caPSdZCWANe6SKE+pI5MNj7IpOIkIzKv/og
Hu8iLNqx9Wj58cERNqmAlNOUwA032kOsRRxFTioK/E/FykA2GByXY5zc77kFoNEd
Mmla+RurGTb8B+lrlddbnAQ0wzRBEM8vXZVMKQ/ECPcjIMMshrVigXJJsUR9sZL+
LQL9R6b7xWBLU9cJwfcX73DZqJcvLQh8kRi+qvSbkgvPQ9gwXTFiJRh+bVfrNxTg
vRHntoEBxpnoyYVasI6K30l091NuzoPO8OaWmyx5XhoGrS2u+7eau5vFmhmP3Q08
TFr8oKuB9fyMd4PfXvuLT3TUSGf0ptsR474DiSvh8nwq4Q7tW8BBBS3zIflfRM5J
Yei/J5iVPHX6jwXPG8n5Hebw3hT5/wAScmGa7Vgqom11jS1Ej22cAawGn1hPCiyc
EI2fPnpyTyVHAW0m/t93fcDWkZw54XM28lc3skhoZ3yrfVsrGvvbEIeaczhMmo/6
xE400mOCHNWxdrUTNg26
=EO0/
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--

--===============0149921722164149123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0149921722164149123==--
