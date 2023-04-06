Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E00AD47
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 20:07:50 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id l12so40630488wrm.10
        for <iommu@lists.linux.dev>; Thu, 06 Apr 2023 13:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1680811669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SImv1Rdk/+kE5EteKBqsurf3m5xVNf7BO/4yX5HUIM=;
        b=WjeHYe0vmiAkeua0VT7ZVcJlF+Tnlz4iYE2OEXOy+OvmP4Ud89Kz7xAz4rtag4h26a
         I23SMRAiz7875kUZ5VCa8FysC35Ny5SWMXJKEQSfiXc6Am4pHX6PwpZor8IFq/Ipinu1
         wfOUcEhsShJfMew+6uQyu5WY1RKRBgdWNjJYy8kS8jWboL05splsbv/yjipH0X23f0wC
         sBmZ3lb5ye8WmgEx1l6gS8DyA1OI/imHst38pOe5px8cA5BqNsCOKyIzEJo+XyCc/HBk
         hhVB7hV4hGxRxTR/YweB1sXuSlYvzdnS9TeWrVDbbyDzKcc06/cWX6y5wgXjaZyJ3TML
         OEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SImv1Rdk/+kE5EteKBqsurf3m5xVNf7BO/4yX5HUIM=;
        b=ByU37eqG/nT2fcDoPtL8XidwcaHI/cAeXLcWa5sN9KhGGKmIl03m6V5wKfN2ELzp1h
         GucD0TzGUXfEXa9LuJcx7WgigergL/jbxKo6kablTlmT0F2/f3AVCI74AT8yMq/rkWNG
         sd5Pn/uBM1ETWEpTbc2gDlSNffyBj1Cg++KWtlr+6mBoBy4lKK+Vw4MYIBtlCAKWKHjc
         5EXbbtF2Nn9nxT6wMyK2w9Lrkp9lNPqnG362oWwmgDExI499z0p3SH054y0GCRPxblZS
         r8NBYN4uC27KnODqQvnuYyIrK2CjSk4CZ56Z+YhDLpepPFw3zwzoioV/ygygbjYaFXib
         auIQ==
X-Gm-Message-State: AAQBX9cOAWHfHrI05rtn4NiUAHcO8mm1KWKJdz6sjQOCCQi46OrDNkXE
	DKy/W8ysgIS0MLybV6lK+xONoA==
X-Google-Smtp-Source: AKy350aqh8Akw7hp7e53sm6ji/MH7B41I+AjfxnjeOwFkxczT7A+0E2LkoY06UBce0pl07AQwayx1Q==
X-Received: by 2002:a05:6000:508:b0:2d7:89ce:8319 with SMTP id a8-20020a056000050800b002d789ce8319mr6475533wrf.27.1680811668794;
        Thu, 06 Apr 2023 13:07:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4793:cb9a:340b:2f72])
        by smtp.gmail.com with ESMTPSA id c11-20020adfe74b000000b002d89e113691sm2560506wrn.52.2023.04.06.13.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 13:07:48 -0700 (PDT)
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
Subject: [PATCH v2 0/7] arm64: dts: qcom: sa8775p: add more IOMMUs
Date: Thu,  6 Apr 2023 22:07:16 +0200
Message-Id: <20230406200723.552644-1-brgl@bgdev.pl>
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
  dt-bindings: iommu: arm,smmu: enable clocks for sa8775p
  arm64: dts: qcom: sa8775p: add the pcie smmu node
  arm64: dts: qcom: sa8775p: add the GPU clock controller node
  arm64: dts: qcom: sa8775p: add the GPU IOMMU node

Shazad Hussain (1):
  clk: qcom: add the GPUCC driver for sa8775p

 .../devicetree/bindings/clock/qcom,gpucc.yaml |   2 +
 .../devicetree/bindings/iommu/arm,smmu.yaml   |   5 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 124 ++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/gpucc-sa8775p.c              | 625 ++++++++++++++++++
 .../dt-bindings/clock/qcom,sa8775p-gpucc.h    |  50 ++
 8 files changed, 814 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/qcom/gpucc-sa8775p.c
 create mode 100644 include/dt-bindings/clock/qcom,sa8775p-gpucc.h

-- 
2.37.2

