Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98446BD
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 09:12:36 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9926623e367so731933566b.0
        for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690189954; x=1690794754;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fh4EDpkUKXX0i2jSGB1PBtJy0KS6P9QG8sx5m74zofM=;
        b=k7sd9ry9f7KEkVokM1xv+AAbCPIUgxP9XVqzO2oMvoiFvG/KjABl32DheQa3U+CUC4
         FiNKfOU4mjEp9GJcI0Im9xwYFtPAIZbXJzoxBZ/rr6RF5MlQJ0kJAVrUTUTeDxI9XkQy
         qWGaACOxgXzHWqRKbhJnXkE+kOdZMIe41i0vCaZUNjm760cbJH+6w5Ty3z/OHyDLnvEN
         0EPDsV6gNixv/DBpu2SVDzffU4PrMSt6DhSna0c1zR0eAOASjDQZI/BWq7g2AcuTy7jr
         2bgX4+HoikeVPH6/aaWveSXFCU0WTMON9pJ61shYVBFC1X5Oxw9lu+khduMMptAw9RbC
         lGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189954; x=1690794754;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh4EDpkUKXX0i2jSGB1PBtJy0KS6P9QG8sx5m74zofM=;
        b=IKxbwK5jCs6J2jVinA0dUU+IDXm9unZ3rqauIviKEQ0snwAPXs8whhLFuXbhL6msWG
         tFhAlxYQgcbESbk5GQIz9T7+1SgsBaLXj2GNPenEkR0uD7yRAHfWgQraYZRXwfpQ8nZi
         pCJLz+HnZ7nocnWv0agE9XqL+pIR7tQYv4FLxMZhf+CnWKYz2VAexuGBAFKCjB+WNcjs
         LVcR9eeaUjDx6TEln/clwHNGL3HMdHqMX6onDF32fyhlm7/uaAlGlkxIWMxjuEqMpaVK
         4yH5PKNW/bcyCttWfyxvJX6JNrOdqOPOu7Ai8uIa9UzrcR62t2gyuP9DGR6md0OYd7Z9
         5Cnw==
X-Gm-Message-State: ABy/qLbFxQWiGC9qVQN8w20ySJvCmMsGRJvYk1LSmgnVyMqbbN6P3Wzo
	SvklMKBG1JQMT3AHLl0WrjxtgA==
X-Google-Smtp-Source: APBJJlFyiqbyrtae4oPoU8c9essn66hxwhB/tZ54efWazcZSBJL34UATeiWbByL1xXKVtIQgz5XF7Q==
X-Received: by 2002:a17:906:64d2:b0:993:d6a7:13b with SMTP id p18-20020a17090664d200b00993d6a7013bmr10019595ejn.22.1690189954456;
        Mon, 24 Jul 2023 02:12:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906254f00b00992d122af63sm6445656ejb.89.2023.07.24.02.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:12:33 -0700 (PDT)
Message-ID: <4d8143bc-03db-4f6b-9833-44cbaf95ecac@linaro.org>
Date: Mon, 24 Jul 2023 11:12:30 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/11] dt-bindings: arm: msm: kpss-acc: Make the optional
 reg truly optional
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Benjamin Li <benl@squareup.com>, James Willcox <jwillcox@squareup.com>,
 Joseph Gates <jgates@squareup.com>, Stephan Gerhold <stephan@gerhold.net>,
 Zac Crosby <zac@squareup.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang
 <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Wesley Cheng <quic_wcheng@quicinc.com>, Jun Nie <jun.nie@linaro.org>,
 Max Chen <mchen@squareup.com>, Shawn Guo <shawn.guo@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vincent Knecht <vincent.knecht@mailoo.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>, alsa-devel@alsa-project.org,
 iommu@lists.linux.dev, linux-usb@vger.kernel.org,
 Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>,
 Andy Gross <andy.gross@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org>
 <c52ee94f-f60b-f8f0-f93c-221beec0224a@linaro.org>
Content-Language: en-US
In-Reply-To: <c52ee94f-f60b-f8f0-f93c-221beec0224a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2023 11:05, Krzysztof Kozlowski wrote:
> On 27/06/2023 18:24, Konrad Dybcio wrote:
>> The description of reg[1] says that register is optional. Adjust
>> minItems to make it truly optional.
>>
>> Fixes: 12f40018b6a9 ("dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> 
> This patch does not make sense. It wasn't also tested. The code
> (minItems) is already there.


What's more - there is no such commit as 12f40018b6a9!

Bjorn,
You might find this useful (fake Fixes tag should be detected):
https://github.com/krzk/tools/blob/master/linux/git-hooks-post-commit

Best regards,
Krzysztof

