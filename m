Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F110EF
	for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 09:07:21 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id b13so12715964lfo.3
        for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 01:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4tpSk+tjYm0GwOPhGRXLIEBiSIOkO/36qvtptczgjw=;
        b=N3oFLtrcYYoltNNztEkRCstMhmF7L/B1dnooX75CzPsUn+NB8JbGvQdJ++Vql486rF
         sefNxpApu6gMAkVRZOYes5d3WqLsgDYrPWXIykFUNwYYPYntjL7zQN/Yhj84qQ9yoiOq
         za7S99D23KoxgXtbD8tcKKJM6ms0CopXhQBeC/57fZXbvDUvweuKwwtELoDksuGGEnXN
         xMA4hzwsvuWl0iJx4kqAGSdbI2IBE6c3UtHU8lwq8qaa4WXjxWha0/uYfo266NJHaDjJ
         hXNkPR4WAkVmQWhue7F5tmilGwwmT1Qz3/wvZnTpuPGZ8ofXrIqRmnAPPfHGg+Hw1acY
         dv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4tpSk+tjYm0GwOPhGRXLIEBiSIOkO/36qvtptczgjw=;
        b=pJw5JMmAmu/6NPGhHuzPRmk+pwK2g3eyHjtxqaB1YHEK8XbH7tZSWOjJzEOqO2sbw5
         8bBO5a+QBfIBPDG8UYQQiHRo3VrRy+f8HPE1McVFIyPzUcGcut0AkcF9R8Gog9UEAMkA
         oq0FMzIfGD61tvq/Stwzyg3kF820V2qZGfJJnLKY3+j7GAB+NURTE2um5icLoauwR9y1
         F9bfYQ1KV0Icc+/nnCNUwJFF/THTdXn284nMXnS0Uk026qqNvIzEV5hQiB2feBfts6lo
         YN0I+gvr3D01taaZlp3LQHzDE3AA09Dt1kAQmJLqqc3D5bLm7eroxE0NJozGVXnRZbVA
         TJWQ==
X-Gm-Message-State: ANoB5pk0cN/SKDYLTS4D9dsfLzJ3fWF+qry7c84O/WGaU0VfqJKrD5dU
	jFLdeVfAjEyWQLKQW//sz+duBg==
X-Google-Smtp-Source: AA0mqf6yerJKFHzLlNexb6x/HD/ZwWzG43qKAdQsx9Tu5MD1hdnY7UrOWDYeXeOGe3TiRLg+e8ZbFw==
X-Received: by 2002:a05:6512:32cd:b0:4a4:68b7:f87a with SMTP id f13-20020a05651232cd00b004a468b7f87amr20619118lfg.30.1671440839244;
        Mon, 19 Dec 2022 01:07:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m16-20020a05651202f000b004b4930d53b5sm1042586lfq.134.2022.12.19.01.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 01:07:18 -0800 (PST)
Message-ID: <306709f8-7d45-9b76-f95b-1b3088d37a78@linaro.org>
Date: Mon, 19 Dec 2022 10:07:17 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/4] dt-bindings: arm-smmu: Document smmu-500 binding
 for SM6125
Content-Language: en-US
To: Marijn Suijten <marijn.suijten@somainline.org>,
 phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Andersson <andersson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, Lux Aliaga <they@mint.lgbt>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andy Gross <agross@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Thierry Reding <treding@nvidia.com>, Melody Olvera
 <quic_molvera@quicinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Douglas Anderson <dianders@chromium.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20221216215819.1164973-1-marijn.suijten@somainline.org>
 <20221216215819.1164973-2-marijn.suijten@somainline.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221216215819.1164973-2-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/12/2022 22:58, Marijn Suijten wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> Document smmu-500 compatibility with the SM6125 SoC.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

