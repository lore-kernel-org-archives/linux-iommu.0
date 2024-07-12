Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13D31A89
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769909; cv=none; b=R5UxHugfLeah2ek09tcAD2zbR8AFO8ZChIRjcutc0pD9IcDWNO8llNu9XTdzQvZ+CefrHv+FMMJlkG76Wjmjqt2d98LoR5ZT8o0hpovnOCHpmebbDU7hIG6iwPT70JPFvUkr8283GiTzZfeOqDm12W44zCOOZh+G2FFRxc1l/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769909; c=relaxed/simple;
	bh=ye7wXbcNIIa89jC4Vj43ONgKIfW4gqaNk0cyyruTMoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iunxkKeOJXmU1kT61Fu9o/wpimuo5zJpeKt8dZpDK61PPYn1Xpn9qizaLqE3oF7+1YCps7/v2+J4kkT5SF6gPjw0W1wZocvuLf83SkoeifKWo4TbWWrdu+0Em1uKGcSKllvZLXo7hTJAFEWw0yHxvddV9BO94zjK/xyK96PLuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JQXye5Ft; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JQXye5Ft"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720769898; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ywK4ki7xtX77OnJnErKp32Ajn4mO+woZuazV6SE+LGc=;
	b=JQXye5Ftc6VgBEm73OVTOiQwBd1btJi/M9itUCCquu+8z8pQKA/wlop8794pDrAHpyjlOTFY0dQ/OiNzfSfiQOg1uHlNhQy0fnu+E6AsXSPgPvd/NeVmio/KItI/Hv2+6YJXnJxzZkw/Sio4eXW8RfkY6MVzt6h88ScbigpeNIA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0WANFw0s_1720769897;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WANFw0s_1720769897)
          by smtp.aliyun-inc.com;
          Fri, 12 Jul 2024 15:38:17 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] swiotlb: Add missing kernel-doc function comments for swiotlb_del_transient
Date: Fri, 12 Jul 2024 15:38:16 +0800
Message-Id: <20240712073816.38772-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-doc style comments for swiotlb_del_transient function.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9513
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/dma/swiotlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b4d8167b2f8d..df68d29740a0 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1500,6 +1500,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr,
  * swiotlb_del_transient() - delete a transient memory pool
  * @dev:	Device which mapped the buffer.
  * @tlb_addr:	Physical address within a bounce buffer.
+ * @pool:       Pointer to the transient memory pool to be checked and deleted.
  *
  * Check whether the address belongs to a transient SWIOTLB memory pool.
  * If yes, then delete the pool.
-- 
2.20.1.7.g153144c

