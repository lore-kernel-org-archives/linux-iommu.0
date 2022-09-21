Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823211C27
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 07:31:09 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id z25so7797097lfr.2
        for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Y5vXOK0VmzHVXi9yS4v7tjY/hx6rNTPtAupQE8SpBw0=;
        b=y/jcA++D/06UjV+5R2t4zQ4KPE9IH7YAmYxqFbAPoAd+MAhdrGgEYWXKznIcyAlzNi
         F1RUbqGTUlPTy4mSeGRwr/T39XNIkBXVIs8PzkF9Mhc6XqqsXVcuhBqjs3HpL9OQyYfQ
         RmxKNidzGOBnujf33nNRVVgM5XYZ71qu6AUxSsrndRvnXgeJ/KSFPIB+sTxnahx66FDP
         4tlfaW3u8BkMYkoW1e2yI2Dg6OHWRhhuYqWPKlwNy6NX7Flkl8IBG9drokT4oHD/aumH
         puf8HxHbutEeaJ8M5HbExspBV4uD+5l4ymude5oTaoYXh+qHqR+FiGhxsCw1hyQUhByg
         1SIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Y5vXOK0VmzHVXi9yS4v7tjY/hx6rNTPtAupQE8SpBw0=;
        b=eiJ1voPFt+XipM2t8llJBgM15a+Z4Km61P1WBHqQ790O5usLlGzfBRPUZZOB0405vC
         u3vPrmgrBjJbJAbLspEZ4PUFBfbUU5FPrnJhYIX7tFiGCG4yU/GFE8v3uRSS/3VAW9aT
         PpbHZSRyUbyM2MOI8UEtL1SUeb7Qxa9M/fvu9GCvFohIaeulYrpOtn8SIodE46ZfbW7J
         QUrOBJJpNWeOeXNsbXk5Unyv3ZiB1J3EJ+M1fl97tKw+uUVvHczTmpTgYWTMoop9WhlC
         /Fht2fpSivli6VMHp2S8+96LLe08asSfYByNnwHnG05YOXF75/7rdpghy/8znnnbSkI1
         JndQ==
X-Gm-Message-State: ACrzQf2vq5mDUCOSGLyjM24ydarc8YjNms8CF5hj/vxw1jRC3p2FifA+
	dfKvRF7kTJIqbg3DQxK9oTequQ==
X-Google-Smtp-Source: AMsMyM7RpErQl780CD4dVB+vh4re/DIllGACRaxt7BzIfp6fNvauT36ldNcu0qXeEYZ8JJqF5lZeSg==
X-Received: by 2002:a05:6512:a8c:b0:49e:359f:5563 with SMTP id m12-20020a0565120a8c00b0049e359f5563mr9264642lfu.563.1663745467580;
        Wed, 21 Sep 2022 00:31:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v7-20020a056512348700b00497a23cf2absm309960lfr.258.2022.09.21.00.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:31:07 -0700 (PDT)
Message-ID: <88013406-6e07-2d3a-400e-5ec4ea83ee06@linaro.org>
Date: Wed, 21 Sep 2022 09:31:05 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] dt-bindings: iommu: arm-smmu: add sdm670 compatible
Content-Language: en-US
To: Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@chromium.org>, Sibi Sankar <sibis@codeaurora.org>,
 Loic Poulain <loic.poulain@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20220920223955.151507-1-mailingradian@gmail.com>
 <20220920223955.151507-2-mailingradian@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920223955.151507-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/09/2022 00:39, Richard Acayan wrote:
> The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string in
> the documentation to represent its support.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
