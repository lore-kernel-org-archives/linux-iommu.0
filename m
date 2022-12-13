Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF233D4
	for <iommu@lists.linux.dev>; Tue, 13 Dec 2022 13:15:44 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id g7so4833645lfv.5
        for <iommu@lists.linux.dev>; Tue, 13 Dec 2022 05:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKHuBiG5bn0UFG61Yqwdz0QHJ0cX2ppNH1TiayU1Q2o=;
        b=ensnDSrEu44YeNbGbwFOzBKWKixUCwqYBsxZkxclujpJr1dSc1JlIIPAwlwjzG1U/f
         OxwyEB3rLtLXnqOdfDcijaI7wX+ZMm3r47P+39ftfrEqZwW2vbsA/2BolSUMnm+0O+Ov
         o/fjqXpnJYMc9SV9FnGrhdFCor0hX/iMr8xCppy3zTYV/vM4o4zFbCQW8QSKRwua9KKe
         U7jeBpztkz9yw63c/pAFpcJ2zMssJ/XgZFKdPdb/wr4S3v7nV4vvIOfC7yYcJ+z/5BA3
         ZsBVNyas1eXJ4Loo4KpUvgliQT8kj64d9K0kMrDqQjUna0hsMYXDE1fqsordWumWxOBI
         d5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKHuBiG5bn0UFG61Yqwdz0QHJ0cX2ppNH1TiayU1Q2o=;
        b=Y8ZOFkpV32/LcJ7Zmb6Onc+aiXhPlAA2b79M9Twol/6PGr/yD4lYWTMvZ2U3JURboc
         6xI/Yi15lsPoJnsMGU6Jrl2mKnydCMdmkHOV9b1ArQMrt3ZsRiTIWIo5gVVxtIVrgCNP
         lM9mT8B1pQlzWNTTVtap8d+464YfQ/J9j1IBNYHDlv1eGqX91Ayyi3LU1KZ4NgJixv+U
         67qyf7JgwBCRP4iQBnDGko3tl8fwqiE/x54vH1hEbnnLhEoPlZ21KTRS7RpOyAvJYI1f
         mwLFkfAoFR0kBQlaUvcVmpzmIAuXqhU3cVQqx84rpuEziOZulz7j3xb61CBgaGX+/Kc+
         WT1w==
X-Gm-Message-State: ANoB5plfR2dkvQLPJmOMkVIEZH3LDh7zFfxaXLM6d3vJdtIjJG7sp2ZI
	mjCoPlg1DfB8NLNjLRahT99pxw==
X-Google-Smtp-Source: AA0mqf5tU/Ma5YpbX86AbY/XiEHidBFkWVYYIi+47CjDu764F7Uj5i7SXZRUaPL43IkeKYz3YWIZfA==
X-Received: by 2002:ac2:4c98:0:b0:4b5:688e:ee10 with SMTP id d24-20020ac24c98000000b004b5688eee10mr4840617lfl.16.1670937342156;
        Tue, 13 Dec 2022 05:15:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w13-20020a19c50d000000b004b5284a92f9sm360837lfe.208.2022.12.13.05.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 05:15:41 -0800 (PST)
Message-ID: <10cdb865-9052-f535-a2af-c872fe456bc1@linaro.org>
Date: Tue, 13 Dec 2022 14:15:40 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add sm8150-smmu-500 to the
 list of Adreno smmus
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 andersson@kernel.org, agross@kernel.org
Cc: marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221213002626.260267-1-konrad.dybcio@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213002626.260267-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/12/2022 01:26, Konrad Dybcio wrote:
> From: Marijn Suijten <marijn.suijten@somainline.org>
> 
> sm8150 has an smmu-500 specifically for Adreno, where the GPU is allowed
> to switch pagetables.  Document the allowed 3-compatibles for this,
> similar to sc7280 and sm8250.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

