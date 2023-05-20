Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDCA624
	for <iommu@lists.linux.dev>; Sat, 20 May 2023 01:34:16 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2af290cf9b7so10619421fa.3
        for <iommu@lists.linux.dev>; Fri, 19 May 2023 18:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684546455; x=1687138455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLAGUtWMudiFE1fjRVJz4UPReT3teB4CnEhketxzvG8=;
        b=jtF8SWdB4WbRVXC2NVHEZAvpwX249s2JclIrlpwexrwTZ2cgknIxXFoIhINKIkcngD
         APKbH2AD071j63Ei7ZCjRI1cp3sR8ofPnMa9S+XUjAUpqcGwkEGcPnoZpNeqQjcxKRU/
         1bZ9K5Xzfn680v4atudeR+w5P+OUWHaQixtmKmpyo99nmTydUPJRLgvoV7GLffnLjbCw
         +7c2yO4kksTWsoRJNjLgSvyjbsZdl4IxeX4OdRdo2/bILsDog/QeiCBEY6XyYVD5MgLs
         PVniMBfasG458Cuy73WkDz3ybI67t7Kj3E0BlX7pibybU/fzS8tBbrjxg1beaIWUuomF
         BFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684546455; x=1687138455;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLAGUtWMudiFE1fjRVJz4UPReT3teB4CnEhketxzvG8=;
        b=YuVgLi8nSqJlNrOGl+8zKOBzcaPM14eBCC8M/C7ysw75AKmGjj6deoZVa8UBRe2O8t
         tc9Rbu+VJG4lY/i9Bmgi3afV/QGPiK8rFPbM5/7zvfr7GpgIXmRJ0vChrThDaUv6Ma24
         F5VfpObkNqBuyzpP3vkvkDPaSBAKgGTtD+GaLQrtiTU37NHfBXne8q5DiNajggAsBZOZ
         BNfTGCTxXpp7Z7QJ57Qj8/hcKs+q482b7LrgzzSeYHkFxkQXx9xF/wfszCPIh//U/BEs
         o+VzdCeIhorG8YR4sQGCnCwZyVZtvCKlVVvgcIrq0c/1tMeAXxzZoAPk2qdC8ZYNgqgA
         1AaQ==
X-Gm-Message-State: AC+VfDy0k+vhekDvA0UcbXA2xo7+XFTK38pdqGOPGmZ7OMMEwl+cqoPL
	RL2+iO9daAaf9tWUVtkJUAhezQ==
X-Google-Smtp-Source: ACHHUZ7G6s2ldDT/PJWyP3GIpJqiwJxUgAD9NJmFazGPXUEt5kQ8ak4Spemx2LJsae2R6elvXeTolg==
X-Received: by 2002:a2e:9ac7:0:b0:2ad:509a:22b8 with SMTP id p7-20020a2e9ac7000000b002ad509a22b8mr1586632ljj.16.1684546454796;
        Fri, 19 May 2023 18:34:14 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l21-20020a2e99d5000000b002ad333df101sm73780ljj.133.2023.05.19.18.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 18:34:14 -0700 (PDT)
Message-ID: <e04ed1b6-958e-ffc8-ea5e-7fe89bb2b9f9@linaro.org>
Date: Sat, 20 May 2023 04:34:13 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 10/12] iommu/arm-smmu-qcom: Sort the compatible list
 alphabetically
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v4-10-68e7e25d70e1@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v4-10-68e7e25d70e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/05/2023 20:04, Konrad Dybcio wrote:
> It got broken at some point, fix it up.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

