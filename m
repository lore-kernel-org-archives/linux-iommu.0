Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A2193B2
	for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693001752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kso0bHAJbNi7PoOyIay86CVNgj3x+jo0WkAZo3ICUzc=;
	b=I/b1eeDSrtzINZmmsMuwwvD/o4MHLL81h0N+3E+bVBBHsT/99GKvHzwVtcQhFDKGY5ZUh2
	aNuluPA5ks13R9sOsdrpDZKOKEF8WFMtBCof+T0rTADWLjazWUK6S++HE4L1abuAgURUBH
	XbcZJTwYz5PMETA+3+NSmJaQtaWAibA=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-socdtnWdNp6j0I-SpIUpbQ-1; Fri, 25 Aug 2023 18:15:51 -0400
X-MC-Unique: socdtnWdNp6j0I-SpIUpbQ-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5735bb13261so255624eaf.0
        for <iommu@lists.linux.dev>; Fri, 25 Aug 2023 15:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693001750; x=1693606550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kso0bHAJbNi7PoOyIay86CVNgj3x+jo0WkAZo3ICUzc=;
        b=hLIt9l0cht+l1xpUcGNuxZaraAwv8MwyJdkx0fNHWQf4tPv0GjJqwFzyPswg0KAyPh
         rmdaFLJ9laIOjH90bH1RI3ZNxwbTADMABn8e+N8n04obAdzPnV8wMqTaV3bM1AXhl0Hd
         xB7YLxKxpBABgnSsDEdC3mZpeWe2atr+pLeCqlirO6RNBFwqKEFI8y9d6r9qColwqYCr
         bxkCQ0lKK8qLRqt2fivptz9/I4FmgbPza6sCKshnH/YxQc46jDm7L4Ml8cLeARHKtt/g
         3GFuDKxnqJD8OSm2oWxyou9WkHdSSyOejP9YjInv7AM5Rjg8p36p0/4s9Kubz9X+8sOf
         Pxng==
X-Gm-Message-State: AOJu0YzmtOjcNMbuupqa/SprTNLVevtX5NRhAZlRJPhW2ZdXF0wTXein
	9yqAFHoCyjBpAtbuYIG12m/wEkgB5A+sz9yrwsV9Eb+njN20QDjmeJ4hc0188acD+yxOW1daK5h
	7mGUBZcigk9BLgJ4=
X-Received: by 2002:a05:6358:7e53:b0:139:d0bc:acfa with SMTP id p19-20020a0563587e5300b00139d0bcacfamr20095492rwm.23.1693001750539;
        Fri, 25 Aug 2023 15:15:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkY4Kv1xGxroqOwtsL16yLvAJMOO7lHXk5XmHI00VwDkZfKODP2FZnPBehYOmoTkQvGLsKdQ==
X-Received: by 2002:a05:6358:7e53:b0:139:d0bc:acfa with SMTP id p19-20020a0563587e5300b00139d0bcacfamr20095448rwm.23.1693001750156;
        Fri, 25 Aug 2023 15:15:50 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v19-20020a0cdd93000000b0064f3b0d0143sm816749qvk.142.2023.08.25.15.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 15:15:49 -0700 (PDT)
Date: Fri, 25 Aug 2023 15:15:48 -0700
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
Subject: Re: [PATCH v7 07/24] iommu/mtk_iommu_v1: Implement an IDENTITY domain
Message-ID: <yentwv7rhnjolgvcdq23e2tizhpduwbpgaojrmaqnsuzvsrlsh@ey75l3ffixok>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <7-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:21PM -0300, Jason Gunthorpe wrote:
> What mtk does during mtk_iommu_v1_set_platform_dma() is actually putting
> the iommu into identity mode. Make this available as a proper IDENTITY
> domain.
> 
> The mtk_iommu_v1_def_domain_type() from
> commit 8bbe13f52cb7 ("iommu/mediatek-v1: Add def_domain_type") explains
> this was needed to allow probe_finalize() to be called, but now the
> IDENTITY domain will do the same job so change the returned
> def_domain_type.
> 
> mkt_v1 is the only driver that returns IOMMU_DOMAIN_UNMANAGED from
> def_domain_type().  This allows the next patch to enforce an IDENTITY
> domain policy for this driver.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/mtk_iommu_v1.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

