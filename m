Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03D8492
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 09:44:49 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fe655796faso3798197e87.2
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691487888; x=1692092688;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXb3gGUTCuGI9f7CTmhZvudhYCVdkZDKGm57sq75z9A=;
        b=Ur+9mBTZIqc5FyEhZitwY2gYZyQBtNf5UVQHcJ9D+zh75PuCUke0karwttm/9fdf6/
         PyYhZA/8KNb7gRihaKwM4ze28zJi3oiLF4h5zjKuD+vAqvILUGmLXK3DmWwVNaCPvryX
         jmR3HLiP0OjrNGCZrXkqDzsfw2HcwHcU8I1oQlgznGOs58ZuMzWGzCc/mtTHawNI4VsX
         oEla3lxK+ZpR7mOUNGzko97jdnmcBmOxXZR3A6qAiMxO6gEDB3WT48BYmedQrv39Vgls
         mDBj26AW0PWj1veVWc1Tvl8Vw/steOG8uposb5KlLm7J5Fs19tg5d0AL5QJn52dZp5Np
         H/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691487888; x=1692092688;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXb3gGUTCuGI9f7CTmhZvudhYCVdkZDKGm57sq75z9A=;
        b=CkFEhtsmBmsEeziiNemnMrwz2gzYm258QfiJD00JbyMmb7O3LJuJHHAaxM3i4+ABV/
         cpv5IlvE2KSKOZ9J/QTegLED7xLGKVJbA6QLLJX1SG/o5Kdf7yIanwdTHLN9u0MxSaYp
         J/0RgFWf8uZ3KY5vCXHY873KZcKf97z89vAfZ0oxeMIrMi0SmMNtzOK78Odsppc0PKM9
         WSdLxEsk3Gmkxj+DaTbvAA0savxuiDYUBTaQrPWo3xjmTqIJEb70r32RQXQGdNVaT/PW
         ocWbQelhq1r1jConhJzqUv+I016kDlt2gqMoj69JbCJ8t8IvHVh6+7ywYjyaMb6/Pk4/
         Ku9Q==
X-Gm-Message-State: AOJu0YxTttFSA1J3vJR+QAuweBq7aMPXLBETQzgPFx62ePDZWmoG3K5N
	A+cVjpG+IShmHY+V+yMk+aU6EA==
X-Google-Smtp-Source: AGHT+IH+aKb/us+BJrh9hTz6KF/MXtFLXgEfAZaI1uc/X5WOfIfDWEdaa6Uiv+MPqfqqttpgiGhcBQ==
X-Received: by 2002:a05:6512:3ca6:b0:4fe:279b:7609 with SMTP id h38-20020a0565123ca600b004fe279b7609mr9597266lfv.17.1691487887970;
        Tue, 08 Aug 2023 02:44:47 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id i6-20020a056512006600b004fdba93b92asm1818884lfo.252.2023.08.08.02.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 02:44:47 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 0/6] MMCC MSM8998 fixes
Date: Tue, 08 Aug 2023 11:44:40 +0200
Message-Id: <20230531-topic-8998_mmssclk-v2-0-34273e275c51@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIgO0mQC/32N0Q6CIBRAf8Xx3G2AuaAn/6O5Bgh6F4IDczXnv
 0d+QI/nbGdnI9kmtJncqo0ku2LGGArwU0XMqMJgAfvChFNe06ZmsMQZDQgpxWOacjb+Ca6/aO7
 01QnDSAm1yhZ0UsGMJQ0v74uck3X4Pk73rvCIeYnpc4xX9rN/HysDClw3SjgjqZSs9RhUiueYB
 tLt+/4FMewJ3soAAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, 
 Imran Khan <kimran@codeaurora.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Joonwoo Park <joonwoop@codeaurora.org>, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691487885; l=1561;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=APl5fI6CgPz/P+aBiMrAGDV2ER8mxIXa42jNxZTZU0A=;
 b=utcVZVXR/N23ZVDqZiyeYw1eROZHDAt70NBzimNDO1RcNS9XaxCjRcvkl2Ey8pMFL7xr+tFi2
 MSKWoDguWMkDlbEplPK8WDVFypi/F7YhDNuLBVSMMOTLKgCLcnEy8FX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

8998 has a couple of issues related to its clock controllers. This series
attemps to fix some of them.

The DT patch should go in first for bisectability, otherwise
clk/pd_ignore_unused will need to be used, as the SMMU GDSC is no longer
considered always-on.

This series results in less "clk stuck at 'on/off'" messages and should
marginally reduce power consumption.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v2:
- Update bindings
- Separate out the dt patch into two
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230531-topic-8998_mmssclk-v1-0-2b5a8fc90991@linaro.org

---
Konrad Dybcio (6):
      arm64: dts: qcom: msm8998: Drop bus clock reference from MMSS SMMU
      arm64: dts: qcom: msm8998: Add missing power domain to MMSS SMMU
      clk: qcom: gcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
      dt-bindings: arm-smmu: Fix MSM8998 clocks description

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 41 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  8 +++--
 drivers/clk/qcom/gcc-msm8998.c                     |  6 ++--
 drivers/clk/qcom/mmcc-msm8998.c                    |  7 +++-
 4 files changed, 55 insertions(+), 7 deletions(-)
---
base-commit: 71cd4fc492ec41e4acd85e98bbf7a13753fc1e03
change-id: 20230531-topic-8998_mmssclk-fd4b2fb7f8c1

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

