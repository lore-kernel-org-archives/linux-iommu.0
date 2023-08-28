Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA36410F4
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 21:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693256456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mPucHT4vAUhtQdeHUtkBDDGaES5ThoGt/JYy///1HlU=;
	b=ClfVnh6sjQQIwTVzkFNU5fb4fXdrHIe1gE+0oXYFCxtZR2TdB927h321Oic3MqzUrHWa/n
	4Ln23rGjT6pMKqZQkY8HLkOFDsQD1PGYZhmLjVJU1zm/l4oipi5IUvmhRqLh30NDYBLda1
	WR3w5snZrA2vbdPAW5w4f6wLa4IefSw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-PgInXjjzN42-Fcvn2fTGiA-1; Mon, 28 Aug 2023 17:00:52 -0400
X-MC-Unique: PgInXjjzN42-Fcvn2fTGiA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76d86b5e2f1so509716685a.2
        for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 14:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693256452; x=1693861252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPucHT4vAUhtQdeHUtkBDDGaES5ThoGt/JYy///1HlU=;
        b=XDqd4vM5xkAMn009rY2wzAfVRR5TlP2hVStX50Ap/JjhBSlHAOmy4O8kqvsgW2UyyB
         MeJFA8KrU3d9VhG+MrrXVFo4F2iSmX9u5020MNcdytICP4fXIGX/O7f4e+4ofP9IImL4
         niJSUB0djbBJDwS5K+/4xbtt66s4dXJ+8cotUmKwIiNHqWRZInofs9iZh5I9frxhzj3c
         3Eao08bYwIWhC1nYiawS2kfTCtxtrKKVzn7F48hNXjmcZ6DBGwH+fCAZ/cz5AnhbygHy
         KZ/3v9SgLRsEA7ukzZQG7drpmDc5PTXfBNWFHMEXO7OFuOpUY7AEoj1q3uS+FigtRD0u
         V7OQ==
X-Gm-Message-State: AOJu0Yz8APbczvY9Ew79yKfI3gcEBlzooksTyy/5eQ5N7QikRLa8fv00
	W2Y6SbnC45S9vRWff0DKtoZEZunetKR3lEc51yzVE9HpgeDuHzN7j94oxOdnWv33rUjygmA+qws
	xEW2bEViehwFnFUo=
X-Received: by 2002:a05:620a:254e:b0:767:dd2c:9a1 with SMTP id s14-20020a05620a254e00b00767dd2c09a1mr32435896qko.20.1693256452117;
        Mon, 28 Aug 2023 14:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc76gVDSQjoSi7VzVoCzv2VufWTRTR2JHknan7WgS/aaS2xw9REImaP5+SJVlVkj2Kooggog==
X-Received: by 2002:a05:620a:254e:b0:767:dd2c:9a1 with SMTP id s14-20020a05620a254e00b00767dd2c09a1mr32435844qko.20.1693256451852;
        Mon, 28 Aug 2023 14:00:51 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v14-20020ae9e30e000000b00767d2870e39sm2642220qkf.41.2023.08.28.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 14:00:51 -0700 (PDT)
Date: Mon, 28 Aug 2023 14:00:50 -0700
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
Subject: Re: [PATCH v7 16/24] iommu/qcom_iommu: Add an IOMMU_IDENTITIY_DOMAIN
Message-ID: <cfl4ixqvcradllxpjzbmyikl6jtr5q53tipn4p3bka7obavxjj@novxolxpv7sr>
References: <0-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
 <16-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <16-v7-de04a3217c48+15055-iommu_all_defdom_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 01:47:30PM -0300, Jason Gunthorpe wrote:
> This brings back the ops->detach_dev() code that commit
> 1b932ceddd19 ("iommu: Remove detach_dev callbacks") deleted and turns it
> into an IDENTITY domain.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 39 +++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

