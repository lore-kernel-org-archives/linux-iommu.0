Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E06DF55
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374935; cv=none; b=hJigIQJwB7zMBilXtwpbyNgzAxkxx6zIPZb3b9xRDla/bg8nNSvEMKB9NsCLPBiWAY7q3/HGY97dV9iAx4Ev7rCZyf/rfdYSmExt0acHLo+GTcQghxNhtxp6+ZrZyZCjxLNLoj9tHcAMHVz1rwtyf4QGpKQlmR2gi69s7ErcDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374935; c=relaxed/simple;
	bh=AFqoKum5maZXoq29R1hOtMdbeMl8SDzKa1SfdPLj4w8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sEiPY/InjFwaiTDKFWwjdgpubpqd4FRm86u3CfRKA4GVe3xYkge3theE1FA4Dxrkm7knDlGKdxUau9VI+y5XxVFu6aiPMKBNZWNUzMOOF+RdSOAVDgB2eVCdI89xkFaasRuHXgHkIdW62jniXCmqYGgdloXaV+SiMqZyOaPPP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KRXkv+zL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KRXkv+zL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6c7cdec83so19211715ad.0
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374933; x=1718979733; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tlFDKoGPkyb3nGW5qL4azlR55hFLQbYBhLCB+CenNg8=;
        b=KRXkv+zLPNxGNyW5DVm+52/v5tDzfctyC3AoyNmrcu3RqrxYbLywLQ0cVem6E4OZHP
         9ko8+Jc8x9AIW+9dm3LkH+DF8M9I3KyFzhzVfiX/ia+2eiVgQsgBateeW25c5d/rKlDz
         +NtH8zCH6zSDVPDGEQ3eAS7UYbgzn0r9hHCu8GezagEjJ6u+7vZ59qp1+i8mU+pkCabu
         K/QnP3MwAuWlJ/n7hy0xKYhszDO06M6qApH6jvRNFu3WRfHTeEoqaqkh9ByWY2bAw5oD
         KN1H7f7Y3Nl4FpywPVaFufZMyUL2SlI1dEVKaStfA1hmZF5YbatLsRJhVYbYJIGOJ7ih
         5sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374933; x=1718979733;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlFDKoGPkyb3nGW5qL4azlR55hFLQbYBhLCB+CenNg8=;
        b=YllEHiVee/f3OAo8jH7zFzu8KQfh9ClXVylZI4uhZjAwx5Xm5WAdNFt+cmI2pAe5Rj
         BIzOBo1vpoYLm4ZgpDNoVa1wCI+ti1iP1B/aGR1PWqC053YI29no3RzzGhq0j/7pfXSp
         TM2A9Xh0bi0IKiT3mQT/4O9fHo9EyhZ/EGG084aJM7GqxoB97vIT9d3tirTM69DqGe43
         2vcSUqYAxomO2QWZTJpTkdbCstu3/UZpzrs2Di8BOsdojl2tleLhGlwvgN7XWKBZDSQz
         82lVgNQTmCNKmInoiGJVFqAL22Ll9gADo+GP4g2Ncew4VrcWwZk8VNwhFuLwCpRSqTeV
         Xsrg==
X-Forwarded-Encrypted: i=1; AJvYcCVSp06TPnQNOG32vf6yAYWYBbdQqhBUwGZQF6xB67EbhUYuAWmV2BHwEWP5YqV8sij3aYgIM3tZEK1KfibAf1WVUGEoCmU=
X-Gm-Message-State: AOJu0YwpmCeUZAaj2sRzOlYDA00c8xxw2lsehreCp7FWCVuW6uOZiDfe
	Ttuwk9nhZbRxXb0AO6MB0+JAYTz+7O1unTuAyWtjp/Qcq2PigvKNkOYaaYvlg60=
X-Google-Smtp-Source: AGHT+IE4q8GqM7rVw79GCJsFYmYJxenhwqq3dMfDvs+NWax7S8ItEx42VF35t3MI4KJSDGoZTtuT2g==
X-Received: by 2002:a17:902:7883:b0:1f7:35e0:5af4 with SMTP id d9443c01a7336-1f8627e18bcmr22056005ad.30.1718374933563;
        Fri, 14 Jun 2024 07:22:13 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:13 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/10] iommu/riscv: support HPM and interrupt handling
Date: Fri, 14 Jun 2024 22:21:48 +0800
Message-Id: <20240614142156.29420-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This patch initialize the pmu stuff and uninitialize it when driver
removing. The interrupt handling is also provided, this handler need to
be primary handler instead of thread function, because pt_regs is empty
when threading the IRQ, but pt_regs is necessary by perf_event_overflow.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8b6a64c1ad8d..1716b2251f38 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -540,6 +540,62 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * IOMMU Hardware performance monitor
+ */
+
+/* HPM interrupt primary handler */
+static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
+{
+	struct riscv_iommu_device *iommu = (struct riscv_iommu_device *)dev_id;
+
+	/* Process pmu irq */
+	riscv_iommu_pmu_handle_irq(&iommu->pmu);
+
+	/* Clear performance monitoring interrupt pending */
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP);
+
+	return IRQ_HANDLED;
+}
+
+/* HPM initialization */
+static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
+{
+	int rc;
+
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
+		return 0;
+
+	/*
+	 * pt_regs is empty when threading the IRQ, but pt_regs is necessary
+	 * by perf_event_overflow. Use primary handler instead of thread
+	 * function for PM IRQ.
+	 *
+	 * Set the IRQF_ONESHOT flag because this IRQ might be shared with
+	 * other threaded IRQs by other queues.
+	 */
+	rc = devm_request_irq(iommu->dev,
+			      iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IPSR_PMIP)],
+			      riscv_iommu_hpm_irq_handler, IRQF_ONESHOT | IRQF_SHARED, NULL, iommu);
+	if (rc)
+		return rc;
+
+	return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iommu->dev));
+}
+
+/* HPM uninitialization */
+static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
+{
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
+		return;
+
+	devm_free_irq(iommu->dev,
+		      iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IPSR_PMIP)],
+		      iommu);
+
+	riscv_iommu_pmu_uninit(&iommu->pmu);
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1612,6 +1668,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
 	riscv_iommu_queue_disable(&iommu->cmdq);
 	riscv_iommu_queue_disable(&iommu->fltq);
+
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_pmu_uninit(&iommu->pmu);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
@@ -1651,6 +1710,10 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	if (rc)
 		goto err_queue_disable;
 
+	rc = riscv_iommu_hpm_enable(iommu);
+	if (rc)
+		goto err_hpm_disable;
+
 	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
 				    dev_name(iommu->dev));
 	if (rc) {
@@ -1669,6 +1732,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_iodir_off:
+	riscv_iommu_hpm_disable(iommu);
+err_hpm_disable:
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
 err_queue_disable:
 	riscv_iommu_queue_disable(&iommu->fltq);
-- 
2.17.1

