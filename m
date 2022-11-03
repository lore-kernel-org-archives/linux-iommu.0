Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA82256D
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 23:26:52 +0000 (UTC)
Received: by mail-io1-f42.google.com with SMTP id p141so2653342iod.6
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 16:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2MxtLOgKpYqADcHi0Ms5rAnV0GYIWE9u/0gNL7Fhik=;
        b=OpbNUsypFM1RninV6RLllkyCftJbdR1wOFxqN4+JBJvIY5EFbqE+/YL483TAJbiJPE
         rrwdh0dallEp5pyTTKD+0C8FIxdCYbEPQi65kNj7NuLLTs9wlkPYq3qHQ9qaUJ16Y/Rp
         6w2JBrPclqEBVI/kPCA8Q2oe0g6F/tol3P1G0bGpXDi1BbKajobrCk6WWD2sbsHzqVml
         4zRc7CLoWFt0Y+MuckUMwMrfbHx3uMPkk04inlj0Jy2/yMu8WrzIvk9VvnJCqhnRBjiB
         xlbOomyVFQ0vCkDpZxTehaKdwkfau5D/tk+fcLYHRFFIty4ONDBe94+TLDSilQQgCv3D
         YOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2MxtLOgKpYqADcHi0Ms5rAnV0GYIWE9u/0gNL7Fhik=;
        b=EK3jkOq63YWzvUYgdaO2RBAM8qbMnq8jRCJ83DKQGbW1I6KZm/TIzKaZwGfgOg6edt
         DidBcPPGXS47EKDCRAp2uL2HWjhqhtRTUP2OeXZxtMoRZ0NP8dYn+823FtcIKRE2brAw
         xGelFyiFruw2WN8rQvE6MaUI0BV1kz5wp7OFLiFI0OYEiJhZ4BnH6JM6RqUlSwD9yxI3
         +mAx55gvnIT5zzB72lbeaK5Ttm0C+09KUr+fpf/pZlPRvlq23FT7wjdaV873ScxliRV7
         gw9W9i3fbi8mtNBKhJBYlXi91qQF1U9oJAYkfjd6YMH1efx1g9uqIVr7X6Mw4QeD5DAh
         yZnw==
X-Gm-Message-State: ACrzQf3XvY8U9rYT2JyXl0Ea1YWO0CK1K7zWbPd4ErYDsc7Cc9lCEM/L
	sNx4B1DjWpC/RlxO9eqqceE=
X-Google-Smtp-Source: AMsMyM7onJtADF2TVejUtu5zJXSlEYzCF9cQnLipsTcL/WhqsMRyzA4AAxmCP58Bzxiny24H+6JVWg==
X-Received: by 2002:a05:6602:134f:b0:6a4:cd04:7842 with SMTP id i15-20020a056602134f00b006a4cd047842mr21063075iov.172.1667518011328;
        Thu, 03 Nov 2022 16:26:51 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id n4-20020a027144000000b003752e5b3c23sm654334jaf.20.2022.11.03.16.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 16:26:50 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>,
	Emma Anholt <emma@anholt.net>,
	Rob Clark <robdclark@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Cc: Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 0/2] iommu: SMMU for SDM670
Date: Thu,  3 Nov 2022 19:26:30 -0400
Message-Id: <20221103232632.217324-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
 - rewrite driver patch (2/2)
 - rebase on (1/2):
   https://lore.kernel.org/linux-iommu/20221102184420.534094-1-dmitry.baryshkov@linaro.org/
 - reset review process (1-2/2)

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
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 8 ++++++++
 2 files changed, 9 insertions(+)

-- 
2.38.1

