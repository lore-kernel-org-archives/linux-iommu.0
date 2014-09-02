From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [RFC PATCH 1/7] iommu: provide early initialisation hook for
	IOMMU drivers
Date: Tue, 02 Sep 2014 09:56:12 +0300
Message-ID: <5261873.R44Dyo67Nf@avalon>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<1409327670-3495-2-git-send-email-will.deacon@arm.com>
	<20140901075216.GA24430@ulmo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1254661840268886731=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140901075216.GA24430@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============1254661840268886731==
Content-Type: multipart/signed; boundary="nextPart11462514.U0VALDcW0r"; micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart11462514.U0VALDcW0r
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Monday 01 September 2014 09:52:19 Thierry Reding wrote:
> On Fri, Aug 29, 2014 at 04:54:24PM +0100, Will Deacon wrote:
> > IOMMU drivers must be initialised before any of their upstream devi=
ces,
> > otherwise the relevant iommu_ops won't be configured for the bus in=

> > question. To solve this, a number of IOMMU drivers use initcalls to=

> > initialise the driver before anything has a chance to be probed.
> >=20
> > Whilst this solves the immediate problem, it leaves the job of prob=
ing
> > the IOMMU completely separate from the iommu_ops to configure the I=
OMMU,
> > which are called on a per-bus basis and require the driver to figur=
e out
> > exactly which instance of the IOMMU is being requested. In particul=
ar,
> > the add_device callback simply passes a struct device to the driver=
,
> > which then has to parse firmware tables or probe buses to identify =
the
> > relevant IOMMU instance.
> >=20
> > This patch takes the first step in addressing this problem by addin=
g an
> > early initialisation pass for IOMMU drivers, giving them the abilit=
y to
> > set some per-instance data on their of_node. This data can then be
> > passed back to a new add_device function (added in a later patch) t=
o
> > identify the IOMMU instance in question.
> >=20
> > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > ---
> >=20
> >  drivers/iommu/of_iommu.c          | 14 ++++++++++++++
> >  include/asm-generic/vmlinux.lds.h |  2 ++
> >  include/linux/of_iommu.h          | 21 +++++++++++++++++++++
> >  3 files changed, 37 insertions(+)
>=20
> I don't think this is the right direction. We've been preaching that
> using initcall ordering is a bad thing and people should be using
> deferred probe instead. Now we have a bunch of these OF tables that d=
o
> the exact opposite. Note that these are nothing more than a variant o=
f
> initcalls that get called at platform-specific points in time.

My idea to solve this problem was to defer probing of the bus master de=
vice=20
from=20the add_device IOMMU operation. This obviously won't work with add=
_device=20
called from the BUS_NOTIFY_ADD_DEVICE notifier, which led me to naively=
 wonder=20
whether we couldn't call the add_device operation from the=20
BUS_NOTIFY_BIND_DRIVER notifier instead.

> There are also ongoing discussions about how to change the device pro=
be
> order to use dependencies (such as phandles from device tree) to prev=
ent
> excessive deferred probing. With that in place this would be solved i=
n a
> much more generic way.

=2D-=20
Regards,

Laurent Pinchart

--nextPart11462514.U0VALDcW0r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUBWoSAAoJEIkPb2GL7hl1wOsIALWDUPL1tvgbDlwSNg2px9DI
1hoL1356mkPp0Cb1vh6U0pyHzmG8606oUSA5EfjRhETF0h5m/b2zHFj0d3weXAnq
EHdhTt1KPoFNjvQGN+tmGvcaOk6dM1AOCEJgNO/IHAP6wF4QdZJtHziyNbETGEAU
qQsS0eASZe4whDAButjLko9UhFI20c5ixgxCOX0ufVt+CFL1hN5WhuFNwoDxkVfB
VlwouuGly2f/iQvYIiYl/IFSoJ9uQbgwgLFq9gsXofUHv52gR80+BGT5obvrzBIx
EnbmjKV3RbXR4TyPTIY6C1OL+z54bsYUuCUKEsr2KVnEgGPoE+6k6/wgKdac/ZY=
=0e/C
-----END PGP SIGNATURE-----

--nextPart11462514.U0VALDcW0r--


--===============1254661840268886731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1254661840268886731==--
