Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284F1865
	for <iommu@lists.linux.dev>; Sun, 17 Sep 2023 07:35:26 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9a6190af24aso460778566b.0
        for <iommu@lists.linux.dev>; Sun, 17 Sep 2023 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694936124; x=1695540924; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVg4iMqyFo6GXp2VZ+N/pcY2Y8g5Wn2f/zmdGd2t3MI=;
        b=VkO2Ri9M0h5OIAHl7esiuBdevBsucXkixoRvFy7Cp+WT8/+nhQtuUnf0ZwZ9Ss82AN
         LLClHtPT2b4jfpucYJ54+J0mKOd2Rbas7pylRaOMFjzDa2jtIVjVl7bxgSbJaPDfDQjI
         W6ZpqUuO3VfwAvgSfqH2gQcUJlhd6XkSQ6F6OVs5WQ8QMXyQ+tBu3V85NExmh0Qh5M6Z
         ZthtIJAewhIJrOK3/iPHP0zBabVOZDqXPtIe/aE688WUtm0OVfUQ/eFTxKY2D+7M8qry
         toIBBPy5bDJ1Gdt6UufyW4R2g7FxEGNss4GyFC5FEWQ9GEqchr4FwZL1aXAlBQYizCgY
         ejWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694936124; x=1695540924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVg4iMqyFo6GXp2VZ+N/pcY2Y8g5Wn2f/zmdGd2t3MI=;
        b=dvdeGInqyaQy8uhAZ6SaZjbNpO+FXPqAeAHWQkr+u5EX+6QZkwgAOf0YdFEQQDoCbg
         0U787nwfURJd4bt9vzwIkNulUN2SXXUQ6shWV9A6KQ+Irx+szl0cju6D9YYD6YUeCYuZ
         GuN6pYCRyQYDuz1BBL9/6qj6/MxlTeCyImNvdWAApL5h7UnBHc8Na+xrlNRhKGHCA8WN
         IQdBq2GOZbT0coIDZ39Ou8JgKtvha2xt/4Zzbmgr66OtPnc3D6YFeGnjUTS/gYteWx8z
         iRKJHJ3esF6dfHCMOVOhOrZvLp5ur24OlVqar+ciQzJUEryPY7G2WaNHbzq119tzSkRq
         gO8Q==
X-Gm-Message-State: AOJu0Yx0BpLApJdD3/4xvztYB2SzR++5qNya/7YNdUs18HgNj5fijgtX
	+73mNn9L3DnqN08Hg015ZZKF3A==
X-Google-Smtp-Source: AGHT+IHV9X9GTjPS8Rpcs9R2kxN8xI/rL5gF7b1VuZpWiQozu9bvvyJUcivpO+mDfPfyOicv9EQkxw==
X-Received: by 2002:a17:907:775a:b0:9a2:16e2:353 with SMTP id kx26-20020a170907775a00b009a216e20353mr5651059ejc.6.1694936124406;
        Sun, 17 Sep 2023 00:35:24 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b0099bd1a78ef5sm4640735ejb.74.2023.09.17.00.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 00:35:23 -0700 (PDT)
Message-ID: <54fcf0c2-c8e2-6ee8-5f6c-4de914c56c19@linaro.org>
Date: Sun, 17 Sep 2023 09:35:17 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 8/8] arm64: defconfig: enable interconnect and pinctrl
 for SM4450
To: Georgi Djakov <djakov@kernel.org>, Trilok Soni <quic_tsoni@quicinc.com>,
 Tengfei Fan <quic_tengfan@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, catalin.marinas@arm.com
Cc: geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
 nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_shashim@quicinc.com,
 quic_kaushalk@quicinc.com, quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
 quic_aiquny@quicinc.com, kernel@quicinc.com
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-10-quic_tengfan@quicinc.com>
 <8f2c9664-a2c8-50dc-8a1c-e50a071ebeb2@linaro.org>
 <e9ff05b3-2742-416e-b417-5e2414036008@quicinc.com>
 <0a34dd35-7aea-4655-4cdd-e7196a1ba52b@linaro.org>
 <f76e1cc8-fc48-4208-bbe4-9204d9d28363@quicinc.com>
 <b7398390-23bc-467c-5b83-411110d60f43@linaro.org>
 <01c020ae-a019-e4eb-14cb-64503bde05a6@quicinc.com>
 <212f9bfa-6d4c-bba2-60d2-272c001a4322@quicinc.com>
 <e30870d5-a0cc-4210-a2b0-c7621ea5ecfa@kernel.org>
 <accb4814-4826-ff97-3527-4e3fbadcd4ff@linaro.org>
 <c11fd3c2-770a-4d40-8cf3-d8bc81f7c480@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c11fd3c2-770a-4d40-8cf3-d8bc81f7c480@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2023 00:55, Georgi Djakov wrote:
> Hi Krzysztof,
> 
> On 16.09.23 23:32, Krzysztof Kozlowski wrote:
>> On 16/09/2023 17:13, Georgi Djakov wrote:
>>>
>>>>
>>>> Complete list here, and it is inconsistent. Latest 8550 is also =y. Do we document
>>>> the reasons somewhere on why they are added as =y?
>>>>
>>>> CONFIG_INTERCONNECT_QCOM=y
>>>> CONFIG_INTERCONNECT_QCOM_MSM8916=m
>>>> CONFIG_INTERCONNECT_QCOM_MSM8996=m
>>>> CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>>>> CONFIG_INTERCONNECT_QCOM_QCM2290=m
>>>> CONFIG_INTERCONNECT_QCOM_QCS404=m
>>>> CONFIG_INTERCONNECT_QCOM_SA8775P=y
>>>> CONFIG_INTERCONNECT_QCOM_SC7180=y
>>>> CONFIG_INTERCONNECT_QCOM_SC7280=y
>>>> CONFIG_INTERCONNECT_QCOM_SC8180X=y
>>>> CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>>>> CONFIG_INTERCONNECT_QCOM_SDM845=y
>>>> CONFIG_INTERCONNECT_QCOM_SM8150=m
>>>> CONFIG_INTERCONNECT_QCOM_SM8250=m
>>>> CONFIG_INTERCONNECT_QCOM_SM8350=m
>>>> CONFIG_INTERCONNECT_QCOM_SM8450=y
>>>> CONFIG_INTERCONNECT_QCOM_SM8550=y
>>>
>>> If the device can boot (to console/initramfs) with =m, we go with that.
>>> But if something critical like the UART depends on the interconnect
>>> provider, then we make it built-in.
>>>
>>> On SM8550 for example, we have enabled bandwidth scaling support for QUP
>>> and that's why it needs to be =y.
>>>
>>> It looks like on SM4450 this should be =y too.
>>
>> I asked why SM4450 has to be =y and there was no answer. The argument
>> that SM8450 is a module, is not applicable.
> 
>  From the hardware description i see in patch 7, the serial engine depends
> on some interconnect provider. But as the serial console driver is only
> available as built-in, the interconnect provider also needs be built-in
> for the UART device to probe and register the console.
> 
> So the answer to your question should be that this is needed by the UART
> device (at least).
> 
> Such details of course deserve to be mentioned in the commit message of
> this patch.

If you mean here the debug UART with console, then it is the same valid
reason as in my change for others. This should be mentioned in commit msg.

Best regards,
Krzysztof

