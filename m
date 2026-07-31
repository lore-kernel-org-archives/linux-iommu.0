Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D221361DB5
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477290; cv=none; b=LW4QdQ5BLCzHSs/sfmo8iyLX+6tAYEeeBAu98dJJfnvqZ8deUpHqu9qHQDR3t9IELpN8a/Si5vCWlrTZbGLt73wvho8LVjWQzNmBgkBUKV67MvtOjirIiFHDLQJrx7T5PJHwSVX2ZTKVEt1oIFXUbYQtJtc6zKzrOOIXeTg/NCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477290; c=relaxed/simple;
	bh=w1DmIJJT/VVqp1LJKvA//Zkogd2iy0ulo2WljJSVg0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goI7w5JH9a7FTRekVXB7chYn8oymCy6A038V20Eu/HBrKTHG9BR8JI3SNHmjo7GlNXWxtK+EpmEfcQd9/pMdeHSADIyjft8rosc/UuRlh/mpcjcMHKoqoBE/73aBnzySQ6LR+nzCydK4lFDNb94mvKbyLnr3yQzcXVVVEyN3+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSPqOwzZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSPqOwzZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785477289; x=1817013289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w1DmIJJT/VVqp1LJKvA//Zkogd2iy0ulo2WljJSVg0g=;
  b=MSPqOwzZH5qCNvA4KqFqn2FfO8hcnAhIjHgQbw+8WVQ8AKTsa+crTE9F
   7d3+pQNhXaYZFlZ0d1XYCkjl+nsrA5X9SXI6a+wxi1QFGOkrz5nZbAYdW
   r8bzsAnd0hu0+V9Ge3RAWOUK4yDGIHHBgHgdcVCdWz6LogwqIT7nJqTNl
   u3DmH7Hz1Svz4hczeF8szXzH7RNp7Zy579cB2+e8TwZuOahHDhZZ/JhXx
   tUHWsLoknTcqx0Uf6ZAGb9HDUYx4v5XLbY89kSlLQb9ZKH8aQ9KcKVCbE
   OkzS9isV92GfjQCbvwZReN5MegwJ9+68D74xxUwKoXak4AZH8lLJKrxOS
   g==;
X-CSE-ConnectionGUID: UrZjiV85RVa/W5hmU2/7TA==
X-CSE-MsgGUID: Gvb9CMc4RQ21puSy4y/npQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="97615898"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="97615898"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 22:54:49 -0700
X-CSE-ConnectionGUID: d24gsISwQROuymQQ562PUg==
X-CSE-MsgGUID: NjXJmz07Sru8bNEAVmDr/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="298695479"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 30 Jul 2026 22:54:47 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 4/5] iommu/vt-d: Tear down scalable-mode context on probe failure
Date: Fri, 31 Jul 2026 13:43:28 +0800
Message-ID: <20260731054329.2948252-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
References: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
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
index 6baf1c075dc9..489e9ab5f698 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3342,6 +3342,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	return &iommu->iommu;
 free_table:
+	intel_pasid_teardown_sm_context(dev);
 	intel_pasid_free_table(dev);
 clear_rbtree:
 	device_rbtree_remove(info);
-- 
2.43.0

