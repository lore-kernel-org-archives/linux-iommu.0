Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576BB1C69F
	for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 11:54:31 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so69973091fa.2
        for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 04:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695038069; x=1695642869; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XTuYj+doNNU72YBaw1CaA5ZGAyKTkm1rkVWPnny88Q=;
        b=mo5roe3jVS6SWGTS4+lxN68Wrp4ovcejzRPlimhZHgPgiitkD+eVcPy7MBXbQiWfEo
         wcci/57udk5HbUpXZlKY+psKcJPzM8eVaDKjqXpTRUyW9pFKvM+oUcDqA96slCasaJbR
         Te+aNWbbpsyp93Fl1KgmNgsVnodztRWHrOxtp7TycM8XxVCGykIlPOXwlNYb1eBjcVMX
         eqhYIY3q6i9wExwxCxjVxGiaA35oxC+V6Mx82KcoQkZSvTI5EO2NlobfOKnTSZlzG9ID
         5sVHthSsuDAU6WpKhCuIWyqEaQiD8Fx2BgHGUCfAIrcZR+JZxLpvXuu0SOD/KcA4y3SG
         aVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695038069; x=1695642869;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XTuYj+doNNU72YBaw1CaA5ZGAyKTkm1rkVWPnny88Q=;
        b=Ala8rUkZ6+QVtcHBWcOkzTcxEM1/m8x2jEGLNIdPGk68RFNALejcdPOawZXBYzqfBg
         /I30wfyMXDAm2IbQowMVfkH9bHj9H3EL6EM0HksonfrqZhDZTqAotGBSNrEcfOs7NDc5
         +6OUPDyLaWodr5lYSF+s+M7fqezr+T2AEWGrLqWxdHPGETdaC4diYXMMhp+HBysVxFdW
         HsqUPcdsunEtQam0f9vzcrVE72kQ+s0iH2APOGYrH1VXC5iaq/OqubU2kMWlrBWQZX2O
         cTX7Z+BExV1OHwXhasma06zLmWbyTYa1zN93V2v/fEJh4hg2C9PHCndeLZXF7I0OFJx2
         Iu5A==
X-Gm-Message-State: AOJu0YyA/dIMwig6qSde4+QBIcE02SLrkd/zS/anoPV+CzbmLXHMqDjp
	LgfQ4tQPt0LFOwK5NWd5oRINBg==
X-Google-Smtp-Source: AGHT+IFFJVzuNiojURIGIa0Y2S0/cv6X2tyb8l1Ch14n1dQLx1ebsX7rXJSwkNoFewVC8Flj1/YkLg==
X-Received: by 2002:a2e:95cb:0:b0:2b6:a3a0:5f7 with SMTP id y11-20020a2e95cb000000b002b6a3a005f7mr7882460ljh.9.1695038069338;
        Mon, 18 Sep 2023 04:54:29 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906198b00b009926928d486sm6324008ejd.35.2023.09.18.04.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 04:54:28 -0700 (PDT)
Message-ID: <b71c60f2-6781-02fa-ec31-13060af05c7a@linaro.org>
Date: Mon, 18 Sep 2023 13:54:27 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/8] arm64: dts: qcom: sm4450: Add RPMH and Global
 clock controller
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
 quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com, kernel@quicinc.com,
 Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-8-quic_tengfan@quicinc.com>
 <c4e95307-3f09-5704-e5ea-cb42befb9921@linaro.org>
 <1a7fdafb-e75e-46a1-94be-36a9c3c94c15@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1a7fdafb-e75e-46a1-94be-36a9c3c94c15@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/09/2023 12:34, Tengfei Fan wrote:
> 
> 
> 在 9/15/2023 3:22 PM, Krzysztof Kozlowski 写道:
>> On 15/09/2023 04:15, Tengfei Fan wrote:
>>> From: Ajit Pandey <quic_ajipan@quicinc.com>
>>>
>>> Add device node for RPMH and Global clock controller on Qualcomm
>>> SM4450 platform.
>>>
>>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>
>> Warnings in your code:
>> sm4450-qrd.dtb: clock-controller@100000: clocks: [[28, 0], [29]] is too
>> short
>>
>>
>>
>> Best regards,
>> Krzysztof
>>
> Hi Krzyszrof,
> Want to know how did you find this warning?
> I cannot find this warning when I do dt check(make ARCH=arm64 
> DT_CHECKER_FLAGS=-m dtbs_check) or kernel compile(make -j8 ARCH=arm64 
> CROSS_COMPILE=aarch64-linux-gnu- Image.gz dtbs modules).
> 

I just applied dependencies and these patches, and run dtbs_check.

Best regards,
Krzysztof

