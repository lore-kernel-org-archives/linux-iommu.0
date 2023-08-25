Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91845CAC
	for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 21:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692998156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RNGvpBuIiKL3Cl4QX+janawTefek15UWSwqXPvpbHmo=;
	b=cwtllQin9aGNGDGC4sewr4XinJEewwlqvkNuo3F3po0QfRD+7ufjiyyhs5t2pFbyuDTzfW
	BSM0y8P792D6u+QtMD2G2EL/WCvs0OBVjTDQ+nIbcbReqH8xfsLF+BPnWAXxs9YL9HFv5F
	S7Wor7sjEvNi0oYW58c3JZ75a/EOQCg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-W5vjmbO4O26B8foSfX90eQ-1; Fri, 25 Aug 2023 17:15:54 -0400
X-MC-Unique: W5vjmbO4O26B8foSfX90eQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76de9c1d13cso141090385a.2
        for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 14:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692998154; x=1693602954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNGvpBuIiKL3Cl4QX+janawTefek15UWSwqXPvpbHmo=;
        b=luSZR1+PcQI0qPkCIeIZlHwSmqd7N9M402g+ljS0rgpk08Dxd0QVU2GZ8UQoFIshfh
         I5HZYLRQDq3SEVqaSSQcMPqKziB2NyDKQ733n1tnVwg/daqjWdHQ4IeWpGceSRMxYi0m
         BiVtk8DKKNAFVUVAQIZQmB3oiw2+VWIuorsjEofJ2onmnBBDyiZIleVFKOInEd1Ve919
         SZSrPcxHzWe4SzEF4XQ/y9/tlWyRKQNqghiFQPjHIzEuvE5/N2Jlkf5vduBAerDd3ax9
         ssT9+g56qf5za1xKckcm01CldfApRbjI2FlZpA/H0W2bCGhc9zly7DHGVxtAVLJMR87m
         ixDw==
X-Gm-Message-State: AOJu0YygQD56wfDd9kS2Dvxbu0a/k2DtjsQB773/52KfZbwt51WcRp1P
	bo32vb5uhXBfldUPETrTkdYm8vdo1ADi/f8B5OUT3Qd1w7mAYHilr5vSm3KcKwBWjgLiV3wUbcz
	H4W+N9Cnax3X1RpQ=
X-Received: by 2002:a05:622a:138c:b0:411:fc77:5863 with SMTP id o12-20020a05622a138c00b00411fc775863mr9742851qtk.34.1692998153928;
        Fri, 25 Aug 2023 14:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGkTdJ1PESb45xmKP1IyMr0VhacrVsFun4AHO5ghG+vkiiDrIbNOg/oEp2bfPugUDBb4fzHQ==
X-Received: by 2002:a05:622a:138c:b0:411:fc77:5863 with SMTP id o12-20020a05622a138c00b00411fc775863mr9742803qtk.34.1692998153629;
        Fri, 25 Aug 2023 14:15:53 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id i3-20020ae9ee03000000b0076745f352adsm759948qkg.59.2023.08.25.14.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:15:53 -0700 (PDT)
Date: Fri, 25 Aug 2023 14:15:51 -0700
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
Subject: Re: [PATCH v7 04/24] iommu: Add IOMMU_DOMAIN_PLATFORM for S390
Message-ID: <qlgsyftnpb55wn6jcsdx27u3vnc66h5dmtcuelw4y5wgk3vorf@ctgykaa5wp7d>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <4-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:18PM -0300, Jason Gunthorpe wrote:
> The PLATFORM domain will be set as the default domain and attached as
> normal during probe. The driver will ignore the initial attach from a NULL
> domain to the PLATFORM domain.
> 
> After this, the PLATFORM domain's attach_dev will be called whenever we
> detach from an UNMANAGED domain (eg for VFIO). This is the same time the
> original design would have called op->detach_dev().
> 
> This is temporary until the S390 dma-iommu.c conversion is merged.
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

