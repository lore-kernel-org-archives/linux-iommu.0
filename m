Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9202570
	for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 22:41:15 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id d8so3601590iof.11
        for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FlMLWqjsEhvvN9ALe+BbwKktL9+Dx8brwwgQenKGt2w=;
        b=WI8D7cv5AZmDkN4ttg4WESnrYZlMkYc+I75Yjz/udZtGHW6fOOlelxZ1TfN6DAlGfY
         cJyXYmECYMg4cNoQZuruYtL2NsVhMzEuXYGRwVrfoijNO1g3iTATKJHZIfLzmu0Ehl/+
         7yMnPdGi1jdgc7ZC2EZn+GHBJJixCPWGlXJKH4gJdnq3b8T1IgzLS97gKAtO76kycVxv
         j/tg7iqOtP7puKTrTFiSWI4fY+otdWgp38ah8/7OPArqc1j+EOit4B7ZVMdjTVweMqQW
         GddxzD96qbuZgnFq6wo3P/U5NShsIgsyWdqvzntO5j56R+3kybwi9Jp8NND2pfDP0xlw
         o9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FlMLWqjsEhvvN9ALe+BbwKktL9+Dx8brwwgQenKGt2w=;
        b=6W5vIwDTdrMapcaKcFxjfPLhlbuhhwJIalzzAZDZtuMn7H9FiJs3l8Hzd2DRX3krYX
         rSu75SXVduFua+8kKXpu/hY4hpdcE723H1nyO/znOfY3NuqsODs3fWGEQ8HYJZ5If/Pl
         5lTJhq7r+0qt4cF1T0hwPyAmD6YZPF//+GnPERA78pu5oTf3kTUESeAvwDggoJ/F7CN2
         gNyGFOFN5pYE9kNryfiSRfXrFpINEtu9S95m6NqLlIhbRdHt/aH7yAsXhyg1KzG+91QZ
         ZujyiiAg33R8gqQSltbXAXhAlC2JQns0ROozJgEnpr41gxG7tNqcbKE74ReKRnm8F3bL
         RoFA==
X-Gm-Message-State: ACrzQf27RU8J7MCFKFS1u7zkAjY98FQfGS5HxC62M/G7D1ypcvz7TKEq
	TzTggT1YSGaQDqwwFLGCQis=
X-Google-Smtp-Source: AMsMyM7DChjcxcQ05YM1UPiqeTWc90XICrCceCVpbT8ax1IaDzOSdV3dn3C0H8CbRGzvxdyjpdIRYQ==
X-Received: by 2002:a05:6638:13c1:b0:35a:54e8:a388 with SMTP id i1-20020a05663813c100b0035a54e8a388mr11985045jaj.268.1663713674992;
        Tue, 20 Sep 2022 15:41:14 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::a533])
        by smtp.gmail.com with UTF8SMTPSA id q12-20020a0566380ecc00b00349cee4ef4asm394392jas.62.2022.09.20.15.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 15:41:14 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Sibi Sankar <sibis@codeaurora.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 2/2] iommu: arm-smmu-qcom: add sdm670 compatible
Date: Tue, 20 Sep 2022 18:39:56 -0400
Message-Id: <20220920223955.151507-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920223955.151507-1-mailingradian@gmail.com>
References: <20220920223955.151507-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string to
support it.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b2708de25ea3..bf9653b9eb89 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -431,6 +431,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8180x-smmu-500" },
 	{ .compatible = "qcom,sc8280xp-smmu-500" },
 	{ .compatible = "qcom,sdm630-smmu-v2" },
+	{ .compatible = "qcom,sdm670-smmu-500" },
 	{ .compatible = "qcom,sdm845-smmu-500" },
 	{ .compatible = "qcom,sm6125-smmu-500" },
 	{ .compatible = "qcom,sm6350-smmu-500" },
-- 
2.37.3

