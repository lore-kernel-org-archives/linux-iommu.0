Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317CF3B3E0
	for <iommu@lists.linux.dev>; Wed,  7 Jun 2023 23:20:06 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f642a24568so46890e87.2
        for <iommu@lists.linux.dev>; Wed, 07 Jun 2023 16:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686180005; x=1688772005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyY/6IODHDlyeeop9FZuaK8o19bhh4JMPkyiNt+oF7I=;
        b=A9Vo0XkJIpgWyLRpiuu4l+nqzYPZyLpVqVdvCiGXgVQ1bC5U/NMMhRPj2tMBh1pHlz
         4E3UGxsRvR8xbq/CTMWAZEoIbXITXi8fPElZ5zapepohNCtK/0DWv/89o6AXmp0itP2O
         TWMW2xpyJylMKi+csThqo2mUbBuD8VdyBd3oySuu7CTWcEQDRdQv4GdGXv03pHoJastY
         B3nTDZc8VnZ9emMvGY4b/6QPd2nP+3NfvlmtSsvIqXvj+O+ehhxQAoT3W9qganeqYX/+
         icJ+rMTamrIocafOYueceNpwIpEAWwRFJ2UcGgRoTmfT0X3GKxwB29afKvLfGfk0+K58
         iEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686180005; x=1688772005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyY/6IODHDlyeeop9FZuaK8o19bhh4JMPkyiNt+oF7I=;
        b=ATiLEtJOZA0BxANHrq2KAsu66pnNeknKqj2rwb5XjJI+jri84s/nu+uo/943u9mNtl
         s/BYuwA4UUy42AR71tgfvZv3hDkc/zyBfzSTwyWIQnVg4KOIhkP8Bl5DQfLsV3wMTVD6
         iV+0Tyrsuh5txHeJgInhQ6+C/WxL2XMdaPPDxxkFxW7TIY2b7xEhziPQXq3KpjXc3t0S
         EK1LByFRvfvmP0UGwPyoN4AO1mtmqq/IcpBjm9DJIw/pJc8E+kqIqdg2hfHkGZ+pQbIU
         W6wkpnYaMxkgAf3J5fI6IbajZOmdMKdcj+zBHsz1fXP5jsK/LpWEajf9biIi/Q9PFTJM
         7o3g==
X-Gm-Message-State: AC+VfDyly232BizXboIubbg7uHyi36qnIjvKRLUogql+3zi4XeLHGNw7
	MZTx6DAXNR90ZAnLHhxE2G6SFg==
X-Google-Smtp-Source: ACHHUZ7hRM7SbUTZb8qBUPmUIUaSTu0RbpCLtAbbhmsR/dpPRr3/MkmoarjoWZTP2QKK3G21z5N7rg==
X-Received: by 2002:ac2:430e:0:b0:4f6:2e4e:e41b with SMTP id l14-20020ac2430e000000b004f62e4ee41bmr2199648lfh.3.1686180004908;
        Wed, 07 Jun 2023 16:20:04 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h18-20020a197012000000b004f00189e1dcsm1908952lfc.117.2023.06.07.16.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:20:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v6 00/12] SM63(50|75) DPU support
Date: Thu,  8 Jun 2023 02:20:02 +0300
Message-Id: <168617996601.1879421.15966890603577062057.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 06 Jun 2023 14:43:51 +0200, Konrad Dybcio wrote:
> v5 -> v6:
> - Drop unnecessary items: level in bindings
> - Use INTF_SC7180_MASK for 6375 to avoid enabling DPU_INTF_DATA_COMPRESS on DPU6
> - Pick up tags
> 
> v5: https://lore.kernel.org/r/20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: display/msm: dsi-controller-main: Add SM6350
        https://gitlab.freedesktop.org/lumag/msm/-/commit/e99b2d0670a7
[02/12] dt-bindings: display/msm: dsi-controller-main: Add SM6375
        https://gitlab.freedesktop.org/lumag/msm/-/commit/27a869221bb7
[03/12] dt-bindings: display/msm: sc7180-dpu: Describe SM6350 and SM6375
        https://gitlab.freedesktop.org/lumag/msm/-/commit/ed41005f5b7c
[04/12] dt-bindings: display/msm: Add SM6350 MDSS
        https://gitlab.freedesktop.org/lumag/msm/-/commit/3b7502b0c205
[05/12] dt-bindings: display/msm: Add SM6375 MDSS
        https://gitlab.freedesktop.org/lumag/msm/-/commit/2a5c1021bc77
[06/12] drm/msm/dpu: Add SM6350 support
        https://gitlab.freedesktop.org/lumag/msm/-/commit/3186acba5cdc
[07/12] drm/msm: mdss: Add SM6350 support
        https://gitlab.freedesktop.org/lumag/msm/-/commit/c2c1217e61bd
[08/12] drm/msm/dpu: Add SM6375 support
        https://gitlab.freedesktop.org/lumag/msm/-/commit/27f0df03f3ff
[09/12] drm/msm: mdss: Add SM6375 support
        https://gitlab.freedesktop.org/lumag/msm/-/commit/5ff3d3a0a09e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
