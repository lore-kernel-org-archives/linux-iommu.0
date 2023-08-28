Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569146AD
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 23:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693264700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NqA+se+NtJmo6VZ6Aa5eIZ0Mw7Oak0MLDxzh66FDHNk=;
	b=ZOuLxZiP6JCleCLIrS/kaBM4b5Vp6793Da8FEWuUUwS2suWYsOdIO5gGlx6aIeLxuyvlCl
	WjjncI+dC/4nWi97MEsOwo1HLBRXaf1bBg3ktAkh/T1U9+6MXWL/w5S5hCAQR7gHVx9OJn
	U17O5imRf6Cbxcgid5+dP8CtgVGJc/M=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-5fpLXLpfOKmvxk1aqWAi0g-1; Mon, 28 Aug 2023 19:18:19 -0400
X-MC-Unique: 5fpLXLpfOKmvxk1aqWAi0g-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5660839189fso2390537a12.0
        for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 16:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693264698; x=1693869498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqA+se+NtJmo6VZ6Aa5eIZ0Mw7Oak0MLDxzh66FDHNk=;
        b=hHtQHeS+RwSWvCq5d9IFhswDf7p55JN3698w1wNx8QDuuoecFs01QCF+oOi6vOe25O
         Bs6aAfJzpuFT186g7sxW1vEaJ1OVYDOvHhiJJ19PSTeiyRJl7PI7zRNFaaywz9rNST6N
         sx8Ubf/JX1BMikJRAdCo52/kuUPrtk5x8a51NAAiNYgmJY9X/A6v1OzNDdSkxWk+L71V
         LMHPA8BzmBQZFY9mbMDhc63as7oCP77ab7JyrV9lZzriI4HPNKeQm4Msbh3qfTeUBKYw
         tIuXWiF4lw46z3+hXL52WclFZUR2l1PFUJH67JXFNSgWjUGEi5t0prp0GCfu19qvLSF3
         uThA==
X-Gm-Message-State: AOJu0Yz8dmfbry+n0lQ3XbOut49q/Bb4nneUS3M2YXmKaoe/UywFd5vG
	pTCb88GvtbDTJaoOSRO7y+4IElp3fX1fEt8uL2HCbozj8YUwWVpkJfLD3b8jbOSOPoDfpr0AlqK
	f0fDUsFzNL5oiXsg=
X-Received: by 2002:a17:902:ea08:b0:1c0:a30e:2388 with SMTP id s8-20020a170902ea0800b001c0a30e2388mr17734000plg.31.1693264698534;
        Mon, 28 Aug 2023 16:18:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4PLIDBi9wZuEsVkyH1S0PFnZ5haeuWus0luN/Yrn+a4DV04N4xayoEkUTdP5JJP349iuJ+Q==
X-Received: by 2002:a17:902:ea08:b0:1c0:a30e:2388 with SMTP id s8-20020a170902ea0800b001c0a30e2388mr17733983plg.31.1693264698231;
        Mon, 28 Aug 2023 16:18:18 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001b53953f306sm7947728plg.178.2023.08.28.16.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 16:18:17 -0700 (PDT)
Date: Mon, 28 Aug 2023 16:18:16 -0700
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
Subject: Re: [PATCH v7 22/24] iommu: Add ops->domain_alloc_paging()
Message-ID: <6wbamqxazr3yxu25haul2vcbyt5da5py4i2pemga77pg74knov@htfe53txxkzx>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <22-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <22-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:36PM -0300, Jason Gunthorpe wrote:
> This callback requests the driver to create only a __IOMMU_DOMAIN_PAGING
> domain, so it saves a few lines in a lot of drivers needlessly checking
> the type.
> 
> More critically, this allows us to sweep out all the
> IOMMU_DOMAIN_UNMANAGED and IOMMU_DOMAIN_DMA checks from a lot of the
> drivers, simplifying what is going on in the code and ultimately removing
> the now-unused special cases in drivers where they did not support
> IOMMU_DOMAIN_DMA.
> 
> domain_alloc_paging() should return a struct iommu_domain that is
> functionally compatible with ARM_DMA_USE_IOMMU, dma-iommu.c and iommufd.
> 
> Be forwards looking and pass in a 'struct device *' argument. We can
> provide this when allocating the default_domain. No drivers will look at
> this.
> 
> Tested-by: Steven Price <steven.price@arm.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 17 ++++++++++++++---
>  include/linux/iommu.h |  3 +++
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

