Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFBF7B
	for <iommu@lists.linux.dev>; Wed,  4 Jan 2023 00:20:28 +0000 (UTC)
Received: by mail-io1-f43.google.com with SMTP id p66so17438542iof.1
        for <iommu@lists.linux.dev>; Tue, 03 Jan 2023 16:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V83unu/dgWIOer+77hb9Z8kEGKWwgriIpRWxhsjKe3Y=;
        b=VACI0vDQzOoT6DT+ah0Lwdkxh//n8czQwBmlp7+sx15zyzE99X+lQ2zTnCwB8079W8
         hIzXP+S0ReVockKixKLH8l1av+rwekIPHx54kFhebu1chNb0FX6SJNonOHuFGFOgvFHB
         +Y3+Mkj1J6zMFacGDYT8VU/+KwpHGZ8mwQOeQulmi0zf4Uwh6+PuQGjkTA8p97lbtfS5
         uRyB0vBsv5x7XXOoYg8t2QHBb1I6PmP9dQasLvENHODqY2AP7INNTQPHCUnuVdRfBD+1
         so2P3+76fliplBJGtiRBSO/SbeXdBV4vB/su54K1MBMqFoKzadHRT0YPjKVipQ1etzvv
         TOQg==
X-Gm-Message-State: AFqh2kofk+ygASOf0IBBVavs5QrpbKhhttL+5SoyuLbdl9M4YdqnjbzL
	4OZZut1KRClYQ3Ob2aN+uA==
X-Google-Smtp-Source: AMrXdXuv1hGJk8lfquTpLcS7/biZZcd23B/tCPFIIbvgei2vvOQ7G5YpoHCp2tegO6OVYgRUzIhblA==
X-Received: by 2002:a5e:9204:0:b0:6e0:27a2:1768 with SMTP id y4-20020a5e9204000000b006e027a21768mr30210378iop.18.1672791627051;
        Tue, 03 Jan 2023 16:20:27 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r5-20020a0566022b8500b006e01740c3b6sm12154582iov.2.2023.01.03.16.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 16:20:26 -0800 (PST)
Received: (nullmailer pid 131563 invoked by uid 1000);
	Wed, 04 Jan 2023 00:20:24 -0000
Date: Tue, 3 Jan 2023 18:20:24 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, iommu@lists.linux.dev, Marijn Suijten <marijn.suijten@somainline.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, devicetree@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
Message-ID: <167279162395.131504.15364556098341067594.robh@kernel.org>
References: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>


On Thu, 22 Dec 2022 10:23:55 +0100, Krzysztof Kozlowski wrote:
> Disallow clocks for variants other than:
> 1. SMMUs with platform-specific compatibles which list explicit clocks
>    and clock-names,
> 2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
>    variable clocks on different implementations.
> 
> This requires such variants with platform-specific compatible, to
> explicitly list the clocks or omit them, making the binding more
> constraint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
