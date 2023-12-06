Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC4651
	for <iommu@lists.linux.dev>; Wed,  6 Dec 2023 00:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xsWqQhuG"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b84e328327so3692427b6e.2
        for <iommu@lists.linux.dev>; Tue, 05 Dec 2023 16:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701824257; x=1702429057; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=15PtUMzm1CCv273Hbndys2UZ7tBEJDNkUXj6E0nA6q4=;
        b=xsWqQhuGItDZGqw9I6XpWHKZn/PAJhjNk5hLDIab0jM68/yBYIAqgIb0AUSEqhwdA8
         thQVMZSxjiXqLA6fIileEvZANYsvKYpfquTkjkOKM+KP0JqdiY/uOiJk+FN1xwtmVRs8
         r1PGJCkarfkrTiedsbC125keOUKbo40XSP9Ar7sSKdrZnbQthkiovFTHYHlXZ0DX85yX
         xCnSnNKszjSScyZAE7m1EqBkk+ZzraDX1n5AbD2IO5htYE/dkbx/IKZV5Lfy2iXBmDQy
         ldTwOCsKQnqHmHEG2LVwgQkCChYL+bNSUOqEYTyg2hmc5hO5GHDuyC37kPCmGLxlDDwe
         TcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701824257; x=1702429057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15PtUMzm1CCv273Hbndys2UZ7tBEJDNkUXj6E0nA6q4=;
        b=c5Vri00TOFqkk1uAE5L0hqedM3l2KnUNWHqD8AxQ9/MOve5lc2KwTHfQuSdBvlmgmT
         0ay1y2ywlid9/Vup5mPXghhZn5/9FpUtopiHp7nZal9J98qfXTo376p+GEsMYLSkrwLq
         ok5b2eGC87CszYSrAW55falcX1u9ybWw+bXQzlT9xjeaf9hpKrt+tQvD5mQUygVOLf/e
         84hgWEMBLA9c/YMAWEKCcFgrktxwD62xEzcjhvOi8WFBCOsEk7biZLqlnOK69sYaxUOr
         Or2TZmsoBF/0JvuUhH6gflHtYOgjCYSc/6HruFWx+i/+EwCOiy0FMZQvFbqVsQuKLbXY
         Ag6w==
X-Gm-Message-State: AOJu0Yxr/XCLr3M0ViqN4VcjP2eNg2CAMDhZvsxZfgsYVVgqcbbiQPYJ
	9vphsbsu8Zp+XYX6fb5xoT5INw==
X-Google-Smtp-Source: AGHT+IE5ulwG4V0s2m8jeafUFyOjHpVi+hGh+noPkhcaG114A6cDiNvh20aA9d+SEUvHswrSwKpRqQ==
X-Received: by 2002:a05:6808:319b:b0:3b8:b063:6bb8 with SMTP id cd27-20020a056808319b00b003b8b0636bb8mr185810oib.103.1701824256810;
        Tue, 05 Dec 2023 16:57:36 -0800 (PST)
Received: from localhost.localdomain ([36.5.194.73])
        by smtp.gmail.com with ESMTPSA id fe18-20020a056a002f1200b006cddecbf432sm3569583pfb.96.2023.12.05.16.57.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Dec 2023 16:57:36 -0800 (PST)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	Wenkai Lin <linwenkai6@hisilicon.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH] iommu/arm-smmu-v3: disable stall for quiet_cd
Date: Wed,  6 Dec 2023 08:57:27 +0800
Message-Id: <20231206005727.46150-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenkai Lin <linwenkai6@hisilicon.com>

In the stall model, invalid transactions were expected to be
stalled and aborted by the IOPF handler.

However, when killing a test case with a huge amount of data, the
accelerator streamline can not stop until all data is consumed
even if the page fault handler reports errors. As a result, the
kill may take a long time, about 10 seconds with numerous iopf
interrupts.

So disable stall for quiet_cd in the non-force stall model, since
force stall model (STALL_MODEL==0b10) requires CD.S must be 1.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7445454c2af2..7086e5fa41ff 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1063,6 +1063,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	bool cd_live;
 	__le64 *cdptr;
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
+	struct arm_smmu_device *smmu = master->smmu;
 
 	if (WARN_ON(ssid >= (1 << cd_table->s1cdmax)))
 		return -E2BIG;
@@ -1077,6 +1078,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	if (!cd) { /* (5) */
 		val = 0;
 	} else if (cd == &quiet_cd) { /* (4) */
+		if (!(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
+			val &= ~(CTXDESC_CD_0_S | CTXDESC_CD_0_R);
 		val |= CTXDESC_CD_0_TCR_EPD0;
 	} else if (cd_live) { /* (3) */
 		val &= ~CTXDESC_CD_0_ASID;
-- 
2.39.3 (Apple Git-145)

