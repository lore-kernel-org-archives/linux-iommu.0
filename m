Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F283A08
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716500100; cv=none; b=sCYyU8U5c9FNuJBwxjZ1CL4r2GGpLSpiBh8/JbRMdC61OJzyd9YRY2tMplowIb7v7QhO0HK2jLY3i64hsZPvQU7hIq4D7KEcsXW5+04FlsnYPuAKW80ON9uRSYsHdgNVQIHywVxgHVqtelLmEGrEvRiue9P6Mvlye9P0NADZU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716500100; c=relaxed/simple;
	bh=TtkKeCps0ejierSSi4w3QTlHUP2b6nZhMZC8/xjZifE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JwYR/qGFI07gtC3TyXuFtlMopZWW7+DGOYJRXRSYJwgCDTqxJmTNqSgQ8ChmnKyCSTkgJegRcX9clCQDeVuk6m44dDExZgPf2WdougfjA3sR+xEkzJWSKgEng0EQU2Tv0VXBnDRAopsHDz4gu6RAENWZouCnLVg8GMJ21xNZpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSrROwoN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSrROwoN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f44b5d0c50so1072595ad.2
        for <iommu@lists.linux.dev>; Thu, 23 May 2024 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716500098; x=1717104898; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T7a2uMVZssHO/XdZkFjaZx6Fve2Wj78fROEuqBTUEKo=;
        b=PSrROwoN7VEPIScPJq4xIExVcjrQiboZ+SbJbS3hVANU+8CTYEN2IkbR6EC+7fVCJE
         JR1QzC4maa3CUE8uwhQ6b884ZIJ+5eYEEHHbi6O7eUHT0QHN3FTeKmeDwMMrDhZSFwAR
         JgmDG1YpFeF3t74UfnQ/KLnKyYs58lKwDMd9rJx0N6nKiMMeYBrYg1e3zUfnFaU3zzPv
         RtrH5fhEqO8E8MrIUOwX2F1cxPjKUtzNr6x3nid0ahasQcWcU5COzOjUIvdtg6D72mrv
         HrAf2LbSTRMg0Aasdw/tZHwKF0prmqPGjcWPMiSmrLzcusrorZDsG4hhzjdEZgDBaniM
         /fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716500098; x=1717104898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7a2uMVZssHO/XdZkFjaZx6Fve2Wj78fROEuqBTUEKo=;
        b=S2tKTc9zs4GP0P6M+iWmo5N0IbehRGmmwDcxp694tpb5BG7pU68dp6FGBdmwVAUmUC
         HXG2Qf94zGuH4KSC2HmQ1RYF4kHH9f9FPnWs2wX89t3DCnN3ueffW2SmUGzngUEvJFLD
         Zr+DQASAn5oJgUGanu9hcLWgC0kNh9G45V1+i9S8crAiZinvBkD8uiXoE6hGXvMxoSic
         bTXBl1jODz/GxWexMa+/uxgCFAb3UZv4mgo5e/IOx6v9F4QM9k6zQP4+Emg/9CYBcp88
         4aNma4F11TI+ADALHw8Rm2DMFUtY1d45ut3n3p80DHS71xVg+0RI3UEj1zremdDPLJ/U
         8KPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs/S48aTgdnjR5FkPXxrIQADUrqIaHceQuMW8aoOPECmdDFuxCXvasuUfSwUsBWBMRJdlz6576Xq2OEykXW3QPHc0ZLuA=
X-Gm-Message-State: AOJu0YxZKM3KXm72SBt318tnjqJicf9ykjSJ/VgWOk+mpWzH9N+vZAB9
	OQFwqhr2txj98XSoFTPYJFzU3J1VRLRto3H29JX2PSKWlGK1x+zn
X-Google-Smtp-Source: AGHT+IHg64GfV68qCaL9nLaV71GpQJxYCS/dHS/c9zQ8wKfbt4plO5szkSRDbRHEZbACBIBwzwC+Ng==
X-Received: by 2002:a17:902:ea0a:b0:1f2:fd9a:dbf3 with SMTP id d9443c01a7336-1f4486d1fa4mr5743115ad.11.1716500097727;
        Thu, 23 May 2024 14:34:57 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9dd519sm399235ad.298.2024.05.23.14.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:34:57 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Rob Clark <robdclark@chromium.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	iommu@lists.linux.dev (open list:IOMMU SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/arm-smmu: Pretty-print context fault related regs
Date: Thu, 23 May 2024 14:34:47 -0700
Message-ID: <20240523213452.144108-1-robdclark@gmail.com>
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

