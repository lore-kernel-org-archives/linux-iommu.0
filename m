Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26017EC
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 08:45:05 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id x10so27333622edd.10
        for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 00:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rpXbd029I4RPrcJB43EPCQvzvd9TlAPezPhrvHuKOuc=;
        b=o3jbXDIKuTrfK/FM8hCEiHzqTQqqdJisJkST2+WPejTG1q7HPRpBjiaAgPihfoufw7
         xHx7p20QP7Ariimi43Qph8cY7QmKBKEm9+138VJwbw//XL2IGvH0FKvh+yyvQyqD9IDm
         lrY++lqPr9VJPqTqZt+1hLklqsBTQDoJNHzHU1p5bCFWcOYdPbNDiM1qwbIiN+Qap2l4
         zA/tGM9fvHMKMzYm3kyAqZjm6EZvMIOvWc9REcL2d8L0B6NCg0fFFBtEw5rYjD/I4duk
         W0bYs3EAu+s2oUCZ9mjxMW9CzMFGDmFaIqgBcdHj1I3vDqhC9BTbS4++X7RKSJGV1CWb
         W6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpXbd029I4RPrcJB43EPCQvzvd9TlAPezPhrvHuKOuc=;
        b=vaYTlp1uXfquWXwQC+oR7/DXmdaEBuaIs82yAOtHwGQNfkMhqXlCCwojFHyxWNK72u
         CxgxevIlh1ClS30omEvUMRiFR1AagXPHGINnv6iPUX63+t1pBBgOe1WTMr1msOOJpe8r
         7Hw99sQ+9Kp5xYMrBINFyPys5wqJsJjkkOF9FmyD+Hj9nOtUDrj9VmVo4XysQjvGyF0/
         st6hKywvMWTHal3eKnbrODJBB/pCVY/LE0AvpW2hKohxw9NVR3S8XQnAYH6hWc0YPKGN
         cK4ml/Yc3sypxjMNr1DbFJZypO+HLMoXnGoP9bgRGcePli/1S1ZuqOOBIT6JtW2DeWz5
         Uihw==
X-Gm-Message-State: AFqh2kqqUq6ddl6oxwjUSYx0G0JV9a9MYVF3KOEfrbjpT00aUgSaB8S9
	d6V3PE2fK+l/f1UNRdGXz5dWTg==
X-Google-Smtp-Source: AMrXdXv/8nXe2cQTPknFxBnq/uaW5tOzgI0h2dOUmh7Bg86HuOIFQ9db4MoU0xWsBZgtyuL10JOf0A==
X-Received: by 2002:a05:6402:370:b0:492:bf3d:1a15 with SMTP id s16-20020a056402037000b00492bf3d1a15mr25701705edw.1.1673599504036;
        Fri, 13 Jan 2023 00:45:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b2-20020a0564021f0200b0048c85c5ad30sm7913356edb.83.2023.01.13.00.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 00:45:03 -0800 (PST)
Message-ID: <230e4a92-1114-1217-9d3e-b2aee9b30d41@linaro.org>
Date: Fri, 13 Jan 2023 09:45:02 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: document the smmu on Qualcomm
 SA8775P
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230112154554.442808-1-brgl@bgdev.pl>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230112154554.442808-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2023 16:45, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Document the qcom,smmu-500 SMMU on SA8775P platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

