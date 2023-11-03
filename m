Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C922EEF
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCnLjbvS"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-507d1cc0538so3369537e87.2
        for <iommu@lists.linux.dev>; Fri, 03 Nov 2023 15:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699052054; x=1699656854; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umt0TPj4nshu0V3EQdMVsdcmvgrR/dSt/qtZRwkMkUE=;
        b=hCnLjbvSutoMBR1q5alF2DcVFHY84x4dqWcXai5KT5VbVOoN2rkZe6jShYZzxs/BLb
         +/cxOabWp6EFAtjX6HIUcprzyRxb/GNgcSbMZixlP+hCEehOxvH7shgIZmVBgr0LfVC+
         5xEY6eM+YT1xMVuB7Ed8sYfPxjNefEW9wpOG33R49oC6G05LDxrAPhVviYogXTm6G42r
         tVFhuM+FOEtWequ4W0qUkys0LSdm8fWH/PiqQjiItcqcnUKP/DvAq8I8ene9vDnDB5O2
         WTK4PhT1u/ZC3S2UCUHAA639FTpDR7XGL/hhW410oieasqotKRhqMPFQFa6vFPFq8y1z
         HGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699052054; x=1699656854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umt0TPj4nshu0V3EQdMVsdcmvgrR/dSt/qtZRwkMkUE=;
        b=a51L6jGUb5M88mNHf4FPNpcZfMUg6lhpI3BeesfpyHyicqahEE9haZZUW2JFY/lghs
         8Uvcb3ryttekCXWqtG1sb3xadur8l0ebZEt0G3hT45azQE+D/Dbw2wTb74jf9HEdJ2JN
         kmyQXIDBzc/IeoFyHJ56XjqCJyOAJtWSQaZAV3fz51zxwBcR0uZgIq3MWGqTT8e4Gkqc
         NvRgGAyLQoX6/+iEJOeK884Q8Zc8u1jeVXvLtTVbS9t0TfOeIBNqDNkGAUaHsHWtJG82
         9gw/QSqHQqQ5q6ortapduL2OkE271vaE2Y6xtoRRZRgqhSfqTP7HTE0m3TI5xpIzgq2b
         u87g==
X-Gm-Message-State: AOJu0YywO8S07/TcPY/ul0cDsHDI6wyRiT3Q0deA9c//h/ZL3VmEKPxe
	t6q0mJlt6SzsNRBZ7eWAVi/WXw==
X-Google-Smtp-Source: AGHT+IEHhxBChb8k7T5rMq/zqfWwHN4Qghq3nc3Rm/+b0JrtGnrBUumdbXfZLWSA6oxuGMW4srCyJg==
X-Received: by 2002:ac2:5935:0:b0:503:1be5:24eb with SMTP id v21-20020ac25935000000b005031be524ebmr15688875lfi.50.1699052054588;
        Fri, 03 Nov 2023 15:54:14 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id i10-20020a056512318a00b00507aa6ab0ecsm335202lfe.248.2023.11.03.15.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 15:54:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: list all Qualcomm IOMMU drivers in the QUALCOMM IOMMU entry
Date: Sat,  4 Nov 2023 00:54:13 +0200
Message-ID: <20231103225413.1479857-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For historical reasons the 'QUALCOMM IOMMU' entry lists only one
Qualcomm IOMMU driver. However there are also the historical MSM IOMMU
driver, which is used for old 32-bit platforms, and the
Qualcomm-specific customisations for the generic ARM SMMU driver. List
all these files under the QUALCOMM IOMMU entry.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a7dc3e56e1e..ed1c864794aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17888,6 +17888,8 @@ L:	iommu@lists.linux.dev
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/iommu/arm/arm-smmu/qcom_iommu.c
+F:	drivers/iommu/arm/arm-smmu/arm-smmu-qcom*
+F:	drivers/iommu/msm_iommu*
 
 QUALCOMM IPC ROUTER (QRTR) DRIVER
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-- 
2.42.0

