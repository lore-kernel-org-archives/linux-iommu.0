Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581EA920
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344998; cv=none; b=hNOOXGdm74ZX1L3vSUclQFHbR9i8znOe5+zyvOtz/fRpmL7sFanwPafpeRVGUN/pR6hljtkf9qxzqSjD8y0WSqrqtBb+0SnhDfalf71n+vZn2FhZSq2tjxiaFH550j1ow6tc7tNaFIBD/I1SOO6Uid7ad3rA3J8Ag3VRrEXt5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344998; c=relaxed/simple;
	bh=Poz4SCs49YW7HgnH1y2i1KMJOF+RxrMdU7g65yvq9uU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g+qJMsasd/dCjbtf38yU8ulaonqQXIe9lWYtF1qGssXNveDK4f767zfHAUjbZfki2oEsRiKBwK2FaqiW4AB0GwTih51J3an5ng4GTJTJUAzZqI4eJhZOIMwA0guQILiQppTPRHa3EmcHQfkTci5E18NFgEjtuNYIgvSFtgVLjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaPhx2X/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaPhx2X/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224191d9228so123841315ad.3
        for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 17:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742344994; x=1742949794; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQcl8HgMjJZ77I0KLuf92BopxolC2Tva2yytHW9cQsg=;
        b=PaPhx2X/qeUGSuhe47ooBaLxc0wjaw5bz9/ONNTPGvK2CD/PJqsWe40/l4koBdfXAH
         uvTntfbQyZpQGFfJkUHDdNwYlNpK5eeuYQtMrlT7MPIcfvxhPf/D+MtDwOJUNRU9iPsP
         fZx2vCdUpKAEhangFrV5rNsoPffg54aHHvmHEEFx6MIVu748aexLiPeU7HDv3s14spBZ
         7hKVnWzsnpXVsHGZGyASQyZ9W28a1PdO8CTyS6lWWb2e+q+HbO60PyqwAn3nw9jHfXob
         HrB8f95zIedewweT7M1Ycn7ih6s+JZ0B0wd9spg25DCIfaZ4pb5/lCCrytCw9rr7qmA7
         TB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344994; x=1742949794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQcl8HgMjJZ77I0KLuf92BopxolC2Tva2yytHW9cQsg=;
        b=hk/pruTWt15GyhWsFLW/UgUO7QDU19tsj0v8ZtJt0facw9Meawmr2NBt50mRit8LRz
         D3o0/zIRPxB96HZE4xbsjOHgtE3zZG1krTg4tx66SKL6TW2FnJ0fJn8utGABRrCVuvZd
         6p7mVGRt2BDwfeJi0VrvZ1kDHSwJAEfso5P4+Qy2C73HveOxVhBvWKeTYX8IJiNpXiGf
         QDZroYeNphU0pE3s/oq4Mpzk4GakzUihfGzHScupOICb6ckXekTdyNSMwLQaQmocZE4S
         GzuQtLKkR31/4FRCEe1prDdbheq56CeMqtDPNLDV8zxlxkB+GCvmozUoPYpfFXcKzpMv
         YB1A==
X-Forwarded-Encrypted: i=1; AJvYcCUbDRmDz3Uzzo06oM11mVSyFgWuj84jsQbSyXsSbQm4q9P7rX6w2IAFcNFFw8h+3dbMfojtOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDX0XDZAfB1b0kENg8LV/3jUzVn7nScAI1XQ3kygJBvL36zmo0
	zJs6jAX784j1vay5kkQN+X0O4cQrP5U0SOOlIGWOAfkXth+cCQLDTDfdak/M/LdsqN8ms6HY4g=
	=
X-Google-Smtp-Source: AGHT+IFd9xq8mMjtufBz+kwDPf+O/SyhRVAC3Ii2DYhnezqRNbE9/WuA4/V8dZuejkXADiXeGBxZElETcQ==
X-Received: from pfne8.prod.google.com ([2002:aa7:8248:0:b0:732:547c:d674])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12d5:b0:1f6:2d39:8713
 with SMTP id adf61e73a8af0-1fbebb8cb0bmr1213275637.19.1742344994547; Tue, 18
 Mar 2025 17:43:14 -0700 (PDT)
Date: Wed, 19 Mar 2025 00:42:51 +0000
In-Reply-To: <20250319004254.2547950-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250319004254.2547950-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319004254.2547950-3-praan@google.com>
Subject: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add a helper to wait till cmdq drains
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Before we suspend SMMU, we want to ensure that all commands have been
consumed by the SMMU's command queue, i.e. the cmdq is empty. Add a
helper function that waits till the cmdq is empty using `queue_empty`.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 80362d9f293b..f65d9bca0392 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -754,6 +754,30 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
 }
 
+/*
+ * Wait until the SMMU cmdq is empty
+ * Must be called with the cmdq lock held in some capacity.
+ */
+static int arm_smmu_cmdq_poll_until_empty(struct arm_smmu_device *smmu,
+					  struct arm_smmu_cmdq *cmdq,
+					  struct arm_smmu_ll_queue *llq)
+{
+	struct arm_smmu_queue_poll qp;
+	int ret = 0;
+
+	queue_poll_init(smmu, &qp);
+	llq->val = READ_ONCE(cmdq->q.llq.val);
+	do {
+		if (queue_empty(llq))
+			break;
+
+		ret = queue_poll(&qp);
+		llq->cons = readl(cmdq->q.cons_reg);
+	} while (!ret);
+
+	return ret;
+}
+
 static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
 					u32 prod, int n)
 {
-- 
2.49.0.rc1.451.g8f38331e32-goog

