Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE71FF7D4
	for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369025; cv=none; b=NGr+65PgR7dfPSbmm6jTkiZ3gweIHLADPLHo7uUoG+sMvBMXLoOFWzEMCstq7SQytjs437rJ8nzDhemv9Ak6Fva9EsWWSGvNtz3AyglqgWXTeCqR7AUrAE6PCnsEuUgb4E+aZBpUKduO9byEoMTx5/PEViOb/lo6aWLXsaq6QYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369025; c=relaxed/simple;
	bh=3baokyYFvGF6TPpe6/8+A/JesNtE+sKXB2Z8P5colj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VK8ZtX11Q0f0EkC+VAS2fb7JvG7Ilee+GTmi/BQxNiOVAgnIbcSohGbdFM1HilZ879lIGgvTc3s3xltHPR1YcXAaqlpdyRDJR3M6oGhDscyPzNUlumwRsiaHUACjT5GDNpHlt/WLhxA8QgR1bOZVFMjKV4nGmoEOopCJWqBN6ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxESXTyv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxESXTyv"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2161eb94cceso29253435ad.2
        for <iommu@lists.linux.dev>; Mon, 16 Dec 2024 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734369022; x=1734973822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vU+dmUIEOB3Bn235Q13lqV4rtbETnj3tLnp1CwkpGgc=;
        b=AxESXTyvg94XUj4Cz8XwyLK0ZZDbwDLWqQg6mPIMuPP9+e1XV8n3JgkzKoe5CXVOaO
         vMgMYwExH9tcoI495NV9yNbBYLk/X5I/WPB+v1OCgTL84cGJ7BkSYSz639BIzufi82+n
         ps0h1JWBWU6MX+eKbsyHNxS5AJ0zhhCHjm98Xy9+zS3L26pXKdVXJmYZBWdg9A1K729K
         8+OP1uPYja/ZtydLQ7Ep6mdNYfvPazw/97E3sxHZpiXl8ELuShRf0L5iCMQtxSuuAOqj
         hu4y3YCFBxlTicMHvbtdjIF1xcqitZ42S7g8ZW+C+hUb/yvA0UKCml4A7FAo/HJIfyjU
         KTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734369022; x=1734973822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vU+dmUIEOB3Bn235Q13lqV4rtbETnj3tLnp1CwkpGgc=;
        b=CKJJsAcQl1xgS5dxjfvp4261AOQBg05AN9ZKbTDgwHlrgmLxiamqM+3v+yI91c5QL3
         OBHTx2YS6G4bOafdjxu5xLJN+6LEOOyfFtNxnl2Lzwv+tYCYREQxVbQbGWP94O/LKQwy
         NHloYMVDnzg+icR2FqKh8DD93RAwr8MAhq49/eHKnYXwpGuNX9aBPPVljuMG9pTijy3l
         Kml9rvbGGFS0fzJSGnjsby2PzHSUbT8hNa+304mdbUm6T133uk77FTQtSGBQLHBiXOWg
         ZTjOQ2A7VqYzhJIndd31vRt5W/gDKwbqRIIbayRcLQvb1T0RsA3HjRt8Ute2Cd22wok9
         4OJQ==
X-Gm-Message-State: AOJu0YyWGErwvp1unIQ8/ovQkzC46OieIdifmBl1MqGejhZ3yar6yDmz
	X0Biz5b++aq7oILnRdjngHo7YLeQGu4RjhzzciTXvNa+hZ0RCCPorgfAow==
X-Gm-Gg: ASbGncuSABXSAQ0j07kd4nGcOpFidGc1nN5nprTmjCiGFPFN2WIXfgiQj7m+yH9GcNl
	JvkU4GYmDv/mD4VfvWIXSCLm4Y4DIHhrS4KFJNbMmyHbpIKf2BXwE/1rmBfYxvPqXzyaGTSKamk
	YqZ22nyqHNKwFhaQFi9eUr84/PP8+9Qy1vxYfbF1QzOPiPQjrewfoVitITX4DRm6lhcCclXAzZP
	m3fgF1Xdjaz6qgcCqezo3LVMG/26aZif4kDee1+WmdkLTs+2/n46wGvNbeibsTSvtKqDfXgi0j5
	nw7DBuQm6lHuyNvPwTAnybt7RghU6bY=
X-Google-Smtp-Source: AGHT+IELBk5CES1wF4PHrucRwTPjdWhx8XVgyIQNlfgXs1jGjow9SanGNGa0Yz59QLbcpGn4/Q+npQ==
X-Received: by 2002:a17:902:c409:b0:215:a05d:fb05 with SMTP id d9443c01a7336-218c8dd54aamr3975465ad.32.1734369022087;
        Mon, 16 Dec 2024 09:10:22 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:12e9:d196:a1e9:ab67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcb4d6sm45181925ad.80.2024.12.16.09.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:10:21 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/arm-smmu-qcom: Only enable stall on smmu-v2
Date: Mon, 16 Dec 2024 09:10:17 -0800
Message-ID: <20241216171017.4881-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

On mmu-500, stall-on-fault seems to stall all context banks, causing the
GMU to misbehave.  So limit this feature to smmu-v2 for now.

This fixes an issue with an older mesa bug taking outo the system
because of GMU going off into the year.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index c4c52f7bd09a..1c881e88fc4d 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -331,8 +331,10 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
 	priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
 	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
-	priv->set_stall = qcom_adreno_smmu_set_stall;
-	priv->resume_translation = qcom_adreno_smmu_resume_translation;
+	if (of_device_is_compatible(np, "qcom,smmu-v2")) {
+		priv->set_stall = qcom_adreno_smmu_set_stall;
+		priv->resume_translation = qcom_adreno_smmu_resume_translation;
+	}
 	priv->set_prr_bit = NULL;
 	priv->set_prr_addr = NULL;
 
-- 
2.47.1

