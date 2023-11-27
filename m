Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2C32C61
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9MZkq/Q"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso6641365e87.1
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 07:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098947; x=1701703747; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzHhRUdqYzC89phn7gbVveYcCLwhSTvqnPb56NAvVOE=;
        b=p9MZkq/QiA1IMgW9aOM5CTA9IjKiDyMDozm/XzJIVw0GHHbvctDe7AQagS4WFMDLio
         sRlRxlaxzh341Mx9dEcfiGanBE8sHOHzj6WMY0rgIjaoN24Ct2UbjBNVYodYEM/mNtwV
         3yOjkB8uXFhAU8DuDAnY/Tr0J1puv6be4WAPE8tdr+h7fImIh1Xkyo1Ye00oiUbhEPun
         WZ0qTtrUIJjE0Z3eF9t9nZeZxdS5mk4UQK//zruPR9uj59xKgdXw+jTH+w0438vke1JO
         yqtuZyj8iv8v35/s4I+0FDeuwYQj5jf9NXOVKtX6pXT+2lxB14UWqSHVsBxfTzoljigs
         JcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098947; x=1701703747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzHhRUdqYzC89phn7gbVveYcCLwhSTvqnPb56NAvVOE=;
        b=DOWmvDmGCQM0YhOG3RfAKFh994yMFSCmnVHAKdT9e5HhvgvoIcpekSL+3l2yEpeGHs
         BwoCvl+bC21VO3cqtXrpDsO2JdShvi/dgJ1I32oApPPjYZrhJAEfwpTAozKNQ2YjttsZ
         V25z1jFHh3To1OCQ7Ljen8asYLk1nNcJTtyXpos2ixQRmPY23mRc4R5WRKFQ7d6Tl0xE
         9oJXAVof74VEMAJUuyO1+pZM3dsf5EFHGf2okppZdnkpR+muIcXtH0dqTBJhTaK8vJ2L
         JZId9F1IYnZ2ELs+2q41kEHH0A6E9RmnY/AnDk2saO2iMgwCqSzMMaRgayJjuOv2rgKr
         E+NQ==
X-Gm-Message-State: AOJu0YyZRwPhphW8xYGG8k6NPpBNNN+OnTESD94D7WqEefyoXGMTyIHt
	mCol6HqVoULvMyXeJXjtMkRrhw==
X-Google-Smtp-Source: AGHT+IHfuCB/u5iuBzcXxxczmnBsCFIJiK0WEL6nD72DL5ef/WUsiecbpfHVhsXn1JxOeqjD5DGehA==
X-Received: by 2002:ac2:43cb:0:b0:50b:ad16:bca0 with SMTP id u11-20020ac243cb000000b0050bad16bca0mr3545964lfl.40.1701098947808;
        Mon, 27 Nov 2023 07:29:07 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id e7-20020a056402104700b00542db304680sm5321002edu.63.2023.11.27.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 07:29:07 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 16:28:45 +0100
Subject: [PATCH v2 05/12] iommu/arm-smmu-qcom: Add QCM2290 DPU compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v2-5-979b28f35e4a@linaro.org>
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701098925; l=876;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=G/TOscakzMl5L7lLg+f1aIz+xjyCycciuqgvdkeUR9s=;
 b=VIz+Y9084yjDi3/47tMxdkTC2e177oM5XcQ6dTdEpAKxC7RNhwq2iZQcKfXPJV4yp7X01NvAb
 VckWTM1fxXjDzEfWhm9T0ZWjcXcDhTcG2S1DXVj6948Sceq8Wj0LnzX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the QCM2290 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a6..aea5e85b20ff 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -245,6 +245,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
+	{ .compatible = "qcom,qcm2290-mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
 	{ .compatible = "qcom,sc7180-mss-pil" },
 	{ .compatible = "qcom,sc7280-mdss" },

-- 
2.43.0

