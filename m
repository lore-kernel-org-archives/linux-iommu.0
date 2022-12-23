Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0123A2
	for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 08:21:22 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id f34so6171590lfv.10
        for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 00:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+a3E/WsPht2OzFwjCL5xU/bureLMTsu06UItSpCOeI=;
        b=gYlcHa7/P3MqkCaku/u5VWO4JjTkTe9UtThg5QFuKr2GukWCj2kAhaiMiOvCBBBd6f
         GLaOq8uYxKuBRsK4y925kG6ZXRH1fKjLbYikSenfrZgpm9owLK3V037Px1tfarNcoGkr
         HORH/xHQGZe4Lpyjq0q5YBthSvhm4p9Wz4OAK3wdmSqWJ8/xpW6UIHeF/M7AFt8gTyf6
         oRpuXKBSmcGvzK7Bbts5PfVWG5b1WRXCWu3QhvSmxA4K3mbkbtTq3O2tqmaTVgmK5v7T
         mWJITwgEKNx/rBpJzAGHr/v+Of+QoWGwjcJWbAUw+SWcsJvfUZzubfIxdeib+j/sRCFV
         6dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+a3E/WsPht2OzFwjCL5xU/bureLMTsu06UItSpCOeI=;
        b=QSjBYJx2GA0V2dCF1p9gIzF0xDyXIFOTsB8vxwq88Q+aVQH1Gw30Ubiy3RPKmjgwZn
         9q0Y4uA0Dul658z+ErtoaCCi6np97W/GZE/tNbQc8YurB3gjOlOX6wSwVMhaQg/TpBbi
         ppw8oRlwPjqma9oEFs4kF9Eh/FzlqLqsIyXqFqZ0/AfopVZt5kIAPpi5oUodC5Bmyq1g
         DEUy2yDuycPW+eHRkgo01V2Hj2WDlLsx21kP3izPppNp33iT/a+x1bOCWEoAXfv6FWNP
         Y49Csb41kfrt7PA+XtWFRoi4IjaBr41vGMIF61JmrCnXvdtKf03cIsIa/zqBEI1LMpfy
         pc8A==
X-Gm-Message-State: AFqh2koZN5dYXcxihz+bcF0wVO5Wb6iuzwkg8zgwX7KEcd3OPVbCSa81
	GMiMDmLiGDRkK07rsoLmZcpbJg==
X-Google-Smtp-Source: AMrXdXvwJCJKbgnY/TzJ7r09IRwavsCP0pYsBXAK2+HyDem66Dnw9GndXvejtz8/3+6YZjtrTmyKsQ==
X-Received: by 2002:ac2:59da:0:b0:4b6:ea42:de0d with SMTP id x26-20020ac259da000000b004b6ea42de0dmr1948549lfn.39.1671783680552;
        Fri, 23 Dec 2022 00:21:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e29-20020a19675d000000b004b5812207dbsm426219lfj.201.2022.12.23.00.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 00:21:19 -0800 (PST)
Message-ID: <089247cb-9723-6834-bc6c-cd795ada87c6@linaro.org>
Date: Fri, 23 Dec 2022 09:21:18 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/4] dt-bindings: arm-smmu: Document smmu-500 binding
 for SM6125
Content-Language: en-US
To: Marijn Suijten <marijn.suijten@somainline.org>,
 phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Andersson <andersson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, Lux Aliaga <they@mint.lgbt>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Thierry Reding <treding@nvidia.com>, Melody Olvera
 <quic_molvera@quicinc.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20221222193254.126925-1-marijn.suijten@somainline.org>
 <20221222193254.126925-2-marijn.suijten@somainline.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222193254.126925-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/12/2022 20:32, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Document smmu-500 compatibility with the SM6125 SoC.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> [Marijn: Move compatible to the new, generic, qcom,smmu-500 list]
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

