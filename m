Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3714110D
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 20:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693256000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qzw/wSjdBQfPlF1y1vWCr8uR+Xbcc5Ojc8ATgenlbFw=;
	b=MUGBkjX1SAoYiO57oNz+CgGXdx7TXHY4FdNbUtQjx+EMOHix5MUmwXOKax0jjVnQ4JVPQV
	wm5+Qz4TeSV2ZSumGzyMj9R7WDhJKcAPAx4OW/cLWtIO4vgQ7lUY1/5XdCVB/eRMMp429U
	MJIwc3e3KtYIwHQ0luGi7FgkJxVehO0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-km4nCQGGN62nnBOxCtZ9IQ-1; Mon, 28 Aug 2023 16:53:19 -0400
X-MC-Unique: km4nCQGGN62nnBOxCtZ9IQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-40fefde5a99so40650661cf.3
        for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 13:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693255999; x=1693860799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzw/wSjdBQfPlF1y1vWCr8uR+Xbcc5Ojc8ATgenlbFw=;
        b=dCNxESSMW53frcMU/elPzF7D16Rf+meNUgEBVIYGhHtUDdbyfzZFzUq5hD/sNXU2Qj
         FkcLxxzRi5bIXeLwQ0hfmwKXn6RiL5TZYFbWwEycgcQlifa/wZGvoseowdUz+UFmIr+4
         a/GA0sAoaz2bkCzPtzFc/dd7RaB5CGMx8fFf9NaeIlfy/xtC4csMY8iVay6/CpIH7Vfh
         adkVnSFNEBO53I4VCalqleeS+DXeEgeLGbEZO1uxT6k20cP71yHhLwGMc6TeGtk+L09J
         qxgdJfohiiy5RXhYdv7XXbaDeYh4jQD2iD+8gPUR9isf7CbsGuIhW5TNjY7JiOWGLEOO
         U9tA==
X-Gm-Message-State: AOJu0YyU7b8QDJMyrxJPUoQjjAGSbMCG0vEukM4aI5FZh0X87JtPwf7F
	pMgoS7S+rEyTJu3orfMkJqC2FL6y9RMu22NzIFH1jXNByfJ60Vi9OEzHbr78LDA76G4uIrJv7JT
	JFwKtSm/FqEemC/Lpb/nP8mUS3Q==
X-Received: by 2002:a05:622a:13cc:b0:407:fb08:c44c with SMTP id p12-20020a05622a13cc00b00407fb08c44cmr31265774qtk.47.1693255998862;
        Mon, 28 Aug 2023 13:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1P7U6WABsjNUNOIrt30Nh8s3ysfvweacBVh9WudC6nYyRn08u0phTJIzmGkwySv3sSUL+sw==
X-Received: by 2002:a05:622a:13cc:b0:407:fb08:c44c with SMTP id p12-20020a05622a13cc00b00407fb08c44cmr31265764qtk.47.1693255998660;
        Mon, 28 Aug 2023 13:53:18 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z21-20020ac84555000000b0040ff0590fd2sm2553633qtn.87.2023.08.28.13.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:53:18 -0700 (PDT)
Date: Mon, 28 Aug 2023 13:53:16 -0700
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
Subject: Re: [PATCH v7 14/24] iommu/msm: Implement an IDENTITY domain
Message-ID: <37fnmzxe5cqs57gei3i6irsnnybzkbkdjf3nhertw55bb4ke6w@un2o657nczbc>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <14-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <14-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:28PM -0300, Jason Gunthorpe wrote:
> What msm does during msm_iommu_set_platform_dma() is actually putting the
> iommu into identity mode.
> 
> Move to the new core support for ARM_DMA_USE_IOMMU by defining
> ops->identity_domain.
> 
> This driver does not support IOMMU_DOMAIN_DMA, however it cannot be
> compiled on ARM64 either. Most likely it is fine to support dma-iommu.c
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/msm_iommu.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

