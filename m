From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] iommu-api: Add map_range/unmap_range functions
Date: Thu, 24 Jul 2014 12:14:18 +0200
Message-ID: <20140724101417.GE3811@ulmo.nvidia.com>
References: <1405558917-7597-1-git-send-email-ohaugan@codeaurora.org>
	<1405558917-7597-2-git-send-email-ohaugan@codeaurora.org>
	<20140717082138.GC18640@ulmo> <53CDB76A.5090602@codeaurora.org>
	<20140722074507.GB18258@ulmo> <53CFF5C3.5060600@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9094024057425297550=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <53CFF5C3.5060600-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============9094024057425297550==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2014 at 10:49:55AM -0700, Olav Haugan wrote:
> On 7/22/2014 12:45 AM, Thierry Reding wrote:
> > On Mon, Jul 21, 2014 at 05:59:22PM -0700, Olav Haugan wrote:
> >> On 7/17/2014 1:21 AM, Thierry Reding wrote:
> >>> On Wed, Jul 16, 2014 at 06:01:57PM -0700, Olav Haugan wrote:
> > [...]
> >>>> Additionally, the mapping operation would be faster in general since
> >>>> clients does not have to keep calling map API over and over again for
> >>>> each physically contiguous chunk of memory that needs to be mapped t=
o a
> >>>> virtually contiguous region.
> >>>>
> >>>> Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> >>>> ---
> >>>>  drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >>>>  include/linux/iommu.h | 25 +++++++++++++++++++++++++
> >>>>  2 files changed, 73 insertions(+)
> >>>>
> >>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >>>> index 1698360..a0eebb7 100644
> >>>> --- a/drivers/iommu/iommu.c
> >>>> +++ b/drivers/iommu/iommu.c
> >>>> @@ -1089,6 +1089,54 @@ size_t iommu_unmap(struct iommu_domain *domai=
n, unsigned long iova, size_t size)
> >>>>  EXPORT_SYMBOL_GPL(iommu_unmap);
> >>>> =20
> >>>> =20
> >>>> +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
> >>>
> >>> Maybe iova should be dma_addr_t? Or at least unsigned long? And perha=
ps
> >>> iommu_map_sg() would be more consistent with the equivalent function =
in
> >>> struct dma_ops?
> >>>
> >>>> +		    struct scatterlist *sg, unsigned int len, int opt)
> >>>
> >>> The length argument seems to be the size of the mapping. Again, the
> >>> struct dma_ops function uses this argument to denote the number of
> >>> entries in the scatterlist.
> >>>
> >>> opt is somewhat opaque. Perhaps this should be turned into unsigned l=
ong
> >>> flags? Although given that there aren't any users yet it's difficult =
to
> >>> say what's best here. Perhaps the addition of this argument should be
> >>> postponed until there are actual users?
> >>
> >> I am thinking something like this:
> >>
> >> int iommu_map_sg(struct iommu_domain *domain, struct scatterlist *sg,
> >> unsigned int nents, int prot, unsigned long flags);
> >> int iommu_unmap_sg(struct iommu_domain *domain, struct scatterlist *sg,
> >> unsigned int nents, unsigned long flags);
> >=20
> > Looks good.
> >=20
> >> The iova is contained within sg so we don't need that argument really
> >=20
> > I'm not sure. I think a common use-case for this function is for some
> > driver to map an imported DMA-BUF. In that case you'll get a struct
> > sg_table, but I think it won't have sg.dma_address set to anything
> > useful. So if we don't have iova as a parameter to this function, the
> > driver would have to make it a two-step process, like this:
> >=20
> > 	sg_dma_address(sg) =3D iova;
> >=20
> > 	err =3D iommu_map_sg(...);
> >=20
> > And drivers that use the IOMMU API directly need to manage IOVA space
> > themselves anyway, so I think passing around the IOVA within the SG
> > won't be a very common case. It will almost always be the driver that
> > calls this function which allocates the IOVA range.
>=20
> Yes, I see your point. Rob is not a fan either...
> So what about this:
>=20
> int iommu_map_sg(struct iommu_domain *domain, unsigned long iova, struct
> scatterlist *sg, unsigned int nents, int prot, unsigned long flags);
> int iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
> size_t size, unsigned long flags);
>=20
> No need for sg in the unmap call then. Keeping iova an unsigned long to
> match the existing iommu_map/iommu_unmap calls.

Looks good to me. I think we may want to eventually convert iova to
dma_addr_t since that's a more appropriate type for these addresses but
we can do that in a separate patch later on.

[...]
> > For .map_sg() I think pretty much every driver will want to implement
> > it, so requiring developers to explicitly set it for their driver seems
> > like a good idea. If there's no advantage in implementing it then they
> > can always get the same functionality by explicitly using the fallback.
>=20
> I feel that requiring drivers to set the default callback defeats the
> purpose of having a fallback in the first place. The reason to provide
> the default fallback is to catch any driver that does not implement this
> themselves.

Certainly, but the exact same can be achieved by making all drivers
point to the generic implementation. In my opinion that makes it much
more explicit (and therefore obvious) what's really going on. Hiding
fallbacks in the core API obfuscates.

And this is all in-tree code, so we have full control over what we
change, so the patch that introduces this new API could simply make the
necessary adjustments to existing drivers.

Thierry

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0Nx5AAoJEN0jrNd/PrOhtX4P/3Dp2y4mbMX9PpQoKqXnGvmd
qI1zrCZTWvRsZMN3CnMw8L5aD2kzsyhQf2CsarD4qzrDz1/FkgNoNXqTX69MXxfe
+OiFzSmJb5SOL/oQugeiYB6qFFFAv5J46z6FfC9UFKhslyvQWEpDnFUde7WkIwvE
OYBMZOZKCCFpP85CYncyR7+Zpe64UGA2CtDF18+/XWeXpFaOEjAGJ+iL5udbcnaV
iXXb+mnUpca8J4kVxDhTzMwyTnhmvGgaKC8xcQKvRVLbbykjHr9DwH2zvK3VMUFy
4M3b/EQ4IPrSkC7gnLAVKVgy1elR2shWngEockCkMaVcdMEMkEZrNnc/5zo623S5
S9iWfsoWKyoYoqHURfg5wYcShSj/W3Ms/hSfJ+9eAU4Xo5Z+dK23uaXSL6rlHL9u
G5MBwIIbXB9zdS6jRqYvAQC891xd8qliIfl4m6bjax/OmYvBkY8nuvF+qksNOcjL
HBY+njncooV3m1b29KZl/mU9D+b0fOZ39Gcr3UXAMfYVZ7z+Er7k4iFKYuAqXM8O
uFMFdueY1sPp9/aQQdbj5stWY6sLEG7imKu1670D6r6M6PYiUSZEvsdIt8bLI+m1
doZo37sGv+DnvS2QV5vzh0/RMWTS0eOV1yhtoyEsaYQNJlJW/8G+14JobUP5Jp6L
1L5xgmep3mHqvn3Gv7Kc
=Re9a
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--

--===============9094024057425297550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9094024057425297550==--
