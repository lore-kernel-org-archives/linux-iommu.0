Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779229A0
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 18:44:23 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id g12so29708778lfh.3
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9I1z4AXsJK+25P06vSnuu3hIZEjku7ef8TqnyD4Aqg=;
        b=kTDv3XtmSj8ZzEhElD+tS6kV/E5rjqnEgwJn+7OtiDgaoylq7zpGu0O8MsV6YUggqZ
         tpoR7YynzbGW8BD0B0/UuAIE45M6gqQ/QoVDCinax2fD7nl54xrTH6lMwTC9ZlxNIYUr
         +/gLjkbwGIac99WXTE1xsNir/QYRDCCahPRSLYhR2Q1fYoksslmTLMH+ImFxUYv5e1x7
         uA4RKNM482d0SL/u3Sakay2t8ryF0pezayc0lb/ZgxbkAyz3TvYU3X0yEI6tWgpNQZ7H
         uQdFIYxdSZL4Bfy60szDSIzNerJ7fz/TUlwQN46zBj/z2yK5gbEXKEKdNj0Ag3Fw8LyB
         u9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9I1z4AXsJK+25P06vSnuu3hIZEjku7ef8TqnyD4Aqg=;
        b=FDnHUC9SjFhLLMMzRPfrV1BvL6RbYKCixUgpvprtgcKh7V37K5bH/6IloOLi54C+st
         TIe0z3E4DtapBy7yutiuHiTHIb//OkTK5Ageq/T7XTd7hoFe1sgNIF9Igi2F988DTGYV
         f/QGK2SUTv92DsdpgIJm3+pdgRB4r8MpRJ9uFSR4w7HZ3YIgXpSNDsZF+bsdy1v8/HOM
         RPbxy5Jgbea0QRHhjfhRfNArDQirh6MN+Yaapj5ILLCn6IVwmwCvAd2AwdJxN226mZXQ
         JIpYgWFrn+d5zpcSauMt39q7M6HsHRisNhSw9v8HPBo8xX0k5pwIvb50PD3smaErLcqo
         4OLQ==
X-Gm-Message-State: ACrzQf1J7DRfpoJ0rOWwlKjP+M8rqp/mU2Hqh3+eHLNDOm4uDH5ZC8Sy
	UOwN4Q5xd4FMXkiwBSruWX6XnQ==
X-Google-Smtp-Source: AMsMyM5KhE+waYR30gx/0w7uAuJpT6jJfFha4iriDSYOuqxv78t3C1EPaBfdCNkuA9y8K6jwgl3ddQ==
X-Received: by 2002:ac2:4d2e:0:b0:4a4:7ed0:76c0 with SMTP id h14-20020ac24d2e000000b004a47ed076c0mr9309861lfk.240.1667414661707;
        Wed, 02 Nov 2022 11:44:21 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t8-20020a05651c204800b00277092c03e7sm2277540ljo.33.2022.11.02.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:44:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: [RFC PATCH v2 00/11] iommu/arm-smmu-qcom: Rework Qualcomm SMMU bindings and implementation
Date: Wed,  2 Nov 2022 21:44:09 +0300
Message-Id: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main goal of this patchset is to define a generic qcom,smmu-500
binding to be used by newer Qualcomm platforms instead of defining each
and every SoC line with no actual differences between the compats.

While preparing this change it was required to cleanup the existing
bindings and to rework the way the arm-smmu-qcom implementation handles
binding to IOMMU devices.

Changes since RFC v1:
 - Added the dts patch fixing order of clocks in msm8996.dtsi
 - Fixed the DT bot errors
 - Added separate clause for Google Cheza devices

Dmitry Baryshkov (11):
  arm64: dts: qcom: msm8996: change order of SMMU clocks on this
    platform
  dt-bindings: arm-smmu: Add missing Qualcomm SMMU compatibles
  dt-bindings: arm-smmu: fix clocks/clock-names schema
  dt-bindings: arm-smmu: add special case for Google Cheza platform
  dt-bindings: arm-smmu: Add generic qcom,smmu-500 bindings
  iommu/arm-smmu-qcom: Move implementation data into match data
  iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into
    qcom_smmu_create
  iommu/arm-smmu-qcom: provide separate implementation for
    SDM845-smmu-500
  iommu/arm-smmu-qcom: Merge table from arm-smmu-qcom-debug into match
    data
  iommu/arm-smmu-qcom: Stop using mmu500 reset for v2 MMUs
  iommu/arm-smmu-qcom: Add generic qcom,smmu-500 match entry

 .../devicetree/bindings/iommu/arm,smmu.yaml   | 172 +++++++++++++++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  31 ++--
 .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  |  91 ---------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    | 156 +++++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h    |  21 ++-
 5 files changed, 307 insertions(+), 164 deletions(-)

-- 
2.35.1

