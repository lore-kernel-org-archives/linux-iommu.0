Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09D946F
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 22:49:06 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4edc114c716so976910e87.1
        for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682030944; x=1684622944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fdP8MC3XaEqA32rWPdIckKxRCI4GJxh3IXEDH13XKh4=;
        b=Uo5s2ZVJ8f0YtJNR2V/QAw9DClxjdNn9cqFYEbfOZQUbcrDWvI3kZIG/ZvuvSdVhU7
         pfh5B5a9RphGrqWEwNIRlbMY45cfKU38pWY1e0FY61FUJh0Jb1svYJ9R0LJakfx9tu3m
         nbekIr7F6ZW68EnD6s+zO6qcATzgxFBHn6w9fyAO0JcooAsehyLQcDBDOcntPm0NyGoN
         Oifnhlo7c89uxuHM+wDtJ0RnSGZNiKDCUdarMsAhcx8sziEmaqPjUGiTtCmM0BS8tN6v
         sj4Ln9lcUStQlwf/nzgnSZ0qMbfnh5CtcwwFPN++psWNdyfLRUKvJWy/6+3gbGTZVDBk
         ty5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682030944; x=1684622944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fdP8MC3XaEqA32rWPdIckKxRCI4GJxh3IXEDH13XKh4=;
        b=YJiqWUDWIvtjQsUP6+lMX+l4xaXa0ahxOvIgA3ugtjcS2raiuYwKsKum6xfFONoGVh
         3csE8WSswpmLgXqFAYvG61/6NwnKYFTW8BqPs7p1sjfOoh8toLHH1GcqiUJaxd4sMacy
         0htKYBr9IY8oTXBScL9ndNXDDnmFl90xB6mNtAWGanQvlntXbSiTOCiCndiuPplzUb3F
         5/8yfDIoGwS+BGC28l5wjtSosTc8SAao6h6Sb+7b+zCfBklNolvHQFY67AxkbHM3WhlC
         sqIgBbxOaA1CkEJDtbcHujqRhO3zJb2KVQjVq6ifnyJkIh9wXD4QP/sak6qEdzIjbp2O
         9duQ==
X-Gm-Message-State: AAQBX9enQgUd626FImTPKE2nTCKseqbShMwrx+bOSOJuB/VML6goW4ro
	mKAFukwcJfcdGssbE5gYDmf7EQ==
X-Google-Smtp-Source: AKy350ZInjPaVxyUTYhwDYw+L3xY8vOz8c952eS4vzPQ6cipzNOj58Pw/XifVqqdE8XeIyyL0HzukA==
X-Received: by 2002:ac2:4905:0:b0:4ed:c9b0:6a42 with SMTP id n5-20020ac24905000000b004edc9b06a42mr780084lfi.12.1682030944156;
        Thu, 20 Apr 2023 15:49:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id x13-20020ac2488d000000b004ef11b30a17sm94609lfc.91.2023.04.20.15.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 15:49:03 -0700 (PDT)
Message-ID: <d2b6ebad-dd38-0bb3-7c98-27cda45c7ed9@linaro.org>
Date: Fri, 21 Apr 2023 01:49:03 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 10/13] drm/msm: mdss: Add SM6375 support
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-10-5def73f50980@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-10-5def73f50980@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/04/2023 01:31, Konrad Dybcio wrote:
> Add support for MDSS on SM6375.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

