Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D02432E6A
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811747; cv=none; b=ZnWYSuCmMWXhwtg9uq1UznR5HCa4OngUZvUBLZUubZ6Rwf8P1tZ3USi25JtARtqBFBUpE/lR5QdWPeuD6LYf/3SfplKeV+V7uGBjKaAHCbXQos1BNAPmW8LvvssjB7e7yb0uMhb/Zf1e3EuR6oe5VX95mu+OPKqpBdeBTOoyquE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811747; c=relaxed/simple;
	bh=pnwJe36D1sL/gNEszmY3UecgU2zT9dRDC3/tQgH4P6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mN3USMV6AxvKp6NxE5gfaq+FH158ve2mkIPoqcczjhsqGUHF7skE/5BHOMJlOg6kdQVzDnXJkPxWDeREUfslgHwL0F2fAEgzM8lUFXbiQqwck6gLjI/jSHvIaAu833Iz0+n6qDtMGK1Eu9bZi3BIkg+9iQucU7yaij70FDLZ95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBmy+bKp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBmy+bKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811747; x=1817347747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pnwJe36D1sL/gNEszmY3UecgU2zT9dRDC3/tQgH4P6c=;
  b=KBmy+bKpBAXS+pTOSwLkhqOfKzUGk/CyE0oEhZcZ8tR5vdfMAZUj/3Ve
   cjBUJcsZVfNps/jqpluVWOTP58/SdMGRzswRXN4NdztNORf1qUORBHvIL
   HRqshEy0kSMTKJvNNjnZHD8swKIZtc2Ip9ckUJo0UR94v7QqfjlgGB05r
   BFmhsqEdyaCgrV1A60VsBp3P52kkPjqjKF3vrObQo2gRwdtxYQ95bZrMP
   E1guZM/80hCETp8FqE7xWqDQCoKUqs2ehTGulX+WpUq73tImHkoplczIL
   LKlFcdXjcl7GPh6XbfGWeEoIzpjm69snzVtF63mxYUTlX7b2me7j5mH1F
   w==;
X-CSE-ConnectionGUID: EvNaBmI8QKm6ClW0VPFZpQ==
X-CSE-MsgGUID: ovTyjM2BTZ+WeN9Xr/6Ktw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231388"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231388"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:49:06 -0700
X-CSE-ConnectionGUID: d2ixe8DhRsm+bxtHqPRcVw==
X-CSE-MsgGUID: FtOQCQoqTYaFlF+btNPIQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587644"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:49:04 -0700
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
Subject: [PATCH 19/20] iommu/vt-d: Tear down scalable-mode context on probe failure
Date: Tue,  4 Aug 2026 10:37:13 +0800
Message-ID: <20260804023714.3080506-20-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

intel_pasid_setup_sm_context() walks a PCI device’s DMA aliases via
pci_for_each_dma_alias() and programs a scalable-mode context entry for
each RID. For a device with a dma_alias_mask, the callback is invoked
once for the device’s own RID and once for each alias bit, all with the
same pci_dev, so device_pasid_table_setup() runs for multiple RIDs.

pci_for_each_dma_alias() stops at the first callback error. Therefore, a
failure partway through the walk can leave context entries for already
processed RIDs present and still pointing to the device’s PASID table.

On this error path, intel_iommu_probe_device() currently jumps directly
to intel_pasid_free_table(), which frees the PASID table without
first tearing down those context entries. The IOMMU may then walk a
present context entry whose PASID table pointer references freed
memory.

intel_iommu_release_device() already performs teardown before freeing the
table. Apply the same ordering on the probe failure path.

device_pasid_table_teardown() safely handles RIDs that were never
programmed: iommu_context_addr() returns NULL when no context table has
been allocated, and clearing the Present bit of an already non-present
entry is a no-op. So unwind is safe for both the alias that failed and
any aliases not yet reached.

Fixes: 301f1a80487fd ("iommu/vt-d: Setup scalable mode context entry in probe path")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260602233426.357499-1-baolu.lu%40linux.intel.com
Assisted-by: Claude:claude-opus-5
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9003783d02bc..489bab4999fb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3333,6 +3333,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	return &iommu->iommu;
 free_table:
+	intel_pasid_teardown_sm_context(dev);
 	intel_pasid_free_table(dev);
 clear_rbtree:
 	device_rbtree_remove(info);
-- 
2.43.0

