Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7026B96A
	for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255392; cv=none; b=sUeagNzxDxJmMAoCOhfTtMsdHQLHkL8WaOAu1MYeO5g43+6320Tb2YWYudPaNT09Gf/GFs+92Iv/57n/qOIkJmMZuD6lKBXSlr3JadOLZTE4qlm1OoAkmt5Mjb0R1ow2/Ua8GuEY4/QC1NiDvlRltkYdq0qVgzyB2gJIhtk39YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255392; c=relaxed/simple;
	bh=IcWzJQHLqQkYIL3cX6VQmN0GELUf+4nTg2JHGzLpqGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pze3Z3QAiEOr6IIeZsmIYKa4ZCISqD+UoADxaqjcxZFEjBQpQB51qJ9jkLvUGv6sKa8ELOyOppPG77+gKWjSkJOE1IhYFQchDN0yLKGGYdXAAyevyk2NIzTTkhW2Z2cQOU/aXXBj7IFhHqASVMeUF/hK1Vtle4LNSCWELGgXMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdaUWKW+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdaUWKW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753255392; x=1784791392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IcWzJQHLqQkYIL3cX6VQmN0GELUf+4nTg2JHGzLpqGs=;
  b=RdaUWKW+A1mrOxXkYL56vI8JJsJo+MTgjcN6QvvUKj54pYW4EJK9scmQ
   urzZetbqDJvdJZ/TwHu7pXS0Vt16mMBpPJNe1IgBd2n6Dri3+XMC8VpG4
   j3RXgWHrdqmdDZWNFsyyV7CfQ1YNBd9FyWL+K0tz7adQGOkKZgleLWYXb
   BDEV6JCxz9C/CxmsX7FotrOBRva5TnUjqmxgS8r2HSHXoEpzwgoyYE6+U
   6N6cTDDmRXh2WpNw+RLWj46iHb19OiFu1ecVsS3xwulfJoxuHdZ3dx7z+
   JQugVHXkTWP1uIHe4vTih9Xi6+B3WoFtbM3X25RptWtc+2N6wghrO5OEp
   Q==;
X-CSE-ConnectionGUID: OLn3NPwQRt+i4tWwyrzMBQ==
X-CSE-MsgGUID: 3f3pafdsQmmGMMlCqkkaMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55680922"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55680922"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 00:23:11 -0700
X-CSE-ConnectionGUID: fEVuD6JvTUq44MKe8IPqWg==
X-CSE-MsgGUID: So4t9iT8T0iiU3uXZ6bsNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159018255"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 23 Jul 2025 00:23:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Ethan Milon <ethan.milon@eviden.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix UAF on sva unbind with pending IOPFs
Date: Wed, 23 Jul 2025 15:20:45 +0800
Message-ID: <20250723072045.1853328-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach
path") disables IOPF on device by removing the device from its IOMMU's
IOPF queue when the last IOPF-capable domain is detached from the device.
Unfortunately, it did this in a wrong place where there are still pending
IOPFs. As a result, a use-after-free error is potentially triggered and
eventually a kernel panic with a kernel trace similar to the following:

 refcount_t: underflow; use-after-free.
 WARNING: CPU: 3 PID: 313 at lib/refcount.c:28 refcount_warn_saturate+0xd8/0xe0
 Workqueue: iopf_queue/dmar0-iopfq iommu_sva_handle_iopf
 Call Trace:
   <TASK>
   iopf_free_group+0xe/0x20
   process_one_work+0x197/0x3d0
   worker_thread+0x23a/0x350
   ? rescuer_thread+0x4a0/0x4a0
   kthread+0xf8/0x230
   ? finish_task_switch.isra.0+0x81/0x260
   ? kthreads_online_cpu+0x110/0x110
   ? kthreads_online_cpu+0x110/0x110
   ret_from_fork+0x13b/0x170
   ? kthreads_online_cpu+0x110/0x110
   ret_from_fork_asm+0x11/0x20
   </TASK>
  ---[ end trace 0000000000000000 ]---

The intel_pasid_tear_down_entry() function is responsible for blocking
hardware from generating new page faults and flushing all in-flight
ones. Therefore, moving iopf_for_domain_remove() after this function
should resolve this.

Fixes: 17fce9d2336d ("iommu/vt-d: Put iopf enablement in domain attach path")
Reported-by: Ethan Milon <ethan.milon@eviden.com>
Closes: https://lore.kernel.org/r/e8b37f3e-8539-40d4-8993-43a1f3ffe5aa@eviden.com
Suggested-by: Ethan Milon <ethan.milon@eviden.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7c64d88ece77..82b0cec240de 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4081,8 +4081,8 @@ static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
-	iopf_for_domain_remove(old, dev);
 	intel_pasid_tear_down_entry(info->iommu, dev, pasid, false);
+	iopf_for_domain_remove(old, dev);
 	domain_remove_dev_pasid(old, dev, pasid);
 
 	return 0;
-- 
2.43.0

