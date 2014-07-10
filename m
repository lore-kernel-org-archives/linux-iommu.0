From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC/PATCH 2/7] iommu-api: Add map_range/unmap_range functions
Date: Thu, 10 Jul 2014 09:10:15 +0200
Message-ID: <20140710071014.GA17918@ulmo>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
 <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
 <20140704072940.c1e8e8cdd38fbc295fe5c086@nvidia.com>
 <53BC6866.30803@codeaurora.org>
 <CAF6AEGvpD+gvDvQte6YVOP8Q6NeXsoReQ_waWqjsMjffUzALOA@mail.gmail.com>
 <53BDD834.5030405@codeaurora.org>
 <CAF6AEGucNbo7sm9oQWFq9hcfoSeR5DuwRcRUvG+Y2sxLaM7OTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGucNbo7sm9oQWFq9hcfoSeR5DuwRcRUvG+Y2sxLaM7OTQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Olav Haugan <ohaugan@codeaurora.org>, Hiroshi Doyu <hdoyu@nvidia.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "vgandhi@codeaurora.org" <vgandhi@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 08:40:21PM -0400, Rob Clark wrote:
> On Wed, Jul 9, 2014 at 8:03 PM, Olav Haugan <ohaugan@codeaurora.org> wrot=
e:
> > On 7/8/2014 4:49 PM, Rob Clark wrote:
> >> On Tue, Jul 8, 2014 at 5:53 PM, Olav Haugan <ohaugan@codeaurora.org> w=
rote:
> >>> Hi Hiroshi,
> >>>
> >>> On 7/3/2014 9:29 PM, Hiroshi Doyu wrote:
> >>>> Hi Olav,
> >>>>
> >>>> Olav Haugan <ohaugan@codeaurora.org> writes:
> >>>>
> >>>>> Mapping and unmapping are more often than not in the critical path.
> >>>>> map_range and unmap_range allows SMMU driver implementations to opt=
imize
> >>>>> the process of mapping and unmapping buffers into the SMMU page tab=
les.
> >>>>> Instead of mapping one physical address, do TLB operation (expensiv=
e),
> >>>>> mapping, do TLB operation, mapping, do TLB operation the driver can=
 map
> >>>>> a scatter-gatherlist of physically contiguous pages into one virtual
> >>>>> address space and then at the end do one TLB operation.
> >>>>>
> >>>>> Additionally, the mapping operation would be faster in general since
> >>>>> clients does not have to keep calling map API over and over again f=
or
> >>>>> each physically contiguous chunk of memory that needs to be mapped =
to a
> >>>>> virtually contiguous region.
> >>>>>
> >>>>> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
> >>>>> ---
> >>>>>  drivers/iommu/iommu.c | 24 ++++++++++++++++++++++++
> >>>>>  include/linux/iommu.h | 24 ++++++++++++++++++++++++
> >>>>>  2 files changed, 48 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >>>>> index e5555fc..f2a6b80 100644
> >>>>> --- a/drivers/iommu/iommu.c
> >>>>> +++ b/drivers/iommu/iommu.c
> >>>>> @@ -898,6 +898,30 @@ size_t iommu_unmap(struct iommu_domain *domain=
, unsigned long iova, size_t size)
> >>>>>  EXPORT_SYMBOL_GPL(iommu_unmap);
> >>>>>
> >>>>>
> >>>>> +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
> >>>>> +                struct scatterlist *sg, unsigned int len, int prot)
> >>>>> +{
> >>>>> +    if (unlikely(domain->ops->map_range =3D=3D NULL))
> >>>>> +            return -ENODEV;
> >>>>> +
> >>>>> +    BUG_ON(iova & (~PAGE_MASK));
> >>>>> +
> >>>>> +    return domain->ops->map_range(domain, iova, sg, len, prot);
> >>>>> +}
> >>>>> +EXPORT_SYMBOL_GPL(iommu_map_range);
> >>>>
> >>>> We have the similar one internally, which is named, "iommu_map_sg()",
> >>>> called from DMA API.
> >>>
> >>> Great, so this new API will be useful to more people!
> >>>
> >>>>> +int iommu_unmap_range(struct iommu_domain *domain, unsigned int io=
va,
> >>>>> +                  unsigned int len)
> >>>>> +{
> >>>>> +    if (unlikely(domain->ops->unmap_range =3D=3D NULL))
> >>>>> +            return -ENODEV;
> >>>>> +
> >>>>> +    BUG_ON(iova & (~PAGE_MASK));
> >>>>> +
> >>>>> +    return domain->ops->unmap_range(domain, iova, len);
> >>>>> +}
> >>>>> +EXPORT_SYMBOL_GPL(iommu_unmap_range);
> >>>>
> >>>> Can the existing iommu_unmap() do the same?
> >>>
> >>> I believe iommu_unmap() behaves a bit differently because it will keep
> >>> on calling domain->ops->unmap() until everything is unmapped instead =
of
> >>> letting the iommu implementation take care of unmapping everything in
> >>> one call.
> >>>
> >>> I am abandoning the patch series since our driver was not accepted.
> >>> However, if there are no objections I will resubmit this patch (PATCH
> >>> 2/7) as an independent patch to add this new map_range API.
> >>
> >> +1 for map_range().. I've seen for gpu workloads, at least, it is the
> >> downstream map_range() API is quite beneficial.   It was worth at
> >> least a few fps in xonotic.
> >>
> >> And, possibly getting off the subject a bit, but I was wondering about
> >> the possibility of going one step further and batching up mapping
> >> and/or unmapping multiple buffers (ranges) at once.  I have a pretty
> >> convenient sync point in drm/msm to flush out multiple mappings before
> >> kicking gpu.
> >
> > I think you should be able to do that with this API already - at least
> > the mapping part since we are passing in a sg list (this could be a
> > chained sglist).
>=20
> What I mean by batching up is mapping and unmapping multiple sglists
> each at different iova's with minmal cpu cache and iommu tlb flushes..
>=20
> Ideally we'd let the IOMMU driver be clever and build out all 2nd
> level tables before inserting into first level tables (to minimize cpu
> cache flushing).. also, there is probably a reasonable chance that
> we'd be mapping a new buffer into existing location, so there might be
> some potential to reuse existing 2nd level tables (and save a tiny bit
> of free/alloc).  I've not thought too much about how that would look
> in code.. might be kinda, umm, fun..
>=20
> But at an API level, we should be able to do a bunch of
> map/unmap_range's with one flush.
>=20
> Maybe it could look like a sequence of iommu_{map,unmap}_range()
> followed by iommu_flush()?

Doesn't that mean that the IOMMU driver would have to keep track of all
mappings until it sees an iommu_flush()? That sounds like it could be a
lot of work and complicated code.

Thierry

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTvjxWAAoJEN0jrNd/PrOhzZ0P/jvmVHkJ7ZQAQkk8u3l7g3wv
lO1UORARItGfIcvHNVdzyoNBDwL0aXD80zxSFpFFu2rpuK7wDl7BKq2CUQFXEEYI
cAUOjJyLIiOGokjmNskruSG3KYzlJt2J2mxkO1tYXc2csMAD9Iu82Dwc3cxg29bE
KrtIqAZmLOqdIGZV9TIqzGs6JTDGejLUsdxkUjrhqT9+iJ6JGKd8cCa4itm4zKX9
XDviS4N11DMC1BjrQasy008w7XCozwcS8kZnQiH2H+Ji06FskXu3ZanKwSYfDJbz
yS5Gd40DCH8In6tLL2zgrazBo9XD+lATEDPKurBhMWdMfA9Q+VM/D7z0+GvUSjX9
zUqwq4ZUNN3LtSUxIfY/Da0cDBt4h4JeP//RbYIK0s9dZqq6GqkhpCWv7jRlb5tx
U5vB2VvAWYgMh0LtBp8iShHgUQTPn4LO4xcuM4fI1hgYAL7SxEJRtEmfZ18xQBj2
KIRqjNnX/zN3Mh6QaD1JhlGP/LYDehFe1Sv5xaUUBlLX8ucaHzoBk1drcyspqvUN
RcIIlsfHlPZp0sqkoUEuCx6xaiwkjgt8Q4j0ok6/ak2Or7r24xfqDywQ853Me8Zv
BuxTkWe9rjHzL7cAuBduMjxMoT8axB1VZ4BZY3oz2reGhErrpOp92LjXmdAqcVhC
yjSO1driNaxEY/QDtW3c
=vQi3
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
