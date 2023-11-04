Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B63D68
	for <iommu@lists.linux.dev>; Sat,  4 Nov 2023 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFg2LZF8"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9be02fcf268so434331466b.3
        for <iommu@lists.linux.dev>; Sat, 04 Nov 2023 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699097379; x=1699702179; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJy2KKsB0PbRWKDGIHkbpjHuAvHX1QTO5G0UNsgJYlE=;
        b=aFg2LZF8blSNI853ghjEX8wuHwbg2xYq/SgboVl2koHCeGQxKS5VH98idjwAftWaPP
         l44tsJJ6nbFA7Sf5ET+ENK3WtGw+UQVme+Rbj7CO5dlT4MVQskZH9DOBD+TJQkLppjpl
         75LgNL45Rn4CRRl3m1kgJWBpYBwuDJZiuW1gq3evZqPdnKcrOxjDRVs1KuJrFHjEtZOu
         xSCaJPMbXYb9rcZMiuqR867AX5P9Bz444AzJRzfoY5OtYcHp5ePJM9e/WVAv/IMyyUZR
         vt94wCVsAl7WuPnhIA1+zQWKTNsiwsRjkzfkYnaVv+iOmKEkLig9GnsN05lk598wZwW6
         c0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699097379; x=1699702179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJy2KKsB0PbRWKDGIHkbpjHuAvHX1QTO5G0UNsgJYlE=;
        b=CrogDtmAPLXE1R9GG6QZn8vavhLi1Orq8BrYb8veHlsnwwkg+ldhsHeG+s0KsFeOmw
         FwEVpMrMwPQixsvoejwzMeugL9c1fO5Yt3RKxpsPK3OXamnbAYelX/3LLxq++DMYWBIf
         of+ACjRNYHrbUC93YCGmCwhdFpnD7crxJsLBsu4uYStSf3oWxdRp2mG/xE0ga6AI7pjZ
         ms3AlZu+yHPe5aFkpcFAkN7Q8Lo45yUiL5wjyHD6uD/FKqxo8Hx1nLAv5NtQKldbWMx7
         SQ+j9IrrIXS/BCH4HMlFBRNoo7I3TMZl0icYcrS6hZxjXtv0Wv7W82rZT5ptg5HMaY2x
         TVjA==
X-Gm-Message-State: AOJu0YxUglkRz3PGoUjTEWLyjDbsJ1ueEvr+0z+A5PT0f2wj12gTSwPk
	hllhRueY3eddgkDvJxtAfS3l9Q==
X-Google-Smtp-Source: AGHT+IEuzZ1y3DjdgqAfYz2QBkwZeMYD0RlEFfRha4mPCbrG7WKwE7gDC2yS115Aw3rKUa0Nzo8mzg==
X-Received: by 2002:a17:906:7955:b0:9dc:ee58:6604 with SMTP id l21-20020a170906795500b009dcee586604mr3980586ejo.21.1699097379512;
        Sat, 04 Nov 2023 04:29:39 -0700 (PDT)
Received: from [192.168.0.153] (178235177017.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.17])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906454500b009c7608eb499sm1878707ejq.94.2023.11.04.04.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 04:29:39 -0700 (PDT)
Message-ID: <27b4a561-a2af-47a4-912e-6ee6961f0f6b@linaro.org>
Date: Sat, 4 Nov 2023 12:29:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
Content-Language: en-US
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
 a39.skl@gmail.com, quic_saipraka@quicinc.com, quic_pkondeti@quicinc.com,
 quic_molvera@quicinc.com
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
References: <20231103215124.1095-1-quic_bibekkum@quicinc.com>
 <20231103215124.1095-3-quic_bibekkum@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231103215124.1095-3-quic_bibekkum@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/23 22:51, Bibek Kumar Patro wrote:
> Add ACTLR data table for SM8550 along with support for
> same including SM8550 specific implementation operations.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 85 +++++++++++++++++++++-
>   1 file changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 68c1f4908473..590b7c285299 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -25,6 +25,64 @@ struct actlr_data {
>   	u32 actlr;
>   };
> 
> +static const struct actlr_data sm8550_apps_actlr_data[] = {
I assume this data will be different for each SoC.. perhaps
moving this to a separate file (not sure if dt makes sense if
it's hardcoded per platform) makes sense.

This will also assume that these can not differ between firmware
versions.

Konrad
