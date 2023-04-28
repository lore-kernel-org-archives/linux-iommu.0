Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C92F36
	for <iommu@lists.linux.dev>; Fri, 28 Apr 2023 12:25:40 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f490so14525811a12.2
        for <iommu@lists.linux.dev>; Fri, 28 Apr 2023 05:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682684739; x=1685276739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZaTVYj+7JHW5ogrU2gshDHZR4SGV9IAITO2F/xNkdE=;
        b=S09ujwy6aOa6ctTYPXwZoPuRqF36CQOsazZonATFMiCtuWUqgPKeTkzkXMlHuMRDwV
         fLyWqUdCI9LTy5qBVXnvUr9nsc1iUB70043XxxZExzigT7J8Q5IBgzamv6tF2kALgu1Y
         Yea9deTDF9RU3VYdjcs6b5Rjz461ikvTNh/RO1MsUPAASsf9MNnIjvxm5MHjXHO8mWd3
         MpDfVvBEqhnqWnh/krHjWorg//QItjEdQCqnZZ+7NaRY3SFEK9fv0qHuNQP8oTu23hUq
         XRgPM+D1+VtGFF4UcvqEN3Z1pUWM0Gxg0ZN152oSurdgRNsePO4i9JsPUHjavQrMvg1Y
         Uwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682684739; x=1685276739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZaTVYj+7JHW5ogrU2gshDHZR4SGV9IAITO2F/xNkdE=;
        b=Rz8ge0oQnh7WKWiIMXTnF5dC9Tihx9DCD8R9ZfMZSTiKL1RRDHG9SkhJtgidcFqaUW
         HGweUiUE8elpP5Oj0v7QTg9ZQ6FmhCtlJfcxzRlotEhacf+HMuRPAn8cJBQr2Ae6Hurx
         Aro5hAy2izN/ogAmYTcPZFW6cv9ZSLaQHIj1tWxaRIAUEXPMv3CnU34fMeHU9bWK9lDs
         /SUzXgetpkvyT5bJXek5nQ4xBUZ9Th6A60fZcMprtsa83TGPCIcQUcBgWKNnLDYtopI0
         nHyp5iKpJ3cVFfJ7pZMqr6bp3bpUS/Cqi4U2JoE/6XTLPVbVKvvYl7RJYpvw8J3HI5Ol
         Lm1A==
X-Gm-Message-State: AC+VfDydwTNOebBmDGHEBTWus+f8MtJM/K1vJfUal2a0mr/p5Czi4Bt8
	W+R+Cyyq1+lUFqDcpg6wQ6EDzg==
X-Google-Smtp-Source: ACHHUZ5nE8CV6swtaa6RT8oWCahIZAfJUkO/1Goui9aA/rILn+31p0oddbno5lpzYsEOiXt4oKJLeg==
X-Received: by 2002:a50:fb04:0:b0:506:be49:243a with SMTP id d4-20020a50fb04000000b00506be49243amr4117396edq.15.1682684739187;
        Fri, 28 Apr 2023 05:25:39 -0700 (PDT)
Received: from [172.23.4.26] ([31.221.30.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a05640214c700b004fa380a14e7sm9102383edx.77.2023.04.28.05.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 05:25:38 -0700 (PDT)
Message-ID: <87d16bb4-178a-2583-5338-d9e9674da6e9@linaro.org>
Date: Fri, 28 Apr 2023 13:25:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 07/13] drm/msm/dpu: Add SM6350 support
Content-Language: en-US
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar
 <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-7-5def73f50980@linaro.org>
 <k25jg7cez2kimpxr4ztbdzjr2adq6a2vjknyvfe5frxujtogfg@vhfdyt45unv6>
 <b3fajcbkfxqy4bxzjezrugbetpbjxdskarr3fhtn2unhqv2srj@y2o3wfd4v7dz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <b3fajcbkfxqy4bxzjezrugbetpbjxdskarr3fhtn2unhqv2srj@y2o3wfd4v7dz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/27/23 16:48, Marijn Suijten wrote:
> On 2023-04-27 17:37:42, Marijn Suijten wrote:
>> On 2023-04-21 00:31:16, Konrad Dybcio wrote:
>>> Add SM6350 support to the DPU1 driver to enable display output.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> After addressing the comments from Dmitry (CURSOR0->DMA1 and
>> CURSOR1->DMA2), this is:
>>
>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
>>
>> See below for some nits.
> Actually found one glaring issue that might explain why INTF TE wasn't
> working for you the other day!

[...]


>>> +	.vbif = sm6350_vbif,
>>> +	.reg_dma_count = 1,
>>> +	.dma_cfg = &sm8250_regdma,
>>> +	.perf = &sm6350_perf_data,
>>> +	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
>>> +		     BIT(MDP_SSPP_TOP0_INTR2) | \
>>> +		     BIT(MDP_SSPP_TOP0_HIST_INTR) | \
>>> +		     BIT(MDP_INTF0_INTR) | \
>>> +		     BIT(MDP_INTF1_INTR)
> For completeness I should've pointed out that you're missing
> MDP_INTF1_TEAR_INTR here, likely resulting in INTF TE not working.
>
> - Marijn

<annoyed noises>

so it might have been this.. I'll retest, thanks!


Konrad

>
> <snip>
