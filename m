Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793436949;
	b=mr+ZJo8uG6NZt69AmfmGhzs67K6sHx1/53OvW99l5yj07TKhfzEnGLMgeWCHFVkBPs+4
	 XdJWGgKPyumD9H1e02KUxeiVdxHnrKg05oy5qTsf5e+ySiZkUPniUDIFNrXobRWIuLaef
	 tPZS+zxJA07+PuS9ukypEVCIPVc0jexAPFw3nDdvuB5gYSaRW2MRqoBU2p1t8Q6+fhUHA
	 DqkjZ4oo/Fd2spFhJvW6ghAEUNuOpZQ8pOj/04SokkhQDMHiwYuhKdJVAEtH3P9+nhL20
	 eEEpeY27Ja7qQ4E02zJ8O7Ufoo4AJng3J5LZUX8r5bwwy4xcLAGSlsQkXTiqXuP/oBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793436949;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fS7XURTcWggfWp6dQC3jfd2C5c5AXRPdyf6P61qt0XU=;
	b=zj3VtbmrJu52rXliiCEww0IHuQ4rAV/DwdFGAZc1HCcVwdvB0yCqATEpOdBciUzhXC7P
	 GmAS7R1c+p/k9GApl5T74Fv6ceumHiYfLTye7hxr2ZW6gumOcajEibQInlL1Vszo3zto7
	 O3CefW4W5T6G2R9GeyQqEzHtucCEOtBjRy74raPoDSpi0L1ePq1EXTpVy4AaDIZQMxdVT
	 ijN9D6zjnEn0cC7yY5TafcGTO4Q1i5NgleUQrDsWKJRwvFUEUkjkzXnOwXC7Wd1QFe5EQ
	 LQn/svUgGnJPMATFPzoJF8biatNTXxbPiZtSTkxT798HGj66Pt3t9n+4g1SVz1FYTgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HKmXs3AZ;
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B47606A320
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 08:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5B47606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HKmXs3AZ
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793436944; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fS7XURTcWggfWp6dQC3jfd2C5c5AXRPdyf6P61qt0XU=;
	b=HKmXs3AZZJ8RKJ4qG1geCjSUB2hZ9FPo51eXFCpJBmASPck9X2Cekv1EtMTeOcoHIbjL06SdyHwCf+RRe6oZRhara3+RIOIHnZR7w9XBF1heqnErNS1Kl4LCZGemdeFOpugtfCtPrQqsSJ+kabsVDLpnpXNMU2bRutRDJK207Fg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XDo6dzb_1793436942;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDo6dzb_1793436942 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 31 Oct 2026 16:55:43 +0800
From: fangyu.yu@linux.alibaba.com
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	joerg.roedel@amd.com,
	jgg@ziepe.ca,
	jgg@nvidia.com,
	dan@reactivated.net,
	vasant.hegde@amd.com,
	kevin.tian@intel.com,
	Ankit.Soni@amd.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	guoren@kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v2] iommupt/kunit: Skip the page-table leak check on SMP
Date: Sat, 31 Oct 2026 16:55:36 +0800
Message-Id: <20261031085536.18555-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

NR_SECONDARY_PAGETABLE is batched per-CPU on SMP, so the global counter
can change as pending updates are folded, even when a test has freed all
its page tables. Comparing the global counter before and after a test
can therefore report a false leak. A failed teardown assertion also
aborts cleanup, causing subsequent tests to fail because the test driver
is still registered.

Only perform the leak-check assertion on non-SMP configurations, where
there are no per-CPU vmstat deltas. Keep the tests and resource cleanup
enabled on SMP without accessing MM's internal vmstat data structures.

Fixes: bc5233c0904e ("iommupt: Add a kunit test for the IOMMU implementation")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
Changes in v2:
  - Replace the hand-written vmstat snapshot with a non-SMP-only
    assertion, as suggested by Jason.

Link to v1:
  https://lore.kernel.org/linux-iommu/20261015132024.43998-1-fangyu.yu@linux.alibaba.com/
---
 drivers/iommu/generic_pt/kunit_iommu_pt.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
index 9fc71db74234..d90e57b2cd7b 100644
--- a/drivers/iommu/generic_pt/kunit_iommu_pt.h
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -470,8 +470,10 @@ static void pt_kunit_iommu_exit(struct kunit *test)
 	 * Look for memory leaks, assumes kunit is running isolated and nothing
 	 * else is using secondary page tables.
 	 */
-	KUNIT_ASSERT_EQ(test, priv->orig_nr_secondary_pagetable,
-			global_node_page_state(NR_SECONDARY_PAGETABLE));
+	/* Per-CPU vmstat batching can cause false leak reports on SMP. */
+	if (!IS_ENABLED(CONFIG_SMP))
+		KUNIT_ASSERT_EQ(test, priv->orig_nr_secondary_pagetable,
+				global_node_page_state(NR_SECONDARY_PAGETABLE));
 	kunit_kfree(test, test->priv);
 }
 
-- 
2.50.1

