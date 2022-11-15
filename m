Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD48AD5B
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:52:31 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id a15so18054755ljb.7
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 07:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qv1jQJ+HAdTvDoHEWeiJyxCYUc1W0oMj7+9QSvPLhVc=;
        b=by67cHmdJG/Y3MLIFsigEaHI6UU+//XXwrX3/Ut83VA+Cmpe8/MUNVfjV21llKKtiI
         nx7MbqtWD/pTgQIjfINnM778dG6FGptovgryInpbKTk5tzwwEhALKRvxrnybAjqGoZCW
         VtmgjdS7Z4M7h2d43uAphVjmqQyPldFRAbVBW6O3ErHeYluHYPet2100OI5zksptMpI8
         Ol6EAbdBAhP1H7yR9auIqrabT3cBB5yO+mc1a82AR4U092w4gXTHo/y4lFjCsTzNRkAr
         +PpmDROj/OzHQMft5k3DIgL62g4gc2asRAQCKKTB+fqkd6rycNH5GF3EimYh+tNPfDd5
         YhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qv1jQJ+HAdTvDoHEWeiJyxCYUc1W0oMj7+9QSvPLhVc=;
        b=p15NjYp6QUnn9an3CZQXkQiY/ijGNYYl9PE9VGSEwzz4AmyLlJIc7w30iYBssqw8u7
         nzhpOj51GW2c+pqAAMHjgtWfcKoOc6y6XYklvuOq6u+Cs7jXmMSFZSSFnfSxmntI1sC1
         dIhHySwz6Bu945iF5TRNu7lWLUiDETt0Es+6kYEuu8VV/7g8XmEMGXF3SR8dRbhMbRcH
         ahe1CnFoM8wNtwNG8y9xW/LRVE9RidnI2vamelniq3/Gwsh991NvaPhdD3uTeLpsoynN
         1CHDqQ3DPC2mb5V7vHkVeE8frkwiugpPA1HpYwKOwLEecFr4STxJr+vf4+h2dJd1096j
         naOA==
X-Gm-Message-State: ANoB5plw7ZaKXVRG4xjrk0K8KxMbOYe8AdOn410bJ27KD1N5T3wP9fRp
	PTt+qzZx5l4rjGIiu6YtBR+OSw==
X-Google-Smtp-Source: AA0mqf7gWLAjDp2it8ozEEeNxtZ/0E2c3yVOGMOdPqQ9nMgKSfpCDyG2szboeSX/KAVBrxbsqEMLzw==
X-Received: by 2002:a2e:a401:0:b0:277:37a8:ba87 with SMTP id p1-20020a2ea401000000b0027737a8ba87mr5799824ljn.14.1668527549201;
        Tue, 15 Nov 2022 07:52:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f27-20020a19381b000000b004a45ed1ae21sm2243842lfa.224.2022.11.15.07.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:52:28 -0800 (PST)
Message-ID: <63f4d2eb-d681-a523-1a5c-9f727c3ddc7f@linaro.org>
Date: Tue, 15 Nov 2022 16:52:26 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/9] dt-bindings: arm-smmu: Allow 3 power domains on
 SM6375 MMU500
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 andersson@kernel.org, agross@kernel.org
Cc: patches@linaro.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
 <20221115152727.9736-2-konrad.dybcio@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115152727.9736-2-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/11/2022 16:27, Konrad Dybcio wrote:
> The SMMU on SM6375 requires 3 power domains to be active. Add an
> appropriate description of that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

