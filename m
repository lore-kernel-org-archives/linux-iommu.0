Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12F017982
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 12:08:58 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-986d8332f50so904932266b.0
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694606937; x=1695211737; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dsc3mJorN3B/h1Vd1XyRMUNMxmDX6BmM8Ul2Dt3JUqg=;
        b=OCratJPIhA8IrtejCIL6cnMiOM7p0eguxFea6m1Fsc8T1MSETIPj7whmU9zJ2ifBGM
         Rpwhvr5weI3L3HYs60y/LOWXYPKr8xhelaAwFoKieLa9uhQYaqCZO4cRbNWt1OFRdW/w
         RvAwcD43PGWySm3/mYQbgYGFfWOf4WlGkzYDwyv/85+otn+l8McAVqILMlRdnqnzGmyU
         p8H4+ojXwfMGNrBMmCbA+TZyGtZxvjkdg381X2m2F5dejxvaS9HySuHLj26UV+auI6Tc
         icPikSvjAMTQoMKFzg72tXwaw+udXEXBXDEwmr5ov5Ns6WWhs1ABbPYODFwK8BZwlVuL
         l1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694606937; x=1695211737;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dsc3mJorN3B/h1Vd1XyRMUNMxmDX6BmM8Ul2Dt3JUqg=;
        b=AW7tZDXYb20XnYdwkgb0LSHAG0+Hg50XDNmCxNwWPtlP6d7VwLLhE7in55GBaGGCWb
         GR6VcFgulU1OyEtztNn2pScJFkGVOR2LFNgo4sxUuekiDWxdnWT4TVEwCiG4lElwyKpX
         R1GJ6qW6wypZBUWPPITUa9p69z4Kzvz+IqagqvZ6HmbpByIFRJ7dLw61N4XlJy21eNyJ
         S536ixLQERmeypVdN7nrpfKWp3ucCtMELC1U5XAABS9KW8zRTb67N0p6cGrRAJh71b/Y
         LbdnRsOvkITAYfuS7nnuIN8KEHEM1qppDj1nvYiXM1lqVHOeF32W0xIf76J5YANu7H6c
         Kvkw==
X-Gm-Message-State: AOJu0Yzz/91I+vMYcXxBWwj7SuI5o8iE6UAQ4QnGBBbYRmXQhSzgFQph
	NNgWwn41BRON0C1QX7gExrhmZJ8cylIoQyMskI2xyg==
X-Google-Smtp-Source: AGHT+IFeIWTz7zH3NNiZGG8GawoWgTPZnX8SM7DBQPmw79zI1P9+hmA7uTN3L/vILKVy/rLiMXcj8Q==
X-Received: by 2002:a17:906:cc16:b0:9a2:23cd:f052 with SMTP id ml22-20020a170906cc1600b009a223cdf052mr1668521ejb.7.1694606936783;
        Wed, 13 Sep 2023 05:08:56 -0700 (PDT)
Received: from [192.168.37.232] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906229500b00992b8d56f3asm8319579eja.105.2023.09.13.05.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 05:08:56 -0700 (PDT)
Message-ID: <c3dd5f68-af75-4880-83c2-ca7723561ae9@linaro.org>
Date: Wed, 13 Sep 2023 14:08:53 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] arm64: dts: qcom: sdm630: Drop RPM bus clocks
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-usb@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-6-1e506593b1bd@linaro.org>
 <70b2a9d7-1a3e-25da-3d78-7bfa5d3a1e05@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <70b2a9d7-1a3e-25da-3d78-7bfa5d3a1e05@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.09.2023 09:13, Krzysztof Kozlowski wrote:
> On 12/09/2023 15:31, Konrad Dybcio wrote:
>> These clocks are now handled from within the icc framework and are
>> no longer registered from within the CCF. Remove them.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
[...]

>>  		anoc2_smmu: iommu@16c0000 {
>>  			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
>>  			reg = <0x016c0000 0x40000>;
>> -
>> -			assigned-clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
>> -			assigned-clock-rates = <1000>;
>> -			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
>> -			clock-names = "bus";
> 
> This is also against bindings. After your patch #4, such bus clock (or
> other combinations) is still required.
So, we have 4 SMMU instances on this platform:

MMSS (described, iface, mem, mem_iface)
GPU (described, iface-mm, iface-smmu, bus-smmu)

ANOC2 (this one, no clocks after removing rpmcc bus)
LPASS (no clocks)

Should I then create a new entry in the bindings, replicating
what's there for msm8998[1] and dropping the entry with just "bus"
from anyOf?

Konrad

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/iommu/arm,smmu.yaml?h=next-20230913#n272
