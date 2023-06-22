Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CD1E531
	for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 14:52:51 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-77e4126badcso16755439f.0
        for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 07:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687445570; x=1690037570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2zm8McjBvSHDaGmBgl+/DFbo4FGaTvp/UrUy9Rpg30=;
        b=MtZpy2NI0HGvjc9h3jBxi8i9WEvjUzIB6tGLVruRvNqiyi1jUjZF2CD0ue+nbj+tuv
         kyGjT28yQ6/eC7ibrJA8cYXDqt02fL5q1YXLt9jQ4vEKK6PfotWj1lIDBNbkHYQCXUKS
         J9W+cS4jjcdcNOiki4PZ2nvZ2j6ptGGB4tm34CGEGIlDmaLMqBc4fIehEajmMu1Zw7Zv
         a9NXuj3xGwIC70P4rqZ5UmXPHQ1YiX/4lo44a0D8YOCkOgtcoUNgdtIre0BoW9zvgd3L
         ahuggg346Vb8yF7oYrbJaIcwffTmDg+bxSlirgawzAZqoTfPA6YzmoxZt6hR9snD+gy5
         fd4w==
X-Gm-Message-State: AC+VfDzX9qthztOz1iX7KF3BQqTcKrWESH+9mcN0FuUO3ZqHJ/J6IXCT
	faIkx6jnsfRYBUTg+uJ9wg==
X-Google-Smtp-Source: ACHHUZ7BssGZaMe2LWzZc7NLHZQSRnh/rv9M54Q4CRtuhN69oQddGV8O5QHBtsyb4/QqnwdeDwMwRg==
X-Received: by 2002:a05:6e02:d03:b0:33f:c2f8:e503 with SMTP id g3-20020a056e020d0300b0033fc2f8e503mr11307806ilj.5.1687445570232;
        Thu, 22 Jun 2023 07:52:50 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id eh16-20020a056638299000b003e8a17d7b1fsm2098979jab.27.2023.06.22.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:52:49 -0700 (PDT)
Received: (nullmailer pid 1686676 invoked by uid 1000);
	Thu, 22 Jun 2023 14:52:46 -0000
Date: Thu, 22 Jun 2023 08:52:46 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: andersson@kernel.org, luca@z3ntu.xyz, krzysztof.kozlowski+dt@linaro.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, agross@kernel.org, robdclark@gmail.com, linux-arm-msm@vger.kernel.org, robh+dt@kernel.org, will@kernel.org, devicetree@vger.kernel.org, kernel@collabora.com, dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org, joro@8bytes.org, conor+dt@kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: iommu: qcom,iommu: Add qcom,ctx-asid
 property
Message-ID: <168744556630.1686619.1948595274939844483.robh@kernel.org>
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
 <20230622092742.74819-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622092742.74819-2-angelogioacchino.delregno@collabora.com>


On Thu, 22 Jun 2023 11:27:37 +0200, AngeloGioacchino Del Regno wrote:
> Add a new "qcom,ctx-asid" property to force an ASID number on IOMMU
> contexts where required.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

