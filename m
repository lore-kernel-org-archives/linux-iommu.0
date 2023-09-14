Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08F3FED
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 06:26:47 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso8862501fa.1
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 23:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694672805; x=1695277605; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vNd6Mhf35GMe9RWa+Xf0nZSRO80+x90q1mI0LjqNNU=;
        b=rD2T+SXfMBRxKLFGnf7TluP3p5/lFGA98CYP01NC2GWKtc+V3cBX2mlJo4HLF3WSUh
         ZYb6jp9CQ5R0Q/fPb9GHq3UnlM10IgmaBTEGdyE652izMZnwbi8yyCjbr7cfgvyN3pxT
         LbfVTfbo0SuYEFjqkndVDk5udZAcGb4xDYCUzBPPJJ+A8/jtAaMy6DKuFDcOUMLVeCg4
         0tRHf+gR9IMxb8MWJBUYV7rESo1t95vMUHQhvS1ill4JXboQeEmpBUreWgNzsGzEgIvl
         EYyqr7Gu5Xmoq9VxrdUBqVxhsLriHA/825o6BgHVyU9cnhxFJfFWlMoYI6VOP+3h/4nd
         Umyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694672806; x=1695277606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vNd6Mhf35GMe9RWa+Xf0nZSRO80+x90q1mI0LjqNNU=;
        b=BgbSmYDCxr6/LEJv6BTyyfA92Evhm2qXXQag6oIxeYOHjEDl+pVuViRHd/y7GBHuv2
         vx1cA7Z2lTOqBGMI1OfdGXFMUBgFd1tWf9BKriwx9UFPUqTtu32dCavNpMlRHTkfSXta
         7Qd/R5rPW9wNIB2yl/5rJ4PNcwauwnAE/xsOMATxd/39ZZ2CWhD8BynkMxLuObP+MILJ
         m2Qr3wthXr3XXugGnpLA/caadWPYsgsBJyklgSC8jVWkMca9qiJu8pYJGWITubFKVqgG
         3Mp12JrT5jXVd1zxnuSOD8Xf6VoEszEZo81L+SQdHYiNXZ0yRvLrTPgx9QVUdACuDgkA
         R38A==
X-Gm-Message-State: AOJu0YxQi+aUqruYgFsZFN94Phy3jpzVfraONmdqa8c4zb+2jvdYSAaO
	f0MMsrzfVbiyNDUC+7HaeUuk8w==
X-Google-Smtp-Source: AGHT+IEXyD/63hRonxcmIDGjRGZcaw+/cu+rROOPezAiFh0Nr/O9LBQRR/P1DTlJe4FEXa2CWCykZQ==
X-Received: by 2002:a2e:9c0b:0:b0:2bc:fa8f:83bf with SMTP id s11-20020a2e9c0b000000b002bcfa8f83bfmr3161470lji.36.1694672805675;
        Wed, 13 Sep 2023 23:26:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id ce11-20020a170906b24b00b0099cc1ffd8f5sm520889ejb.53.2023.09.13.23.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 23:26:45 -0700 (PDT)
Message-ID: <7796431f-ae52-58b6-499e-566a17292725@linaro.org>
Date: Thu, 14 Sep 2023 08:26:42 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 06/14] arm64: dts: qcom: sdm630: Drop RPM bus clocks
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c3dd5f68-af75-4880-83c2-ca7723561ae9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/2023 14:08, Konrad Dybcio wrote:
> On 13.09.2023 09:13, Krzysztof Kozlowski wrote:
>> On 12/09/2023 15:31, Konrad Dybcio wrote:
>>> These clocks are now handled from within the icc framework and are
>>> no longer registered from within the CCF. Remove them.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
> [...]
> 
>>>  		anoc2_smmu: iommu@16c0000 {
>>>  			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
>>>  			reg = <0x016c0000 0x40000>;
>>> -
>>> -			assigned-clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
>>> -			assigned-clock-rates = <1000>;
>>> -			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
>>> -			clock-names = "bus";
>>
>> This is also against bindings. After your patch #4, such bus clock (or
>> other combinations) is still required.
> So, we have 4 SMMU instances on this platform:
> 
> MMSS (described, iface, mem, mem_iface)
> GPU (described, iface-mm, iface-smmu, bus-smmu)
> 
> ANOC2 (this one, no clocks after removing rpmcc bus)
> LPASS (no clocks)

Ah, I did not notice it.

> 
> Should I then create a new entry in the bindings, replicating
> what's there for msm8998[1] and dropping the entry with just "bus"
> from anyOf?

So this passes the bindings, right? anyOf: in the binding should allow
also no match, so this should be fine. However indeed we need to drop
the "bus" entry, because it is not valid anymore.

Best regards,
Krzysztof

