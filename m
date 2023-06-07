Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7534CDB
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 18:11:54 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-516a0546230so1119599a12.3
        for <iommu@lists.linux.dev>; Wed, 07 Jun 2023 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686161512; x=1688753512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=38gFDOgOs7OiOboCZ97J7wgn0Fj+LylW3p4y2EEpitY=;
        b=lpv2yfhVs1ay4EQ/axvCEim0SnJftwinn+5AL4kiudbnjwRCz8+AwbFewKwK0pYXcm
         m4xcxqBrZWkCJNQ5XkGbLldksMjNL9ys+rNBkLDmbLCdIS5ovgRA6+kR91H3dMyS9lkZ
         ROCeEHqh98oSIg6SOUfyHh03KqzwZ64+uehdKviePDHwXNinpPey5n/s09H46aPU7x2t
         +ePVU/JemqY8zfkFP1BUkfD9o8yZ3DFNxS2idpdLqTUCXbei+uyv8Lsar8NP0kdz5ybr
         AL7jEWg4R/F5Cinb+UXx0txTu7jweBEOImKOeeHWgb3fm5EMclTY6D2nAHKp9olqMoUk
         OPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161512; x=1688753512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38gFDOgOs7OiOboCZ97J7wgn0Fj+LylW3p4y2EEpitY=;
        b=T7wk97BaxMfW70H1y9l3uFZ7MW4ARGyVOmu/wtsijyok9NHD7yfVrckmfJ8fkJTmWo
         ipszZQgNc7drqdU5mn9Hd6DBmDrY0SqVtOmVsb2kWuTog6rfYXEEmPctVLtGT5sXOPkk
         1CHLUFfQCXumCDSSBQD3jpiMg8s5xwINwJs6Ck6NREHkGU9Gw7OJ8H7Xy+EMtAygxe4r
         y4j8iWdtAR8q7RwnEI2I7EPxWG9kovmTxcaJEn+6ycyf1FEYIhdT7F5ZnqacwnD/QfCh
         KQIzliw2MUySWR95I8/hXV8R8W5PqDamsoU1Vo5q6BQc7sno+RLtP2pllxDIUGYAkKfD
         0AIA==
X-Gm-Message-State: AC+VfDzVqQd+hjaMy1nf6lfllOUtmfqTb0++e1qdxgEzpXule94U4XaE
	lt6RWUTk/T9p9LGrU+Dn7wkxcw==
X-Google-Smtp-Source: ACHHUZ6QlGsiXyrJcXM30ikCxTwLf17/dt+bW4ffQAr6CkTuL+AYvsWCQwfGH415M7X/kOv0SIGcWQ==
X-Received: by 2002:aa7:c3da:0:b0:514:7f39:aa80 with SMTP id l26-20020aa7c3da000000b005147f39aa80mr4770123edr.18.1686161512431;
        Wed, 07 Jun 2023 11:11:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g16-20020a056402181000b005149cb5ee2dsm6427652edy.82.2023.06.07.11.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:11:51 -0700 (PDT)
Message-ID: <7107e83a-c607-41da-f606-277400d40010@linaro.org>
Date: Wed, 7 Jun 2023 20:11:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v6 04/12] dt-bindings: display/msm: Add SM6350 MDSS
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
 <20230411-topic-straitlagoon_mdss-v6-4-dee6a882571b@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-4-dee6a882571b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2023 14:43, Konrad Dybcio wrote:
> Document the SM6350 MDSS.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/msm/qcom,sm6350-mdss.yaml     | 213 +++++++++++++++++++++
>  1 file changed, 213 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

