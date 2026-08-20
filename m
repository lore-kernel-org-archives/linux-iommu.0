Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9A3672BA
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237331; cv=none; b=qsJsDXzdvAIVI0lqVppOXEHbgorsSXZDfZOAikX1rDTqKzgg1maSi7qfJnWXxg7NFrs8wSkAHF+Tt0AVA5oP0S6G1IPJd1nI5GDHPD2TcATwJnSpUwXewusv5kMNMzNvkXF3MkQ81j3O3f1z6Q2c9yKsitbmAQvhtYGxCAGYbQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237331; c=relaxed/simple;
	bh=LcdrWQwq5yKQ9E7JRRHKGiy0qrVd+OS9APzXYCvziEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MH+n9mcoxo6RJ/w7/DV9WW654fdwIENZmvsd5nU68V6qvGQD/gW7omvyGj+hLi8iyoSVAUB9My2j1kMtUo8cpq8zQjzdK4UD8WETSB8EUJKIGg71ZjcsCEYvaOGr5AwGNqsGOQQdEM3Wn1p31Q3eninxpc/aaIbggbz9NVBa65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qSE8AQF2; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qSE8AQF2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787237320; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vgQ+VYvp6/RFnUh1YnQP8XOtZDLhcPdXhfjbqQkK2y8=;
	b=qSE8AQF2hyn9pn42siRaDHfzLioB9oMIRj87So17c80PHjNKOhnhhn/nF2oDgj3ArlpLE+kDtoFaDpf0lDqUGxyfnp4uNvpAM77/TeluZuWgYd4JIloM4IFDUalAafuqEFLKMw6z7a0jt9vWGnp7kCrvVbEnhEXhMo+2ICarrNg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9JnJMn_1787237306;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X9JnJMn_1787237306 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 20 Aug 2026 22:48:39 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: baolu.lu@linux.intel.com
Cc: dwmw2@infradead.org,
	guanghuifeng@linux.alibaba.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org,
	"bikuan . zbk" <bikuan.zbk@alibaba-inc.com>
Subject: [PATCH] iommu/vt-d: Fix IQE handling to cover all descriptors in submission range
Date: Thu, 20 Aug 2026 22:47:41 +0800
Message-ID: <20260820144741.920858-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <06975717-677b-4c81-8c74-63d42b335db7@linux.intel.com>
References: <06975717-677b-4c81-8c74-63d42b335db7@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, qi_check_fault() only handles IQE (Invalidation Queue Error)
when the faulting descriptor index exactly matches the first descriptor
of the current submission (head == index). This is too restrictive in
multi-descriptor submissions where the error could occur at any
descriptor within the batch.

If the IQE is triggered by a descriptor that belongs to the current
submission but is not at the starting index, the function returns 0
without clearing the IQE fault status. Since hardware stops fetching
new descriptors until IQE is cleared, this leads to an indefinite wait
on the wait descriptor completion - effectively a deadlock.

Fix this by expanding the IQE handling condition to cover all descriptors
within the circular range [index, wait_index]. Use explicit bounds
checking that properly handles the wrap-around case of the circular
queue.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Signed-off-by: bikuan.zbk <bikuan.zbk@alibaba-inc.com>
---
 drivers/iommu/intel/dmar.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ba675b08cd20..ecc95af06f61 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1366,8 +1366,21 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 	 * is cleared.
 	 */
 	if (fault & DMA_FSTS_IQE) {
+		int head_idx;
+
 		head = readl(iommu->reg + DMAR_IQH_REG);
-		if ((head >> shift) == index) {
+		head_idx = head >> shift;
+
+		/*
+		 * The faulting descriptor can be anywhere within the current
+		 * submission's range [index, wait_index]. Since the queue is
+		 * circular, this submission may wrap around QI_LENGTH
+		 * (index > wait_index in that case), so check both the
+		 * non-wrapped and wrapped cases of the range.
+		 */ 
+		if (index <= wait_index ?
+		    (head_idx >= index && head_idx <= wait_index) :
+		    (head_idx >= index || head_idx <= wait_index)) {
 			struct qi_desc *desc = qi->desc + head;
 
 			/*
-- 
2.43.7

