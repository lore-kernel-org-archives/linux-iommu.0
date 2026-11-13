Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794582371;
	b=Gm2Nxe334WFHMQyv9prqoxdVq+W8CzAolAOUMzV+1+ljI20mc/q0jdzOE49RWtf6GcY1
	 EAKq1rqIoAnLjWbuaN96jkMJR6j+8rQlGKM1J6krNBpPmkc5iTGvr2ELLip/thztbfZgQ
	 WYVk8fuW+jiIcKEkdwpplEcJbRwY+MxvgqMmJty4jnUEbNPNjhLnx2Oq0P76ETlCopY5x
	 FmWtpqId53g1D3/BRcKCaekcEijUQP068SCR6VfOO23OKY1rP2grlEMMNceOUsz38I/x7
	 9qfTidcJhc3NxSkT0DPtvWcRYFzCIqZPa5wG1KVmLjXb+eDSn0Rg2cG13v4JW5DqR5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582371;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JOoo9w+biOZwsPCzKxRRmsFPgf4UiAdunvpl6A1YETU=;
	b=uKgG23xS01XuSmjfU9qPrbqbKt9+yNwg71xCcQDjYGonQ3FqA1Y9IhVPkclvQN6Y62fc
	 rzAb0uGo8+ZyNGICftZane9Mhwp3/ThMKwLr40jxkPbrVOJsbLlRg4XyAaImqHr/p43yI
	 tPSk1Br5mBwMLhR5/SENzMsrjgd8PEcWOJGMqSWIVQugpS5gHb1qdfTwoZXFh/y0dD/Bx
	 +a85Bd4C8c+8kbvezRaIZ2yNcJHbXXUnArz6TKOnEi5LTZI/+KiXgLXjgmzNHW1BrQ1gg
	 Tl393Kh57mekUkHy2gjSAH1MjqeA47kNIg68lnLyln/Re1UVXXYYyk1ItVo1n6OUM/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BXbyJ06P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.0
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE82606A8AD
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 15:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BE82606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BXbyJ06P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb6nIW1im/HDb8ttNQ81GIwSKAkogi29gCGOG6nKgZGQolcMeEm7hdeXIC6ehnZJWyNy6R62HPMfvDiJRzeGd3nPdkoxx54ESIJ2kNXNHgl78ubLWzUH/NkJAOn8/fq4NWHmjXGzHQHP4/E5iD817P0gbfPva+nimJezMdAQ+eMLSN5Ftee8CUmFye1UO4Fj9o0bvfAZYtmykrv3HYt5fc1hY4Q7fomAyLnSK5VG28HSuzlPOAggL8pRcBZOYEo0JsIi5nbMtV6xuMeRNkwd7k0O7kbLQGjBV1m9DqeAD7VpDPRiy0B5PjVaLSwLdOMmCSXyV/LUSCoN1fVMWRfvTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOoo9w+biOZwsPCzKxRRmsFPgf4UiAdunvpl6A1YETU=;
 b=N+2DTD8nYJEPYyQT2qtK9JLH+ecH8td0PicUkBEd8CtlKzs79hGGyJRp7VsAxBv1KdPsv7B4wIMFg7WzhwPG+lmcETttm2EE76l3pthcgXjCiQ3Tv03GC4lUp49kbCXaL9E7g8x94q0XTGWixmVErLyJ4SkNy1/bYC9zEAsORIiNNNiiGFC+miFPxgIp57HqdaOEXeQYjSzyCqYQ7DePRvuARaaQw+vOj7zMsdq3mBMZlRpKN0qXmS5anq63a6znXHWw4JV2uW58u4hgpeNOxT/To4wooMiABzuTc9v7Uax80COHOwmhTinQHpT0b6CC8enOOHc1BbSLWkUVYkVIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOoo9w+biOZwsPCzKxRRmsFPgf4UiAdunvpl6A1YETU=;
 b=BXbyJ06PxHWPED+urp1xdovgM73ah5j+Qhhoqw94/KI0drMk5OT2ZR5NXL+pkv6tufLzAJoNw3bn1p5ldSfiwCm/5IYGZPDipDpKEeh/PJxVjj9rc/d/ev7UwvPB5CeOkMy1kPBVVtiJUOlQq+uhG+R8nwAwsBkDF6ywVnYas5I=
Received: from CH0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:610:b0::15)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Fri, 13 Nov
 2026 15:05:45 +0000
Received: from BL2PEPF000352CA.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::90) by CH0PR03CA0010.outlook.office365.com
 (2603:10b6:610:b0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri,
 13 Nov 2026 15:05:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352CA.mail.protection.outlook.com (10.167.249.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 15:05:38 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 09:05:32 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <james.clark@linaro.org>
CC: <x86@kernel.org>, <dave.hansen@linux.intel.com>, <tglx@kernel.org>,
	<bp@alien8.de>, <hpa@zytor.com>, <iommu@lists.linux.dev>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <sandipan.das@amd.com>, <ctshao@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2] x86/events/amd/iommu: Use a per-IOMMU cpumask
Date: Fri, 13 Nov 2026 15:05:02 +0000
Message-ID: <20261113150502.685887-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352CA:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 729d49e3-edcc-46ac-b8f6-08df41979419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|82310400026|1800799024|36860700016|261021123027099003|921020|11063799006|261009223027099003|261022105027099003|261026140227099003|261009221227099003|261021121427099003|261028144727099003|261102123227099003|56012099006|18002099003|6133799003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	n9QS2Lv+yE2bZOpwT8r1OT0NdHW2zVn+B5d3aTWftDs861Wn4cbNBaRflZmAulwbALfPTZhwBzviuD7AZX9DJTMB0rZHE89kmK3zVKVMqpt8Ax5CMwHvv6KyRMN0aGXUUMeYiFBNyFa6XMYvBOPqQI6kyadKNfHjS5BN9oM/tPD0bCE68BTfuA2pCWBmqHitJF/2KfoHTcBvsAW8ORMFnbaC9b63hm7KnhHcUWNpsIFzT1riZIsRH46XgKiOkKPq9YLaeZkwPhhHfkx2+HoAsyEOOexEdRRIFnHikDgG0ZVTK7LFMnMf6IjBa2WbgBnOGyQX5BIIOKstPucZkNDVTTGc/AVamjkPsVUK6PL8NolBvYLqdpwwbZXId5jZdUF8+ziXtlZNnzDs+cu701HoxHjVwYKMDcece4S5RzAKw7wZhlx9xrnnIP3bfpUJNUG3p995Iy8TKfT+/ncMUNPfc5k3CBMsQ750G1KJkDykpkU1LvpB3X0LJI5WJoZEaMwSWBwY5yGppNIDMm5K6gavuiVn42+8d1oiu7OhVfHbtccI14o85N5gMhX9sCpF3zmZJi64uSHysJNhGWRMeqZDduWuvmoHFuelFsioXR95Cg8Nuq406YJ2WwKwDk9xayi/GOFeP6L+8f5jS4+UVIEwoTB3Ki8XeMrJaWtC5Qbn5X6R9ps3mR8uyOmE0LN49kpjrus4VqiEPnMdvbjMKCotNQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(261021123027099003)(921020)(11063799006)(261009223027099003)(261022105027099003)(261026140227099003)(261009221227099003)(261021121427099003)(261028144727099003)(261102123227099003)(56012099006)(18002099003)(6133799003)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OxtH6a1SUpDbSogDyAMqUAkXtluGV8rAapsRoIraBnfyh3OdTg8KZceNbGzitzIHRqe6spm8bQALX7pgsTAxY5y670cgmfk10usaAzILaceAagxFj+pOa9/aKuRe6lV8xEjVkV3hxnhN5eFzjdJDujtGF7p0hOFPYQs+od8lrhAdN4iim9GdIVwe8Tl72jMVSg2FeJZXSeCQUOFJNyYFJyoHHuzAh3xvg59Bau/GIxstaZPesr7D996wJVDAeV3yqr6dY5IapneMGvh8icRvnCajMUdQPS0f9iSLPpHINskgdE1xsiCY6pfw+eDhDbSncqNPT8WPxLXCJLece1gmnbXKXRqaErsWKQVNC0Oo7wJJFRoNbEZZjNwwD6zS/5dTSHPQe2Zk+bdbRjK9yFmH/Uq1YogNSfalCrjhvEHOs0scfXvG6fNx+e65nphK9Z3S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 15:05:38.9964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729d49e3-edcc-46ac-b8f6-08df41979419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352CA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103

IOMMU performance counters are accessed via MMIO. The AMD IOMMU PMUs
share one global cpumask, fixed to CPU0, so every IOMMU's events are
read through the same CPU. That prevents collecting per-NUMA-node
numbers (for example perf stat --per-socket). The mask is also never
updated, so counting stops if that CPU goes offline.

Give each IOMMU PMU its own cpumask. The CPU is chosen from the online
CPUs of the NUMA node of the IOMMU's PCI device, via
amd_iommu_idx_to_dev(). If the node is unknown or has no online CPU,
any online CPU is used. If no online CPU exists at all, that PMU is
not registered.

A CPU hotplug callback moves the reader when that CPU goes offline,
preferring another online CPU on the same node. If the reader had to
leave the node, it moves back when a CPU on that node comes online.
Events are pinned to the current reader so they share one context and
migrate together.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
V1: https://lore.kernel.org/linux-iommu/20260517114026.6817-1-vasant.hegde@amd.com/

Changes since v1:
  - Rebased on top of v7.4-rc2
  - Added hotplug support

-Vasant

 arch/x86/events/amd/iommu.c | 130 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/amd/init.c    |   7 ++
 include/linux/amd-iommu.h   |   1 +
 include/linux/cpuhotplug.h  |   1 +
 4 files changed, 134 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index f332c7089bd5..3b35702aa702 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt)	"perf/amd_iommu: " fmt
 
+#include <linux/device.h>
 #include <linux/perf_event.h>
 #include <linux/init.h>
 #include <linux/cpumask.h>
@@ -43,6 +44,8 @@ struct perf_amd_iommu {
 	u8 max_counters;
 	u64 cntr_assign_mask;
 	raw_spinlock_t lock;
+	int node;
+	cpumask_t cpumask;
 };
 
 static LIST_HEAD(perf_amd_iommu_list);
@@ -131,13 +134,15 @@ static struct amd_iommu_event_desc amd_iommu_v2_event_descs[] = {
 /*---------------------------------------------
  * sysfs cpumask attributes
  *---------------------------------------------*/
-static cpumask_t iommu_cpumask;
-
 static ssize_t _iommu_cpumask_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&iommu_cpumask));
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct perf_amd_iommu *perf_iommu =
+			container_of(pmu, struct perf_amd_iommu, pmu);
+
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&perf_iommu->cpumask));
 }
 static DEVICE_ATTR(cpumask, S_IRUGO, _iommu_cpumask_show, NULL);
 
@@ -207,7 +212,11 @@ static int clear_avail_iommu_bnk_cntr(struct perf_amd_iommu *perf_iommu,
 
 static int perf_iommu_event_init(struct perf_event *event)
 {
+	struct perf_amd_iommu *perf_iommu =
+			container_of(event->pmu, struct perf_amd_iommu, pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	unsigned long flags;
+	unsigned int cpu;
 
 	/* test the event attr type check for PMU enumeration */
 	if (event->attr.type != event->pmu->type)
@@ -224,6 +233,18 @@ static int perf_iommu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
+	/*
+	 * Counters are read via MMIO from one CPU. Pin every event there so
+	 * they share a context and move together when that CPU goes offline.
+	 */
+	raw_spin_lock_irqsave(&perf_iommu->lock, flags);
+	cpu = cpumask_first(&perf_iommu->cpumask);
+	raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+	if (cpu >= nr_cpu_ids)
+		return -ENODEV;
+
+	event->cpu = cpu;
+
 	/* update the hw_perf_event struct with the iommu config data */
 	hwc->conf  = event->attr.config;
 	hwc->conf1 = event->attr.config1;
@@ -417,9 +438,93 @@ static const struct pmu iommu_pmu __initconst = {
 	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 };
 
+/*
+ * Pick a CPU to read this IOMMU's counters. Prefer an online CPU on
+ * @node. @except is skipped so a CPU going offline is not chosen again;
+ * pass -1 when any online CPU is acceptable.
+ */
+static unsigned int iommu_pmu_pick_cpu(int node, int except)
+{
+	unsigned int cpu = nr_cpu_ids;
+
+	if (node != NUMA_NO_NODE)
+		cpu = cpumask_any_and_but(cpumask_of_node(node),
+					  cpu_online_mask, except);
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_any_but(cpu_online_mask, except);
+
+	return cpu;
+}
+
+static int iommu_pmu_cpu_offline(unsigned int cpu)
+{
+	struct perf_amd_iommu *perf_iommu;
+	unsigned long flags;
+	unsigned int target;
+
+	list_for_each_entry(perf_iommu, &perf_amd_iommu_list, list) {
+		raw_spin_lock_irqsave(&perf_iommu->lock, flags);
+		if (!cpumask_test_and_clear_cpu(cpu, &perf_iommu->cpumask)) {
+			raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+			continue;
+		}
+
+		target = iommu_pmu_pick_cpu(perf_iommu->node, cpu);
+		if (target < nr_cpu_ids)
+			cpumask_set_cpu(target, &perf_iommu->cpumask);
+		raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+
+		if (target < nr_cpu_ids)
+			perf_pmu_migrate_context(&perf_iommu->pmu, cpu, target);
+	}
+
+	return 0;
+}
+
+static int iommu_pmu_cpu_online(unsigned int cpu)
+{
+	struct perf_amd_iommu *perf_iommu;
+	unsigned long flags;
+	unsigned int target;
+
+	list_for_each_entry(perf_iommu, &perf_amd_iommu_list, list) {
+		if (perf_iommu->node != NUMA_NO_NODE &&
+		    cpu_to_node(cpu) != perf_iommu->node)
+			continue;
+
+		raw_spin_lock_irqsave(&perf_iommu->lock, flags);
+		if (cpumask_empty(&perf_iommu->cpumask)) {
+			cpumask_set_cpu(cpu, &perf_iommu->cpumask);
+			raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+			continue;
+		}
+
+		/*
+		 * A reader that fell off this node, because every local CPU
+		 * was offline, moves back when a local CPU returns.
+		 */
+		target = cpumask_first(&perf_iommu->cpumask);
+		if (perf_iommu->node == NUMA_NO_NODE ||
+		    cpu_to_node(target) == perf_iommu->node) {
+			raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+			continue;
+		}
+
+		cpumask_clear(&perf_iommu->cpumask);
+		cpumask_set_cpu(cpu, &perf_iommu->cpumask);
+		raw_spin_unlock_irqrestore(&perf_iommu->lock, flags);
+
+		perf_pmu_migrate_context(&perf_iommu->pmu, target, cpu);
+	}
+
+	return 0;
+}
+
 static __init int init_one_iommu(unsigned int idx)
 {
 	struct perf_amd_iommu *perf_iommu;
+	struct device *dev;
+	unsigned int cpu;
 	int ret;
 
 	perf_iommu = kzalloc_obj(struct perf_amd_iommu);
@@ -440,6 +545,17 @@ static __init int init_one_iommu(unsigned int idx)
 		return -EINVAL;
 	}
 
+	dev = amd_iommu_idx_to_dev(idx);
+	perf_iommu->node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
+	cpu = iommu_pmu_pick_cpu(perf_iommu->node, -1);
+	if (cpu >= nr_cpu_ids) {
+		pr_warn("Failed to find online CPU for IOMMU %d.\n", idx);
+		kfree(perf_iommu);
+		return -ENODEV;
+	}
+
+	cpumask_set_cpu(cpu, &perf_iommu->cpumask);
+
 	snprintf(perf_iommu->name, IOMMU_NAME_SIZE, "amd_iommu_%u", idx);
 
 	ret = perf_pmu_register(&perf_iommu->pmu, perf_iommu->name, -1);
@@ -483,8 +599,12 @@ static __init int amd_iommu_pc_init(void)
 		return -ENODEV;
 	}
 
-	/* Init cpumask attributes to only core 0 */
-	cpumask_set_cpu(0, &iommu_cpumask);
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_AMD_IOMMU_ONLINE,
+				"perf/x86/amd/iommu:online",
+				iommu_pmu_cpu_online, iommu_pmu_cpu_offline);
+	if (ret)
+		pr_warn("Failed to install CPU hotplug callback (%d)\n", ret);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3dd4ff145e55..f13aa858fd50 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -4077,6 +4077,13 @@ struct amd_iommu *get_amd_iommu(unsigned int idx)
 	return NULL;
 }
 
+struct device *amd_iommu_idx_to_dev(unsigned int idx)
+{
+	struct amd_iommu *iommu = get_amd_iommu(idx);
+
+	return iommu ? &iommu->dev->dev : NULL;
+}
+
 /****************************************************************************
  *
  * IOMMU EFR Performance Counter support functionality. This code allows
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 5c9dcf720f84..e3bddbe1c21b 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -67,6 +67,7 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 		u64 *value);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
+struct device *amd_iommu_idx_to_dev(unsigned int idx);
 
 #ifdef CONFIG_KVM_AMD_SEV
 int amd_iommu_snp_disable(void);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 1b6dba159bb2..468e61c98e80 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -205,6 +205,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
+	CPUHP_AP_PERF_X86_AMD_IOMMU_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
-- 
2.31.1

