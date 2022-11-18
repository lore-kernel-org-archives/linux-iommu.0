Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2E33ED
	for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 12:43:51 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id s8so8021361lfc.8
        for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 04:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NiJMwiexjpUP7f7ZjsLLypcVQ7mNaWepQNRbw1OYtm4=;
        b=qtpZx1/UIdHoxayltqQ4wSi4b4Rfeard4Y79ULV0zSSgxeJ7phYlh4wnkyy/PjSae0
         6NFV+z60FnqaGFYXywY+OTus2kfJ8lCKPX/JkZqVmbzlOVPyGGdCzapAmCnD1n2q7e5U
         vPH8whYhm+jF63rmSUQAOOkyWWe7J0xmZz/ZG8jDgEbG61YeY2wy1NwtAZTd2GKz1PEu
         hD3EqnmNEMCNr8FuHHVeOnHYzg5FkFH7XljW+uKEW+5AqIoLnb4J02VF5cyT8vXUPasf
         977lGiIbZ1SP0gwZPGAEapXiqB3ihxehgKpEUHO2Bfu+BzkBWQtHcN2rZ57TMkjN1p/u
         CZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiJMwiexjpUP7f7ZjsLLypcVQ7mNaWepQNRbw1OYtm4=;
        b=tV4NwN/zB/RZmFakxsf6V7v/jhf2gPzvh6BQ56n5FUc2IQFaU1S/0LamVSuS5w72Q5
         xuTHpB3LFBJO9OvKDuVUzs95BF7MHi+4Ag7wjrrCmBLZN6GJEvslPo+wnm3fs01GoCOd
         KvReiHtQINbqfPZymzDFR61Q1u8cNKtAIiGMTWgJd8S1TXU5kItVujeHg8npAhtP4GEB
         POL1zjhNVL9nbTR6MdnTRH+Xgt6AaETF7gAHqaaiL6Xq1dZ/ydnuQh68ghQqjmSwUlH7
         DWyPnts0MlxFkCAFhI8xXFaKt5mAMLfCwW1s9hOhZlfUsl9aNAlsMa1lB44UuR0coTR+
         J2Uw==
X-Gm-Message-State: ANoB5plDp47IOprowKkwAnSM2+dQFIwro/0sIPkble3E6yokrZVFFN2n
	7tEbIJ0Y1ETfqo5wSDV7pJk03A==
X-Google-Smtp-Source: AA0mqf4kFMQPrBQUIqNY/nnzlWJ+TlDHY1ENdLRVDtsiTkbe7Sl/yPRQ7nACIJ2NZY3PH0R/GP8kBw==
X-Received: by 2002:a05:6512:4017:b0:4b1:be16:4a4a with SMTP id br23-20020a056512401700b004b1be164a4amr2724427lfb.0.1668775429326;
        Fri, 18 Nov 2022 04:43:49 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y25-20020a2e7d19000000b0026dd4be2290sm637438ljc.90.2022.11.18.04.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 04:43:48 -0800 (PST)
Message-ID: <e45614a2-5c86-ead2-c7f3-cc7f0720ce75@linaro.org>
Date: Fri, 18 Nov 2022 13:43:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 03/10] dt-bindings: arm-smmu: add special case for
 Google Cheza platform
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20221114170635.1406534-1-dmitry.baryshkov@linaro.org>
 <20221114170635.1406534-4-dmitry.baryshkov@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114170635.1406534-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2022 18:06, Dmitry Baryshkov wrote:
> Cheza fw does not properly program the GPU aperture to allow the
> GPU to update the SMMU pagetables for context switches. The board file
> works around this by dropping the "qcom,adreno-smmu" compat string.
> Add this usecase to arm,smmu.yaml schema.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

You already got my tag.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

