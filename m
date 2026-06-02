Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7343D9DA6
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397241; cv=none; b=A7Tcry2IEBKc71ZEsNVQ5NjJZ+d/KCmIKtTJ92KTn2EJSTkf39foRLDL7NA7CC2YObaA3Gx39UZrO84gddTVk/w6Mu8fSKuPLz0LoTqRa21vheuzBzoDB7Bj5IBxtB2J+/U80chXoSlljB617PmqNlz7St2/tJu4ICA2Whh0DqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397241; c=relaxed/simple;
	bh=lI3x7qiBpStf7+riMLkavf19/hS8Q6Sn6QyC7laDlJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idFdPeTqMEzq1sv7IjcBj/vsV8UHO1+x8yg0C3P84xHsWbmLNAWEjiqo4nFhs2JCcHjoqt1ml4NN/GPsJz6LM2q5gJRVfSV/xCDjSXsUkESBC0KFMURI1I3wWiWAo0/fA77o6r0pTIEQdja27DFtxNer4xzyEUchSBtTsOv+EDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cARLhbUE; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cARLhbUE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397236; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FtoAZ4ObIrgN8RB/Z4MrgWEyJCArPPBpz4yofnEwwtU=;
	b=cARLhbUEDHW8HzSoTo1RpHxukxpFCaDCXs1HO1YjokxCMmyEhvzEnR2ZWLWlhmxImtI+5v/qFtLHK6RZrFmgfuRsCLPWo55eLEE1tZ73n7lvHoZ+NmUHDxKs7SErZrMZgUrM2iS0VV0Q8c8bELD7KNr870s/kyL2ZxIfwl0hNKk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E98Q_1780397231;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E98Q_1780397231 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:12 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: adrian.larumbe@collabora.com,
	airlied@gmail.com,
	alex@shazbot.org,
	baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	oliver.yang@linux.alibaba.com,
	robh@kernel.org,
	robin.murphy@arm.com,
	shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com,
	suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de,
	wei.guo.simon@linux.alibaba.com,
	will@kernel.org,
	xlpang@linux.alibaba.com
Cc: alikernel-developer@linux.alibaba.com
Subject: [PATCH v2 24/30] drm/panfrost: switch to iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:31 +0800
Message-ID: <20260602104637.1219810-25-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate panfrost_mmu to use ops->iova_to_phys_length(ops, iova, NULL)
instead of the deprecated ops->iova_to_phys.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 4a3162c3b659..aa0bc82deaf6 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -514,7 +514,7 @@ void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)
 
 		if (bo->is_heap)
 			pgcount = 1;
-		if (!bo->is_heap || ops->iova_to_phys(ops, iova)) {
+		if (!bo->is_heap || ops->iova_to_phys_length(ops, iova, NULL) != PHYS_ADDR_MAX) {
 			unmapped_page = ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
 			WARN_ON(unmapped_page != pgsize * pgcount);
 		}
-- 
2.43.7

