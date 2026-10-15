Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFE14AA56B
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070445; cv=none; b=Bn7ksrCHN6CR9UqD7eyTJW2nzIQYFZTksZletvv7ylrilG6VlTnqrhOjE4jqtUgXo2uTshpiAEuqtA+PF61z5eINZgEeL4Z2dfp6yO0R5F1rbQQS1JWHy2QT4aDXVoYmUlVf0y/A8f7p5nCudRGNk94WSuohSt7j6V7CewGiEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070445; c=relaxed/simple;
	bh=p7maNFUFZ8AqbEu28V2pBJOxhMBuQWHTODXj03fzBeE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YcjAuKYnd2p/VhwhtyePSBtT8HTW3EfL14GtIas1mahvf0zPcaGQw9rZTIKMmgwsTTn+Dd6tABr7ZLQNJvVW8iPajScN4gOq571BCilPyI0msr02Rm24RHpUOyH+0UOiCkPR5i/CNobfcFXkOWTlP3Nw/J9jQrP+BByKbqgRYnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fUnivaV+; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fUnivaV+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792070433; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vsIpB7vSSkRwIpK0lyI7cC1L86RAh24gU6u1hVeflGQ=;
	b=fUnivaV+tHjWqDp1Ju3QhOHL6nM1yz03n6M5wqtIE6vPV2AxiNhbCt8gxDnPdAgbbJav3+juM06uKhTKZanuH3IqNnrtcuelL2rF7Ietswyl6ll7e/U0k1oM6xki+7DJIq2AG3VI4ZIIYzsHSA44T/zoMhpBTTSgAJipFwqMreg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XCrq9fv_1792070431;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XCrq9fv_1792070431 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 Oct 2026 21:20:32 +0800
From: fangyu.yu@linux.alibaba.com
To: jgg@nvidia.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	joerg.roedel@amd.com,
	jgg@ziepe.ca,
	vasant.hegde@amd.com,
	kevin.tian@intel.com,
	Ankit.Soni@amd.com
Cc: guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH] iommupt/kunit: Read an exact NR_SECONDARY_PAGETABLE snapshot for the leak check
Date: Thu, 15 Oct 2026 21:20:24 +0800
Message-Id: <20261015132024.43998-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

NR_SECONDARY_PAGETABLE is per-CPU batched and only folded into the global
counter about once per second. The tests complete within a few seconds, so
the init/exit checks can read stale values and randomly fail when a fold
lands mid-test, even though no page table is leaked:

    # test_map_simple: ASSERTION FAILED at .../kunit_iommu_pt.h:473
    Expected priv->orig_nr_secondary_pagetable ==
    global_node_page_state(NR_SECONDARY_PAGETABLE), but
        priv->orig_nr_secondary_pagetable == 68 (0x44)
        global_node_page_state(NR_SECONDARY_PAGETABLE) == 70 (0x46)

Sum the per-CPU batches together with the global counter to get an exact
snapshot before and after each test case, which makes the check
deterministic without any settling delay.

Fixes: bc5233c0904e ("iommupt: Add a kunit test for the IOMMU implementation")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/generic_pt/kunit_iommu_pt.h | 40 ++++++++++++++++++++---
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
index ece1c9b8c55d..d20728b196be 100644
--- a/drivers/iommu/generic_pt/kunit_iommu_pt.h
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -4,6 +4,7 @@
  */
 #include "kunit_iommu.h"
 #include "pt_iter.h"
+#include <linux/cpu.h>
 #include <linux/generic_pt/iommu.h>
 #include <linux/iommu.h>
 
@@ -438,6 +439,36 @@ static struct kunit_case iommu_test_cases[] = {
 	{},
 };
 
+/*
+ * The global NR_SECONDARY_PAGETABLE counter is batched per-CPU and folded
+ * into the global value asynchronously, sum the global value and the per-CPU
+ * deltas to get an exact snapshot.
+ *
+ * The global value must be read without the clamp of global_node_page_state():
+ * the raw counter is transiently negative whenever a folded free batch
+ * outweighs allocation deltas still pending on other CPUs, and clamping
+ * before adding the deltas back would overestimate and report phantom leaks.
+ * global_node_page_state_monotonic() is normally reserved for monotonic
+ * counters because a raw negative read is garbage as a page count, but the
+ * sum with the pending deltas always restores the exact non-negative value.
+ */
+static unsigned long pt_kunit_nr_secondary_pagetable(void)
+{
+	unsigned long nr = global_node_page_state_monotonic(NR_SECONDARY_PAGETABLE);
+
+#ifdef CONFIG_SMP
+	int nid, cpu;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu)
+		for_each_online_node(nid)
+			nr += per_cpu_ptr(NODE_DATA(nid)->per_cpu_nodestats,
+					  cpu)->vm_node_stat_diff[NR_SECONDARY_PAGETABLE];
+	cpus_read_unlock();
+#endif
+	return nr;
+}
+
 static int pt_kunit_iommu_init(struct kunit *test)
 {
 	struct kunit_iommu_priv *priv;
@@ -447,8 +478,7 @@ static int pt_kunit_iommu_init(struct kunit *test)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->orig_nr_secondary_pagetable =
-		global_node_page_state(NR_SECONDARY_PAGETABLE);
+	priv->orig_nr_secondary_pagetable = pt_kunit_nr_secondary_pagetable();
 	ret = pt_kunit_priv_init(test, priv);
 	if (ret) {
 		kunit_kfree(test, priv);
@@ -461,17 +491,19 @@ static int pt_kunit_iommu_init(struct kunit *test)
 static void pt_kunit_iommu_exit(struct kunit *test)
 {
 	struct kunit_iommu_priv *priv = test->priv;
+	unsigned long nr;
 
 	if (!test->priv)
 		return;
 
 	pt_iommu_deinit(priv->iommu);
+	nr = pt_kunit_nr_secondary_pagetable();
+
 	/*
 	 * Look for memory leaks, assumes kunit is running isolated and nothing
 	 * else is using secondary page tables.
 	 */
-	KUNIT_ASSERT_EQ(test, priv->orig_nr_secondary_pagetable,
-			global_node_page_state(NR_SECONDARY_PAGETABLE));
+	KUNIT_ASSERT_EQ(test, priv->orig_nr_secondary_pagetable, nr);
 	kunit_kfree(test, test->priv);
 }
 
-- 
2.50.1

