Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D5D1110
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693256631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HWGAjWA2SZIgARlOfsf2TOxHPntdeHshE+ifQSu/y8U=;
	b=SJy7J7OO5NgCERnXV/0/R0fqYuRw7BCXluBJhF7R8Cv3Eudkt8kzf68fkDLvuWSFjMgYT2
	+Tnfn2mg2IPm2P+9ydYF9beTYpqNMzvQH85nKpjiV0JxIctRd/F5n6z2aosUVCjoFgqF49
	oDONxOsCnym5ahxTMQkzEkgG9gvkoF4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-Z-M9jUqoPmS0JhnkB8Wkpg-1; Mon, 28 Aug 2023 17:03:49 -0400
X-MC-Unique: Z-M9jUqoPmS0JhnkB8Wkpg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76ef8b91a84so297946085a.0
        for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 14:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693256629; x=1693861429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWGAjWA2SZIgARlOfsf2TOxHPntdeHshE+ifQSu/y8U=;
        b=gLmLhD4L+qbsdQaJgXckYP774uzEehWKcphRQfAbRbEW22XfP68OhOUXYjXr6jNopO
         75q3vQH/yznxAdUu7XHDUwDu4xDN93hCe7luqmtpWosFTsjvqMhnbxFGs/0XrL83DYgN
         ndmU6tWIFk8dEO33sJ+nhyozXasLr2fyjBWdNbBN4P5zXG3Jp9aACaZVqvN/+RtNt18V
         z7ZcFgkKLp7Nd3MBLiBuP/WhqTS+nAHgB9zxE4q3Zfm43owvKPNo4V6hLcRTZ9whiles
         88R98vmsJlzJvIEpjVCbhsrYURskiLXSV1/K/Dfr8GWBJBEvuTJYk4qyxvLwC+dpFr2O
         5D6Q==
X-Gm-Message-State: AOJu0YzXmtwtssUI9rJ/fPJtNY6DDj9DWcMSpFa1n040eEFUIba69Ty7
	O1RBGdoRvvrHqSVa1vj+0rxmSo974+2KQyzKUsjAHjwGNQSZmnC6qbqgdqOEQ6ktmI//8xbEpGi
	SWwyo5C1UCaff+hw=
X-Received: by 2002:a05:620a:4043:b0:76d:a569:cca9 with SMTP id i3-20020a05620a404300b0076da569cca9mr1135622qko.16.1693256629208;
        Mon, 28 Aug 2023 14:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPzgbmIBwnSRpgIiayc8cNLu07wX9Qi7uegSYIbsuDejPaJeraN4CSa9e1P57NFTVOJ82DNQ==
X-Received: by 2002:a05:620a:4043:b0:76d:a569:cca9 with SMTP id i3-20020a05620a404300b0076da569cca9mr1135581qko.16.1693256628994;
        Mon, 28 Aug 2023 14:03:48 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id l19-20020ac87253000000b0041061a16791sm2555777qtp.67.2023.08.28.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 14:03:48 -0700 (PDT)
Date: Mon, 28 Aug 2023 14:03:47 -0700
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
Subject: Re: [PATCH v7 18/24] iommu/mtk_iommu: Add an IOMMU_IDENTITIY_DOMAIN
Message-ID: <co5jqsviedblnyi7gkdkjuo6n3ai6o4qvzclvqfyrl6h7ugtdr@lkwojyyjq3qh>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <18-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <18-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:32PM -0300, Jason Gunthorpe wrote:
> This brings back the ops->detach_dev() code that commit
> 1b932ceddd19 ("iommu: Remove detach_dev callbacks") deleted and turns it
> into an IDENTITY domain.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/mtk_iommu.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

