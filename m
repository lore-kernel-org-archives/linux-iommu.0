Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813259;
	b=BSwmmeYjEzV6AdCk3I30pJ7QXK9ZkBO3cAP2DnHMuthjye7GgQUDBnp4xdmrhewHxdsH
	 cSKpqi53VKUG0HUeCyI4sINXmtNbc+yTHYEwZZsYnxfkRoHPsX3uZab/diJxK/5otoIh/
	 a/X0MIm+Uj6VKBE4AxKOKLMRo4KvmEGFaxbE0Ms5/lzoBS+Pz5IYNuzkEkJmKu5GG/Di7
	 uRL2fUDfjxvPZOeXGB85Jxn5tx40HRmwnghHuUSKgFGhdiglFXqrkbBO6JFRh12x+Jgo8
	 1v3gWnHN+MWIFxUT81ai+LJ0JNPQcsirAvNdK6IMofpn3HMY1iLJTalcOmtSlmoLppg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lD8smwGXYocwft1WL1JcoM2WfeV21QF9P31PQZqIk5I=;
	b=zvFXbyBF1om6DbvhYdl1ARraH+0EnzzZzvgC8VNpsBteUOIahMxvXFBI3GV+OFhNTdqO
	 B8A62nVv6XF8dZGfz9o3VcrNo+uR0mlICmcUZ8jXseTjk9/sO2VPNJRsTsg5QyrhxwUv+
	 j287in4XmMZ1ShCLRbUAgcwkOj9g3Z0q+4bTKR031iOs8tWhSQHj0XwgBhwQ1d5emsV6l
	 y+dSF9u4EF/JAKC6vTS3BDJnu8cNelBZ1Q+7qAZhVnK9UW6/4QO1uuXgsDPGrqEqXSMTM
	 yA7kbRv1rY2n27sky02YqFeHfht9LpLEeS+0Y9WbbEgkEbRFKlLzQWzXkeIdyzV82ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kgQEzK2X;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA952606A332
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 07:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA952606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kgQEzK2X
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33fb4680717so8533341eec.1
        for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 23:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794813258; x=1795418058; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lD8smwGXYocwft1WL1JcoM2WfeV21QF9P31PQZqIk5I=;
        b=kgQEzK2XjbFSrC5olhflWA4VlKaF3iS0+eSsL35CMht7479jRkr9ONy6Ump+LoP55W
         Wjj/0kdoE7T8xk3/HaZotZ8CkH8iUE5aZJILpQZY9ieAhnpkwODusbq+EXEljBOoY2rP
         OJb6Qa/ZUD1OYaWUHA3MFMzHYPUxkTGisai4Y0/mxK1J1Kmsprckbv051T4+Z7kpTvg5
         UO06SwxHqJt/985n6711d85VBMTJSKFHz7Q17dfIm/gqdnIwPW8hjh/ER4CeQKlZe0YO
         4lm+/PspscYGaJnjcv0kKS8AA4Vx/xFUAVo04X7fECc3u9n7d1vEJbqlTqFaIHzoNV+F
         HG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813258; x=1795418058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lD8smwGXYocwft1WL1JcoM2WfeV21QF9P31PQZqIk5I=;
        b=roDlsPlUeiv//oAkhIkZ8lLrQ1YtKlpGOYj9jXyo0Z6d60iK04EghecCCgBZA9hB3Y
         G1JghnHrDYpczz+IQLRiNhQKpXpSQp04QTS68+3yaBm/v5ctl57reVEls6tqD60RA5pt
         ZwjX3OdJWyBq58qYDsEJbZ88PFFT8lXFq5w1bObN7mMenBlk6jnUXv9QIpgmAz0Ik+8T
         ERksI2I4bU5qrQmmoXmoRLyjGQ1JGmcJuzwoelHXfP5Y1lp4qgl2ciwhQqfyjSUKWJMk
         zI0scMYp+idLlFE+VIQphLKZyzhASIoWAzUBkSLqD0vArSDjsf95//tc02XgApy4SyjR
         n+3g==
X-Forwarded-Encrypted: i=1; AL+hErEtXKj6QM0v3zgmV96kFmtxIzo3/w0LCkF9OW4fKMVIwZZhhAQhl2DZx5he279JOuiNyZqE2g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/HbNC0VHWm51sd08ikhHd1qDFQ0DyMGHhiHsVOb99+L69DVa+b
	uM7I6UdVxb4w/Il/VIZR6Kop1l1GOQYFpmbpdDJs/AkWK6gbVAo2YwyjTctbsUtYQp8=
X-Gm-Gg: AYBFou1DSNfUaH9ZvCZnd6Hw85kf1gWON0Y1VQVZodHTBblKsasvP5rY5YXiGu/xJaR
	z3WYgjy+uwFk5P274RhyYkcGA1gcG2M05D6hPfRB6Dr158TpAwt1WfelOK7DHz9jNYlZQwfNrrU
	l9JZUS+wl38QmHaoNh2NyKEXTeUiEWrtoe00qyT9kF4oFP+G8euAu3sSqg1sS5akWBRmff30OZr
	t7SSHwkhyfe5rg79Y8lBXQbXMDBoutIvu4EoXBRxq4+t/EAS7NBvS2+xTeNoRCc5MBV2NXO2gDz
	EkmY4SygKv6PcBquhm7dP+/ZZDBf6M00uPgFnxm0fCkiGPkO+Nu4ApWhnCj3YNnjUUV/LXM3xfW
	1sjwYInylnK6s6wW70IRwhdHKumXeGyOKyceHliA1JbSFYv6GFM2uzs6ysb9ate1nRqENR8SISO
	RDAtRsz35+MdLFq9bBH04gh5LSRgG+aF+wieUS+Y3f8ZBlAuKgzzadchQWClRjURuDUpzRFX43q
	lls4jplKw8X8uc61Km2filEZ8w3HDweKcmgJ4X2ry45P5/QS1ZAH3Ow8O+oZjVyc5LYFX+IQWKi
	20Qjnu8G807PSuWNry806PD6HPZtRMGslKEXgR7F3ZhWw0vdCxIOMLOPR1A0HSwB6cnMloVKFKE
	5Rxiu/g==
X-Received: by 2002:a05:701b:251c:b0:187:eb7f:bb4 with SMTP id a92af1059eb24-1b503169356mr9334211c88.46.1794813257635;
        Sun, 15 Nov 2026 23:14:17 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332ae7sm47858505eec.8.2026.11.15.23.14.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:14:17 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: joro@8bytes.org,
	palmer@dabbelt.com,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	tomasz.jeznach@linux.dev
Cc: fustini@kernel.org,
	jgg@ziepe.ca,
	james.morse@arm.com,
	ben.horgan@arm.com,
	xiaqinxin@huawei.com,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Dave.Martin@arm.com,
	babu.moger@amd.com,
	kevin.tian@intel.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	shuah@kernel.org,
	randy.dunlap@infradead.org,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH v2 2/4] iommu/riscv: Register independently tagged devices with resctrl
Date: Mon, 16 Nov 2026 15:13:41 +0800
Message-ID: <20261116071338.35991-8-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261116071338.35991-6-zhangzhanpeng.jasper@bytedance.com>
References: <20261116071338.35991-6-zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register independently tagged devices after default-domain setup and
retain their IDs in driver-private state across domain changes. Program
all firmware IDs under the context-update lock and report command
completion failures to resctrl.

The DC.ta field size does not describe the implemented QoS ID widths.
Probe the low bits of the global write-any, read-legal fields with DDTP
OFF and all queues disabled and idle. Preserve and verify restoration of
the original register. If the widths cannot be obtained safely, do not
register devices with resctrl. Reject IDs outside the probed range before
changing any device context.

Track exclusive device-context ownership without changing IOMMU core.
Discovering an alias resets and unregisters any previous QoS owner before
marking the context shared. Shared contexts are excluded from independent
QoS assignment until IOMMU reprobe, without failing ordinary DMA probing.
Serialize registration, alias discovery and release so an old owner
cannot become independently assignable again after its context is shared.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 drivers/iommu/riscv/iommu-bits.h |   8 +
 drivers/iommu/riscv/iommu.c      | 269 ++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.h      |  16 ++
 3 files changed, 289 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index f2ef9bd3cde9..9dce98c5239c 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -63,6 +63,7 @@
 #define RISCV_IOMMU_CAPABILITIES_PD8		BIT_ULL(38)
 #define RISCV_IOMMU_CAPABILITIES_PD17		BIT_ULL(39)
 #define RISCV_IOMMU_CAPABILITIES_PD20		BIT_ULL(40)
+#define RISCV_IOMMU_CAPABILITIES_QOSID		BIT_ULL(41)
 #define RISCV_IOMMU_CAPABILITIES_NL		BIT_ULL(42)
 #define RISCV_IOMMU_CAPABILITIES_S		BIT_ULL(43)
 
@@ -274,6 +275,11 @@ enum riscv_iommu_hpmevent_id {
 #define RISCV_IOMMU_TR_RESPONSE_SZ	BIT_ULL(9)
 #define RISCV_IOMMU_TR_RESPONSE_PPN	RISCV_IOMMU_PPN_FIELD
 
+/* IOMMU global QoS IDs (32 bits). */
+#define RISCV_IOMMU_REG_IOMMU_QOSID	0x0270
+#define RISCV_IOMMU_IOMMU_QOSID_RCID	GENMASK(11, 0)
+#define RISCV_IOMMU_IOMMU_QOSID_MCID	GENMASK(27, 16)
+
 /* 5.27 Interrupt cause to vector (64bits) */
 #define RISCV_IOMMU_REG_ICVEC		0x02F8
 #define RISCV_IOMMU_ICVEC_CIV		GENMASK_ULL(3, 0)
@@ -371,6 +377,8 @@ enum riscv_iommu_dc_iohgatp_modes {
 
 /* Translation attributes fields */
 #define RISCV_IOMMU_DC_TA_PSCID		GENMASK_ULL(31, 12)
+#define RISCV_IOMMU_DC_TA_RCID		GENMASK_ULL(51, 40)
+#define RISCV_IOMMU_DC_TA_MCID		GENMASK_ULL(63, 52)
 
 /* First-stage context fields */
 #define RISCV_IOMMU_DC_FSC_PPN		RISCV_IOMMU_ATP_PPN_FIELD
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index fbdca69c436e..dd2ebb25312d 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -22,6 +22,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/resctrl_device.h>
 #include <linux/generic_pt/iommu.h>
 
 #include "../iommu-pages.h"
@@ -472,6 +473,7 @@ static int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
 
 err_busy:
 	/* Report the failure and continue; full RAS recovery is not implemented. */
+	WRITE_ONCE(queue->iommu->qos_cmd_failed, true);
 	dev_err_once(queue->iommu->dev, "Hardware error: command enqueue failed\n");
 	return ret;
 }
@@ -484,13 +486,22 @@ static int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
 static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
 {
 	const struct riscv_iommu_queue *queue = (struct riscv_iommu_queue *)data;
+	unsigned long flags;
 	unsigned int ctrl;
 
 	/* Clear MF/CQ errors, complete error recovery to be implemented. */
+	spin_lock_irqsave(&queue->iommu->cmdq_error_lock, flags);
 	ctrl = riscv_iommu_readl(queue->iommu, queue->qcr);
 	if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
 		    RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FENCE_W_IP)) {
+		if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
+			    RISCV_IOMMU_CQCSR_CMD_ILL))
+			WRITE_ONCE(queue->iommu->qos_cmd_failed, true);
 		riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);
+	}
+	spin_unlock_irqrestore(&queue->iommu->cmdq_error_lock, flags);
+	if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
+		    RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FENCE_W_IP)) {
 		dev_warn(queue->iommu->dev,
 			 "Queue #%u error; fault:%d timeout:%d illegal:%d fence_w_ip:%d\n",
 			 queue->qid,
@@ -851,8 +862,16 @@ PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
 	struct riscv_iommu_domain *domain;
+	/* Retained across domain changes, under the IOMMU's qosid_lock. */
+	struct resctrl_device_ids qos_ids;
 };
 
+static u64 riscv_iommu_qos_ta(struct resctrl_device_ids ids)
+{
+	return FIELD_PREP(RISCV_IOMMU_DC_TA_RCID, ids.closid) |
+	       FIELD_PREP(RISCV_IOMMU_DC_TA_MCID, ids.rmid);
+}
+
 /*
  * Linkage between an iommu_domain and attached devices.
  *
@@ -1191,12 +1210,14 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 				     struct device *dev, u64 fsc, u64 ta)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc *dc;
 	struct riscv_iommu_command cmd;
 	bool sync_required = false;
 	u64 tc;
 	int i;
 
+	mutex_lock(&iommu->qosid_lock);
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
 		tc = READ_ONCE(dc->tc);
@@ -1230,7 +1251,8 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 		tc |= ta & RISCV_IOMMU_DC_TC_V;
 
 		WRITE_ONCE(dc->fsc, fsc);
-		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->ta, (ta & RISCV_IOMMU_PC_TA_PSCID) |
+			   riscv_iommu_qos_ta(info->qos_ids));
 		/* Update device context, write TC.V as the last step. */
 		dma_wmb();
 		WRITE_ONCE(dc->tc, tc);
@@ -1247,6 +1269,7 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 	}
 
 	riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+	mutex_unlock(&iommu->qosid_lock);
 }
 
 /*
@@ -1460,6 +1483,38 @@ static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+/* Shared DIDs stay ineligible for independent QoS until IOMMU reprobe. */
+#define RISCV_IOMMU_SHARED_DC xa_mk_value(1)
+
+static int riscv_iommu_claim_qos_context(struct riscv_iommu_device *iommu,
+					 struct device *dev, u32 did)
+{
+	struct device *owner;
+	int ret = 0;
+
+	lockdep_assert_held(&iommu->qos_registry_lock);
+	mutex_lock(&iommu->qosid_lock);
+	owner = xa_load(&iommu->dc_owners, did);
+	mutex_unlock(&iommu->qosid_lock);
+
+	/*
+	 * Reset and remove the old assignment before an alias can use this DC.
+	 * The registry lock keeps owner and its driver state alive here. Never
+	 * take the resctrl mutex while holding qosid_lock.
+	 */
+	if (owner && owner != dev && !xa_is_value(owner))
+		resctrl_device_unregister(owner);
+
+	mutex_lock(&iommu->qosid_lock);
+	if (!owner)
+		ret = xa_insert(&iommu->dc_owners, did, dev, GFP_KERNEL);
+	else if (owner != dev)
+		ret = xa_err(xa_store(&iommu->dc_owners, did,
+				      RISCV_IOMMU_SHARED_DC, GFP_KERNEL));
+	mutex_unlock(&iommu->qosid_lock);
+	return ret;
+}
+
 static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -1467,7 +1522,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	struct riscv_iommu_info *info;
 	struct riscv_iommu_dc *dc;
 	u64 tc;
-	int i;
+	int i, ret;
 
 	if (!fwspec || !fwspec->iommu_fwnode->dev || !fwspec->num_ids)
 		return ERR_PTR(-ENODEV);
@@ -1486,31 +1541,174 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	info = kzalloc_obj(*info);
 	if (!info)
 		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&iommu->qos_registry_lock);
+	/* Shared contexts disable independent QoS, not ordinary DMA probing. */
+	if (IS_ENABLED(CONFIG_RISCV_CBQRI_RESCTRL_FS) &&
+	    iommu->qos_ids_valid) {
+		for (i = 0; i < fwspec->num_ids; i++) {
+			ret = riscv_iommu_claim_qos_context(iommu, dev,
+							    fwspec->ids[i]);
+			if (ret)
+				goto err_claims;
+		}
+	}
 	/*
 	 * Allocate and pre-configure device context entries in
 	 * the device directory. Do not mark the context valid yet.
 	 */
+	mutex_lock(&iommu->qosid_lock);
 	tc = 0;
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
 		if (!dc) {
-			kfree(info);
-			return ERR_PTR(-ENODEV);
+			ret = -ENODEV;
+			goto err_contexts;
 		}
 		if (READ_ONCE(dc->tc) & RISCV_IOMMU_DC_TC_V)
 			dev_warn(dev, "already attached to IOMMU device directory\n");
 		WRITE_ONCE(dc->tc, tc);
+		WRITE_ONCE(dc->ta, 0);
 	}
+	mutex_unlock(&iommu->qosid_lock);
 
 	dev_iommu_priv_set(dev, info);
+	mutex_unlock(&iommu->qos_registry_lock);
 
 	return &iommu->iommu;
+
+err_contexts:
+	mutex_unlock(&iommu->qosid_lock);
+err_claims:
+	mutex_lock(&iommu->qosid_lock);
+	for (i = 0; i < fwspec->num_ids; i++)
+		if (xa_load(&iommu->dc_owners, fwspec->ids[i]) == dev)
+			xa_erase(&iommu->dc_owners, fwspec->ids[i]);
+	mutex_unlock(&iommu->qosid_lock);
+	mutex_unlock(&iommu->qos_registry_lock);
+	kfree(info);
+	return ERR_PTR(ret);
+}
+
+/* Unlike the legacy void sync helper, QoS must report incomplete updates. */
+static int riscv_iommu_qos_sync(struct riscv_iommu_device *iommu)
+{
+	struct riscv_iommu_command cmd;
+	u32 errors = RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
+		     RISCV_IOMMU_CQCSR_CMD_ILL;
+	unsigned long flags;
+	unsigned int prod;
+	int ret;
+
+	riscv_iommu_cmd_iofence(&cmd);
+	ret = riscv_iommu_queue_send(&iommu->cmdq, &cmd, sizeof(cmd), &prod);
+	if (!ret)
+		ret = riscv_iommu_queue_wait(&iommu->cmdq, prod,
+					     RISCV_IOMMU_QUEUE_TIMEOUT);
+	/* The IRQ must not clear CSR errors between these two checks. */
+	spin_lock_irqsave(&iommu->cmdq_error_lock, flags);
+	if (ret || READ_ONCE(iommu->qos_cmd_failed) ||
+	    (riscv_iommu_readl(iommu, iommu->cmdq.qcr) & errors)) {
+		WRITE_ONCE(iommu->qos_cmd_failed, true);
+		ret = -EIO;
+	}
+	spin_unlock_irqrestore(&iommu->cmdq_error_lock, flags);
+	return ret;
+}
+
+static int riscv_iommu_set_device_ids(struct device *dev,
+				      struct resctrl_device_ids ids)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_command cmd;
+	struct riscv_iommu_dc *dc;
+	u64 mask = RISCV_IOMMU_DC_TA_RCID | RISCV_IOMMU_DC_TA_MCID;
+	int i, ret = 0;
+
+	if (!iommu->qos_ids_valid)
+		return -EOPNOTSUPP;
+	if (ids.closid > iommu->qos_rcid_max ||
+	    ids.rmid > iommu->qos_mcid_max)
+		return -ERANGE;
+
+	mutex_lock(&iommu->qosid_lock);
+	if (READ_ONCE(iommu->qos_cmd_failed)) {
+		ret = -EIO;
+		goto out;
+	}
+	/* Validate the complete device before changing any of its contexts. */
+	for (i = 0; i < fwspec->num_ids; i++) {
+		if (xa_load(&iommu->dc_owners, fwspec->ids[i]) != dev ||
+		    !riscv_iommu_get_dc(iommu, fwspec->ids[i])) {
+			ret = -ENODEV;
+			goto out;
+		}
+	}
+	for (i = 0; i < fwspec->num_ids; i++) {
+		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
+		WRITE_ONCE(dc->ta, (READ_ONCE(dc->ta) & ~mask) |
+			   riscv_iommu_qos_ta(ids));
+		dma_wmb();
+		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
+		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
+		riscv_iommu_cmd_send(iommu, &cmd);
+		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
+	}
+	ret = riscv_iommu_qos_sync(iommu);
+	if (!ret)
+		info->qos_ids = ids;
+out:
+	mutex_unlock(&iommu->qosid_lock);
+	return ret;
+}
+
+static const struct resctrl_device_ops riscv_iommu_resctrl_ops = {
+	.set_ids = riscv_iommu_set_device_ids,
+};
+
+static void riscv_iommu_probe_finalize(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	int i, ret;
+
+	if (!IS_ENABLED(CONFIG_RISCV_CBQRI_RESCTRL_FS) ||
+	    !iommu->qos_ids_valid ||
+	    iommu->ddt_mode <= RISCV_IOMMU_DDTP_IOMMU_MODE_BARE)
+		return;
+
+	mutex_lock(&iommu->qos_registry_lock);
+	for (i = 0; i < fwspec->num_ids; i++) {
+		if (xa_load(&iommu->dc_owners, fwspec->ids[i]) != dev) {
+			dev_dbg(dev, "shared device context; independent QoS unavailable\n");
+			goto out;
+		}
+	}
+	ret = resctrl_device_register(dev, &riscv_iommu_resctrl_ops);
+	if (ret)
+		dev_warn(dev, "resctrl registration failed: %d\n", ret);
+out:
+	mutex_unlock(&iommu->qos_registry_lock);
 }
 
 static void riscv_iommu_release_device(struct device *dev)
 {
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	int i;
 
+	/* Do not take qosid_lock before draining resctrl callbacks. */
+	mutex_lock(&iommu->qos_registry_lock);
+	resctrl_device_unregister(dev);
+	mutex_lock(&iommu->qosid_lock);
+	for (i = 0; i < fwspec->num_ids; i++)
+		if (xa_load(&iommu->dc_owners, fwspec->ids[i]) == dev)
+			xa_erase(&iommu->dc_owners, fwspec->ids[i]);
+	mutex_unlock(&iommu->qosid_lock);
+	mutex_unlock(&iommu->qos_registry_lock);
 	kfree_rcu_mightsleep(info);
 }
 
@@ -1523,9 +1721,62 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
+	.probe_finalize = riscv_iommu_probe_finalize,
 	.release_device	= riscv_iommu_release_device,
 };
 
+/* Probe implemented low bits without changing the other ID or reserved bits. */
+static int riscv_iommu_probe_qosid_field(struct riscv_iommu_device *iommu,
+					 u32 saved, u32 mask)
+{
+	u32 value, limit;
+
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IOMMU_QOSID, saved | mask);
+	value = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IOMMU_QOSID);
+	if ((value & ~mask) != (saved & ~mask))
+		return -EIO;
+	limit = (value & mask) >> __ffs(mask);
+	/* A width mask consists of contiguous low bits; zero permits only ID 0. */
+	if (limit & (limit + 1))
+		return -EINVAL;
+	return limit;
+}
+
+static void riscv_iommu_probe_qosid_limits(struct riscv_iommu_device *iommu)
+{
+	u32 busy = RISCV_IOMMU_QUEUE_ENABLE | RISCV_IOMMU_QUEUE_ACTIVE |
+		   RISCV_IOMMU_QUEUE_BUSY;
+	u32 saved, restored;
+	u64 ddtp;
+	int rcid, mcid;
+
+	/* Never retag live DMA or queue traffic, including firmware handover. */
+	ddtp = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
+	if ((ddtp & (RISCV_IOMMU_DDTP_IOMMU_MODE | RISCV_IOMMU_DDTP_BUSY)) ||
+	    ((riscv_iommu_readl(iommu, RISCV_IOMMU_REG_CQCSR) |
+	      riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FQCSR) |
+	      riscv_iommu_readl(iommu, RISCV_IOMMU_REG_PQCSR)) & busy))
+		goto unavailable;
+
+	saved = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IOMMU_QOSID);
+	rcid = riscv_iommu_probe_qosid_field(iommu, saved,
+					     RISCV_IOMMU_IOMMU_QOSID_RCID);
+	mcid = riscv_iommu_probe_qosid_field(iommu, saved,
+					     RISCV_IOMMU_IOMMU_QOSID_MCID);
+	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IOMMU_QOSID, saved);
+	restored = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_IOMMU_QOSID);
+	if (rcid < 0 || mcid < 0 || restored != saved)
+		goto unavailable;
+
+	iommu->qos_rcid_max = rcid;
+	iommu->qos_mcid_max = mcid;
+	iommu->qos_ids_valid = true;
+	return;
+
+unavailable:
+	dev_warn(iommu->dev, "QoS ID limits unavailable; device QoS disabled\n");
+}
+
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 {
 	u64 ddtp;
@@ -1559,6 +1810,10 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 			return -EINVAL;
 	}
 
+	if (IS_ENABLED(CONFIG_RISCV_CBQRI_RESCTRL_FS) &&
+	    (iommu->caps & RISCV_IOMMU_CAPABILITIES_QOSID))
+		riscv_iommu_probe_qosid_limits(iommu);
+
 	/*
 	 * Distribute interrupt vectors, always use first vector for CIV.
 	 * At least one interrupt is required. Read back and verify.
@@ -1583,6 +1838,7 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
 void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
 	iommu_device_unregister(&iommu->iommu);
+	xa_destroy(&iommu->dc_owners);
 	iommu_device_sysfs_remove(&iommu->iommu);
 	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
 	riscv_iommu_queue_disable(&iommu->cmdq);
@@ -1596,6 +1852,10 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	RISCV_IOMMU_QUEUE_INIT(&iommu->cmdq, CQ);
 	raw_spin_lock_init(&iommu->cmdq.lock);
 	RISCV_IOMMU_QUEUE_INIT(&iommu->fltq, FQ);
+	mutex_init(&iommu->qosid_lock);
+	mutex_init(&iommu->qos_registry_lock);
+	spin_lock_init(&iommu->cmdq_error_lock);
+	xa_init(&iommu->dc_owners);
 
 	rc = riscv_iommu_init_check(iommu);
 	if (rc)
@@ -1657,6 +1917,7 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 err_queue_disable:
 	riscv_iommu_queue_disable(&iommu->fltq);
 	riscv_iommu_queue_disable(&iommu->cmdq);
+	xa_destroy(&iommu->dc_owners);
 	return rc;
 }
 
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 5676001548cc..72bb536190d1 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -15,6 +15,9 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/xarray.h>
 
 #include "iommu-bits.h"
 
@@ -62,6 +65,19 @@ struct riscv_iommu_device {
 	unsigned int ddt_mode;
 	dma_addr_t ddt_phys;
 	u64 *ddt_root;
+
+	/* Serialize resctrl registration against DC sharing and device release. */
+	struct mutex qos_registry_lock;
+	/* Serialize DC updates and track independently owned device IDs. */
+	struct mutex qosid_lock;
+	struct xarray dc_owners;
+	/* Serialize CQ error acknowledgement with QoS completion checks. */
+	spinlock_t cmdq_error_lock;
+	bool qos_cmd_failed;
+	/* Inclusive ID limits, valid only after a quiescent WARL probe. */
+	u16 qos_rcid_max;
+	u16 qos_mcid_max;
+	bool qos_ids_valid;
 };
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
-- 
2.50.1 (Apple Git-155)

