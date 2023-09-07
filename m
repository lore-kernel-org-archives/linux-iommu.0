Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D727136B
	for <iommu@lists.linux.dev>; Thu,  7 Sep 2023 07:44:45 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9936b3d0286so75767866b.0
        for <iommu@lists.linux.dev>; Thu, 07 Sep 2023 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694072684; x=1694677484; darn=lists.linux.dev;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVal77bSl5KfJ1NqAZdo3TviCRf1XkCZOl7Ruz9I9ec=;
        b=rnFy7PfcgFVB3ATs3PTSYjuQ2fv7fgRM7CUaY9wVSXk6SN/5rE9hZM9QW4QGbW+JD4
         cduRwpsohry+v90xGUhhgYqzCOuA1M4i+rnddpo31Rgcy7INGFHpF77Xx/sulzOAtn+k
         9+z3UBnDeZKRfk5meZlmpDywyujUyYzMrHegiKBPqN5h9xGIMy33ZtK3IS1OmELUiQWr
         6p6sXmJ5aE55iceOawSNxrmZ0adQKofDLqPjrb3t3xXmbMmLnADodSNqqAmNQHrLcyle
         6qGLRd/Ulkfgwt6EmCN5SWCa+c6vziyJc3cFEFvas2WLyui/M0dSWGAlTc9mCjo25e1p
         2d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694072684; x=1694677484;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVal77bSl5KfJ1NqAZdo3TviCRf1XkCZOl7Ruz9I9ec=;
        b=R4x2ILYB13TWKsWNCSNVnt/K0j4Rm+ifWQLLNbUgpABeSucMvWv9ZUWMM8V1OG9KiI
         IfgBT/yZlCqLQga6MRvF25ElrRV5TviCT+nkAjngG0yfS+sXmgGucotOqsN2uz6NmRou
         CSzuUJXDVrcbhYB6oIbh11N4QSQpQdxrK6MGFEJyeCgmP1hwb0txOTW5xsVvywuYH/Qr
         xVdm6Ws56jaryc6L2HziJFmMv9x+6TNdz26aHOS3LH9xTOes3cMippnYYRLzXKP0/BOK
         9a6UUWYUsBCdcrfj0+wTq3MzyuswkHEolGb6wuULRont3Z/R98mRP2vNCTI5sJ9C+a81
         qzJg==
X-Gm-Message-State: AOJu0YwlUy3j2tIYKNJqRLtotYews02KY4clLWBEl714HINPXE6EQUcD
	yVLC6dbQ3HpbQbebyNXCSeY=
X-Google-Smtp-Source: AGHT+IEb44oJKVU32g8Gpv1w2GLfsjAU2c/Jg14YL7Z37DVTPrlmAqulebsJshUTyJmwcD4D4xsXqA==
X-Received: by 2002:a17:907:1003:b0:9a6:800a:8b58 with SMTP id ox3-20020a170907100300b009a6800a8b58mr4081654ejb.59.1694072683833;
        Thu, 07 Sep 2023 00:44:43 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906241100b0099cf91fe297sm10257349eja.13.2023.09.07.00.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 00:44:43 -0700 (PDT)
Date: Thu, 7 Sep 2023 09:44:41 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux.dev,
	baolu.lu@linux.intel.com, Krishna Reddy <vdumpa@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] iommu/tegra-smmu: Drop unnecessary error check for
 for debugfs_create_dir()
Message-ID: <ZPl_adfR8j-ih7Tt@orome>
References: <20230901073056.1364755-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HvtXWZfmTjWuBMT6"
Content-Disposition: inline
In-Reply-To: <20230901073056.1364755-1-ruanjinjie@huawei.com>
User-Agent: Mutt/2.2.10 (2023-03-25)


--HvtXWZfmTjWuBMT6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 03:30:56PM +0800, Jinjie Ruan wrote:
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL.
>=20
> As Baolu suggested, this patch removes the error checking for
> debugfs_create_dir in tegra-smmu.c. This is because the DebugFS kernel API
> is developed in a way that the caller can safely ignore the errors that
> occur during the creation of DebugFS nodes. The debugfs APIs have
> a IS_ERR() judge in start_creating() which can handle it gracefully. So
> these checks are unnecessary.
>=20
> Fixes: d1313e7896e9 ("iommu/tegra-smmu: Add debugfs support")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
> ---
> v2:
> - Remove the err check instead of using IS_ERR to replace NULL check.
> - Update the commit message and title.
> ---
>  drivers/iommu/tegra-smmu.c | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--HvtXWZfmTjWuBMT6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmT5f2cACgkQ3SOs138+
s6GGQw/+Ncn2h8nFPL3OqrcC1az2G+luBQnIRXGLvBs+7LJRMW6CgmhxPvgxWIai
eAt4lXhLCEU9OluStu/79xJXExRJpVOftYb2918gMfsp5VMWq+4tc3uIRo6bbr9P
LTax1jEg4c6cWQjbDGBU3qXZhMxBdc2dr8b7szlbxLrCOiL4ZYakStnxlnO2EEZT
buWVhRhLNsHoYjgUUrp1mSNg0EcfZqeKuE6VwXQ6Q1cI6c/ZekthJmlh35HOU/Uz
THB00C67niQLkkPor8/xtpESrL6bUtfblHbDVAjU4etiamfe3mGClX6cJjltuLnl
lpYghVrbk4ZMjzudoQsX53PL6465ykf8LOseMO6lJ6wWyXxEMetNy46McP5mwnLn
/ANRNqMi0TUbBgcXUj81eVhQ4UIZJGHZoGwGlnvntWb5/QNZOhLKSweWQ8VSC6ZM
pC65yGUeS0ZawAovOtsqVCEdxserfREsr2r8lsUPV1ITO/nPa+OndPMRJ2XI6Acu
lYJmfiHvRweXodiW8V+zu3WsWm3H7dWmOlyDlnUSKyhWzIA8cRhLKCWqh/9fQG0t
xdoK+4a0UK6LzfDvLKqfkwx70vzrL4vS3Kpv+h672KmQdaxRlwPUKUX4THj+hFxe
983l9GGsGQlP6mRMvoumjufwdZBWauTfWfb5q4XymGwDSb9sk9Y=
=HMdc
-----END PGP SIGNATURE-----

--HvtXWZfmTjWuBMT6--
