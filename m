Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D218F2F0
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419929; cv=none; b=Cxc77AKC4vuVRc75lk4eztEo/N3mMkrwRa3pMiPhimY9eL+rwFoytVsEtDh4F0vP+NedcLLxzYSH7qPwiAiVRTuDuAdyltKuSd/96HUA9ud9BHJFntQKw2lde8QvTSM9zX4IVuUKbV+cowhth+7VZ9vsGLd2lqhILJfFlr6QUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419929; c=relaxed/simple;
	bh=Qg1KyEqVbJ9yqKTEMAuBywYLT9R2R4enwl8NoPA/WxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjuzLhLZE3eozEUcuu0lDqPAPyV46zd4q7enoFwupkFgff+lARU5PQWkhxWsVFoWllWDeQcmXaJeH8yZRWSYKpu9NOwPVhzfhHrbuPOCsysDN/L/4oKyTFyZ0bs4IJaqgBROWPIvQ6jAIc5U7G+XWOP7Uc9CPia1w4P2GEA0/WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPypThrg; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPypThrg"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5c21c68b786so797226eaf.0
        for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719419926; x=1720024726; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SWzieAW4a+lvny1okz+Epi3m5sR5cLacEd8KBGZql9g=;
        b=WPypThrgnFkI+LQgCSzYDE8HSZdK5hgZMJV29euK0gYVN8hcSEbPlPDfPVBBJ0Q2xq
         YWd9QOMOdF90wNx+SP3sMARDijQo1AyN4xulWdzhK0aXi1LV+QYvEGf1IaMKAkKkzJgk
         ehIt+D0OhpsNbos9UoTguSRlD/hSHOhqFgJkSqkUF60F7P8YNuWRwbHMfjzPN33j/v0O
         /VSPkV5Nk0pt97aP571fTuZsYXOrqTHEGaKSE6yh7no8RSz3bRqsC44YSrIV17tRpkOL
         YnFU5hVSLbNfbKQgJHR3noD/W/Z4QxNVKLYPfhLXFLm9odGd4nJ615l/8ngTMGye+BS1
         7S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719419926; x=1720024726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWzieAW4a+lvny1okz+Epi3m5sR5cLacEd8KBGZql9g=;
        b=T2ltTtrQX8aXhXCxI0t10ZQ2yQMU4PYZDxUX6Ujor73rVeNB19A3fNKImNIz3izYCv
         Ks4TTaWBJPXZLCWlBOo+so4se/5JuhFZ+A/rCRXLpFMTek1RYo4rT6btoYsu5cZ2FqLz
         9JIyfAEp7cktwyhR+X28TMMXgsNiUgjUuEehB16ErapGpG4NYg6pEp/Dk8xTjgVK2zHl
         iMmSGI2JyL+C550/EHmqsyFOOQF+ZTIT60qq084OPBnJKB2/QZ563bqTc4gIik+valUc
         JPLy47/RJ46QsS27fdWH+mGjtuDXQokB4i+glcnPS+R3OIdD5VnxZc7GocrVbWvJCbGN
         SE1Q==
X-Gm-Message-State: AOJu0YwboJTWCIZEVUxZC0RqjAMH3C0MzAW6Wb8SxaZCbUUG5btIoGNu
	/hdZEZrYobfsblDLpjL3j24cyQNUf2wNJka4wuPcqfVWIkdYyIonZPAvrw==
X-Google-Smtp-Source: AGHT+IF32yp5lqZIJHIVEYNwMPOPqn40IzoSCvEsTm7oJ/KwT63/UUbxgksu4RHOILX8ivphZ4mRHA==
X-Received: by 2002:a05:6358:998d:b0:19f:38a0:f507 with SMTP id e5c5f4694b2df-1a23c02ab11mr1433148055d.5.1719419926096;
        Wed, 26 Jun 2024 09:38:46 -0700 (PDT)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba5b5f58sm8985778a12.73.2024.06.26.09.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:38:44 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Pranjal Shrivastava <praan@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iommu/arm-smmu: Pretty-print context fault related regs
Date: Wed, 26 Jun 2024 09:38:37 -0700
Message-ID: <20240626163842.205631-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.45.2
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
I kept with the dev_err, which matches qcom_smmu_context_fault.  It is
only adding two extra lines, and it is ratelimited.

I also converted qcom_smmu_context_fault() to use the helpers to do the
parsing, rather than more or less duplicating.

 .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 21 +++---
 drivers/iommu/arm/arm-smmu/arm-smmu.c         | 70 ++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h         | 58 +++++++++------
 3 files changed, 110 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
index 552199cbd9e2..ee7eab273e1a 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
@@ -429,22 +429,17 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *dev)
 		phys_addr_t phys_atos = qcom_smmu_verify_fault(smmu_domain, iova, fsr);
 
 		if (__ratelimit(&_rs)) {
+			char buf[80];
+
 			dev_err(smmu->dev,
 				"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
 				fsr, iova, fsynr, cbfrsynra, idx);
-			dev_err(smmu->dev,
-				"FSR    = %08x [%s%s%s%s%s%s%s%s%s], SID=0x%x\n",
-				fsr,
-				(fsr & 0x02) ? "TF " : "",
-				(fsr & 0x04) ? "AFF " : "",
-				(fsr & 0x08) ? "PF " : "",
-				(fsr & 0x10) ? "EF " : "",
-				(fsr & 0x20) ? "TLBMCF " : "",
-				(fsr & 0x40) ? "TLBLKF " : "",
-				(fsr & 0x80) ? "MHF " : "",
-				(fsr & 0x40000000) ? "SS " : "",
-				(fsr & 0x80000000) ? "MULTI " : "",
-				cbfrsynra);
+
+			arm_smmu_parse_fsr(buf, fsr);
+			dev_err(smmu->dev, "FSR: %s\n", buf);
+
+			arm_smmu_parse_fsynr0(buf, fsynr);
+			dev_err(smmu->dev, "FSYNR0: %s\n", buf);
 
 			dev_err(smmu->dev,
 				"soft iova-to-phys=%pa\n", &phys_soft);
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 87c81f75cf84..7f5ca75d5ebe 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -405,12 +405,67 @@ static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
 	.tlb_add_page	= arm_smmu_tlb_add_page_s2_v1,
 };
 
+void arm_smmu_parse_fsr(char buf[80], u32 fsr)
+{
+	static const struct {
+		u32 mask;
+		const char *name;
+	} fsr_bits[] = {
+		{ ARM_SMMU_CB_FSR_MULTI,  "MULTI"  },
+		{ ARM_SMMU_CB_FSR_SS,     "SS"     },
+		{ ARM_SMMU_CB_FSR_UUT,    "UUT"    },
+		{ ARM_SMMU_CB_FSR_ASF,    "ASF"    },
+		{ ARM_SMMU_CB_FSR_TLBLKF, "TLBLKF" },
+		{ ARM_SMMU_CB_FSR_TLBMCF, "TLBMCF" },
+		{ ARM_SMMU_CB_FSR_EF,     "EF"     },
+		{ ARM_SMMU_CB_FSR_PF,     "PF"     },
+		{ ARM_SMMU_CB_FSR_AFF,    "AFF"    },
+		{ ARM_SMMU_CB_FSR_TF,     "TF"     },
+	};
+	char *p = buf;
+
+	p += sprintf(p, "FORMAT=%u",
+		     (u32)FIELD_GET(ARM_SMMU_CB_FSR_FORMAT, fsr));
+
+	for (int i = 0; i < ARRAY_SIZE(fsr_bits); i++)
+		if (fsr & fsr_bits[i].mask)
+			p += sprintf(p, "|%s", fsr_bits[i].name);
+}
+
+void arm_smmu_parse_fsynr0(char buf[80], u32 fsynr)
+{
+	static const struct {
+		u32 mask;
+		const char *name;
+	} fsynr0_bits[] = {
+		{ ARM_SMMU_CB_FSYNR0_WNR,    "WNR"    },
+		{ ARM_SMMU_CB_FSYNR0_PNU,    "PNU"    },
+		{ ARM_SMMU_CB_FSYNR0_IND,    "IND"    },
+		{ ARM_SMMU_CB_FSYNR0_NSATTR, "NSATTR" },
+		{ ARM_SMMU_CB_FSYNR0_PTWF,   "PTWF"   },
+		{ ARM_SMMU_CB_FSYNR0_AFR,    "AFR"    },
+	};
+	char *p = buf;
+
+	p += sprintf(p, "S1CBNDX=%u",
+		     (u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_S1CBNDX, fsynr));
+
+	for (int i = 0; i < ARRAY_SIZE(fsynr0_bits); i++)
+		if (fsynr & fsynr0_bits[i].mask)
+			p += sprintf(p, "|%s", fsynr0_bits[i].name);
+
+	p += sprintf(p, "|PLVL=%u",
+		     (u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_PLVL, fsynr));
+}
+
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 {
 	u32 fsr, fsynr, cbfrsynra;
 	unsigned long iova;
 	struct arm_smmu_domain *smmu_domain = dev;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
 	int idx = smmu_domain->cfg.cbndx;
 	int ret;
 
@@ -423,13 +478,22 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
 
 	ret = report_iommu_fault(&smmu_domain->domain, NULL, iova,
-		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+		fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
+
+	if (ret == -ENOSYS && __ratelimit(&rs)) {
+		char buf[80];
 
-	if (ret == -ENOSYS)
-		dev_err_ratelimited(smmu->dev,
+		dev_err(smmu->dev,
 		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
 			    fsr, iova, fsynr, cbfrsynra, idx);
 
+		arm_smmu_parse_fsr(buf, fsr);
+		dev_err(smmu->dev, "FSR: %s\n", buf);
+
+		arm_smmu_parse_fsynr0(buf, fsynr);
+		dev_err(smmu->dev, "FSYNR0: %s\n", buf);
+	}
+
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 4765c6945c34..763ea52fca64 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -196,34 +196,46 @@ enum arm_smmu_cbar_type {
 #define ARM_SMMU_CB_PAR_F		BIT(0)
 
 #define ARM_SMMU_CB_FSR			0x58
-#define ARM_SMMU_FSR_MULTI		BIT(31)
-#define ARM_SMMU_FSR_SS			BIT(30)
-#define ARM_SMMU_FSR_UUT		BIT(8)
-#define ARM_SMMU_FSR_ASF		BIT(7)
-#define ARM_SMMU_FSR_TLBLKF		BIT(6)
-#define ARM_SMMU_FSR_TLBMCF		BIT(5)
-#define ARM_SMMU_FSR_EF			BIT(4)
-#define ARM_SMMU_FSR_PF			BIT(3)
-#define ARM_SMMU_FSR_AFF		BIT(2)
-#define ARM_SMMU_FSR_TF			BIT(1)
-
-#define ARM_SMMU_FSR_IGN		(ARM_SMMU_FSR_AFF |		\
-					 ARM_SMMU_FSR_ASF |		\
-					 ARM_SMMU_FSR_TLBMCF |		\
-					 ARM_SMMU_FSR_TLBLKF)
-
-#define ARM_SMMU_FSR_FAULT		(ARM_SMMU_FSR_MULTI |		\
-					 ARM_SMMU_FSR_SS |		\
-					 ARM_SMMU_FSR_UUT |		\
-					 ARM_SMMU_FSR_EF |		\
-					 ARM_SMMU_FSR_PF |		\
-					 ARM_SMMU_FSR_TF |		\
+#define ARM_SMMU_CB_FSR_MULTI		BIT(31)
+#define ARM_SMMU_CB_FSR_SS		BIT(30)
+#define ARM_SMMU_CB_FSR_FORMAT		GENMASK(10, 9)
+#define ARM_SMMU_CB_FSR_UUT		BIT(8)
+#define ARM_SMMU_CB_FSR_ASF		BIT(7)
+#define ARM_SMMU_CB_FSR_TLBLKF		BIT(6)
+#define ARM_SMMU_CB_FSR_TLBMCF		BIT(5)
+#define ARM_SMMU_CB_FSR_EF		BIT(4)
+#define ARM_SMMU_CB_FSR_PF		BIT(3)
+#define ARM_SMMU_CB_FSR_AFF		BIT(2)
+#define ARM_SMMU_CB_FSR_TF		BIT(1)
+
+void arm_smmu_parse_fsr(char buf[80], u32 fsr);
+
+#define ARM_SMMU_FSR_IGN		(ARM_SMMU_CB_FSR_AFF |		\
+					 ARM_SMMU_CB_FSR_ASF |		\
+					 ARM_SMMU_CB_FSR_TLBMCF |	\
+					 ARM_SMMU_CB_FSR_TLBLKF)
+
+#define ARM_SMMU_FSR_FAULT		(ARM_SMMU_CB_FSR_MULTI |	\
+					 ARM_SMMU_CB_FSR_SS |		\
+					 ARM_SMMU_CB_FSR_UUT |		\
+					 ARM_SMMU_CB_FSR_EF |		\
+					 ARM_SMMU_CB_FSR_PF |		\
+					 ARM_SMMU_CB_FSR_TF |		\
 					 ARM_SMMU_FSR_IGN)
 
 #define ARM_SMMU_CB_FAR			0x60
 
 #define ARM_SMMU_CB_FSYNR0		0x68
-#define ARM_SMMU_FSYNR0_WNR		BIT(4)
+#define ARM_SMMU_CB_FSYNR0_PLVL		GENMASK(1, 0)
+#define ARM_SMMU_CB_FSYNR0_WNR		BIT(4)
+#define ARM_SMMU_CB_FSYNR0_PNU		BIT(5)
+#define ARM_SMMU_CB_FSYNR0_IND		BIT(6)
+#define ARM_SMMU_CB_FSYNR0_NSATTR	BIT(8)
+#define ARM_SMMU_CB_FSYNR0_PTWF		BIT(10)
+#define ARM_SMMU_CB_FSYNR0_AFR		BIT(11)
+#define ARM_SMMU_CB_FSYNR0_S1CBNDX	GENMASK(23, 16)
+
+void arm_smmu_parse_fsynr0(char buf[80], u32 fsynr);
 
 #define ARM_SMMU_CB_FSYNR1		0x6c
 
-- 
2.45.2

