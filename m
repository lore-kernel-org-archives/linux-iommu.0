From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Wed, 15 Oct 2014 11:16:53 +0200
Message-ID: <20141015091652.GB13162@ulmo>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
 <1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
 <20140925170108.GE8306@8bytes.org>
 <5432E757.10201@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5432E757.10201@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Olav Haugan <ohaugan@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>, laurent.pinchart+renesas@ideasonboard.com, konrad.wilk@oracle.com, mitchelh@codeaurora.org, linux-arm-msm@vger.kernel.org, will.deacon@arm.com, iommu@lists.linux-foundation.org, robdclark@gmail.com, Varun.Sethi@freescale.com, kgene.kim@samsung.com, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org, hdoyu@nvidia.com
List-Id: iommu@lists.linux-foundation.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 12:02:47PM -0700, Olav Haugan wrote:
> On 9/25/2014 10:01 AM, Joerg Roedel wrote:
> >On Mon, Aug 11, 2014 at 03:45:50PM -0700, Olav Haugan wrote:
> >>+static inline int iommu_map_sg(struct iommu_domain *domain, unsigned l=
ong iova,
> >>+			       struct scatterlist *sg, unsigned int nents,
> >>+			       int prot, unsigned long flags)
> >>+{
> >>+	return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
> >>+}
> >>+
> >>+static inline int iommu_unmap_sg(struct iommu_domain *domain,
> >>+				 unsigned long iova, size_t size,
> >>+				 unsigned long flags)
> >>+{
> >>+	return domain->ops->unmap_sg(domain, iova, size, flags);
> >>+}
> >
> >I have thought a little bit more about this interface and think that it
> >would be better to just return a size_t from iommu_map_sg().  The
> >function returns the amount of address space mapped by it, 0 in the
> >worst case.
> >
> >This makes it easy to unmap the region just with
> >iommu_unmap(domain, iova, size) in the end and removing the need for a
> >new iommu_unmap_sg() function. Also the error-path of the map_sg
> >call-backs becomes easier as the function then just returns the amount
> >of address-space already mapped before the error happened.
> >
> >So the prototype would be:
> >
> >	size_t iommu_map_sg(struct iommu_domain *domain,
> >			    unsigned long iova,
> >			    struct scatterlist *sg,
> >			    unsigned int nents,
> >			    int prot);
> >
> >(as I said before, the flags parameter should not be added by this
> >  patch-set).
> >
>=20
> Ok, sounds good. I'll post v6 soon.

Perhaps make the return value ssize_t so that we can propagate errors?

Thierry

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUPjuEAAoJEN0jrNd/PrOhXFYP/i78cDhw9xWBbB5j76Sfu1au
wVnojUxcsnDAwNA/3N8sLbqx8HLWNyyIcJOAmqMi1rtdlPfl3rYUkvWxw9xTZYtE
Lgh24+nMg8ViDoXSDn9NM2IKF9ERk6fxNtDyrykxuvUz3XWwV3NL7TLTJIJOMVio
bvT41NAWC3PP0s3mRspt5y3wEUDMcwRykFze72ZMTn2nGqZavI8ovSwCLFlzi9iW
Ud88C9Q15rdxZX3tXnWM9vhbyUWLBKKLqhnJ48qwgGXj0n5bm9jbvglB1JqpRYal
WwY63MhBpF4CuLZSf8K+oyEbhKNURTpPxqEZifw3ONsilV5TzK7vw2S58XmONbeU
mwFuGraEBYzWAZ7dxK80Uy6zYnCmd0q5XMIh1F+pWhSwlz8xAo//LUwkkcAh/lDt
eNP7yUma7vA1tqSty795itST4uJSTgVbs5nJOJKMhs8cm0REj0pVwMbU++4pgjh0
PACFnxmhO2dBu6OlYgTBYj/YwlOSp7BZ9WicfK9z4Rq4NiyhAx2jZ/yj4yar2T79
f+Bze+9YYMxAPPBRSPccfBm+KtjTIxe/bd6QkEY0+B5zz7hAjwKN9M9y53O2zym3
iOYbk8izwixD82M/BFh0kpKNm2JsJn/gbAgY+SHRXuJtcLSD7w1RVTiOMhDCUI4V
QCrv260nQpr+YMIUcb5H
=sSLW
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
