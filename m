Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071937CD5A
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051831; cv=none; b=F5ATaz4tZ38GEEf1hpK0NimoZ+rcF6fbhPnUlVfxNqt/J3Rd8ormUEc2xrDgDSjwuAirrck9Ucz4j/N95nZrHtxgTJpEk0v2VgdKD/v8lmIuSiQeQ/IZQFtim+GSWyA3CfiGxc7aXaifjmycMcrrHkH66fk4odUkfDeJkJYPSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051831; c=relaxed/simple;
	bh=Jwpmthhapek6obfWvi74Lgl/nSIAQOIwoCd5PWfiYEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9s5mq0OcYMUNIpNerNc0oLi/cCkLa2yqLAlgvK6cNImEyefYGOPqchUh/eY3M2hAklyr6fxgNhEYXpf9XU+qrSSj8lqT8AZJQpxg44oAyfxsD2WSq+MM7S2Ll6vfKNPX+HMJwFWCmdfSVHU9UvE0IPnLPL7idWcFk7JOl0DiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oVR2KgZl; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oVR2KgZl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785051819; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lFZMurE4LaM5y5cfT18SOT1Vmb20iD+1VNeWbwIkZss=;
	b=oVR2KgZlRGlQritK3pADgg3bI7LhHZjFS0MYXY7jsNTT6ozQZrhbJvhnt+oT03GoWZRIOmaqewd7QMOKU7QspTCcSSTQNLD3Jds5I2/IiIjv3w1qn0X7YFDIE392uB8a+82npluxb+jt3EynO452++FCuFNB4LmEtsHY4MBEBXg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X7n2nA3_1785051816;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X7n2nA3_1785051816 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 26 Jul 2026 15:43:36 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com
Subject: [PATCH 1/4] iommu/sva: Set handle->dev before the SVA handle is visible
Date: Sun, 26 Jul 2026 15:43:29 +0800
Message-Id: <c22e9af74d113b110348b995879baf2fd4734fe7.1785050951.git.xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1785050951.git.xueshuai@linux.alibaba.com>
References: <cover.1785050951.git.xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_attach_device_pasid() installs the new SVA attach handle in the
group PASID lookup before iommu_sva_bind_device() returns. A concurrent
bind can therefore find and reuse the same handle after iommu_sva_lock is
dropped.

handle->dev was initialized after dropping iommu_sva_lock. This leaves a
window where a racing bind can return a handle whose dev pointer is still
NULL. A subsequent iommu_sva_unbind_device() can then dereference it via
handle->dev->iommu_group.

Initialize handle->dev before releasing iommu_sva_lock so any visible SVA
handle is fully initialized.

Fixes: be51b1d6bbff ("iommu/sva: Refactoring iommu_sva_bind/unbind_device()")
Cc: stable@vger.kernel.org
Assisted-by: Qoder:Qwen-3.8-MAX-Preview
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/iommu/iommu-sva.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index bc7c7232a43e..9742cb593577 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -145,8 +145,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	list_add(&domain->next, &iommu_mm->sva_domains);
 out:
 	refcount_set(&handle->users, 1);
-	mutex_unlock(&iommu_sva_lock);
 	handle->dev = dev;
+	mutex_unlock(&iommu_sva_lock);
 	return handle;
 
 out_free_domain:
-- 
2.39.3

