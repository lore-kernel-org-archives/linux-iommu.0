Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489311;
	b=WpS5BOdmHqzkxY+vH6i+F0fPIWwM5AYd7iO4wf+bnoRu5IgK3wOTV+v6zaVg3otR6mBY
	 0WC5moTB+S7zxZbueV4aCCNsXTdIfTgQkdEHaM334QcMRwaG6/WJC8mtvK0SJFQFSFtpi
	 ievx1l9VjJN0BYXooNP6f2DYZlqcbI2lIznobde8BLQIHcn9M1jaexXk8FJgkOhG/aiFh
	 ggtu+KTyTXDHus6fm3kJ1YhcUAc4fGibNLOzMonQxFmsEz30+qjDXZ7/Hp4QgJCxNS/Xx
	 5uXl6Q522cRovb6CnSYRSCFuVbclh6rHpcpJR2mjiNNoLlmcsdICCs3gHux1eNvGLSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489311;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QCb47E7x0Bd30ckXIsM6yBXLo6H/r24mXo17wO/0cfM=;
	b=GRr8N41l5bDJlLoGYkycEi56zMs+Ob03PpVNfYMLxcXUInI5MsbjgH1uywJ8ogX+z8gx
	 9MZb6ssRWfIv8YX2XLSEVCfgEYiI52/4t9+P+DXAfixdB11uFH6YvMg3mfnXiLWjB5W6R
	 klWEE5+iIHXiBcyjbBDt+AzLSoZVdoXmDH575FHcmWCdJ46C1CJCWkJDe78j8Xkcredcw
	 rX3ZCnpdZqIbTj5EJO8jKZu56vgvTFkik3ZlutqwR1ymVPjYKygESecfZpEQFT5bB4oUE
	 oUbkskx6P9aRA3F1GJ34CgOjuGPAqDwUMpolT/Q+XP0Ja4GQVhhd26FTmyqMfMd7UGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="A2Cz/7dG";
	arc=none smtp.remote-ip=115.124.30.132
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3583C60A3819
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 09:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3583C60A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=A2Cz/7dG
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792489308; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QCb47E7x0Bd30ckXIsM6yBXLo6H/r24mXo17wO/0cfM=;
	b=A2Cz/7dGlInE8/pju8HUjpFmpt5qbA0YfCc+6Uy0OjFLucxG2KfjzQIZg55cQJnka94c/6hXUZhVpkElGJwgCA7VroW5GYf95bumSx1uR9Ttv7tTTgyGDhx+JpMN1sxfmpCuhMP6PRaKcVXMEKa3zpIGnzWnCDMiGwZOYOv+GxA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XDCspfO_1792489304;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDCspfO_1792489304 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 17:41:46 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	jroedel@suse.de,
	zong.li@sifive.com,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	atish.patra@linux.dev,
	skhawaja@google.com,
	vasant.hegde@amd.com,
	joerg.roedel@amd.com,
	tanchi25@mails.ucas.ac.cn,
	gong.shuai@sanechips.com.cn
Cc: fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org
Subject: [RFC PATCH v5 09/10] iommu/riscv: Add dirty tracking support for second-stage domains
Date: Tue, 20 Oct 2026 17:41:05 +0800
Message-Id: <20261020094106.92722-10-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
References: <20261020094106.92722-1-fangyu.yu@linux.alibaba.com>
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

Add hardware dirty tracking support for second-stage (iohgatp) domains
used in KVM VFIO device pass-through.

The RISC-V IOMMU can automatically set the dirty bit in PTEs on write
access when DC.tc.GADE is set and the hardware has AMO_HWAD capability.
Wire this up to the iommufd dirty tracking interface:

  - riscv_iommu_set_dirty_tracking(): Always enabled dirty tracking for
    second-stage domain.

  - riscv_iommu_dirty_ops: Exposes set_dirty_tracking and the generic
    page-table read_and_clear_dirty via IOMMU_PT_DIRTY_OPS(riscv_64).

  - domain_alloc_paging_flags: Assigns dirty_ops to second-stage domains
    when AMO_HWAD is advertised in hardware capabilities.

  - riscv_iommu_capable: Reports IOMMU_CAP_DIRTY_TRACKING when
    AMO_HWAD is present.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 9310b818c038..e3791e912af3 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1376,6 +1376,21 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	return 0;
 }
 
+static int riscv_iommu_set_dirty_tracking(struct iommu_domain *iommu_domain,
+					  bool enable)
+{
+	/*
+	 * Always enabled and the dirty bitmap is cleared prior to
+	 * set_dirty_tracking().
+	 */
+	return 0;
+}
+
+static const struct iommu_dirty_ops riscv_iommu_dirty_ops = {
+	IOMMU_PT_DIRTY_OPS(riscv_64),
+	.set_dirty_tracking = riscv_iommu_set_dirty_tracking,
+};
+
 static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
 	IOMMU_PT_DOMAIN_OPS(riscv_64),
 	.attach_dev = riscv_iommu_attach_paging_domain,
@@ -1466,6 +1481,8 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 			goto err_free;
 		}
 		cfg.common.features |= BIT(PT_FEAT_RISCV_S2);
+		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
+			domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -1541,9 +1558,13 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 
 static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
 		return true;
+	case IOMMU_CAP_DIRTY_TRACKING:
+		return !!(iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD);
 	default:
 		return false;
 	}
-- 
2.50.1

