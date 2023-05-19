Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AA3D3B9
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 19:06:46 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f3a166f8e9so1506821e87.0
        for <iommu@lists.linux.dev>; Fri, 19 May 2023 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684523204; x=1687115204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rui+ZWUFjt86muw9r1inOKrWuQmQAvAfmjQmisslnGc=;
        b=rXItGa2oK4EId+ypJUigwh2I4n2aUm3LD0VPGd7JlVZCaPN/L88EcMPOP4jWOnPsQZ
         CMm4ajybmaym87ABRc8V6w1o4kohcT+W1ohUypA9+EDCj73+q5y0nvyWbhDHobWdb6Wu
         sIyjjd8bJ8+fnLS+pt1HFKqrBe9SO5gkmQyicwHfhc6LPGdryrcV1gAFOFPuRy+/V/vf
         CEB4XZ2V6Bv9bm8AjqnJWsxwAw2BnFMIUlmk2zv186UF9J2mfuO7wgqfYg5tVieB6J6P
         kLogJIvzdk6ert42EdAka5D9GXdWfHp+tod5qHax9lYYW06PeODCbhHf8lYLWQS8Oqlk
         9n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523204; x=1687115204;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rui+ZWUFjt86muw9r1inOKrWuQmQAvAfmjQmisslnGc=;
        b=CmJsX/vsS5bOF8/rGS1UqJ0HoTZR01BMoXfebqyY4klK7M8rdupS9DbB+Q4KvhH3j+
         RbfugcMwi0TwXAdyboYszcbDHzRCisvdnom2OGFKbRLdJxe0EQKJrQSEP0PXr5K5u8oB
         b3tv4kMssEwkGbkPZ7g4Sk1y+rZQJ5Kxre+TzJSG9V/Je5BHbht1haKP2vwpc6DDTVVu
         4TSlh/yMRC0OhX1Q/3A/jTQKVZq8n2YlCq0rdJEZcc/SNBgC8xISm4BXBOHot82EFR7o
         ZrfSLAp++0Xd9O7w+776uno2nMRgPSs9A7Cqp5Wrnb9FlWzjUj6GjGkEWcr46U3kijsJ
         Csgw==
X-Gm-Message-State: AC+VfDzzfaJTjkhZNOcWX5s5uXhEkaCVvml5JjTVWiHIFNw3p+o7gIpN
	29F97saotJe2tOlyy8zihPHw8w==
X-Google-Smtp-Source: ACHHUZ67Ce2tA0cEGprwriJupZEEkiXqed5dpC+i0UuXp7d1PPnEunZUR84ZOoZKnBiZEonZaVqBdg==
X-Received: by 2002:a05:6512:3d22:b0:4f3:aa26:1890 with SMTP id d34-20020a0565123d2200b004f3aa261890mr1294165lfv.22.1684523204153;
        Fri, 19 May 2023 12:06:44 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id d30-20020ac25ede000000b004f019d3eab4sm2904lfq.23.2023.05.19.12.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 12:06:43 -0700 (PDT)
Message-ID: <0ccf9fdf-5604-d65d-6c7f-02c96f706a09@linaro.org>
Date: Fri, 19 May 2023 21:06:41 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, iommu@lists.linux.dev,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 David Airlie <airlied@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>
References: <20230411-topic-straitlagoon_mdss-v4-0-68e7e25d70e1@linaro.org>
 <20230411-topic-straitlagoon_mdss-v4-5-68e7e25d70e1@linaro.org>
 <168452313011.3852116.2187810600963716663.robh@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <168452313011.3852116.2187810600963716663.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19.05.2023 21:05, Rob Herring wrote:
> 
> On Fri, 19 May 2023 19:04:26 +0200, Konrad Dybcio wrote:
>> Document the SM6375 MDSS.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
>>  1 file changed, 216 insertions(+)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:0: 'bus' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:1: 'iface' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:2: 'rot' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.example.dtb: display-controller@5e01000: clock-names:4: 'core' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> 
Whoops, forgot to fix the bindings.. there was going to be a v5 anyway.

Konrad
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230411-topic-straitlagoon_mdss-v4-5-68e7e25d70e1@linaro.org
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
