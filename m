Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BD46AD
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 07:11:28 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so2089037a12.3
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694761887; x=1695366687; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=duNzL30y57/ySAf7C7Vscwm8B7UTpG6sGWYT0D1JL74=;
        b=Yx0TMSzGjT8+O6/msgctY6L9c/KnMzxo4q7BDn4Rjo5/pyGALWICSj6gT3E8Vt0vPw
         7Xcissi/WFg9jHIztW6gSW5FMmLlfryXWGz4kzBoOO4D7uHXspq8xSnLNSv4dFgfpoCq
         5NYqv2+GBNZDCPR04sltmZAoJa0onGo322VmDb0HYmXT4FKgctDzmpQKDZvnNwk7UmmH
         QttoAkTrn2azwM24hL3rvosi3O0SVPD+slHs4XPRA90eZdavDK4ySZDd6xPdUzTgqv2y
         2mKTw2246m/Nex+xlCc8/Vx5eA+TKTJ/x9IMEJR7S9zY5nc7F8ubfBSuEQEzEyq6+GRD
         Z9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694761887; x=1695366687;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duNzL30y57/ySAf7C7Vscwm8B7UTpG6sGWYT0D1JL74=;
        b=tTATn7AsFW13Phx9Eu9qKJskCNPVYu4Vh45Mgp5Ed2pmOysvrdeHYlVimKoqyNyDSj
         G/CoHSjf1+MN7pkFHJB/Z6FsciQ/djYwOFlUMobVflcZsYMszvHVCFdMaSqwPs9A9xe2
         coOZ/ah7TFXeQ2aftBZiwAQjNN0SXzY+dg2vj/eqem+o3Taakqmhs2nY0+wInZnO5jqV
         lnkNaH2BTj3h8UiacAM8oqBVpXdiIisetiR9rYuC+zRUUYwd2gbKe763ztGIatiGKpg5
         IKKHnh5YL4wbEU+5TvS3xvkpILDtPMmZrAQMkgnNm+eEVPFQ/uM1wm3kCbcZ9o3M5Lx5
         Oazg==
X-Gm-Message-State: AOJu0YzXeWl6mubWkSrS8NGTQCjbfe5MiDChAOvC9QA9M62EKaKkrO0Q
	dyxfzAUM5jULmslOygfYecrxug==
X-Google-Smtp-Source: AGHT+IG80X1Vd9VVje2GNT+zD8duHxXIpA9OlMLUywM3CGAi4AX7C8Ef0fS8yntKTDXyicbSekDESw==
X-Received: by 2002:aa7:d3cb:0:b0:52b:d187:61c2 with SMTP id o11-20020aa7d3cb000000b0052bd18761c2mr680552edr.29.1694761886864;
        Fri, 15 Sep 2023 00:11:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id y2-20020aa7c242000000b0052a404e5929sm1836816edo.66.2023.09.15.00.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:11:26 -0700 (PDT)
Message-ID: <5a386be4-facc-8aef-aad7-da6508aa0505@linaro.org>
Date: Fri, 15 Sep 2023 09:11:23 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 4/8] dt-bindings: arm-smmu: Add compatible for SM4450
 SoC
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, catalin.marinas@arm.com
Cc: geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
 nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_tsoni@quicinc.com,
 quic_shashim@quicinc.com, quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
 quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-3-quic_tengfan@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915021509.25773-3-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/09/2023 04:15, Tengfei Fan wrote:
> Add the SoC specific compatible for SM4450 implementing arm,mmu-500.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index cf29ab10501c..b57751c8ad90 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -47,6 +47,7 @@ properties:
>                - qcom,sdx55-smmu-500
>                - qcom,sdx65-smmu-500
>                - qcom,sdx75-smmu-500
> +              - qcom,sm4450-smmu-500
>                - qcom,sm6115-smmu-500
>                - qcom,sm6125-smmu-500
>                - qcom,sm6350-smmu-500
> @@ -70,6 +71,7 @@ properties:
>                - qcom,sc8180x-smmu-500
>                - qcom,sc8280xp-smmu-500
>                - qcom,sdm845-smmu-500
> +              - qcom,sm4450-smmu-500

Isn't there comment just few lines above your edit? Comment saying DON'T?


Best regards,
Krzysztof

