Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D366531E834
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271698; cv=none; b=oS7xRBiqtH/UuvXle/2rUwytk7bfU22Xgplxjc36ywE/+vY0ipPb96gbkRYi57iBeL5tufPHbfP4gvLWbvW4UK1OpCG5p4vfpdYhQjZkL6+VWtbb5YrwWacGUYM5vlYFhS8vN25bc47om/08HZmMX5+tCdJd8nzj0M7jI977iJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271698; c=relaxed/simple;
	bh=EVB+lA5myfzb3tQ/c6BDnSI9Nq3hG2yWIB6cxALQSLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcvDie7NN8ulkuovaeghPNwuVxzIq5BfxPaN8sacKgxM7Z2R+mk6f1h7Nk/m9i9trxBTrzZQKl8P2pv6wrU+Dph3YqDlc8m7jg/2LlWJC7qIckaq31QLYLfxzkvFkyrqpy6Sey1JV00ANY4jsgjhSaYgJzQY4JS1A90N1jOnGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=r3ULZqNc; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="r3ULZqNc"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=06tMOEVizMmDTKQSyYnrlOXakbIpvRYxitn5j9k6NYc=;
	b=r3ULZqNcqsK25YSJzBxVW3TOnImsVtBmH3FEp+L0P0I5hwoqroH3j2Mxq/pA8q7pJ7nl84C6b
	8em6IK/iTRvEHoIrdUJxSdMsQisSbY9gcp9Yyho4kuPCC2hAK526x/DBhzM732vnKGHCv+ERCO7
	Lb+L4ww4Wcs276KyDoIXo8E=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hZ6qc1lz9zmVXs;
	Tue,  1 Sep 2026 21:57:16 +0800 (CST)
Received: from kwepemo500007.china.huawei.com (unknown [7.202.195.114])
	by mail.maildlp.com (Postfix) with ESMTPS id DDB324055B;
	Tue,  1 Sep 2026 22:08:05 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500007.china.huawei.com (7.202.195.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 1 Sep 2026 22:08:04 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <ben.horgan@arm.com>, <zhangzhanpeng.jasper@bytedance.com>,
	<joro@8bytes.org>, <palmer@dabbelt.com>, <tony.luck@intel.com>,
	<reinette.chatre@intel.com>, <tomasz.jeznach@linux.dev>,
	<zengheng4@huawei.com>, <fustini@kernel.org>, <cuiyunhui@bytedance.com>,
	<wangzhou1@hisilicon.com>, <xiaqinxin@huawei.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <pjw@kernel.org>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <Dave.Martin@arm.com>,
	<james.morse@arm.com>, <babu.moger@amd.com>, <corbet@lwn.net>,
	<shuah@kernel.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<yuanzhu@bytedance.com>, <iommu@lists.linux.dev>, <linuxarm@huawei.com>,
	<baolin.wang@linux.alibaba.com>
Subject: [RFC PATCH 2/5] arm_mpam: resctrl: Add arch query for device DMA QoS support
Date: Tue, 1 Sep 2026 22:07:59 +0800
Message-ID: <20260901140802.1215508-3-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260901140802.1215508-1-xiaqinxin@huawei.com>
References: <20260901140802.1215508-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500007.china.huawei.com (7.202.195.114)

Add an architecture query so core resctrl can decide whether to expose the
"devices" file.

The file is only meaningful when an IOMMU can tag the DMA of devices behind
it with a QoS class (such as an MPAM PARTID/PMG), so the query reports
support only on platforms where that is available.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 arch/x86/include/asm/resctrl.h |  5 +++++
 drivers/resctrl/mpam_devices.c | 20 ++++++++++++++++++++
 drivers/resctrl/mpam_resctrl.c |  5 +++++
 include/linux/arm_mpam.h       |  5 +++++
 4 files changed, 35 insertions(+)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 8f6edcdcfd87..744a04f06025 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -71,6 +71,11 @@ static inline bool resctrl_arch_mon_capable(void)
 	return rdt_mon_capable;
 }
 
+static inline bool resctrl_arch_devices_supported(void)
+{
+	return false;
+}
+
 static inline void resctrl_arch_enable_mon(void)
 {
 	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index dd422c56fbb1..882184651c14 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -67,6 +67,26 @@ u8 mpam_pmg_max;
 static bool partid_max_init, partid_max_published;
 static DEFINE_SPINLOCK(partid_max_lock);
 
+/*
+ * Set once an IOMMU (e.g. ARM SMMU v3) has registered that it can tag
+ * device DMA with a PARTID/PMG. resctrl only exposes the "devices" file
+ * when this is true, so unsupported architectures never see it. The flag
+ * only ever flips false -> true and is read with READ_ONCE().
+ */
+static bool mpam_device_requestor_registered;
+
+void mpam_register_device_requestor(void)
+{
+	WRITE_ONCE(mpam_device_requestor_registered, true);
+}
+EXPORT_SYMBOL(mpam_register_device_requestor);
+
+bool mpam_devices_supported(void)
+{
+	return READ_ONCE(mpam_device_requestor_registered);
+}
+EXPORT_SYMBOL(mpam_devices_supported);
+
 /*
  * mpam is enabled once all devices have been probed from CPU online callbacks,
  * scheduled via this work_struct. If access to an MSC depends on a CPU that
diff --git a/drivers/resctrl/mpam_resctrl.c b/drivers/resctrl/mpam_resctrl.c
index 9d223057953a..71ccb3db5987 100644
--- a/drivers/resctrl/mpam_resctrl.c
+++ b/drivers/resctrl/mpam_resctrl.c
@@ -97,6 +97,11 @@ bool resctrl_arch_mon_capable(void)
 	return l3->mon_capable;
 }
 
+bool resctrl_arch_devices_supported(void)
+{
+	return mpam_devices_supported();
+}
+
 bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
 {
 	return false;
diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
index f92a36187a52..9d2deee604ce 100644
--- a/include/linux/arm_mpam.h
+++ b/include/linux/arm_mpam.h
@@ -53,6 +53,11 @@ static inline int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
 bool resctrl_arch_alloc_capable(void);
 bool resctrl_arch_mon_capable(void);
 
+bool resctrl_arch_devices_supported(void);
+
+void mpam_register_device_requestor(void);
+bool mpam_devices_supported(void);
+
 void resctrl_arch_set_cpu_default_closid(int cpu, u32 closid);
 void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid);
 void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 rmid);
-- 
2.33.0

