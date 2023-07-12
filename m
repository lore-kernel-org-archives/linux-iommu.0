Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5A1F959
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 12:22:21 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-313e742a787so431712f8f.1
        for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689164540; x=1691756540;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=risaOC2By4RRr2SXI3daNv3cxbGsdWxMPTLhDodknLI=;
        b=k+WfAkF8VRKEiFemqZ4Tv+BdDzhbDaf+A9ySwe7eOoRNdPqrXbZpCGRXuBELieQiQ9
         AnOEIeNdgR3iMzpzL9YM13kYo9Upn9kAIHBG2BIebyVBtTQ7VstkT0j1KTr/4blkvGMv
         uF3wA18+zm7gglNb3T5SOTnZFYn52BDgnFm2v+t9OfjROJF8Wu9Jupw6hgdOeijYj4TW
         fANTqSOWdFvkINt80/D1I5cSspsUH0lkfuzcPO1DlVA6GTCXcwjGo0B1E3JmTwckdLrD
         NkXkFAFcgHi9DXfCiH8GafnTQik1hcO0UqSOmfs21z5xv5oRGpCcbzMLmac2+n2GwOmA
         8Now==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689164540; x=1691756540;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=risaOC2By4RRr2SXI3daNv3cxbGsdWxMPTLhDodknLI=;
        b=CfkHhZ7bSYmwVWJWsuBP7VgcwdsfNYufgdePCUUc88bbI0oiglzLu2e0Ce6AjbuJv1
         88a5UXDqHPHjaDXSEqxDa/ht6NM8vgiukV2w/UN0RK6QAerb7f5Z/K24hqye8B92bRwp
         CIgvFMH+P9WMadyFrg6lbrumL+OfWVsg3tviWTZGCsPhmgH2uZ5BbzT2oUXabr+bZAR5
         9RmIOFd7LjPhLmzFCG5HxcWImxwCoCLA99iOmYfmCsjpt+IE0G2T1GplEz5ecG+w+i53
         ELVeo8b09c5YLPDG7Pe1ISA27i80oLbu1xxcjVr5WHy8Gt111TvLuHlAGZzVQG5CM/hL
         OmSg==
X-Gm-Message-State: ABy/qLYNxYOqcbdnp9HVEjNhlML9tIDsoj0QYR7fokf6stBiCXtXA2+h
	XXIaibqDYHyKIf/227OyvZI=
X-Google-Smtp-Source: APBJJlEkmSfITgeLnMo/tOjF1lMyUPDdKd7C73TOjb/E3FNO4uz7G9hrS5td6jJmUA23LgJnnAyFmQ==
X-Received: by 2002:a5d:4d42:0:b0:30a:c681:fd2e with SMTP id a2-20020a5d4d42000000b0030ac681fd2emr1936132wru.22.1689164539857;
        Wed, 12 Jul 2023 05:22:19 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j11-20020a056000124b00b0031417fd473csm5009874wrx.78.2023.07.12.05.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 05:22:19 -0700 (PDT)
Date: Wed, 12 Jul 2023 14:22:17 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Minjie Du <duminjie@vivo.com>
Cc: Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>,
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] iommu: fix parameter check in
 tegra_smmu_debugfs_init()
Message-ID: <ZK6a-f2Se3HWjU7D@orome>
References: <20230712113145.12888-1-duminjie@vivo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="So7QhWFQ1LiNBVmH"
Content-Disposition: inline
In-Reply-To: <20230712113145.12888-1-duminjie@vivo.com>
User-Agent: Mutt/2.2.10 (2023-03-25)


--So7QhWFQ1LiNBVmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 07:31:45PM +0800, Minjie Du wrote:
> Make IS_ERR() judge the debugfs_create_dir() function return
> in tegra_smmu_debugfs_init()
>=20
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/iommu/tegra-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 1cbf063cc..841e14cce 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
>  static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
>  {
>  	smmu->debugfs =3D debugfs_create_dir("smmu", NULL);
> -	if (!smmu->debugfs)
> +	if (IS_ERR(smmu->debugfs))
>  		return;

I think we can just drop the error check altogether since
debugfs_create_file() will simply return early if smmu->debugfs is an
error pointer.

Thierry

--So7QhWFQ1LiNBVmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSumvkACgkQ3SOs138+
s6FfXhAAjRjwsGjs2rm1PFgf1a1quzdz67t2GTDswhEnV/zLM0eXE9y7LzTzl23O
wM3y49DWK44J4d77LAZeXw2vCa7QjorWCcLX9uwJhxFOVwYJ5ptjRDOVkCjNTscu
JYCLoKICX5NmpT4z5zUp/bCTm4hu0fsGQIKilEpH0+0h6JrUObbtappv70dxLCFp
c4YJ8ZDR0faBjjrIOUQdbMqSB2fOyuOgfdtO9n9Q0PMkek6JXywr+DNUtuidoD1j
0NtgJnreYfvkgyn+dQ61XoqYHi3Ql0VpIMrQKrey45urtFRgpN75KxrJhlKSHSGo
MVDNLEEyoLGNAqjOpVErnmmDQvDXUcpDieXzn35LsW9ijpdX2/i1JI/Y7sJwkSTG
uuWZRDW53E7C6xjlMk3GklMJEn/ChJU4AMgvQrQ85dxokO6XTfP1GbjcmoofPoA6
Jl5+9BrN31j8aCnOlEarbVXyFQdKSu54Vsu+INoIj9cpsVmOQNeTGfqpQnjOiXkj
cpJOEfetwB1L/WcjQyaUJjti8nk5AMwfx5bclJPXJ7qT7sHcbB0n0GXmcmOog6o0
XvO1baO+9lCIS9Nchn8KR+oo7wmCT7E8IWKxWLkDgznInfXXXl1WtIbPgbzNN1qk
8w55I6NwjRfo80lpkGxlr23Vk6wiJJCbv2BC3IjmGkHP4eZoPP4=
=kkYV
-----END PGP SIGNATURE-----

--So7QhWFQ1LiNBVmH--
