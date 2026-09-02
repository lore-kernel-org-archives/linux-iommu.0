Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3BE3EF643
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339263; cv=none; b=VXJauOdX4YARuFLtHgzpNA8Q+Sibdyeua9XYc6BosEuk0d68JfSL3SFA92oM3VUMD8pYc4fB5CyFOVDVBVklmHx1/sm8NB6cnQy7VNccshE7MhcgeUNVxX83N9WRYyeXDz92tAFGUUq3u3pZ+MTTpg7NrsKCRzya4d+MG0fKFpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339263; c=relaxed/simple;
	bh=5Coe72x/U21hD8YKbeq+87ZR7E19XoiYikO0HoKXNRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dnrg6pK+8Rm5vesYODemgvq6bsCY600svl1HG6MqwTvwQeW1QlCVFgbYIumiis4ncesaLLudd5r2ZkEBhqUihCcz40+e9bXNUf033Hb060nAuAsmE3jiH5PGiwX+i1tGg4gBjb3Lc8gKUqmLQdEyyFKo0SDELAqhdP8dF3FQp0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZyuUouEP; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZyuUouEP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788339257; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hwHhb2zUXrWj+XEOFD6mkAm84SIqh2us6H+dJa35h3g=;
	b=ZyuUouEPVnBauXzJnpdFqBzLeeLGmH6/41nRfHl0Hlk1A2EaVr+ihVXrI+M1WXh1QrdGDywy1oS1zIdmBGqrE8oaw8H89EPSYRqZgilccTXu2CCzS/WGvdLLeAfOu1UaiZQ9SrKLnHorIzLfKE+IQ6eeGbWsapW53Fhg7SVXV9w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XACD4Ge_1788339255;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XACD4Ge_1788339255 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 02 Sep 2026 16:54:16 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	yeeli <seven.yi.lee@gmail.com>,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH] iommufd/selftest: Return dmabuf fd from IOMMU_TEST_OP_DMABUF_GET again
Date: Wed,  2 Sep 2026 16:54:14 +0800
Message-ID: <20260902085414.549830-1-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The selftest helper reads the new dmabuf fd from the ioctl return
value:

	*out_fd = ioctl(fd, IOMMU_TEST_CMD, &cmd);

Commit dba4254e216d ("iommufd/selftest: Fix dmabuf leak in
iommufd_test_dmabuf_get()") fixed the dmabuf leak on dma_buf_fd()
failure, but the applied version also changed the success path to
return 0, so userspace no longer receives the fd.  Note the patch as
posted on the list returned rc here; the change to return 0 appeared
when it was applied:

  https://lore.kernel.org/all/20260707030635.221577-1-seven.yi.lee@gmail.com/

Every test using test_cmd_get_dmabuf() then operates on fd 0 instead
of the dmabuf, and the dmabuf_simple and dmabuf_revoke selftests fail
across all fixtures:

  # iommufd.c:1595:dmabuf_simple:Expected -1 (-1) ==
    _test_ioctl_ioas_map_file(...) (0)

Keep the dma_buf_put() on failure but return the fd on success.

Fixes: dba4254e216d ("iommufd/selftest: Fix dmabuf leak in iommufd_test_dmabuf_get()")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 drivers/iommu/iommufd/selftest.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index ee706f18f7e91..f6da927461b57 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -2056,11 +2056,9 @@ static int iommufd_test_dmabuf_get(struct iommufd_ucmd *ucmd,
 	}
 
 	rc = dma_buf_fd(dmabuf, open_flags);
-	if (rc < 0) {
+	if (rc < 0)
 		dma_buf_put(dmabuf);
-		return rc;
-	}
-	return 0;
+	return rc;
 
 err_free:
 	kfree(priv->memory);
-- 
2.43.7

