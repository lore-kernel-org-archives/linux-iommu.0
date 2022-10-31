Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDE8F52
	for <iommu@lists.linux.dev>; Mon, 31 Oct 2022 21:45:11 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-13be3ef361dso14896071fac.12
        for <iommu@lists.linux.dev>; Mon, 31 Oct 2022 14:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foZleSHJS3Wtg9Ww5hakvytOudBWym5CaB+K5swVYfg=;
        b=Z9N77o/IIAnK5zqH+wPQInvLJT4tcDUpccZ1goejKlcBN55fFRhwGGyUV+PGdD8Gmp
         FA2FtRPNQts+4maIb+aCjXMku9D998kl1hXred0CXkemNXcGkztJIeSmO78xYdx8lCC9
         GZdnQTPJxiqjUVUjRB0bBeP/oBoH08gQFoLcaVjVQMXHpg3msOaYJBvmOUy81vKnx3EC
         IY8UEHdDcvK48i+L0evwpl3zHPdnbVr1y7nUU6UJo+rywWGUwmNc2OQ2/hGUPiolobhp
         8ewdJMdxmZcRDc5fBC7rqr6/ZV10s3Dj+HLDSCaW1QUYOGw4I+JqY79qanZHq9bwXm3Q
         NkvQ==
X-Gm-Message-State: ACrzQf1QH/n5bkAn+jd181b7wuSW3Qnk7QqWtX5CINCcvIN4w5DuLhL0
	xfUjF4M7Xt/8W/U8Ay7mPA==
X-Google-Smtp-Source: AMsMyM6Hh9hh+av/WnARd8ReaocOnqw6068tCkQzgp0z38FOhn0eps2gxYxBYnLes9Jw223nXRz9Sg==
X-Received: by 2002:a05:6870:e3d1:b0:13c:9dbb:7e95 with SMTP id y17-20020a056870e3d100b0013c9dbb7e95mr9024880oad.43.1667252710890;
        Mon, 31 Oct 2022 14:45:10 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r7-20020a4acb07000000b00494ed04f500sm2805034ooq.27.2022.10.31.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:45:10 -0700 (PDT)
Received: (nullmailer pid 3622710 invoked by uid 1000);
	Mon, 31 Oct 2022 21:45:12 -0000
Date: Mon, 31 Oct 2022 16:45:12 -0500
From: Rob Herring <robh@kernel.org>
To: Iskren Chernev <iskren.chernev@gmail.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, Adam Skladowski <a39.skl@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 4/8] dt-bindings: arm-smmu: Add compatible for
 Qualcomm SM6115
Message-ID: <166725271158.3622671.481660062453926156.robh@kernel.org>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-5-iskren.chernev@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030094258.486428-5-iskren.chernev@gmail.com>


On Sun, 30 Oct 2022 11:42:54 +0200, Iskren Chernev wrote:
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Add compatible for the Qualcomm SM6115 platform to the ARM SMMU
> DeviceTree binding.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
