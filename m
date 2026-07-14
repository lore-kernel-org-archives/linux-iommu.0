Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFC47A0C2
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034509; cv=none; b=jyzYWFf49NMa47AyRlQJpyt7sl/dey1sjE7/iTlW0r25w4WuqrdItx6IVjkOncEDu795bFV8OAAJYBa3hZMU/ARMgMn1bI2APqNlX5hBxESok16ZrzBRcAw4WHurg/SG1bLFNElO5vl5Y6ufAmCVMK+ufesHolcoNjO4/dFqoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034509; c=relaxed/simple;
	bh=88hFgKCg+bUuFow9gcc2rzIqGEA2+sQ8+uzIG1WjY5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAXEVn77P4ZABgcBUinFsvzG2nq3YT2a4+4I9FwhJuwOdeEep2FCRBeFB2bJwss4/hlmBeFmt9tMeEm+utTpHGMiRUVJ6SxNPArA7Fu4DGT5Zq7fQGfp6P44yD9X956aiMbjChaGnmWz4jAei8qw67lJ+hpfQ8DU8GMngoyHE2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gF1dQxha; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gF1dQxha"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb29ed2bbdso1367651a34.2
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784034504; x=1784639304; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0MZi7cORh66e/+tuz0lS/dEufQyLW2u/I7nsyx5ACQE=;
        b=gF1dQxha8PFqypfhhWC7+IQ2/2FGtY5AXjLt24WILbxqCZrpfQtTbzBhB/UHF/v5TG
         /qVozyZUKgfKk2H6hKD2pKJkmhR1Ot0J7fIltT/7l7xJMHGaLxI3f72KEazXEV3Qhmho
         TVctsEPHBvfT4YE+PvbAU1zpEJJBD4WGdMhSCbZRdA0xqeon1UZnDt0psyk05J76fakI
         PjPIxW6guEsb9OcV/mqHVio1kZpaHuvxPB0ekrFZnssMpi82tQAXzfnxqL6EgKSBimdl
         5T9wzZKNmEeB103qH886Ul6OhSKfDBwO3UeGYjr2p50mEB5DcdI4ebuyBbzkafKsyuWP
         HRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034504; x=1784639304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0MZi7cORh66e/+tuz0lS/dEufQyLW2u/I7nsyx5ACQE=;
        b=UZ6vkrS2W7psYhk80FvzA1WUaZKl+u5uUgtY51Yzem0/AKI10+EpbvEPdZFL9Nkisv
         kDTBT0gIOxN7ZdiUGjLgBP65Ib+GaTp3/80OswFNPZopOlmqwfaU5DaXMh2NtW32ZmIZ
         fBngg9pyKe7ryMJ8HZHgpCqsAqf03bOjGyI1MKybQe1CPX6+8ACpAQ8zx2RwCJa6abYg
         AI+H+P5EnT89jaKsazSE55oU0S7hdpmEjlPf2Iy84D0d+5i4Me29mUxuAZWm2RjLdQ3L
         2nMkJDPSel0j66vLTxSgV2Ue+hP3gHa+LQWLcBg+XMZGT1/nn6dwNvaaQnuj1PGRDz3N
         BnJA==
X-Forwarded-Encrypted: i=1; AFNElJ/4rHjk3IT+SGmX9dRe0uElNcvFA8DDhbHTxFrJI/7tMFG8LaUgWOmU5IavZF/N246RLXg0iQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxfmWz9r6OBjEdZrVjEFjg2bWRsloV0JLGfbECUQkpOnpTDjZ4
	XNbC2m+Z7DyV/6fxWGMSVi48MyMLhaIqBgc2XsdF70e49rbPEF6pwzykQwTgLnuIy8o=
X-Gm-Gg: AfdE7clPOKe/lVD9Mi/c/4UEyuyhmUR2oHrWHrXfrEcIFc3YZaC5oo8QgK5PZ3JzWGp
	qaeXjnOhFl1LSFDZ/IRwul1X6smf5/tPzk6rcKO8uc8wnUTXJiwcKjg+cyeCe7ugtc+xErovzCC
	/I1NxpFLP1jzZuVS/109JkYr/Y/xAEZxHM6Lc6KDF9O+QW8V685hCZ4cAReQjOAWK9yH+9Gia9V
	LG2P2230TXLQPD08W3o/Ta0j5fO00ZJSVgG6Cq72J9k1nexi0Bqn1NrN0mEvjvNtsdVmma8KFjx
	f7w0v+na3b0/R9nw7x7z0pJaNoyyDIkVLeoi7H0C2OPVAi4Hefrv+/TZgya3xPWMpJvrkR7fxgo
	tp7DrpY8RoC8CB95hIOlJIWj/Tl5kF0pw3c4HZgb5ljlaNX3LqpfGPsh69FLeMBotXPysXAGqMj
	Uug0THqFLYQy3yP3ci1bfL+rEhT8AztElTVit0EInI6ZxxYICrVs3WRPwOxWvM6Nec6Zo1Cxv5
X-Received: by 2002:a05:6830:3817:b0:7e1:cbe3:bb1b with SMTP id 46e09a7af769-7ec4a5cda29mr1176418a34.0.1784034503802;
        Tue, 14 Jul 2026 06:08:23 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcab8efc3sm14657738a34.0.2026.07.14.06.08.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 06:08:23 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: joro@8bytes.org,
	palmer@dabbelt.com,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	tomasz.jeznach@linux.dev
Cc: will@kernel.org,
	robin.murphy@arm.com,
	fustini@kernel.org,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	corbet@lwn.net,
	shuah@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH 6/7] riscv_cbqri: Assign IOMMU groups to resource groups
Date: Tue, 14 Jul 2026 21:06:56 +0800
Message-ID: <20260714130657.46963-7-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the resctrl devices file to accept iommu_group:<id> tokens on
RISC-V and map the target resource group's closid and rmid values to
RCID and MCID.

Record non-default assignments in an RCU-protected binding list rather
than inferring membership from hardware IDs, which may be shared. Keep a
parent reference obtained by numeric group lookup so the binding does not
keep an empty group's devices kobject active, and prune bindings after
their group becomes inactive.

Publish an explicit UPDATING state while hardware changes. Paging-domain
attachment rejects that transient state. Static FSC=Bare transitions
preserve the current IDs so a mandatory release-domain attachment cannot
fail. After the checked group update succeeds, publish the packed IDs. A
validation failure restores the previous active state without partially
changing hardware.

Moving an IOMMU group to the default resource group resets its hardware
state and removes the software binding. Device contexts created later for
an assigned group inherit the IDs through the RCU lookup path.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 MAINTAINERS                   |   1 +
 arch/riscv/include/asm/qos.h  |  12 ++
 drivers/iommu/riscv/iommu.c   |  70 +++++++--
 drivers/iommu/riscv/iommu.h   |  16 +-
 drivers/resctrl/Kconfig       |   6 +
 drivers/resctrl/Makefile      |   1 +
 drivers/resctrl/cbqri_iommu.c | 276 ++++++++++++++++++++++++++++++++++
 7 files changed, 369 insertions(+), 13 deletions(-)
 create mode 100644 drivers/resctrl/cbqri_iommu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c59be02c8f02..162ad5a1780f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23288,6 +23288,7 @@ L:	iommu@lists.linux.dev
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-iommu-riscv-iommu
+F:	drivers/resctrl/cbqri_iommu.c
 
 RISC-V MICROCHIP SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
index daa758d4efff..84a93739c6ff 100644
--- a/arch/riscv/include/asm/qos.h
+++ b/arch/riscv/include/asm/qos.h
@@ -8,6 +8,18 @@
 
 struct iommu_group;
 
+#ifdef CONFIG_RISCV_CBQRI_IOMMU
+int riscv_resctrl_iommu_group_get_qosid(struct iommu_group *group,
+					u32 *rcid, u32 *mcid);
+#else
+static inline int
+riscv_resctrl_iommu_group_get_qosid(struct iommu_group *group, u32 *rcid,
+				    u32 *mcid)
+{
+	return -ENOENT;
+}
+#endif
+
 #ifdef CONFIG_RISCV_IOMMU
 int riscv_iommu_group_set_qosid(struct iommu_group *group, u32 rcid,
 				u32 mcid);
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e85da9eef58e..1a7d8a582959 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1188,16 +1188,50 @@ static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
  * device is not quiesced might be disruptive, potentially causing
  * interim translation faults.
  */
-static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, u64 fsc, u64 ta)
+static int riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
+				    struct device *dev, u64 fsc, u64 ta)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
 	struct riscv_iommu_command cmd;
 	bool sync_required = false;
+	u64 group_qos_ta = 0;
+	bool has_group_qos;
+	u32 group_rcid;
+	u32 group_mcid;
 	u64 tc;
+	int ret = 0;
+	int qos_ret;
 	int i;
 
+	/* Serialize DC.ta updates with resctrl IOMMU group QoS changes. */
+	mutex_lock(&iommu->qosid_lock);
+
+	qos_ret = riscv_resctrl_iommu_group_get_qosid(dev->iommu_group,
+						      &group_rcid, &group_mcid);
+	if (qos_ret == -EAGAIN) {
+		/* Static domain transitions must not fail during device release. */
+		if (fsc != RISCV_IOMMU_FSC_BARE) {
+			ret = -EBUSY;
+			goto unlock;
+		}
+		qos_ret = -ENOENT;
+	}
+	has_group_qos = !qos_ret;
+	if (has_group_qos) {
+		if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_QOSID) ||
+		    iommu->ddt_mode <= RISCV_IOMMU_DDTP_IOMMU_MODE_BARE) {
+			ret = -EOPNOTSUPP;
+			goto unlock;
+		}
+		if (group_rcid > FIELD_MAX(RISCV_IOMMU_DC_TA_RCID) ||
+		    group_mcid > FIELD_MAX(RISCV_IOMMU_DC_TA_MCID)) {
+			ret = -ERANGE;
+			goto unlock;
+		}
+		group_qos_ta = riscv_iommu_qosid_ta(group_rcid, group_mcid);
+	}
+
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
 		tc = READ_ONCE(dc->tc);
@@ -1233,11 +1267,12 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 		tc = READ_ONCE(dc->tc);
 		dc_ta = ta;
 		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_QOSID) {
-			dc_ta |= READ_ONCE(dc->ta) &
-				 (RISCV_IOMMU_DC_TA_RCID |
-				  RISCV_IOMMU_DC_TA_MCID);
-			ta_mask |= RISCV_IOMMU_DC_TA_RCID |
-				   RISCV_IOMMU_DC_TA_MCID;
+			if (has_group_qos)
+				dc_ta |= group_qos_ta;
+			else
+				dc_ta |= READ_ONCE(dc->ta) &
+					 RISCV_IOMMU_DC_TA_QOSID;
+			ta_mask |= RISCV_IOMMU_DC_TA_QOSID;
 		}
 		tc |= dc_ta & RISCV_IOMMU_DC_TC_V;
 
@@ -1259,6 +1294,9 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 	}
 
 	riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+unlock:
+	mutex_unlock(&iommu->qosid_lock);
+	return ret;
 }
 
 /*
@@ -1324,6 +1362,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct pt_iommu_riscv_64_hw_info pt_info;
 	u64 fsc, ta;
+	int ret;
 
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
 
@@ -1338,7 +1377,11 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	if (riscv_iommu_bond_link(domain, dev))
 		return -ENOMEM;
 
-	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
+	ret = riscv_iommu_iodir_update(iommu, dev, fsc, ta);
+	if (ret) {
+		riscv_iommu_bond_unlink(domain, dev);
+		return ret;
+	}
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 
@@ -1413,9 +1456,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	int ret;
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
+	ret = riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
+	if (ret)
+		return ret;
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
@@ -1435,8 +1481,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	u64 ta = RISCV_IOMMU_PC_TA_V;
+	int ret;
 
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
+	ret = riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, ta);
+	if (ret)
+		return ret;
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 13ea67b7e42d..e7804ec65647 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -11,13 +11,11 @@
 #ifndef _RISCV_IOMMU_H_
 #define _RISCV_IOMMU_H_
 
+#include <linux/errno.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
-#ifdef CONFIG_RISCV_IOMMU_32BIT
-#include <linux/spinlock.h>
-#endif
 
 #include "iommu-bits.h"
 
@@ -26,6 +24,18 @@ struct riscv_iommu_device;
 int riscv_iommu_group_set_qosid(struct iommu_group *group, u32 rcid,
 				u32 mcid);
 
+#ifdef CONFIG_RISCV_CBQRI_IOMMU
+int riscv_resctrl_iommu_group_get_qosid(struct iommu_group *group,
+					u32 *rcid, u32 *mcid);
+#else
+static inline int
+riscv_resctrl_iommu_group_get_qosid(struct iommu_group *group, u32 *rcid,
+				    u32 *mcid)
+{
+	return -ENOENT;
+}
+#endif
+
 struct riscv_iommu_queue {
 	atomic_t prod;				/* unbounded producer allocation index */
 	atomic_t head;				/* unbounded shadow ring buffer consumer index */
diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
index b7db6ff9d054..4e10c813e647 100644
--- a/drivers/resctrl/Kconfig
+++ b/drivers/resctrl/Kconfig
@@ -60,3 +60,9 @@ endif
 config RISCV_CBQRI_RESCTRL_FS
 	bool
 	default y if RISCV_CBQRI && RESCTRL_FS
+
+config RISCV_CBQRI_IOMMU
+	bool
+	depends on RISCV_CBQRI_RESCTRL_FS && RISCV_IOMMU
+	select ARCH_HAS_RESCTRL_DEVICES
+	default y
diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
index c8339113ef1f..148b2e28c6a3 100644
--- a/drivers/resctrl/Makefile
+++ b/drivers/resctrl/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_RISCV_CBQRI)			+= cbqri.o
 cbqri-y						+= cbqri_devices.o
 cbqri-$(CONFIG_RISCV_CBQRI_RESCTRL_FS)		+= cbqri_resctrl.o
 cbqri-$(CONFIG_RISCV_CBQRI_CAPACITY)		+= cbqri_capacity.o
+cbqri-$(CONFIG_RISCV_CBQRI_IOMMU)			+= cbqri_iommu.o
diff --git a/drivers/resctrl/cbqri_iommu.c b/drivers/resctrl/cbqri_iommu.c
new file mode 100644
index 000000000000..4086c32546bd
--- /dev/null
+++ b/drivers/resctrl/cbqri_iommu.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/capability.h>
+#include <linux/errno.h>
+#include <linux/iommu.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/rcupdate.h>
+#include <linux/resctrl.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <asm/qos.h>
+
+#define IOMMU_GROUP_TOKEN	"iommu_group:"
+
+/*
+ * RISC-V IOMMU RCID and MCID fields are 12 bits each, so an active binding
+ * cannot contain U64_MAX.
+ */
+#define QOS_IOMMU_BINDING_UPDATING	U64_MAX
+
+/* Records the resctrl QoS ID assignment for one IOMMU group. */
+struct qos_iommu_group_binding {
+	struct list_head node;
+	struct rcu_head rcu;
+	struct iommu_group *group;
+	int group_id;
+	/* Packed IDs, or QOS_IOMMU_BINDING_UPDATING during a hardware update. */
+	u64 state;
+};
+
+/*
+ * resctrl owns IOMMU group membership bookkeeping. Do not infer membership by
+ * reading RCID/MCID back from hardware: the same IDs may be shared by multiple
+ * resctrl users. Writers are serialized by rdtgroup_mutex. IOMMU attach paths
+ * read the list under RCU so newly attached devices can inherit an existing
+ * group assignment without taking locks in the opposite order to resctrl.
+ */
+static LIST_HEAD(qos_iommu_bindings);
+
+static u64 qos_iommu_group_ids_pack(struct resctrl_group_ids ids)
+{
+	return (u64)ids.closid << 32 | ids.rmid;
+}
+
+static struct resctrl_group_ids qos_iommu_group_ids_unpack(u64 ids)
+{
+	return (struct resctrl_group_ids) {
+		.closid = upper_32_bits(ids),
+		.rmid = lower_32_bits(ids),
+	};
+}
+
+static bool qos_iommu_group_ids_match(u64 packed, struct resctrl_group_ids ids)
+{
+	return packed != QOS_IOMMU_BINDING_UPDATING &&
+	       packed == qos_iommu_group_ids_pack(ids);
+}
+
+static bool qos_iommu_group_ids_default(struct resctrl_group_ids ids)
+{
+	return ids.closid == RESCTRL_RESERVED_CLOSID &&
+	       ids.rmid == RESCTRL_RESERVED_RMID;
+}
+
+static struct qos_iommu_group_binding *
+qos_iommu_group_find_binding(int group_id)
+{
+	struct qos_iommu_group_binding *binding;
+
+	list_for_each_entry(binding, &qos_iommu_bindings, node) {
+		if (binding->group_id == group_id)
+			return binding;
+	}
+
+	return NULL;
+}
+
+static void qos_iommu_group_free_binding(struct qos_iommu_group_binding *binding)
+{
+	list_del_rcu(&binding->node);
+	iommu_group_put_by_id(binding->group);
+	kfree_rcu(binding, rcu);
+}
+
+static void qos_iommu_group_prune_inactive(void)
+{
+	struct qos_iommu_group_binding *binding;
+	struct qos_iommu_group_binding *tmp;
+
+	list_for_each_entry_safe(binding, tmp, &qos_iommu_bindings, node) {
+		if (!iommu_group_is_active(binding->group))
+			qos_iommu_group_free_binding(binding);
+	}
+}
+
+static int qos_iommu_group_set(struct iommu_group *group,
+			       struct resctrl_group_ids ids)
+{
+	/* RISC-V IOMMU QoS maps closid->rcid and rmid->mcid 1:1. */
+	return riscv_iommu_group_set_qosid(group, ids.closid, ids.rmid);
+}
+
+int resctrl_arch_devices_write(char *tok, struct resctrl_group_ids ids)
+{
+	struct qos_iommu_group_binding *binding;
+	struct qos_iommu_group_binding *new_binding = NULL;
+	struct iommu_group *group;
+	u64 old_state = QOS_IOMMU_BINDING_UPDATING;
+	bool default_ids;
+	int group_id;
+	int ret;
+
+	if (strncmp(tok, IOMMU_GROUP_TOKEN, strlen(IOMMU_GROUP_TOKEN))) {
+		resctrl_last_cmd_printf("Unsupported device token %s\n", tok);
+		return -EOPNOTSUPP;
+	}
+
+	tok += strlen(IOMMU_GROUP_TOKEN);
+	if (kstrtoint(tok, 10, &group_id) || group_id < 0) {
+		resctrl_last_cmd_printf("IOMMU group parsing error %s%s\n",
+					IOMMU_GROUP_TOKEN, tok);
+		return -EINVAL;
+	}
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		resctrl_last_cmd_puts("No permission to move IOMMU group\n");
+		return -EPERM;
+	}
+
+	default_ids = qos_iommu_group_ids_default(ids);
+	qos_iommu_group_prune_inactive();
+	binding = qos_iommu_group_find_binding(group_id);
+	if (!binding) {
+		group = iommu_group_get_by_id(group_id);
+		if (!group) {
+			resctrl_last_cmd_printf("No IOMMU group %d\n", group_id);
+			return -ENOENT;
+		}
+
+		if (default_ids) {
+			ret = qos_iommu_group_set(group, ids);
+			iommu_group_put_by_id(group);
+			if (ret)
+				resctrl_last_cmd_printf("Failed to reset IOMMU group %d QoS (%d)\n",
+							group_id, ret);
+			return ret;
+		}
+
+		new_binding = kzalloc_obj(*new_binding, GFP_KERNEL);
+		if (!new_binding) {
+			iommu_group_put_by_id(group);
+			resctrl_last_cmd_puts("Unable to allocate IOMMU group QoS binding\n");
+			return -ENOMEM;
+		}
+		binding = new_binding;
+		binding->group = group;
+		binding->group_id = group_id;
+		binding->state = QOS_IOMMU_BINDING_UPDATING;
+		list_add_tail_rcu(&binding->node, &qos_iommu_bindings);
+	} else {
+		group = binding->group;
+		old_state = READ_ONCE(binding->state);
+		WRITE_ONCE(binding->state, QOS_IOMMU_BINDING_UPDATING);
+	}
+
+	ret = qos_iommu_group_set(group, ids);
+	if (ret) {
+		if (new_binding)
+			qos_iommu_group_free_binding(binding);
+		else
+			WRITE_ONCE(binding->state, old_state);
+		resctrl_last_cmd_printf("Failed to move IOMMU group %d QoS (%d)\n",
+					group_id, ret);
+		return ret;
+	}
+
+	if (default_ids)
+		qos_iommu_group_free_binding(binding);
+	else
+		WRITE_ONCE(binding->state, qos_iommu_group_ids_pack(ids));
+
+	return 0;
+}
+
+int riscv_resctrl_iommu_group_get_qosid(struct iommu_group *group, u32 *rcid,
+					u32 *mcid)
+{
+	struct qos_iommu_group_binding *binding;
+	int ret = -ENOENT;
+
+	if (!group)
+		return -ENODEV;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(binding, &qos_iommu_bindings, node) {
+		struct resctrl_group_ids ids;
+		u64 state;
+
+		if (binding->group != group)
+			continue;
+		state = READ_ONCE(binding->state);
+		if (state == QOS_IOMMU_BINDING_UPDATING) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		ids = qos_iommu_group_ids_unpack(state);
+		if (rcid)
+			*rcid = ids.closid;
+		if (mcid)
+			*mcid = ids.rmid;
+		ret = 0;
+		break;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+void resctrl_arch_devices_show(struct seq_file *s, struct resctrl_group_ids ids)
+{
+	struct qos_iommu_group_binding *binding;
+
+	qos_iommu_group_prune_inactive();
+	list_for_each_entry(binding, &qos_iommu_bindings, node) {
+		if (qos_iommu_group_ids_match(READ_ONCE(binding->state), ids))
+			seq_printf(s, "iommu_group:%d\n", binding->group_id);
+	}
+}
+
+bool resctrl_arch_devices_assigned(struct resctrl_group_ids ids)
+{
+	struct qos_iommu_group_binding *binding;
+
+	qos_iommu_group_prune_inactive();
+	list_for_each_entry(binding, &qos_iommu_bindings, node) {
+		if (qos_iommu_group_ids_match(READ_ONCE(binding->state), ids))
+			return true;
+	}
+
+	return false;
+}
+
+int resctrl_arch_devices_reset_all(struct resctrl_group_ids default_ids)
+{
+	struct qos_iommu_group_binding *binding;
+	struct qos_iommu_group_binding *tmp;
+	u64 old_state;
+	int first_ret = 0;
+	int ret;
+
+	qos_iommu_group_prune_inactive();
+	list_for_each_entry_safe(binding, tmp, &qos_iommu_bindings, node) {
+		old_state = READ_ONCE(binding->state);
+		WRITE_ONCE(binding->state, QOS_IOMMU_BINDING_UPDATING);
+		ret = qos_iommu_group_set(binding->group, default_ids);
+		if (ret) {
+			WRITE_ONCE(binding->state, old_state);
+			if (!first_ret)
+				first_ret = ret;
+			resctrl_last_cmd_printf("Failed to reset IOMMU group %d QoS (%d)\n",
+						binding->group_id, ret);
+			continue;
+		}
+
+		qos_iommu_group_free_binding(binding);
+	}
+
+	return first_ret;
+}
-- 
2.50.1 (Apple Git-155)

