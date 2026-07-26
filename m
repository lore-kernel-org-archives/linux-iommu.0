Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF541376BD5
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051828; cv=none; b=JT9jesiJDVxaOrJsnDYIiBOzd1oLBl0wKe6uZtT5wAex4b8qOhor6/YAFfr9D/vPLnLOCqjxYHCbXIMM2D72CQSrPEBLFafbVHFTDjSSxf/JmyTwi0UDsgKqpn9etVYjMFbj4xCvvV3c5u/UYgCuYaRSNJ3Nt53bjEMtXu/tw1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051828; c=relaxed/simple;
	bh=6XqjtVwp414ZAhy94z6HfwZiflN5trwvP/Fkg2RXFEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etyv7KD4AOmNljchkCWt7z9iWEK+yk6opdtuOt2GW/2sMe8o6+MPQAdrf5qMfs1O1K2dhYN56MUmN/9JNYRPup2rJwU2TlUFUYJLwyrUqNkI43Y4rRtQftPk4b0/NwoLbWf6niCWL6ABkQsFBJjqC6mjiruJk5MJOCAD4yyshhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z0cRUu1L; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z0cRUu1L"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785051818; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8moZmqRu5BYGMq3UQVS1Pstmg4bZq+N44oPbZJY+cDA=;
	b=Z0cRUu1L2e8eWfSIPTqPyjhgjs6xTm7qxpds9qBjo55tBHBtRC0v3BY1dCIpjVBeX/9DKEdviwTQbc9h2PLUx71hp7snE0+1org5RLdgn+/7qFNN/Wdw8JCPcJxrSIcMCF5/xaufe8q0HZw4tDTAZohy9vhMCyFeP1Yzeh8aKjs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X7n2nAG_1785051817;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X7n2nAG_1785051817 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 26 Jul 2026 15:43:37 +0800
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
Subject: [PATCH 2/4] iommufd: Avoid locking internal accesses during unmap
Date: Sun, 26 Jul 2026 15:43:30 +0800
Message-Id: <e1141361f8850ada55ba4435c5a36b1ccc4eb1a4.1785050951.git.xueshuai@linux.alibaba.com>
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

iommufd_access_notify_unmap() skips internal accesses because they do
not have an external unmap callback to invoke.

However, the current test calls iommufd_lock_obj() before checking
whether the access is internal. If iommufd_lock_obj() succeeds, the loop
then sees the internal access and continues, bypassing the matching
iommufd_put_object() used by the normal unmap path. This leaks the
object reference taken by iommufd_lock_obj().

Check for internal accesses first so skipped entries are never locked.

Fixes: 27b77ea5feaa ("iommufd/access: Bypass access->ops->unmap for internal use")
Cc: stable@vger.kernel.org
Assisted-by: Qoder:Qwen-3.8-MAX-Preview
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/iommu/iommufd/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 170a7005f0bc..e4537db724d5 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1307,8 +1307,8 @@ void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
 
 	xa_lock(&ioas->iopt.access_list);
 	xa_for_each(&ioas->iopt.access_list, index, access) {
-		if (!iommufd_lock_obj(&access->obj) ||
-		    iommufd_access_is_internal(access))
+		if (iommufd_access_is_internal(access) ||
+		    !iommufd_lock_obj(&access->obj))
 			continue;
 		xa_unlock(&ioas->iopt.access_list);
 
-- 
2.39.3

