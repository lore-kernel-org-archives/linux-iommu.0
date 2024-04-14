Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25661370;
	Sun, 14 Apr 2024 00:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052919; cv=none; b=XwZXch6aQQrTOt32qr3A+GitF6SNmTZxTZRh6ZsegWiC1aPV2XO0wAW4xuAAYksHjWJxfnp/JHC8h0tJTKyofju1bRodEvNChfIPhc5UeQ9iogdI8VH8ebmpAsskgEZfDI4zn8rR5lADr/Cmk9P7hCv5yN2Xvk79ScYZikgsC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052919; c=relaxed/simple;
	bh=gowBcIVjkrIRCzpktT8xjhDtwrM/kyvyXvSUbC7DTEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUTx8ZBH1ssQO2qHPKOF/4VqiloSfRPs0oW7ctHvtjT9f3kUWMTsTZRPHaiKTvirjXP5rahjHVdmBT5Cx6amh8XEVwcuSUzGSrdXixSZudQKZTgzLo5vfS+54/rpX39558wmioqM6y6UcoCSMoY3OhtA96fNW5zUGCPui5ingb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uaxd8VXs; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uaxd8VXs"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a2d248a2e1so2033547a91.0;
        Sat, 13 Apr 2024 17:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713052917; x=1713657717; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WufJPRcDUlI9hWQPeCIELs5BadGAqcV8RB9i29rVPSE=;
        b=Uaxd8VXsFxM1QvWDHNNZ9BdbtTgEV1RNLRPj45fET8VlhWLjPe0B1Ii0rHcjpBD/XS
         TqdVsNFU/YVdOTjfpDxPmeYEuM4jdh8xQUoZNE3TEjFhpTAWjVbPK1/X4G1f+8Y30TBy
         NGgAeltMG9AwFkI6s0SOo+MXnGVImAS6Y3fsugEoEu24MnwLadf+DVEX77UguXbT6RhY
         ZQOiFOxl/lYirkXiwo5We+AYymNf2bgOHhVyuVpkZ1Jaae9NthUfP8KFVO9ziS7KSbkd
         xRzQ5atUgAKqjoGjODLFne5uMUJzcgNd/allPkgPQat5x8/w/+2PyCvIWZPsrsNHuEfX
         NQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052917; x=1713657717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WufJPRcDUlI9hWQPeCIELs5BadGAqcV8RB9i29rVPSE=;
        b=ixfXNJLs+8F00qCSj2f4Iq8sQJ60am0e+jDOv4mf9ORWmJfbOpQYhif8Op5oH27rb+
         CQLH8IfpJD8hkd+G+E+DhUEkFR0fcrQ/zyXwZ+nUMEwEuLrT9Bs7HctCM/bthN2Q+FQE
         A27TmaC0b9PqZYq9uvv9BqOAj6zLO8ffyYK1cGJYDZNA7Mg9eemzIjV5wdeDqy9tVgIa
         Ey+QYnTcUfjCPbsXUyeVunEq5rrNS8qWFBqnJyE7kw76LcoRKqruY3qR2aZr9t5mGRth
         sy7im9Z7hz/aQ2sgVMst+3Y03Ja0Fqbn3sLtlIk4JlL3bzZp2zpbaQ5Z7AajVAP2HQZk
         iKEA==
X-Forwarded-Encrypted: i=1; AJvYcCUoGuwyVMC1LiiT37/ae2OvqFsr1RvjiP1Ijl0ey4fhWH5gHKdw3dRXt1jLxwwcZydzgc1zRgOaUXv4deRQ6CSmUyknU63NuKHpSU4oc3cMHbUA38zicfsvXFTSN2cwJiyxbg==
X-Gm-Message-State: AOJu0YwPth4dC0rxB3jJKHbZSNzNN9JW29B41urueW8TemVHV9Fukpmv
	b2zxQOAWuSUzt922tjhKS8BUo01L9qg8s9C4ML4c9jLbNw/UCyVx
X-Google-Smtp-Source: AGHT+IGrAqwuqHFxlxFTtEnyAqnda4cYfCPT+QePK4NluaOztQzsIE/j760N6Zrk/aFwQ0IZHsBe7A==
X-Received: by 2002:a17:90a:7146:b0:2a5:be1a:6831 with SMTP id g6-20020a17090a714600b002a5be1a6831mr13029487pjs.19.1713052916728;
        Sat, 13 Apr 2024 17:01:56 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090a154c00b002a52c2d82f0sm9077979pja.1.2024.04.13.17.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 17:01:55 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C1C0418462BA3; Sun, 14 Apr 2024 07:01:52 +0700 (WIB)
Date: Sun, 14 Apr 2024 07:01:52 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Eric Wagner <ewagner12@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Kernel 6.7 regression doesn't boot if using AMD eGPU
Message-ID: <Zhsc8GZG6HhqCa6h@archie.me>
References: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DhFDuHrGl5KsKvNz"
Content-Disposition: inline
In-Reply-To: <CAHudX3zLH6CsRmLE-yb+gRjhh-v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com>


--DhFDuHrGl5KsKvNz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 06:04:12PM -0400, Eric Wagner wrote:
> On my Thinkpad T14s G3 AMD (Ryzen 7 6850U) laptop connected to an AMD RX
> 580 in Akitio Node Thunderbolt 3 eGPU. Booting with the eGPU connected
> hangs on kernels 6.7 and 6.8, but worked on 6.6. For debugging, I find th=
at
> adding the kernel parameter amd_iommu=3Doff seems to fix the issue and al=
lows
> booting with the eGPU on 6.7.
>=20
> I tried bisecting the issue between 6.6 and 6.7 and ended up with:
> "e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2 is the first bad commit" in the
> attached. This seems to indicate an amd iommu issue.
>=20
> Two others also reported the same issue on AMD Ryzen 7 7840 with AMD RX
> 6000 connected as eGPU (https://gitlab.freedesktop.org/drm/amd/-/issues/3=
182
> ).
>=20
> Let me know if you need more information.

> Bisecting: 366 revisions left to test after this (roughly 9 steps)
> [74e9347ebc5be452935fe4f3eddb150aa5a6f4fe] Merge tag 'loongarch-fixes-6.6=
-3' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loong=
son
> Bisecting: 182 revisions left to test after this (roughly 8 steps)
> [f6176471542d991137543af2ef1c18dae3286079] Merge tag 'mtd/fixes-for-6.6-r=
c7' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
> Bisecting: 87 revisions left to test after this (roughly 7 steps)
> [fe3cfe869d5e0453754cf2b4c75110276b5e8527] Merge tag 'phy-fixes-6.6' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
> Bisecting: 43 revisions left to test after this (roughly 6 steps)
> [c76c067e488ccd55734c3e750799caf2c5956db6] s390/pci: Use dma-iommu layer
> Bisecting: 27 revisions left to test after this (roughly 5 steps)
> [aa5cabc4ce8e6b45d170d162dc54b1bac1767c47] Merge tag 'arm-smmu-updates' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
> Bisecting: 14 revisions left to test after this (roughly 4 steps)
> [bbc70e0aec287e164344b1a071bd46466a4f29b3] iommu/dart: Remove the force_b=
ypass variable
> Bisecting: 9 revisions left to test after this (roughly 3 steps)
> [e82c175e63229ea495a0a0b5305a98b5b6ee5346] Revert "iommu/vt-d: Remove unu=
sed function"
> Bisecting: 5 revisions left to test after this (roughly 2 steps)
> [92bce97f0c341d3037b0f364b6839483f6a41cae] s390/pci: Fix reset of IOMMU s=
oftware counters
> Bisecting: 3 revisions left to test after this (roughly 2 steps)
> [3613047280ec42a4e1350fdc1a6dd161ff4008cc] Merge tag 'v6.6-rc7' into core
> Bisecting: 2 revisions left to test after this (roughly 1 step)
> [f7da9c081517daba70f9f9342e09d7a6322ba323] iommu/tegra-smmu: Drop unneces=
sary error check for for debugfs_create_dir()
> Bisecting: 1 revision left to test after this (roughly 1 step)
> [9e13ec61de2a51195b122a79461431d8cb99d7b5] iommu/virtio: Add __counted_by=
 for struct viommu_request and use struct_size()
> Bisecting: 0 revisions left to test after this (roughly 0 steps)
> [6e6c6d6bc6c96c2477ddfea24a121eb5ee12b7a3] iommu: Avoid unnecessary cache=
 invalidations
> e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2 is the first bad commit
> commit e8cca466a84a75f8ff2a7a31173c99ee6d1c59d2
> Merge: 6e6c6d6bc6 f7da9c0815 aa5cabc4ce 9e13ec61de e82c175e63 cedc811c76 =
3613047280 92bce97f0c
> Author: Joerg Roedel <jroedel@suse.de>
> Date:   Fri Oct 27 09:13:40 2023 +0200
>=20
>     Merge branches 'iommu/fixes', 'arm/tegra', 'arm/smmu', 'virtio', 'x86=
/vt-d', 'x86/amd', 'core' and 's390' into next
>=20

Also Cc: regressions ML.

--=20
An old man doll... just what I always wanted! - Clara

--DhFDuHrGl5KsKvNz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZhsc7AAKCRD2uYlJVVFO
o3cdAPoDuiz+svWmSHQ3KkcQxl7HN7HflVRo+sFdCU6PzHtpCwEAmCvj14Dl7qnO
Qa2vk5I7HXJEpWRKVehg+WbWFv4qqAE=
=vOFu
-----END PGP SIGNATURE-----

--DhFDuHrGl5KsKvNz--
