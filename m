Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0820C004
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400236; cv=none; b=DL+mp82a5aONK7Jm/3dVfoa66x3vo6fQsWcMGCyLk0txFNM4fr4VDpybJt4VN2wpSmf6gTwaMZSvJRA28au8F1QXYifqg1SqQk4kC77E47uWT5pyNrc6mjtr4UcZsKqeE7pjHWaKqwwo6gsUQ+Tc+e1um/xgioDyXovLoCbhbHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400236; c=relaxed/simple;
	bh=8m7yqNH8zB91NiFEYxsipb1uFYymQ0Qt1NJG1RWqEbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m6WOs2mfQk3+wnuQDH7I9CP+J1nh+UsTDKoewhg3Wxe6fYunzKHH6PtaXUh8rfyEGh4vzKiQa35KjrkASB3/4uilxGrt9uLBCYHcizunggq2hb8FWqP+YVqTdWvg8yl8QYpDoLkPxiluvx362f3vBYUMqtMEQKAlPTn1u6yl+DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSWr/uoM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSWr/uoM"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso9240822276.1
        for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 00:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731400234; x=1732005034; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=euWM5ZDBHXm27g2v/wzHotz4fxAR6QJf1auy95HU4RU=;
        b=jSWr/uoMdnDnd1FENorN976cFYhCp0L5kFiyO+QazCpwcxBEyVyZdsxMq1cCsudQ57
         tjGDe5EN539DRDjQnIZizOsseBLRTFwW0rdK3Ckb9owPn5543JUmqlXgG+o3fW8V4LMJ
         mAWYq8qhelO7wOAcysuQtT4BXQDS3B/tcg+UMd4/wyfWP4yZdEs8+cy4BOaBmupLlwOi
         ce7M4ADbxnnOqicGiGYnLcJu4SDRK8wa7zPuZoE+EVEIn2hHEiEXfW5RFpsKoCMCpyw8
         AjljG3P6SpgrhbzeNxN3wqby6SiBIgXUPWoJwqHVb4Sx0f9i6A+F2kN8/RedahMWJKQf
         7tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731400234; x=1732005034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euWM5ZDBHXm27g2v/wzHotz4fxAR6QJf1auy95HU4RU=;
        b=Y4GnGvsbdTUertrBETjOk2n93VCVhEnfyKHznLoZ+zpzGRDyHI00lwQ8TfxPl12pWk
         9Flr2hpeO94KHyEnqm5XjUmS+qnAC34AD5McSPTdlrZOllwQvKAFz91XkN4lQEbEunno
         8J6Ls0udjL+GzepTAFPCxjfv1QBb/feSK7hdFx5we6t2F11KP/lMO2W1w3BT1PgJ5aap
         fTPYBjzWjhuuuHYKaWWQI8UJYHreSGFxFLvCmDmz5qhVhirUUCWaCWgmaTLIN95PKEK1
         viP/WenXQQ9h7pO9CdZIBSnxP3NwVAu3DnwOfb4h9IMOlR2XYeZZKSt3Al/bkv7pdUQv
         wPeg==
X-Forwarded-Encrypted: i=1; AJvYcCXNH0EnpwJ45k03qFDVhIKPgk4bVrAZYIkwYJyIWIeSlUoPhnQxhUFDxFjyldWI6WbyEwCFFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqhkFo0RINBTYaYiaEZzYK5CzhsA9S4NxUNXfM4/06C4HjOXNf
	11zYKmJtfTX405K3sIf1lADdmcOxICINIiXJXJ51RcTEd6w4F7VXXVFzLSdvNA7tsGti9mzf2g=
	=
X-Google-Smtp-Source: AGHT+IGDnq2EnxSFwridAolcqjx8lHlacUHCxH+/J0XlH7mLa7hzlWy664cNbRAi4C0Ic68Dgsi1C5q7vw==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:dcc8:0:b0:e30:d673:94eb with SMTP id
 3f1490d57ef6-e35dc5bb0f2mr1483276.10.1731400233809; Tue, 12 Nov 2024 00:30:33
 -0800 (PST)
Date: Tue, 12 Nov 2024 08:30:16 +0000
In-Reply-To: <20241112083018.1662104-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241112083018.1662104-1-praan@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112083018.1662104-2-praan@google.com>
Subject: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 57 +++++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 16 ++++++
 2 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..e1b69aa04382 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1757,17 +1757,33 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 }
 
 /* IRQ and event handlers */
-static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
+static void arm_smmu_decode_event(u64 *raw, struct arm_smmu_event *event)
+{
+	event->id = FIELD_GET(EVTQ_0_ID, raw[0]);
+	event->sid = FIELD_GET(EVTQ_0_SID, raw[0]);
+	event->ssv = raw[0] & EVTQ_0_SSV;
+	event->ssid = event->ssv ? FIELD_GET(EVTQ_0_SSID, raw[0]) : IOMMU_NO_PASID;
+	event->privileged = FIELD_GET(EVTQ_1_PnU, raw[1]);
+	event->instruction = FIELD_GET(EVTQ_1_InD, raw[1]);
+	event->s2 = FIELD_GET(EVTQ_1_S2, raw[1]);
+	event->read = FIELD_GET(EVTQ_1_RnW, raw[1]);
+	event->stag = FIELD_GET(EVTQ_1_STAG, raw[1]);
+	event->stall = raw[1] & EVTQ_1_STALL;
+	event->class = FIELD_GET(EVTQ_1_CLASS, raw[1]);
+	event->iova = FIELD_GET(EVTQ_2_ADDR, raw[2]);
+	event->ipa = raw[3];
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
@@ -1777,35 +1793,35 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
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
@@ -1820,25 +1836,26 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
 	int i, ret;
+	u64 raw_evt[EVTQ_ENT_DWORDS];
+	struct arm_smmu_event evt = {0};
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
-	u64 evt[EVTQ_ENT_DWORDS];
 
 	do {
-		while (!queue_remove_raw(q, evt)) {
-			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
+		while (!queue_remove_raw(q, raw_evt)) {
 
-			ret = arm_smmu_handle_evt(smmu, evt);
+			arm_smmu_decode_event(raw_evt, &evt);
+			ret = arm_smmu_handle_evt(smmu, &evt);
 			if (!ret || !__ratelimit(&rs))
 				continue;
 
-			dev_info(smmu->dev, "event 0x%02x received:\n", id);
-			for (i = 0; i < ARRAY_SIZE(evt); ++i)
+			dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
+			for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
 				dev_info(smmu->dev, "\t0x%016llx\n",
-					 (unsigned long long)evt[i]);
+					(unsigned long long)raw_evt[i]);
 
 			cond_resched();
 		}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1e9952ca989f..abb543d987f6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -771,6 +771,22 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+struct arm_smmu_event {
+	u8				stall		: 1,
+					ssv		: 1,
+					privileged	: 1,
+					instruction	: 1,
+					s2		: 1,
+					read		: 1;
+	u8				id;
+	u8				class;
+	u16				stag;
+	u32				sid;
+	u32				ssid;
+	u64				iova;
+	u64				ipa;
+};
+
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
-- 
2.47.0.277.g8800431eea-goog

