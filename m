Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384702CA4
	for <iommu@lists.linux.dev>; Mon, 13 Mar 2023 16:47:51 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id d36so16516689lfv.8
        for <iommu@lists.linux.dev>; Mon, 13 Mar 2023 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678726069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H/Xng2L0Nis9bfcRngZjnYKolZIpIcLii2KfuUAhG9w=;
        b=SBP3GdlgbK6AYF6nVDhkX7eVTZqx1J2dBpyxxNddA57rFzy4BZmTNYmtmkbnCKotzY
         sdnzZDi/CaElBYvCa84hQJSN0DFLAEI+h9uqplNBHwZy2mkNHkk/w4WYIKusdARaCLzb
         OLNvyJccRhChqef6QVKxFxpoczV0HmNlJpl1XmnRKwheIVB4DZRIfGO4up9AqfA/FLz7
         sZuJTYNeGUzg/20faZe21N5PH9sl+9Hhc9a5s510yphLcte/eJW/A/rfJvN5T2dETBdy
         wxujlUloBkFgNc1eV4esqHUPfIejznbuHmZt7hfMqzVv3cU1ryZ28MRBE/4AFGIS1XGf
         CrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678726069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/Xng2L0Nis9bfcRngZjnYKolZIpIcLii2KfuUAhG9w=;
        b=WRSOzEEZO7hHbWHHsxqU6pkbyGUJmTkvHVYeFHbE+DRATtVeQA7s6uB+MWtFV9B7Ut
         3aCDltThyG/ri/FxA55rVr//IsQEEr2G+xaFv18hr8IPquFx9ZWLIq0XAZ90kTckH1NR
         MRtGe/Zqu63ZRiNo4vDd9RewadC3UD3T/4JHXH72LSxOFaRxw+0jVrx5CsRQs+0J0KDO
         YKgNRmLlpWVzKNp/vRQtNOs5N8c9QduPJvE3uSH9oxCZ8MvXs5827VDpA+m+rB8Riz/g
         kHi/3OEreKFU3wT26F2QD3t0DIROOMCB9DvbWDHGqtO4Vs8mwQrac/G+EU3Yn7CMEXlB
         eFnA==
X-Gm-Message-State: AO0yUKVXNuhi/wgKD48BWa9kdAzf1f94qIlf74LC83s3uG9Sy+Q3PczD
	v+WrMpM0sBI9Cy+E7tZGD0mAsg==
X-Google-Smtp-Source: AK7set9iLcaH1qw5uFITqV5UI/uvee9wg1vWLJ3XeokSHZEBSBobWGYbvYXKxKAP85hVOi4pAd6rJw==
X-Received: by 2002:ac2:54a7:0:b0:4b5:70e0:f2e6 with SMTP id w7-20020ac254a7000000b004b570e0f2e6mr3246542lfk.24.1678726069196;
        Mon, 13 Mar 2023 09:47:49 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651238a900b004db48ae69cbsm18134lft.206.2023.03.13.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:47:48 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/6] Clean up Adreno SMMU bindings
Date: Mon, 13 Mar 2023 17:44:15 +0100
Message-Id: <20230313-topic-gpu_smmu_bindings-v3-0-66ab655fbfd5@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9SD2QC/x2N0QrDIAwAf6XkeYJTkLJfGaNEm9pAm4qZY1D67
 5M93sFxJyhVJoXHcEKlDysf0sHfBkgrSibDc2dw1nnr7968j8LJ5NIm3fc2RZaZJasJFpdxxBB
 cQuh1RCUTK0paey9t27oslRb+/nfP13X9AHNYa+d+AAAA
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678726067; l=1268;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=f4B1yJzVBbsZqehz8JLbHpySiLGAvrTlDRteS3PGcW0=;
 b=0ksZnyi/nnvCpvu93COpZxIxLAkofAIO0o8CMs9a6YKsMYcpaqt99maJN0Bj97+fqQDOYqcQtkJ6
 HsLVAj2ED/WYQcvwwtZkIiRID9VdiI2IypPjtTHnfkJR+PzOZ6Fn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

v2 -> v3:
- Pick up acks
- Fix the "arm,smmu-500" typo in bindings (Rob)
- use b4

v2: https://lore.kernel.org/lkml/3aa78b15-8e6c-9657-0d08-0d0452d51fbe@linaro.org/T/#md7074966fdcbbd884baf62153f726bec54b2e819

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (6):
      dt-bindings: arm-smmu: Use qcom,smmu compatible for MMU500 adreno SMMUs
      dt-bindings: arm-smmu: Add SM8350 Adreno SMMU
      arm64: dts: qcom: sc7280: Add qcom,smmu-500 to Adreno SMMU
      arm64: dts: qcom: sm8150: Add qcom,smmu-500 to Adreno SMMU
      arm64: dts: qcom: sm8250: Add qcom,smmu-500 to Adreno SMMU
      arm64: dts: qcom: sm8350: Add qcom,smmu-500 to Adreno SMMU

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 15 +++++++++++++--
 arch/arm64/boot/dts/qcom/sc7280.dtsi                  |  3 ++-
 arch/arm64/boot/dts/qcom/sm8150.dtsi                  |  3 ++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi                  |  3 ++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi                  |  3 ++-
 5 files changed, 21 insertions(+), 6 deletions(-)
---
base-commit: 24469a0e5052ba01a35a15f104717a82b7a4798b
change-id: 20230313-topic-gpu_smmu_bindings-60af88a662ca

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

