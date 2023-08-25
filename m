Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC419397
	for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 20:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692995074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T9GaVO4jGruWR+C5Izp9D7v0Lmi9Kx5kTKgCOaeAvTc=;
	b=NaFcTyN5fkzp392RI9XQScQEw8Z2+t8sQBntQK+r1+2bMVqgt31mtU71Bxzp2iJUKn06uV
	eH2duvFbGAX7qfInz7tmbEK0OauFS4CEpOXgkPJ3BiAhCafrmWEyqiPpKaDJjvjg5DzQvs
	o18R3PF0gOTHLBHk/pzzkxSBKcSZdRo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-KklEYDE9NGOG1BuufwsH0w-1; Fri, 25 Aug 2023 16:24:28 -0400
X-MC-Unique: KklEYDE9NGOG1BuufwsH0w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76e1a6a107eso135890985a.3
        for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 13:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692995068; x=1693599868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9GaVO4jGruWR+C5Izp9D7v0Lmi9Kx5kTKgCOaeAvTc=;
        b=FRJ/3wpIZQRU01U/UsD1gar1vBIGCINBgK+GOtDKeXDpq3Cv+Grtvl2CihuiFGVnLc
         abmh5nMeKF2vx1wWc0VBUhLbpSz71fb0kb+5Q3rsFxHjWO3KPmErt+XQsXinVpj2wDDb
         UKtk3O5hzez1cUecSO6PjbSrbG6yYI8k0rDH3y8zCCiJdzpWOHjmf7vF7ue1/iwVPVz1
         UJ/HNeoFzi4aZsVm3oPoMDrqzSsYiOcuaRa6P6PWu958d3fCHc265Z1Gs1eBxBm0vV2A
         ryhMjL9QApwFcPSPnMjT9bKIMl/SMpfHwtScezO5Y6SbaMuvfhiMM7Uen7Pw4oqy1FRB
         jT7g==
X-Gm-Message-State: AOJu0YyH+hsNL4GG1exlO7GvNRyswc1FCfJVU0hAX/bl/gAMERPSlUye
	tau6AJeQ+zA8RVlgXcYalqQrKPn5nEtb4HQfGPnXQkwoOxm6qjcDzz1PhFEqNZUVNor4dBkGcys
	v2bKgETzIXoNVRvQ=
X-Received: by 2002:a05:620a:4009:b0:76e:eeaa:a079 with SMTP id h9-20020a05620a400900b0076eeeaaa079mr7880691qko.10.1692995067922;
        Fri, 25 Aug 2023 13:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLBKI1XGw7s6CbX7jhIzTvhmgnGyxca1Jm6YHCiJ3dxbM+m70gQmthLg44868T29Hr/JESWg==
X-Received: by 2002:a05:620a:4009:b0:76e:eeaa:a079 with SMTP id h9-20020a05620a400900b0076eeeaaa079mr7880679qko.10.1692995067632;
        Fri, 25 Aug 2023 13:24:27 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g7-20020a37e207000000b0075cd80fde9esm741104qki.89.2023.08.25.13.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:24:27 -0700 (PDT)
Date: Fri, 25 Aug 2023 13:24:25 -0700
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
Subject: Re: [PATCH v7 03/24] powerpc/iommu: Setup a default domain and
 remove set_platform_dma_ops
Message-ID: <zbmf64fbpp5zsolyqd74px3hpgvvorc3xal6pvaxdw3uoccb6c@epcqhetd6n6l>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <3-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:17PM -0300, Jason Gunthorpe wrote:
> POWER is using the set_platform_dma_ops() callback to hook up its private
> dma_ops, but this is buired under some indirection and is weirdly
> happening for a BLOCKED domain as well.
> 
> For better documentation create a PLATFORM domain to manage the dma_ops,
> since that is what it is for, and make the BLOCKED domain an alias for
> it. BLOCKED is required for VFIO.
> 
> Also removes the leaky allocation of the BLOCKED domain by using a global
> static.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  arch/powerpc/kernel/iommu.c | 38 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

