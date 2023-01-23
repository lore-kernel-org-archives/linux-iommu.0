Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937E1C2D
	for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 13:19:46 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id i1so8743189pfk.3
        for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 05:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vf7HzZ2FzkJA9LCsnYBUI4BkmATEeS0RRCfbvDc3nIY=;
        b=Hp0RYxiU9r6fKa4c9nXygqj5qT8I3r2Z5/IE/RMPEZb59UGqle4JKAuU+bD6Ab9P2/
         sz+3Mw9p3ZjnSTBAdCVrNfyI3LQ/2hAbo23McNNiCiJPQjILquC25IUCFCddi6e27LsW
         cyuGLDyufrMzu1Pio0MqG3tReKCmZ0hfEL3AZe3LcnRhabOwP7SKKTuEIxc3McbaqnaP
         /67XuYyLh2p0tAak8lTLKR4cXDXxEvRXcEQ5zpuaK9teJE23vye1O0l6idOn/h2CXByo
         9YlCHx6sfbrslO9s2v9xSlDcidjCsKqMaIm6zKQgvl37g4CijAnUms0CHSK2j+0pbJaF
         CwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vf7HzZ2FzkJA9LCsnYBUI4BkmATEeS0RRCfbvDc3nIY=;
        b=Adp5CHgV+JfZv8i16YLgIsmB6ka+MMbw2UsSI7QCJRtt3QZKpwYnjaZWj14P9blA0K
         xcM/e/rhOxk291XBM0ea6YUAUA/9EQKbswYHNBruXGP0DrELB1sAC2vbNPDc2HeNsjiY
         Pqn+kufFzDnjuqaT576fAYTtzrt0G+QWAIxfKKycxZ6ZLRNrpg/6PPCQSUDDHUUS0DM0
         wegnPgGDS/7cUuz277aeE47wx3CrZITXRNTQE5O5jeVlf0z942nXXXz+SEVlVra6rDdU
         74OlmfaRv+92o7qg1tUt2FfP82DhQz4RD7d0DplascUa82AdJzFt/Rhn2gkrI64SJ7zY
         AQTQ==
X-Gm-Message-State: AFqh2kr+HD7rtBb4txXvvnco67PBByCjZahAJl4ugPi4890hqJF6zdV+
	bA5/CD7XHoTtnMWQLj8fqfD9
X-Google-Smtp-Source: AMrXdXsJLGGXaN/t/4PztX3ojVUGGW+Zsrq8vCocR2JCax+6ki5jOtam2EEraVZdqhmJK5bRXYz8VA==
X-Received: by 2002:aa7:982b:0:b0:58b:4ae0:c761 with SMTP id q11-20020aa7982b000000b0058b4ae0c761mr24838899pfl.34.1674479985718;
        Mon, 23 Jan 2023 05:19:45 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm30818783pfl.146.2023.01.23.05.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 05:19:44 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	will@kernel.org,
	joro@8bytes.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: konrad.dybcio@linaro.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	dmitry.baryshkov@linaro.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/3] Fix SMMU on SDX55 and SDX65
Date: Mon, 23 Jan 2023 18:49:28 +0530
Message-Id: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Both SDX55 and SDX65 SoCs are using the Qcom version of the ARM SMMU-500
IP. Even though the SoC specfic compatibles were being used in devicetree,
the compatibles were not added to the arm-smmu-qcom driver. So they end up
using the generic ARM SMMU-500 driver instead.

Spotting this discrepancy, the recent arm,smmu bindings change moved these
SoCs under the non-qcom implementation of the SMMU.

This series fixes the binding by moving the compatibles under qcom impl.
and also adding the "qcom,smmu-500" fallback compatible to the devicetree
so that the qcom implementation can be used without adding SoC specific
entries to the driver.

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: arm-smmu: Fix binding for SDX55 and SDX65
  ARM: dts: qcom: sdx55: Add Qcom SMMU-500 as the fallback for IOMMU
    node
  ARM: dts: qcom: sdx65: Add Qcom SMMU-500 as the fallback for IOMMU
    node

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 10 ++--------
 arch/arm/boot/dts/qcom-sdx55.dtsi                     |  2 +-
 arch/arm/boot/dts/qcom-sdx65.dtsi                     |  2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

-- 
2.25.1

