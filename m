Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8933C05
	for <iommu@lists.linux.dev>; Sat, 22 Oct 2022 15:43:59 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1321a1e94b3so7186173fac.1
        for <iommu@lists.linux.dev>; Sat, 22 Oct 2022 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ju7kxtOhKHTRsfBsXg2/eTdT1+u5aVNes5dScova9r8=;
        b=t+NU1/rm2OYIOGutKekuo5Cb7LFVI4jyvbzHGZxnhEgdUfK4OIiG27Yb3cKYAvy2pV
         VTJvYTAhBPsv5eq4iySUTnVFI2KbzQLGm3jmHDFtEg0+OHQA3phW8OCiT0W085wZEH+j
         6eGJgWlG3Nkc6GnsKY0AhMoF7SwyDYTbwcFay9Josxm8RqUD267fuz58WuMaAq0iHKSo
         4hAXCYtHDAPJ3HDanYSaMEoVS6cO++4FHw4tqbjgb8jYCcjLwMW30QzCEX1rqiroJbrt
         fXh9PgXEJmW58cAdlNyUTl6vzxNQOPX2ZfUaI6Hib+57Hf0395nUIT4COzVcD+urDfWE
         5EAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ju7kxtOhKHTRsfBsXg2/eTdT1+u5aVNes5dScova9r8=;
        b=r7KA75ceS5MlGPqdivh7pn4FsmCePyzfGrlgHDbmZyF7kJiyG2VFJZXG/MQvntMPFt
         HEOPNEuAdyvdtbPcKLdjv3yZIf086KLFu+ead6jO9rRbn5/eMx67Fx8E6XU6Nd5gBUNv
         TSF7et2y1/rioVhhKK6hSbbBEWnkpkDHA3PwyxgKI98CpDv5zWI0Z2GEBPBrVqHfBZgm
         SyYkyQ5thIDRytyxIEOeacrEzTHjeJef22yl9sCOQbp/xNahiBqc/NonJohcxjT1WLJ7
         nHZkiijcsPOTiC4ezFtGlcg9nsuxEN9sBQANq7+cQ4Rr8f8LwX3IQ+lofV2Yxh6feIgh
         2T3A==
X-Gm-Message-State: ACrzQf2EHa8tNKHtOwsbkU7BB6Kz/QykZRMOoj3BdqBXa/qTreL6lzUY
	8uSQ0RJKPPIXiKQtVkg1pcsBKA==
X-Google-Smtp-Source: AMsMyM6YOhCieDZR89GiEFE08pgj2Qt6dMSwM5GAwGyMbRO7gGqkcoZSc6SrRMkBjYf0g84SmS/maQ==
X-Received: by 2002:a05:6870:b393:b0:136:8cc2:ea8 with SMTP id w19-20020a056870b39300b001368cc20ea8mr32922605oap.20.1666453439075;
        Sat, 22 Oct 2022 08:43:59 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id q185-20020acaf2c2000000b00354b619a375sm2267659oih.0.2022.10.22.08.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 08:43:58 -0700 (PDT)
Message-ID: <403db1f4-d927-bb73-8aa9-84b9b0330e73@linaro.org>
Date: Sat, 22 Oct 2022 11:43:54 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH 1/9] dt-bindings: arm-smmu: Add missing Qualcomm SMMU
 compatibles
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
References: <20221021165534.2334329-1-dmitry.baryshkov@linaro.org>
 <20221021165534.2334329-2-dmitry.baryshkov@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021165534.2334329-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2022 12:55, Dmitry Baryshkov wrote:
> Add missing compatibles used for Adreno SMMU on sc7280 and sm8450
> platforms and for the Qualcomm v2 SMMU used on SDM630 platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

