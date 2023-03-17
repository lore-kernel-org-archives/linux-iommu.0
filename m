Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C1F810
	for <iommu@lists.linux.dev>; Fri, 17 Mar 2023 08:32:45 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id eh3so17297011edb.11
        for <iommu@lists.linux.dev>; Fri, 17 Mar 2023 01:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679041964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4gMB7SZxNWv+MDYaayvd9ycdrz/eczmjD/cN2vt4Ac=;
        b=SsZG2iK2wjRdcnUwAMmT5zPS6jyIUtZbrTrAAVflo135hSbXsOvpWlR8KLwMzSmTW3
         xdwxHgYbSU8lwIcKvoHo10STBzWmiEzTdWe8LPTVEZhycJeLEhTz/dJe0DhFAjCuWnIu
         khP4ueaX6E7uY7xOmB+WxCNyCfkujfRVAV30lfZO4DlCcRo5PGib+/nIU8eB712xgmeG
         7Lbnm8qV5u46uchvUgA9q019euMT5CwjIdZdPh2gavS7kBElhQAcQv4ThKWimifl2YOB
         XnSikjFomgxB5nLs6rzB/ButK7zWL6RcHwylhqvm+n/1AWa2aIAmMhvvWFK4ZNScfOFg
         ytpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679041964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4gMB7SZxNWv+MDYaayvd9ycdrz/eczmjD/cN2vt4Ac=;
        b=jdStZy6V6Oepyln5kcz1vhJasKBN7g8niIolC26BFWA2Wc+5NLzfJlG2pTtoOQKlV7
         rupJNEB6IQHP+mjamP6uRMKFCDUfbngbueXwrlq4eiwTFiCRLDOEUm9gBgZVeVecJvM5
         pA3KhTP69dQYjhW9Tqz6vySvDIQNQrWmLIGPWG+jDeklE1VFWwZ7hAzl06flM4bV4xwi
         bwKvv4p1zjsvMUGmKHMDQJp991YF+vRJuSOxs/tIuQA0wor8Exblc077bVRGk2u0VC9t
         GaTTXdfeWLvvc4FsNaGQb3Yh+qCPS6aXiZ8StDOyfiBQrE/VIjeRNZ0ZasOxIo5t5ITg
         46KA==
X-Gm-Message-State: AO0yUKUIQoMD1UCYjAO9I2NhdypMS7xyY5mOro1n2z5wMN2H4sDFyRUs
	TWiiloMdZES7DZqQrS7lDPGg7w==
X-Google-Smtp-Source: AK7set9zDb+LdLCcDtcK8Y4Z2Ema368dGsLYXeN2m7ir7jVLdOXjO1ztr1HTB4kC/41/bOxhmnJdhQ==
X-Received: by 2002:a17:906:fc5:b0:8aa:c090:a9ef with SMTP id c5-20020a1709060fc500b008aac090a9efmr13536902ejk.55.1679041963869;
        Fri, 17 Mar 2023 01:32:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id lc13-20020a170906f90d00b00927341bf69dsm692631ejb.88.2023.03.17.01.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:32:42 -0700 (PDT)
Message-ID: <2f2d253d-a247-afc8-519d-9e41512c17f9@linaro.org>
Date: Fri, 17 Mar 2023 09:32:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Document SM61[12]5 GPU SMMU
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
 <20230315-topic-kamorta_adrsmmu-v1-1-d1c0dea90bd9@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315-topic-kamorta_adrsmmu-v1-1-d1c0dea90bd9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2023 11:52, Konrad Dybcio wrote:
> Both of these SoCs have a Qualcomm MMU500 implementation of SMMU
> in front of their GPUs that expect 3 clocks. Both of them also have
> an APPS SMMU that expects no clocks. Remove qcom,sm61[12]5-smmu-500
> from the "no clocks" list (intentionally 'breaking' the schema checks
> of APPS SMMU, as now it *can* accept clocks - with the current
> structure of this file it would have taken a wastefully-long time to
> sort this out properly..) and add necessary yaml to describe the
> clocks required by the GPU SMMUs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

