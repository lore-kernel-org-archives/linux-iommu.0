Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958EEC433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 15:13:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2604C6112E
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 15:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2604C6112E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1A1040236;
	Thu, 16 Sep 2021 15:13:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pRWy85CUboIR; Thu, 16 Sep 2021 15:13:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A8364407D3;
	Thu, 16 Sep 2021 15:13:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B6A0C0011;
	Thu, 16 Sep 2021 15:13:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3115BC000D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 13CCB83EB9
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kapsi.fi
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xAlu6cWggLWd for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 15:13:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5C17E83EB6
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xtxY+cXT8XfPoPIGlZyiPeXDXul2zQL4SqWivDuepj4=; b=QV15Ac0XhHrt5pDBOkpviaHDeu
 lKoPCHIrQh5xpfB2IzNL+4Sw7Qnow9KyDZ1xtQYDZwnNvHux8UYRKptD64nQJ+WdLtPZM2BQhAh0W
 KONWoXth4fs6j7Z4pp7p25R3wQzBPoy0ylhX3gSCYFu6T035vt/TSDDrabzn1NLVYkTHOA+KcawOE
 pDDmwXD4xJjGNqqiC/N7qHd5rqy80ozxwzM+1Ce0emf4ozIgiUxnDLJ68iZC0dUFG0N4VcmyYAvS4
 wOg4oE85Uud9uB5RE0bNL31rbK/IOK8FHThsvR/mRUw2NG0SLRDWDE5pxniss5PUlQNa142+IKI/V
 lYTEnVSQ==;
Received: from dsl-hkibng22-54f986-236.dhcp.inet.fi ([84.249.134.236]
 helo=toshino.localdomain)
 by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <mperttunen@nvidia.com>)
 id 1mQsRw-0005Xx-Dm; Thu, 16 Sep 2021 17:33:16 +0300
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
Subject: [PATCH v2 8/8] drm/tegra: Support context isolation
Date: Thu, 16 Sep 2021 17:33:02 +0300
Message-Id: <20210916143302.2024933-9-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916143302.2024933-1-mperttunen@nvidia.com>
References: <20210916143302.2024933-1-mperttunen@nvidia.com>
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
From: Mikko Perttunen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Mikko Perttunen <mperttunen@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

For engines that support context isolation, allocate a context when
opening a channel, and set up stream ID offset and context fields
when submitting a job.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/drm.h    |  2 ++
 drivers/gpu/drm/tegra/submit.c | 13 +++++++++++++
 drivers/gpu/drm/tegra/uapi.c   | 34 ++++++++++++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index fc0a19554eac..717e9f81ee1f 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -80,6 +80,7 @@ struct tegra_drm_context {
 
 	/* Only used by new UAPI. */
 	struct xarray mappings;
+	struct host1x_context *memory_context;
 };
 
 struct tegra_drm_client_ops {
@@ -91,6 +92,7 @@ struct tegra_drm_client_ops {
 	int (*submit)(struct tegra_drm_context *context,
 		      struct drm_tegra_submit *args, struct drm_device *drm,
 		      struct drm_file *file);
+	int (*get_streamid_offset)(struct tegra_drm_client *client);
 };
 
 int tegra_drm_submit(struct tegra_drm_context *context,
diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index 776f825df52f..b6008246bebe 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -469,6 +469,9 @@ static void release_job(struct host1x_job *job)
 	struct tegra_drm_submit_data *job_data = job->user_data;
 	u32 i;
 
+	if (job->context)
+		host1x_context_put(job->context);
+
 	for (i = 0; i < job_data->num_used_mappings; i++)
 		tegra_drm_mapping_put(job_data->used_mappings[i].mapping);
 
@@ -572,6 +575,16 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 	job->release = release_job;
 	job->timeout = 10000;
 
+	if (context->memory_context && context->client->ops->get_streamid_offset) {
+		int offset = context->client->ops->get_streamid_offset(context->client);
+
+		if (offset >= 0) {
+			job->context = context->memory_context;
+			job->engine_streamid_offset = offset;
+			host1x_context_get(job->context);
+		}
+	}
+
 	/*
 	 * job_data is now part of job reference counting, so don't release
 	 * it from here.
diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
index 690a339c52ec..bfded46b974a 100644
--- a/drivers/gpu/drm/tegra/uapi.c
+++ b/drivers/gpu/drm/tegra/uapi.c
@@ -37,6 +37,9 @@ static void tegra_drm_channel_context_close(struct tegra_drm_context *context)
 	struct tegra_drm_mapping *mapping;
 	unsigned long id;
 
+	if (context->memory_context)
+		host1x_context_put(context->memory_context);
+
 	xa_for_each(&context->mappings, id, mapping)
 		tegra_drm_mapping_put(mapping);
 
@@ -76,6 +79,7 @@ static struct tegra_drm_client *tegra_drm_find_client(struct tegra_drm *tegra, u
 
 int tegra_drm_ioctl_channel_open(struct drm_device *drm, void *data, struct drm_file *file)
 {
+	struct host1x *host = tegra_drm_to_host1x(drm->dev_private);
 	struct tegra_drm_file *fpriv = file->driver_priv;
 	struct tegra_drm *tegra = drm->dev_private;
 	struct drm_tegra_channel_open *args = data;
@@ -106,10 +110,29 @@ int tegra_drm_ioctl_channel_open(struct drm_device *drm, void *data, struct drm_
 		}
 	}
 
+	/* Only allocate context if the engine supports context isolation. */
+	if (client->ops->get_streamid_offset &&
+	    client->ops->get_streamid_offset(client) >= 0) {
+		context->memory_context =
+			host1x_context_alloc(host, get_task_pid(current, PIDTYPE_TGID));
+		if (IS_ERR(context->memory_context)) {
+			if (PTR_ERR(context->memory_context) != -EOPNOTSUPP) {
+				err = PTR_ERR(context->memory_context);
+				goto put_channel;
+			} else {
+				/*
+				 * OK, HW does not support contexts or contexts
+				 * are disabled.
+				 */
+				context->memory_context = NULL;
+			}
+		}
+	}
+
 	err = xa_alloc(&fpriv->contexts, &args->context, context, XA_LIMIT(1, U32_MAX),
 		       GFP_KERNEL);
 	if (err < 0)
-		goto put_channel;
+		goto put_memctx;
 
 	context->client = client;
 	xa_init_flags(&context->mappings, XA_FLAGS_ALLOC1);
@@ -122,6 +145,9 @@ int tegra_drm_ioctl_channel_open(struct drm_device *drm, void *data, struct drm_
 
 	return 0;
 
+put_memctx:
+	if (context->memory_context)
+		host1x_context_put(context->memory_context);
 put_channel:
 	host1x_channel_put(context->channel);
 free:
@@ -180,7 +206,11 @@ int tegra_drm_ioctl_channel_map(struct drm_device *drm, void *data, struct drm_f
 
 	kref_init(&mapping->ref);
 
-	mapping->dev = context->client->base.dev;
+	if (context->memory_context)
+		mapping->dev = &context->memory_context->dev;
+	else
+		mapping->dev = context->client->base.dev;
+
 	mapping->bo = tegra_gem_lookup(file, args->handle);
 	if (!mapping->bo) {
 		err = -EINVAL;
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
