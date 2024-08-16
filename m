Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417527DA64
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843075; cv=none; b=UmlnWGwQC+FoGFtpiHgAWMU8l7MvDJrok0PvztHYmiL5uL9uIBEc99FFaqYeQB9s3ByPtnVKsPGijYwajt0fsBzHzQTcR4VCAVW2TZKp4rOzP/a4uXgVMIsvRa22gsTtKBRFMba2d+JXtIbGelYuGmDFo2EOkLx4XSQZpReZnQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843075; c=relaxed/simple;
	bh=j/pwVToCKLWDnC3SPyknJTLiiSGjqV6XR6pGEtK4T0k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XTCyHAWBEESRHGZhpDHIjn1qAOGLVOMaUrmzfLYbQFN/AjJsyJLm9Lmqj5w7r5INGXcgx4V2XuqAed54xeO+GQsTl4rJNBPH8q/ufYRxFUumkrYVNd4N4xtV5m8ClfGWssozW+r6Z0yyK8fbiFijTGsS+E1xSwD1Ceo0jLYD8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WUyhPdZ7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUyhPdZ7"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b198ecf931so14058367b3.1
        for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723843073; x=1724447873; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ALeg+irkeTP8ga/ayIOJQ6m7x1zEP/qNdDKyFjJWxtM=;
        b=WUyhPdZ7mfumqFXFu58PdIRqPuQJEzPBgJkFZVNxBNoesZZP4ROqwfmI4VHjs2HaHk
         jUrnIm6ar+MsgQPb6RiHDBq51oOMsAX3TYjqynAAk/KM91BGtroeyjBThjbl7uj5XHld
         aIdPUXXb92qgpYPmRp48W52hw6GRQiLMLgMhE9vmeHCh794GzTki3mqAHcbIqwlCvwZs
         oJ5A+SvmDZCgcUyOh3UEG5EtLFES8doqEKIyghK+Eur6a7DNJH/XrPPLymIow/aJjgs0
         JJaeYR8zctBVZiHxU7NV0DBlclnlHSlpB3XlCwquztAvbGTWQHAZ/x5DwvTsnMYn3rsN
         2ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723843073; x=1724447873;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALeg+irkeTP8ga/ayIOJQ6m7x1zEP/qNdDKyFjJWxtM=;
        b=D8qkxAOro1xyJ+8Cq3maY7c+K+0T4ftiqa2a49b6NV+JqXZfqH4/ztAU2D4kBoTVgx
         /HdM6bc5pdhAMQiVerkE8QpXgIkx2YLobaDASy0cWnW6BB7TtFMzA0SgQuZ472ds9u3R
         SsGJwgON8zIPZEngG6+GHBGmEEepBudfiDM7edtvAvtzZROtCDt4/Fl2d8A7r9eBzWby
         BTLSD4a9I1PvTpdixdJ+1c6QGJyPyTNrccHyiLowayL6zvsUssFkv2fs1bGqeFM0FDjR
         ivWOd3PCgHYDKVftVLUoBmEHlnTX0gSBANJQHt4pNvcruj2GIy6DjjqyiyiIiLyM5J3X
         YSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl0yoFjBR7LaXUDAtqZhfnuZMex+in2HJjyJMmO8z4BO3bKviGCvTDdqjKwBN95AiSDBrCTwzxx9Zw9cezncHxp92x4rQ=
X-Gm-Message-State: AOJu0Yymq438p5AxThMcpdf7i+Qscj9q1usI7zDyCw23U9W+QI+VK6KA
	toqPuEI/LtNXr3Z+0vQTzONf1RYtxBy+WtYntt687rh8SEdFxKoy+5PykJNZLx+VMJeo7laLfQ=
	=
X-Google-Smtp-Source: AGHT+IE0UBGz8OXFpWdWR/4odWMWHuRsS1gRpzzuFJm26D4U08Xyipjk27xc5nvfmzG0hco7rnTh2/s6yQ==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:951:0:b0:e0b:af9b:fb94 with SMTP id
 3f1490d57ef6-e1182f824e6mr114928276.6.1723843073036; Fri, 16 Aug 2024
 14:17:53 -0700 (PDT)
Date: Fri, 16 Aug 2024 21:17:22 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816211722.1404070-1-praan@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Print better events records
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the driver dumps the hex for a received event, improve this
by parsing out fields from an event for easier-to-read event records.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 102 ++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  10 ++
 2 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a31460f9f3d4..993ded10c7b1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1783,9 +1783,102 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 	return ret;
 }
 
+static void arm_smmu_print_evt_record(struct arm_smmu_device *smmu, u64 *evt)
+{
+	static const char * const evts[] = {
+		/* Bad config events */
+		[EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
+		[EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
+		[EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
+		[EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
+		[EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
+
+		/* Bad translation events */
+		[EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
+		[EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
+		[EVT_ID_ACCESS_FAULT] = "F_ACCESS",
+		[EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
+
+		/* Bad fetch events */
+		[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
+		[EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
+		[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT"
+	};
+
+	static const char * const class_str[] = {
+		[0] = "CD",
+		[1] = "TTD",
+		[2] = "IN",
+		[3] = "RES",
+	};
+
+	const char *master_name = "(unassigned sid)";
+	struct arm_smmu_master *master;
+	u64 iova, ipa;
+	bool ssid_valid;
+	u32 sid, ssid;
+	u8 evt_id, class;
+	int i;
+
+	/* Pick out the good stuff */
+	evt_id = FIELD_GET(EVTQ_0_ID, evt[0]);
+	sid = FIELD_GET(EVTQ_0_SID, evt[0]);
+	ssid_valid = evt[0] & EVTQ_0_SSV;
+	ssid = ssid_valid ? FIELD_GET(EVTQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
+	class = FIELD_GET(EVTQ_1_CLASS, evt[1]);
+	iova = FIELD_GET(EVTQ_2_ADDR, evt[2]);
+	ipa = FIELD_GET(EVTQ_3_IPA, evt[3]);
+
+	mutex_lock(&smmu->streams_mutex);
+	master = arm_smmu_find_master(smmu, sid);
+	if (master)
+		master_name = dev_name(master->dev);
+	mutex_unlock(&smmu->streams_mutex);
+
+	switch (evt_id) {
+	case EVT_ID_BAD_SID_CONFIG:
+	case EVT_ID_BAD_STE_CONFIG:
+	case EVT_ID_BAD_SSID_CONFIG:
+	case EVT_ID_BAD_CD_CONFIG:
+	case EVT_ID_STREAM_DISABLED:
+		dev_err(smmu->dev, "Bad smmu config - %s client %s sid 0x%08x.0x%05x\n",
+				evts[evt_id], master_name, sid, ssid);
+		break;
+
+	case EVT_ID_TRANSLATION_FAULT:
+	case EVT_ID_ADDR_SIZE_FAULT:
+	case EVT_ID_ACCESS_FAULT:
+	case EVT_ID_PERMISSION_FAULT:
+		dev_err(smmu->dev, "Translation fault:\n");
+		dev_err(smmu->dev, "\t%s client %s sid 0x%08x.0x%05x: iova = %#llx ipa = %#llx (%s%s%s%s%s%s)\n",
+			    evts[evt_id], master_name, sid, ssid, iova, ipa,
+			    FIELD_GET(EVTQ_1_PnU, evt[1]) ? "Priv " : "Unpriv ",
+			    FIELD_GET(EVTQ_1_InD, evt[1]) ? "Inst " : "Data ",
+			    FIELD_GET(EVTQ_1_RnW, evt[1]) ? "Read " : "Write ",
+			    FIELD_GET(EVTQ_1_S2, evt[1]) ? "S2 " : "S1 ", class_str[class],
+			    ((evt_id == EVT_ID_PERMISSION_FAULT) && (class == EVTQ_1_CLASS_TT)) ?
+			    (FIELD_GET(EVTQ_1_TT_READ, evt[1]) ? " TTD Read" : " TTD Write")
+			    : "");
+		break;
+
+	case EVT_ID_STE_FETCH_FAULT:
+	case EVT_ID_CD_FETCH_FAULT:
+	case EVT_ID_VMS_FETCH_FAULT:
+		dev_err(smmu->dev, "Unable to fetch data structure - bad fetch address\n");
+		dev_err(smmu->dev, "\t%s client %s sid 0x%08x.0x%05x: fetch addr = %#llx\n",
+				evts[evt_id], master_name, sid, ssid, ipa);
+		break;
+	}
+
+	dev_info(smmu->dev, "event 0x%02x received:\n", evt_id);
+	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
+		dev_info(smmu->dev, "\t0x%016llx\n",
+			 (unsigned long long)evt[i]);
+}
+
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
-	int i, ret;
+	int ret;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
@@ -1795,17 +1888,12 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 	do {
 		while (!queue_remove_raw(q, evt)) {
-			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
 
 			ret = arm_smmu_handle_evt(smmu, evt);
 			if (!ret || !__ratelimit(&rs))
 				continue;
 
-			dev_info(smmu->dev, "event 0x%02x received:\n", id);
-			for (i = 0; i < ARRAY_SIZE(evt); ++i)
-				dev_info(smmu->dev, "\t0x%016llx\n",
-					 (unsigned long long)evt[i]);
-
+			arm_smmu_print_evt_record(smmu, evt);
 			cond_resched();
 		}
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 14bca41a981b..500eecbf2834 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -399,10 +399,19 @@ struct arm_smmu_cd {
 
 #define EVTQ_0_ID			GENMASK_ULL(7, 0)
 
+/* Events */
+#define EVT_ID_BAD_SID_CONFIG		0x02
+#define EVT_ID_STE_FETCH_FAULT		0x03
+#define EVT_ID_BAD_STE_CONFIG		0x04
+#define EVT_ID_STREAM_DISABLED		0x06
+#define EVT_ID_BAD_SSID_CONFIG		0x08
+#define EVT_ID_CD_FETCH_FAULT		0x09
+#define EVT_ID_BAD_CD_CONFIG		0x0a
 #define EVT_ID_TRANSLATION_FAULT	0x10
 #define EVT_ID_ADDR_SIZE_FAULT		0x11
 #define EVT_ID_ACCESS_FAULT		0x12
 #define EVT_ID_PERMISSION_FAULT		0x13
+#define EVT_ID_VMS_FETCH_FAULT		0x25
 
 #define EVTQ_0_SSV			(1UL << 11)
 #define EVTQ_0_SSID			GENMASK_ULL(31, 12)
@@ -414,6 +423,7 @@ struct arm_smmu_cd {
 #define EVTQ_1_RnW			(1UL << 35)
 #define EVTQ_1_S2			(1UL << 39)
 #define EVTQ_1_CLASS			GENMASK_ULL(41, 40)
+#define EVTQ_1_CLASS_TT			0x1
 #define EVTQ_1_TT_READ			(1UL << 44)
 #define EVTQ_2_ADDR			GENMASK_ULL(63, 0)
 #define EVTQ_3_IPA			GENMASK_ULL(51, 12)
-- 
2.46.0.184.g6999bdac58-goog

