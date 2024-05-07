Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2287A15FA97
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091972; cv=none; b=eZtR61cR85Z/a8KDn3UnNcHBQStpQBxEMcKTDNtUtnFOrtLBp0PxY50eY7XI1mowSSgQs3Tq/Ot11ZRlZRgema4M6tEyjSfCOdkv4DX48UG5ywphzY71N9cvFMWf5jtp3lpTdMCh89SYvLngvlnItXhUKE8ehdhYTUlaingUeC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091972; c=relaxed/simple;
	bh=VZxNS2OxyzYq3m1acYYqTvZC3vZEhXDPbe+Lr3aCwho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fUM2zCVrFbqKnW3Zy7jPgL6E5/Mwe/RFTWoxPo90IMOhZ3IYYp1yBLVckkM4pJdjkSzRKXhSF595T2oA6f02CNjkzb/Irgdxq+jZYkF6tkKNHaAzXmeN+q39NNzXWn8sQYmaAsFjuyJHiZgiVPssI7T/Gv7PTCTSsjf6jCl0/Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GEEy2082; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GEEy2082"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f490b5c23bso719979b3a.3
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715091970; x=1715696770; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0jz4ENNoetocqIssCS0B2oXUtzcTlnoT1WDoFLx5sIU=;
        b=GEEy2082AKS1oQVSUa6JCGFfNRNKKa/tby8Sf9f2x4Z5upE/SUrmQumr3pc3darJXA
         J1/wQTzzTYQFEZp+Qd0N4Lz4cZI0mCikk2LszUGKJ9aJGiB3PpXTvDsuz5G+Fk/KX/zn
         cOVdP1bBKIQHoNFMIrdLnt6miIVTYWv0T4w/J86dt70WHKSdjDmN6K6JPBi+HDO/uasV
         I4EFr0dcCvrTGr11FL4XzM9gtcMwQx35/2PDvHtAGN7S90cimUnHQspNCWc5CRdsfWUK
         VGnkLvpEYnkY7zQ4ynTs/yzYRJFQ0mfgQB5aYKkz+Ao76RIfsSMaVvOkkG/Gcn18xZ7E
         9iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091970; x=1715696770;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jz4ENNoetocqIssCS0B2oXUtzcTlnoT1WDoFLx5sIU=;
        b=dekJzE+XNBCxayhO2yyGuqZ57EIif/Oc5YbxqwOIK57Ot5wblvFbyjCZbkjFSvYML0
         HyrZlY11zsgPu+uoZz/fWq7iECIhlxK1ZJj4BXx591JVubKA1JiOIMAjnyybj9oqEo39
         VnQRCpDMyc5ZBV7LalDRBM+hFrG385Dpb2WaTTc4q1k3msZa9eCHifAkdGPPoKQ6o1la
         pITnmB/xlWycBEJYtZZrwvHC4i09alJ2vVsrCxE0wRiz2mLgPvdEvzd7S7QW6owDXqv4
         hS3fh/p/hDf8OwtX+zZSaKfO5Jru1crJnRhemQf79FnXRhyFTE1I7JxvTVuzcmGrq2Aj
         jyfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW44/6Wrk5+FiUtpfyaj7aDFiUNPUxh8JehkAzyNibq2y50MtztDNDRGmVZvkOuHJYR866IeXc+nCV+StvCQqJc78zLiXg=
X-Gm-Message-State: AOJu0YwANaU8Opgx9SE/8tu/2gcjkEP6x0DcymtbAsR75nQ1q53n0mhQ
	RCzMyL2nMSNwOcJJXW0ClOsvKu8FbwFnAQFcZ4nyPzY7JXFDYjGL1yOo4zTzxNM=
X-Google-Smtp-Source: AGHT+IFFwJydlhv8Eo1uigoZzco+8G3QZGbkY7AV3d8a5KKB5Jnd/eMaJgfIknHgv405ntAxsJkBlA==
X-Received: by 2002:a05:6a20:9c97:b0:1af:9ee6:25c4 with SMTP id mj23-20020a056a209c9700b001af9ee625c4mr8750903pzb.42.1715091970500;
        Tue, 07 May 2024 07:26:10 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b006f44bcbe7e3sm7687554pfa.201.2024.05.07.07.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:26:10 -0700 (PDT)
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
Subject: [PATCH RFC RESEND 2/6] iommu/riscv: Support HPM and interrupt handling
Date: Tue,  7 May 2024 22:25:56 +0800
Message-Id: <20240507142600.23844-3-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240507142600.23844-1-zong.li@sifive.com>
References: <20240507142600.23844-1-zong.li@sifive.com>
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
 drivers/iommu/riscv/iommu.c | 59 +++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index ec701fde520f..e0bf74a9c64d 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -526,6 +526,56 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
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
+	if (!(iommu->caps & RISCV_IOMMU_CAP_HPM))
+		return 0;
+
+	/*
+	 * pt_regs is empty when threading the IRQ, but pt_regs is necessary
+	 * by perf_event_overflow. Use primary handler instead of thread
+	 * function for PM IRQ.
+	 */
+	rc = devm_request_irq(iommu->dev, iommu->irqs[RISCV_IOMMU_IPSR_PMIP],
+			      riscv_iommu_hpm_irq_handler, 0, NULL, iommu);
+	if (rc)
+		return rc;
+
+	return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iommu->dev));
+}
+
+/* HPM uninitialization */
+static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
+{
+	if (!(iommu->caps & RISCV_IOMMU_CAP_HPM))
+		return;
+
+	devm_free_irq(iommu->dev, iommu->irqs[RISCV_IOMMU_IPSR_PMIP], iommu);
+
+	riscv_iommu_pmu_uninit(&iommu->pmu);
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1551,6 +1601,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
 	riscv_iommu_queue_disable(&iommu->cmdq);
 	riscv_iommu_queue_disable(&iommu->fltq);
+
+	if (iommu->caps & RISCV_IOMMU_CAP_HPM)
+		riscv_iommu_pmu_uninit(&iommu->pmu);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
@@ -1590,6 +1643,10 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	if (rc)
 		goto err_queue_disable;
 
+	rc = riscv_iommu_hpm_enable(iommu);
+	if (rc)
+		goto err_hpm_disable;
+
 	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
 				    dev_name(iommu->dev));
 	if (rc) {
@@ -1608,6 +1665,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_iodir_off:
+	riscv_iommu_hpm_disable(iommu);
+err_hpm_disable:
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
 err_queue_disable:
 	riscv_iommu_queue_disable(&iommu->fltq);
-- 
2.17.1

