Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965F1D3194
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787087; cv=none; b=CrdBOPqu8lN2mPdaJ23ojoT3Owq1LdBSK+p7A+nzLfQBde8bnVxwhV3b+Ib7tzGFB8lBScDTJPLUm0VvZ68kTbFBfvy7SRX41k0rD/+UOpji3q9OWUVNMs4l8jhbp985R8jrC+Q/nz7P6ErEBZV/e7CWWKsrycnFPmEIGMqGZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787087; c=relaxed/simple;
	bh=pfrcgVyxbqF8vbBndIPjsFBYlyJ9Xc6C0Mu5Y4WH3Io=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VZYOTmyXTCMI3HWz18eH4NdLZQ95zqVJqdvy7Zh7rEsc55kDZZrZ4y4C/bxsbBN4whcDea94mX/sp9AX896vjBQeXXg5zWRPG0GXhsLq30d8maJxw23C2D8/xvQX4ptELf0A34RUjBt9q73kGmDtsMvOwuXTET9uDNco0vTRu2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gi95rbKE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi95rbKE"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so10392791276.0
        for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 12:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724787085; x=1725391885; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUzDQqrV+J6iG6BhgqMia0sgLkcPdbPDb9fAz9n47OU=;
        b=Gi95rbKEXdlSC4mlh404v7DVnDziF8a8JDI018NOrWohtwpeLW7nSfn97P3TeXjczH
         C9kpRTz1PmZFXFRhcXjBaI6Nt1aKJWSff6KkOG9Y6gvp7yG9UcoTyzxKPkmCjdqfXrDN
         4DnQWj6pTm9ifC8FG9mlkcdO/aN02d2be+kwoJ+jzJ1Uh1i65xAqV+SbPbMf1uznq/Zm
         jMTXWSZiw7wIMQPjvREto9Zy2+k+WB6y1sdyH1VulX0BJDjAew1ibFRnWH5sZunOcyJ7
         RXRL28nr/wb9fBFPPxplQ6IkTV64I2ByfOwdKzA1UW90jpHiqVSCGZA6K5ysMBZXSNap
         RZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724787085; x=1725391885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUzDQqrV+J6iG6BhgqMia0sgLkcPdbPDb9fAz9n47OU=;
        b=XlGhrKccnAfcDInCiFH5UjSu0gvg24x9elBfXxb2/ZZAAX9NAaKUpYE2kBw9heYjlu
         h/1rs+/9c4g5lb39O43adkvo9/zghROCSEy+qnp52dteDhVno4QSekPIVVL9AYrykzLA
         0lOAbQdEKPnbvJS8aTzrbs4RbbCcbXF5ccxw/Xw2cHZEXEMNfvX1j/HzpXtC3S6oRKuw
         +r5zQa5RhArBeuG5cBwadWNklNnExsDu/vyqDjo5EKZVZ9Lh9vUdTjBWgwcwtmTEH+wP
         5+yDUwdpJ45J7XHIqkcVtCNPuZtcHGQ8T8vgBdTP+ikanuFe3LbzNsuXOIkNBjYFUm3D
         kbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy0QLlQbtVQiEmaoYWj5yQwZZeN46/36hIohARacRCeWT2uyrfbgu1dfm4skbQKuWDRIjptg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnMVmvAMkD+TLvKztPxUNWi9MW2N1G3H3kdw4aXlY45H/sDPRa
	1IMksf2bkHxS0VUGDSWuYiyhddVM+CUzZWZzI6/bS3eJSrGcDQxghptgxGL9ikBAhzqpqb2sFw=
	=
X-Google-Smtp-Source: AGHT+IGdvSdMLyTDAuubnCoB1ABY2ubCxvnCnKvNFcaFA6aHm2DFb6rbwNj8zl+EwbV3dKCC1vTCfr17lQ==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a25:b11d:0:b0:e17:8e4f:981a with SMTP id
 3f1490d57ef6-e17a8659ce9mr184908276.11.1724787084741; Tue, 27 Aug 2024
 12:31:24 -0700 (PDT)
Date: Tue, 27 Aug 2024 19:30:25 +0000
In-Reply-To: <20240827193026.3993039-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240827193026.3993039-1-praan@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827193026.3993039-2-praan@google.com>
Subject: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 128 ++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  27 +++++
 2 files changed, 148 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8a6cd0adfcf2..65160b52d944 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -83,6 +83,33 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+static const char * const evts[] = {
+	/* Bad config events */
+	[EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
+	[EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
+	[EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
+	[EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
+	[EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
+
+	/* Bad translation events */
+	[EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
+	[EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
+	[EVT_ID_ACCESS_FAULT] = "F_ACCESS",
+	[EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
+
+	/* Bad fetch events */
+	[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
+	[EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
+	[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT"
+};
+
+static const char * const class_str[] = {
+	[0] = "CD",
+	[1] = "TTD",
+	[2] = "IN",
+	[3] = "RES",
+};
+
 static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 				    struct arm_smmu_device *smmu, u32 flags);
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
@@ -1783,9 +1810,100 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 	return ret;
 }
 
+static void arm_smmu_get_evt_info(struct arm_smmu_device *smmu, u64 *evt,
+				  struct arm_smmu_event *event)
+{
+	/* Pick out the good stuff */
+	event->id = FIELD_GET(EVTQ_0_ID, evt[0]);
+	event->sid = FIELD_GET(EVTQ_0_SID, evt[0]);
+	event->ssid_valid = evt[0] & EVTQ_0_SSV;
+	event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
+	event->class = FIELD_GET(EVTQ_1_CLASS, evt[1]);
+	event->iova = FIELD_GET(EVTQ_2_ADDR, evt[2]);
+	event->ipa = FIELD_GET(EVTQ_3_IPA, evt[3]);
+	event->privileged = FIELD_GET(EVTQ_1_PnU, evt[1]);
+	event->instruction = FIELD_GET(EVTQ_1_InD, evt[1]);
+	event->stage = FIELD_GET(EVTQ_1_S2, evt[1]);
+	event->read = FIELD_GET(EVTQ_1_RnW, evt[1]);
+	event->raw = evt;
+
+	mutex_lock(&smmu->streams_mutex);
+	event->master = arm_smmu_find_master(smmu, event->sid);
+	mutex_unlock(&smmu->streams_mutex);
+
+	if (event->master)
+		event->master_name = dev_name(event->master->dev);
+	else
+		event->master_name = "(unassigned sid)";
+}
+
+static void arm_smmu_dump_xlation_fault(struct arm_smmu_device *smmu,
+					struct arm_smmu_event *event)
+{
+	dev_err(smmu->dev, "Fault: %s client %s sid 0x%08x.0x%05x:\n",
+			evts[event->id], event->master_name, event->sid, event->ssid);
+	dev_err(smmu->dev, "\tiova = %#llx ipa = %#llx (%s%s%s%s%s%s)\n", event->iova, event->ipa,
+		    event->privileged ? "Priv " : "Unpriv ",
+		    event->instruction ? "Inst " : "Data ",
+		    event->read ? "Read " : "Write ",
+		    event->stage ? "S2 " : "S1 ", class_str[event->class],
+		    ((event->id == EVT_ID_PERMISSION_FAULT) && (event->class == EVTQ_1_CLASS_TT)) ?
+		    (FIELD_GET(EVTQ_1_TT_READ, event->raw[1]) ? " TTD Read" : " TTD Write")
+		    : "");
+}
+
+static void arm_smmu_dump_fetch_fault(struct arm_smmu_device *smmu,
+				      struct arm_smmu_event *event)
+{
+	dev_err(smmu->dev, "Bad fetch: %s client %s sid 0x%08x.0x%05x: fetch addr = %#llx\n",
+			evts[event->id], event->master_name, event->sid, event->ssid, event->ipa);
+}
+
+static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu,
+				    struct arm_smmu_event *event)
+{
+	int i;
+
+	dev_err(smmu->dev, "event 0x%02x received: client %s:\n", event->id, event->master_name);
+	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
+		dev_err(smmu->dev, "\t0x%016llx\n",
+			 (unsigned long long)event->raw[i]);
+}
+
+static void arm_smmu_dump_event(struct arm_smmu_device *smmu,
+				 struct arm_smmu_event *event)
+{
+	switch (event->id) {
+	case EVT_ID_BAD_SID_CONFIG:
+	case EVT_ID_BAD_STE_CONFIG:
+	case EVT_ID_BAD_SSID_CONFIG:
+	case EVT_ID_BAD_CD_CONFIG:
+	case EVT_ID_STREAM_DISABLED:
+		dev_err(smmu->dev, "Bad smmu config - %s client %s sid 0x%08x.0x%05x\n",
+				evts[event->id], event->master_name, event->sid, event->ssid);
+		break;
+
+	case EVT_ID_TRANSLATION_FAULT:
+	case EVT_ID_ADDR_SIZE_FAULT:
+	case EVT_ID_ACCESS_FAULT:
+	case EVT_ID_PERMISSION_FAULT:
+		arm_smmu_dump_xlation_fault(smmu, event);
+		break;
+
+	case EVT_ID_STE_FETCH_FAULT:
+	case EVT_ID_CD_FETCH_FAULT:
+	case EVT_ID_VMS_FETCH_FAULT:
+		arm_smmu_dump_fetch_fault(smmu, event);
+		break;
+	}
+
+	arm_smmu_dump_raw_event(smmu, event);
+}
+
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
-	int i, ret;
+	int ret;
+	struct arm_smmu_event event;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
@@ -1795,17 +1913,13 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 	do {
 		while (!queue_remove_raw(q, evt)) {
-			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
 
+			arm_smmu_get_evt_info(smmu, evt, &event);
 			ret = arm_smmu_handle_evt(smmu, evt);
 			if (!ret || !__ratelimit(&rs))
 				continue;
 
-			dev_info(smmu->dev, "event 0x%02x received:\n", id);
-			for (i = 0; i < ARRAY_SIZE(evt); ++i)
-				dev_info(smmu->dev, "\t0x%016llx\n",
-					 (unsigned long long)evt[i]);
-
+			arm_smmu_dump_event(smmu, &event);
 			cond_resched();
 		}
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 14bca41a981b..6728e306e4da 100644
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
@@ -702,6 +712,23 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+struct arm_smmu_event {
+	struct arm_smmu_master		*master;
+	const char			*master_name;
+	u8				id;
+	u8				class;
+	u32				sid;
+	u32				ssid;
+	u64				iova;
+	u64				ipa;
+	u64				*raw;
+	bool				ssid_valid;
+	bool				privileged;
+	bool				instruction;
+	bool				stage;
+	bool				read;
+};
+
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
-- 
2.46.0.295.g3b9ea8a38a-goog

