Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651AD5229
	for <iommu@lists.linux.dev>; Sat,  1 Jul 2023 08:06:38 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51d805cb33aso3012678a12.3
        for <iommu@lists.linux.dev>; Sat, 01 Jul 2023 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688198796; x=1690790796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F2AOA85WPLNeq59zZIQIWUFQQzF6b4WaPXnHpsoj/pM=;
        b=uTt9U+aYLjgWdXce3eySEIwUYyScwz33iTbz8S7vol+S7QzIP9b1Fio3ugyjMzlTEM
         H35JObt6DdDe+ZAcrodw8uN/VW+NQ0CqZ3BQL4MYQyK/VG/jqB9fXAiem+0ABDpT8SMD
         jtIdYLOMBEssloGgEwn0cZsSLT3+MKV5fWePDdwy5GOGUNilj/gsbg/gPIl5znH0T4Wu
         vzEsOA4OW+uHY00syfFg4Kk7fezNivoQaQSTeCBtNOfjXPeHitfb0gcotxrQzmejiOg3
         Ym29/2O6Y8KtJR8Z70kir6HCS6nh0pKIyzJxpXQqPSeCQaqa/GXYh7L3Bhc+EOvvhCfl
         rA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688198796; x=1690790796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2AOA85WPLNeq59zZIQIWUFQQzF6b4WaPXnHpsoj/pM=;
        b=PDTYFb98FvDhsxkZrQyNjGLNBCBhVwyso6F2XXoIelUVoDs9D2rMBBdExvI8l9U9bS
         vRuF/dJ4+43tkDDZFUlXz+ftWTg0TxXX1DJHNenKGLlbZ7UuyWD+Mn33HubeAtyTw0HB
         izp33TJjegprjAk6vSpFKmBluaCBEoR3I14lqPTCQGwrxHw0OKh5jIcw+3JlNfoGvFK1
         n5fHqhSL3P+jKKtjNx5iuQ7V0hfaNhCLTHrTuCd5CG3StWq5+ySuVDFRS5kVzBorw8mQ
         hkfeOOy/5J/TUGQNzxZxN4fKno/EWBuepjGsZo9ra0wc8bSpcD+GEPGQw7o3eG5QZLGC
         SaQQ==
X-Gm-Message-State: ABy/qLa+YDzc/heGIMCRd8hlR5DvyqGmbvfCjydrt5GKixMiaiT+jTnv
	aXn4NkgMu+j1vKe1qcdKkzu/jQ==
X-Google-Smtp-Source: APBJJlEAcfboaxVqaehIP+kbquc2c7WH/RTZTv63cSm62Jc7muAl9JsCRYIb9E82IwV3w1SZdW4oEA==
X-Received: by 2002:a05:6402:64d:b0:51d:9605:28fd with SMTP id u13-20020a056402064d00b0051d960528fdmr2861016edx.26.1688198796353;
        Sat, 01 Jul 2023 01:06:36 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id i12-20020a170906850c00b00992f81122e1sm1268309ejx.21.2023.07.01.01.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 01:06:35 -0700 (PDT)
Message-ID: <05d97994-49a4-1618-890f-9f5c70c201fa@linaro.org>
Date: Sat, 1 Jul 2023 10:06:34 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/11] arm64: dts: qcom: msm8939: Add missing
 'cache-unified' to L2
Content-Language: en-US
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
 <20230627-topic-more_bindings-v1-3-6b4b6cd081e5@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-3-6b4b6cd081e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/2023 18:24, Konrad Dybcio wrote:
> Add the missing property to fix the dt checker warning:
> 
> qcom/apq8039-t2.dtb: l2-cache: 'cache-unified' is a required property
> 
> Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 2 ++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

