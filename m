Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6988D8BF4
	for <iommu@lists.linux.dev>; Wed, 18 Jan 2023 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674075032; x=1705611032;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qcZT/7ts8Z1Nd0zZr5T1O31AnNqRthUIEcQh9UoSLFk=;
  b=CP069+B1EA4nJPgFciSZ/ByHCle+jsgxWrYsesT/+uvTdPnZUnVL3egq
   xTQCtZWCf9wgZanq+c/M/52b8W/UAdJdWpv5qVQllID9/3xRrXZcam807
   oTpmrrSo23CCUw+iBv0PINfavY1BsEaI0visMXRmlXe6cTDLPQHqfzoR5
   +9Ogg29pY5ohukfzuDsoftlHpLHiSQySu3KKIaClWaxTb+BWy6BYjJ4da
   HXvIfzlEsdNT2mVODAnJ4SAzgunDkX8vSyuWCkzz34DnpDv5IUlye+gjm
   7mlrEm9TFPi2G2bDy7J5HAxbY6jyG1TzYMykGzg84EZFPljnWTUme+NCV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="323784148"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="323784148"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 12:50:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="833739580"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="833739580"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2023 12:50:27 -0800
From: kan.liang@linux.intel.com
To: joro@8bytes.org,
	will@kernel.org,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	robin.murphy@arm.com,
	robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 5/7] iommu/vt-d: Support cpumask for IOMMU perfmon
Date: Wed, 18 Jan 2023 12:50:04 -0800
Message-Id: <20230118205006.3182907-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118205006.3182907-1-kan.liang@linux.intel.com>
References: <20230118205006.3182907-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The perf subsystem assumes that all counters are by default per-CPU. So
the user space tool reads a counter from each CPU. However, the IOMMU
counters are system-wide and can be read from any CPU. Here we use a CPU
mask to restrict counting to one CPU to handle the issue. (with CPU
hotplug notifier to choose a different CPU if the chosen one is taken
off-line).

The CPU is exposed to /sys/bus/event_source/devices/dmar*/cpumask for
the user space perf tool.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 .../sysfs-bus-event_source-devices-iommu      |   8 ++
 drivers/iommu/intel/perfmon.c                 | 115 ++++++++++++++++--
 include/linux/cpuhotplug.h                    |   1 +
 3 files changed, 116 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
index 04e08851d8e6..3519954fe713 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
@@ -22,3 +22,11 @@ Description:	Read-only.  Attribute group to describe the magic bits
 		    filter_pasid	= "config1:32-53" - PASID filter
 		    filter_ats		= "config2:0-4"   - Address Type filter
 		    filter_page_table	= "config2:8-12"  - Page Table Level filter
+
+What:		/sys/bus/event_source/devices/dmar*/cpumask
+Date:		Jan 2023
+KernelVersion:	6.3
+Contact:	Kan Liang <kan.liang@linux.intel.com>
+Description:	Read-only.  This file always returns the CPU to which the
+		IOMMU pmu is bound for access to all IOMMU pmu
+		performance monitoring events.
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index 06e95b9b88d5..ed06bf121b50 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -32,9 +32,30 @@ static struct attribute_group iommu_pmu_events_attr_group = {
 	.attrs = attrs_empty,
 };
 
+static cpumask_t iommu_pmu_cpu_mask;
+
+static ssize_t iommu_pmu_cpumask_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &iommu_pmu_cpu_mask);
+}
+
+static DEVICE_ATTR(cpumask, S_IRUGO, iommu_pmu_cpumask_show, NULL);
+
+static struct attribute *iommu_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static struct attribute_group iommu_pmu_cpumask_attr_group = {
+	.attrs = iommu_pmu_cpumask_attrs,
+};
+
 static const struct attribute_group *iommu_pmu_attr_groups[] = {
 	&iommu_pmu_format_attr_group,
 	&iommu_pmu_events_attr_group,
+	&iommu_pmu_cpumask_attr_group,
 	NULL
 };
 
@@ -660,20 +681,98 @@ void free_iommu_pmu(struct intel_iommu *iommu)
 	iommu->pmu = NULL;
 }
 
+static int iommu_pmu_cpu_online(unsigned int cpu)
+{
+	if (cpumask_empty(&iommu_pmu_cpu_mask))
+		cpumask_set_cpu(cpu, &iommu_pmu_cpu_mask);
+
+	return 0;
+}
+
+static int iommu_pmu_cpu_offline(unsigned int cpu)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &iommu_pmu_cpu_mask))
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+
+	if (target < nr_cpu_ids)
+		cpumask_set_cpu(target, &iommu_pmu_cpu_mask);
+	else
+		target = -1;
+
+	rcu_read_lock();
+
+	for_each_iommu(iommu, drhd) {
+		if (!iommu->pmu)
+			continue;
+		perf_pmu_migrate_context(&iommu->pmu->pmu, cpu, target);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int nr_iommu_pmu;
+
+static int iommu_pmu_cpuhp_setup(struct iommu_pmu *iommu_pmu)
+{
+	int ret;
+
+	if (nr_iommu_pmu++)
+		return 0;
+
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE,
+				"driver/iommu/intel/perfmon:online",
+				iommu_pmu_cpu_online,
+				iommu_pmu_cpu_offline);
+	if (ret)
+		nr_iommu_pmu = 0;
+
+	return ret;
+}
+
+static void iommu_pmu_cpuhp_free(struct iommu_pmu *iommu_pmu)
+{
+	if (--nr_iommu_pmu)
+		return;
+
+	cpuhp_remove_state(CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE);
+}
+
 void iommu_pmu_register(struct intel_iommu *iommu)
 {
-	if (!iommu->pmu)
+	struct iommu_pmu *iommu_pmu = iommu->pmu;
+
+	if (!iommu_pmu)
 		return;
 
-	if (__iommu_pmu_register(iommu)) {
-		pr_err("Failed to register PMU for iommu (seq_id = %d)\n",
-		       iommu->seq_id);
-		free_iommu_pmu(iommu);
-	}
+	if (__iommu_pmu_register(iommu))
+		goto err;
+
+	if (iommu_pmu_cpuhp_setup(iommu_pmu))
+		goto unregister;
+
+	return;
+
+unregister:
+	perf_pmu_unregister(&iommu_pmu->pmu);
+err:
+	pr_err("Failed to register PMU for iommu (seq_id = %d)\n", iommu->seq_id);
+	free_iommu_pmu(iommu);
 }
 
 void iommu_pmu_unregister(struct intel_iommu *iommu)
 {
-	if (iommu->pmu)
-		perf_pmu_unregister(&iommu->pmu->pmu);
+	struct iommu_pmu *iommu_pmu = iommu->pmu;
+
+	if (!iommu_pmu)
+		return;
+
+	iommu_pmu_cpuhp_free(iommu_pmu);
+	perf_pmu_unregister(&iommu_pmu->pmu);
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 6c6859bfc454..f2ea348ce3b0 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -221,6 +221,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_CQM_ONLINE,
 	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
 	CPUHP_AP_PERF_X86_IDXD_ONLINE,
+	CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
-- 
2.35.1

