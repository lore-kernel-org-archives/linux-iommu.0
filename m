Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C53EDE6B
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397240; cv=none; b=Rmzexcjo6gVvzai5wqL2H0YSHdUlRHUqCXyc12rR3b1cXC+TWPIQW3yL/spXPSVJqCunQGS9QAH3nixw4Q76yYWNLlZVCJXm50rz2Rs3vOTkHnxdJx8sHnEEuUFRuMQRMfFPJ5vi6S0TP0cuLs6BnOmS1z9QHy/QneSqFMjDslQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397240; c=relaxed/simple;
	bh=W2loNsplm/62WAbgEnrp4IWnKkCdhr3ty+a5gaQMTJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYdX72ZDvfmhoN3gSP4yYCjR73mHS4fR0RKcs759tyJeKX3vaRt8h4i5jo3tg2fhI7vKGvWMzTGt8Ev0xj096H82baqFDMCWtuO8S6GZWTfCTkof5kVgfnZcpVylv3FJnFtSqYrh2g548YpW26PxYF367f5OKE0T1CiWP48gbJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=liFEEm3D; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="liFEEm3D"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780397235; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dloNw3khkYFpZ8HUOkLSEFcKW6J/1PykK/kcWicIG90=;
	b=liFEEm3DLA5RcSaKTLq0axu7O5SCFWtUIo9GonM5PoFvjpxdjN5aDXUcYFGVGRcY3qMM4nH6KcEy59UIOqAEEgWW9PH41ff87i4uZeuEHciUxr/hMeLWHKe5H33Xa336NKIf2KYBa/wGlildD04wzX6F/TT9N5sT64B1YfaSCVg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X44E98l_1780397232;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X44E98l_1780397232 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 18:47:13 +0800
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
Subject: [PATCH v2 25/30] drm/panthor: switch to iova_to_phys_length
Date: Tue,  2 Jun 2026 18:46:32 +0800
Message-ID: <20260602104637.1219810-26-guanghuifeng@linux.alibaba.com>
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

