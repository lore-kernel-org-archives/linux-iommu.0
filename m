Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4527708
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 20:56:45 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id l2so82132qtq.11
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LezinHxIM/g7YL8z+NENWzds4O5w/AflVPEU1lWlKZY=;
        b=w9sx/pbHGUwWv9Z5UN0K5mv+FPBhXCKp7XOFTxC5GlkYuFPFOCSrH0lJbaRoyR9ds5
         M3nbjBZEtjaRofkiSNe/W7PL5B8sWHc4kWPU9YXp6fZd97IdyYxx8FouUzj+O58QTvGR
         WPj0JndkI4Ty3o0PI7uadzji0qC28abbkqucbhcRD0ZPO1wOn//rvRp4QN7ZtKAI3rsM
         qOLNI+KX7gbB2QpFvZKbtLYVUquIRk+26bG3dhreckluMrWktPV50KH2ljtCnFC2L8ua
         QxXi4bCDiS29bnp5oboD1IgwopNzGREkyYEYppmZPMX1uWGdZCcxXxVj8jOs440KdtzM
         XbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LezinHxIM/g7YL8z+NENWzds4O5w/AflVPEU1lWlKZY=;
        b=4fvgfsSvo+aibiFr9Vg/0O2pdYOxBcjN3v6goiq2JhF81AA/eyPKj59a/e0GD0cEIl
         osikKIR4bT+7IQL5wALl4J2R+HijBo0j2l5kSnvEtFEJ/AAo/yx+/Vx8jqOV2z6tqgEK
         qVjE80OVUZa4sXF9T7pDfis4JVqQf9ixtI/obwjc5f0SKeSi91EeztfMo/Pijcwx9aL5
         p2EDJP2UHUFoxD8b3h7IZBJRJoB0Uy1s992a2qiVRerJ5GSlVn+p+JiolOA0bRPZVp7N
         kxYiqjJi6ZyXt3lu931SSJohVrFfPoCRSGZ3mHO+DyHHSPrV5huyHHS8h7rlaPdzm5o1
         Ustw==
X-Gm-Message-State: ACrzQf00gnY3BBku2tNX5PZ2ePvC98Zy3toHzvL3MEWfjD32cWS+hjRB
	qjjqOpxcvF9YEI8oaXWY18H3Tg==
X-Google-Smtp-Source: AMsMyM7PHSjcA525xUqb2mRTdLe6Qynf1IGw15HV4W1FUp7u3d2iYKbm1jQAdW6TjKmvePalyJm/UA==
X-Received: by 2002:a05:622a:608:b0:398:959b:b758 with SMTP id z8-20020a05622a060800b00398959bb758mr21736567qta.553.1667422604968;
        Wed, 02 Nov 2022 13:56:44 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id u12-20020a05620a454c00b006ea7f9d8644sm9362363qkp.96.2022.11.02.13.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:56:44 -0700 (PDT)
Message-ID: <38755e52-626d-ed01-72b5-d199af646c48@linaro.org>
Date: Wed, 2 Nov 2022 16:56:43 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH v2 03/11] dt-bindings: arm-smmu: fix
 clocks/clock-names schema
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
References: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
 <20221102184420.534094-4-dmitry.baryshkov@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102184420.534094-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/2022 14:44, Dmitry Baryshkov wrote:
> Rework clocks/clock-names properties schema to property describe


s/property/properly/

with that:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

