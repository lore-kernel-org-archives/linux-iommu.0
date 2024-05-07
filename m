Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC0A15FA68
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091980; cv=none; b=pwav7kzkUc+VfLOl2W8sZmXJWyc/b58U4Qwm+WlvLwdcz2Z08P+JM4zl+X45ix3/VRvHaOtuK8ffWCnzZB/x956SAmdguIRfxJT6JCQAorzEJQd4mkb55cFWQtujvEc6ZqIrvQPitn5fu/I9uuNy26cNRJdN3sAZkmDU/gCge2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091980; c=relaxed/simple;
	bh=/u32NxJwpRrssHruSux3ZSYrSazvMyTW+Oc6RuusvT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U6o0u2/4VF+eL8TAbV2KefM4+FCkEO+XzY/lIMlMZYUJGixfVh/I1IpNJIbj1Kvc6HB3L4zCwN0Wn0e5y5fkMldsR+BAzwIVy0QiQOotZmhHARvNycq0Bq5/DMcrZTrpXTCW/9Zo/Uv2vL05tOc8HNV0xyXWqe+JnCBkuDg6x1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fi1MeHBC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fi1MeHBC"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso3082005b3a.0
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715091977; x=1715696777; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b+b6a14h4JCjFlQP6t364i5UnYTPW3CwsNAJ2Ic+YBk=;
        b=fi1MeHBC7zhpglhLPXVzxeAqTxtGMOqs1XK+gJZlMIyflSNuHWFBDRSwPbSQvtiIX+
         0bNGW+XWe1jkuSVWfL8v8TpR0JNYxt1Q5wmRCWhVDtZm2yQUMUTrslTbwHxdKzFSAOD0
         RIWYTtna8Zk9msHSotAsQOxIiYtWkw7gVQq1kf1RgdrIEJQ4VAePAsqP2dUpZRB7uWxB
         oWCE5IpugVQZKxf7yDlii22o66O4bRGO4YgNRU9CqvGZK1nKBeXokWuvYcWTUq3NGJVY
         ieUp3swptXOnJm05fq4jvJm8KNn/X0E7V53cGCiIfPC8NrrPzoM5Y2iNQr9vYB/gbkW4
         k1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091977; x=1715696777;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+b6a14h4JCjFlQP6t364i5UnYTPW3CwsNAJ2Ic+YBk=;
        b=OLVVHCRBlzKXFo6b6fKCxnuA5mGTC9DwUmpXnIbXzQThalhmr9DNrNZkg8U85U7oNg
         R495WaaBbJXU+gLd+Tn8TORHQqjZq4QYsk5QoSaLGoeU1xGn9xbQJxylYeeJ1EYhIaqV
         MWlhBNxXSqnbCrd3l4opd4DGy74kt0IUL4hvub1oJznrmgqIlMm7Zl2KxaVBVL6abTe8
         pyjDk1Ks+M43FpcSFAWNNqZnivpXmcmHddp37sAWP7LbK6F50IPc/JdZDB/4HkijWBoR
         5d7LPCWDrwu7df+YhEuc2JArvBvnwYDfYTylBS8FAsIfBERhwASI/okhWXpC0kWrHjGg
         /74A==
X-Forwarded-Encrypted: i=1; AJvYcCWXZ8VYtuD+hd2N8TQd6NJzPNJGl+2UNTttWJeCfna3JbViolT3kzlDm1EmBt3kF+7hJ9UibScjog2c6Gx3+MzTo+9yuKg=
X-Gm-Message-State: AOJu0YylMSOIIRHl6Dh11xhKRL5qMgQ5ulA9L6W/d/hTHq2RgIdTc37j
	3Hp6qFW5gyHSTt610MAUdxq9fQiyseKMoS5ufRiE5TyFIt4qvyXl7XAgccNW6Rs=
X-Google-Smtp-Source: AGHT+IGGpKiuhFlm6XAxN2dekhHNztwFPkYH1wk0fi2F0H3c/gi7fQ/EHQEjzLAwbTOOSYiKwoJeKg==
X-Received: by 2002:a05:6a00:843:b0:6ea:86f2:24fb with SMTP id q3-20020a056a00084300b006ea86f224fbmr15303975pfk.25.1715091976310;
        Tue, 07 May 2024 07:26:16 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b006f44bcbe7e3sm7687554pfa.201.2024.05.07.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:26:16 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC RESEND 4/6] iommu/riscv: support nested iommu for getting iommu hardware information
Date: Tue,  7 May 2024 22:25:58 +0800
Message-Id: <20240507142600.23844-5-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507142600.23844-1-zong.li@sifive.com>
References: <20240507142600.23844-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This patch implements .hw_info operation and the related data
structures for passing the IOMMU hardware capabilities for iommufd.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c  | 23 +++++++++++++++++++++++
 include/uapi/linux/iommufd.h | 13 +++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d38e09b138b6..072251f6ad85 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -19,6 +19,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <uapi/linux/iommufd.h>
 
 #include "../iommu-pages.h"
 #include "iommu-bits.h"
@@ -1485,6 +1486,27 @@ static struct iommu_domain riscv_iommu_identity_domain = {
 	}
 };
 
+static void *riscv_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct iommu_hw_info_riscv_iommu *info;
+
+	if (!iommu)
+		return ERR_PTR(-ENODEV);
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->capability = iommu->caps;
+	info->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
+
+	*length = sizeof(*info);
+	*type = IOMMU_HW_INFO_TYPE_RISCV_IOMMU;
+
+	return info;
+}
+
 static int riscv_iommu_device_domain_type(struct device *dev)
 {
 	return 0;
@@ -1560,6 +1582,7 @@ static void riscv_iommu_release_device(struct device *dev)
 static const struct iommu_ops riscv_iommu_ops = {
 	.pgsize_bitmap = SZ_4K,
 	.of_xlate = riscv_iommu_of_xlate,
+	.hw_info = riscv_iommu_hw_info,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dfeaa2e649e..ec9aafd7d373 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -475,15 +475,28 @@ struct iommu_hw_info_vtd {
 	__aligned_u64 ecap_reg;
 };
 
+/**
+ * struct iommu_hw_info_riscv_iommu - RISCV IOMMU hardware information
+ *
+ * @capability: Value of RISC-V IOMMU capability register
+ * @fctl: Value of RISC-V IOMMU feature control register
+ */
+struct iommu_hw_info_riscv_iommu {
+	__aligned_u64 capability;
+	__u32 fctl;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report hardware
  *                           info
  * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
+ * @IOMMU_HW_INFO_TYPE_RISCV_IOMMU: RISC-V iommu info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE,
 	IOMMU_HW_INFO_TYPE_INTEL_VTD,
+	IOMMU_HW_INFO_TYPE_RISCV_IOMMU,
 };
 
 /**
-- 
2.17.1

