Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67288472
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274450; cv=none; b=C+aEAzplHMRDPuVp4uEFLPfhrNGcDpSaY2tlWrcGbb3z85a1VgRTnIw9NOAw4+MsBdymeSBM3H3NMtRTBAXhT1aL03qG86IoRhgZdRhj0yAq9rx5H3bUiUEh9s5V9ChmrRSZntZT3gd1GZdp+W7ComSpC4jAhfP4gqY+OsHjyhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274450; c=relaxed/simple;
	bh=ptVkTzvG45mo5j2g4U2BuT37lkliI8DS0DjCWGvShxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PJy8Jql4QxqzEBLXulgr+kCFkn1vm/wl8v1OfWn0+MWXV3V8iCcJ3A8xFNe8S32FD8BD1yGPBg26KTwk9zSDwZ/35oC6XHvbv8jtZxgsufKlHR9wJMzigbnb5nyYBQaUfIUWiEgzmW2lB+DRRXqFlOF3YomAYe4TgyB8GKCXHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P/q/H36M; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/q/H36M"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fea2adb6so3212875276.3
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729274448; x=1729879248; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+uODfMi2ATPUrgf+1AtbeAQsa2v9dTSCy+qJDq9N6A=;
        b=P/q/H36M7etj4Qyy2B+IY/e7RzBHMXCksFZnjrCeLGk7uuBqUdwdS91SuNyIM7NNQq
         XodrgRxUYQ10Q+aJOs2T/9Xp560Usx2UuqqP93Wj6cNhqirL7Fei3pYDgTpPaPNTv+6L
         FUpFOmVWxd8iha4ciyHfcnEEMl7+Bd7TXtTWHDcb1vAj0WB2Lwnc1FNQwMc6pCc8xR6V
         h0i/1UPZVoz/Na7VSomVjqhVrnDmOssiSv1XeipOnCk2ICZHd7gMYRSCFKYPtfZjkcHr
         /YW207O2MhHLZQ3IbsWQmTKL6yPgH/qOsMRBpGYkl2WVOvdoXyqlwM3yRYVVCXR57Ccx
         54/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729274448; x=1729879248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+uODfMi2ATPUrgf+1AtbeAQsa2v9dTSCy+qJDq9N6A=;
        b=kdHZ2vv8yXHEf0Gl3A4VDVlJ9KQQV55VwBKuJ9F99x+1Lp9Q7JjgeTOdevYuXg9SPf
         1nez9vZhFuxpypETka9XxQmb6FCcTBdzv1JmpJucHgf5XcxSV/UCZRN8ad9MP/cBuqN9
         N3xnQI8SpO8pE/6I0/CvLr3UNA81LWeZMwN2T+iUfK52ZGLcPIJQwn5K4gMC9lGxaDI6
         TkEIQauHuf8hyZMvV70ypX5ixZWD1ogn5QZaxV1klupEbEjbOfTYqA3EkFGwNNudkRDD
         NKy0kLLZFkWJwInlJTyLWjl66BMac/ESG72TzR/iV2EfEpZYwD9se0TzJ6/CSnuxYJYH
         H2ng==
X-Forwarded-Encrypted: i=1; AJvYcCWItcqypIAeIKua4mYH5c0bN+KlnfGxsJLyF9kITzpz6tjde0aQoY9fA6MST0blh6xgR+e5EQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXY9tinu1F8ISi2YTBQquhD/7dK5B07cdb9rtw8CZyawFfbpjh
	uqswm0RfOxROM2Txl0ShjhOb7cNEwdpQDj5/lxW36HIBc55KgtLI/NuwEXFmB7vJPnva+mRyTA=
	=
X-Google-Smtp-Source: AGHT+IHuYk11rLkFkkV0b67U+4NZPBynwRGERACQizKPgO2xDRqtTkaXXXTM5hOc+NzWCEYIv1sRP76exg==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:6c02:0:b0:e28:ec5d:ebe7 with SMTP id
 3f1490d57ef6-e2bb1309f80mr3452276.5.1729274447798; Fri, 18 Oct 2024 11:00:47
 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:00:20 +0000
In-Reply-To: <20241018180022.807928-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241018180022.807928-1-praan@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241018180022.807928-2-praan@google.com>
Subject: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Pranjal Shrivastava <praan@google.com>, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce `struct arm_smmu_event` to represent event records.
Parse out relevant fields from raw event records for ease and
use the new `struct arm_smmu_event` instead.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 59 ++++++++++++++-------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 20 +++++++
 2 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..2f1108e5de51 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1757,17 +1757,16 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 }
 
 /* IRQ and event handlers */
-static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
+static int arm_smmu_handle_evt(struct arm_smmu_event *event)
 {
 	int ret = 0;
 	u32 perm = 0;
 	struct arm_smmu_master *master;
-	bool ssid_valid = evt[0] & EVTQ_0_SSV;
-	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
 	struct iopf_fault fault_evt = { };
+	struct arm_smmu_device *smmu = event->smmu;
 	struct iommu_fault *flt = &fault_evt.fault;
 
-	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
+	switch (event->id) {
 	case EVT_ID_TRANSLATION_FAULT:
 	case EVT_ID_ADDR_SIZE_FAULT:
 	case EVT_ID_ACCESS_FAULT:
@@ -1777,35 +1776,35 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
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
+	if (event->ssid_valid) {
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
@@ -1817,28 +1816,48 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 	return ret;
 }
 
+static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
+					struct arm_smmu_event *event)
+{
+	/* Pick out the good stuff */
+	event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
+	event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
+	event->ssid_valid = event->raw[0] & EVTQ_0_SSV;
+	event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, event->raw[0]) : IOMMU_NO_PASID;
+	event->privileged = FIELD_GET(EVTQ_1_PnU, event->raw[1]);
+	event->instruction = FIELD_GET(EVTQ_1_InD, event->raw[1]);
+	event->s2 = FIELD_GET(EVTQ_1_S2, event->raw[1]);
+	event->read = FIELD_GET(EVTQ_1_RnW, event->raw[1]);
+	event->stag = FIELD_GET(EVTQ_1_STAG, event->raw[1]);
+	event->stall = event->raw[1] & EVTQ_1_STALL;
+	event->class = FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
+	event->iova = FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
+	event->ipa = FIELD_GET(EVTQ_3_IPA, event->raw[3]);
+	event->smmu = smmu;
+}
+
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
 	int i, ret;
+	struct arm_smmu_event evt;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
-	u64 evt[EVTQ_ENT_DWORDS];
 
 	do {
-		while (!queue_remove_raw(q, evt)) {
-			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
+		while (!queue_remove_raw(q, evt.raw)) {
 
-			ret = arm_smmu_handle_evt(smmu, evt);
+			arm_smmu_get_event_from_raw(smmu, &evt);
+			ret = arm_smmu_handle_evt(&evt);
 			if (!ret || !__ratelimit(&rs))
 				continue;
 
-			dev_info(smmu->dev, "event 0x%02x received:\n", id);
-			for (i = 0; i < ARRAY_SIZE(evt); ++i)
+			dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
+			for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
 				dev_info(smmu->dev, "\t0x%016llx\n",
-					 (unsigned long long)evt[i]);
+					(unsigned long long)evt.raw[i]);
 
 			cond_resched();
 		}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1e9952ca989f..8a42d7b701fb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -437,6 +437,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 
 #define EVTQ_0_ID			GENMASK_ULL(7, 0)
 
+/* Events */
 #define EVT_ID_TRANSLATION_FAULT	0x10
 #define EVT_ID_ADDR_SIZE_FAULT		0x11
 #define EVT_ID_ACCESS_FAULT		0x12
@@ -452,6 +453,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define EVTQ_1_RnW			(1UL << 35)
 #define EVTQ_1_S2			(1UL << 39)
 #define EVTQ_1_CLASS			GENMASK_ULL(41, 40)
+#define EVTQ_1_CLASS_TT			0x1
 #define EVTQ_1_TT_READ			(1UL << 44)
 #define EVTQ_2_ADDR			GENMASK_ULL(63, 0)
 #define EVTQ_3_IPA			GENMASK_ULL(51, 12)
@@ -771,6 +773,24 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+struct arm_smmu_event {
+	struct arm_smmu_device		*smmu;
+	u8				id;
+	u8				class;
+	u16				stag;
+	u32				sid;
+	u32				ssid;
+	u64				iova;
+	u64				ipa;
+	u64				raw[EVTQ_ENT_DWORDS];
+	bool				stall;
+	bool				ssid_valid;
+	bool				privileged;
+	bool				instruction;
+	bool				s2;
+	bool				read;
+};
+
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
-- 
2.47.0.rc1.288.g06298d1525-goog

