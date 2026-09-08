Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921ED5908DE
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887870; cv=none; b=gAx0Tc8QHKwEp8ZKsmBx6o1QoYqBpscBveVmpdUKMbLHk6gKFfeVKNDuSXd2enodvHxSIM98MfK7kvuMkych8VbGJ/KIlFbK4ejizQP8eUHuENlpSpBfmHPJhfxtwy3KGRsVg05SFjtI58EALak00PIqQEMV5g/oKcP+h6B7Zjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887870; c=relaxed/simple;
	bh=MaaNrFZoorftxe/5xEyHHcF0ll5OmDC71WrwDpSAsqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VSqsU9PNqeiAzCPQJXzYO9nGnESj9Pd7YXoNnGNc6Ltu6BMelPircusibOsA0S3Tlh/Y7fLC/PQWHXFXiTJ36QdGuoUkka3+y5DFT/HDvRzxRxCrjgParPAy63BVi++dyQJGKOy9KlXtrfa1OzXeswftjbvbLfudsoBToUvcb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKZq4xMB; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKZq4xMB"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so1047022a12.1
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887867; x=1789492667; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fg33v8r0CDMBRVs9DFtJmNEUTUGaiIsk+dCr8ct6zII=;
        b=dKZq4xMBGAPz/qGXzB5k6n65KJMX0qwX4ZKQ35hvRMmFcX6153mx3nUVZT1m1ERpwp
         cHndgStAqoZAr1fROOtZxRa0faZgToIjAZFTFrDEF8sqcAp7obpT0lRAauEE4l6Eu8QS
         LfHeEnOrNLzoERZ+kUFp8ZltWvYTOZC1l67LOKZOqGzkG2k60rDmKiwdWoBRibVsu1qs
         kxYKGiEpezbUdl/u2jBvsonoQun39g4IDPFdPQERJFdIozwR3sKtnNjrwYIaI0HM9VcX
         lZUNsRcB7fEBYSUGG9W9mCnoZiT+YBhQXGvot59JbBhFwLrQ5ENt6u0ky8FD/Vg75Srq
         fgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887867; x=1789492667;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fg33v8r0CDMBRVs9DFtJmNEUTUGaiIsk+dCr8ct6zII=;
        b=qoumCEOn+5N8G3LIrh+QMrGrtb2bXXqZT/8qQgVXvdMOS8b7sGWwYsadGj+z2ksHXh
         7Ik8/KzSxirn00ky7nPWQRDQP+8rCbRpH5/On6ZV7cjq2qas+FUwajcWPNULu+9btqwv
         6DSwayu4E2dnYl0AE8Hn8ef9BYgaSv1gOywiqvti5pUZGZXYKSkIulbmrBxf4eH12EOQ
         C+7nT6gBb1lMkVgzMPcszqYv8DhkQNYrieuGIkcoHUNd+4J5sB6D6jU0RRgE4Ot1BpAM
         3gW0F+slk0nhVTK99IzBwos+BFyxltS+nYksP2QazwY7OiKtT9ybvKnuWXvjd5UsVgJC
         rfbg==
X-Gm-Message-State: AFuF++mAnY3nZMWDiaG89a0fABug+KphlQmCnU2XyzSQ+3awhPAMhMbn
	3yQv+gr+6V1WtRdkzCdVJF2zPZdiQEEqi4bru0zt0wGkI7AcNzlwDsUwq+yogkDCf4jUpSq2Nul
	rUuBOI706r0p8nTgX2KC7wRGZHmQ+eENZ+pA3973Tc9v8RD4295/zTEzFDnNwZEPRtCdnhTviFn
	45CmegKO81AF2aaa1Bp+vvrq0tmIDRgA==
X-Received: from pgca12-n1.prod.google.com ([2002:a05:6a02:638c:10b0:cbe:48b9:7b3a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d8b:b0:3c3:875d:7053
 with SMTP id adf61e73a8af0-3da39edb988mr51977054637.8.1788887867051; Tue, 08
 Sep 2026 10:17:47 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:17:10 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-15-praan@google.com>
Subject: [PATCH v10 14/15] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Invoke the pm_runtime helpers at all places before accessing the hw.
The idea is to invoke runtime_pm helpers at common points which are used
by exposed ops or interrupt handlers. TLB and CFG invalidations are
elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG.

In the threaded interrupt handlers (EVTQ/PRIQ), arm_smmu_rpm_get_if_active()
is used to avoid sleeping and deadlocking against synchronize_irq() during
suspend. Because device links guarantee client devices remain suspended
and cannot issue DMA until the SMMU has fully transitioned to RPM_ACTIVE,
no client-generated events can be received or dropped during transient
states like RPM_RESUMING.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  20 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 163 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
 3 files changed, 175 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 25982bdbcbd9..7150b9c497a4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -15,17 +15,28 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 	struct iommu_hw_info_arm_smmuv3 *info;
 	u32 __iomem *base_idr;
 	unsigned int i;
+	int ret;
+
+	ret = arm_smmu_rpm_get(master->smmu);
+	if (ret < 0)
+		return ERR_PTR(-EIO);
 
 	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
 	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
-		if (!impl_ops || !impl_ops->hw_info)
-			return ERR_PTR(-EOPNOTSUPP);
-		return impl_ops->hw_info(master->smmu, length, type);
+		void *ret_ptr = ERR_PTR(-EOPNOTSUPP);
+
+		if (impl_ops && impl_ops->hw_info)
+			ret_ptr = impl_ops->hw_info(master->smmu, length, type);
+
+		arm_smmu_rpm_put(master->smmu);
+		return ret_ptr;
 	}
 
 	info = kzalloc_obj(*info);
-	if (!info)
+	if (!info) {
+		arm_smmu_rpm_put(master->smmu);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	base_idr = master->smmu->base + ARM_SMMU_IDR0;
 	for (i = 0; i <= 5; i++)
@@ -39,6 +50,7 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 	*length = sizeof(*info);
 	*type = IOMMU_HW_INFO_TYPE_ARM_SMMUV3;
 
+	arm_smmu_rpm_put(master->smmu);
 	return info;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0a83d495d8d2..8e4ce5eb2228 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -121,7 +121,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
 
 /* Runtime PM helpers */
-__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -137,7 +137,7 @@ __maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-__maybe_unused static bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
+static bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
 {
 	if (!pm_runtime_enabled(smmu->dev))
 		return true;
@@ -145,7 +145,7 @@ __maybe_unused static bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *sm
 	return pm_runtime_get_if_active(smmu->dev) > 0;
 }
 
-__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -1186,6 +1186,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 				   struct iommu_page_response *resp)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
 	u8 resume_resp;
 
 	if (WARN_ON(!master->stall_enabled))
@@ -1204,6 +1205,23 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 		break;
 	}
 
+	/*
+	 * The SMMU is guaranteed to be active via device_link if any master is
+	 * active. Furthermore, on suspend we set GBPA to abort, flushing any
+	 * pending stalled transactions.
+	 *
+	 * Receiving a page fault while suspended or suspending implies a stale
+	 * event when the master has already powered down. A lockless pre-check
+	 * on STOP_FLAG avoids taking the PM lock if already suspended. If active,
+	 * arm_smmu_rpm_get_if_active() atomically acquires a PM reference under
+	 * power.lock, avoiding races against concurrent suspend and rejecting
+	 * responses during transient states like RPM_SUSPENDING.
+	 */
+	if (!arm_smmu_is_active(smmu) || !arm_smmu_rpm_get_if_active(smmu)) {
+		dev_err(smmu->dev, "Ignoring page fault while suspended / suspending\n");
+		return;
+	}
+
 	arm_smmu_cmdq_issue_cmd(master->smmu,
 				arm_smmu_make_cmd_resume(master->streams[0].id,
 							 resp->grpid,
@@ -1214,6 +1232,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	 * terminated... at some point in the future. PRI_RESP is fire and
 	 * forget.
 	 */
+	arm_smmu_rpm_put(smmu);
 }
 
 /* Invalidation array manipulation functions */
@@ -1739,7 +1758,6 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 			smmu, &cmds,
 			arm_smmu_make_cmd_cfgi_cd(master->streams[i].id, ssid,
 						  leaf));
-
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
@@ -2050,9 +2068,9 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 {
 	struct arm_smmu_ste_writer *ste_writer =
 		container_of(writer, struct arm_smmu_ste_writer, writer);
+	struct arm_smmu_device *smmu = writer->master->smmu;
 
-	arm_smmu_cmdq_issue_cmd_with_sync(
-		writer->master->smmu,
+	arm_smmu_cmdq_issue_cmd_with_sync(smmu,
 		arm_smmu_make_cmd_cfgi_ste(ste_writer->sid, true));
 }
 
@@ -2460,6 +2478,40 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
+	/*
+	 * Use a non-sleeping get to avoid a circular dependency deadlock
+	 * with arm_smmu_runtime_suspend().
+	 *
+	 * When using a combined_irq, the suspend thread waits for pending
+	 * threaded handlers to complete. If the IRQ thread blocks waiting
+	 * for the PM core, it creates a deadlock:
+	 *
+	 *  [Suspend Thread]                  | [IRQ Thread]
+	 *  pm_runtime_suspend()              |
+	 *    state = RPM_SUSPENDING;         |
+	 *                                    | IRQ fires
+	 *                                    | arm_smmu_rpm_get()
+	 *                                    |   sleeps (waiting for suspend)
+	 *  arm_smmu_runtime_suspend()        |
+	 *    ...                             |
+	 *    synchronize_irq()               |
+	 *      sleeps (waiting for IRQ)      |
+	 *
+	 *           <==== DEADLOCK ====>
+	 *
+	 * A non-sleeping get allows the thread to instantly drop the event
+	 * if the device is suspending, safely bypassing the synchronize_irq()
+	 * deadlock.
+	 *
+	 * Devlinks guarantee client devices cannot resume or issue DMA until
+	 * the SMMU has fully transitioned to RPM_ACTIVE, ensuring no valid
+	 * events can be generated during transient states like RPM_RESUMING.
+	 */
+	if (!arm_smmu_rpm_get_if_active(smmu)) {
+		dev_warn_ratelimited(smmu->dev, "client device is suspended, dropping event\n");
+		return IRQ_HANDLED;
+	}
+
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
@@ -2480,6 +2532,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2518,6 +2571,18 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	struct arm_smmu_ll_queue *llq = &q->llq;
 	u64 evt[PRIQ_ENT_DWORDS];
 
+	/*
+	 * Use non-sleeping get to avoid deadlock. Devlinks prevent page
+	 * requests from arriving during transient states like RPM_RESUMING.
+	 * (see the detailed comment in arm_smmu_evtq_thread)
+	 * Page requests require active client masters, which are held in
+	 * runtime suspend until the SMMU is fully RPM_ACTIVE.
+	 */
+	if (!arm_smmu_rpm_get_if_active(smmu)) {
+		dev_warn_ratelimited(smmu->dev, "client device is suspended, dropping page request\n");
+		return IRQ_HANDLED;
+	}
+
 	do {
 		while (!queue_remove_raw(q, evt))
 			arm_smmu_handle_ppr(smmu, evt);
@@ -2528,6 +2593,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2582,8 +2648,40 @@ static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
+	irqreturn_t ret;
 
-	return arm_smmu_handle_gerror(smmu);
+	/*
+	 * Global Errors are only processed if the SMMU is active.
+	 *
+	 * When the STOP_FLAG is set, the SMMU is disabled (CR0.SMMUEN = 0)
+	 * Any errors captured during the quiesce/drain phase (suspend)
+	 * will be handled by the explicit arm_smmu_handle_gerror() call at
+	 * the end of the arm_smmu_runtime_suspend() callback before power
+	 * down.
+	 *
+	 * During resume (RPM_RESUMING), the only operations that could
+	 * trigger a gerror are the CMDQ invalidation commands which are
+	 * only issued after the STOP_FLAG has already been cleared.
+	 *
+	 * Thus, no legitimate gerrors can ever occur while STOP_FLAG is
+	 * set. Any interrupt received while !arm_smmu_is_active() is
+	 * strictly spurious. Hence, returning IRQ_NONE correctly signals
+	 * an unhandled IRQ without missing any valid hardware errors.
+	 *
+	 * A lockless check is favoured here over a dynamic PM core check
+	 * since the runtime_pm_get_if_active would return false during
+	 * transient states like RPM_RESUMING & ignore level-triggered
+	 * interrupts.
+	 */
+	if (!arm_smmu_is_active(smmu)) {
+		dev_err(smmu->dev,
+			"Ignoring gerror interrupt because the SMMU is suspended\n");
+		return IRQ_NONE;
+	}
+
+	ret = arm_smmu_handle_gerror(smmu);
+
+	return ret;
 }
 
 static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
@@ -2666,6 +2764,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	struct arm_smmu_cmd cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
+	/* Shouldn't hit the WARN if there's no devlink inconsistency */
+	if (WARN_ON_ONCE(!arm_smmu_is_active(master->smmu)))
+		return 0;
+
 	cmd = arm_smmu_make_cmd_atc_inv_all(0, IOMMU_NO_PASID);
 	arm_smmu_cmdq_batch_init_cmd(master->smmu, &cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++)
@@ -2912,7 +3014,16 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 
 		if (cmds.num &&
 		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
+
+			/*
+			 * Concurrent suspend races are benign: the cmdq allocation cmpxchg
+			 * loop acts as the serialization point to safely drop the batch
+			 * without MMIO accesses. Concurrent resume is caught by the HW
+			 * reset cache invalidation, ensuring state consistency.
+			 */
 			arm_smmu_cmdq_batch_submit(smmu, &cmds);
+
+			/* Drop this batch to ensure the next one's fresh */
 			cmds.num = 0;
 		}
 		cur = next;
@@ -5135,14 +5246,37 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 static void arm_smmu_disable_action(void *data)
 {
 	struct arm_smmu_device *smmu = data;
+	int ret;
 
 	/* If the SMMU is already suspended, nothing to do */
 	if (!pm_runtime_suspended(smmu->dev)) {
+		ret = arm_smmu_rpm_get(smmu);
+		if (ret < 0) {
+			dev_err(smmu->dev, "failed to resume device for disable: %d\n", ret);
+			goto disable_pm;
+		}
+
 		if (smmu->impl_ops && smmu->impl_ops->device_disable)
 			smmu->impl_ops->device_disable(smmu);
 		arm_smmu_device_disable(smmu);
+
+		/*
+		 * A PM ref was only acquired via arm_smmu_rpm_get() to
+		 * guarantee power for the MMIO register writes in
+		 * arm_smmu_device_disable().
+		 *
+		 * Drop the PM ref, we intentionally do NOT invoke a
+		 * synchronous put/suspend here since the HW was already
+		 * disabled above. Calling put_sync would invoke
+		 * arm_smmu_runtime_suspend(), redundantly attempting to
+		 * do the same. Any pending autosuspend timer is cleanly
+		 * cancelled by pm_runtime_disable() immediately below.
+		 * The core code ensures the power management here.
+		 */
+		arm_smmu_rpm_put(smmu);
 	}
 
+disable_pm:
 	if (pm_runtime_enabled(smmu->dev)) {
 		pm_runtime_dont_use_autosuspend(smmu->dev);
 		pm_runtime_disable(smmu->dev);
@@ -5984,12 +6118,27 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
+	int ret;
 
 	/* If the SMMU is already suspended, nothing to do */
 	if (pm_runtime_suspended(&pdev->dev))
 		return;
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to resume device for shutdown: %d\n", ret);
+		return;
+	}
+
 	arm_smmu_device_disable(smmu);
+	/*
+	 * Drop the PM ref acquired for the MMIO disable write.
+	 * An asynchronous put is intentional here as the HW is already
+	 * disabled (CR0 disabled), and the system is in the middle of
+	 * reboot/poweroff. Initiating a synchronous runtime suspend here
+	 * would redundantly disable SMMU and delay system powerdown.
+	 */
+	arm_smmu_rpm_put(smmu);
 }
 
 static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d0a3d497915c..a018913d3bb8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1249,6 +1249,9 @@ static inline bool arm_smmu_is_active(struct arm_smmu_device *smmu)
 	return !Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
 }
 
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu);
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
-- 
2.55.0.979.g7e5102b832-goog

