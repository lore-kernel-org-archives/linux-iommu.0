Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA2215A5
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 12:59:16 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id gw11-20020a05600c850b00b003f07d305b32so5336155wmb.4
        for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1681217954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gVuMmsSUuik77Ijx/8EU9TNPivGbNCZ9khKZD4i9/BM=;
        b=ZNuwfNHT1p/L4mQ0ZKMicW8hWuIsz23tQW+92LtMGchp7cQfdHi55p/378Z65ZNORl
         5wA/raAbIQ+z7XxlNbE65524TZQE9Z7dvQO/hs7lHAunBYZlFFMxcS2O2WUpETnnO9UH
         oW7yjNgm8VW/3XEBEEriKW4GSpvJzu+VxGvT+I3t9yMlDKn7wOAKBanGiWijKhshS8yw
         du040ueDH5DdkeR1iCqcuXOtzN2i5OE/oNryHRwqzcCdi4dUNYJbF+lYwe8gZ7o9vZ50
         iL7ilCvX306s+8CeSaQxzTH4TfcmyD2iP70nIj51mqqbIIgk0FiCtKfiaVB/NeRc66HP
         RWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681217954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVuMmsSUuik77Ijx/8EU9TNPivGbNCZ9khKZD4i9/BM=;
        b=1BJFJRKgxbSXXay9x1bWBK8z4cZtoe6HR2GIwBr+n14jKdrWlq7sxs0bp2aqfFhs9t
         mHdc+iI0843wAiYgJbMta4Np6vfMMmDcgOReJ9FHKjYesODt1ik4A+lSy6eynabh6nf7
         JqNoYZP0RJ8rMYXgAJU7Zr2TxXqfA1wYtpsO2MIP9aTspJf2vKxsHDoekVQhpA3k7+Fx
         ZEi3aMe2y38kWG6XVuww5Ii8URNxfCf/qcJnc02pP8E0coLi26eGPs3Wz+mNC5H1b8VX
         oRPf4VkanMoxaau68+jemMSl6IV2/lKt61YlbWC98JGWPNNHj69GnACyKPTzgskhk8hD
         IzuQ==
X-Gm-Message-State: AAQBX9djURfC4qcHIHLFxEon81VMSsLIK8uo/62IO+iy/VeGbUvkARoM
	VU5M1gaMuSWuXJrwv3/q+wPvAw==
X-Google-Smtp-Source: AKy350ZFwGmF0uWrr2tG/BrpiE90COQA60InF2b3iXCaBkZ98ODQnmuu5K1WHIogyJwqSY4ZJbpkTQ==
X-Received: by 2002:a7b:ca54:0:b0:3eb:39c3:8844 with SMTP id m20-20020a7bca54000000b003eb39c38844mr9829158wml.12.1681217954605;
        Tue, 11 Apr 2023 05:59:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a099:fc1d:c99a:bfc3])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003eae73f0fc1sm16944591wme.18.2023.04.11.05.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:59:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 0/7] arm64: dts: qcom: sa8775p: add more IOMMUs
Date: Tue, 11 Apr 2023 14:59:03 +0200
Message-Id: <20230411125910.401075-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the GPU and PCIe IOMMUs for sa8775p platforms as well as the required
GPU clock controller driver.

NOTE: I didn't pick up Krzysztof's tag for patch 4/7 as the patch changed
significantly.

v2 -> v3:
- select QCOM_GDSC in Kconfig for the GPUCC module
- the GPU SMMU is actually an adreno SMMU so describe it as such and
  fix the DT
- fix the mapped memory size for the PCIe SMMU

v1 -> v2:
- remove unused include in the GPUCC driver
- remove unused clock from the GPUCC driver and make it compatible
  with the generic QCom GPUCC bindings
- put the new defconfig option in the right place (as per savedefconfig)
  and make the GPUCC driver a module rather than built-in
- describe the smmu clocks for sa8775p in dt-bindings

Bartosz Golaszewski (6):
  dt-bindings: clock: qcom: describe the GPUCC clock for SA8775P
  arm64: defconfig: enable the SA8775P GPUCC driver
  arm64: dts: qcom: sa8775p: add the pcie smmu node
  arm64: dts: qcom: sa8775p: add the GPU clock controller node
  dt-bindings: iommu: arm,smmu: enable clocks for sa8775p Adreno SMMU
  arm64: dts: qcom: sa8775p: add the GPU IOMMU node

Shazad Hussain (1):
  clk: qcom: add the GPUCC driver for sa8775p

 .../devicetree/bindings/clock/qcom,gpucc.yaml |   2 +
 .../devicetree/bindings/iommu/arm,smmu.yaml   |   6 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 125 ++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/qcom/Kconfig                      |   9 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/gpucc-sa8775p.c              | 625 ++++++++++++++++++
 .../dt-bindings/clock/qcom,sa8775p-gpucc.h    |  50 ++
 8 files changed, 817 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/qcom/gpucc-sa8775p.c
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-gpucc.h

-- 
2.37.2

