Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B1A32C87
	for <iommu@lists.linux.dev>; Wed,  8 Nov 2023 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTB630qi"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2c518a1d83fso95416941fa.3
        for <iommu@lists.linux.dev>; Wed, 08 Nov 2023 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699467180; x=1700071980; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XyM6VQ+HEN7IzJJ5bMoPN5/yYHnG+EAx9sBxv2Z/Ai8=;
        b=lTB630qi65Y5TVvHAeJxy6Z423xDWZ55HS4Byjvo3NrNQ4sGwUrohlqqQ2lGLApTnL
         7eUEXPGFU1CB9W4xjBqZaQyR3QCJOxzlcAth6eO+Ueq6rGDuotSPC6LaOhsviZp+M04x
         LaQ3hZ39lHjREeQidQqMH+t+53/bvfN3FsNJpOxRz2TJYJlplq7YjQwWi357ERH8xbMC
         KhutA+0KIGYBLmWieByrUrnrY0vXhbp7z+2e2fwcbG0MehqLRzRS355VekErULZ82Ue2
         i2j6g0r0cZKJftJFni0t8axGc5HuT+QFjiYbjvRKj7LwOi1q3QWMCZ4Wb3Z+6IlAawyU
         07Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467180; x=1700071980;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyM6VQ+HEN7IzJJ5bMoPN5/yYHnG+EAx9sBxv2Z/Ai8=;
        b=dpGalu13WwM8PLB+vNBOyOTHBLeGrmcEYYItEYx7M4bI6qwx2IlVP5o4tkZplYUWVA
         pyDGQKFarWSSLSuJGVH8hpg8dT2FQDinbhLR7PEDkkHHx2Ecr49mH9q0UsvP2pzGalqo
         kg0YevgLr2trfaspvzuXMFJNa/T0mQ7Azi9IJNnNgX/CL6tmB8JBXCu1u21UWGo2YC+I
         KVXcSEEbyQJ3htj8vukXuN0e/DOnENjhu/leZvzBLZbhww0r0FPoI1dQ93TV5ytREl5w
         LDMwOHxmtjD2XR94fhUUkb/Tz6ru19OshuOUpXx8rJIUj5dWOU3BMD+USdrwxqHCotuJ
         UzqA==
X-Gm-Message-State: AOJu0YwxzlbmBrDdf4S3d0+yRQk2uzfsQu24cmCpZPwXuo0T8oO7FN9a
	ocBycRcigvywEuiAH9eoi7B6Ug==
X-Google-Smtp-Source: AGHT+IEAPIM/7orU2/kUz+9e+TY8CYDTNJKLdVzPi+Pze4e6FKjzPA1Tq2W37LpeXm1IyotL7oPMlg==
X-Received: by 2002:a2e:8e7b:0:b0:2c5:582:fd8d with SMTP id t27-20020a2e8e7b000000b002c50582fd8dmr2179335ljk.30.1699467179768;
        Wed, 08 Nov 2023 10:12:59 -0800 (PST)
Received: from [10.1.1.118] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c4c1400b003fd2d3462fcsm739766wmp.1.2023.11.08.10.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 10:12:58 -0800 (PST)
Message-ID: <e57f11915745674521b8c73d88a198a0b9c32c21.camel@linaro.org>
Subject: Re: [PATCH RFC 12/17] iommu: Make iommu_ops_from_fwnode() static
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
 acpica-devel@lists.linuxfoundation.org,  Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>,
 asahi@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas
 <catalin.marinas@arm.com>,  Dexuan Cui <decui@microsoft.com>,
 devicetree@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,  Frank
 Rowand <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 iommu@lists.linux.dev,  Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org,  linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org,  linux-snps-arc@lists.infradead.org,
 linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore
 <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>,  Robin Murphy
 <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Sven Peter
 <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy
 <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>, 
 virtualization@lists.linux-foundation.org, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Date: Wed, 08 Nov 2023 18:12:56 +0000
In-Reply-To: <12-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
References: <12-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4-1 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

On Fri, 2023-11-03 at 13:44 -0300, Jason Gunthorpe wrote:
> There are no external callers now.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
> =C2=A0drivers/iommu/iommu.c | 3 ++-
> =C2=A0include/linux/iommu.h | 6 ------
> =C2=A02 files changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 62c82a28cd5db3..becd1b881e62dc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2945,7 +2945,8 @@ bool iommu_default_passthrough(void)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(iommu_default_passthrough);
> =C2=A0
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle
> *fwnode)
> +static const struct iommu_ops *
> +iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct iommu_ops *o=
ps =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iommu_device *iomm=
u;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 27e4605d498850..37948eee8d7394 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -701,7 +701,6 @@ static inline void iommu_fwspec_free(struct
> device *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->iommu->fwspec =3D NU=
LL;
> =C2=A0}
> =C2=A0int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)=
;
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle
> *fwnode);
> =C2=A0int iommu_fwspec_append_ids(struct iommu_fwspec *fwspec, u32 *ids,
> int num_ids);
> =C2=A0
> =C2=A0static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct
> device *dev)
> @@ -1044,11 +1043,6 @@ static inline int iommu_fwspec_add_ids(struct
> device *dev, u32 *ids,
> =C2=A0}
> =C2=A0
> =C2=A0static inline
> -const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle
> *fwnode)
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> -}
> -
> =C2=A0static inline int
> =C2=A0iommu_dev_enable_feature(struct device *dev, enum iommu_dev_feature=
s
> feat)

This leaves the extra line with 'static inline', it should also be
removed.

Cheers,
Andre'

