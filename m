Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3592808
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151172; x=1706687172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bRhbLbcdzD3YZbuz7wKC51Hdu2i1rzT4Orz0g+avwrI=;
  b=FUgkFeWV1ENe7UGadNZxO5MscAlxVfI1XpRYL4IEbna2svdl6wHGC1ZZ
   w6in84yMuuToa8p5LaxtM9rJLPWb8eEDVSNSGxVW0gJjQahcMA+UqkLBc
   PkGEhqt/IAaXNM/foavz8CSHrqZ1mBU058lhpR/20577o32XuSe3lffS6
   alXQCguGV1GyEq2RUbnfQuYoB1Kqe8NPFNTnxVnA6dW0edZJVdkye4I8T
   rIjRkN3D50jmYvb+J7JfmSf3P/NLbujYA1vYgMZkvsWg7xs4bnbYeJwmM
   q/rQE37HSslwKWxhtkaNqCg2xe0L61u+Red/ucwT33S1nasKWiYueNx6d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736640"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736640"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:46:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775576"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775576"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:46:07 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: kan.liang@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] iommu/vt-d: Support cpumask for IOMMU perfmon
Date: Tue, 31 Jan 2023 15:37:38 +0800
Message-Id: <20230131073740.378984-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131073740.378984-1-baolu.lu@linux.intel.com>
References: <20230131073740.378984-1-baolu.lu@linux.intel.com>
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
Link: https://lore.kernel.org/r/20230128200428.1459118-6-kan.liang@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/cpuhotplug.h                    |   1 +
 drivers/iommu/intel/perfmon.c                 | 113 ++++++++++++++++--
 .../sysfs-bus-event_source-devices-iommu      |   8 ++
 3 files changed, 114 insertions(+), 8 deletions(-)

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
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index df9b78736462..322d362b85e4 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -34,9 +34,28 @@ static struct attribute_group iommu_pmu_events_attr_group = {
 	.attrs = attrs_empty,
 };
 
+static cpumask_t iommu_pmu_cpu_mask;
+
+static ssize_t
+cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &iommu_pmu_cpu_mask);
+}
+static DEVICE_ATTR_RO(cpumask);
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
 
@@ -679,20 +698,98 @@ void free_iommu_pmu(struct intel_iommu *iommu)
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
diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
index 988210a0e8ce..d7af4919302e 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
@@ -27,3 +27,11 @@ Description:	Read-only.  Attribute group to describe the magic bits
 		    filter_pasid	= "config2:0-21"  - PASID filter
 		    filter_ats		= "config2:24-28" - Address Type filter
 		    filter_page_table	= "config2:32-36" - Page Table Level filter
+
+What:		/sys/bus/event_source/devices/dmar*/cpumask
+Date:		Jan 2023
+KernelVersion:	6.3
+Contact:	Kan Liang <kan.liang@linux.intel.com>
+Description:	Read-only. This file always returns the CPU to which the
+		IOMMU pmu is bound for access to all IOMMU pmu performance
+		monitoring events.
-- 
2.34.1

