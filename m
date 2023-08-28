Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E83A13AF8
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 19:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693252592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+aPLP5Dvqf88CiJMFQl9Auucq47ZaEdR+LnhUOVMwHI=;
	b=F6eWE2XfSec0Gf/5CMCgTQkpFPmrbGAwyzJg2PfLzbTfAJ9TOOutp1kw8w/aVdJLXPJv8p
	Aow5GyiUoW96lSj2GUazw5bL4FBboc/qvsrESVcd4qL8HUVO/gK8e5v9Xvl1J8i8rbvArz
	IxYUTKOTxcCfKYojjdotUqLfCtEYofM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-DurTKRAAO32xayrkAVSjPA-1; Mon, 28 Aug 2023 15:56:30 -0400
X-MC-Unique: DurTKRAAO32xayrkAVSjPA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41213943314so29079501cf.0
        for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 12:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693252590; x=1693857390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aPLP5Dvqf88CiJMFQl9Auucq47ZaEdR+LnhUOVMwHI=;
        b=O5HQ7BBOKJVC9vySrLk3fUChzL7S+4baAQbypQYgqtMGdS/6O/dVEFskuyZHPfWudd
         Xet3dOz0TJdb8MXVQHWc/OUT61B7Z8JsG2UEqJSx1gJDIUux/CcQD8oeh+2kGklVTn3A
         8qGCiId7w73cqvreGIN5ZiQF6PWjFCi3Hm33jI4v29poRn9muTAotnXWyZ8sBy0tnILv
         Vee5sMC8w0TmHSD3OND0NdGJY8+PmMn1yWwCYypjz02eBRGARRec4T88nOykW0TNjSwy
         smELuJzaWpM761qQ+yWNuo+JSunraZVvENHmFugLebf0XTt/Zb/ghhpfj1mxldXnyY+7
         gNZQ==
X-Gm-Message-State: AOJu0Yx3GGKcbmkhPH0LoSD0U32HqjiA+RHZZtp0jBTpu9mr72k6Tdsk
	1a+WdNQekK7+Czgec8UGJCnCmy5YKrzwWw8S9WFHm5YkQelxDN7hVhIWkvxlqFMBRomKxdHZ5q6
	XQq5pCrgU7gGCJQ0=
X-Received: by 2002:a05:622a:1b92:b0:403:fd62:ce75 with SMTP id bp18-20020a05622a1b9200b00403fd62ce75mr28216015qtb.5.1693252590264;
        Mon, 28 Aug 2023 12:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsYP9ZZ2CsJhUv0f/7ePOTXR8lCjq1Is30niybYFTHi0Enn8YltRs8yVE4tVH5Ow+UhbE98A==
X-Received: by 2002:a05:622a:1b92:b0:403:fd62:ce75 with SMTP id bp18-20020a05622a1b9200b00403fd62ce75mr28215977qtb.5.1693252589954;
        Mon, 28 Aug 2023 12:56:29 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id d4-20020ac86144000000b0040ff25d8712sm2559692qtm.18.2023.08.28.12.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:56:29 -0700 (PDT)
Date: Mon, 28 Aug 2023 12:56:28 -0700
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
Subject: Re: [PATCH v7 08/24] iommu: Reorganize
 iommu_get_default_domain_type() to respect def_domain_type()
Message-ID: <3pxd6d44iejlvlijiyd65ze3wfsvvjtgrvstwhgp423uwutrz6@dak5ytcxcspv>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <8-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:22PM -0300, Jason Gunthorpe wrote:
> Except for dart (which forces IOMMU_DOMAIN_DMA) every driver returns 0 or
> IDENTITY from ops->def_domain_type().
> 
> The drivers that return IDENTITY have some kind of good reason, typically
> that quirky hardware really can't support anything other than IDENTITY.
> 
> Arrange things so that if the driver says it needs IDENTITY then
> iommu_get_default_domain_type() either fails or returns IDENTITY.  It will
> not ignore the driver's override to IDENTITY.
> 
> Split the function into two steps, reducing the group device list to the
> driver's def_domain_type() and the untrusted flag.
> 
> Then compute the result based on those two reduced variables. Fully reject
> combining untrusted with IDENTITY.
> 
> Remove the debugging print on the iommu_group_store_type() failure path,
> userspace should not be able to trigger kernel prints.
> 
> This makes the next patch cleaner that wants to force IDENTITY always for
> ARM_IOMMU because there is no support for DMA.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 117 ++++++++++++++++++++++++++++--------------
>  1 file changed, 79 insertions(+), 38 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

