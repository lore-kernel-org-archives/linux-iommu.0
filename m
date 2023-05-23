Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FDA1DDEF
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 07:47:07 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f00d41df22so5506023e87.1
        for <iommu@lists.linux.dev>; Tue, 23 May 2023 00:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684828025; x=1687420025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71R2q19ZXsGZnOPocAOTBJ3+IZ1FZhz4Wl6PP95R9qE=;
        b=YPo9tEHQHCri7/TBnpqe1nZ2RsEH/5ivukk/0Bm9/Qolw/Ge0wK7uvV7HcVD3sJooC
         BBEaB+Yr09XY5EIascvBaFzb4i+zzySuhc2FF4OHV+HB9pBdbEFDggwZ6SgefLSV5r8B
         D5SVj455OVphN4ODyA9+/DQS63JRaxnTs8FGL/hfhRFFEuc3AExQVCoLTyWFpZjW8aFn
         cW7pbRXOFvy99WRx0ro+8WjLyPWMst2oBJ3/+DytEGpNpVUS8R7ZBGPq+bydcGXxLGvY
         nt1JQj6jd29Q0TEJdxI4dJg1ki6N4+0NhHPfb1Xu0UxA0fPZSgS7ghvWpitSR+mgMVjH
         VEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828025; x=1687420025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71R2q19ZXsGZnOPocAOTBJ3+IZ1FZhz4Wl6PP95R9qE=;
        b=HdGOfG+MO0DUIlM9akof9Jj7EE8L6EZg/wI9bm6zBz3RHzGvh6162kUwi+9snPta/4
         sC0rE1Xz1DNcQdnF9OGTwTwY4SaUCGpI4KXsOdZpaV7r8rKrKeuHCPRUlA2RZwgUezFW
         L66HR0sG6n2saUq6ry9JyLj9CThbW/FVartcqAMBCyJ29aWjN9v8RSXm4QqstIE23gyl
         H7qUGoYX0XfKSYUezPODDAEMs/DrM2UjKjI7gC0ShVjW7tkqCkQGRhKk/VW7PmsYfxDE
         K+R+5fVrGQ+e6kgTGnqAUTEhfGi0RonnZuF8d73v8vvMMTdOiy0KFPs6MW+i5B965FAW
         AyZw==
X-Gm-Message-State: AC+VfDxYYNekS9XgeVP9pnGPFP6MtSbmhLB2c+NadgL+sL2R8j1Jiye7
	h3qCBVqlyEhKNkz4WXLYgGt9xQ==
X-Google-Smtp-Source: ACHHUZ5JTVpp/5NYzr6IYfEXUmBsbC2bmktnK/xToOViR87FZyWOzG7h4gTsSFl8nLwfgfTSrf+jJg==
X-Received: by 2002:ac2:4847:0:b0:4f3:b242:aa98 with SMTP id 7-20020ac24847000000b004f3b242aa98mr4037954lfy.30.1684828025193;
        Tue, 23 May 2023 00:47:05 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id t9-20020ac25489000000b004eb0c51780bsm1257070lfk.29.2023.05.23.00.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:47:04 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 23 May 2023 09:46:23 +0200
Subject: [PATCH v5 12/12] iommu/arm-smmu-qcom: Add SM6350 DPU compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v5-12-998b4d2f7dd1@linaro.org>
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
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684828003; l=1014;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=CPO6pRkqp9OH9BXcQBO5PamnhFLC+q+SwQwF41wCtLY=;
 b=k7xKsuFLcWfaIkR5AoVwsP5oWEGrwWp29yM+FdNZiowj/uPcFBuemt4KcDaxucF97xazSftcP
 FeLxlwlnyYMCspg0xBeAlehmkXWyCgK+IbNjZK0m2G5efyzBkT9Mgm+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add the SM6350 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index cc574928c707..bdeb587552c0 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -253,6 +253,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sc8280xp-mdss" },
 	{ .compatible = "qcom,sdm845-mdss" },
 	{ .compatible = "qcom,sdm845-mss-pil" },
+	{ .compatible = "qcom,sm6350-mdss" },
 	{ .compatible = "qcom,sm6375-mdss" },
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },

-- 
2.40.1

