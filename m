Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5536B808
	for <iommu@lists.linux.dev>; Mon, 27 Feb 2023 08:43:19 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id z5so5577128ljc.8
        for <iommu@lists.linux.dev>; Mon, 27 Feb 2023 00:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677487397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pl3dkRXMmAk1JBFimIqhpxnC6XsfsDXMDQ44PxTCQ/s=;
        b=DtxNJ6ePjQ/i4m/NMWNDtDHj6jb+VPPrSwrShpD9ysYFk+mdEp1ayrEGACcGBLYzkV
         2jyWy+BksOm5xtg2FTLlj5vcPRD1W4cN95un71DyKs7L+FilsP2x7WPsJBDkjJWhpKdC
         F3qbguO2fGdC/e4BRKHSRed36QUraJsMFex/pvrMCTpZY2J7ZIV+Jc4d5JWdpuyVMk5p
         b+z1PXXCw0DM3G9Ispl81es5iGClOZHsO1BQizMXge71LOCI7C/tySGssjGHEMls/L5m
         Epi/B0lFr91Ei45CM/egghyOdHb2H9gFn1r7DSbJQwyz47+qDOT2fGW8+EpflibkZt3F
         5Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677487397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl3dkRXMmAk1JBFimIqhpxnC6XsfsDXMDQ44PxTCQ/s=;
        b=fK63eN0C6YlRK2U/nJOBPbkJvbEARvtvM+GvqnIuptaWQus0i1UYjDaMZRzLnDCE+F
         qshh+WyxoSwr8tKt9w0aCStgSiWpzQ9DPQJr/kmSprweI7VobvgtYbPhQOY6PPewCSxg
         WN5Yu1tgToSs5ZdymrZmiag4mXz6enJcRBRGt+Tv5Q1HsfW174P0dv83mMq7CYJBqdJS
         AciOQddr0nVUsCyREWguOj3pbh56385MSeFRf3/8ZzDUgYSnjWKAWIrpn7N9Hfg4U/pS
         v/sIeTADvLWKRzogIvuUDXNoH9CXgRBHUh5hdp57rCaac/bk2/qz7W40mBTFN32t+JrG
         G84w==
X-Gm-Message-State: AO0yUKUfrnWBv44hUuAsEuKrx7fLQQ0TrJT6AhN7TX+yp3Jx/x4CDj5R
	01kzbiVtTT5tHMdtGtLFf8C8UA==
X-Google-Smtp-Source: AK7set/Gvtsf5P7zOB+MC4cBLFFsUoGA6x+8HxOLVIaK3IY1MS+lDHx3oVzZik2heawiFH8nJ7qjMg==
X-Received: by 2002:a05:651c:2228:b0:295:9c2e:7324 with SMTP id y40-20020a05651c222800b002959c2e7324mr7173325ljq.4.1677487397220;
        Mon, 27 Feb 2023 00:43:17 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id i2-20020a05651c120200b002935305ff4asm643079lja.82.2023.02.27.00.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:43:16 -0800 (PST)
Message-ID: <3aa78b15-8e6c-9657-0d08-0d0452d51fbe@linaro.org>
Date: Mon, 27 Feb 2023 09:43:15 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/6] dt-bindings: arm-smmu: Use qcom,smmu compatible
 for MMU500 adreno SMMUs
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, andersson@kernel.org, agross@kernel.org,
 marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
 <20230226173706.GA60188-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230226173706.GA60188-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.02.2023 18:37, Rob Herring wrote:
> On Fri, Feb 17, 2023 at 12:16:08PM +0100, Konrad Dybcio wrote:
>> qcom,smmu-500 was introduced to prevent people from adding new
>> compatibles for what seems to roughly be the same hardware. Use it for
>> qcom,adreno-smmu-compatible targets as well.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> v1 -> v2:
>> - Add this patch, omitted previously (big oops)
>>
>>  .../devicetree/bindings/iommu/arm,smmu.yaml        | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> index 807cb511fe18..4d7f61700cae 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>> @@ -75,9 +75,19 @@ properties:
>>                - qcom,sm8350-smmu-500
>>                - qcom,sm8450-smmu-500
>>            - const: arm,mmu-500
>> -
>> -      - description: Qcom Adreno GPUs implementing "arm,smmu-500"
>> +      - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,smmu-500"
>> +        items:
>> +          - enum:
>> +              - qcom,sc7280-smmu-500
>> +              - qcom,sm8150-smmu-500
>> +              - qcom,sm8250-smmu-500
>> +          - const: qcom,adreno-smmu
>> +          - const: qcom,smmu-500
>> +          - const: arm,mmu-500
> 
> 4 compatibles seems excessive. Is adding one that helpful? Is 
> 'arm,mmu-500' useful on its own?
Yes.

per-soc compatible is there for per-soc quirks should there be any
qcom,adreno-smmu enabled per-process pagetables
qcom,smmu-500 matches the qcom smmu implementation
arm,mmu-500 matches the smmu driver as a whole

> 
>> +      - description: Qcom Adreno GPUs implementing "arm,smmu-500" (legacy binding)
> 
> Perhaps fix the existing typo: arm,mmu-500
Ack

Konrad
> 
>> +        deprecated: true
>>          items:
>> +          # Do not add additional SoC to this list. Instead use previous list.
>>            - enum:
>>                - qcom,sc7280-smmu-500
>>                - qcom,sm8150-smmu-500
>> -- 
>> 2.39.1
>>
