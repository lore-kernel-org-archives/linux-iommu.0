Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4464DC433E6
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 16:41:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0638E64E8C
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 16:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0638E64E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DD85586D78;
	Mon,  8 Feb 2021 16:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qZMmrDB2qRPM; Mon,  8 Feb 2021 16:41:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 520AE86DCC;
	Mon,  8 Feb 2021 16:41:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E9BEC1DA9;
	Mon,  8 Feb 2021 16:41:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86E79C013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 16:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7586C86FD1
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 16:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FWKFo4ytRZnc for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 16:41:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D666786FB1
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dMAh1MNck3e2VRmcao1RhRO5KxC9ewWuSldpLdYqPJE=; b=2Bavg5JYwLJkBoT+joSv1vCEss
 dDQMGRJApeOztQqsbb+LsVsiyDuKS/bbcfe0Ybm/ncO/bwNI2A9v/SSfzGfpX2JznB1z6nwwEbid2
 hP8hzI1bbDag/COrEujQiEeXrt156euzfcRyOfr8d5AK61OXq85Z3nAPtT9e9eIKQwUKefPWrf1cs
 sz5AOPTZPJkE4n4IsCHOiwE/HDBDOG41NzYSks8ziE71WcXTwe2RdY3XFXQYUyBUlceFiruyGs82Y
 Q3OpUBVzupKr6MgWM8N5xAND0u3sYq6bWBrz715PekJ2f08NSQha4pc2/9ozLU0tdrILcngH8b+hD
 ov0NeY8A==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236]
 helo=toshino.localdomain)
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <mperttunen@nvidia.com>)
 id 1l99as-0000Cr-Td; Mon, 08 Feb 2021 18:40:58 +0200
From: Mikko Perttunen <mperttunen@nvidia.com>
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robh+dt@kernel.org, frowand.list@gmail.com,
 robin.murphy@arm.com
Subject: [RFC PATCH 4/8] gpu: host1x: Program context stream ID on submission
Date: Mon,  8 Feb 2021 18:38:44 +0200
Message-Id: <20210208163848.2504291-5-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208163848.2504291-1-mperttunen@nvidia.com>
References: <20210208163848.2504291-1-mperttunen@nvidia.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 84.249.134.236
X-SA-Exim-Mail-From: mperttunen@nvidia.com
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Add code to do stream ID switching at the beginning of a job. The
stream ID is switched to the stream ID specified by the context
passed in the job structure.

Before switching the stream ID, an OP_DONE wait is done on the
channel's engine to ensure that there is no residual ongoing
work that might do DMA using the new stream ID.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/hw/channel_hw.c        | 52 +++++++++++++++++++++--
 drivers/gpu/host1x/hw/host1x06_hardware.h | 10 +++++
 drivers/gpu/host1x/hw/host1x07_hardware.h | 10 +++++
 include/linux/host1x.h                    |  4 ++
 4 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/host1x/hw/channel_hw.c b/drivers/gpu/host1x/hw/channel_hw.c
index d88a32f73f5e..f97296864da8 100644
--- a/drivers/gpu/host1x/hw/channel_hw.c
+++ b/drivers/gpu/host1x/hw/channel_hw.c
@@ -129,6 +129,45 @@ static void host1x_channel_set_streamid(struct host1x_channel *channel)
 #endif
 }
 
+static void host1x_channel_program_engine_streamid(struct host1x_job *job)
+{
+#if HOST1X_HW >= 6
+	u32 fence;
+
+	if (!job->context)
+		return;
+
+	fence = host1x_syncpt_incr_max(job->syncpt, 1);
+
+	/* First, increment a syncpoint on OP_DONE condition.. */
+
+	host1x_cdma_push(&job->channel->cdma,
+		host1x_opcode_nonincr(HOST1X_UCLASS_INCR_SYNCPT, 1),
+		HOST1X_UCLASS_INCR_SYNCPT_INDX_F(job->syncpt->id) |
+			HOST1X_UCLASS_INCR_SYNCPT_COND_F(1));
+
+	/* Wait for syncpoint to increment */
+
+	host1x_cdma_push(&job->channel->cdma,
+		host1x_opcode_setclass(HOST1X_CLASS_HOST1X,
+			host1x_uclass_wait_syncpt_r(), 1),
+		host1x_class_host_wait_syncpt(job->syncpt->id, fence));
+
+	/*
+	 * Now that we know the engine is idle, return to class and
+	 * change stream ID.
+	 */
+
+	host1x_cdma_push(&job->channel->cdma,
+		host1x_opcode_setclass(job->class, 0, 0),
+		HOST1X_OPCODE_NOP);
+
+	host1x_cdma_push(&job->channel->cdma,
+		host1x_opcode_setpayload(job->context->stream_id),
+		host1x_opcode_setstreamid(job->engine_streamid_offset / 4));
+#endif
+}
+
 static int channel_submit(struct host1x_job *job)
 {
 	struct host1x_channel *ch = job->channel;
@@ -184,18 +223,23 @@ static int channel_submit(struct host1x_job *job)
 	if (sp->base)
 		synchronize_syncpt_base(job);
 
-	syncval = host1x_syncpt_incr_max(sp, user_syncpt_incrs);
-
 	host1x_hw_syncpt_assign_to_channel(host, sp, ch);
 
-	job->syncpt_end = syncval;
-
 	/* add a setclass for modules that require it */
 	if (job->class)
 		host1x_cdma_push(&ch->cdma,
 				 host1x_opcode_setclass(job->class, 0, 0),
 				 HOST1X_OPCODE_NOP);
 
+	/*
+	 * Ensure engine DMA is idle and set new stream ID. May increment
+	 * syncpt max.
+	 */
+	host1x_channel_program_engine_streamid(job);
+
+	syncval = host1x_syncpt_incr_max(sp, user_syncpt_incrs);
+	job->syncpt_end = syncval;
+
 	submit_gathers(job);
 
 	/* end CDMA submit & stash pinned hMems into sync queue */
diff --git a/drivers/gpu/host1x/hw/host1x06_hardware.h b/drivers/gpu/host1x/hw/host1x06_hardware.h
index 01a142a09800..5d515745eee7 100644
--- a/drivers/gpu/host1x/hw/host1x06_hardware.h
+++ b/drivers/gpu/host1x/hw/host1x06_hardware.h
@@ -127,6 +127,16 @@ static inline u32 host1x_opcode_gather_incr(unsigned offset, unsigned count)
 	return (6 << 28) | (offset << 16) | BIT(15) | BIT(14) | count;
 }
 
+static inline u32 host1x_opcode_setstreamid(unsigned streamid)
+{
+	return (7 << 28) | streamid;
+}
+
+static inline u32 host1x_opcode_setpayload(unsigned payload)
+{
+	return (9 << 28) | payload;
+}
+
 static inline u32 host1x_opcode_gather_wide(unsigned count)
 {
 	return (12 << 28) | count;
diff --git a/drivers/gpu/host1x/hw/host1x07_hardware.h b/drivers/gpu/host1x/hw/host1x07_hardware.h
index e6582172ebfd..82c0cc9bb0b5 100644
--- a/drivers/gpu/host1x/hw/host1x07_hardware.h
+++ b/drivers/gpu/host1x/hw/host1x07_hardware.h
@@ -127,6 +127,16 @@ static inline u32 host1x_opcode_gather_incr(unsigned offset, unsigned count)
 	return (6 << 28) | (offset << 16) | BIT(15) | BIT(14) | count;
 }
 
+static inline u32 host1x_opcode_setstreamid(unsigned streamid)
+{
+	return (7 << 28) | streamid;
+}
+
+static inline u32 host1x_opcode_setpayload(unsigned payload)
+{
+	return (9 << 28) | payload;
+}
+
 static inline u32 host1x_opcode_gather_wide(unsigned count)
 {
 	return (12 << 28) | count;
diff --git a/include/linux/host1x.h b/include/linux/host1x.h
index 3cf3c6a0b225..3bf19080f1c1 100644
--- a/include/linux/host1x.h
+++ b/include/linux/host1x.h
@@ -272,6 +272,10 @@ struct host1x_job {
 	/* Callback called when job is freed */
 	void (*release)(struct host1x_job *job);
 	void *user_data;
+
+	/* Options for configuring engine data stream ID */
+	struct host1x_context *context;
+	u32 engine_streamid_offset;
 };
 
 struct host1x_job *host1x_job_alloc(struct host1x_channel *ch,
-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
