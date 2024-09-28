Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72114101E2
	for <iommu@lists.linux.dev>; Sat, 28 Sep 2024 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727484730; cv=none; b=Uh6BBiVPG1NM9Pv3t3kU9ntB1yYVJSfZ4w08cxBuubTR2JUSlCVTS67et6v8pzQqLxZ36kFTyzn2yvguAxjSncz4GyVhrWqicZkLmb9C+8Z8ihrEDDBYzbxO8PYbiQ5sWYsgjhCbmTooo9RQxaR+nZHtDML1UkbNhkSTqo1wIUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727484730; c=relaxed/simple;
	bh=iw/G53ICI7bDERkbXYGmuqZIttgVhABJm2sLPLz51gI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QvJJ5X8fFGArmcuJzqK5XlWyLrK/dA8L3v27w1gSrXlj/6yTIeiBWK2QCpmExlsdGUTOBYjc3XfLhoIptMfH7DHN2FlM40unZEv0L5pdtGVlfT5cmOsSjbdBv2ip3KIMXSwcWiB2PKKil92Xc4oQgnc94oh26XDYsCeDgZ8opNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zrNSzMO8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zrNSzMO8"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2590f5bc1so6222347b3.2
        for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 17:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727484727; x=1728089527; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UlUrtUfxEtJH7fUZZ8bFrmmjslLLKfNc1rNbpylU1NM=;
        b=zrNSzMO8lSWr0h8bVJBjllnWgwv/LAqe8+MrohJdYRuhzNni7XE0z+6GAQv9SSSpVZ
         Tw9gpjvl8L9AdMsOoxYiGfkJUjFf5jvoptC7qyvHevfVaAxt/MzCxL+aNlP00IS/3dsk
         8A2dznjEudRogOHT3iUVoXQi+22SbIpbBKTn32O6+Mhvcv0UdSeVzkoVcvXhDKVm8YDe
         dkzf6Lb1x6Uxk1lf+77hTtF+8YCZfgI1LuP2K0W8gTXAaiDFg8wzyTSVBEOQ2nDtsli1
         7i8wGvp+DP9JW7aUeZbaQje4pA4zrz0e5NrEUBecflGDukfc8QQhpaOvzGnFC0V65P8R
         TIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727484727; x=1728089527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlUrtUfxEtJH7fUZZ8bFrmmjslLLKfNc1rNbpylU1NM=;
        b=PjiZvJDUzmqExfdD82eV0xM9Jut5XmSY5wj/edpL7FX9rq3aTf8dWPpM1DwPA6xuOi
         gYQzZJYv4ruZ/cPC2Vw6AoAaeKmxsr+c6CswokZYqoOwnQQ9spNBhpnO7FanEikNGTQN
         4aWmT/7FBEo0/cu5q6c+GtNESU2j8zJ1eGe7hmHu25kUlx7BCyX9/FbPVs7NA/K9deMi
         bAcD68YbOXD/7ovqwHHcxz9TgS7SuEGtz0kGGGnIf78PrgbSQwp+Qg+Qb5FoiPqZDEN9
         TkkwuCKLS+1dEu1Pelztm29+7sr4nJl0kbjG76nEkwk7mRMiWtIjKaP+FM5Wx4ykijeg
         nGAw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Bzfh9JKVEyO/R+DQC0azRCRcMYsRPZcP1tnppkWy4rd5cNg/2Ua5WmRY9XlRvZQ40pFriQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBFI7Z+MidOEDeyFHPOBh2fXcr8MVqEPNGnk9HsMQPfQG4kzPd
	5e8aoMk+qxL/l4biuzXaGHl5cDyIANCL3WG5RXbgXI0o4iiDGQ14OkUYfWHI2xpYMmU8WKXqiA=
	=
X-Google-Smtp-Source: AGHT+IFlaWtb65TtyyKZ24hyp684U/MDXyd1WMEr/CzdqpWCJlpVvVVRlqplUU+9ZNBjHym+tQNl6EDq9w==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a05:690c:67c7:b0:6d4:d6de:3e35 with SMTP id
 00721157ae682-6e2475d39d8mr498067b3.8.1727484727487; Fri, 27 Sep 2024
 17:52:07 -0700 (PDT)
Date: Sat, 28 Sep 2024 00:51:42 +0000
In-Reply-To: <20240928005143.2378938-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240928005143.2378938-1-praan@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240928005143.2378938-2-praan@google.com>
Subject: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the driver dumps the hex for a received event. Improve this
by parsing out fields from an event for easier-to-read event records.
Introduce a `struct arm_smmu_event` to hold the parsed out information.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 128 ++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  30 +++++
 2 files changed, 151 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 737c5b882355..2b2949bd2d26 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -83,6 +83,34 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+static const char * const event_str[] = {
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
+	[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT",
+	[EVT_ID_MAX] = NULL,
+};
+
+static const char * const class_str[] = {
+	[0] = "CD fetch",
+	[1] = "Stage 1 translation table fetch",
+	[2] = "Input address caused fault ",
+	[3] = "Reserved",
+};
+
 static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 				    struct arm_smmu_device *smmu, u32 flags);
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
@@ -1756,6 +1784,66 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 	return rb_entry(node, struct arm_smmu_stream, node)->master;
 }
 
+static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu,
+				    struct arm_smmu_event *event)
+{
+	int i;
+
+	dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
+		event->id, event->master_name);
+
+	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
+		dev_err(smmu->dev, "\t0x%016llx\n",
+			 (unsigned long long)event->raw[i]);
+}
+
+static void arm_smmu_dump_event(struct arm_smmu_device *smmu,
+				struct arm_smmu_event *event)
+{
+	char title[256] = {0};
+	char mastr[256] = {0};
+	char addrs[256] = {0};
+	char flags[256] = {0};
+	char other[256] = {0};
+
+	snprintf(title, 256, "Unexpected event received: %s\n",	event_str[event->id]);
+	snprintf(mastr, 256, "\tmaster: %s sid: 0x%08x.0x%05x\n",
+		 event->master_name, event->sid, event->ssid);
+
+	switch (event->id) {
+	case EVT_ID_TRANSLATION_FAULT:
+	case EVT_ID_ADDR_SIZE_FAULT:
+	case EVT_ID_ACCESS_FAULT:
+	case EVT_ID_PERMISSION_FAULT:
+		snprintf(addrs, 256, "\tiova = %#llx ipa = %#llx\n", event->iova, event->ipa);
+		snprintf(flags, 256, "\t%s%s%s%s%s%s\n",
+				event->privileged ? "Priv |" : "Unpriv |",
+				event->instruction ? " Inst |" : " Data |",
+				event->read ? " Read |" : " Write |",
+				event->s2 ? "S2|" : "S1|", class_str[event->class],
+				((event->id == EVT_ID_PERMISSION_FAULT) &&
+				 (event->class == EVTQ_1_CLASS_TT)) ?
+				  (FIELD_GET(EVTQ_1_TT_READ, event->raw[1]) ?
+				  "|TTD Read" : "|TTD Write") : "");
+		snprintf(other, 256, "\tSTAG = %#x Stall = %#x\n",
+				event->stag, event->stall);
+		break;
+
+	case EVT_ID_STE_FETCH_FAULT:
+	case EVT_ID_CD_FETCH_FAULT:
+	case EVT_ID_VMS_FETCH_FAULT:
+		snprintf(addrs, 256, "\tFetch address: %#llx\n", event->ipa);
+		break;
+	}
+
+	dev_err(smmu->dev, "%s%s%s%s%s", title, mastr,
+		strlen(addrs) ? addrs : "",
+		strlen(flags) ? flags : "",
+		strlen(other) ? other : "");
+
+	arm_smmu_dump_raw_event(smmu, event);
+}
+
 /* IRQ and event handlers */
 static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 {
@@ -1817,9 +1905,39 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
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
+	event->s2 = FIELD_GET(EVTQ_1_S2, evt[1]);
+	event->read = FIELD_GET(EVTQ_1_RnW, evt[1]);
+	event->stag = FIELD_GET(EVTQ_1_STAG, evt[1]);
+	event->stall = evt[1] & EVTQ_1_STALL;
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
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
-	int i, ret;
+	int ret;
+	struct arm_smmu_event event;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
@@ -1829,17 +1947,13 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
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
index 1e9952ca989f..743a544a50e9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -437,10 +437,20 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 
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
+#define EVT_ID_MAX			0xff
 
 #define EVTQ_0_SSV			(1UL << 11)
 #define EVTQ_0_SSID			GENMASK_ULL(31, 12)
@@ -452,6 +462,7 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define EVTQ_1_RnW			(1UL << 35)
 #define EVTQ_1_S2			(1UL << 39)
 #define EVTQ_1_CLASS			GENMASK_ULL(41, 40)
+#define EVTQ_1_CLASS_TT			0x1
 #define EVTQ_1_TT_READ			(1UL << 44)
 #define EVTQ_2_ADDR			GENMASK_ULL(63, 0)
 #define EVTQ_3_IPA			GENMASK_ULL(51, 12)
@@ -771,6 +782,25 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+struct arm_smmu_event {
+	struct arm_smmu_master		*master;
+	const char			*master_name;
+	u8				id;
+	u8				class;
+	u16				stag;
+	u32				sid;
+	u32				ssid;
+	u64				iova;
+	u64				ipa;
+	u64				*raw;
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
2.46.1.824.gd892dcdcdd-goog

