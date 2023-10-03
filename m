Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FF2942C
	for <iommu@lists.linux.dev>; Tue,  3 Oct 2023 17:34:50 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2c186ea81c7so14103061fa.1
        for <iommu@lists.linux.dev>; Tue, 03 Oct 2023 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696354488; x=1696959288; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czVNBFVVhSN57f1C5bOMBkgsrsL4Q+/2Zk2ObpbPw5g=;
        b=pnapzEYs0Uq6uG0Gm+priXO//+BuFw11r9dIqNLRYishDvdklK+gUhVT6qbjrQGgu8
         OQdl7re76BpkbJgzhboqN9sFyESs/tRf1opP24xL5XiTzcUTJ19RQ0fGfalEJDTUAHX4
         +PT557kyeVlAR8miEQCHWCCX4IfXRarSJ3JDqoSf72xc5TqS4t4VZ9TcBPc/htFc6aKw
         F9H/6VHO/lbw0omMudSSb57LO3w+DKV3RHXwo3OBNGh4SSj0OEAbue4bSTsoTLKpE9n8
         5iGT1QX3sdd+0cIDHPeqt8Foe0UfIwniwFdAR7e/eT/LCwx9nJU+C71cbXyYJqj2yTwF
         86Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696354488; x=1696959288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czVNBFVVhSN57f1C5bOMBkgsrsL4Q+/2Zk2ObpbPw5g=;
        b=C3zg1AjMubhfX8rciwagTLN+O535jZhmFOusyH6ajjElt3d60Y0Na3B7SHTbIKJr+h
         Eej4HrsocH0qiaoOKTB5X+GETAtPllnatLX2pjAwYfW6iQ3lb+pdArZ2BKELxSVTcjM0
         PEl/QD1NfbzPOGGKTvJe6LqhZTOqH5scyN5tsSPyUptXsaq+hBLpKQT7R2mrv5hVxaw7
         hmKqlUdqP/lSVEjAG8u5X+UiH8kWGmAng/bSQr06b2j+ZzasuGNDnzYzQy40HsclrM5l
         MIXp6/+Q8/VaGQpn+T9WfWfZ3NTabsIDi8ssFX9Iy6I7KmOLSDsh5OZCyP4L6iA0BF66
         gVYQ==
X-Gm-Message-State: AOJu0YzzRdc0v0tmtrZGqfRAn/Kbx7yZUmPdLbP2PK2ZVKvk26HVAiAu
	+RY0HM2mQ2+RyQ5EaVf8e67SEQ==
X-Google-Smtp-Source: AGHT+IEQMbojMIl5Eb6Ys8OumPpySxRHjsqqVFjwBUgqiQyg7E8/YneVz3sGmMTEP08fKSpCeTk5Tg==
X-Received: by 2002:a2e:9c06:0:b0:2bc:db99:1775 with SMTP id s6-20020a2e9c06000000b002bcdb991775mr11999252lji.26.1696354488559;
        Tue, 03 Oct 2023 10:34:48 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p7-20020a2e93c7000000b002bce3123639sm320732ljh.98.2023.10.03.10.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 10:34:48 -0700 (PDT)
Message-ID: <08ff4faa-2936-44bb-b1c6-d9fc77f8e170@linaro.org>
Date: Tue, 3 Oct 2023 20:34:47 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Do not use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA is
 not enabled
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <jroedel@suse.de>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Steven Price <steven.price@arm.com>
References: <0-v1-20700abdf239+19c-iommu_no_dma_iommu_jgg@nvidia.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <0-v1-20700abdf239+19c-iommu_no_dma_iommu_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/10/2023 19:52, Jason Gunthorpe wrote:
> msm_iommu platforms do not select either CONFIG_IOMMU_DMA or
> CONFIG_ARM_DMA_USE_IOMMU so they create a IOMMU_DOMAIN_DMA domain by
> default and never populate it. This acts like a BLOCKED domain and breaks
> the GPU driver on the platform.
> 
> Detect this and force use of IDENTITY instead.
> 
> Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Link: https://lore.kernel.org/linux-iommu/CAA8EJprz7VVmBG68U9zLuqPd0UdSRHYoLDJSP6tCj6H6qanuTQ@mail.gmail.com/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> Dmitry, I changed the patch from what I got you to test, probably best if you
> can confirm this is OK too. This should fix any other drivers beyond msm that are
> doing the same thing. Thanks

It still works for me, so:

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thanks a lot for your help!


-- 
With best wishes
Dmitry

