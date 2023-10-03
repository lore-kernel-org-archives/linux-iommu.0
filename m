Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE0463B3
	for <iommu@lists.linux.dev>; Tue,  3 Oct 2023 08:34:21 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a229ac185aso8076407b3.1
        for <iommu@lists.linux.dev>; Tue, 03 Oct 2023 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696322061; x=1696926861; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bitTTBesOlX5jNs0WrntjlIVBf0r6k8vUqdJl07s2a4=;
        b=HBfhD2hZxRrfu0LBgm1qnZyzNBS1mLwMImwRhRnIljQs8fBfCCtghgjPKlMl+j8e2H
         wMTd4bQa+M3+DcCNjYrNA8oQJeKsJsWrFkspxxjGimgX9CJOM2Mu/RIJmeYyBJzw6xjM
         RBTje4gcke0p5BB3woKQQEgyAzNDOdWFzk9dvUmIWTO+51SWnqaPwqfv5jmyLHkV+UPS
         +gQFGORhVrSaruWZiR/ZgHJEtqLNLh8Mq0myWfphEmgDF3Pdd20+Y120qozv6hKMs4sf
         9ebh0jPngyfCZ39jlrylqb1ct+YgieIlvtNENJ9EYkKMwc4W7/zktG+MQplJGGsysxgV
         Vspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696322061; x=1696926861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bitTTBesOlX5jNs0WrntjlIVBf0r6k8vUqdJl07s2a4=;
        b=FszOkVpYPUYlNnok/zwspr7ZrYQiLgQ0mm3mKKXhZJ6gxZN9hMMAT5OyFTr0EOIh5I
         e6/1oO3+jDONhoicxIcJyDnCmI1HUlwaEJWeBvXa2VG5il7l/OsNs8G2KrJiW6Rm1dEa
         VBupT0x9fJAtk+qvjK79cR7LGUWNgaw3X1j5l0jU20gJnmx98suCxxz+A4ymnEfDi6ag
         nN+2JytSr77Jnn9LMJm3i1/V1GxcVnzASZbOUFvwCZEf+ipRQiwMQWi9sftqtQkkIw5Y
         gCFo37irbOyCiXJS9H1Xb7zs0t7N9coWxyS/x0egDmaQwrwgmmLt6pjwH8LgBFSP6+hF
         3lTQ==
X-Gm-Message-State: AOJu0YzEsTy3+LsE5uOTyceFnEX8RQngjjvxSxo+LrhdG1Yp+BBadJrX
	D5fVE4ryClbEsQ5N8ZI3qYcQ74UHHVqjaZ3U6Eq32g==
X-Google-Smtp-Source: AGHT+IFDzIQLW0laXGE7JKd6lbdhFAMnDeThlxxmtoO8UChMspJgCI8sx/aRikQspuJgbcSRJHW6nrx+DUBW3F7ngjs=
X-Received: by 2002:a0d:f685:0:b0:59e:8f6d:92e with SMTP id
 g127-20020a0df685000000b0059e8f6d092emr14665847ywf.49.1696322060718; Tue, 03
 Oct 2023 01:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v8-81230027b2fa+9d-iommu_all_defdom_jgg@nvidia.com>
 <20-v8-81230027b2fa+9d-iommu_all_defdom_jgg@nvidia.com> <CAA8EJprz7VVmBG68U9zLuqPd0UdSRHYoLDJSP6tCj6H6qanuTQ@mail.gmail.com>
 <20231002230000.GA682044@nvidia.com>
In-Reply-To: <20231002230000.GA682044@nvidia.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 3 Oct 2023 11:34:08 +0300
Message-ID: <CAA8EJpr-CpgTVipd_t1uj7iHHq6__pj3mrm4Mn-pdZwhpS8aDA@mail.gmail.com>
Subject: Re: [PATCH v8 20/24] iommu: Require a default_domain for all iommu drivers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Rob Clark <robdclark@gmail.com>, Andy Gross <agross@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>, 
	linuxppc-dev@lists.ozlabs.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>, 
	Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Dmitry Osipenko <digetx@gmail.com>, Jerry Snitselaar <jsnitsel@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Steven Price <steven.price@arm.com>, 
	Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Oct 2023 at 02:00, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Oct 03, 2023 at 12:21:59AM +0300, Dmitry Baryshkov wrote:
> > On Wed, 13 Sept 2023 at 16:45, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > At this point every iommu driver will cause a default_domain to be
> > > selected, so we can finally remove this gap from the core code.
> > >
> > > The following table explains what each driver supports and what the
> > > resulting default_domain will be:
> > >
> > >                                         ops->defaut_domain
> > >                     IDENTITY   DMA  PLATFORM    v      ARM32          dma-iommu  ARCH
> > > amd/iommu.c             Y       Y                       N/A             either
> > > apple-dart.c            Y       Y                       N/A             either
> > > arm-smmu.c              Y       Y                       IDENTITY        either
> > > qcom_iommu.c            G       Y                       IDENTITY        either
> > > arm-smmu-v3.c           Y       Y                       N/A             either
> > > exynos-iommu.c          G       Y                       IDENTITY        either
> > > fsl_pamu_domain.c                       Y       Y       N/A             N/A     PLATFORM
> > > intel/iommu.c           Y       Y                       N/A             either
> > > ipmmu-vmsa.c            G       Y                       IDENTITY        either
> > > msm_iommu.c             G                               IDENTITY        N/A
> >
> > Unfortunately this patch breaks msm_iommu platforms. This driver
> > doesn't select ARM_DMA_USE_IOMMU, so iommu_get_default_domain_type()
> > returns 0, bus_iommu_probe() fails with -ENODEV.
> > If I make MSM_IOMMU select ARM_DMA_USE_IOMMU, then GPU probing fails
> > with -EBUSY.
>
> Oh, OK.
>
> Does this fix it?

It indeed fixes the issue, so could you please post it, adding:
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index cdc7b730192a35..f7ef081c33dcb2 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -685,10 +685,16 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
>         return 0;
>  }
>
> +static int msm_iommu_def_domain_type(struct device *dev)
> +{
> +       return IOMMU_DOMAIN_IDENTITY;
> +}
> +
>  static struct iommu_ops msm_iommu_ops = {
>         .identity_domain = &msm_iommu_identity_domain,
>         .domain_alloc_paging = msm_iommu_domain_alloc_paging,
>         .probe_device = msm_iommu_probe_device,
> +       .def_domain_type = msm_iommu_def_domain_type,
>         .device_group = generic_device_group,
>         .pgsize_bitmap = MSM_IOMMU_PGSIZES,
>         .of_xlate = qcom_iommu_of_xlate,

-- 
With best wishes
Dmitry
