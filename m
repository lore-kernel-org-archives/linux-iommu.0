Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D44134D4
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 20:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693254356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0s9odd+rKCTI6ikiachNnQFGjcYGlZyEVlbrTzPdyIQ=;
	b=fVlnrtkMBtKqw3AFBsB7s+XdxmoyI/b4f2q8DCxWGESDA7ALtsqHKg5DTrNdVp/E3SvGD9
	aq87hKfoodSpu1lfpgcccP6izi0rSyyfP0tCXwvAALP8jFcOmL10yuiOFWj8XV53irLygc
	GX2Ck2YM0kgkehI7FUKFym/kNcYx2qI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-OLu5XqFVOqS7pu8NeWFUXA-1; Mon, 28 Aug 2023 16:25:54 -0400
X-MC-Unique: OLu5XqFVOqS7pu8NeWFUXA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76e26652e6fso457219785a.2
        for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 13:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693254353; x=1693859153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s9odd+rKCTI6ikiachNnQFGjcYGlZyEVlbrTzPdyIQ=;
        b=SdNYJzU2z8Ku6VXrW/3EMXtfsXSaxlYpsm/StVnIlWxLWGQp8KXuhF/q1Kufu5jR2G
         A4Bsr2qvIWO6nfzQTzU6sbPTHXv+YGjlYekXNCe2V+LOd/OltkRulGJqXWqWjbBJvLZz
         nSaBLrExX8HJpOM6/11LGudM1wqXjzp38CJ+OocLMvmPNsTS+0h4WakPrF3htimXHwgt
         2AnReeV1gbVyEdeELfngdfxp37ZlkoSpFhlLQNPAGVeRouNefnXrB5p/9wDzz6IQQxLe
         YWPEgtAvRCJRD9R+zSK0K7Gy1RjC5kdZxBjRgeg3OkywOE5shijrKVWr5LwWVK1KVqlN
         aoaQ==
X-Gm-Message-State: AOJu0Yw2/bZztVksRNXyI4h6f5ivqQRU8Tpox8DdjP+XwZ9cFBF8WAVX
	zIjakIObvKh41mEw6JnI0ms87nlW+zeMTqdqLJyre7zLz/aS0e5rfvMDtyJpaotXqspADkM3OHS
	NyJRGvoV5Bzkfzg4=
X-Received: by 2002:a05:620a:221:b0:76d:c63e:8e70 with SMTP id u1-20020a05620a022100b0076dc63e8e70mr14041509qkm.27.1693254353202;
        Mon, 28 Aug 2023 13:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9O6FxP0inVTnVJ2vRf5VolLj9Ux6/2WGBYm17sZOw53hmRs71i9SgIXCArw27HMmN5iSTDg==
X-Received: by 2002:a05:620a:221:b0:76d:c63e:8e70 with SMTP id u1-20020a05620a022100b0076dc63e8e70mr14041474qkm.27.1693254352979;
        Mon, 28 Aug 2023 13:25:52 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id o22-20020a05620a111600b0076816153dcdsm2613458qkk.106.2023.08.28.13.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:25:52 -0700 (PDT)
Date: Mon, 28 Aug 2023 13:25:51 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gross <agross@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Bjorn Andersson <andersson@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linuxppc-dev@lists.ozlabs.org, 
	Matthias Brugger <matthias.bgg@gmail.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Rob Clark <robdclark@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>, Chen-Yu Tsai <wens@csie.org>, 
	Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Dmitry Osipenko <digetx@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Steven Price <steven.price@arm.com>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v7 11/24] iommu/tegra-smmu: Implement an IDENTITY domain
Message-ID: <mqc777v7h4bpz5xgfcqjqig4zoo3ifobiyut4r43dghkxp3yl2@uyb72ermxszs>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <11-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <11-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:25PM -0300, Jason Gunthorpe wrote:
> What tegra-smmu does during tegra_smmu_set_platform_dma() is actually
> putting the iommu into identity mode.
> 
> Move to the new core support for ARM_DMA_USE_IOMMU by defining
> ops->identity_domain.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/tegra-smmu.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

