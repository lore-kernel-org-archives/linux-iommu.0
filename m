Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A11362
	for <iommu@lists.linux.dev>; Tue,  3 Dec 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251760; cv=none; b=pDHmz1M13CDFpdw7PoAaPg5+3me+rRXI65sjoiF/iRUfU36g/X3pg1OjUI0YeVC2s/PDbwUB+9crnZNbC8Y4Cg2xhgQ/Zv9WHtjx8sX7feMlmm7QYhKJU7cnWK0kXkYGKhJujd2g5+cYWGMxf4wj1IT/EOVf7xaG6KNwdpMdUh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251760; c=relaxed/simple;
	bh=iCFX9+Oje5tCEElz/tO2MvgyLBwc70fT9cGH2TSJNUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B1XzrLicfX09KPzbI/WJXWP12L0Xs3gd+5MX+oFmI4YX63EDr+5qCCc6eehgnrpTyI2oa8Rkzsd9EAvoj5ycZiCZKWTBPn+DKoFREbJRjlnCYN1T0pl/mh4JX9eeV+BwAScs//MPJvS7jMEwF+mW4L6Jzh6PdjJUaMtO0ayAt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbOKvZ2r; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbOKvZ2r"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so1955769a91.0
        for <iommu@lists.linux.dev>; Tue, 03 Dec 2024 10:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733251758; x=1733856558; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kntFYO53ecwgb3vUexCkZl6su7KvmFgnNy+yxrRx5OU=;
        b=VbOKvZ2rygw9UHCdzklnYiDN7JFbQnFAb/+BFJ9BmIYWkqR0WYOVoaIhMBQj/HboPO
         YuTOwghUOBUubJ0SJLd7RxX5LrgdVH37Opye/7x1lzdsLV1Ojz4rrIzIIzMS/ba6Ng/8
         ZzoHDDuMmGOGh+jOpbZ94Z2CgaUhRcVtN8PXgHMP7rBEWoIYpUu0seI8MgE7ysuDRH9U
         sZRYFX1Gq9qI1h9iKxtUV48928RSDm934S/nM5E6ii2MwGQRbqN0FuqnL7nZIjlytCUp
         mviMXRV5XZYkqA1BBLC59W3kuaFij6UQ3+mpfxQ/SQMmJfiy0z42PnWtIDRJaryW5fhv
         Zuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733251758; x=1733856558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kntFYO53ecwgb3vUexCkZl6su7KvmFgnNy+yxrRx5OU=;
        b=gEafKzMA9Ut+p4byL0S3F1JULLUdjJPb2GxYfRLrx+S1IVrBS1ozul+MJDQH+CGQGN
         IKmzC3oC2tJSxvQS0RcMVY7ti1n+4ZhbyN+bi1FZ9DY8aAX64gCMs+E91aGs6CYLi6bo
         GYMJbMxdp25XqlWPVZwXH8Jb96PVOicyXN620jeDaEtorWs8dcoXyECTOeBEcgytqtWQ
         UhaE15vVQGTv8qH1O5rueC2mU2RViR+z1Uh2Ug4MSuuJkBUfopeUdbiBoY/CtTtuwYw6
         WejeI4ew5sFGb1OymuEXn2uBb/srE0KtouwrzqP/ngVMNHos2NxXQxnPo5k0d1SvmA3M
         7eOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqK40IdmiwoKJNlIOPqUPL3s8UaCBShcZZJO3+GLjJy+i1W8w689g8HskdWYm4+LwtS5nlKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yze43nR2YiYdPvql0WGjl52fn62V1TUIZyjkA2W2kt/X5Ag2EwJ
	Ig0qHY4e+KScAggTIwXvA/xoLNesab5WR5jjJRM9x3POEgd4GlxdeZrCZBykc/HVhDujjrQXOQ=
	=
X-Google-Smtp-Source: AGHT+IFrS4SGZaRHCvx9tjdmQELFcp0RZ9DxMDAdFkAR/gM7Ka7CLMao7v8KX2jiVVZOaZKq8tdoma1eqA==
X-Received: from pjf15.prod.google.com ([2002:a17:90b:3f0f:b0:2e2:9021:cf53])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2547:b0:2ee:f22a:61dd
 with SMTP id 98e67ed59e1d1-2ef01274f35mr4193589a91.32.1733251758115; Tue, 03
 Dec 2024 10:49:18 -0800 (PST)
Date: Tue,  3 Dec 2024 18:49:05 +0000
In-Reply-To: <20241203184906.2264528-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241203184906.2264528-1-praan@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203184906.2264528-2-praan@google.com>
Subject: [PATCH v6 1/2] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce `struct arm_smmu_event` to represent event records.
Parse out relevant fields from raw event records for ease and
use the new `struct arm_smmu_event` instead.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 55 ++++++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 18 +++++++
 2 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..3168bb31e145 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1757,17 +1757,34 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 }
 
 /* IRQ and event handlers */
-static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
+static void arm_smmu_decode_event(u64 *raw, struct arm_smmu_event *event)
+{
+	event->id = FIELD_GET(EVTQ_0_ID, raw[0]);
+	event->sid = FIELD_GET(EVTQ_0_SID, raw[0]);
+	event->ssv = FIELD_GET(EVTQ_0_SSV, raw[0]);
+	event->ssid = event->ssv ? FIELD_GET(EVTQ_0_SSID, raw[0]) : IOMMU_NO_PASID;
+	event->privileged = FIELD_GET(EVTQ_1_PnU, raw[1]);
+	event->instruction = FIELD_GET(EVTQ_1_InD, raw[1]);
+	event->s2 = FIELD_GET(EVTQ_1_S2, raw[1]);
+	event->read = FIELD_GET(EVTQ_1_RnW, raw[1]);
+	event->stag = FIELD_GET(EVTQ_1_STAG, raw[1]);
+	event->stall = FIELD_GET(EVTQ_1_STALL, raw[1]);
+	event->class = FIELD_GET(EVTQ_1_CLASS, raw[1]);
+	event->iova = FIELD_GET(EVTQ_2_ADDR, raw[2]);
+	event->ipa = raw[3] & EVTQ_3_IPA;
+	event->fetch_addr = raw[3] & EVTQ_3_FETCH_ADDR;
+}
+
+static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
+			       struct arm_smmu_event *event)
 {
 	int ret = 0;
 	u32 perm = 0;
 	struct arm_smmu_master *master;
-	bool ssid_valid = evt[0] & EVTQ_0_SSV;
-	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
 	struct iopf_fault fault_evt = { };
 	struct iommu_fault *flt = &fault_evt.fault;
 
-	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
+	switch (event->id) {
 	case EVT_ID_TRANSLATION_FAULT:
 	case EVT_ID_ADDR_SIZE_FAULT:
 	case EVT_ID_ACCESS_FAULT:
@@ -1777,35 +1794,35 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 		return -EOPNOTSUPP;
 	}
 
-	if (!(evt[1] & EVTQ_1_STALL))
+	if (!event->stall)
 		return -EOPNOTSUPP;
 
-	if (evt[1] & EVTQ_1_RnW)
+	if (event->read)
 		perm |= IOMMU_FAULT_PERM_READ;
 	else
 		perm |= IOMMU_FAULT_PERM_WRITE;
 
-	if (evt[1] & EVTQ_1_InD)
+	if (event->instruction)
 		perm |= IOMMU_FAULT_PERM_EXEC;
 
-	if (evt[1] & EVTQ_1_PnU)
+	if (event->privileged)
 		perm |= IOMMU_FAULT_PERM_PRIV;
 
 	flt->type = IOMMU_FAULT_PAGE_REQ;
 	flt->prm = (struct iommu_fault_page_request) {
 		.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
-		.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
+		.grpid = event->stag,
 		.perm = perm,
-		.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
+		.addr = event->iova,
 	};
 
-	if (ssid_valid) {
+	if (event->ssv) {
 		flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-		flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
+		flt->prm.pasid = event->ssid;
 	}
 
 	mutex_lock(&smmu->streams_mutex);
-	master = arm_smmu_find_master(smmu, sid);
+	master = arm_smmu_find_master(smmu, event->sid);
 	if (!master) {
 		ret = -EINVAL;
 		goto out_unlock;
@@ -1820,23 +1837,23 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
 	int i, ret;
+	u64 evt[EVTQ_ENT_DWORDS];
+	struct arm_smmu_event event = {0};
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
-	u64 evt[EVTQ_ENT_DWORDS];
 
 	do {
 		while (!queue_remove_raw(q, evt)) {
-			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
-
-			ret = arm_smmu_handle_evt(smmu, evt);
+			arm_smmu_decode_event(evt, &event);
+			ret = arm_smmu_handle_evt(smmu, &event);
 			if (!ret || !__ratelimit(&rs))
 				continue;
 
-			dev_info(smmu->dev, "event 0x%02x received:\n", id);
-			for (i = 0; i < ARRAY_SIZE(evt); ++i)
+			dev_info(smmu->dev, "event 0x%02x received:\n", event.id);
+			for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
 				dev_info(smmu->dev, "\t0x%016llx\n",
 					 (unsigned long long)evt[i]);
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1e9952ca989f..89fe2eee5856 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -455,6 +455,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define EVTQ_1_TT_READ			(1UL << 44)
 #define EVTQ_2_ADDR			GENMASK_ULL(63, 0)
 #define EVTQ_3_IPA			GENMASK_ULL(51, 12)
+#define EVTQ_3_FETCH_ADDR		GENMASK_ULL(51, 3)
 
 /* PRI queue */
 #define PRIQ_ENT_SZ_SHIFT		4
@@ -771,6 +772,23 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+struct arm_smmu_event {
+	u8				stall : 1,
+					ssv : 1,
+					privileged : 1,
+					instruction : 1,
+					s2 : 1,
+					read : 1;
+	u8				id;
+	u8				class;
+	u16				stag;
+	u32				sid;
+	u32				ssid;
+	u64				iova;
+	u64				ipa;
+	u64				fetch_addr;
+};
+
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
-- 
2.47.0.338.g60cca15819-goog

