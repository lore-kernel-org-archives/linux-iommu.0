Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D968CCA483
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 15:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 145694196C;
	Tue, 21 Jun 2022 15:11:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 145694196C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.a=rsa-sha256 header.s=20161220 header.b=089q7ix7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v6a5syXab749; Tue, 21 Jun 2022 15:11:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0604F418DE;
	Tue, 21 Jun 2022 15:11:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0604F418DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7C6EC0039;
	Tue, 21 Jun 2022 15:11:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EE85C002D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B66483F6A
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:11:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B66483F6A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi
 header.a=rsa-sha256 header.s=20161220 header.b=089q7ix7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id taiT7H8NsZhD for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jun 2022 15:11:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4DA1183F7F
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DA1183F7F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jun 2022 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
 s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yb5ZRXXvSv1MiO+QoygFiVs/3UGGooAnjV7C1vURjL4=; b=089q7ix7VFyc4yPydq1N6VI+B8
 4nHdPI/mf4h525r1RrtY5SUl2VYpeJPcjCEhuc3aay5p8dLgHaQal5inGNQeXWfPOxVwf46Mavw4Q
 /ysL5EXfZq2YwT8gcDNgzE+yViN49zSoB4Tgrn9YWvWsLE8NMeHccN4O/fJA1FlX+IvyeZqprFd9S
 P0Dv1DD393IFmGEZnh/8wj+9QNYLGsDNY0EISTDZg4N30vaokDbtXYniXR+3HvEmwJAv4QguYcoih
 Ww1140KOOdzLE18qVEcDjU9W6iwieP7Z9K+91hA8eE6IP0HF7RWuhR1ABUO9MpbUl1JItRyGB94gn
 OfcFqUyw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70]
 helo=toshino.localdomain) by mail.kapsi.fi with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <cyndis@kapsi.fi>)
 id 1o3fWU-00Ea3F-JY; Tue, 21 Jun 2022 18:10:34 +0300
From: Mikko Perttunen <cyndis@kapsi.fi>
To: thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski@canonical.com
Subject: [PATCH v6 09/10] drm/tegra: Support context isolation
Date: Tue, 21 Jun 2022 18:10:21 +0300
Message-Id: <20220621151022.1416300-10-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621151022.1416300-1-cyndis@kapsi.fi>
References: <20220621151022.1416300-1-cyndis@kapsi.fi>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
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

From: Mikko Perttunen <mperttunen@nvidia.com>

For engines that support context isolation, allocate a context when
opening a channel, and set up stream ID offset and context fields
when submitting a job.

As of this commit, the stream ID offset and fallback stream ID
are not used when context isolation is disabled. However, with
upcoming patches that enable a full featured job opcode sequence,
these will be necessary.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v5:
* On supporting engines, always program stream ID offset and
  new fallback stream ID.
* Rename host1x_context to host1x_memory_context
v4:
* Separate error and output values in get_streamid_offset API
* Improve error handling
* Rename job->context to job->memory_context for clarity
---
 drivers/gpu/drm/tegra/drm.h    |  3 +++
 drivers/gpu/drm/tegra/submit.c | 48 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tegra/uapi.c   | 43 ++++++++++++++++++++++++++++--
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/drm.h b/drivers/gpu/drm/tegra/drm.h
index fc0a19554eac..2acc8f2948ad 100644
--- a/drivers/gpu/drm/tegra/drm.h
+++ b/drivers/gpu/drm/tegra/drm.h
@@ -80,6 +80,7 @@ struct tegra_drm_context {
 
 	/* Only used by new UAPI. */
 	struct xarray mappings;
+	struct host1x_memory_context *memory_context;
 };
 
 struct tegra_drm_client_ops {
@@ -91,6 +92,8 @@ struct tegra_drm_client_ops {
 	int (*submit)(struct tegra_drm_context *context,
 		      struct drm_tegra_submit *args, struct drm_device *drm,
 		      struct drm_file *file);
+	int (*get_streamid_offset)(struct tegra_drm_client *client, u32 *offset);
+	int (*can_use_memory_ctx)(struct tegra_drm_client *client, bool *supported);
 };
 
 int tegra_drm_submit(struct tegra_drm_context *context,
diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index 6d6dd8c35475..b24738bdf3df 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -498,6 +498,9 @@ static void release_job(struct host1x_job *job)
 	struct tegra_drm_submit_data *job_data = job->user_data;
 	u32 i;
 
+	if (job->memory_context)
+		host1x_memory_context_put(job->memory_context);
+
 	for (i = 0; i < job_data->num_used_mappings; i++)
 		tegra_drm_mapping_put(job_data->used_mappings[i].mapping);
 
@@ -588,11 +591,51 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 		goto put_job;
 	}
 
+	if (context->client->ops->get_streamid_offset) {
+		err = context->client->ops->get_streamid_offset(
+			context->client, &job->engine_streamid_offset);
+		if (err) {
+			SUBMIT_ERR(context, "failed to get streamid offset: %d", err);
+			goto unpin_job;
+		}
+	}
+
+	if (context->memory_context && context->client->ops->can_use_memory_ctx) {
+		bool supported;
+
+		err = context->client->ops->can_use_memory_ctx(context->client, &supported);
+		if (err) {
+			SUBMIT_ERR(context, "failed to detect if engine can use memory context: %d", err);
+			goto unpin_job;
+		}
+
+		if (supported) {
+			job->memory_context = context->memory_context;
+			host1x_memory_context_get(job->memory_context);
+		}
+	} else if (context->client->ops->get_streamid_offset) {
+#ifdef CONFIG_IOMMU_API
+		struct iommu_fwspec *spec;
+
+		/*
+		 * Job submission will need to temporarily change stream ID,
+		 * so need to tell it what to change it back to.
+		 */
+		spec = dev_iommu_fwspec_get(context->client->base.dev);
+		if (spec && spec->num_ids > 0)
+			job->engine_fallback_streamid = spec->ids[0] & 0xffff;
+		else
+			job->engine_fallback_streamid = 0x7f;
+#else
+		job->engine_fallback_streamid = 0x7f;
+#endif
+	}
+
 	/* Boot engine. */
 	err = pm_runtime_resume_and_get(context->client->base.dev);
 	if (err < 0) {
 		SUBMIT_ERR(context, "could not power up engine: %d", err);
-		goto unpin_job;
+		goto put_memory_context;
 	}
 
 	job->user_data = job_data;
@@ -627,6 +670,9 @@ int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
 
 	goto put_job;
 
+put_memory_context:
+	if (job->memory_context)
+		host1x_memory_context_put(job->memory_context);
 unpin_job:
 	host1x_job_unpin(job);
 put_job:
diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
index 9ab9179d2026..a98239cb0e29 100644
--- a/drivers/gpu/drm/tegra/uapi.c
+++ b/drivers/gpu/drm/tegra/uapi.c
@@ -33,6 +33,9 @@ static void tegra_drm_channel_context_close(struct tegra_drm_context *context)
 	struct tegra_drm_mapping *mapping;
 	unsigned long id;
 
+	if (context->memory_context)
+		host1x_memory_context_put(context->memory_context);
+
 	xa_for_each(&context->mappings, id, mapping)
 		tegra_drm_mapping_put(mapping);
 
@@ -72,6 +75,7 @@ static struct tegra_drm_client *tegra_drm_find_client(struct tegra_drm *tegra, u
 
 int tegra_drm_ioctl_channel_open(struct drm_device *drm, void *data, struct drm_file *file)
 {
+	struct host1x *host = tegra_drm_to_host1x(drm->dev_private);
 	struct tegra_drm_file *fpriv = file->driver_priv;
 	struct tegra_drm *tegra = drm->dev_private;
 	struct drm_tegra_channel_open *args = data;
@@ -102,10 +106,36 @@ int tegra_drm_ioctl_channel_open(struct drm_device *drm, void *data, struct drm_
 		}
 	}
 
+	/* Only allocate context if the engine supports context isolation. */
+	if (device_iommu_mapped(client->base.dev) && client->ops->can_use_memory_ctx) {
+		bool supported;
+
+		err = client->ops->can_use_memory_ctx(client, &supported);
+		if (err)
+			goto put_channel;
+
+		if (supported)
+			context->memory_context = host1x_memory_context_alloc(
+				host, get_task_pid(current, PIDTYPE_TGID));
+
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
@@ -118,6 +148,9 @@ int tegra_drm_ioctl_channel_open(struct drm_device *drm, void *data, struct drm_
 
 	return 0;
 
+put_memctx:
+	if (context->memory_context)
+		host1x_memory_context_put(context->memory_context);
 put_channel:
 	host1x_channel_put(context->channel);
 free:
@@ -156,6 +189,7 @@ int tegra_drm_ioctl_channel_map(struct drm_device *drm, void *data, struct drm_f
 	struct tegra_drm_mapping *mapping;
 	struct tegra_drm_context *context;
 	enum dma_data_direction direction;
+	struct device *mapping_dev;
 	int err = 0;
 
 	if (args->flags & ~DRM_TEGRA_CHANNEL_MAP_READ_WRITE)
@@ -177,6 +211,11 @@ int tegra_drm_ioctl_channel_map(struct drm_device *drm, void *data, struct drm_f
 
 	kref_init(&mapping->ref);
 
+	if (context->memory_context)
+		mapping_dev = &context->memory_context->dev;
+	else
+		mapping_dev = context->client->base.dev;
+
 	mapping->bo = tegra_gem_lookup(file, args->handle);
 	if (!mapping->bo) {
 		err = -EINVAL;
@@ -201,7 +240,7 @@ int tegra_drm_ioctl_channel_map(struct drm_device *drm, void *data, struct drm_f
 		goto put_gem;
 	}
 
-	mapping->map = host1x_bo_pin(context->client->base.dev, mapping->bo, direction, NULL);
+	mapping->map = host1x_bo_pin(mapping_dev, mapping->bo, direction, NULL);
 	if (IS_ERR(mapping->map)) {
 		err = PTR_ERR(mapping->map);
 		goto put_gem;
-- 
2.36.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
