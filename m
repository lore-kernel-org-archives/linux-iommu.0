Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F53C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:23:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D281F23741
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 10:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFnsISeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D281F23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 801A386A00;
	Thu, 24 Sep 2020 10:23:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXIhg1Q9vybs; Thu, 24 Sep 2020 10:23:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0329F869ED;
	Thu, 24 Sep 2020 10:23:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE1E0C0889;
	Thu, 24 Sep 2020 10:23:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7FB5C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:23:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A061986A00
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VrSmB3IwVML5 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 10:23:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CB443869ED
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 10:23:16 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id w2so2966927wmi.1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EVfZA8Ct79CbPZklHfFRotVXFuhWd9+as8robUKzh4k=;
 b=RFnsISeh2H1GKnONLlgbr2NxtGdER3flCTS61Yyr/wr+dppwJjXOgsShgvRmJMJP4S
 ZNqSg5vliGpP6p+YIrVsVvjtTMKa7suw0pt0H9EQbsNS628luftbpxDnsyr8d+c/Kt49
 b5FghArvusHD1IIv9jqCrgqVkWwynaWKpjZ4uVAudh901f5qy7svs5qlukrYGEFvtrzJ
 +NaiP+JEFJZkiIEKC8bZYv72Q9xtHAqtef6fUGJyFCMW58YFWsqKe+HxiPNbL2nE0qzP
 oH/JDKFs+Gpm7CsYybhiaN82SS3L7+tM+GtDNv8PGbuXXh49uUSA2luFxWfnwq5ce4mW
 mEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EVfZA8Ct79CbPZklHfFRotVXFuhWd9+as8robUKzh4k=;
 b=BfgDOuqlCkBt2ZdIq0x7b9Gu8e0mhLWMOabSmGCW73CZ4oZ1yjp7Q1/FUvYEIqSKdJ
 5RThvPjBUMIGfbO4+W9e7YPhJV4GOF7rlcXF/b0F+UwAs0zyXqbu/vkNMZ0fIcNlLob8
 XBzaFVGk75Ws+qCCwo1ZDkfqZ7a+YJzDdFaAdboikjqtkXSTpo/cVw4dj5jr848sZxV6
 CYIGrhAT8pri8Ja4anUhDQ2eyXpyY4yF/FcXDBbwZzEWINqFIUcK0InHzNqYHAn+hv55
 EJMGz13o/hIdKlHJ94L5c49wcqCmhZgqRSZv4oweaLhuE+vFz7b88K3xPHGDxVPZ8+DW
 YfqQ==
X-Gm-Message-State: AOAM533ngu3vUomG6afh/yJ2Kw2sQTBUaoBG/hJtA6NFyb1iub+VJ83J
 npL4CvDt+dp8DPOvU42XR0E=
X-Google-Smtp-Source: ABdhPJzw+VjS6qW3ICFO0IQrZ5i6ll2keFfG0Jk2Pm3kmAheCl4xQOGiaStfjuT1zAoKEsb0Sub9SA==
X-Received: by 2002:a1c:488:: with SMTP id 130mr3831012wme.164.1600942995364; 
 Thu, 24 Sep 2020 03:23:15 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id u63sm2952064wmb.13.2020.09.24.03.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 03:23:14 -0700 (PDT)
Date: Thu, 24 Sep 2020 12:23:12 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/3] iommu/tegra-smmu: Do not use PAGE_SHIFT and PAGE_MASK
Message-ID: <20200924102312.GG2483160@ulmo>
References: <20200911071643.17212-1-nicoleotsuka@gmail.com>
 <20200911071643.17212-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200911071643.17212-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0526666954663973493=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0526666954663973493==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Content-Disposition: inline


--/i8j2F0k9BYX4qLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 12:16:41AM -0700, Nicolin Chen wrote:
> PAGE_SHIFT and PAGE_MASK are defined corresponding to the page size
> for CPU virtual addresses, which means PAGE_SHIFT could be a number
> other than 12, but tegra-smmu maintains fixed 4KB IOVA pages and has
> fixed [21:12] bit range for PTE entries.
>=20
> So this patch replaces all PAGE_SHIFT/PAGE_MASK references with the
> macros defined with SMMU_PTE_SHIFT.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 046add7acb61..789d21c01b77 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -130,6 +130,11 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu=
, unsigned long offset)
>  #define SMMU_PDE_SHIFT 22
>  #define SMMU_PTE_SHIFT 12
> =20
> +#define SMMU_PAGE_MASK		(~(SMMU_SIZE_PT-1))
> +#define SMMU_OFFSET_IN_PAGE(x)	((unsigned long)(x) & ~SMMU_PAGE_MASK)
> +#define SMMU_PFN_PHYS(x)	((phys_addr_t)(x) << SMMU_PTE_SHIFT)
> +#define SMMU_PHYS_PFN(x)	((unsigned long)((x) >> SMMU_PTE_SHIFT))
> +
>  #define SMMU_PD_READABLE	(1 << 31)
>  #define SMMU_PD_WRITABLE	(1 << 30)
>  #define SMMU_PD_NONSECURE	(1 << 29)
> @@ -644,7 +649,7 @@ static void tegra_smmu_set_pte(struct tegra_smmu_as *=
as, unsigned long iova,
>  			       u32 *pte, dma_addr_t pte_dma, u32 val)
>  {
>  	struct tegra_smmu *smmu =3D as->smmu;
> -	unsigned long offset =3D offset_in_page(pte);
> +	unsigned long offset =3D SMMU_OFFSET_IN_PAGE(pte);
> =20
>  	*pte =3D val;
> =20
> @@ -726,7 +731,7 @@ __tegra_smmu_map(struct iommu_domain *domain, unsigne=
d long iova,
>  		pte_attrs |=3D SMMU_PTE_WRITABLE;
> =20
>  	tegra_smmu_set_pte(as, iova, pte, pte_dma,
> -			   __phys_to_pfn(paddr) | pte_attrs);
> +			   SMMU_PHYS_PFN(paddr) | pte_attrs);
> =20
>  	return 0;
>  }
> @@ -790,7 +795,7 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct iom=
mu_domain *domain,
> =20
>  	pfn =3D *pte & as->smmu->pfn_mask;
> =20
> -	return PFN_PHYS(pfn);
> +	return SMMU_PFN_PHYS(pfn);
>  }
> =20
>  static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
> @@ -1108,7 +1113,8 @@ struct tegra_smmu *tegra_smmu_probe(struct device *=
dev,
>  	smmu->dev =3D dev;
>  	smmu->mc =3D mc;
> =20
> -	smmu->pfn_mask =3D BIT_MASK(mc->soc->num_address_bits - PAGE_SHIFT) - 1;
> +	smmu->pfn_mask =3D
> +		BIT_MASK(mc->soc->num_address_bits - SMMU_PTE_SHIFT) - 1;

checkpatch no longer warns about lines longer than 80 characters. The
new limit is 100, so you can fit this all on one line.

But either way:

Acked-by: Thierry Reding <treding@nvidia.com>

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9sc5AACgkQ3SOs138+
s6F80g/+JuxY/x6E7mY8d3iXr0sk56VhC9IAKa2ZyE5iUaD2Con2ohzLEZQ9zOCS
GSQqZuiQiP+9l6k296/0wKd2NV9Y9g86JBmyEghk0YBCpqqoR8eklPmpL4D/vXwx
CjwqxnQ8Qm0nAUTkOLYC1bygUJ6eELDD/P8z2pU/Gex6hLTFP93PbRkpnjke8poS
beDTJGgBpQFSJ3vv3+R/nTAbWtI1ErWIugpSxiRUrBr8E7H8M9dyYVknKk49Ejjo
3+PUYW7GmuUnvtbs5fI9oPZ5ydgeL92QK38OLgVzAOnnULvcrwLCXrxATIrPJ9sD
qURSWQa2mOE+NFQ7z7+Z0qDt48FjQoGj6IGFjQur+wWulZiSLRiZP5s3u+k6aOU8
oPl1uMwDf2UEQLT8CGNR02z/0VBCV/WwFx1fXAaTqu5wBsdVAzIKe5dCQDk+c74O
KwXzkzvNvsfGSJ2DlMi/iJC0CETD2UlBfGZnCDOv5fzWYkXotHn9smqKNv0ihbMO
s9dCY0lYd8PhjLL//qY18WPXmM5s3HjxPUJmU/wmKUIYofJR6+xmmksqtWBydjiv
l5R0TopIsLDRQ739sGdW3yUvgbYHdXq51oExrkZSh+BKJoobwazDgBP4CR7UVpXO
Uxl+wVcC7qo4g2AFCb9iMmrw7o6hvpW+G3JpT5vcMCqCX5/DjZc=
=JXY2
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--

--===============0526666954663973493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0526666954663973493==--
