Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0011C04
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 09:52:53 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id j4so17860036lfk.0
        for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 01:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a9Yf2vWUl8QzwLNPXZEfNbnDgDj4wdhs80ARN0uIn5o=;
        b=zFcD4hHN168CNCoyPSlrb9+6t0FgavGOjn21soIQWD/L9bHbAsS0qZoUKUgSM32vVL
         wT1xO2/5HLpNzOqepbyiCWRdkcV+HrXd9vrCq8se58aWPJQX6GteODFVEc/fxOuEyi/8
         qLwF6yh3aG/1qhk4Giwka6QWitzsWAAICUgC4Ln2Lm0kUipCNKZhsD87yG6R0qRVCfsO
         Q5ZdjqBMwgHTO9ds0BPA1Dp00ypBGv8Ut28SOS9ig+8Q3CHd4zPvLNJe2+YRyJP0hLtE
         BcMGLD2YklebCLi31jiGOSpjxx/YOUNVbayQJbnD/adbwwnDPQhMNPJ1mC7O/862oaQH
         oiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9Yf2vWUl8QzwLNPXZEfNbnDgDj4wdhs80ARN0uIn5o=;
        b=ybawA/lAtLz3AEHoueVxJfJdZApIsEfs/jK3OjbLeg0dzbf5f+VG+ChOJ/hEtwmwck
         13+/wA8ssWliX4d0RK6UG9CAKxWEXgC6aDTuyyUq057gZTZQqKTLq5iiNCDj4lDtaIyt
         jP7K29AKInp0USbU7h+cYgZ63b+XNpEv7FvtFBiH/9XDp1lzmTk/7IrS8sWWKYNuI2aY
         OnMYlLSVJmLrE3luIMbZXiMCFic2HonIfE0c49icwC+sOYYQCSogR1lWGh58mGvD+iEL
         DGHyOXdoPuQKZxDr0mwAPilORD6qDYPmcRlM4GVE5pxVC8URriwdOegMFOk/IOEv2oFL
         TLeg==
X-Gm-Message-State: AFqh2koPU8gJnh77IEvSIDlLNubmcKTpseBE1LVb5DLRSoK8Uxq+RJu+
	OmO8talqniU+ztc9FZx/fjMg8A==
X-Google-Smtp-Source: AMrXdXu0d0zComy3IE8gzQZF4ZUH5xe/Di0Y0qahh3gpxl4wo2vABVT0rsPbJckxn2PGuBPsxi7Brg==
X-Received: by 2002:a05:6512:3d26:b0:4bb:710e:bf8 with SMTP id d38-20020a0565123d2600b004bb710e0bf8mr7769031lfv.16.1671529971804;
        Tue, 20 Dec 2022 01:52:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q2-20020ac25282000000b00492c663bba2sm1384212lfm.124.2022.12.20.01.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 01:52:51 -0800 (PST)
Message-ID: <b4186ec6-a3f2-4dfb-a83e-25cf6d460a39@linaro.org>
Date: Tue, 20 Dec 2022 10:52:49 +0100
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
To: Marijn Suijten <marijn.suijten@somainline.org>,
 phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Andersson <andersson@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
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
 <306709f8-7d45-9b76-f95b-1b3088d37a78@linaro.org>
 <6d263321-782d-9d9c-4fdf-8bcf5b280779@linaro.org>
 <20221219192839.6oqialqqw5xw5fxa@SoMainline.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219192839.6oqialqqw5xw5fxa@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2022 20:28, Marijn Suijten wrote:
> On 2022-12-19 10:09:03, Krzysztof Kozlowski wrote:
>> On 19/12/2022 10:07, Krzysztof Kozlowski wrote:
>>> On 16/12/2022 22:58, Marijn Suijten wrote:
>>>> From: Martin Botka <martin.botka@somainline.org>
>>>>
>>>> Document smmu-500 compatibility with the SM6125 SoC.
>>>>
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Wait, not entirely... no constraints for clocks and regs?
> 
> Quite odd that there is no warning for my DT patch as it clearly
> requires at least one clock...
> 
> Irrespective of that downstream doesn't define any (nor power domains).
> How should we proceed?

Binding now has constraints for clocks so at least that should be added
to your variant.

Best regards,
Krzysztof

