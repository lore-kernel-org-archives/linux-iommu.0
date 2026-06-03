Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3448C3F5
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499955; cv=none; b=BSikYE1WyQZ3AcAtFOPn/ilvcpDDEzLt7IcMUz6PSr4bnOONqs1AnGLh9p9GJgr3B8/dliKZmckSR6jGL3tsbXY2zcoNbrRisLp4QAPbkF0tnbGw0a1EZ0Ii8BzxG80iLClTu2vA+ZJPL+CbQ73dDD1/EMepUxIjrEyBowvrvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499955; c=relaxed/simple;
	bh=W2loNsplm/62WAbgEnrp4IWnKkCdhr3ty+a5gaQMTJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYoFlzkJ4Ly+F+aVSyOYD4/HmkA201LQGWcYnEUOX88kWIaV3N/Y+88bWHm17+cBXTdoEaf9mMzXE0Od4jMsGcgJ9LoOJx+OjDHVPMF2kVpI/MHHbZsKbkuJlcC+SCBGryRjONIR6U+GL1diRILZIRPrLOGruYnYHfWezHzPxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QK4rDq95; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QK4rDq95"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780499948; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dloNw3khkYFpZ8HUOkLSEFcKW6J/1PykK/kcWicIG90=;
	b=QK4rDq956aZlbprwsmi3ijhiNYLEnUSt6zIvLFBNnxcclcuPqifnsMKMQ+xop+MjN9aApkRjYxhRRhHQLbk/3TQtlJ/1a0Kq5o38dBbXV3Im7pAwYJElCoLT04OoXqbrIx6881AUhCg9lFRDs5CxGk3tGRQdA5WF4JSa4OaqQb4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X47fR7b_1780499945;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X47fR7b_1780499945 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 23:19:05 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: adrian.larumbe@collabora.com,
	airlied@gmail.com,
	alex@shazbot.org,
	alikernel-developer@linux.alibaba.com,
	baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
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
Subject: [PATCH v3 27/32] drm/panthor: switch to iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:59 +0800
Message-ID: <20260603151804.1963871-28-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate panthor_mmu to use ops->iova_to_phys_length(ops, iova, NULL)
instead of the deprecated ops->iova_to_phys.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 75d98dad7b1d..3b635fc1f651 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -903,7 +903,7 @@ static void panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
 			 * are out-of-sync. This is not supposed to happen, hence the
 			 * above WARN_ON().
 			 */
-			while (!ops->iova_to_phys(ops, iova + unmapped_sz) &&
+			while (ops->iova_to_phys_length(ops, iova + unmapped_sz, NULL) == PHYS_ADDR_MAX &&
 			       unmapped_sz < pgsize * pgcount)
 				unmapped_sz += SZ_4K;
 
-- 
2.43.7

