Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C11E507
	for <iommu@lists.linux.dev>; Fri,  2 Aug 2024 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611761; cv=none; b=NXbDtOYGOO1eyx4hjQdtttxIKmgijs6drZWDKoUV5tpkzw5IP8WpApEBTym3uZQChdhn7zvuL/W6+XcwylcXdIzwWQpyPZQJkbHHBmaqYqEOLDCxvyYTUyLCPn7AQ3ran+55ob+XFnG63UvmKpI1y5gHPDwdQWtdEIKa9A9oBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611761; c=relaxed/simple;
	bh=X/DZHGNEnpppzw6W66fG/5qG6ja3qRNvChuXNJE/48w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TyIiSRYkKfJGdGkLzRFQ4NbieKx5VwTc2oikJGlNEBgDU6cVg3xykUGXY0tNaU2eLJB42jlbqCtQo/XSxOxa9yGyQCZFZVcVYo1Xs6MYwF+etTS1gTgZFT950WYB/z5KswYmJroPRnT+13I+KggWt2NhFDAGXkSNnAHPII6czCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8Meo/1B; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8Meo/1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722611761; x=1754147761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X/DZHGNEnpppzw6W66fG/5qG6ja3qRNvChuXNJE/48w=;
  b=d8Meo/1Bb6fby4rI4TgP0/qYqWwhhs4NWLcXuBpaSizClweXuQewoB61
   YzFlhj7m1DiWF9Zf61Tb7Fa2rRtd0JkwXjeGFjN766SWOkPu2rzWmuD0g
   J9lfXHp2EdZnuK+jzzLbFkdk6D/vdRdw03lw9SU/DFBuM6e+nACg8I8MR
   x2Ab1pvudRJX9AEEqrFODy82powrdKMsOi0bmMz3GWnr0ki1ahPvQkGIT
   WqQFNRa/Op/9eic8K1ePt03oJERtMFdxv+CClQS/5iCrBNGR7kQeJjAsG
   yXca6h1hEel4SxT2LBSTGO+44JybhhF03FoJsegfH5QcF9QOUm560oZnF
   g==;
X-CSE-ConnectionGUID: aalzzy6GSt+e9wDfZxfmUQ==
X-CSE-MsgGUID: o+fSF9UrTkaJL94phDvdsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20473776"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20473776"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:16:00 -0700
X-CSE-ConnectionGUID: m3YEcdw7RruD1VS/A3Y19g==
X-CSE-MsgGUID: f2Ic8290SdynwlOlesaHDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55516934"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 02 Aug 2024 08:15:59 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev
Subject: [PATCH 4/7] iommu/vt-d: Clean up cpumask and hotplug for perfmon
Date: Fri,  2 Aug 2024 08:16:40 -0700
Message-Id: <20240802151643.1691631-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240802151643.1691631-1-kan.liang@linux.intel.com>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The iommu PMU is system-wide scope, which is supported by the generic
perf_event subsystem now.

Set the scope for the iommu PMU and remove all the cpumask and hotplug
codes.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev
---
 drivers/iommu/intel/iommu.h   |   2 -
 drivers/iommu/intel/perfmon.c | 111 +---------------------------------
 2 files changed, 2 insertions(+), 111 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b67c14da1240..bd2c5a4ca11a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -687,8 +687,6 @@ struct iommu_pmu {
 	DECLARE_BITMAP(used_mask, IOMMU_PMU_IDX_MAX);
 	struct perf_event	*event_list[IOMMU_PMU_IDX_MAX];
 	unsigned char		irq_name[16];
-	struct hlist_node	cpuhp_node;
-	int			cpu;
 };
 
 #define IOMMU_IRQ_ID_OFFSET_PRQ		(DMAR_UNITS_SUPPORTED)
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index 44083d01852d..75f493bcb353 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -34,28 +34,9 @@ static struct attribute_group iommu_pmu_events_attr_group = {
 	.attrs = attrs_empty,
 };
 
-static cpumask_t iommu_pmu_cpu_mask;
-
-static ssize_t
-cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	return cpumap_print_to_pagebuf(true, buf, &iommu_pmu_cpu_mask);
-}
-static DEVICE_ATTR_RO(cpumask);
-
-static struct attribute *iommu_pmu_cpumask_attrs[] = {
-	&dev_attr_cpumask.attr,
-	NULL
-};
-
-static struct attribute_group iommu_pmu_cpumask_attr_group = {
-	.attrs = iommu_pmu_cpumask_attrs,
-};
-
 static const struct attribute_group *iommu_pmu_attr_groups[] = {
 	&iommu_pmu_format_attr_group,
 	&iommu_pmu_events_attr_group,
-	&iommu_pmu_cpumask_attr_group,
 	NULL
 };
 
@@ -565,6 +546,7 @@ static int __iommu_pmu_register(struct intel_iommu *iommu)
 	iommu_pmu->pmu.attr_groups	= iommu_pmu_attr_groups;
 	iommu_pmu->pmu.attr_update	= iommu_pmu_attr_update;
 	iommu_pmu->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+	iommu_pmu->pmu.scope		= PERF_PMU_SCOPE_SYS_WIDE;
 	iommu_pmu->pmu.module		= THIS_MODULE;
 
 	return perf_pmu_register(&iommu_pmu->pmu, iommu_pmu->pmu.name, -1);
@@ -773,89 +755,6 @@ static void iommu_pmu_unset_interrupt(struct intel_iommu *iommu)
 	iommu->perf_irq = 0;
 }
 
-static int iommu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
-{
-	struct iommu_pmu *iommu_pmu = hlist_entry_safe(node, typeof(*iommu_pmu), cpuhp_node);
-
-	if (cpumask_empty(&iommu_pmu_cpu_mask))
-		cpumask_set_cpu(cpu, &iommu_pmu_cpu_mask);
-
-	if (cpumask_test_cpu(cpu, &iommu_pmu_cpu_mask))
-		iommu_pmu->cpu = cpu;
-
-	return 0;
-}
-
-static int iommu_pmu_cpu_offline(unsigned int cpu, struct hlist_node *node)
-{
-	struct iommu_pmu *iommu_pmu = hlist_entry_safe(node, typeof(*iommu_pmu), cpuhp_node);
-	int target = cpumask_first(&iommu_pmu_cpu_mask);
-
-	/*
-	 * The iommu_pmu_cpu_mask has been updated when offline the CPU
-	 * for the first iommu_pmu. Migrate the other iommu_pmu to the
-	 * new target.
-	 */
-	if (target < nr_cpu_ids && target != iommu_pmu->cpu) {
-		perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target);
-		iommu_pmu->cpu = target;
-		return 0;
-	}
-
-	if (!cpumask_test_and_clear_cpu(cpu, &iommu_pmu_cpu_mask))
-		return 0;
-
-	target = cpumask_any_but(cpu_online_mask, cpu);
-
-	if (target < nr_cpu_ids)
-		cpumask_set_cpu(target, &iommu_pmu_cpu_mask);
-	else
-		return 0;
-
-	perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target);
-	iommu_pmu->cpu = target;
-
-	return 0;
-}
-
-static int nr_iommu_pmu;
-static enum cpuhp_state iommu_cpuhp_slot;
-
-static int iommu_pmu_cpuhp_setup(struct iommu_pmu *iommu_pmu)
-{
-	int ret;
-
-	if (!nr_iommu_pmu) {
-		ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
-					      "driver/iommu/intel/perfmon:online",
-					      iommu_pmu_cpu_online,
-					      iommu_pmu_cpu_offline);
-		if (ret < 0)
-			return ret;
-		iommu_cpuhp_slot = ret;
-	}
-
-	ret = cpuhp_state_add_instance(iommu_cpuhp_slot, &iommu_pmu->cpuhp_node);
-	if (ret) {
-		if (!nr_iommu_pmu)
-			cpuhp_remove_multi_state(iommu_cpuhp_slot);
-		return ret;
-	}
-	nr_iommu_pmu++;
-
-	return 0;
-}
-
-static void iommu_pmu_cpuhp_free(struct iommu_pmu *iommu_pmu)
-{
-	cpuhp_state_remove_instance(iommu_cpuhp_slot, &iommu_pmu->cpuhp_node);
-
-	if (--nr_iommu_pmu)
-		return;
-
-	cpuhp_remove_multi_state(iommu_cpuhp_slot);
-}
-
 void iommu_pmu_register(struct intel_iommu *iommu)
 {
 	struct iommu_pmu *iommu_pmu = iommu->pmu;
@@ -866,17 +765,12 @@ void iommu_pmu_register(struct intel_iommu *iommu)
 	if (__iommu_pmu_register(iommu))
 		goto err;
 
-	if (iommu_pmu_cpuhp_setup(iommu_pmu))
-		goto unregister;
-
 	/* Set interrupt for overflow */
 	if (iommu_pmu_set_interrupt(iommu))
-		goto cpuhp_free;
+		goto unregister;
 
 	return;
 
-cpuhp_free:
-	iommu_pmu_cpuhp_free(iommu_pmu);
 unregister:
 	perf_pmu_unregister(&iommu_pmu->pmu);
 err:
@@ -892,6 +786,5 @@ void iommu_pmu_unregister(struct intel_iommu *iommu)
 		return;
 
 	iommu_pmu_unset_interrupt(iommu);
-	iommu_pmu_cpuhp_free(iommu_pmu);
 	perf_pmu_unregister(&iommu_pmu->pmu);
 }
-- 
2.38.1

