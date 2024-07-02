Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B919DF46
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925888; cv=none; b=KFnXKY8VCVFxOJ2YHX55nxo4NykvClmc++cJkUDKNQ4Y54jtCNUlr/g22AQlDeH1KssZPThRkql9Ua5bf9kWwT6u1p4RhNxYewJ8188PN5RfUvpRrzGsPvyRvgf9GeGi73oDMLkPxATSo/E3/2zCgQh5/YaEkiMo1u0rkqkrE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925888; c=relaxed/simple;
	bh=+g/siJnzmZoFiX3UTf80ep+rreHDj09IRPBQNzXe1gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DiEH6iImmw84Fwtkqcdp6s7/h6DHGSjVHDTe4YPutSl5CxCKNK1NK0vVwZYIVutsoxlglLChUKoOKUpUHZYkpQRNJsIGgfPXwO16AVhlhGb4urg109AiXT3QBxV4A7BEA+42hL/zHOU8P1/9TWZtuEUpRoiAU7EIsfgmyiY68nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4D3PyWy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4D3PyWy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719925886; x=1751461886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+g/siJnzmZoFiX3UTf80ep+rreHDj09IRPBQNzXe1gw=;
  b=l4D3PyWyVrxuPpvhbZYp+TU9LzjT1JbCbFxWwrz1TXnyrE0VMlf9Jaxo
   1JKD3T/XyR+qbraPIa5kp/q0XJL4SJzvLJ9w3cyzR8MvWN7hdXVMkxZU2
   V+jbZtlYv5K2qXzwBEy5n/L9HJk8oKEwiVnxexjf0ty4+P+tn9qIdfQOf
   KFQE4xZUio4xZCcl7zX6RntDGqQKPJaV+be9vq7f1b0+NbqsY2uug6E4D
   p2g+iSlXu6P+j0K0FsD7OFMfPlETY9YCuYGKrx7UCKcFNjc5Kfq/pRDvX
   YhImGnC+mVeuSnXU/5jCfIrw3YRorAxZvc6UYob+8pggFqc6O0rjM8jb2
   A==;
X-CSE-ConnectionGUID: WzvEcOxiQtC3k01JXrmfBg==
X-CSE-MsgGUID: hF5klsWWS/m2Vfb+vRDDbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27699995"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27699995"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:11:25 -0700
X-CSE-ConnectionGUID: wLdcj0pCSjqrsCSOpmUzDQ==
X-CSE-MsgGUID: /RTKjcrDS4C5AmdTfY00PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50250830"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2024 06:11:23 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] iommu/vt-d: Handle volatile descriptor status read
Date: Tue,  2 Jul 2024 21:08:33 +0800
Message-Id: <20240702130839.108139-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702130839.108139-1-baolu.lu@linux.intel.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Queued invalidation wait descriptor status is volatile in that IOMMU
hardware writes the data upon completion.

Use READ_ONCE() to prevent compiler optimizations which ensures memory
reads every time. As a side effect, READ_ONCE() also enforces strict
types and may add an extra instruction. But it should not have negative
performance impact since we use cpu_relax anyway and the extra time(by
adding an instruction) may allow IOMMU HW request cacheline ownership
easier.

e.g. gcc 12.3
BEFORE:
	81 38 ad de 00 00       cmpl   $0x2,(%rax)

AFTER (with READ_ONCE())
    772f:       8b 00                   mov    (%rax),%eax
    7731:       3d ad de 00 00          cmp    $0x2,%eax
                                        //status data is 32 bit

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20240607173817.3914600-1-jacob.jun.pan@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 304e84949ca7..1c8d3141cb55 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1446,7 +1446,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	 */
 	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
 
-	while (qi->desc_status[wait_index] != QI_DONE) {
+	while (READ_ONCE(qi->desc_status[wait_index]) != QI_DONE) {
 		/*
 		 * We will leave the interrupts disabled, to prevent interrupt
 		 * context to queue another cmd while a cmd is already submitted
-- 
2.34.1

