Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0182E62B7
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196047; cv=none; b=psND8pxUrPgmFrB6SDCoZn35mek59cAA9pQlz5wxFD6doV6zMfD/2f8Qoit8EJfFRatedXplFJzrs5arG4wmeinjxn4M4p7Ly2yJ9M20X2p1WTDQfLMcxGVOzJiDCkT3eu2qA5/QmyqpdTqVUOPo3Bfbmb2VHdJl/d+hUzefUl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196047; c=relaxed/simple;
	bh=jVFqPMJmqKPLot8HY3RDd8xBDdm/2ufQqUkn64mCS/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RwpHus5Sm5nuSmHihmBD2n9jQYuMGqj0baohrOzsgNr6uRopyl0P+FZ4knzMecLXSMF/yo8oR71k16LCAbICsZqY75tRKqQYuCQrFF6/ky7P+L0rdBhw+qR4dA8k4xwv9dDM+YdkFsx0f3VuyqknsrnfD0oQStZP8P831tOqCOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D8TEVp+x; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D8TEVp+x"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a77f807e4so6091863b3a.3
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196046; x=1776800846; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkFDaZGovwKOl39drZuQ8LnIMuQlzCO6C0fPxu8OYNw=;
        b=D8TEVp+xxCuYOzsjFOhI32C/HeIg3aYGFGU0/i1UwKVQry7byb0mXdSkPMfuwMmceP
         rpJQyKURTuiAnHRhpgu6ZcIJ8XNpkz1IJ38wbVBderajOJYJLaxwK3vvCWGEgThBwzlZ
         JFQA11/90fwVZfk97i/T4UywoYEIkR7OenIJivt0NHrtwsZdlN7FOrXAmwRstMLcPv9m
         mB/tnAi7ikoVmrgKuULNp2KPPbNetQB9/fp3nriN5wwiK3Lqyudu+XS7LucvBAFcn+gB
         bBDuyW0e5u6sTeraG9KFKP5Mz01C1CuBgTAbmKp1ZabC3Qe7Ae/zJF2tSKqD0nojNs1H
         t3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196046; x=1776800846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkFDaZGovwKOl39drZuQ8LnIMuQlzCO6C0fPxu8OYNw=;
        b=B28JHy23+x8gnZg3SYPfJlIAjOz8W/4EAv12APtUkbBOuTzy8zuF6SIRTDg52A964Z
         4FxxBPIXxRAeXMYd34KrWUr7gvdsoozfWrtMgVZZmoHHNXTnz/dJWrMs0TxjyNqVv0D0
         xAnSYlX01h2Mftfr3KuPA6EMFD8QllCBNIk35I3X/Mg81a/3G2qV/LP/hAYUGgksHxOF
         eeVfsg81j6YE2yIZJZBRnyYVz/OVSIqsrfpELhMzjCbAOyNDC367HjoWQgucE9Ao+/5W
         WfFVYZaITccvuwanMX/Enn2nOhjiX99kedWxD1LtgCMPBLaTclH1vsv0h6yKQdkmjOHE
         dFvA==
X-Gm-Message-State: AOJu0YxqAJAgxk7zpZjWnY8SqTg9AyOAPV6RZykYJeHdFrH6mn1I+gRN
	ojitANq+tyhyGvKUdFbULfayxZB0qLM0dJyhHie3qKB4yN2jqH+f22/6ymss6OQ1loC+G+JlWan
	qRPfFCiq7a1HElESIWUZFIcK33gSVAiN2G/okn/HUQ/Vmke8xrGVT4vCEjJQ8Q4dv4bZIi7t8qP
	8uZosXh2bWjYS0qu8YKs5Dz90BeeqXFg==
X-Received: from pfbdi7.prod.google.com ([2002:a05:6a00:4807:b0:82a:ff5:27d5])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3907:b0:81f:31c3:2e34
 with SMTP id d2e1a72fcca58-82f0c29fed7mr19278905b3a.25.1776196045259; Tue, 14
 Apr 2026 12:47:25 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:46:58 +0000
In-Reply-To: <20260414194702.1229094-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414194702.1229094-7-praan@google.com>
Subject: [PATCH v6 06/10] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to gate
 CMDQ submissions
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
queue's producer index to safely gate command submissions during device
suspension.

The flag embeds the suspend state directly into the existing global state
The flag checked in the compxchg loop in arm_smmu_cmdq_issue_cmdlist(),
which acts as a Point of Commitment, ensuring that no indices are
reserved or committed once the SMMU begins suspending.

This prevents a situation of "abandoned batches" where indices are
incremented but commands are never written, which would otherwise
lead to timeout during the drain poll.

Update queue_inc_prod_n() to preserve this flag during index
calculations, ensuring that any in-flight commands that successfully
passed the point of commitment can proceed to completion while the
flag remains set.

Suggested-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 +++++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4fa452465b4d..93ce9ea81991 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -209,7 +209,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
 {
 	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + n;
-	return Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
+
+	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
 }
 
 static void queue_poll_init(struct arm_smmu_device *smmu,
@@ -818,8 +819,25 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	do {
 		u64 old;
 
+		/*
+		 * If the SMMU is suspended/suspending, any new CMDs are elided.
+		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
+		 * our new indices yet, we can safely bail. Once the indices are
+		 * committed, we MUST write valid commands to those slots to
+		 * avoid indefinite polling in the drain function.
+		 */
+		if (Q_STOP(llq.prod)) {
+			local_irq_restore(flags);
+			return 0;
+		}
+
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
+
+			/* Avoid waiting for space if the SMMU is suspending */
+			if (Q_STOP(READ_ONCE(cmdq->q.llq.prod)))
+				return 0;
+
 			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 001734bc3c7d..4bace6a85d29 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -389,6 +389,8 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
 
 #define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
+#define CMDQ_PROD_STOP_FLAG		(1U << 30)
+#define Q_STOP(p)			((p) & CMDQ_PROD_STOP_FLAG)
 
 /*
  * This is used to size the command queue and therefore must be at least
-- 
2.54.0.rc0.605.g598a273b03-goog

