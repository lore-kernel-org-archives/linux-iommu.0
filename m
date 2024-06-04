Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86734C91
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513310; cv=none; b=uKeXTg3XgqcEqZ+xsF3HoWpSVciic3fhQgbVEVIFEYzi1wy+KRN8c211BBmN5XGwT8XjMr5k+kOdU5gEfJ83gtAaxg055cAm6o2VL8Kh9Ws07WW4E1DLs1BjaU0u2rj5dcGtd0UqRT3Wx1uQ2IUhY1qwHYKPrwr28C4Ltrq05I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513310; c=relaxed/simple;
	bh=FBKiAGtmKJHWNrtxjlG2jSJk1wPquEKW9T6nmOhWZEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeByqQTsJqBOfibDvaQlL5gnOsYOznRElIiD7GppaO9Q+lTcl/muNUqhWuI20ufP9YYAxzFK0IP2rVWk4EXpyAYqvs8N7Kr2sD5KPlj/nq/PpdGouUOJtAgOrjeO2G1JePjVtZhg72+Kgq/gAN27AxkLuWGc1X9uIgr/N5yN4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp57faRy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp57faRy"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f44b42d1caso43315715ad.0
        for <iommu@lists.linux.dev>; Tue, 04 Jun 2024 08:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717513307; x=1718118107; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zzDBNu/Km1bywTdzn1zNJ2Ca7zC5GTmKmM9CZqf88E=;
        b=Qp57faRyzvZcLoN/5D3bSDPDDg3GkYrbl7YAgUflPTucMeXFaTsvct486iYsJ3BI2y
         2mQQ/pNiLbF4O+qXAKGKla6mmHTmoV4Gl8Ojl3jk4qBsj7IOjUc3JZhrU1/fQldWHYlx
         udpfn1gUF4Xb1FPo6IZCh954/pUPpcjWFgnivaereMhA+1+vFG4p//2DBCNxyD+F/6DJ
         0gCqPXjK5/WtxOCmRE5+b6WrXSlNRtZPcdOrt5QvOhZZlvL816IuOVHRS5TeM9xHozas
         pFcMCd/kDAF0gOjgAfxVh+gRT/d/AJoG6sO+YaQwwlCjFHPdVwrPUjewdNV5BRU2WaoB
         76nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717513307; x=1718118107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zzDBNu/Km1bywTdzn1zNJ2Ca7zC5GTmKmM9CZqf88E=;
        b=URXX2cZSN/MJmTbMhIEcOFz9UaRcGQ+jVJo7mArPUioecGb8scu30YZVZNZheTJsha
         ALBWAn4pX258goYXq7K6lz2oZjz+39NYYnvFhXEb5wwC/CEGvmum6N8DSagfcCd+iGiq
         u9JmudmBFOdVeqWUTBQrDxyaiGEcFaXqBDUpQwCJbbN92tsI74GO7z6zW/5YZDHmsAvs
         xWUwHoG1DyxuTELRcNhB26wYoklMreIlkUwD3tgjXDoOTdLt24hWZAQS3sU/G+s+K/Wh
         sc3HUJdV2rtQsvVeaGBx638S1VXQ6xRR265/kZRrU9kq07YO4WKNPMBikZJFB3oj9dYT
         b5cw==
X-Gm-Message-State: AOJu0Yw4VZe4RVeil1JEmtmZ5kJXTQ1xKg4xMEFGdps6O/hkuF+80Yhp
	Ikkx4UcErqyo1+4dk21sp34AgPjE92f/KkLQw3DcaNSITypLm9a+fCdYRg==
X-Google-Smtp-Source: AGHT+IF1zgJrv6FVFO4d/uMJ9aDbi7Mhv60qd0JUz/GquNgBBdeZzjzd6K0FINdAHBDxfCTjnp5JGg==
X-Received: by 2002:a17:902:e846:b0:1f3:4d2:7025 with SMTP id d9443c01a7336-1f6370985fcmr137086895ad.49.1717513301179;
        Tue, 04 Jun 2024 08:01:41 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323dd731sm86202895ad.144.2024.06.04.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 08:01:40 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/arm-smmu: Pretty-print context fault related regs
Date: Tue,  4 Jun 2024 08:01:31 -0700
Message-ID: <20240604150136.493962-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Parse out the bitfields for easier-to-read fault messages.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
Stephen was wanting easier to read fault messages.. so I typed this up.

Resend with the new iommu list address

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 53 +++++++++++++++++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  5 +++
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index c572d877b0e1..06712d73519c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -411,6 +411,8 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	unsigned long iova;
 	struct arm_smmu_domain *smmu_domain = dev;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
 	int idx = smmu_domain->cfg.cbndx;
 	int ret;
 
@@ -425,10 +427,53 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	ret = report_iommu_fault(&smmu_domain->domain, NULL, iova,
 		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
 
-	if (ret == -ENOSYS)
-		dev_err_ratelimited(smmu->dev,
-		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
-			    fsr, iova, fsynr, cbfrsynra, idx);
+	if (ret == -ENOSYS && __ratelimit(&rs)) {
+		static const struct {
+			u32 mask; const char *name;
+		} fsr_bits[] = {
+			{ ARM_SMMU_FSR_MULTI,  "MULTI" },
+			{ ARM_SMMU_FSR_SS,     "SS"    },
+			{ ARM_SMMU_FSR_UUT,    "UUT"   },
+			{ ARM_SMMU_FSR_ASF,    "ASF"   },
+			{ ARM_SMMU_FSR_TLBLKF, "TLBLKF" },
+			{ ARM_SMMU_FSR_TLBMCF, "TLBMCF" },
+			{ ARM_SMMU_FSR_EF,     "EF"     },
+			{ ARM_SMMU_FSR_PF,     "PF"     },
+			{ ARM_SMMU_FSR_AFF,    "AFF"    },
+			{ ARM_SMMU_FSR_TF,     "TF"     },
+		}, fsynr0_bits[] = {
+			{ ARM_SMMU_FSYNR0_WNR,    "WNR"    },
+			{ ARM_SMMU_FSYNR0_PNU,    "PNU"    },
+			{ ARM_SMMU_FSYNR0_IND,    "IND"    },
+			{ ARM_SMMU_FSYNR0_NSATTR, "NSATTR" },
+			{ ARM_SMMU_FSYNR0_PTWF,   "PTWF"   },
+			{ ARM_SMMU_FSYNR0_AFR,    "AFR"    },
+		};
+
+		pr_err("%s %s: Unhandled context fault: fsr=0x%x (",
+		       dev_driver_string(smmu->dev), dev_name(smmu->dev), fsr);
+
+		for (int i = 0, n = 0; i < ARRAY_SIZE(fsr_bits); i++) {
+			if (fsr & fsr_bits[i].mask) {
+				pr_cont("%s%s", (n > 0) ? "|" : "", fsr_bits[i].name);
+				n++;
+			}
+		}
+
+		pr_cont("), iova=0x%08lx, fsynr=0x%x (S1CBNDX=%u", iova, fsynr,
+			(fsynr >> 16) & 0xff);
+
+		for (int i = 0; i < ARRAY_SIZE(fsynr0_bits); i++) {
+			if (fsynr & fsynr0_bits[i].mask) {
+				pr_cont("|%s", fsynr0_bits[i].name);
+			}
+		}
+
+		pr_cont("|PLVL=%u), cbfrsynra=0x%x, cb=%d\n",
+			fsynr & 0x3,   /* FSYNR0.PLV */
+			cbfrsynra, idx);
+
+	}
 
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
 	return IRQ_HANDLED;
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 836ed6799a80..3b051273718b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -223,6 +223,11 @@ enum arm_smmu_cbar_type {
 
 #define ARM_SMMU_CB_FSYNR0		0x68
 #define ARM_SMMU_FSYNR0_WNR		BIT(4)
+#define ARM_SMMU_FSYNR0_PNU		BIT(5)
+#define ARM_SMMU_FSYNR0_IND		BIT(6)
+#define ARM_SMMU_FSYNR0_NSATTR		BIT(8)
+#define ARM_SMMU_FSYNR0_PTWF		BIT(10)
+#define ARM_SMMU_FSYNR0_AFR		BIT(11)
 
 #define ARM_SMMU_CB_FSYNR1		0x6c
 
-- 
2.45.1

