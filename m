Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258C4437
	for <iommu@lists.linux.dev>; Tue,  4 Oct 2022 22:46:25 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id i9so7302129ilv.9
        for <iommu@lists.linux.dev>; Tue, 04 Oct 2022 15:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=lUGmLAO+UyEHxzHYsfZWHoOtdpAGmxoVd+nS8TzFDs8=;
        b=gJfmBcDplWY2FG/9+rfAMBZHoTO2kXKcaA5sPW9YwMR0SXbfNFLp4XQqQCoewAoUBr
         EP9cpMbshZsXLOtqgZaCa0VY8r1aH0jni7544oRGrXKvSAnYei5/GOxSTe8pLDiq9luh
         DQnQnwIjcP7vZcRYCX+UL+M8fzNkDTsYHfQIWkptcqulCslQvWNUgjKINOSts56JXzAE
         Dj8W9zn+3ofri5+eMoAAZcFSpmEOlIaV/XI0y2VFbjyOCsHitD7CNpQO/snwMuZMLv1c
         NFcf58OxrFGhm+cOcmyMENA87e8BfZSrp6iYI1yxlRSaOVL6iqV3ztpH/zedypfXfoga
         ZA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=lUGmLAO+UyEHxzHYsfZWHoOtdpAGmxoVd+nS8TzFDs8=;
        b=SWhzxGF6/mmKxRnlVqNIjfDUf5+l3zpJlDHDyI0NIimXBZ9KENQpgWWSjaVb70JiJj
         44/PUsIdP9qKt9G28crqdEArgZNTe4Uj7bZh5tVrS1u7rr5s8NBUeZpPYNcABz7EaYJ9
         O40z4zwMsRNeXWDoy/nVWXcPm2IO8C6TfgDI1y6LDeNPoBqLfnkoAS7n+zdKyWUBk6Va
         cGCJqz0iDJqOCFJvkvAGGK9xMqxkTL3exbPULMS7MoGUa2ReawUHp/ruSSsc/8T4QjbT
         B+cRvKy6UIclaXrTEluoFexb5mi1ms0YpMNePiYsNQcLIUN/4IhfY9qJ/JOEAJ1gN8ga
         hcuw==
X-Gm-Message-State: ACrzQf1tBCRe9pmoUrYeTRUdzXfw8Pr+zrGHtJi/CRA8Xc7+/LKhCQ0G
	66PrqBMayBx5hi4CYRQH0XGHYHYpAEjvUQ==
X-Google-Smtp-Source: AMsMyM6qIacxLqY4+a9KJy019fK0S8GgSzgU51V8iBUspoS8E0XjiUyC/yJPSvQhQWq4h7PgWqNJng==
X-Received: by 2002:a05:6e02:1bc9:b0:2f1:9ee8:246d with SMTP id x9-20020a056e021bc900b002f19ee8246dmr12835017ilv.246.1664923584568;
        Tue, 04 Oct 2022 15:46:24 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id i9-20020a5e8509000000b006a1f242b529sm6075823ioj.13.2022.10.04.15.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 15:46:24 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Emma Anholt <emma@anholt.net>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rob Clark <robdclark@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] iommu: SMMU for SDM670
Date: Tue,  4 Oct 2022 18:46:17 -0400
Message-Id: <20221004224619.16406-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1 (no emails related to this series since last week):
 - accumulate tags (both were added because it seems like the discussion
   ended in agreement to keep adding compatible strings to the driver)

This adds the compatible string for the Qualcomm Snapdragon 670's SMMU. The
SMMU is necessary for GENI I2C, included in initial bringup because it
doesn't need non-trivial patches except for patches conventionally added
before the initial device tree (global clock controller and pinctrl).

Richard Acayan (2):
  dt-bindings: iommu: arm-smmu: add sdm670 compatible
  iommu: arm-smmu-qcom: add sdm670 compatible

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 2 insertions(+)

-- 
2.38.0

