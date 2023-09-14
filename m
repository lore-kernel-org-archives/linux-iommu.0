Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9121C13
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 07:41:07 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso700494a12.1
        for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 00:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694677266; x=1695282066; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BTTFLmHVcCEeGdB9PLCErU99zAFCDRERFukfsKEjoJU=;
        b=XbP5kD7b/P2lmZzDtY2IIXGylDR9PZ1OJP3wbEDtGlxibcCYMI+dUy6PZCWT3A32Ac
         Q+JuPCe0JAe72RQc0EqvRe8eEtw3JG6r7ta/L123o3+RXxmOEYswQVf8DanF9gMu7bEs
         3HpAY0CVBRZUppDNoLDuSDXLPmpwMHWm5ZtjPC5BkoJH4AKjmTXcNKqG3y2cD0VxrVJa
         yS/37ux7dgBdWX8OPHPGkLR6rLRe0xusJW0EqxSrilNkR9RxOtmgtk+JZe2/rC7lRHgJ
         7dSQYBFyfxdFjk5sFl7N9QH1AGZ/KJy6efZO/F0m4FmRMbRt977fuWrW1ZbyPDhtjlZo
         mdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694677266; x=1695282066;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTTFLmHVcCEeGdB9PLCErU99zAFCDRERFukfsKEjoJU=;
        b=q08DVQNl09eizogY/S25cVS19AhvfHDxmuX+5EO0ZZ+i6yIqtD/ueNpYXIcvJa2Dv7
         ByJPP7xTHoJJG65jh205AWllWV9vLjZDGGZ8/81DEx1MWio365aR+5yVfPyoNJG2R319
         Ny9R3uQpTYHwMqAiMqmOADZilHqdiriXssln+BuMVYyr4A3vBR3+iKtT0LM+58/IgHnn
         hdS2cKwG3pB6c2xbnEy06OJmjBGokN3zLCjG1T9skEJ7iCZHOe8VWHgD7UVi27tIVjTx
         n4EzF47rg8Ky0pU8QThE9j4wooTlA/SCqU2f2fFmFNmOqmPAyQlhsb+33zl+LPCLMmXM
         Vs/g==
X-Gm-Message-State: AOJu0Yy2DAuceq26VCK39PM1oHvjmaC3oRVdlVi5BeGStn6/qFdlhi1R
	QVAv4+a2Y4/Qek/oNV0EU1T/Ww==
X-Google-Smtp-Source: AGHT+IHlbblsKiu2gEtKrdgm90QMFr8E3CuYF/8VHvCB/T7LrlXyHxwj/f1cU1M0mOLP9SJFk3qWLQ==
X-Received: by 2002:a17:906:3051:b0:99e:6a0:5f64 with SMTP id d17-20020a170906305100b0099e06a05f64mr3654818ejd.36.1694677265829;
        Thu, 14 Sep 2023 00:41:05 -0700 (PDT)
Received: from [192.168.37.232] (178235177172.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.172])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709064e8700b00977cad140a8sm589467eju.218.2023.09.14.00.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 00:41:05 -0700 (PDT)
Message-ID: <098f0a07-a67a-4209-8dbb-ff8d5b699dfe@linaro.org>
Date: Thu, 14 Sep 2023 09:41:01 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] arm64: dts: qcom: sdm630: Drop RPM bus clocks
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
 <c3dd5f68-af75-4880-83c2-ca7723561ae9@linaro.org>
 <7796431f-ae52-58b6-499e-566a17292725@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <7796431f-ae52-58b6-499e-566a17292725@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.09.2023 08:26, Krzysztof Kozlowski wrote:
> On 13/09/2023 14:08, Konrad Dybcio wrote:
>> On 13.09.2023 09:13, Krzysztof Kozlowski wrote:
>>> On 12/09/2023 15:31, Konrad Dybcio wrote:
>>>> These clocks are now handled from within the icc framework and are
>>>> no longer registered from within the CCF. Remove them.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>> [...]
>>
>>>>  		anoc2_smmu: iommu@16c0000 {
>>>>  			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
>>>>  			reg = <0x016c0000 0x40000>;
>>>> -
>>>> -			assigned-clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
>>>> -			assigned-clock-rates = <1000>;
>>>> -			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
>>>> -			clock-names = "bus";
>>>
>>> This is also against bindings. After your patch #4, such bus clock (or
>>> other combinations) is still required.
>> So, we have 4 SMMU instances on this platform:
>>
>> MMSS (described, iface, mem, mem_iface)
>> GPU (described, iface-mm, iface-smmu, bus-smmu)
>>
>> ANOC2 (this one, no clocks after removing rpmcc bus)
>> LPASS (no clocks)
> 
> Ah, I did not notice it.
> 
>>
>> Should I then create a new entry in the bindings, replicating
>> what's there for msm8998[1] and dropping the entry with just "bus"
>> from anyOf?
> 
> So this passes the bindings, right?
Yes

anyOf: in the binding should allow
> also no match, so this should be fine. However indeed we need to drop
> the "bus" entry, because it is not valid anymore.
Actually, looks like the LPASS smmu may require a single
clock. We can reuse that single-"bus"-clock entry for
HLOS1_VOTE_LPASS_ADSP_SMMU_CLK.

The device didn't crash when trying to access LPASS SMMU
with that clock absent, but I guess it may have just
been luck, things may change once more hardware is parked..

Konrad
