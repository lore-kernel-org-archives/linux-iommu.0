Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC75A954
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 22:38:18 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id c9so29580986lfb.1
        for <iommu@lists.linux.dev>; Mon, 03 Apr 2023 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680561497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtsOWrQW7hkNYFADGqbjwZ60d4zvSefDrCxExKDl8Ps=;
        b=hwuZ8XieWgBLN5adU41i6xX2s4eNlMpyUG883h6xHBqIp68TLP0PISWCmEmBxbOFNp
         La0z50tJWUVSnxmQGKjzd2D0TI3d8OdvzjbH9uwZNYgcJWNoG92y7hvf5wRLkIcNnJkT
         9xaak/ZDCbwD9kqTd2ISNgfEwhja79Z07uNJPnxcGhHgeZ9/vQGpDOoJeWvRtPZ/2Gxc
         TvPZiYYuhXrmLzm7gBiYz6zwetuFr+2zYf3U5JHJIDUNZM1JFosfH9/7+5HX0jn7xUye
         RlhlegeuGZo1+3qU3CEAaNzaV47X5Q9mtT55migZtfvsp6ZvbmSskgy9parZdncdzPQx
         BKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtsOWrQW7hkNYFADGqbjwZ60d4zvSefDrCxExKDl8Ps=;
        b=kG7KOS8IpaYU505XIcVVfQ3EsTZT/vc8OqgbO7FgvmZkOjtggLJ211rQRZlD5non7G
         m0IAP8B+k/BQvh0NIty1XzRivqso1FqKQ2PZ2fhbn3mABsjcVy9sFEt6YESI6uPpsgo0
         BTZUuZ5M0llRqJybYRcayORYuM4mKdMJkdTJpdLcUVcxscOyPMcncD78Bf1W7pcBNZVB
         z7cumotr7DPz4b8d6OD7dJnYl3uQ5H66DGPWfcKhzNEf8fH9EXnb5gp/5YoJ3eqGfrnt
         vNJNSlnoq3Vx0rhBBlgqap4O/0qU+hLUKZTMZHinF4L1jmvgQAKd+T2hD8U6MFoBLcMP
         f//A==
X-Gm-Message-State: AAQBX9fMRnC6h2RUT/k33Qpb/vqeQxcUYHTMiBO/F4TgtbLkuVNNpFIi
	VP8UBeSVnXTeE3jmIObU+g7tYw==
X-Google-Smtp-Source: AKy350YZO6iPPjj1sua6F66RRClLCkmeKk/nQmT2y4PKC2eroOuYFkNzuee/Tto92qVvDnzdKwZi/Q==
X-Received: by 2002:a05:6512:2192:b0:4e8:3da6:485a with SMTP id b18-20020a056512219200b004e83da6485amr56645lft.68.1680561496989;
        Mon, 03 Apr 2023 15:38:16 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id u5-20020ac248a5000000b004e9cad1cd7csm1985379lfg.229.2023.04.03.15.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 15:38:16 -0700 (PDT)
Message-ID: <b2e81e6c-a9fa-0cc1-01ed-1d82297454c4@linaro.org>
Date: Tue, 4 Apr 2023 00:38:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/7] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-5-brgl@bgdev.pl>
 <20230403204127.GA1708388-robh@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230403204127.GA1708388-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3.04.2023 22:41, Rob Herring wrote:
> On Tue, Mar 28, 2023 at 09:36:29PM +0200, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> The KGSL iommu will require the clocks property to be set. Enable it for
> 
> Isn't KGSL the name for QCom's adreno vendor driver? What does that have 
> to do with bindings?
It's called "KGSL SMMU" (as opposed to the other "APPS SMMU" (Application
Processor SubSystem) in some places in Qualcommland

Konrad
> 
>> sa8775p in the bindings.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index 807cb511fe18..74d5164ed1e8 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -375,7 +375,6 @@ allOf:
>>                - nvidia,smmu-500
>>                - qcom,qcm2290-smmu-500
>>                - qcom,qdu1000-smmu-500
>> -              - qcom,sa8775p-smmu-500
>>                - qcom,sc7180-smmu-500
>>                - qcom,sc8180x-smmu-500
>>                - qcom,sc8280xp-smmu-500
>> -- 
>> 2.37.2
>>
