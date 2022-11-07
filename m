Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F087F
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 09:48:35 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id kt23so28479347ejc.7
        for <iommu@lists.linux.dev>; Mon, 07 Nov 2022 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5L/b/iiv4bE6DnHSKSmrFG5dDWyQhbSZwF9NlGUYx8=;
        b=LvU8zWB72HOIroDkSZ7/lodrDW3JujAAGCgt5V/BrjQk7LZlkPClWG7hdpPRAGHWTd
         nPOS9Guj3pOsR5RNexowZazwzwimNyhP+XTYeA+R75qEej/V3j/UqYLWb5DRN58yByRY
         oJEJWBgJwP1PPRFe79AxPSvMKu1rVLqJe2NBderzxuvk4Xrte+bTz9MZl2QX73OxKwnC
         4Jvp6baDTRbD3Fba67Iex7RcVjU4IOFxBu4F6vQRl5/II1yqrM76FGyyfM2TWm3odpWl
         ahodhBChBL7OeP8jJn4n9bopKtbnL0rMjhB/51As3XeYRyoH15FvrKECAQyb8sbi990T
         CaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5L/b/iiv4bE6DnHSKSmrFG5dDWyQhbSZwF9NlGUYx8=;
        b=Qfh/azy8uJf6rGSAcKS1W+nhOTNFatRVPi+4eU6bzkT3J/bjIppVIyK4niXp8mvyZm
         5gadDXUMe55+e445NigQz7LLKVX7NElm/lEIFBmX+VQNWGB/QnW41eYAxLYFclC9ya+X
         s1wHMof+IP1T5WP6dGWEMExkpLMGHIXvt9cfw+t8zrLKn8gBBH6+3dC+/S2f+Ab4p7T0
         MBs00HVpYKt864ffwQxSEelZTTK2WK2lNPXtyyTVV6kI3RzKcdSe800RoONIiYfGb/9P
         1B1LYhIZk5TL0h7XtVL8bEaZUCku02KJlmiUKPFI4yqY546iZnKEvscVHmKZZqU3dY7L
         BCRQ==
X-Gm-Message-State: ACrzQf0TvBk0JodjMFOg5GQbHzkmlsjQECxaF4l+UNbEmQphD2L0kxyF
	xpZyKeFGp1lXRn2+xS78kUs=
X-Google-Smtp-Source: AMsMyM6vwdAsY7KinVXJMHyPxPpqrdQ/wNM1Ho0qlIueUgBZmzwv11T342tFeKwcw7BjQudiO+GfBw==
X-Received: by 2002:a17:907:3d88:b0:7ae:943:1cc2 with SMTP id he8-20020a1709073d8800b007ae09431cc2mr25128404ejc.675.1667814513845;
        Mon, 07 Nov 2022 01:48:33 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e17-20020a50fb91000000b0045bd14e241csm3931494edq.76.2022.11.07.01.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:48:33 -0800 (PST)
Date: Mon, 7 Nov 2022 10:48:31 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Prathamesh Shete <pshete@nvidia.com>, joro@8bytes.org,
	adrian.hunter@intel.com, jonathanh@nvidia.com,
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	will@kernel.org, iommu@lists.linux.dev, anrao@nvidia.com,
	smangipudi@nvidia.com, kyarlagadda@nvidia.com,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
Message-ID: <Y2jUb3UNeEJVekYS@orome>
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
 <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com>
 <Y2PJq27wkVwPg6rp@orome>
 <CAPDyKFq8szzryFBNkw20wFoPTbAa8YDy0wJnb57yckZ-HFTAMw@mail.gmail.com>
 <4cae5c8d-d6e9-79dc-670d-22ec9fda10a2@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jYpMxqzTZ1vFLQJC"
Content-Disposition: inline
In-Reply-To: <4cae5c8d-d6e9-79dc-670d-22ec9fda10a2@arm.com>
User-Agent: Mutt/2.2.7 (2022-08-07)


--jYpMxqzTZ1vFLQJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 05:35:19PM +0000, Robin Murphy wrote:
[...]
> Now, there does happen to be a tacit contract between the ACPI IORT code =
and
> the Arm SMMU drivers for how SMMU StreamIDs are encoded in their respecti=
ve
> fwspecs, but it was never intended for wider consumption. If Tegra drivers
> want to have a special relationship with arm-smmu then fair enough, but t=
hey
> can do the same as MSM and formalise it somewhere that the SMMU driver
> maintainers are at least aware of, rather than holding the whole generic
> IOMMU API hostage.

Are you talking about qcom_adrena_smmu_is_gpu_device()? That's the only
place I can find where MSM uses iommu_fwspec directly and in a "special"
way.

> Since apparently it wasn't clear, what I was proposing is a driver helper=
 at
> least something like this:
>=20
> int tegra_arm_smmu_streamid(struct device *dev)
> {
> #ifdef CONFIG_IOMMU_API
> 	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev)
>=20
> 	if (fwspec && fwspec->num_ids =3D=3D 1)
> 		return fwspec->ids[0] & 0xffff;
> #endif
> 	return -EINVAL;
> }

We actually also use this mechanism on devices that predate the ARM
SMMU, so it'd need to be even more generic. Also, since we need to
access this from a wide range of subsystems, it'd need to be in a
centralized place. Do you think iommu.h would be acceptable for this?

How about if I also add a comment to struct iommu_fwspec about the
intended use?

Thierry

--jYpMxqzTZ1vFLQJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNo1G8ACgkQ3SOs138+
s6G+AhAAuekGtAmbQT+FO9REjTNcbYsrloj9hB5mgAnet2fyTFqbqaJUeyxXAbqI
F8DfTRRkDH4ivVN3LCySjQxJlP4Gsjs+pokCFZ9fHmUZLXYiVgCMIC1c58c6+NTp
7Zxl4zim6O9d9xI6FqCPhraTLHtfb30IjNi351Ql2D6qzoUsJvqoctKwlDTmddP0
vLaAfr1b3c4CYkSd+UkKV7JXWwAtKc+NiXUUpFDNPXA/7XF6M8DGHOGEPsjiPrjw
Y0y/jixRtybEBixlgEBdDBadi7r2NQ7aKTXSt6U2Y8Z5s939/FL9VXBx6GVGRa3s
KYZZoJ1Rdk13Q4ZEKj7pcvjdbduIskOtMyKAEOt/pKa+/Mc/y2p1L4PArwo4wFUn
VGAhRQsFdFHTzNxanwyK6MuTCYXahA1WdSVlAd8dqrVyG9xefH5QD8ty8muwmIJS
OshziqAHJPPOpPNXEKfXNnIvil+oUkdazKbRyBuybQJpcECcz597WQrzbhuY1BFn
RWq2lneqzXIeiidn7+vyWxfgjzd8aASh6N3A4T+SYcbNEDvkdtJsahZxF9EFesyT
s85i1sseVWa+UPFtKds8AKcAg9AzHm40ZJixa/YzNQ8jEH+R14getVCULMLrvYqy
88RHhjDdRmxg/cxB3Ao+NzP7Lf3KzHcDSit2pVLxh2HXZ0Lb6dw=
=IlwD
-----END PGP SIGNATURE-----

--jYpMxqzTZ1vFLQJC--
