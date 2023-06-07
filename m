Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B034CDB
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 18:12:04 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-977c89c47bdso843985766b.2
        for <iommu@lists.linux.dev>; Wed, 07 Jun 2023 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686161523; x=1688753523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8LLkELG8pk1deRrNltGQ2MtkxURXpppj04DS98maLQ=;
        b=mQwtQAxpJG8jV/xuinu93mq/TbKBa7bsRoILZ55z99uqXXE5DKZVFKH7DpniJCQN1O
         JtBEzsgI5qPT30X/q0Ql60fQqMuONlqxwLiKA7rXEx8zAscuJcOUApu9ynYG/zDz8AAZ
         yaiZnamd97s2iyhRdQ6Okaql4+ryQb3SwBY4YNl7kNJ+HRy1qJPxw4WeNqJZaXWlbO0J
         8j9JXYJRVIh/WIx5MtpUQNuVjTwyALsOrfeJeyaUTiYmEkPHvxCvCXSu4pxjC2GL9bN+
         dO9tWQFuJMI96rn4DT7hGU4eGoGPA47VuIOOtE6tCe61TclepLRJE98yM/i3EPz1lMe6
         SEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161523; x=1688753523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8LLkELG8pk1deRrNltGQ2MtkxURXpppj04DS98maLQ=;
        b=R6zJt3uM51tYgNagzKPbWmoeEVdnCQo3H9stWBTuhhmb6QHkw0Edm1qcujRXrYUMcC
         ZSuIoUZRzp+76bCVic50IvABxzq2UvWCQTkK6S9AHetNhTPfIq+dVVLEhtphTQgzsDfA
         th+EeadfJ3a6pRClmRT6c5aS8N74sDRSC/bzH7EPWDyEve28XX+KKAVLPoOkp3m7XKHO
         5SnOn5ElRkEMdKpZAEcByJTdn5D46devMtNPeHHBii7th9NSlWHHS2mH9f50C8xNMUkN
         y8bmM8n96E0P0kYvCiv1QHEWhQxbfzvCyt8OXPwHi+SC9l6MVN5UmCD9Ixj452ECnxPO
         ZsPA==
X-Gm-Message-State: AC+VfDzvYATtzYPOe8WPEDVlqR91o035b4m+fZh4mKJQg4sCXh+h5n+U
	RAVgShjPPcXuslKe0pbDOSw/kw==
X-Google-Smtp-Source: ACHHUZ4atA66ozVYI+ahtfsSLEEsIg2F4Rpb/cEGKV9GpyA79gCHhdMvWAlwmA4CitsH2GXDKLrxQQ==
X-Received: by 2002:a17:907:7da3:b0:977:d676:d3ca with SMTP id oz35-20020a1709077da300b00977d676d3camr7269835ejc.33.1686161523172;
        Wed, 07 Jun 2023 11:12:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id q20-20020a170906a09400b009786ae9ed50sm2488347ejy.194.2023.06.07.11.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:12:02 -0700 (PDT)
Message-ID: <7717cc1b-d258-4fb6-3379-05b2de27dc70@linaro.org>
Date: Wed, 7 Jun 2023 20:11:59 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 05/12] dt-bindings: display/msm: Add SM6375 MDSS
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
 <20230411-topic-straitlagoon_mdss-v6-5-dee6a882571b@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-5-dee6a882571b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2023 14:43, Konrad Dybcio wrote:
> Document the SM6375 MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 215 +++++++++++++++++++++
>  1 file changed, 215 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

