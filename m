Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5B10F4
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 21:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693258314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dVb5tmc8EbITtSkSc6gJJy1RyzNckSiwLu+iLvVILak=;
	b=Lau8zgtjsq1xfaMsthbVscRzJDNaG8nLYcBgVoic9zvHk6QFdxuluFVZKet/GoIK5D6yTT
	6SQDtNWX+oT04JxNjcG7ejEc/OxOXnTni1gSNyVIUqOX11ZnuMwzonHStJyQVGdHK2GMht
	gC5xhzr2m0Vwvmz6rwcgQ9d99Ip7hP8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-eMyv1CA8OtufG43EBHLasQ-1; Mon, 28 Aug 2023 17:31:52 -0400
X-MC-Unique: eMyv1CA8OtufG43EBHLasQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76de9c09746so463762085a.3
        for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 14:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693258312; x=1693863112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVb5tmc8EbITtSkSc6gJJy1RyzNckSiwLu+iLvVILak=;
        b=BqAeYLm77KugleOzptElrIzcdbFS74Wad1t+nffAP5/jcuBj+PT+9E0ejcMlkbvDeU
         D8giVhV0QyU47A/a2oKn7NPgebPl7CjcRNp1iD3ltVKxZ+/BBc1XGOzNiAMaLh5Zlhxz
         eTr9xDl8O/LAGGlKGAkqC8yVhqC6TYGaPtHUxn3BPWMz1XhQoAVSopmF4ugsQX7ojjC0
         VWQqinFY94a6nWNXXB27SGpyBgP25VJWI9spenhJIBoHb+AGl3GhyZdJFVgtOdWsfMR7
         2kcSpzGPKA13K4tWry0wa3dGa2vvBdErcWDPqs9wFFX0QtQYws7ROlAmLQCNFqrD8mTr
         6SFg==
X-Gm-Message-State: AOJu0Yw6yuc5aqKCSkwoThLoTFxS5yioYxTGsQ5T9Lc0LzXhMK3LObx+
	ZId8dQRaNqdo6kHrV3NdWkNbjba0KTRyXBpkMyxF32x2ToObodEoZA07qSY9m6iqdiG70nD/zoo
	5YAJGuB33ra2gf0c=
X-Received: by 2002:a05:620a:9c7:b0:766:fe28:35a3 with SMTP id y7-20020a05620a09c700b00766fe2835a3mr28616585qky.32.1693258312046;
        Mon, 28 Aug 2023 14:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuVcTMTBbnLPs86MnCDU8eGTgJIDkNhQ+SHq++g5N+BlxbjD8TqX467y2sj6EMGyNhF/9w9w==
X-Received: by 2002:a05:620a:9c7:b0:766:fe28:35a3 with SMTP id y7-20020a05620a09c700b00766fe2835a3mr28616567qky.32.1693258311828;
        Mon, 28 Aug 2023 14:31:51 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a12-20020a05620a124c00b0076f16a00693sm697233qkl.47.2023.08.28.14.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 14:31:51 -0700 (PDT)
Date: Mon, 28 Aug 2023 14:31:49 -0700
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
Subject: Re: [PATCH v7 21/24] iommu: Add __iommu_group_domain_alloc()
Message-ID: <dwrebxdzqjhnryum3czsh6zroapbhpjre7untly3cvl2tn3nij@hpckzx65oxx6>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <21-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <21-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:35PM -0300, Jason Gunthorpe wrote:
> Allocate a domain from a group. Automatically obtains the iommu_ops to use
> from the device list of the group. Convert the internal callers to use it.
> 
> Tested-by: Steven Price <steven.price@arm.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

