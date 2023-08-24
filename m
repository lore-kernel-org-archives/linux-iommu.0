Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89A17F6
	for <iommu@lists.linux.dev>; Thu, 24 Aug 2023 03:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692848507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CH6mXKRKMtD7TEsSEIJfvoLTAwKYFLojoxw+I3lfT8w=;
	b=RT7Hpt/l4CC6ODtBexXQaRi4VOF+gdubIKNO05PYZN7iK59eQvAjLnMI2DjUSGpskUu/OJ
	hfvfPjDlpDLDdk3KONg4dhQ0s71GgN1Ld9ssDe705Aw5yIR8PKczCUmxpVcYWOOmKJKhNr
	1NOXK9hY+n1w4qZ6Fypg3GvZBh318fU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-RWNbm-_zNzqxrTikAVHAtg-1; Wed, 23 Aug 2023 23:41:44 -0400
X-MC-Unique: RWNbm-_zNzqxrTikAVHAtg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-411f7e77b44so10750701cf.3
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 20:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848503; x=1693453303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH6mXKRKMtD7TEsSEIJfvoLTAwKYFLojoxw+I3lfT8w=;
        b=E9IhOV+iP8KthpRa+mwrfoyh3LNw10+hwT/b15i2ieUjgDcXd+3ticxXPdXxu8zVxa
         DnzT1l2oGMxJJnh54Um2uOD624UTwstV+pQBElNsclleTvjPq1RRFUw9HxgZRCRri9sG
         BINFPzcRto3UwA4pVfO/7wp0hWinCy2u+fxAnThZIL3cm672eUoC5h64VRn4wlG/mA0o
         o4y1y+AJocv5fZBS9Y3rm+bzSAHUmDqBrdeqeNxvr0vZyTpWf9y4J8Qp+CnVOfCryCLk
         3xEH7yaeQZO8wJCr9vfmTY12q+yZpUSO+x02C6Z7Sm5MtsPcYZ2DaDUtwClcg2IUl40P
         P1wA==
X-Gm-Message-State: AOJu0YwrvVHk8CkvdsvJl5FcSzcOSqWjvvOVb2Qezm5neMc1/lxT7B+F
	sU5o22wc+iApl5c9f5PHIZRX2jYHdBOPmkq0y6u9UFA+Fo2Gk8+bVAe7EJP0XBY2BpP34qU56Lb
	sTFcYcafVGIFgcgo=
X-Received: by 2002:a05:622a:1a19:b0:410:8551:2608 with SMTP id f25-20020a05622a1a1900b0041085512608mr13211971qtb.58.1692848503553;
        Wed, 23 Aug 2023 20:41:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHjWv1CiL8QEOPMtXQgjOpwEGJSl7biyyoMP2HI5INen9hHlXD9XV1I7hmZP4s4Z/4tJVc6A==
X-Received: by 2002:a05:622a:1a19:b0:410:8551:2608 with SMTP id f25-20020a05622a1a1900b0041085512608mr13211932qtb.58.1692848503326;
        Wed, 23 Aug 2023 20:41:43 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id s26-20020a0cb31a000000b006375f9fd170sm5116337qve.34.2023.08.23.20.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:41:42 -0700 (PDT)
Date: Wed, 23 Aug 2023 20:41:41 -0700
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
Subject: Re: [PATCH v7 01/24] iommu: Add iommu_ops->identity_domain
Message-ID: <r362pqn2venwjut7ernpzbxnc72kvknshxeobrvkvp7p5m554e@7jnu4wja663k>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <1-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:15PM -0300, Jason Gunthorpe wrote:
> This allows a driver to set a global static to an IDENTITY domain and
> the core code will automatically use it whenever an IDENTITY domain
> is requested.
> 
> By making it always available it means the IDENTITY can be used in error
> handling paths to force the iommu driver into a known state. Devices
> implementing global static identity domains should avoid failing their
> attach_dev ops.
> 
> To make global static domains simpler allow drivers to omit their free
> function and update the iommufd selftest.
> 
> Convert rockchip to use the new mechanism.
> 
> Tested-by: Steven Price <steven.price@arm.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

