Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142B1F176
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 16:16:54 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-401d1d967beso333651cf.0
        for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689265013; x=1691857013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIGK1YyVHYZJI7AzNx8908/vhc/B3w7S4pe5DEK+mb0=;
        b=uBZ7B6Zp7EpOVHlAWk+Xb4+1TnfJlI2oH/iQ+Xztosvc4TV7SX1M/zrx6B4Rdhmt9Q
         Sht7ScVZahLgJXbdq7YTR3rylVnso4JJTzYc67XLXMpJ3IWApKIrD/T3d4vKgSKKNf8x
         ymhPMEcB6aXYoU6bHLTW/u3CNE9UhpVdBoKMpl0rt63TxHl+a6Yk/7fJDQYXGrjQWTqC
         wUT5gO/GFlxcD9sqHhzpjIU3oNj5NG4JkhL47DLx5bw+BRfg3DngcmIAX9USdcQgEbLs
         yUZ3WadqYOt3uNCw3II/023hqnWLIYkQrvNQZMx1PrXLPn9bNiS1heYxcUdw1gjK7xDp
         PYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689265013; x=1691857013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIGK1YyVHYZJI7AzNx8908/vhc/B3w7S4pe5DEK+mb0=;
        b=HWwgeYTbceq2BTOUdvY2QJWpMWi6PA9tbNYII+Mk1WbJzQ/bRAfur/b+eYJ6QHGwIh
         MrzAJ5VZm8jJDR7xY12uXqGTGolW4dVKfX73GYGWgpx24JSWp++qLDw16QL3bEbPpyMo
         38y34wHdflCxuPARiiQUj8E9kUTcdrpHoXql5f9vTN42PD5XxbNzB6lCuCqmTTc6Sq7m
         f4GkhxVP6LSF2f3ZG2ROEHKp9Wd8TFNV8wPKvdgM/F4NeUVIJ4aN7odvLXCwmE5/RKQM
         FyTmy3rksr00yA18YBLKNIBxO4v8G7Dzrt3dpqdkmOC7M3TYiTy3SzjU5ciQd1lPzW+z
         rDPQ==
X-Gm-Message-State: ABy/qLbXd4Trom6h2zv3aqjHeFI+GddPsYQVaHNF6oaw/94MB9H3v/dA
	XoF/LFI8Z2p9AfOlTwyqCItmNBw76swYPaocBK4Jpg==
X-Google-Smtp-Source: APBJJlFkh0J4qQCApfksef5WD+OIFNG9dkqTt8Lz2fZbUrMErakuqKo9MIIywxsc27dtNAaDAMMboaoPGHuyWPp4zAQ=
X-Received: by 2002:ac8:5a8b:0:b0:3f8:5b2:aef2 with SMTP id
 c11-20020ac85a8b000000b003f805b2aef2mr522383qtc.26.1689265013503; Thu, 13 Jul
 2023 09:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com>
In-Reply-To: <ZLAKQw+DzcpSRSyi@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 14 Jul 2023 00:16:16 +0800
Message-ID: <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 10:29=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
> It would make alot more sense if the STE value used by an unmanaged S1
> domain was located in/near the unmanaged domain or called 'unmanaged
> S1 STE' or something if it really has to be in the master. Why does
> this even need to be stored, can't we compute it?

struct s1_cfg* and struct s2_cfg* are precisely what is used to
compute an STE. For example, when s1_cfg is set, arm_smmu_write_strtab
will write the s1_cfg's CD table dma_pointer into the STE's
STRTAB_STE_0_CFG field. When neither are set, the STE fields are
written to enable bypass (or abort depending on the config).

> I'd think the basic mental model should be to extract the STE from the
> thing you intend to install. Either the default CD table, or from the
> iommu_domain. ie some 'get STE from iommu_domain' function?

I don't follow this. When we attach a domain with pasid (whether
through SVA or the set_dev_pasid API) , we don't want to install an
entirely new CD table. We want to write something (page-table pointer)
to a common CD table. Where should the s1_cfg which owns that common
table live? I thought we concluded that it should be owned by the
arm_smmu_master rather than any domain (to avoid dependencies between
domains a-la aux-domain). With this change, even attach_dev with a DMA
or UNMANAGED domain is now just preparing a single entry into this
common CD table.
