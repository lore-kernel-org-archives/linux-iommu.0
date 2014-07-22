From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] iommu-api: Add map_range/unmap_range functions
Date: Tue, 22 Jul 2014 09:45:08 +0200
Message-ID: <20140722074507.GB18258@ulmo>
References: <1405558917-7597-1-git-send-email-ohaugan@codeaurora.org>
	<1405558917-7597-2-git-send-email-ohaugan@codeaurora.org>
	<20140717082138.GC18640@ulmo> <53CDB76A.5090602@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5479414358174284509=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <53CDB76A.5090602-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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


--===============5479414358174284509==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2014 at 05:59:22PM -0700, Olav Haugan wrote:
> On 7/17/2014 1:21 AM, Thierry Reding wrote:
> > On Wed, Jul 16, 2014 at 06:01:57PM -0700, Olav Haugan wrote:
[...]
> > > Additionally, the mapping operation would be faster in general since
> > > clients does not have to keep calling map API over and over again for
> > > each physically contiguous chunk of memory that needs to be mapped to=
 a
> > > virtually contiguous region.
> > >
> > > Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > > ---
> > >  drivers/iommu/iommu.c | 48 +++++++++++++++++++++++++++++++++++++++++=
+++++++
> > >  include/linux/iommu.h | 25 +++++++++++++++++++++++++
> > >  2 files changed, 73 insertions(+)
> > >
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 1698360..a0eebb7 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -1089,6 +1089,54 @@ size_t iommu_unmap(struct iommu_domain *domain=
, unsigned long iova, size_t size)
> > >  EXPORT_SYMBOL_GPL(iommu_unmap);
> > > =20
> > > =20
> > > +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
> >=20
> > Maybe iova should be dma_addr_t? Or at least unsigned long? And perhaps
> > iommu_map_sg() would be more consistent with the equivalent function in
> > struct dma_ops?
> >=20
> >> +		    struct scatterlist *sg, unsigned int len, int opt)
> >=20
> > The length argument seems to be the size of the mapping. Again, the
> > struct dma_ops function uses this argument to denote the number of
> > entries in the scatterlist.
> >=20
> > opt is somewhat opaque. Perhaps this should be turned into unsigned long
> > flags? Although given that there aren't any users yet it's difficult to
> > say what's best here. Perhaps the addition of this argument should be
> > postponed until there are actual users?
>=20
> I am thinking something like this:
>=20
> int iommu_map_sg(struct iommu_domain *domain, struct scatterlist *sg,
> unsigned int nents, int prot, unsigned long flags);
> int iommu_unmap_sg(struct iommu_domain *domain, struct scatterlist *sg,
> unsigned int nents, unsigned long flags);

Looks good.

> The iova is contained within sg so we don't need that argument really

I'm not sure. I think a common use-case for this function is for some
driver to map an imported DMA-BUF. In that case you'll get a struct
sg_table, but I think it won't have sg.dma_address set to anything
useful. So if we don't have iova as a parameter to this function, the
driver would have to make it a two-step process, like this:

	sg_dma_address(sg) =3D iova;

	err =3D iommu_map_sg(...);

And drivers that use the IOMMU API directly need to manage IOVA space
themselves anyway, so I think passing around the IOVA within the SG
won't be a very common case. It will almost always be the driver that
calls this function which allocates the IOVA range.

> and I would like to keep the flags argument. I would prefer not to
> change the API after it has been published which could potentially
> affect a lot of call sites.

We have pretty good tools to help with this kind of mechanical
conversion, so I don't think changing the API will be much of a problem.
However it seems likely that we'll want to specify flags eventually, so
I don't have any strong objections to keeping that parameter.

> >> +			phys_addr_t phys =3D page_to_phys(sg_page(sg));
> >> +			u32 page_len =3D PAGE_ALIGN(sg->offset + sg->length);
> >=20
> > Shouldn't this alignment be left to iommu_map() to handle? It has code
> > to deal with that already.
>=20
> I don't see page alignment in the iommu_map function. I only see a check
> whether the (iova | paddr | size) is aligned to the minimum page size
> and then it errors out if it isn't....

Indeed, the above doesn't do what I thought it did.

> > Perhaps rather than check for a ->map_range implementation everytime a
> > better option may be to export this generic implementation so that
> > drivers can set it in their iommu_ops if they don't implement it? So the
> > contents of the if () block could become a new function:
> >=20
> > 	int iommu_map_range_generic(...)
> > 	{
> > 		...
> > 	}
> > 	EXPORT_SYMBOL(iommu_map_range_generic);
> >=20
> > And drivers would do this:
> >=20
> > 	static const struct iommu_ops driver_iommu_ops =3D {
> > 		...
> > 		.map_range =3D iommu_map_range_generic,
> > 		...
> > 	};
>=20
> I'd like to keep the new API consistent with the rest of the API. Most
> if not all of the other APIs always check if the operation is non-NULL.

But that's because the other operations are either optional or they
don't provide a fallback implementation. For .map_sg() the issue is
different because the core provides a slow fallback. The disadvantage
of keeping the check within iommu_map_sg() is that you have this check
every time the function is called. If on the other hand drivers
specifically set a pointer (either a custom implementation or the
wrapper around iommu_map()) you'll simply call the driver function no
matter what and don't have to special case.

It also makes it possible for drivers to opt-in to using the generic
fallback. Currently if driver writers don't set it explicitly they'll
silently get a fallback implementation and they may not even notice.

> A new driver could choose not to set the .map_range callback. I think it
> is better to keep this consistent with the behavior of the other APIs.

I'd argue that it's more consistent to not provide the fallback by
default. None of the other functions do that. If the driver doesn't
implement a callback then the iommu_*() functions will return an error.

For .map_sg() I think pretty much every driver will want to implement
it, so requiring developers to explicitly set it for their driver seems
like a good idea. If there's no advantage in implementing it then they
can always get the same functionality by explicitly using the fallback.

> >> +int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
> >> +		      unsigned int len, int opt)
> >=20
> > Some comments regarding function name and argument types as for
> > iommu_map_range().
> >=20
> >> +static inline int iommu_map_range(struct iommu_domain *domain,
> >> +				  unsigned int iova, struct scatterlist *sg,
> >> +				  unsigned int len, int opt)
> >> +{
> >> +	return -ENODEV;
> >=20
> > I know other IOMMU API dummies already use this error code, but I find
> > it to be a little confusing. The dummies are used when the IOMMU API is
> > disabled via Kconfig, so -ENOSYS (Function not implemented) seems like a
> > more useful error.
>=20
> Again, I would prefer to keep this consistent with the other APIs
> already there. iommu_map/iommu_unmap both returns -ENODEV. If we want to
> change this I think this should be done as a separate patch that changed
> all of them to be consistent.

Fair enough.

Thierry

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTzhaDAAoJEN0jrNd/PrOhrZwP/RzCb3glAODLpFZrjv2E9onI
xy9aQRd28yGNsZu9r5pxugm8p/QswPZsDHXB18upGpJvSbvKfePXhDYemsj4Jh73
towi141xf53hgjeZVN4/ywZffDwrGNLSZ9dAYGLtUp8h/oV4WnjUP/ZD3QHkx4Wr
WcBKV8zXAIGbdMiybPnTQtHHe6hj6XvsHRRFUyB5/lH4c3eEGEuUNUyPZ/z71TA6
M9Jp6lW0vMQBe18LAOZNbxpu96Sz+wRTtkBeN3SxoG71gbmVtU0rNTfbbgnvd4z9
CJZTd2jMr1yeS9a8Fs5GQelrF1hlVFBnvp5M1E7w8qy3rewe5SSxxd97aGszNApy
/nWxPb+TJ46L0pY1RcbViAFHa1CYnD8P1UUsMmNExcamsUfJ9W7cx4WkbY9Su+oj
37ESGBAX2soHkGX/jxtveHhpehDrMad7I9ziQtRsDsRW5rlWN9yfzlWcf5azo5cM
7fPgV+Si+CU/gMdA/+GPFizY0wMSaPA9N4KgRuRwuq+J2z8Q5l2H+DyjcGu/PDWw
Qy8iRpExI7DvDHqPz+sqZSqkem55fTQBeUryfnY8KtfVFhMcI9tIYyXyXrkl/WQS
YkUyH3OuAA2VBve56uVKaHMHnFrc+7irK4uknayDabC3e8cDxSE37/zGChpzRGct
W59OZqTfibWYFsQNT+vb
=PdJP
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--

--===============5479414358174284509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5479414358174284509==--
