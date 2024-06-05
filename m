Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19215155739
	for <iommu@lists.linux.dev>; Wed,  5 Jun 2024 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617485; cv=none; b=GNDWViIiTYJ9q0nyLmlQ8FeQqtsbidEwzJcgV0BzZY0kBNdwbR/CudSD3wcl53mPHeWYap6mwZhQd9RLJzcwmI8ErTU3N7kaP3qIX37gzdVtyBeDh04o0WR0EaEgTsKs70VGPUnRwjePBcEpy8nYJj9rbXpgVuqwkiOzp2aBo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617485; c=relaxed/simple;
	bh=AYdXzOi/+3MhvKkKsxvMYJSyqlyNTjNbRw7I9TePmTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lc+iiAdmAQV8SWidnzf0M6BMAuqDi4CeDhDz7uYFkNnq3RbSAIfb0GbsGZ0vzHX6HYu5yk7XO/PJQaFBuJCk7Foii0DJ9ehwYI928ZhYh/lUqnoJL1JTwFnuc3Nk6BRlEs4HIJuR/4XPq++sDw8vzxm1xFxbxLk+4PSe9DuswR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sCim+MHb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sCim+MHb"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-702492172e3so166765b3a.0
        for <iommu@lists.linux.dev>; Wed, 05 Jun 2024 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717617483; x=1718222283; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4qXMlGpKFmKsrTG7a5LCbQMsXJowMadHB0xL9z/+TE=;
        b=sCim+MHbT34GA43RBT7vPV2Oq3KLDcQne7VRBhFdF2AZRwwitGnPGiNeu26l2aff7b
         TlziGjqnieVuj+rUqVaFfq0LcxiI8yc1PqB3adEkPtHZrNP2a6V8SgBLf00UoSjzdJVi
         b+2yr1Bo7IY55VQ8xQqkt29FZ69FvhhghPQdPUCwh6ue/T5XQTA6NsBAC5z5poSenPho
         3ClDUax6ag/UtCE4ep5xkdi6lGGvlENMJrc0Xe5lKt3YqNOPRzEd4EM9X8Y+MnnBY5eh
         JD6P6oT4G2zO16OxZ9YWVB4iR98k6Q4iu1l9uPRV0Xvcc05YuSf0APwDuvH14TAEY71H
         /1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617483; x=1718222283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4qXMlGpKFmKsrTG7a5LCbQMsXJowMadHB0xL9z/+TE=;
        b=Qv4Ln6fD1hqzhdlS/sEEuZCiVEHuBTnBHghu+u+nLaubKgZwALUVWysKER9AnqcsRu
         q6u1coUgrSv/PZlGX65mJmNMQVvjfYoKJBrbv5960MrV4tCh+VihOrma1WEbtm28aCCr
         wEHLgyjretkthHEKb0sEdokJByNKYGQwHiccIXCXpcUo4BnTK+dpz4/iVK46ufm1MgOV
         MELt8V2d0AIwD7gDJYgPBG7yuLY++QhV6+RMBgMDUckE1Dq7MEriF7QOTOhjE8Pi+ddr
         KxXKhDeEzERZM3ndINCRmGIlhlrJbGBFpMF+hbHxpkMk8zfN8P/n0WvIaSJF5TGrJQTX
         81PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdtI5fh1B2YRgF22BbL+q1XHHOjX67LjadgmiPxAUHyDPh9KEtr6zOfzVMtDQ6N2GMfvMINIrdeBlugXVDCgp2l1WXq/s=
X-Gm-Message-State: AOJu0YzUA8dg++u+RZMEDz/YrW59jqL21yB51KI/0crGOrNkG0TieVti
	PzNreJorTEQRjyX2JY2Duk08o/HIdOvn/UBA8GEeIcPXi2iz6b9w6G1AIKISUow=
X-Google-Smtp-Source: AGHT+IGg4u8JkMWX4fHToDw+Mz7of2dj7MR6lYqtJPVLx71cMemV2dPE+GLuTwembihyzghs4rMJZg==
X-Received: by 2002:a05:6a21:819f:b0:1ac:f796:963c with SMTP id adf61e73a8af0-1b2b7177e4cmr3669852637.56.1717617483430;
        Wed, 05 Jun 2024 12:58:03 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70244900ee9sm8664209b3a.124.2024.06.05.12.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 12:58:02 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v7 4/7] iommu/riscv: Enable IOMMU registration and device probe.
Date: Wed,  5 Jun 2024 12:57:46 -0700
Message-Id: <530cd10360e180a3b8303319ac40a998312e02b0.1717612299.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717612298.git.tjeznach@rivosinc.com>
References: <cover.1717612298.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise IOMMU device and its core API.
Only minimal implementation for single identity domain type, without
per-group domain protection.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 223314f7ed0a..c54088bf138f 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
 
 #include "iommu-bits.h"
 #include "iommu.h"
@@ -36,6 +37,60 @@ static void riscv_iommu_disable(struct riscv_iommu_device *iommu)
 	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_PQCSR, 0);
 }
 
+static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
+					      struct device *dev)
+{
+	/* Global pass-through already enabled, do nothing for now. */
+	return 0;
+}
+
+static struct iommu_domain riscv_iommu_identity_domain = {
+	.type = IOMMU_DOMAIN_IDENTITY,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev = riscv_iommu_attach_identity_domain,
+	}
+};
+
+static int riscv_iommu_device_domain_type(struct device *dev)
+{
+	return IOMMU_DOMAIN_IDENTITY;
+}
+
+static struct iommu_group *riscv_iommu_device_group(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_device_group(dev);
+	return generic_device_group(dev);
+}
+
+static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
+{
+	return iommu_fwspec_add_ids(dev, args->args, 1);
+}
+
+static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_device *iommu;
+
+	if (!fwspec || !fwspec->iommu_fwnode->dev || !fwspec->num_ids)
+		return ERR_PTR(-ENODEV);
+
+	iommu = dev_get_drvdata(fwspec->iommu_fwnode->dev);
+	if (!iommu)
+		return ERR_PTR(-ENODEV);
+
+	return &iommu->iommu;
+}
+
+static const struct iommu_ops riscv_iommu_ops = {
+	.of_xlate = riscv_iommu_of_xlate,
+	.identity_domain = &riscv_iommu_identity_domain,
+	.def_domain_type = riscv_iommu_device_domain_type,
+	.device_group = riscv_iommu_device_group,
+	.probe_device = riscv_iommu_probe_device,
+};
+
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 {
 	u64 ddtp;
@@ -74,6 +129,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 
 void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
+	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
 }
 
@@ -99,5 +155,15 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		return dev_err_probe(iommu->dev, rc,
 				     "cannot register sysfs interface\n");
 
+	rc = iommu_device_register(&iommu->iommu, &riscv_iommu_ops, iommu->dev);
+	if (rc) {
+		dev_err_probe(iommu->dev, rc, "cannot register iommu interface\n");
+		goto err_remove_sysfs;
+	}
+
 	return 0;
+
+err_remove_sysfs:
+	iommu_device_sysfs_remove(&iommu->iommu);
+	return rc;
 }
-- 
2.34.1

