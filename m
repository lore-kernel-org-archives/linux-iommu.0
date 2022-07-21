Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B93D95
	for <iommu@lists.linux.dev>; Thu, 21 Jul 2022 13:03:03 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LpXjQ41C5z1M7vf;
	Thu, 21 Jul 2022 21:00:10 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 21:02:55 +0800
From: <yangyicong@huawei.com>
To: <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
	<leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <acme@kernel.org>, <peterz@infradead.org>,
	<corbet@lwn.net>, <mathieu.poirier@linaro.org>, <mark.rutland@arm.com>,
	<jonathan.cameron@huawei.com>, <john.garry@huawei.com>
CC: <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
	<suzuki.poulose@arm.com>, <joro@8bytes.org>,
	<shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
	<zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <bagasdotme@gmail.com>
Subject: [PATCH v11 4/8] perf tool: arm: Refactor event list iteration in auxtrace_record__init()
Date: Thu, 21 Jul 2022 21:01:12 +0800
Message-ID: <20220721130116.43366-5-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220721130116.43366-1-yangyicong@huawei.com>
References: <20220721130116.43366-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected

From: Qi Liu <liuqi115@huawei.com>

Add find_pmu_for_event() and use to simplify logic in
auxtrace_record_init(). find_pmu_for_event() will be
reused in subsequent patches.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/perf/arch/arm/util/auxtrace.c | 53 ++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index 5fc6a2a3dbc5..384c7cfda0fd 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -50,16 +50,32 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
 	return arm_spe_pmus;
 }
 
+static struct perf_pmu *find_pmu_for_event(struct perf_pmu **pmus,
+					   int pmu_nr, struct evsel *evsel)
+{
+	int i;
+
+	if (!pmus)
+		return NULL;
+
+	for (i = 0; i < pmu_nr; i++) {
+		if (evsel->core.attr.type == pmus[i]->type)
+			return pmus[i];
+	}
+
+	return NULL;
+}
+
 struct auxtrace_record
 *auxtrace_record__init(struct evlist *evlist, int *err)
 {
-	struct perf_pmu	*cs_etm_pmu;
+	struct perf_pmu	*cs_etm_pmu = NULL;
+	struct perf_pmu **arm_spe_pmus = NULL;
 	struct evsel *evsel;
-	bool found_etm = false;
+	struct perf_pmu *found_etm = NULL;
 	struct perf_pmu *found_spe = NULL;
-	struct perf_pmu **arm_spe_pmus = NULL;
+	int auxtrace_event_cnt = 0;
 	int nr_spes = 0;
-	int i = 0;
 
 	if (!evlist)
 		return NULL;
@@ -68,24 +84,23 @@ struct auxtrace_record
 	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (cs_etm_pmu &&
-		    evsel->core.attr.type == cs_etm_pmu->type)
-			found_etm = true;
-
-		if (!nr_spes || found_spe)
-			continue;
-
-		for (i = 0; i < nr_spes; i++) {
-			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
-				found_spe = arm_spe_pmus[i];
-				break;
-			}
-		}
+		if (cs_etm_pmu && !found_etm)
+			found_etm = find_pmu_for_event(&cs_etm_pmu, 1, evsel);
+
+		if (arm_spe_pmus && !found_spe)
+			found_spe = find_pmu_for_event(arm_spe_pmus, nr_spes, evsel);
 	}
+
 	free(arm_spe_pmus);
 
-	if (found_etm && found_spe) {
-		pr_err("Concurrent ARM Coresight ETM and SPE operation not currently supported\n");
+	if (found_etm)
+		auxtrace_event_cnt++;
+
+	if (found_spe)
+		auxtrace_event_cnt++;
+
+	if (auxtrace_event_cnt > 1) {
+		pr_err("Concurrent AUX trace operation not currently supported\n");
 		*err = -EOPNOTSUPP;
 		return NULL;
 	}
-- 
2.24.0

