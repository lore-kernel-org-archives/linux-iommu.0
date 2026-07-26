Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBEF3368B1
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051825; cv=none; b=P1fEiGXgr6fPreMrIEwE/Jol/SgVsYhE0Q8aNWz/4FQ3YLh7jyiT6JpBh+tE7PTForkoiaMsiHlo2rupAD0Bu7V/d99YRX701Mf5TJI/GG+ZlwHvYjWYd6iUGDZxaP6rOBuqeKkycRvpjd7uyMu65fJwBeHeeT9BcKOfM4HcMLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051825; c=relaxed/simple;
	bh=ydC2rTTjyXl40OYqt9rJJInqhDLP1hgTOTEZq9X5yqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aIdKxOXMqEpw/M9mnY80mhiz1lXhMc1wZ6XYLPDJ8h2LPyGwfVK+VYokGZrWmdd9XWWpAHrIGh+dcdMsOkibz1DgL3aevyRGq7eWj+epMgCpykgisehGuoPXx3Szmv4q+EkHip0oiF7QBZe5Iw2lnajq101UzAg/NAeS8ES6x8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j8AtCJhH; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j8AtCJhH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785051819; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+l0zOmO7Vj/1A4auYOFAEN7qrUOdsdK+EoD2ERx3MQU=;
	b=j8AtCJhHB6p7fs3aWEgpQ1PWNIzLCiDh9RCthJ1dtBVuv9SbdValQBC2UQ48N1NJF2duDoqxlO+zGAXtADzNIyng/vFCVP2hUZssBTGu7NQ9CL4YkmHL3GZjPnGaocQy/G1JD4GiZP7qnXTCXeXAMSRJEXsCTwKdB68cxj+cUGI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X7n2nAO_1785051818;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X7n2nAO_1785051818 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 26 Jul 2026 15:43:38 +0800
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
Subject: [PATCH 3/4] iommufd: Release current IOAS on xa_store() failure
Date: Sun, 26 Jul 2026 15:43:31 +0800
Message-Id: <ff7c1b0d1ad84b2896271f84f11054ee8a86a82a.1785050951.git.xueshuai@linux.alibaba.com>
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

iommufd_take_all_iova_rwsem() takes an object reference and the
iova_rwsem write lock before storing the IOAS in the temporary ioas_list
xarray.

If xa_store() fails, the current IOAS has not been inserted into
ioas_list yet. iommufd_release_all_iova_rwsem() only unwinds IOAS
objects already present in that xarray, so it cannot release the current
IOAS.

Release the current IOAS rwsem and object reference before unwinding the
previously stored entries.

Fixes: 051ae5aa73d7 ("iommufd: Lock all IOAS objects")
Cc: stable@vger.kernel.org
Assisted-by: Qoder:Qwen-3.8-MAX-Preview
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/iommu/iommufd/ioas.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index fed06c2b728e..28616465ea6a 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -427,6 +427,8 @@ static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
 
 		rc = xa_err(xa_store(ioas_list, index, ioas, GFP_KERNEL));
 		if (rc) {
+			up_write(&ioas->iopt.iova_rwsem);
+			refcount_dec(&ioas->obj.users);
 			iommufd_release_all_iova_rwsem(ictx, ioas_list);
 			return rc;
 		}
-- 
2.39.3

