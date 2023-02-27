Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3107EF
	for <iommu@lists.linux.dev>; Mon, 27 Feb 2023 08:13:12 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id r18so5236543wrx.1
        for <iommu@lists.linux.dev>; Mon, 27 Feb 2023 00:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0s3QlMH99J9txGN6IDDba9E7YuAuLZPQ1XK9+3yrepI=;
        b=Lwri2+SAGcjuAQG337kAuh7T/1Xy5lNNdYXVC9+tcUxGnIExP8iqrdONHBEdIBeupu
         Ci3Peomsl8WtHpiVOVOcN9pnFZ9yyD0zrsFq/GtKClsvzzar/2rs8EJxveaak+NQ+87w
         u4jg7L8wZUqdkZ9oNQrXu3UT6YoOzBM+dB9utsj51cegG65wUMrVVwIziJA7MaIsIrbm
         mX163nFAvv9J3EA0yXsyeobn7XW1ZRJp2FXgeH6biX0nFjM2NB2H4kFPKzFVfHMCbshC
         /y6bAF73ZXuNkXVBMwQlNbdVXecKT7olWMHBFDL4oZN3zxus0KRVQ/AWTWZOFiKoZ1lk
         C3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0s3QlMH99J9txGN6IDDba9E7YuAuLZPQ1XK9+3yrepI=;
        b=4IxBnA0pxAA8CryTwaKkH7+PScPvGw1DNE+SQyZlJjJYv2FP7SnEOb0xx2BFKaPuhO
         D4I/hlhdbG/Xyb/0hqumNATqBDh2fmvBacu/sH7csrEEvFHulnJuoL549/BH6dh2lipC
         W2lrzyu1PUtG5cPwY8p73R+fqW1zwooNEHYt5HB6Uz1EVAX1bkcMl1uAFxS/dkIhy6lr
         En1q/OQdTB6ovD3NgNM8Zt8bB0ylzNvY1VbZ/0mAG+m6q9Q8AN/Dgb2LHMBy/gkcLrOl
         PMhxIP5px0SvqnitWlhc/EHdIR9xpfUFo6NiDWyhrtwJ5v/imV4NJhuwOdNAQ6bnwoeT
         05Bw==
X-Gm-Message-State: AO0yUKVHWR7mZ/mwz30jwT5zZlvl+H2T0ZukYvVbXkKItn+d4cNoZa8Q
	g/vebuQrSJ7881WFgf1mLN6Zig==
X-Google-Smtp-Source: AK7set8zBqwByG8fmTxhMr+Ahl7JF9nL1tWM7uLVLQ+mkwTwXNLSS9DlEmBnIYzHkI02+nuuh9q1Pg==
X-Received: by 2002:adf:f484:0:b0:2c7:fc61:12d4 with SMTP id l4-20020adff484000000b002c7fc6112d4mr7595144wro.47.1677485590923;
        Mon, 27 Feb 2023 00:13:10 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm6395106wrv.10.2023.02.27.00.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:13:10 -0800 (PST)
Message-ID: <75b4da68-232c-7376-7806-8d475876dc59@linaro.org>
Date: Mon, 27 Feb 2023 09:13:08 +0100
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
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 andersson@kernel.org, agross@kernel.org
Cc: marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217111613.306978-1-konrad.dybcio@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217111613.306978-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2023 12:16, Konrad Dybcio wrote:
> qcom,smmu-500 was introduced to prevent people from adding new
> compatibles for what seems to roughly be the same hardware. Use it for
> qcom,adreno-smmu-compatible targets as well.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> - Add this patch, omitted previously (big oops)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

