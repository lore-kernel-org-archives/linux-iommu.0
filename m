Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25947C
	for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 12:22:20 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id h12so21600568ljg.9
        for <iommu@lists.linux.dev>; Wed, 16 Nov 2022 04:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xljYnYnQPEIox8T8MM9nvvNS3niXSPZfVXSMrwlG7XY=;
        b=XZuqrVaVAtWxSXiEujtNCvoWY32ZxJtglYxJErw6sAxsimQUTKv6R3hzdkwJS/uovh
         yK++rudGgAYYQO+oq4GdMlO16A9iKWRhTk3U4oqNc68QWux0waCXdKhqNPl/vkY+PjTv
         JytbW1ZY+tw6x2Lc8w95J9u+j8kjIlnZ3EHeVXsCPIoWCnUUXMANszFp/c1W27r71Dw5
         r5N2uWXu5wRlqBl5gLkCHvPljr654HO4D/6eY77u8ldMUAwfCRm6EfSaUmOE6sFItfCV
         gdBx7OJ6KiFkKsdpPfp4EhVcUGCEQHcnc44l7VNOjpk+hJ4k2kJzicJWIG5M1hKLD+zS
         G8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xljYnYnQPEIox8T8MM9nvvNS3niXSPZfVXSMrwlG7XY=;
        b=ymBPkO8yupbVTPK3PvaAiThF0N5EcNNy30WELoNf+bW35sQvglEQj13Yj+Fumso3V4
         9XLWZgO64XLAV1O4xXFrh33J/DOTPiT/C4Y9iep9av9xI4xDMffjQB3QLpjINjEBBJU9
         V/RwRcTVdL4jAg0b/HiiRcCH7SHoF+gWLeS3wLySbQlG5A042Jw+7kK6qIFvV5TJVPEg
         88zTzNEkC3Yl/hzMj5YCO3VJZta39Pbf/2wQa9exYN6XGY/6RxM26rbWcwk7Yy0ySmwD
         mnX1mHlhBOLVPXdpz0C5ydkTBJs3FNB9M6LG/vgHF0ZOZg3jkB1vOj6Ldyw8rLCXqKcp
         pOzw==
X-Gm-Message-State: ANoB5pnowdzhB79Zu1dhMx4g8mr0U/kletyouFnuv60Gjzgr1zrvaGwE
	h3WAl1xbtoCWLR156AQl5D5YYw==
X-Google-Smtp-Source: AA0mqf4AyH2iCKvMUFEi0Bg9zUVmNfqqLJ1Oc+IlY8lQaQWt6ko7D1XFUcumAl5Uw0STphIKazmSzw==
X-Received: by 2002:a2e:b54c:0:b0:276:ff0c:b7d1 with SMTP id a12-20020a2eb54c000000b00276ff0cb7d1mr7943969ljn.164.1668601338933;
        Wed, 16 Nov 2022 04:22:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bd18-20020a05651c169200b002790d8012cfsm1059467ljb.139.2022.11.16.04.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 04:22:18 -0800 (PST)
Message-ID: <9dcf36f2-ad3c-842d-db72-f534aad8667b@linaro.org>
Date: Wed, 16 Nov 2022 13:22:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 5/6] dt-bindings: iommu: qcom,iommu: Document QSMMUv2
 and MSM8976 compatibles
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 agross@kernel.org
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, marijn.suijten@somainline.org,
 kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
 <20221115101122.155440-6-angelogioacchino.delregno@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115101122.155440-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/11/2022 11:11, AngeloGioacchino Del Regno wrote:
> Add compatible strings for "qcom,msm-iommu-v2" for the inner node,
> 
> Add compatible string "qcom,msm-iommu-v2" for the inner node,
> along with "qcom,msm8976-iommu" as a first user of it and
> "qcom,msm-iommu-v2-ns" and "qcom,msm-iommu-v2-sec" for the context
> bank nodes to support Qualcomm's secure fw "SMMU v2" implementation.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 8 ++++++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

