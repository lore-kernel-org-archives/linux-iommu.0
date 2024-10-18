Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CAA8472
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274458; cv=none; b=JgxMyUktaJ/3byQvV6HtSwA56f6gJhx1/kMCo/FBW3Ygtw1uzQCDbbpN1RfHWCkk6TKJ40oCOFUpY/h3ykWMcJZdpnLr7dCIi8jSiJMjLSkBRgIf54vexhW6r2HYyn67Zic4Juq7CJy65lXMt0t7xiMopCCibwlRRDo0fRBjBQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274458; c=relaxed/simple;
	bh=daB2YjKgCeOH974ldDkbZbOX/Cxvdav78rGJoCcsxTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gOH+z7EmV2etYYC8j15824gRYfRzxWdOvb4aZnW0ewnt4t0TUtZ0ZqWp8U/Z5dCenBQrtUSBHsXHSC8Q874C5RBvW9nUzE3PqGMQF0RGsRMq38DCxzlLFqYjE+jIXZa+iYvMS/QPgBwOkdj+RFRE8KQTiHRY+/Gtf0LzJqWlnDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n4arFy0Q; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4arFy0Q"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e0082c1dd0so52533157b3.3
        for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 11:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729274456; x=1729879256; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8FfmQmPniP+jxEOqvqQd1udjTCHEf7bqctn734XK2cg=;
        b=n4arFy0QcaTxJiybhI+xavz6muQVBSoWE9MjjQJVzOQBdnuvTKqG2TK+oWdQPPqI/4
         nx6PlYhBD5/maN9Fe6olxLS7Jtdz2V3In7PSsbs9g33fFR4lpGO4bPiPXsdPW6J+MYXc
         BDSD79aLei4SJehroqV2BA5PR1TGYGEuwKW1N1VYdv+R7jBYVA4CSfBFF/Isvyv4pdJu
         XJin7lQSPS3fM5uxt7KrOR791DhYKddXr+09sW/qc2CtFSrGfWIG4mbDpgG86WJOvZ7Q
         Qb79+uEMIUyxIhH7em8kvznZKs5eAlS739RX1XtC7O2I1nEJLpbGcZ+XxAQ1KpiozLhm
         7zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729274456; x=1729879256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FfmQmPniP+jxEOqvqQd1udjTCHEf7bqctn734XK2cg=;
        b=IfIowCLD0QovVDtxrKwztCK9B6xELbnT20IOxv1Bvg69dHmlVBNdiLYEZQMXRwuo9W
         ORu7vp2Vt+bwbqQ+fP55bbsStEGm+gv4Ayj8PQg3S8EHzwtQ2pyDcXu4dUuWebm5z0bB
         E7bhir3BLjqT3HuSznSpkHANmQbYM9Y79NL8pu9M8qEweH42ZiLXNH/oJKz6wEitUzaJ
         THav+QOCkSdlq8Q6N6fxFXuhWcEeclfY50kOGoL6jE9JD39PJ7gcEI2srLmikWh4rKRI
         ZVqMR3v4AYTiQVaz/i9RqPezaS//MTeiFYIw726e5TdD2Dpte9SOul+u7vJUqmZB79O3
         8IrA==
X-Forwarded-Encrypted: i=1; AJvYcCU8lm2aPqg3HG7c0Gs1F6KF2IDLBdVfWgx1fXoKKnhuellPlB53jsekmrivQFY35gk5mV6EQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeJHNsPSSOvCerDruCi/DQlskd4EjT+RYIKzLnhfmlcKR1NTgd
	aTjxYO+iPwKMcJw0rKTxoEo6jLNVQS49Fby51l8aLqUeRPGdtidsD/zNEupNdEfMZjzeDLIjpA=
	=
X-Google-Smtp-Source: AGHT+IGN4bk9aQb7Kxzk0yIu9o7wxQXpu8rJbLSLTki3Z0M/NBcnBX+s4Wp40RCTTfHR2QFBWqpGiEu6+w==
X-Received: from praan.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:3e89])
 (user=praan job=sendgmr) by 2002:a05:690c:c08:b0:6db:d257:b98 with SMTP id
 00721157ae682-6e5bfd1d494mr172747b3.3.1729274455789; Fri, 18 Oct 2024
 11:00:55 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:00:21 +0000
In-Reply-To: <20241018180022.807928-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241018180022.807928-1-praan@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241018180022.807928-3-praan@google.com>
Subject: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, 
	Jason Gunthorpe <jgg@nvidia.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, the driver dumps the raw hex for a received event record.
Improve this by leveraging `struct arm_smmu_event` for event fields
and log human-readable event records with meaningful information.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +++
 2 files changed, 113 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2f1108e5de51..4477cf86cb8e 100644
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
+static const char * const event_class_str[] = {
+	[0] = "CD fetch",
+	[1] = "Stage 1 translation table fetch",
+	[2] = "Input address caused fault ",
+	[3] = "Reserved",
+};
+
 static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 				    struct arm_smmu_device *smmu, u32 flags);
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
@@ -1756,6 +1784,60 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 	return rb_entry(node, struct arm_smmu_stream, node)->master;
 }
 
+static void arm_smmu_dump_raw_event(struct arm_smmu_event *event)
+{
+	int i;
+	struct arm_smmu_device *smmu = event->smmu;
+
+	dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
+		event->id, event->master_name);
+
+	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
+		dev_err(smmu->dev, "\t0x%016llx\n", event->raw[i]);
+}
+
+static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
+{
+	struct arm_smmu_device *smmu = evt->smmu;
+	char title[100] = {0};
+	char mastr[100] = {0};
+	char addrs[100] = {0};
+	char flags[100] = {0};
+	char other[50] = {0};
+
+	if (!__ratelimit(rs))
+		return;
+
+	snprintf(title, 100, "Unexpected event received: %s\n",	event_str[evt->id]);
+	snprintf(mastr, 100, "\tmaster: %s sid: 0x%08x.0x%05x\n",
+		 evt->master_name, evt->sid, evt->ssid);
+
+	switch (evt->id) {
+	case EVT_ID_TRANSLATION_FAULT:
+	case EVT_ID_ADDR_SIZE_FAULT:
+	case EVT_ID_ACCESS_FAULT:
+	case EVT_ID_PERMISSION_FAULT:
+		snprintf(addrs, 100, "\tiova = %#llx ipa = %#llx\n", evt->iova, evt->ipa);
+		snprintf(other, 50, "\tSTAG = %#x Stall = %#x\n", evt->stag, evt->stall);
+		snprintf(flags, 100, "\t%s%s%s%s%s%s\n",
+			 evt->privileged ? "Priv | " : "Unpriv | ",
+			 evt->instruction ? "Inst | " : "Data | ",
+			 evt->read ? "Read | " : "Write | ",
+			 evt->s2 ? "S2 | " : "S1 | ", event_class_str[evt->class],
+			 evt->ttrnw_valid ? (evt->ttrnw ? "| TTD Read" : "| TTD Write") : "");
+		break;
+
+	case EVT_ID_STE_FETCH_FAULT:
+	case EVT_ID_CD_FETCH_FAULT:
+	case EVT_ID_VMS_FETCH_FAULT:
+		snprintf(addrs, 100, "\tFetch address: %#llx\n", evt->ipa);
+		break;
+	}
+
+	dev_err(smmu->dev, "%s%s%s%s%s", title, mastr, addrs, flags, other);
+	arm_smmu_dump_raw_event(evt);
+}
+
 /* IRQ and event handlers */
 static int arm_smmu_handle_evt(struct arm_smmu_event *event)
 {
@@ -1819,6 +1901,8 @@ static int arm_smmu_handle_evt(struct arm_smmu_event *event)
 static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
 					struct arm_smmu_event *event)
 {
+	struct arm_smmu_master *master;
+
 	/* Pick out the good stuff */
 	event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
 	event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
@@ -1833,12 +1917,24 @@ static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
 	event->class = FIELD_GET(EVTQ_1_CLASS, event->raw[1]);
 	event->iova = FIELD_GET(EVTQ_2_ADDR, event->raw[2]);
 	event->ipa = FIELD_GET(EVTQ_3_IPA, event->raw[3]);
+	event->ttrnw = FIELD_GET(EVTQ_1_TT_READ, event->raw[1]);
+	event->ttrnw_valid = false;
 	event->smmu = smmu;
+	event->dev = NULL;
+
+	if (event->id == EVT_ID_PERMISSION_FAULT)
+		event->ttrnw_valid = (event->class == EVTQ_1_CLASS_TT);
+
+	mutex_lock(&smmu->streams_mutex);
+	master = arm_smmu_find_master(smmu, event->sid);
+	if (master)
+		event->dev = get_device(master->dev);
+	mutex_unlock(&smmu->streams_mutex);
+	event->master_name = event->dev ? dev_name(event->dev) : "(unassigned sid)";
 }
 
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
-	int i, ret;
 	struct arm_smmu_event evt;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
@@ -1850,15 +1946,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 		while (!queue_remove_raw(q, evt.raw)) {
 
 			arm_smmu_get_event_from_raw(smmu, &evt);
-			ret = arm_smmu_handle_evt(&evt);
-			if (!ret || !__ratelimit(&rs))
-				continue;
-
-			dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
-			for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
-				dev_info(smmu->dev, "\t0x%016llx\n",
-					(unsigned long long)evt.raw[i]);
+			if (arm_smmu_handle_evt(&evt))
+				arm_smmu_dump_event(&evt, &rs);
 
+			put_device(evt.dev);
 			cond_resched();
 		}
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 8a42d7b701fb..820b08f872af 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -438,10 +438,19 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
 #define EVTQ_0_ID			GENMASK_ULL(7, 0)
 
 /* Events */
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
@@ -774,7 +783,9 @@ struct arm_smmu_stream {
 };
 
 struct arm_smmu_event {
+	const char			*master_name;
 	struct arm_smmu_device		*smmu;
+	struct device			*dev;
 	u8				id;
 	u8				class;
 	u16				stag;
@@ -789,6 +800,8 @@ struct arm_smmu_event {
 	bool				instruction;
 	bool				s2;
 	bool				read;
+	bool				ttrnw;
+	bool				ttrnw_valid;
 };
 
 /* SMMU private data for each master */
-- 
2.47.0.rc1.288.g06298d1525-goog

