Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502EE3D0D8
	for <iommu@lists.linux.dev>; Thu,  7 Dec 2023 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AusLtpDF"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so714326e87.3
        for <iommu@lists.linux.dev>; Thu, 07 Dec 2023 04:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701953702; x=1702558502; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JA5daNbyCgwvSSjCzYxa9vhAfMiSd1k1ygkW4K36+HA=;
        b=AusLtpDFc5eyjdOigNmr+Bpw7q6UP3CB+ak0r+JQGNtX7qNWXNBGxfr5F62XADp7ca
         4h0SjPJBT8b1B8tyOYg1Y0ejEG+imdRYrOjML6J5+oxoVVuc6Ov+VXK0SZ41VL8721B8
         ahIFEJqQ9xjQnvgc9NJEgA+1cVNkHzAwASwRCn/Cn7Mh3/UoGxb4TViVTu6mPZN6VHFR
         GJemfIckd/bFp6//9PqmzWD77GtCBtvxG6NcYjH/ZF+nr21bBl9Gl1n/FQEVDCJv3K7l
         3/NEy6KGcE6z62yVUJfkxMhdsMSTeh7euKrVAOYbiJNPHFQ8ZZpypwd1bLF7RfVWf50a
         H8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953702; x=1702558502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JA5daNbyCgwvSSjCzYxa9vhAfMiSd1k1ygkW4K36+HA=;
        b=KinBGRFdNw/BPl4k5VCw02g6S/FQaipWvOzRIDd14WiL/m0cgjHi6+6MpNCP7zuxfy
         rlzoOBriaqSz0mkfODd7WIrNrTGaZSQdZc3xzujSixIhZ4N/9CKTGhrWVsY2Z9KRgDrW
         Kou2yl4JZSwrzJBMQdjGvweau61i5x+kpD6XRDW6gmwzK9E0lAiW8kUKdiGs/uHZ64fe
         JQagXBXm4p/OnoAlaK0va0oC8qx8BUQUt5dWqIYnzigedzUhWMbInih//HN8x76P2KGt
         5r8e/BP8jhpUOUnZPF6LHDDPJchSwqpCxMbpct4fwStrQQg76VyOyOvdlk6yXbg1AYy4
         BLEw==
X-Gm-Message-State: AOJu0YyDZh1A9ShWsXxAdKs36UbeiDynF2+QAEbScLGDol90pzGmGneV
	seCkZzASoY6+73QjelNbRQNUkQ==
X-Google-Smtp-Source: AGHT+IGViRtvlpdiCs1SPsFLcYgzGmJHBhF3Is5KUCBEwYegCA67nn8Q3E4ww4emr+dFf1lSoaEOAQ==
X-Received: by 2002:ac2:58fc:0:b0:50b:f084:7c8f with SMTP id v28-20020ac258fc000000b0050bf0847c8fmr1365742lfo.111.1701953701726;
        Thu, 07 Dec 2023 04:55:01 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id cf30-20020a056512281e00b0050bfc6dbb8asm163659lfb.302.2023.12.07.04.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:55:01 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: [PATCH 0/3] ARM: qcom: drop 32-bit machine Kconfig entries.
Date: Thu,  7 Dec 2023 15:54:57 +0300
Message-Id: <20231207125500.3322229-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Kconfig for 32-bit Qualcomm arch predates DT and multi-machine
support. It still defines ARCH_MSM* types for some (but not all) 32-bit
Qualcomm machines. The MSM_IOMMU driver has a strict dependency on one
of such kinds.

With the DT support in place, this has become obsolete quite a while
ago. Replace all 32-bit Qualcomm ARCH kinds with the single Kconfig
entry for the workaround required to be enabled for some of those 32-bit
platforms.

Dmitry Baryshkov (3):
  iommu/msm-iommu: don't limit the driver too much
  ARM: qcom: drop most of 32-bit ARCH_QCOM subtypes
  ARM: qcom: merge remaining subplatforms into sensible Kconfig entry

 arch/arm/Makefile          |  4 +---
 arch/arm/mach-qcom/Kconfig | 41 ++++++++------------------------------
 drivers/iommu/Kconfig      |  2 +-
 3 files changed, 10 insertions(+), 37 deletions(-)

-- 
2.39.2

