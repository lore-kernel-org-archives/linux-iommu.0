Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057473205
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 14:36:20 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1878504c22aso440797fac.8
        for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 07:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681310180; x=1683902180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnuVW5Vp/+EHlp3UdQMcKQ8pXzh4inb4O6e6LBWQKfA=;
        b=L0wbw5DOXVtAU/80Z657toDLwKVMkQsUPVx+DdLwKBVFG/ct8p/dfGDiY8E57pMGPK
         8pbRF8MQoyz9PbtbclGTxV+gvwaC2k4fd59VWsTcfKsKfFmz67nmZ8gBS1EYKvvjR8Hc
         JVCaF5yys/6qvbpELaBU/zQD7FjbWkLMIoMPNflwE8blYesFzYzSqY/OGbpowLrQ0Rlw
         zJPHGk5C47onApOZwQLmUyUgjcjgboGaxkVAqeOKTQyt6ynZzu7tISO5j1+Z+asRdT1P
         udamVe03ZJQo+5vZbCfVjLUXPd/ZLrrZ5Y5puCOVSdzWCz1nXKir3NSMDGD5uYr/vGhv
         G/gg==
X-Gm-Message-State: AAQBX9eaXok6V74hd25YL1ww7iPp2VNBjofcYBRHUt5MSvO++KXpXAp7
	4XUnGYuxFdpMBUnRDjRYlg==
X-Google-Smtp-Source: AKy350Yrb4lQU2MjSsBsCSaX0JiNW9MIuuGctZGj/LJOLA9/nYNk7N26TsBKUAGKiWf9TDUJUEj+Sg==
X-Received: by 2002:a05:6870:51f:b0:17b:1214:5fd7 with SMTP id j31-20020a056870051f00b0017b12145fd7mr10030861oao.17.1681310179916;
        Wed, 12 Apr 2023 07:36:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b0018045663fc5sm6230397oac.48.2023.04.12.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:36:19 -0700 (PDT)
Received: (nullmailer pid 2328230 invoked by uid 1000);
	Wed, 12 Apr 2023 14:36:18 -0000
Date: Wed, 12 Apr 2023 09:36:18 -0500
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iommu: Convert QCOM IOMMU to YAML
Message-ID: <168131017435.2328084.7641188921075798677.robh@kernel.org>
References: <20230406-topic-qciommu-v3-1-aa0e4f018191@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406-topic-qciommu-v3-1-aa0e4f018191@linaro.org>


On Thu, 06 Apr 2023 20:47:28 +0200, Konrad Dybcio wrote:
> Convert the Qualcomm IOMMU bindings to YAML.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v2 -> v3:
> - Add additionalProperties:false & required for ctx subnodes
> - Drop the IOMMU consumer device from the DT example
> 
> v2: https://lore.kernel.org/r/20230406-topic-qciommu-v2-1-b8547622b2a4@linaro.org
> 
> v1 -> v2:
> - Include missing header
> - pad the addresses to 8 hex digits
> - add 'reg' to the mdp device
> 
> v1: https://lore.kernel.org/r/20230406-topic-qciommu-v1-1-03f17717a447@linaro.org
> ---
>  .../devicetree/bindings/iommu/qcom,iommu.txt       | 122 ---------------------
>  .../devicetree/bindings/iommu/qcom,iommu.yaml      | 113 +++++++++++++++++++
>  2 files changed, 113 insertions(+), 122 deletions(-)
> 

Applied, thanks!

