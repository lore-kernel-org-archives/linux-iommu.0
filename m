Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17713AC3
	for <iommu@lists.linux.dev>; Thu,  1 Jun 2023 16:55:58 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-97454836448so55474266b.2
        for <iommu@lists.linux.dev>; Thu, 01 Jun 2023 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685638556; x=1688230556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/9PhABrR6fbuT1S1oyIuPZW5VFgQbeU/P+IYi+AHHxM=;
        b=ffZXKYwLf5T1O2JvWMZdIWhRi7SWjAPrvhw6AL6FlT1bG2FLKbU8LX68ph7e3LO04U
         dU0rRDYbrveOU6ArfGhxfOLABRs2IHbfoby2DxZgAs86Y9xgm2Bz6MkxmTFh0uZotOlr
         CpBbV70cVmqyHYXRn5dfEu06K1RrnQc0B65w8dp4o3x3hVSHqwXMddY+I6OdXIITVbLh
         wagj+12DMz6Zvies9MQnbslGC4lzfDHT+hrH1o/RcDSO3+dpYJN1XPzXdQRATYrdVfpI
         TSximRQqSXxMHjLDol5p1/cvuNwXunbRaV7yApHcxtcA54c1/WoUiTSehetLPYX13zRc
         GHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638556; x=1688230556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9PhABrR6fbuT1S1oyIuPZW5VFgQbeU/P+IYi+AHHxM=;
        b=Ofh4zRhIsrrn84vrpp6mNtSa9RssUW1ZVFcbBKtXqcpg4AB7L69YhgKHvDuB79Fnh7
         DgZ1rRs+Dj10fDVlw4hIaFH60hkHcXIBY3heh9i2mdrDjL7c9fbOs572ClIBszpOIdMN
         4eC+D/8kcY+JmneHypWQZyRcfPxQgYrFZZuVSQhdvKef0Qw4rmprwIDtBC7895TcZgC1
         7xtI7fbvs38mRUj2Ey3V6P5SxTBha+imTMiOuThB/XXqbI2T0/LYPRHf684JWicg/Idj
         QLBiZgERtjuaoqFOerUnNxP4ksduNapWWYEYA7v8ucLUO1rXvjZG6PBujFv/3blqPVSK
         AFhw==
X-Gm-Message-State: AC+VfDzer1rmLeA21yOPl5Xp7uJ76NPxjEUwXgyMWjz99koCBfE7mt98
	uhQHAKKXzZmC9Iq8E8903c3krQ==
X-Google-Smtp-Source: ACHHUZ6ygqoysrjPFxzcfm1Ac5L9I1KaJ4mwEF6HXcgsykWw+pw5MRf0NYhA4AB2O0EcNhhoiAnYUQ==
X-Received: by 2002:a17:907:86a4:b0:973:e4c2:2bcd with SMTP id qa36-20020a17090786a400b00973e4c22bcdmr8555945ejc.18.1685638556663;
        Thu, 01 Jun 2023 09:55:56 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709063a4600b00973fac6065esm6693089ejf.223.2023.06.01.09.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 09:55:56 -0700 (PDT)
Message-ID: <3589e3fc-2add-52d7-68bd-2b41a9cba4af@linaro.org>
Date: Thu, 1 Jun 2023 18:55:53 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add SM6375 GPU SMMU
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20230531-topic-sm6375_gpusmmu-v1-0-860943894c71@linaro.org>
 <20230531-topic-sm6375_gpusmmu-v1-1-860943894c71@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531-topic-sm6375_gpusmmu-v1-1-860943894c71@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/05/2023 17:04, Konrad Dybcio wrote:
> SM6375 has a "Qualcomm SMMU V2" implementation for its GPU SMMU. It
> does not however qualify for the qcom,adreno-smmu compatible, as it can
> not do split pagetables. It consumes a single clock and a single genpd.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

