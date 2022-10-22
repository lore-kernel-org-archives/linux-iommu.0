Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AC3C05
	for <iommu@lists.linux.dev>; Sat, 22 Oct 2022 15:45:37 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1364357a691so7130032fac.7
        for <iommu@lists.linux.dev>; Sat, 22 Oct 2022 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVu4XTuwWJr/YwyXL2uAxp+NUft8bZEEOp2Ycu+REmM=;
        b=Q2BgzvRzkSWli269QFsGDIojuLbvHjW9Ea9ghjGGwo9WYK/D5Zc/5LR6oX+WqsTm9h
         3qIFiH0EjPeHTaRzTVYOltZfC/N/gMElNtdN2chpi3/EnA4SI64k6yyz1YCV67fowdkX
         EeM9cv2WXkn4oD/ILMPrnLBDlBNi5UU0OX6QmqZtCRvjRnO4oBiWewkxqUUhEvgngpxv
         XJU7/5njXfWqo5I1VEJBrX+6Z862mRWNc2AMYPantnfpIlwM8L0FQlzvx977dDD/zPHO
         zEiVnP4fxO9Bo4d9s6onoAP7anRFDgTEYa+ZuEfLcV1YYckzHVc38nYkCh5+hb7zKkO0
         zzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVu4XTuwWJr/YwyXL2uAxp+NUft8bZEEOp2Ycu+REmM=;
        b=Ir3xvFZJBOLMYTt8YCUjKOsss0bkZmRqWVDU3Nodm81jBzHHEydQjGqnl5BaGjS1HZ
         BiONFBWt5FBjh/3zHWUSMNh1ICOWpMJNFKG9uXvJrMDO1l3MWZwrEFQFflwcobW3MjVS
         S/vZ9v6XutlGJTpiuC9E4bowqAvtJ8ksRBVU4u4FIhcgDKXT5h6rAR93btXZH3D45KXn
         KIo/fQXOyEoba/G5EcSa8AEGFGZQIJlEGMc/ZbCtBhJ8do7N1jyyCO+3yPIn26rkNZgU
         e1p1xBq0BZMNnP0gcLMrCml+rLVv2M7suOjNqceHaUplQkFuzRh5xfW2qruG2HdtvBKQ
         /QvA==
X-Gm-Message-State: ACrzQf10LVOpz0m3du52//Nr1LzTkr4nH5BvnwEwJcbosPdQsXIIoQ/d
	RD49BFNVhJgG3Nn3F/28UliJVQ==
X-Google-Smtp-Source: AMsMyM54Jr40A+CvqVTyLVkSLJxKugf4BweTxa+vKcieHD0b/jTZxNFDPAfxieTiJOd6kzA5D45GJg==
X-Received: by 2002:a05:6870:b4ac:b0:13b:151c:d1b5 with SMTP id y44-20020a056870b4ac00b0013b151cd1b5mr7328351oap.205.1666453536789;
        Sat, 22 Oct 2022 08:45:36 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id x5-20020a9d2085000000b00661c0747545sm2404098ota.44.2022.10.22.08.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 08:45:36 -0700 (PDT)
Message-ID: <0fa65ec4-b735-4859-401b-da14899ed921@linaro.org>
Date: Sat, 22 Oct 2022 11:45:33 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH 3/9] dt-bindings: arm-smmu: Add generic qcom,smmu-500
 bindings
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
 <20221021165534.2334329-4-dmitry.baryshkov@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021165534.2334329-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2022 12:55, Dmitry Baryshkov wrote:
> Add generic bindings for the Qualcomm variant of the ARM MMU-500. It is
> expected that all future platforms will use the generic qcom,smmu-500
> compat string in addition to SoC-specific and the generic arm,mmu-500
> ones. Older bindings are now described as deprecated.
> 
> Note: I have split the sdx55 and sdx65 from the legacy bindings. They
> are not supported by the qcom SMMU implementation. I can suppose that
> they are using the generic implementation rather than the
> Qualcomm-speicific one.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

