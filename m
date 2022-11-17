Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB8291F
	for <iommu@lists.linux.dev>; Thu, 17 Nov 2022 12:55:57 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id r12so2664885lfp.1
        for <iommu@lists.linux.dev>; Thu, 17 Nov 2022 04:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weF6twQ71pWpDxGcUzWzUjRuKt4zlvZJapX9428bGkM=;
        b=oMJaEUk7SN6S+W68VImxs6MzLOp4LRttAMZpSdPfxVM2JMza7JDFDWdZZaL0lO9Bx1
         M8T9iWspwsMr6SYy4ZdUH8T1EQjqBGNOYs9jfZd1kqrL3uBAEHL+e6n9nPOls2DMEwsu
         wvg1nvOKUUC20InGEspvMCFGtH7OJrPVVthCEovVTkGTnK8vw9BRU7EeZuK0rZ5/1AyO
         EKXWShLXBF48iiY4KC3ZEn8j7aIErKsaOzHZVLlMaw8d2oia8izerOMPXbNkxf/46jhz
         5piUjAecz3Nh2BxW5RRbZrNjPM6u51pvU+DDTdhdccIOFz0aDFLLpVskGANGCamJ3OIL
         up2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=weF6twQ71pWpDxGcUzWzUjRuKt4zlvZJapX9428bGkM=;
        b=JI8Ph+etkidnZfCwu+OX0DLfNPTZNnD9GTRSkQ/s0QvpmyBQsNwaZz50gEAAGVjvJp
         YBJgphU4RukzPJeKvH3vXB1VRBxLjET85bkgg9OfS67VmnkLXYW0TCKUgHZIN/VQ9pvo
         YDECnx/IfcD4usA7pTdSf5nLroyIUVfIZBoZhoInxbdXQcapj/9zK8t2sAG/P1NqAuDw
         n/74bne2A2enNclw8auWu2fPp6nOshDPxk0IlqpTSU+QZfvWSCmVEhYhq8uGMrg9kLdm
         7XVHu5chua6ZFQLqrCcMSWKpwGU+wc8g9ozpuJ9dV0FKSG0QgBHQx2IzmRbPg0s1gc7q
         i+7A==
X-Gm-Message-State: ANoB5plnDPV+cgo7WvCTbzUIKflvUqdyezENsAFEyv7eZW1a4qG4CJRb
	s8xrFpL78En+Yv9YKU2OHA4fwg==
X-Google-Smtp-Source: AA0mqf6HTkt2Xy7pKPSB5hVlx+Bp1Kn+ts6vBant0J7vRFGKxCmfnqQF/qAUyQQ7iWJ9insch5v5nA==
X-Received: by 2002:a05:6512:3b12:b0:4b4:686b:4f7 with SMTP id f18-20020a0565123b1200b004b4686b04f7mr773502lfv.256.1668689755798;
        Thu, 17 Nov 2022 04:55:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s3-20020a05651c048300b002770a9ed61bsm181805ljc.66.2022.11.17.04.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 04:55:55 -0800 (PST)
Message-ID: <77805b04-2724-dc93-eae7-21d9c7caf0a4@linaro.org>
Date: Thu, 17 Nov 2022 13:55:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add SM6350 GPU SMMUv2
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 andersson@kernel.org, agross@kernel.org
Cc: patches@linaro.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221117094422.11000-1-konrad.dybcio@linaro.org>
 <20221117094422.11000-2-konrad.dybcio@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117094422.11000-2-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2022 10:44, Konrad Dybcio wrote:
> SM6350 has a qcom,smmu-v2-style SMMU just for Adreno and friends.
> Document it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

(although this might need rebase later on Dmitry's refactoring)


Best regards,
Krzysztof

