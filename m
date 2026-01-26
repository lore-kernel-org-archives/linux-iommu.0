Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701DA339B41
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440328; cv=none; b=XO8VARA9J017gNZTT+35vLiM6LO2fF8m1Y/4bkhVTNcbnBDkbCOudK13GzKOBiYOVGI0GXgRUftdMrICMUYIft8zeDM4x53BLvQPOvEfyS05jgn7QdFZFYHNoUvjN8kE5LZ15Yat5gwLQfnYaKr+MqT81GHRbQWfiCs1tg4SVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440328; c=relaxed/simple;
	bh=Mz71ZetGFkmBboyQh0KSPHJWliWIpr/rxV7Xv/u75/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uXai4+ygXhHGzJ5Hykd9OG1JD3Yk8bbHOyK5pjNTxu2s1C80YXIv/qFqox8IjppA5tzYXV+4eBEgrvz8z9aHbzmz7EcVfx83kz0Hcq/UY5AkKmoDYO/g+1pgB3ywcoBhiHe9USFz+xEtWuXmJHiWbEC84sGzD13RDNCGQ/WT2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3Uh6dB8; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3Uh6dB8"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so2941020a12.3
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769440327; x=1770045127; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=StajiDd2kCVLarJU4qeL1MtxhvxdWFDkX2CnKRxEzqE=;
        b=U3Uh6dB8vyS8YuGsaGK3fUt6YDlJcFw7xSSq8e/R2S7dttgQq45assWrmZ4lZ6YAEh
         GRHW6sVgxGmfxup//fUIQJ9HAJ5KPJIIsl8IT43TOD3MrLuTMmj3cEAw3OwCEzH/pRbi
         UzDrEcui4Fh2v//2eU2Wvh+NUS7brBAHb/t5KBFgo3flImnRoV64CS50IXFjRT4i2D5I
         N4W0Ptcud+/V2Ot3c0ouZWPzfM27LvogkZciiqN2A8niF1gcfLvSzoeTgVZGcKoqQQeZ
         ZkGfpJ728Pg2dj8suIPI7kqab9ZKaU8KgAd1z+Nr7pkOyIQqmf78mHFHC3Grc3VFq6mH
         NWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769440327; x=1770045127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StajiDd2kCVLarJU4qeL1MtxhvxdWFDkX2CnKRxEzqE=;
        b=kgPbqe2UlvbFXVBK2tIzLiJkdLckQSpo6rNSaxyVpkH9aoVzEYfi4iV9eZiG33aWkl
         zNGeProMPY1d0Z7M4d3T2xAVI5XyINYlessTdW3hIoBGvYIKKATUJRj5ouLYYwUTVzas
         sX34APSWZTFtZnyZNmJ2uOjcxmjh8byRNsubuJKY65JunWtn8T6FqHU4RydUdKoDGd5+
         pX7JFmhF7i8hwf0ZBa5ziaR1QZGIAKmqGHLFdy/ZfH/AwtkpgsAcj7cRWF1dgJXGn9IY
         iDG7N2u4rb2ccBSLOs38I6GSTWQQd8Hlei+Fp8jl5ph89l1F6b2vWrddxNihr/axf01T
         4u2g==
X-Gm-Message-State: AOJu0Yy58XLaBSEDLnO61u7bDMEVm027gHzH+a2dhK25/qLVMLS+lOlS
	tUs0A2hSGBXca2X7sYtZLhkZ/TJqomQB6bbmAitmljbKUlJj6CQTtAjKRhtQuuatTziF0Ttw7VM
	ghSgMfC1UHUXXg0vmKwk9PE7gqivzcs7XLJKRUcmZ/9snB1lCE9+mHAKzTzLs387kOcXbBul2VR
	CVFGOF3LKgFJL/noJ+WrxQVtQ75/QryA==
X-Received: from pgbfq20.prod.google.com ([2002:a05:6a02:2994:b0:c03:e88d:5782])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e598:b0:364:be7:6ffc
 with SMTP id adf61e73a8af0-38e9f1152ecmr4484110637.18.1769440326547; Mon, 26
 Jan 2026 07:12:06 -0800 (PST)
Date: Mon, 26 Jan 2026 15:11:49 +0000
In-Reply-To: <20260126151157.3418145-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126151157.3418145-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126151157.3418145-3-praan@google.com>
Subject: [PATCH v5 02/10] iommu/arm-smmu-v3: Add a helper to drain cmd queues
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Sairaj Kodilkar <sarunkod@amd.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Before we suspend SMMU, we want to ensure that all commands (especially
ATC_INV) have been flushed by the CMDQ, i.e. the CMDQs are empty.
Add a helper function that polls till the queues are dained.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 34 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d479fadc3fe6..014d08cdfb92 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -992,6 +992,40 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q)
+{
+	struct arm_smmu_queue_poll qp;
+	struct arm_smmu_ll_queue *llq = &q->llq;
+	int ret = 0;
+
+	queue_poll_init(smmu, &qp);
+	do {
+		if (queue_empty(llq))
+			break;
+
+		ret = queue_poll(&qp);
+		WRITE_ONCE(llq->cons, readl_relaxed(q->cons_reg));
+
+	} while (!ret);
+
+	return ret;
+}
+
+static int arm_smmu_drain_queues(struct arm_smmu_device *smmu)
+{
+	int ret;
+
+	/*
+	 * Since this is only called from the suspend callback where
+	 * exclusive access is ensured as nr_cmdq_users = 0 blocks new
+	 * command submissions to the cmdq, we can skip the cmdq locking.
+	 */
+	ret = arm_smmu_queue_poll_until_empty(smmu, &smmu->cmdq.q);
+
+	return ret;
+}
+
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
 				   struct iommu_page_response *resp)
 {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3c6d65d36164..4c04f63966eb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -985,6 +985,9 @@ int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_init(struct arm_smmu_device *smmu,
 		       struct arm_smmu_cmdq *cmdq);
 
+int arm_smmu_queue_poll_until_empty(struct arm_smmu_device *smmu,
+				    struct arm_smmu_queue *q);
+
 static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
 {
 	return dev_iommu_fwspec_get(master->dev)->flags &
-- 
2.52.0.457.g6b5491de43-goog

