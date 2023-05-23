Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC741DDE6
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 07:47:02 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f4c264f6c6so265109e87.3
        for <iommu@lists.linux.dev>; Tue, 23 May 2023 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684828020; x=1687420020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uz91t5CPsz6QMWtRIYuzaeaGaQUSJIZo7OKNOwA96Nw=;
        b=UlwfKNSVJBhPxE30HjUkiApKtA4o/j+IQcgcgMlwf0oDC6YsygNnbZpJUblLGu7wIK
         BF9j/m8y6lXF19X/dpy1/NDKqBlaNp1eOpA/1NIfr5JMTe1121rfBVJBhrUl4ciud9Ji
         Zx3uvBnFjtko0vvvSjcZ+1nN6DuR+CaZNofDv3zHbMZST1aYDk1v0BCHps5rMICrt4px
         65tRnlJv2nZV5BQ4rCeNk8/K/dFn9zDl1BJkN3pY3o6v3U10YpLD7nv3EUK67cLzQWsC
         BKs4LH1E5db8UTtCvtKT/qnYtJSOu3nEtoLRlD3UVwQi5SZ2XqFCtZLTdcs8niN8OE9K
         nk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828020; x=1687420020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uz91t5CPsz6QMWtRIYuzaeaGaQUSJIZo7OKNOwA96Nw=;
        b=cD6ksAwa5/vTSKNm4jaEe9yAiYg0iqkDlJel6UqEEu4Rm0gp7fHXN5akKOXzVGm379
         rq2bHy6xsXWS1xqV4g2aOQObgZyGhyy/nIJV+9mV0+RpOUB85NbBy/KEvhmxQDTCGTH5
         FX92OT7rLgEok9wJj+qf5yyLNhZYRMZ0Jrn5bBCl25rOaTfN2TCzsona/q17mP2iPeJ7
         btYBq396KVFq+2b+GI0IAA7uhV7nDjSO6noXZ811bMI1Le2Xn5bWsmju9Hp2uk5xWhx/
         YESOS86n0tH8+tq9Zneja+BwLu3jB7wqOOtvqbftEmgIKEP3c+0UUX4xLFMMDQD8OHDE
         k1dA==
X-Gm-Message-State: AC+VfDydexzTP6JbeHwkiKTnPmTHmahfpScbSEs7sxXZf+dkjp3eIF5a
	YsjCgUUInp3Gm3IgKEupU8SrTQ==
X-Google-Smtp-Source: ACHHUZ5kAF5uQSeuXgAPRImGMQR5VzZ/7OSgGpdEbGRQ+peABQ0DXcoD5LeeMzy346x6Cn0v/DN4vQ==
X-Received: by 2002:ac2:4c09:0:b0:4f2:74d3:8996 with SMTP id t9-20020ac24c09000000b004f274d38996mr4455935lfq.8.1684828020519;
        Tue, 23 May 2023 00:47:00 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id t9-20020ac25489000000b004eb0c51780bsm1257070lfk.29.2023.05.23.00.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:47:00 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 23 May 2023 09:46:20 +0200
Subject: [PATCH v5 09/12] drm/msm: mdss: Add SM6375 support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v5-9-998b4d2f7dd1@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v5-0-998b4d2f7dd1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684828003; l=1022;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Nh6zuYJI8gb14gxje6MmS/hbQSaIA3Eeoi75EfztoC0=;
 b=mwOMTHZtQczidymOKPTKW1hJ3k0Sfycwrop+S9790DYqps1onxdXRPHNXVFw+jMyTBbN68XRh
 O+ZzxbdzSd9AdFBeZSqcdaG2O5vRco+Dkni81Bj96yukCZc4ScXw/yr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add support for MDSS on SM6375.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 4e3a5f0c303c..05648c910c68 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -580,6 +580,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sc8280xp-mdss", .data = &sc8280xp_data },
 	{ .compatible = "qcom,sm6115-mdss", .data = &sm6115_data },
 	{ .compatible = "qcom,sm6350-mdss", .data = &sm6350_data },
+	{ .compatible = "qcom,sm6375-mdss", .data = &sm6350_data },
 	{ .compatible = "qcom,sm8150-mdss", .data = &sm8150_data },
 	{ .compatible = "qcom,sm8250-mdss", .data = &sm8250_data },
 	{ .compatible = "qcom,sm8350-mdss", .data = &sm8250_data },

-- 
2.40.1

