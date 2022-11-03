Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2763D3
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 19:51:57 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id ud5so8203176ejc.4
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSoY1RFfLiYGbG6PVIWaPMns1WQq6G1mUH0o4v3ezJs=;
        b=jXb0goUM1eMoI1vo0YE498npOwxh/JsIH3dtk03GixxejFSVByMt5Dl6Oj9UpEy2W9
         Pf8lK5SE9nKJLqX7fqqHjAKN4x8cTWoBC/ZO7NmVESWXWlgiku667ugCRTUlki6fNW62
         4aJsr84+PNy515JKoqpLImWu/5xN8FtmAHgQKjqLtggAsm39S7frbEXGlFG59qD144CR
         7+lrhEeKGAsBbKo5uOUH426MhT6SnUzT2vBvRxhCUrKOJtrcUrJovRbrtKy0VNuT5kOS
         Jfw13SRy0c7DWpiQN9LurfnyRJQXmhFBacMlSISHuC7N78xKzzX9rDrxxcNd6dhhmr1g
         DxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSoY1RFfLiYGbG6PVIWaPMns1WQq6G1mUH0o4v3ezJs=;
        b=j+3Pw6g9o9yGLdbFwvS3QTWqCPAf07TYWrb3raYaIIAfU10FZrOfG9+dnZlKO6FFFK
         pUq7HvY0ULacngSdE6tzXHph9d3XNgcYzkC05JC3aHIA1lnIK+F1sQVMCsgKE1LYPbtR
         LO4h1NUIwQBcO+3QsISPhmDRNKmrutMpyfgVsv5pueB4lS6qBjfs+tiBCeqkhfjTLbPq
         +jpNeeipZjTTJ0VfqxaWBYfYHiisObQU7wzQvmKWl9DhAVy+eP09+n1ctSjbxBbNTeN6
         Fllh8iJuN/vQkv+y2C939gGPDjfHFYJv7YUi8qhCxZxMP2aHxiUnlkGr0LaK0U5ZB3sX
         jMeQ==
X-Gm-Message-State: ACrzQf3DvMMphbkUsy/HxyNagAz8Y8/m1Zz9TNX1TGaTOEciRi3UPdTC
	Fl3s6yYP71dTbrjykF6fKYKF1Q==
X-Google-Smtp-Source: AMsMyM7oHxP/WKbsDall/gZqsAjIooBN50fjNtXMSu/4PKkO5F+CS5IHBjfjNr2w+TaIs3Ggwoj52g==
X-Received: by 2002:a17:906:730d:b0:78e:9ca5:3269 with SMTP id di13-20020a170906730d00b0078e9ca53269mr31172648ejc.366.1667505115999;
        Thu, 03 Nov 2022 12:51:55 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id j14-20020a1709062a0e00b007415f8ffcbbsm870386eje.98.2022.11.03.12.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:51:55 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	David Virag <virag.david003@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 0/6] iommu/exynos: Convert to a module
Date: Thu,  3 Nov 2022 20:51:48 +0100
Message-Id: <20221103195154.21495-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As exynos-iommu driver is not a critical platform driver, it can be
converted to a loadable module to avoid loading it on non-Exynos
platforms in order to improve the RAM footprint. This patch series
converts it to a module and does some related cleanups. IOMMU/DMA
specifics were taken into the account, so remove/exit methods weren't
added.

There are two drivers using CONFIG_EXYNOS_IOMMU in their code:
DRM_EXYNOS and S5P_MFC. Both were checked, and only a slight change was
needed for S5P_MFC driver (patch #6).

Changes in v2:
  - Extracted the "shutdown" method addition into a separate patch
  - Added MODULE_DEVICE_TABLE(of, ...) to support hot-plug loading
  - Added MODULE_ALIAS("platform:exynos-sysmmu")
  - Added fix for S5P_MFC driver to work correctly with EXYNOS_IOMMU=m
  - Fixed checkpatch coding style suggestion with "--strict" flag
  - Rebased on top of most recent joro/iommu.git:next

Sam Protsenko (6):
  iommu: Export iommu_group_default_domain() API
  iommu/exynos: Fix retval on getting clocks in probe
  iommu/exynos: Modularize the driver
  iommu/exynos: Implement shutdown driver method
  iommu/exynos: Rearrange the platform driver code
  media: platform: Use IS_ENABLED() to check EXYNOS_IOMMU in s5p_mfc

 drivers/iommu/Kconfig                         |   2 +-
 drivers/iommu/exynos-iommu.c                  | 355 +++++++++---------
 drivers/iommu/iommu.c                         |   1 +
 .../platform/samsung/s5p-mfc/s5p_mfc_iommu.h  |   4 +-
 4 files changed, 191 insertions(+), 171 deletions(-)

-- 
2.35.1

