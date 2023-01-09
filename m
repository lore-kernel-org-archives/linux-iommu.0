Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB73C25
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 17:45:34 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id t5so4594540wrq.1
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=48ftCATxHgOiOe6xbKGx2ZiY6n3+BUStS7/be/RWXjo=;
        b=uIyVlkZMW/HK5vBfVUvOkqrToPfP556HNThca4pQQfYpADbQsZh5bnOZnXrlQfuh/x
         OJTgZXPMIBFwIfeEC5Ekj8YBKMs5TNSSH+vlvtRMzYbi3ZiyT7ik8GFNE/Q02NRjJJ80
         oUhRleC0eXkskPsDGH4RiF43IlSg8LaEJfGCM8orW5aCQvFkjxGmSC2OpKBNJ+/LAbcb
         nWe8Yj304C1lxFOJrm4q+sRmQjgXnQ6ocZBohOnptfyNLB0MEOoaa5gyTd8A2NmJCuPA
         Wa7Ix6RAJXjybmvcDRC0hM1dcXhlF7c6AdvnlRAXYCY4Enr8AoxyphhTL46nl07TPwbU
         kpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48ftCATxHgOiOe6xbKGx2ZiY6n3+BUStS7/be/RWXjo=;
        b=EXZavI0OE+4JNbV1QXRH3mkRz5AS2sHEbZ9X+ybVfCWLIbTy/LLMCh4QkABEXlnWCx
         Y7EMRzuskKUdaPYgw6Id0mH64EkTsVdIhsue/m/0PozGcWa+NplONiwNDWRpJwWPVWir
         Yb59dGNHcg5TIGqoB47sA0qantfkEZY9tET4/PXjadAztYBwP1nI2PCltXKb0kUe9fpJ
         ID/dyNaYls5JxRwUn4E6VlpnbjBFNcNvurYRHgzRZUGFYjmqhtOwYmJ3uDJbghMfe9Yj
         YD3Qsm95knmkA0VemBeHIEa1/xqOD2abFB3TpLzApIUg8uTqTyJhZon8DK52YIKt34Pf
         RYMQ==
X-Gm-Message-State: AFqh2kqF0Um6peVOfDSv4VOn/ln9WWoCpk1yq3PSbkjX5JP4+zQEaeUe
	PFYbSePm2AN0UaStW/DL8lZCTw==
X-Google-Smtp-Source: AMrXdXu9JkiYxSufEml13EpQTB0wBLF4UHrsBsfZhlYDworiPjQZ/MQb2g6EnCJfiC/KysHLez8NFg==
X-Received: by 2002:a05:6000:1e1a:b0:290:968:f1ac with SMTP id bj26-20020a0560001e1a00b002900968f1acmr25786641wrb.33.1673286332425;
        Mon, 09 Jan 2023 09:45:32 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c88:901e:c74c:8e80])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm6142902wrv.113.2023.01.09.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:45:32 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 00/18] arm64: qcom: add support for sa8775p-ride
Date: Mon,  9 Jan 2023 18:44:53 +0100
Message-Id: <20230109174511.1740856-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This adds basic support for the Qualcomm sa8775p platform and its reference
board: sa8775p-ride. The dtsi contains basic SoC description required for
a simple boot-to-shell. The dts enables boot-to-shell with UART on the
sa8775p-ride board. There are three new drivers required to boot the board:
pinctrl, interconnect and GCC clock. Other patches contain various tweaks
to existing code. More support is coming up.

Bartosz Golaszewski (15):
  dt-bindings: clock: sa8775p: add bindings for Qualcomm gcc-sa8775p
  arm64: defconfig: enable the clock driver for Qualcomm SA8775P
    platforms
  dt-bindings: clock: qcom-rpmhcc: document the clock for sa8775p
  clk: qcom: rpmh: add clocks for sa8775p
  dt-bindings: interconnect: qcom: document the interconnects for
    sa8775p
  arm64: defconfig: enable the interconnect driver for Qualcomm SA8775P
  dt-bindings: pinctrl: sa8775p: add bindings for qcom,sa8775p-tlmm
  arm64: defconfig: enable the pinctrl driver for Qualcomm SA8775P
    platforms
  dt-bindings: mailbox: qcom-ipcc: document the sa8775p platform
  dt-bindings: power: qcom,rpmpd: document sa8775p
  soc: qcom: rmphpd: add power domains for sa8775p
  dt-bindings: arm-smmu: document the smmu on Qualcomm SA8775P
  iommu: arm-smmu: qcom: add support for sa8775p
  dt-bindings: arm: qcom: document the sa8775p reference board
  arm64: dts: qcom: add initial support for qcom sa8775p-ride

Shazad Hussain (2):
  clk: qcom: add the GCC driver for sa8775p
  interconnect: qcom: add a driver for sa8775p

Yadu MG (1):
  pinctrl: qcom: sa8775p: add the pinctrl driver for the sa8775p
    platform

 .../devicetree/bindings/arm/qcom.yaml         |    5 +
 .../bindings/clock/qcom,gcc-sa8775p.yaml      |   77 +
 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/interconnect/qcom,rpmh.yaml      |   14 +
 .../devicetree/bindings/iommu/arm,smmu.yaml   |    1 +
 .../bindings/mailbox/qcom-ipcc.yaml           |    1 +
 .../bindings/pinctrl/qcom,sa8775p-tlmm.yaml   |  142 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |   39 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  841 +++
 arch/arm64/configs/defconfig                  |    3 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   17 +
 drivers/clk/qcom/gcc-sa8775p.c                | 4806 +++++++++++++++++
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/sa8775p.c           | 2542 +++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    |    1 +
 drivers/pinctrl/qcom/Kconfig                  |    9 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-sa8775p.c        | 1649 ++++++
 drivers/soc/qcom/rpmhpd.c                     |   34 +
 include/dt-bindings/clock/qcom,gcc-sa8775p.h  |  320 ++
 .../dt-bindings/interconnect/qcom,sa8775p.h   |  231 +
 include/dt-bindings/power/qcom-rpmpd.h        |   19 +
 27 files changed, 10776 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sa8775p.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p.dtsi
 create mode 100644 drivers/clk/qcom/gcc-sa8775p.c
 create mode 100644 drivers/interconnect/qcom/sa8775p.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sa8775p.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sa8775p.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sa8775p.h

-- 
2.37.2

