Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791616D9A2
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850842; cv=none; b=exzYjsHBLHxNuxwUt+ErTa0vF5TyYG8OQY05bd0Vg2UW52hmnnh6qja5QHLDdJMFPzc270hUDWGQwUcRYPKGecYeqePoypQOCLrumXQtt6mJFrEP1k52DZqJsFSyGOrVvutyl3r11E/4Usy00GLS8AZdhDtlzhg2Q0roIu08OFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850842; c=relaxed/simple;
	bh=IW8RGWfl2BlHpimDXAA7bRLiZRlSAdHOFyJ5cLC8y/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXcZOg+Bki3zlbjRtwvcBqUSxJ6BMfKIEqJUNQBVnQhqAvRvVpmJF2Zn7MWGPtwAHPMAQD6Y2CPftyxwF0RqHFTXRgdeFy9eBHQ1myPvS/gmgZim5lRH9ltYu8offmkFseC0250k18iFaUfnuExzbmS+2oEQWjtQszDTurT7M/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNb3wEsn; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNb3wEsn"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b53bb4bebaso1777430eaf.0
        for <iommu@lists.linux.dev>; Mon, 01 Jul 2024 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719850839; x=1720455639; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1jhsbzsQSOicdV37XZ9var/nTBpCYxPxtGqd7ndFu8=;
        b=YNb3wEsnli1TV9wNhlx8ftOWDkFLgnCi5JVnIZ8ORt4jlhhdmeTKS5PxHcCbzjJWZi
         h5R9L/sL7xVSACJnPPlcK08GkAXrufKsyHuOCzXQYbLXf0ntCA+XKmQGsURa8W9W6Qkr
         DzcvIaSMLiUwd4k4hAP1JFLy42YP76RRK2cgGzihRPZE20tyACw/i45sJsE1S2w7Doug
         eDfLTy9ooeGxRDwpsJnR/xJE3XTEceZ5+wLYn/oXBuyScdhAI1UCY5h95IGwU6tO18i/
         YwO2IfD8QUJV9gUtx4ECU9OfiaJD2/q5hxhfDA3CxkBrmKGjKiLGDAmLZAk5bYcoBhWh
         ObAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850839; x=1720455639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1jhsbzsQSOicdV37XZ9var/nTBpCYxPxtGqd7ndFu8=;
        b=ehihOJKHChpDZY9LgEs56D3IukBp1LYxDl0fsGy7vEMBisYK/tB0gEFx5FPFX6r8cQ
         PsB6UzbCLO6KN9qddy6uzTSTGMoBTD2wP9YK+4Oifdy2khSZrKXYDdmJqUPZIuVqNAnq
         JWb1wzHvuS8/uMmG/FmsfsnozdVDt4ha9lfJC4c1IkhAsy4aQT2zSsEQkZ7rqD1D0PTd
         fOUdTVBOl3Sj8XA3GDMQBmM+N4XgB8BFrVcCEQbkkdZIvtdeeh7gBvKd5y+hT3I9dsd5
         s1sdMz4DF1aTB4FOMMRPymsTIxiZqwAtdn4fgGp0VoTMf3U0Ro3QR1HwPGzvJUDU2UzU
         KNfA==
X-Gm-Message-State: AOJu0YwO45f4Nv8JlIFn3DGZX7/NQPp4DTei35Ja5ActqLBFgJZzJ7+y
	NvzUYx0l7Pg+iWezgE3A/fw31X63+J3IqLkoyfeYjWvq+XHVwzWmw7bkzg==
X-Google-Smtp-Source: AGHT+IE7cvLNIICXLZ+ApTE7+JEq/r4+y8wOtGf3rrz7GsGFtHfKDk9f6EPS0mmgXO+f7YcF9Yy4cw==
X-Received: by 2002:a05:6358:6f93:b0:1a6:72f2:4d03 with SMTP id e5c5f4694b2df-1a6acd61133mr706254455d.9.1719850839491;
        Mon, 01 Jul 2024 09:20:39 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm4452022a12.31.2024.07.01.09.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:20:38 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Rob Clark <robdclark@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
	linux-tegra@vger.kernel.org (open list:TEGRA IOMMU DRIVERS),
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 0/3] iommu/arm-smmu: Prettyify context fault messages
Date: Mon,  1 Jul 2024 09:20:09 -0700
Message-ID: <20240701162025.375134-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

v3: Split out the reg bitfield renaming, rework
    print_context_fault_info() helper

Rob Clark (3):
  iommu/arm-smmu: Add CB prefix to register bitfields
  iommu/arm-smmu-qcom-debug: Do not print for handled faults
  iommu/arm-smmu: Pretty-print context fault related regs

 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c  |  2 +-
 .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 66 ++++++-----------
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 74 ++++++++++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.h         | 71 +++++++++++-------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  4 +-
 5 files changed, 127 insertions(+), 90 deletions(-)

-- 
2.45.2

