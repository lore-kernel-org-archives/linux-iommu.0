Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652127708
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 20:56:28 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id k2so7062873qkk.7
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXaTqQMSB6hK8loYpSwRgRTmm6tfLwGGmxbJhSSNS3s=;
        b=ytNqlRVySr85I+Qa8Irt/BNZJn01KmpooRo/NhrlHmSE/MhvYBO4rP7rpephRc1Jb+
         p6qO8uE6T36mpmpqeObh+iJHjiDk6ikhpnaWr1epir/jK2f07wCMdE9T5LtNbbFNzN0U
         FUQ3iU9PnugYigl7cT5FlpmjYHCTJv93vgQBTPdC5niTdo94POoWp7GEypDSNe3xBK1O
         AY0X5c8BqOirGBefRxcprArFwcsmw7yZ66Qg/no/KaEC1ptM5xcT8GgPEXAXU7ljsO0B
         5d59eSdaeh5b0ymolqTW2jxgUJlasM9W1ocwzBZXprq7AakMd9eRkKwGM5Zxpatud0rj
         EWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXaTqQMSB6hK8loYpSwRgRTmm6tfLwGGmxbJhSSNS3s=;
        b=gs+L+Xs2rXxKWjtR4fWqBPxEcAqjIQq45/KdzzMaZzj08ne8NgsMXRvWFQDT5q8UM7
         DwjY0vPxjCX0o1QCWG44TZXaXvUANhd1ng5DAiNKPk5EtoUFMj1+0ikUS0SGIAJl9meF
         7ePmlpOLX37P9ZS7OcxY4n0taITf2UN9/PilwlAhlSzSDmq8D5GH4ao/jbvSQEXb+dHp
         DnnQakVvDsRxnCbGNi+QXNfUYDriAX/IK3n8dGtsTn1SgAJGwB+bW7zXe0PYAzxH/oYr
         BHLtF6vmFKst+sDox0PY8KIA+JGX3xO9ldqLFD3yKhcGeNi/5ReSMH4w5PrRSPdBGZDZ
         zUNQ==
X-Gm-Message-State: ACrzQf1U3Ds3JC+iGD8w7CRtcYPc51t/2z6kBo9NzSm2yMzCcOK8knog
	EhguqPx47ZrFI4Em0ECU+jlutw==
X-Google-Smtp-Source: AMsMyM4EeLR1tI8FzAkA5+DmybB7IVuiMLaqywlHHsJRS6oTbfaHD6FMDYMNB50p8rJ7c2S3wbHwVA==
X-Received: by 2002:a05:620a:d55:b0:6f9:fadd:4762 with SMTP id o21-20020a05620a0d5500b006f9fadd4762mr19429978qkl.335.1667422587543;
        Wed, 02 Nov 2022 13:56:27 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id l2-20020a37f902000000b006cea2984c9bsm9138468qkj.100.2022.11.02.13.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:56:27 -0700 (PDT)
Message-ID: <1a3a1080-9bae-3912-d815-47b221a99e82@linaro.org>
Date: Wed, 2 Nov 2022 16:56:25 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH v2 03/11] dt-bindings: arm-smmu: fix
 clocks/clock-names schema
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
 <20221102184420.534094-4-dmitry.baryshkov@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102184420.534094-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/2022 14:44, Dmitry Baryshkov wrote:
> Rework clocks/clock-names properties schema to property describe
> possible usage cases.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

