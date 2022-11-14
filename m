Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1C0748D
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 17:06:38 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id a15so14040279ljb.7
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6guTtDkA1ReGKdqMu1CmE/t+c1qdwq/DIe8B70Maw4=;
        b=lXt9G05aMbjIX8SyJJmKxQQbhZbT47qR3PDriRUC/rwgstPI+MLj2IFqwqUnpZ5tU3
         ayjVTb6PpWhS+A2bV67A6/YDG2ql+DBZdtCwwlg62vZCFRODHCAhjZhgjgpGa98zlYua
         pL4KZFtycsD2vkES+aMG8bJdCT7dTW0auwFq82bVlk19ckcJuRjI6UU/glPoHnmz6cxY
         NfXglJ+Do9C4CJB0/BTKUhGIexhuMIfUFhFq03SoKV+AvchXxYvb9NdZmYk9WJ0sWRtW
         7OugrtBlrqzWa9ZLPsxTLLo2jyE5UOP05RpTJR8nfJQYf/Qe6TAG+tddDgln383CNe5N
         7GIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6guTtDkA1ReGKdqMu1CmE/t+c1qdwq/DIe8B70Maw4=;
        b=RR2cdz6j+WkM1l3inkW+nJC3QKw6fBnboNF+wqxWIb7h10XOiHeoTaooTVBhhjZNBb
         0DdK0fkYJc8OOZsr06Ee2IszPj3iKP5yP5B0JriyyH0TAZ7qwr5bscf9aaI41ngRwPgE
         kbn/+i5sSgRIreGn4C3uQhNT4aGlOoRDYF5EkDlNxcgLXrO97qLpxN8Szh0BsrD9Q9EN
         KiKma3sqBwDz6QNFcF96ooOqP9iKgifAiPQ1+YRVnYQroSyc8PPEZnH0I6fmYUrPPO4K
         Yd81IgLNLMxveZ9p3jgvbtPrCFJQvXAwkVOHTIL8dv5VsSR0bnEnEt+CiOf+IxhB1i1c
         Rdjg==
X-Gm-Message-State: ANoB5pnz0sJRhkV2m7Z4PQthXgeF1ch2dMvWB/tpxSpZQST9uBsaWdni
	XmQmJ1Zig1t3ch9Xi5AFyV1/PA==
X-Google-Smtp-Source: AA0mqf7mzNaaz3n1mkr6Lj1F4uek+u1lXPv2BxwOoadDwOtOhQ+ybNFAsCQDUPJniHl3xDGMrg1xYw==
X-Received: by 2002:a05:651c:194a:b0:277:9e5:6cc9 with SMTP id bs10-20020a05651c194a00b0027709e56cc9mr4916409ljb.165.1668445596544;
        Mon, 14 Nov 2022 09:06:36 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q7-20020a056512210700b004a2ae643b99sm1896344lfr.170.2022.11.14.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 09:06:36 -0800 (PST)
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
Subject: [PATCH v1 00/10] iommu/arm-smmu-qcom: Rework Qualcomm SMMU bindings and implementation
Date: Mon, 14 Nov 2022 20:06:25 +0300
Message-Id: <20221114170635.1406534-1-dmitry.baryshkov@linaro.org>
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

Changes since RFC v2:
 - Dropped the dts patch, picked up by Bjorn
 - Fixed minor nits in commit messages and in-file comments (noted by
   Krzysztof and Richard Acayan)

Changes since RFC v1:
 - Added the dts patch fixing order of clocks in msm8996.dtsi
 - Fixed the DT bot errors
 - Added separate clause for Google Cheza devices

Dmitry Baryshkov (10):
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

 .../devicetree/bindings/iommu/arm,smmu.yaml   | 173 +++++++++++++++++-
 .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  |  91 ---------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    | 163 ++++++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h    |  21 ++-
 4 files changed, 298 insertions(+), 150 deletions(-)

-- 
2.35.1

