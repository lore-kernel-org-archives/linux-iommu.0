Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A3946F
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 22:43:19 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4edb93139ddso937531e87.0
        for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682030598; x=1684622598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdc4rmGvOVsqp5oe4XQe+KMb4W3JpUy4TYDZwsnYsZQ=;
        b=iMmU/ProsZloeDlfszZLM1UhnrSEWbJjuwhbsBIkQ9sbpVonSjhRG+FPE88rZVcOyN
         r5kw6tiLsdoUm4DGrcoZ+oOUk7IZqJQt696BorzzlAb52lkEefX4GwwceABeIF/arWVL
         s2nECak0R/jv9VibAoSWpbroteMwMy22iQPfGTYwhVEIc4eJhKD98KqflXXh0DH9FQKD
         fRgMLcwnUgpahJMyrndXa60iY6a+BTYiAnjtW95phSgoNud9SK5n4u4XD7faHhu+Lo/C
         1iPGPuM14dkyASscMUoPk2rgUxR6YWDW4pK+Mv8Nh4nMuN6wb48vBZ98eyMsk7ePUifD
         8qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682030598; x=1684622598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdc4rmGvOVsqp5oe4XQe+KMb4W3JpUy4TYDZwsnYsZQ=;
        b=OI7Qv/+jqIKC922YiDbfTiYQ15lEr5X4+ffD06IlNNb0Wpgyf3Gvts+h91cqhzTm/A
         w2s2OCNX0fE4UE44OKu4a1p5CdKyv5j+MxQndR8Me/PIsxuAKijAhkFKI8hJt6mjUDCh
         tA4nJ+y73iw7mKH/cFl6qFLtPc08xRdPLwdb9k4fI/iUF+rogZZoE8CnC0H3iIkw/8GZ
         d4T9Y4LNZhtqpJHAYh7GGnxPDrrkPIWjd90cvvCzi74ND7+Yn8js1XyNAtN/XnH77dPI
         9IVjxbVMDltXcZ5nt4lAFGX57udMb3roepvBdui2eag6+6ybVwCuTGrmJFHGiXtQe8+e
         Ix8Q==
X-Gm-Message-State: AAQBX9dUcIlr8K3oVNq2ApDNx1onixaM9ks+V0OGgQ7H/Ed11dLMiWbv
	UW1QVZWhEKrSLNoTwqGEmWMp+g==
X-Google-Smtp-Source: AKy350ZVF4cIUxwuhl1z55nPu1K7EKpo+nQCFX/oqhNnKdROTunmg2Y4/61DtVtV2y6p7vSA1kX/iw==
X-Received: by 2002:ac2:4427:0:b0:4eb:d8d:6c14 with SMTP id w7-20020ac24427000000b004eb0d8d6c14mr727331lfl.11.1682030597782;
        Thu, 20 Apr 2023 15:43:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id l14-20020a2e868e000000b002a775f96ef4sm402576lji.30.2023.04.20.15.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:43:17 -0700 (PDT)
Message-ID: <ae811f1e-1376-f3d4-e297-6dc2f984b4ac@linaro.org>
Date: Fri, 21 Apr 2023 01:43:16 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 08/13] drm/msm: mdss: Add SM6350 support
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-8-5def73f50980@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-8-5def73f50980@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/04/2023 01:31, Konrad Dybcio wrote:
> Add support for MDSS on SM6350.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

