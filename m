Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8031B601C
	for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 20:07:42 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id oy13so28082805ejb.1
        for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cl21jvm8/i18W+G2Dp96sq2YT7qNueybJU+4cdncXPw=;
        b=U13mmqGzcmzWb0EKUrA4kB7s7tMzu6q+l4RblJKQ00zPQ4+7m3FwXyVCE87ry6V1kZ
         sKORedh3MR+G+I1H9tP6E1N3O/zdxTv9nlsw1+icTnVo3sqzJQE5fZkatjiL7z7s/Enu
         4qKcAW0kCJmyl/EzsrTTTKeRrA5/ol04PhdMrRVzXyJ3a3hGL4HjdTyQqibP6x7u25en
         U3ncncw/T9cB6a41bBVzvYy3ZlJAFzYPtlCe3U9JoIzuk6VrrPyq3SktT1U8gfCOFhY7
         bWzrISlmDVhU1ejCZkQF9TQeletEngxIXgbinFJ9VNRM2nGdlOzpk0U8obPc6axsTuiK
         vbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cl21jvm8/i18W+G2Dp96sq2YT7qNueybJU+4cdncXPw=;
        b=luf+z40TAusbIbJnLsYy3sYCK2rTsBxdbP7AgzwkpF9+h+7U1PBsQj7xUuFD8+PYoE
         IbX9J6it4UTeED7oXI0byPR+B+lwz14bAV7bZl8FFFzQCVeVas4PSNcV9sTmy0iIfgLM
         YKpGzYvPaveDl2xtsRuO7ZRk28cVov3GRdNznKSGq1Ej5/rrnV/IGQvLm0qQQX5zAWj9
         8m6WQN+UhJE3CkGvLaPpmKTid8jhwOhCvvK+I9KC/4NiDDFaSWkxCYE3f4wuH/IYtGvj
         UNd43nw8qr4J3ovFobpwJmLO2DaDbz+uquwI8RN7DUOSijfUMq0sdmmJmUW7VL+S5ihZ
         qnJQ==
X-Gm-Message-State: AJIora+yvum0dMGUBqZXfQ/kI4Ckfi9b3FMONBfxneTuPZGBvtn1mSFr
	N0O8QcbX3QEIUMzPH/NT96wHPg==
X-Google-Smtp-Source: AGRyM1t5Wt6O9sdWkph8CILpfneT+aE9nPQuJidjIxem+m7LXnzboEHCUJeiqep+kJlkPyV5eK5lXg==
X-Received: by 2002:a17:907:6087:b0:72f:36ff:7fa2 with SMTP id ht7-20020a170907608700b0072f36ff7fa2mr15123309ejc.162.1658866060598;
        Tue, 26 Jul 2022 13:07:40 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id kz20-20020a17090777d400b00722e203633esm6829623ejc.122.2022.07.26.13.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:07:40 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	David Virag <virag.david003@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iommu/exynos: Add fault handling on SysMMU v7
Date: Tue, 26 Jul 2022 23:07:37 +0300
Message-Id: <20220726200739.30017-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exynos IOMMU driver implements fault handling for SysMMU v1..v5. But the
abstraction currently used is not suited for SysMMU v7, as it has quite
different fault related register set.

This patch series reworks the mentioned fault handling abstraction and
adds fault handling support for SysMMU v7.

Sam Protsenko (2):
  iommu/exynos: Abstract getting the fault info
  iommu/exynos: Implement fault handling on SysMMU v7

 drivers/iommu/exynos-iommu.c | 208 ++++++++++++++++++++++++-----------
 1 file changed, 143 insertions(+), 65 deletions(-)

-- 
2.30.2

