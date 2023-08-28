Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEFC134D4
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 20:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693254450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UKJOgsnfF2FTgMzr7BpoixR3SpR6vuzOkPfvbf/VtFg=;
	b=BSL7MeidQvLgjmnXbgs3GQgzV2ClCCa0RnY+VmcbciUFUxnaPFGPgEoU7VxhlnnjiSsba/
	l+kE4QURtP9MTNNO7i6CpcRFgjedhJfms6Qvh67Vgxau06b0IM1+ye9Au0TZ0t3y/BMeym
	zy2juSBOhW+JzdeVZMN72nuubui/B2U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-mDfd42YLMgSU25ouPsxkoQ-1; Mon, 28 Aug 2023 16:27:28 -0400
X-MC-Unique: mDfd42YLMgSU25ouPsxkoQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63cd1ea05d7so41226526d6.0
        for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 13:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693254448; x=1693859248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKJOgsnfF2FTgMzr7BpoixR3SpR6vuzOkPfvbf/VtFg=;
        b=aQiiYUfJHx2robDzkkN8Y4cWarg1dKRVEfDikySA+fLiZgZeh4pFbUJbp/3kpCWC+A
         IGowPRfwAoyVeEx9PKnlKmW2PcbfJwPMvjjh9zb4C+yfHIE4r8JxuZuZVOP14Vj5hRPI
         lMGMhlIYlYoHT0Dmz272E0FX3r46UdqJ8LVkD1dAFvaXrXiWNwRw4QJBwo5w1tRVLzds
         7gI8+XZXhOUTT+VzIfVVt4WAtso1dygvwzvCLAjklzPLSyH+mJDlC3qRedljfTJN9BhV
         FG5UKrLRCoe0v4RUiDAqdj8tb6aBdtx0rvDCLCQfQ/qR71A8YalI5pElliXDhlhm1eqE
         LFQQ==
X-Gm-Message-State: AOJu0Ywj5mh7006A2/2w46BA4OnMpK/YlZbN7nd7LZ1xgHBgMW2aFMn5
	SdCMbgxg5kmPxyl3v/UD52OQo1tgiwk8SwNUqmTS69cyJ0yZCGnKCXLN7uc2rC49LgEFKkfYxBz
	R5TR8/YIltLrdm/o=
X-Received: by 2002:a05:6214:1946:b0:64b:926a:e7fc with SMTP id q6-20020a056214194600b0064b926ae7fcmr1021337qvk.21.1693254448519;
        Mon, 28 Aug 2023 13:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqFPUIE0VD3pPuJr6SEA/sCAWUcKffhBaA+0iqWdlm0BRzVqkbCdfoX5jw79sJViEhNnh3nw==
X-Received: by 2002:a05:6214:1946:b0:64b:926a:e7fc with SMTP id q6-20020a056214194600b0064b926ae7fcmr1021306qvk.21.1693254448284;
        Mon, 28 Aug 2023 13:27:28 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x10-20020a0ce24a000000b006263a9e7c63sm2767781qvl.104.2023.08.28.13.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:27:27 -0700 (PDT)
Date: Mon, 28 Aug 2023 13:27:26 -0700
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
Subject: Re: [PATCH v7 12/24] iommu/tegra-smmu: Support DMA domains in tegra
Message-ID: <pqocyap65uirlogtdy6fw6gb5qc24zrk6r235krllqj3qrcv3f@4xcew7khwydt>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <12-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <12-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:26PM -0300, Jason Gunthorpe wrote:
> All ARM64 iommu drivers should support IOMMU_DOMAIN_DMA to enable
> dma-iommu.c.
> 
> tegra is blocking dma-iommu usage, and also default_domain's, because it
> wants an identity translation. This is needed for some device quirk. The
> correct way to do this is to support IDENTITY domains and use
> ops->def_domain_type() to return IOMMU_DOMAIN_IDENTITY for only the quirky
> devices.
> 
> Add support for IOMMU_DOMAIN_DMA and force IOMMU_DOMAIN_IDENTITY mode for
> everything so no behavior changes.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/tegra-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

