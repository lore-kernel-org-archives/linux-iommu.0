Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDA4C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 17:13:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA6961139
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 17:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EA6961139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 33F9A404CF;
	Thu,  7 Oct 2021 17:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pzur8ZjuiiIa; Thu,  7 Oct 2021 17:13:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A34A54041A;
	Thu,  7 Oct 2021 17:13:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 777EDC000F;
	Thu,  7 Oct 2021 17:13:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A069BC000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 17:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 824F18433F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 17:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mlny8j3wdxeC for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 17:13:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 90F5584335
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 17:13:29 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id v17so21221174wrv.9
 for <iommu@lists.linux-foundation.org>; Thu, 07 Oct 2021 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vLFoMp+dlaZHfsMQ3K2u0QNFyHL+HsxnT/5AaQm7BNg=;
 b=RX/pQlBUL5wUWRsIZYj7FNselOa0r9QLUJ72MouaPravOCTozOjwEuHD3CC8b4JL2q
 YJ1CJkz2gjw1DWnplJVhFsQ+rIZlS/hl1mXDf0rBb6PnZ/4lwW3wa/uuGSoWgeSksk5g
 l7/mLXdZqBKH7IhdA5odSJn3OxrkDDflMCyvab7jpgm4RtBECKLyKCR3aVBJXnYcxBjO
 sNfcyTIL2wzbHX2/XYlLwL4YLJl1KIHJkLWUq1n7SCKrVS55v24FT/H1f5PyzVGBJIa/
 fSzhN0/saTGfVU/5A5suk6STEvOELjSIntCHKPAFTc82vjMJHc5n59t7322fL1VNzk28
 5QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vLFoMp+dlaZHfsMQ3K2u0QNFyHL+HsxnT/5AaQm7BNg=;
 b=Hqtj9RM0k4TfTTjXcC1BhbYwsU65qw2ESxCu4OrPNMrFyJ2qS3ZbmphzQ08WQqZUur
 PnpW/F2QCEjlPkOTy/r9BpNYfrUBUdrgP4VJgQDmPGQllSrpCXJzZIGTvOZlmaHXKJUQ
 26acVDmBdKXmKTD0fSk9s5teUqfengsHB9IT60NZ9nC4Hisu9SE6NEvjpge5RCnSl8fE
 ZDxz4MMh/AT4N3Wem1aYTXfevha61s95pgENEG6ZyUTtOH51+NpvYtFU7tFmV/OgaWVg
 7d/nAQNO+JkAAuKn6t6t2iG+tofZ0CBil3Kn1WpvAR+fXt6NXeBI8N6gMnSCFwxwvRX6
 r5BQ==
X-Gm-Message-State: AOAM533rggfvC3OLX+DkwfxFzVfkgqgrVpZ30Dv66YezmmwPrK8djVwB
 kf6KSEsr5qjYN1XraWpDRDA=
X-Google-Smtp-Source: ABdhPJzTHTG6kt6OPq07bFUSFJruW8YZ4QMMQf5MkN/9aUgfa60VV/R1Jbf4CIUi4YJBMcgwIkwoTA==
X-Received: by 2002:adf:ab43:: with SMTP id r3mr7062988wrc.225.1633626807587; 
 Thu, 07 Oct 2021 10:13:27 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id p8sm1318wmg.15.2021.10.07.10.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Oct 2021 10:13:26 -0700 (PDT)
Date: Thu, 7 Oct 2021 19:13:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v6 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <YV8qtdicr4+PcIAf@orome.fritz.box>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-7-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20210914013858.31192-7-nicoleotsuka@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com,
 will@kernel.org
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
Content-Type: multipart/mixed; boundary="===============5033293279964944562=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5033293279964944562==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D2ajDYzQb2RUipRA"
Content-Disposition: inline


--D2ajDYzQb2RUipRA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2021 at 06:38:58PM -0700, Nicolin Chen wrote:
> This patch dumps all active mapping entries from pagetable
> to a debugfs directory named "mappings".
>=20
> Attaching an example:
>=20
> SWGROUP: hc
> as->id: 0
> as->attr: R|W|N
> as->pd_dma: 0x0000000080c03000
> {
>         [index: 1023] 0xf0080c3e (count: 2)
>         {
>                 PTE RANGE      | ATTR | PHYS               | IOVA        =
       | SIZE
>                 [#1022, #1023] | 0x5  | 0x000000010bbf1000 | 0x00000000ff=
ffe000 | 0x2000
>         }
> }
> Total PDE count: 1
> Total PTE count: 2
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 145 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 68c34a4a0ecc..aac977e181f6 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -46,6 +46,7 @@ struct tegra_smmu {
>  	struct list_head list;
> =20
>  	struct dentry *debugfs;
> +	struct dentry *debugfs_mappings;
> =20
>  	struct iommu_device iommu;	/* IOMMU Core code handle */
>  };
> @@ -153,6 +154,9 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu,=
 unsigned long offset)
> =20
>  #define SMMU_PDE_ATTR		(SMMU_PDE_READABLE | SMMU_PDE_WRITABLE | \
>  				 SMMU_PDE_NONSECURE)
> +#define SMMU_PTE_ATTR		(SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
> +				 SMMU_PTE_NONSECURE)
> +#define SMMU_PTE_ATTR_SHIFT	29
> =20
>  static unsigned int iova_pd_index(unsigned long iova)
>  {
> @@ -164,6 +168,12 @@ static unsigned int iova_pt_index(unsigned long iova)
>  	return (iova >> SMMU_PTE_SHIFT) & (SMMU_NUM_PTE - 1);
>  }
> =20
> +static unsigned long pd_pt_index_iova(unsigned int pd_index, unsigned in=
t pt_index)
> +{
> +	return ((dma_addr_t)pd_index & (SMMU_NUM_PDE - 1)) << SMMU_PDE_SHIFT |
> +	       ((dma_addr_t)pt_index & (SMMU_NUM_PTE - 1)) << SMMU_PTE_SHIFT;
> +}
> +
>  static bool smmu_dma_addr_valid(struct tegra_smmu *smmu, dma_addr_t addr)
>  {
>  	addr >>=3D 12;
> @@ -496,6 +506,8 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu=
 *smmu,
>  	mutex_unlock(&smmu->lock);
>  }
> =20
> +static const struct file_operations tegra_smmu_debugfs_mappings_fops;

Could the implementation be moved up here to avoid the forward
declaration?

> +
>  static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
>  				 struct tegra_smmu_as *as,
>  				 unsigned int swgroup)
> @@ -517,6 +529,12 @@ static void tegra_smmu_attach_as(struct tegra_smmu *=
smmu,
>  			dev_warn(smmu->dev,
>  				 "overwriting group->as for swgroup: %s\n", swgrp->name);
>  		group->as =3D as;
> +
> +		if (smmu->debugfs_mappings)
> +			debugfs_create_file(group->swgrp->name, 0444,
> +					    smmu->debugfs_mappings, group,
> +					    &tegra_smmu_debugfs_mappings_fops);
> +
>  		break;
>  	}
> =20
> @@ -541,6 +559,12 @@ static void tegra_smmu_detach_as(struct tegra_smmu *=
smmu,
>  		if (group->swgrp !=3D swgrp)
>  			continue;
>  		group->as =3D NULL;
> +
> +		if (smmu->debugfs_mappings) {
> +			d =3D debugfs_lookup(group->swgrp->name, smmu->debugfs_mappings);
> +			debugfs_remove(d);
> +		}
> +
>  		break;
>  	}
> =20
> @@ -1124,6 +1148,125 @@ static int tegra_smmu_clients_show(struct seq_fil=
e *s, void *data)
> =20
>  DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
> =20
> +static int tegra_smmu_debugfs_mappings_show(struct seq_file *s, void *da=
ta)
> +{
> +	struct tegra_smmu_group *group =3D s->private;
> +	const struct tegra_smmu_swgroup *swgrp;
> +	struct tegra_smmu_as *as;
> +	struct tegra_smmu *smmu;
> +	unsigned int pd_index;
> +	unsigned int pt_index;
> +	unsigned long flags;
> +	u64 pte_count =3D 0;
> +	u32 pde_count =3D 0;
> +	u32 *pd, val;
> +
> +	if (!group || !group->as || !group->swgrp)
> +		return 0;
> +
> +	swgrp =3D group->swgrp;
> +	smmu =3D group->smmu;
> +	as =3D group->as;
> +
> +	mutex_lock(&smmu->lock);
> +
> +	val =3D smmu_readl(smmu, swgrp->reg) & SMMU_ASID_ENABLE;
> +	if (!val)
> +		goto unlock;
> +
> +	pd =3D page_address(as->pd);
> +	if (!pd)
> +		goto unlock;
> +
> +	seq_printf(s, "\nSWGROUP: %s\n", swgrp->name);
> +	seq_printf(s, "as->id: %d\nas->attr: %c|%c|%s\nas->pd_dma: %pad\n", as-=
>id,
> +		   as->attr & SMMU_PD_READABLE ? 'R' : '-',
> +		   as->attr & SMMU_PD_WRITABLE ? 'W' : '-',
> +		   as->attr & SMMU_PD_NONSECURE ? "NS" : "S",
> +		   &as->pd_dma);
> +	seq_puts(s, "{\n");

Maybe this can be more compact by putting the name, ID, attributes and
base address onto a single line? Maybe also use "'-' : 'S'" for the
non-secure attribute to keep in line with what you've done for readable
and writable attributes.

Then again, this is going to be very verbose output anyway, so maybe it
isn't worth it.

Thierry

--D2ajDYzQb2RUipRA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFfKrMACgkQ3SOs138+
s6GirA/8Cfx05/2MiogduRWFZTD9SO62n3CnaxfIXdaSXcZYSiqlhygq0iAZXs42
4VEauSkFFGjhS/oREagxAarQzz2P0UWCKK8N5FT3rByEVF5hrL/EPvw3UVnqLLWC
PoiCZITRyQaAuI84r/j0ppiLoVd8p4DaGIPQc2zGgGx9R8Swvwi3+gckJvAixpDW
86EVz4P61liUKkbqxBO4FIueZJydOJcqY3498bZiQ6bKdGItyh8fLxMScqfI5Ejw
MZB9lR9mMdMJxEZwG6ghCH1BVuCMachdscYSWkoqJI3d3jdgecOMcLRaV0tJYSLP
8vQIEPx/zDuYlxKgL9pIcfnhAEwydeaLJt0jS38Lff19jt8yyuJXcGuk0EwWU86f
4YIOmIRiFMPkqbTenptIreZDY//D0EjGRs0T4/5TZ4ln/zmhXwO01RdOBG2aNj4k
oprwCq1zKnmGmjFJTx+NqfiLwhjKX7EpH8OkFCNKXPhb7vOw9ihvKPwiriLhvXGy
OZQbJENISYlJ1yCrRgvxoXQDX1JF6Qfz15m6yTJJT+8Tm4ujKGlNeiOmux0p/Epv
Mpd5+a5k5YYb12+jtZjMTy3Hn75Ma/9cHwavM6xD6LmyppP4MXC6XRPWSVKCjUrs
5H36g9nwEfIhOlYhosC/jp4jH4AQhebHInqjQLrZn0iBxLcBP8k=
=Xb3q
-----END PGP SIGNATURE-----

--D2ajDYzQb2RUipRA--

--===============5033293279964944562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5033293279964944562==--
