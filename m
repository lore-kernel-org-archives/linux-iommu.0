Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154522DFA5
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736910215; cv=none; b=Xw/vz9ZppIMX2Lprp3dP51CAbOdK4X/N7ZFoaZJueIFsgJFk9Fz5Neo5M1Y9pKsfqji3JgbmEK/5d0jRTlJZPYB8ndKHL+BUuGFIzNb6QvhV6pjcw3F6EUdwbqWLJd0uC3XBbWYIFeYsUueNvdJ/8xEf6sytbNtnduWf4+k1Djw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736910215; c=relaxed/simple;
	bh=pKHvVYHDRn0ecGOYQL39aWwE9MzaJjTut+z7liM0ME0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HnXOS6W6iVJMLnZKsCyYjJ/oAzykqC9M83cjt/lRdQOilaiBgBTF4zohq8SwgwTZtCuM25+CYHcQYZyZUTiOqslMyVl26TKO95hJFN1u9aEvLrEk7z54XzczpzSmCX34d1gLrIBkbx4lgCfPd+nf/1wtLPGqtWphK3ADYM4ClZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NlDSK42a; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NlDSK42a"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216281bc30fso132284745ad.0
        for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 19:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1736910213; x=1737515013; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C2l3cW3A35MwF8MmccDu9nYzUOGU3WhdqnIlz5R1nkM=;
        b=NlDSK42ajCnF6RBnfRGnZkXNdYfqtMy+H2CbPyp1Xt9kSi1rKcdDouXoH+iXl60aOH
         9LvPX5wLB1goa2EzTxCRUAvlnqtUADGDdqVZaqiSh5Yzcdy+09q5lk+w46YsvL9Xckv+
         jA45dolM4vWMELtEMFYhlRtZvS+BMv6CVMKmfKa/Nf0AsuK9+auI4JXlNDSzooNaUBv4
         FifITamezz5MINyCOuflx64ywMnhDwbrHR0TQfMFeo3CeMisbBtvP2VCAI2Q+S1k9iNB
         P9oqGUW7ri4uhk7V7hRxLoA8rUS+TP/nAFUOMc7e0PXnNBFRHIGs8xMA3Sy59XlL4HCb
         y8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736910213; x=1737515013;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2l3cW3A35MwF8MmccDu9nYzUOGU3WhdqnIlz5R1nkM=;
        b=uoc2Xlh0ypjgkQeR3Lq2WWwNLBajmW21YyKTIIP9qYOZy7S5SKv7yNihv7Hij+OpyS
         y1vUgZ7oMdI7TgckNHPH4H0L+i8wXVQcM3xfrTvH9c4U8YClL7FHXR1bPBcGeFnU3Xr4
         CRK+iuhlZyC3uTUyS7VsoPjbOSC9NxIRAZdzcXKW+xwCPUrFNvZ/dOpfbrEP3HKfZctk
         qUFrLdCbKigDD2Uk3PVm6GxbmKglH0M1Ye8Tuwk0ypaututFaXUt+m5YmEEM9tQ50dn7
         DZ+OuwX2a7RjUWXq0c5nM4Gchvb6sn1Y7lWn6EQUgFikDvaMjRpVUwO+O11OQunKyCFp
         smNA==
X-Forwarded-Encrypted: i=1; AJvYcCVysTQTzEqI19KA96haCBPbu2KMsce4Q2hnSS0e07Ckm/fzRNTvDTF5l13rlx29CF5tmd1h6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw4ZpZKVjW6ESm0QxwkQF3CVA2kEyortN2zu9lxUM+WUjkt7VY
	+caI5K03YHVrkWvTPC+Nxp76aTEeuLD6TO87rJIROdafyf2baJmcDFcGlAHbEXM=
X-Gm-Gg: ASbGnctVS23ntjS2lQgKaogrS/8zpchTxXJmCFnsn8sdiM+kNfq1XCM9bkbef3/X/oo
	9FJLxUBdBIh8SLe+BzNLHI7/3g0dvCVmzoIV3wI6vXYa48D8YOHVIUzMNxHAFZH2kVqvpgBMifb
	oyWTTtiHUl7j/rbRDwc19jFO1HoGrcdoQ6m4vbXZ1kbXhQJcnxQZJXADS6sZGsuJBfiOMrhmZrO
	5fsu9iLO+nqT46hzAeBg/4T//8co3/Byhx4g5OH688Wa8SFJE6Ao8AVVlSHx31olM7SO1E4UpSU
	DJg=
X-Google-Smtp-Source: AGHT+IGutP9CT/bKHGG/K5YQHtyEvJxs9HfNEL1yUqUDRQQkupgNCYnCJpWiQyiLvCI4Vu/2v7GT3g==
X-Received: by 2002:a05:6a20:7350:b0:1e0:cc4a:caab with SMTP id adf61e73a8af0-1e88d12c1e2mr42368431637.19.1736910212772;
        Tue, 14 Jan 2025 19:03:32 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40568dccsm8123668b3a.47.2025.01.14.19.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:03:32 -0800 (PST)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	luxu.kernel@bytedance.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/2] iommu/riscv: support HPM and interrupt handling
Date: Wed, 15 Jan 2025 11:03:06 +0800
Message-Id: <20250115030306.29735-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250115030306.29735-1-zong.li@sifive.com>
References: <20250115030306.29735-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Initialize the PMU and uninitialize it when driver is removed.
Interrupt handling is also implemented, and the handler needs
to be a primary handler instead of a threaded function because
pt_regs is empty when threading the IRQ. However, pt_regs is
required by perf_event_overflow.

Signed-off-by: Zong Li <zong.li@sifive.com>
Tested-by: Xu Lu <luxu.kernel@bytedance.com>
---
 drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8a05def774bd..20ae90471484 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -552,6 +552,62 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
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
+	/* Clear performance monitoring interrupt pending */
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP);
+
+	/* Process pmu irq */
+	riscv_iommu_pmu_handle_irq(&iommu->pmu);
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
@@ -1596,6 +1652,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
 	riscv_iommu_queue_disable(&iommu->cmdq);
 	riscv_iommu_queue_disable(&iommu->fltq);
+
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_pmu_uninit(&iommu->pmu);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
@@ -1635,6 +1694,10 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	if (rc)
 		goto err_queue_disable;
 
+	rc = riscv_iommu_hpm_enable(iommu);
+	if (rc)
+		goto err_hpm_disable;
+
 	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
 				    dev_name(iommu->dev));
 	if (rc) {
@@ -1653,6 +1716,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
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

