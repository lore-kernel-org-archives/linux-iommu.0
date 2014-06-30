From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC/PATCH 2/7] iommu-api: Add map_range/unmap_range functions
Date: Mon, 30 Jun 2014 21:42:10 +0200
Message-ID: <20140630194209.GC32594@mithrandir>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
 <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Olav Haugan <ohaugan@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, will.deacon@arm.com, joro@8bytes.org, vgandhi@codeaurora.org
List-Id: iommu@lists.linux-foundation.org


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2014 at 09:51:51AM -0700, Olav Haugan wrote:
[...]
> +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
> +		    struct scatterlist *sg, unsigned int len, int prot)
> +{
> +	if (unlikely(domain->ops->map_range == NULL))
> +		return -ENODEV;

Should we perhaps make this mandatory? For drivers that don't provide it
we could implement a generic helper that wraps iommu_{map,unmap}().

> +
> +	BUG_ON(iova & (~PAGE_MASK));
> +
> +	return domain->ops->map_range(domain, iova, sg, len, prot);
> +}
> +EXPORT_SYMBOL_GPL(iommu_map_range);
> +
> +int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
> +		      unsigned int len)
> +{
> +	if (unlikely(domain->ops->unmap_range == NULL))
> +		return -ENODEV;
> +
> +	BUG_ON(iova & (~PAGE_MASK));
> +
> +	return domain->ops->unmap_range(domain, iova, len);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unmap_range);

Could these be renamed iommu_{map,unmap}_sg() instead to make it more
obvious what exactly they map? And perhaps this could take an sg_table
instead, which already provides a count and is a very common structure
used in drivers (and the DMA mapping API).

Thierry

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTsb2RAAoJEN0jrNd/PrOh0IEQAK3eRE9ASWMIMA9FsJ+miO47
j/BUApAd+Mt4dh+p5u+vc48btFiA0ZoWTwv6AfBdXuA83m5wJLxbflGXODtDYQtc
sLGNM9py8/CJeNPufxTOi0WMjFIUvbv/h3Ns9LefXkwzn2B4dbwi0J6a3iDCgE11
aiwaREqCkTTEy2rVpdrnDzuQkxdSA2Dwn9vsLXomrSD4tb2pEqLjnX3L6cSUVmX1
oosOdg1ei71HcUmSOTn0LYVh4Xj5juesS3x8cGf1OXjWCx3Df8RRtI5PLNxLr+xA
hGsRn+RDJK8Gn5lAt4bRBFeIkm09YuBCOysvgPST2KXecQwg0tTMlHsIvFllj6Y6
W9ts2QgKyKZUiWCcV5AQF1pBRIDZB3O7TuA/s1Wdrs+3rjTRWzQvOpEwGi8XLivQ
r7Mw5dq1dG+VtGgHLZjvZg5nnT5EuBXbj1eny8qRRo064acvfySipfjkcq6Hthsd
EZgrXEbyJYTwf5EMlVVPpCl+Z++SiAbMXDffmYwodNXlcjyfrmQonWYpvwET9osh
0yLLJ0qx4CkfmNGEo0B1h0jMdHfH2GWetffXBFJ20v64T933fPj4SJhr88Ok7o52
2OPSC+eAqjwlr8r1NZBOdxgFTfkcW3mn3sLDxlE597PgnGMDlvkjlwp33EKHQn63
f3vNYnl2FL+mfkRKHfiJ
=Li3y
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
