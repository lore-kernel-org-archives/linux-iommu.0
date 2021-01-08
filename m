Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C613CC433DB
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BCB23A00
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 15:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BCB23A00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 21B2A87351;
	Fri,  8 Jan 2021 15:02:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rbO7LdqPUezs; Fri,  8 Jan 2021 15:02:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A7F2687336;
	Fri,  8 Jan 2021 15:02:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2B16C0891;
	Fri,  8 Jan 2021 15:02:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2230C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AE04B86DDA
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jbM-3Nix2egh for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 15:02:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 48DE686DD2
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 15:02:39 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id r7so9301789wrc.5
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rq9YnnCF9pdwgtYQnAeAXZZ3IcyhY6ekEgWvAJDOTvU=;
 b=IOiIJ8XNWCYvh1BpdfwseM30i/6ubKq3gTxQ3kfsHcKH4vdf6xouFBxx92TK+XyBOV
 lfx3XKMqBbNHQoYc+5nHBlyllKI2q7MiUoiOryqcfXxUF2Ndo/Fv2p0r3cOSuHPKr5gu
 PfgQUwRqI2avykbcVZ8/sl8HrU5jrEUbEVqqSmwK97m4fyhX7QYvkXmSf8mKj7Ur1+P7
 Ljp1Sx222jgPaZDOdeXXJqd6WAK5UXSGrzvUtbNo3cEVsnkKBq1kUcbMrQBzeIwzGU1P
 NdabWgqIx+pZmLWdopyFpUire4LOjhNFMCxYSnMgppg3i6OxXi+DYEdeML5Gy63tWc9e
 PgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rq9YnnCF9pdwgtYQnAeAXZZ3IcyhY6ekEgWvAJDOTvU=;
 b=TpxRxrDdBIEZL72BkFc9gDZDKJG9qQBSdBeTk2D1Rp1BTWGrtt1T+IVNzqKqbSlV6a
 6FjA5CLoACiEkMGCfu5UgSwcWdW92ISa2UK0EnQ2whooZ5UtwK3r1kwCykf6xBOrIkDG
 tKt5R55seDFrrEkECl8XjN0po+OTfgOopXs/TnvAS3A9GH8wtt69n+0B3Ur+N75xZOWf
 ix6EvbzDJnr1zxj14x0t/Gr7gTJ5ukgt26eV9k1IVuXQWcyAKnO622xhg823udUPSmnI
 Lrme+VpK7lI1Wseg6fajblt9+NUYgtqGovCw3uNZ948ybSRwRe7sYbItIyAl+Amk+get
 vXlw==
X-Gm-Message-State: AOAM530hiAlV4a8/8fO/uL52exT+kcSWu6loLA0hi25H3xjeSgWjNwi3
 t18IaLFBhoU2ZKYz9TYd6C6FAg==
X-Google-Smtp-Source: ABdhPJwJCscGG7pODg02NfrYn2+RgYVb0v/9gne/VpBeP9PUNk6Pbf8YDqMssBbm/DGKac875QXFsQ==
X-Received: by 2002:a5d:4ccf:: with SMTP id c15mr4079408wrt.237.1610118157731; 
 Fri, 08 Jan 2021 07:02:37 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s13sm14258464wra.53.2021.01.08.07.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 07:02:37 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v9 07/10] iommu/arm-smmu-v3: Maintain a SID->device structure
Date: Fri,  8 Jan 2021 15:52:15 +0100
Message-Id: <20210108145217.2254447-8-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, guohanjun@huawei.com,
 rjw@rjwysocki.net, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-accelerators@lists.ozlabs.org, sudeep.holla@arm.com,
 vivek.gautam@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When handling faults from the event or PRI queue, we need to find the
struct device associated with a SID. Add a rb_tree to keep track of
SIDs.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 161 ++++++++++++++++----
 2 files changed, 144 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 96c2e9565e00..8ef6a1c48635 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -636,6 +636,15 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	struct rb_root			streams;
+	struct mutex			streams_mutex;
+};
+
+struct arm_smmu_stream {
+	u32				id;
+	struct arm_smmu_master		*master;
+	struct rb_node			node;
 };
 
 /* SMMU private data for each master */
@@ -644,8 +653,8 @@ struct arm_smmu_master {
 	struct device			*dev;
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
-	u32				*sids;
-	unsigned int			num_sids;
+	struct arm_smmu_stream		*streams;
+	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				sva_enabled;
 	struct list_head		bonds;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6a53b4edf054..2dbae2e6965d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -912,8 +912,8 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		for (i = 0; i < master->num_sids; i++) {
-			cmd.cfgi.sid = master->sids[i];
+		for (i = 0; i < master->num_streams; i++) {
+			cmd.cfgi.sid = master->streams[i].id;
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 		}
 	}
@@ -1355,6 +1355,32 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+__maybe_unused
+static struct arm_smmu_master *
+arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct rb_node *node;
+	struct arm_smmu_stream *stream;
+	struct arm_smmu_master *master = NULL;
+
+	mutex_lock(&smmu->streams_mutex);
+	node = smmu->streams.rb_node;
+	while (node) {
+		stream = rb_entry(node, struct arm_smmu_stream, node);
+		if (stream->id < sid) {
+			node = node->rb_right;
+		} else if (stream->id > sid) {
+			node = node->rb_left;
+		} else {
+			master = stream->master;
+			break;
+		}
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	return master;
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
@@ -1588,8 +1614,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 
 	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
 
-	for (i = 0; i < master->num_sids; i++) {
-		cmd.atc.sid = master->sids[i];
+	for (i = 0; i < master->num_streams; i++) {
+		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
 	}
 
@@ -1632,8 +1658,8 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 		if (!master->ats_enabled)
 			continue;
 
-		for (i = 0; i < master->num_sids; i++) {
-			cmd.atc.sid = master->sids[i];
+		for (i = 0; i < master->num_streams; i++) {
+			cmd.atc.sid = master->streams[i].id;
 			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
 		}
 	}
@@ -2040,13 +2066,13 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
 
-	for (i = 0; i < master->num_sids; ++i) {
-		u32 sid = master->sids[i];
+	for (i = 0; i < master->num_streams; ++i) {
+		u32 sid = master->streams[i].id;
 		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
-			if (master->sids[j] == sid)
+			if (master->streams[j].id == sid)
 				break;
 		if (j < i)
 			continue;
@@ -2319,11 +2345,101 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 	return sid < limit;
 }
 
+static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
+				  struct arm_smmu_master *master)
+{
+	int i;
+	int ret = 0;
+	struct arm_smmu_stream *new_stream, *cur_stream;
+	struct rb_node **new_node, *parent_node = NULL;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+
+	master->streams = kcalloc(fwspec->num_ids,
+				  sizeof(struct arm_smmu_stream), GFP_KERNEL);
+	if (!master->streams)
+		return -ENOMEM;
+	master->num_streams = fwspec->num_ids;
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids && !ret; i++) {
+		u32 sid = fwspec->ids[i];
+
+		new_stream = &master->streams[i];
+		new_stream->id = sid;
+		new_stream->master = master;
+
+		/*
+		 * Check the SIDs are in range of the SMMU and our stream table
+		 */
+		if (!arm_smmu_sid_in_range(smmu, sid)) {
+			ret = -ERANGE;
+			break;
+		}
+
+		/* Ensure l2 strtab is initialised */
+		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+			ret = arm_smmu_init_l2_strtab(smmu, sid);
+			if (ret)
+				break;
+		}
+
+		/* Insert into SID tree */
+		new_node = &(smmu->streams.rb_node);
+		while (*new_node) {
+			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
+					      node);
+			parent_node = *new_node;
+			if (cur_stream->id > new_stream->id) {
+				new_node = &((*new_node)->rb_left);
+			} else if (cur_stream->id < new_stream->id) {
+				new_node = &((*new_node)->rb_right);
+			} else {
+				dev_warn(master->dev,
+					 "stream %u already in tree\n",
+					 cur_stream->id);
+				ret = -EINVAL;
+				break;
+			}
+		}
+
+		if (!ret) {
+			rb_link_node(&new_stream->node, parent_node, new_node);
+			rb_insert_color(&new_stream->node, &smmu->streams);
+		}
+	}
+
+	if (ret) {
+		for (; i > 0; i--)
+			rb_erase(&master->streams[i].node, &smmu->streams);
+		kfree(master->streams);
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	return ret;
+}
+
+static void arm_smmu_remove_master(struct arm_smmu_master *master)
+{
+	int i;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+
+	if (!smmu || !master->streams)
+		return;
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids; i++)
+		rb_erase(&master->streams[i].node, &smmu->streams);
+	mutex_unlock(&smmu->streams_mutex);
+
+	kfree(master->streams);
+}
+
 static struct iommu_ops arm_smmu_ops;
 
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
-	int i, ret;
+	int ret;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master *master;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -2344,27 +2460,12 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
-	master->sids = fwspec->ids;
-	master->num_sids = fwspec->num_ids;
 	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
-	/* Check the SIDs are in range of the SMMU and our stream table */
-	for (i = 0; i < master->num_sids; i++) {
-		u32 sid = master->sids[i];
-
-		if (!arm_smmu_sid_in_range(smmu, sid)) {
-			ret = -ERANGE;
-			goto err_free_master;
-		}
-
-		/* Ensure l2 strtab is initialised */
-		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-			ret = arm_smmu_init_l2_strtab(smmu, sid);
-			if (ret)
-				goto err_free_master;
-		}
-	}
+	ret = arm_smmu_insert_master(smmu, master);
+	if (ret)
+		goto err_free_master;
 
 	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
 	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
@@ -2403,6 +2504,7 @@ static void arm_smmu_release_device(struct device *dev)
 	WARN_ON(arm_smmu_master_sva_enabled(master));
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
+	arm_smmu_remove_master(master);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
@@ -2825,6 +2927,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	mutex_init(&smmu->streams_mutex);
+	smmu->streams = RB_ROOT;
+
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
 		return ret;
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
