Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF9ECA
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 08:10:15 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id fi11so23817002edb.10
        for <iommu@lists.linux.dev>; Thu, 06 Apr 2023 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680768613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5spE+TO8kzFj6ll3TOgzdsKC4/Ei7C5JM7vz+W4Xh/s=;
        b=hz0lyPmKOXvbz5t+WsVLjNqis1JK48pnGFKDIvbRm+UGRLharEnMhG/+MEl0ITLkN+
         nMg747sXm51hIc1MCJsmw/UutqbqFrh22uBJCZscPd+Zg+ImdtoMcBJd6S0/i5o+KDBr
         EnMfMv7QCOJHMzDviYU2LL67OgwaORKkBT8zYQEkNpArSm4CUm8QY5eOY22guFnPp0a0
         x1/+MCdEzgY3k8OdhlArb3u4oTE95bsrU3S7tMhD0/KnMJILGy0KGiV6M5nASE30T8UW
         /e5rkEzf6g4GLQdo+uu7YQaASTAd5GbyufAV2Yhc3qJg5ZuHswzW91OhzfvuNzEbdHGr
         e9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680768613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5spE+TO8kzFj6ll3TOgzdsKC4/Ei7C5JM7vz+W4Xh/s=;
        b=g0yOT1dL0usw4jEQvUgyNjHMHkjGk0ERgSFB0jxkZlvVUte4vq6NMxwfKRp43tbLuo
         jskU8nxJFKWb1XcJbxV3bWGVhghTDVi5hVGnLi62o2LLx7CdAz1UuVl5g7tDhOXj5k82
         wsjAjykuiNdW/AYreQkP068MK4lp3CTOtenW3jtvt7brqV4/R5Lcjx/6b2cWNo1Ki21Z
         jkNPLJL8ahfLfE/gqIjX2qwxV904fVzbNG4q0fiGvxVkAE0xrah3ube47Wky8AX3m8EF
         4mVsiNWBc745DKYcaLNm64Rd6DTWyDiDX7vFCiwGLWmD+TFDfsS2s9o2Fwzzyiiv0enC
         kUUQ==
X-Gm-Message-State: AAQBX9fOSYMAxwYwoszIazg7X3DJpP+u4oXRfkWTx2eou5K6M7Vjrs5L
	pIwcUnNyeHTveYTjEsgfrW/UfQ==
X-Google-Smtp-Source: AKy350YLZNQIcWIGT3+gVG7/gzwOQQVvDPf7V80JTtlDOvzqFIJ3bIHUh5JpErkXaGQQsPhjJlU50A==
X-Received: by 2002:a17:906:5e53:b0:946:bd15:b13f with SMTP id b19-20020a1709065e5300b00946bd15b13fmr4972980eju.44.1680768613340;
        Thu, 06 Apr 2023 01:10:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id 24-20020a170906319800b008e9c79ff14csm476308ejy.96.2023.04.06.01.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 01:10:12 -0700 (PDT)
Message-ID: <cc92f734-0c8d-2870-6cda-d768579c29b8@linaro.org>
Date: Thu, 6 Apr 2023 10:10:11 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: iommu: Convert QCOM IOMMU to YAML
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406-topic-qciommu-v1-1-03f17717a447@linaro.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406-topic-qciommu-v1-1-03f17717a447@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/04/2023 03:31, Konrad Dybcio wrote:
> Convert the Qualcomm IOMMU bindings to YAML.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

