Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ED942FCBA
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811745; cv=none; b=qC7y/A7aQant2eguxxIQk4hyIWc4lD5k4K4lNl6uJWbDh8uVF+BcfF/dVtozbfvj9fD5XuajrIphu5mmqkf4dZPQCzKFmw6BE/07icqvu8M7BQJVWUV/be0IqXtTLx/lR89fLVWNUyyDiilaNLNgF9jgx3luGbKeoBSAFl1eCD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811745; c=relaxed/simple;
	bh=0hEoNuRKl+qs3eW7LpOd8AxqJYyeaodBDnjTITybW1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmsCW98HXpZ6ndcSyUVb4Dyzu4zcF4/Wp/C6mmTMy1bhGfW9JOmztXUa+6NJjtObx9iTj7XK+A8TbHNnOvQM0XfduEnXMeXn4jBR+Z/m2xUuIei66VaxuBJmL3eAtkwuycFQFOzTdH/2dxIJ+SPj9EzsL+Mpp31lhjCdjdzZkUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZEVaGkb2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZEVaGkb2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811744; x=1817347744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0hEoNuRKl+qs3eW7LpOd8AxqJYyeaodBDnjTITybW1k=;
  b=ZEVaGkb2zJEuj8Qm565xll8yDduH3BtZoB0TeB3GFtHacsnBhQhkAzwB
   MSQqydtLo7pIxBozk6b0kvgFnELvMFir9UOrsjSFLkJJEkjfG723B4tv5
   rjhDzF42P70I6Ga/nMd19wAMBRo6p6Bq52H4mDxRFLnEw6n8Hzb5KbqnI
   C9IfPDkDJ9H1xyaj2c8xS3iL7QANWSbszbCkhZjNBT74cmSfP01ccSrrx
   jFLmLX/Syr4uCRQxTaNE0NcgjQcjJ4X/M5JJfZPApg281K4wcgvk7dBqL
   IWXeQsHI3azjPqURiA927rfZakEQ7ekuvDHOq9iDSQcmE56IBWUWjWx9D
   A==;
X-CSE-ConnectionGUID: GcF9aa7rTtGTK7vT58LPLQ==
X-CSE-MsgGUID: B6kf+cpgRn6ouYaposInDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231379"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231379"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:49:04 -0700
X-CSE-ConnectionGUID: 7EdnSyraSOyqfLcAIsHl1w==
X-CSE-MsgGUID: SAhFNJ2xRsa9FUNkbG9Zlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587632"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:49:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] iommu/vt-d: Fix iopf_refcount leak on RID domain replacement
Date: Tue,  4 Aug 2026 10:37:12 +0800
Message-ID: <20260804023714.3080506-19-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_iommu_attach_device() enables IOPF for the new domain but never
disables it for the old one.  device_block_translation(), called at the
start of the function, tears down translation but does not touch any IOPF
state; blocking_domain_attach_dev() has to call iopf_for_domain_remove()
explicitly before invoking it for exactly this reason.

identity_domain_attach_dev() has the same problem.  Its comment claims
that no PRI handling is needed because the device has been put in the
blocking state, but the blocking state and the IOPF reference count are
independent of each other.

As a result, replacing a domain that has an iopf_handler with another
domain at RID level leaks a reference in info->iopf_refcount.  The count
never drops back to zero, so iopf_queue_remove_device() is never called
and iommu_disable_pci_pri() triggers its WARN_ON(info->iopf_refcount)
when the device is released.

The PASID paths already handle this correctly by way of
iopf_for_domain_replace(); convert the two RID paths to do the same.
Using the replace helper rather than a bare remove keeps the enable
before the disable, so the reference count does not transiently reach
zero and evict the device from the IOPF queue.

Fixes: 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach path")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260602233426.357499-1-baolu.lu%40linux.intel.com
Assisted-by: Claude:claude-opus-5
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 000b81cf4a7a..9003783d02bc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3152,13 +3152,13 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	ret = iopf_for_domain_set(domain, dev);
+	ret = iopf_for_domain_replace(domain, old, dev);
 	if (ret)
 		return ret;
 
 	ret = dmar_domain_attach_device(to_dmar_domain(domain), dev);
 	if (ret)
-		iopf_for_domain_remove(domain, dev);
+		iopf_for_domain_replace(old, domain, dev);
 
 	return ret;
 }
@@ -3861,10 +3861,13 @@ static int identity_domain_attach_dev(struct iommu_domain *domain,
 		return 0;
 
 	/*
-	 * No PRI support with the global identity domain. No need to enable or
-	 * disable PRI in this path as the iommu has been put in the blocking
-	 * state.
+	 * The identity domain has no iopf_handler, so no IOPF reference is
+	 * taken for it.  The reference held by the old domain must still be
+	 * released here; putting the device in the blocking state above does
+	 * not affect the IOPF reference count.
 	 */
+	iopf_for_domain_remove(old, dev);
+
 	if (sm_supported(iommu))
 		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
 	else
-- 
2.43.0

