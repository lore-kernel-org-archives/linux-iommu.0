Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24419066F
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781604; cv=none; b=r8tliAOm9NJxZHRGd4aJ15FmWKppuX8hvZZgWLAWmnakRRJXatWRN2pQcvnBlZHmGl9mP+faJp02blrlz7yYptT5P990I50+eYuDaICd9yfsV93PUoBrr0aLH4Ycf9AdRxeDyrx8rsnYTosa7OsqpilRzJMY3SthhBW60yZo+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781604; c=relaxed/simple;
	bh=DJkQykK9Jx8Er6B2H79K1ibbQjfGa6B7jp8dJp37if8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bh1Ig7b0eaRmb2+bpHoQd69Yl/1tn0uA+sMpdqJ8fbMXVAvX+ngozN54pOmvV74PbnmlNAEBdWqutzOAxzV0rI/x7ZaymxY58D5IH2czLiX07bhUofK9ns16K8QbteDuxZfwQy/yDPzbl+pObcBIr2zQF3vw2wLNRRC+qSVvzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhL/6QVb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhL/6QVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717781603; x=1749317603;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DJkQykK9Jx8Er6B2H79K1ibbQjfGa6B7jp8dJp37if8=;
  b=IhL/6QVbEcHioKcFnbfh+jswziPyN+7X5Pyfkll1PAdBcBUqR7Nm0TgL
   2gt9XOBCBR+CzJgzQ0WUc3Mi3I0/9rPYkIWZac3tsWiEP51bBX6gRgBvO
   txHq1EzZQU/X4598fOAXhUMUhV5C8m+Exz8/xCeGx/CrXrY9zCyyyx+jJ
   CuhHSS/3H75Xo7aYXplBcLncMxVlhUwFBcusLNJmFTwnNSY8kCjv+RdMq
   KcEMgrBsLAtqa2JTna+SY9PxuCIElUR+DUXemeWcZMVm0Zof/n1LUhCuT
   cLdd5/+OF4Am+NQdnhxPC6TYaZiXenSSjsJIXaVUKj0U782pGYcZspfQA
   w==;
X-CSE-ConnectionGUID: VXXRMUXKQLiilR5vEA4Sog==
X-CSE-MsgGUID: GDu+2cYYSbGZJru2BXCnSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="18340860"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="18340860"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 10:33:23 -0700
X-CSE-ConnectionGUID: /8hFgTybQ6WQEnECxLAI0Q==
X-CSE-MsgGUID: x027f1S3ROuFajdE0DBjig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38494227"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa010.fm.intel.com with ESMTP; 07 Jun 2024 10:33:22 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Lu Baolu" <baolu.lu@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	sanjay.k.kumar@intel.com,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Handle volatile descriptor status read
Date: Fri,  7 Jun 2024 10:38:17 -0700
Message-Id: <20240607173817.3914600-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued invalidation wait descriptor status is volatile in that IOMMU hardware
writes the data upon completion.

Use READ_ONCE() to prevent compiler optimizations which ensures memory
reads every time. As a side effect, READ_ONCE() also enforces strict types and
may add an extra instruction. But it should not have negative
performance impact since we use cpu_relax anyway and the extra time(by
adding an instruction) may allow IOMMU HW request cacheline ownership easier.

e.g. gcc 12.3
BEFORE:
	81 38 ad de 00 00       cmpl   $0x2,(%rax)

AFTER (with READ_ONCE())
    772f:       8b 00                   mov    (%rax),%eax
    7731:       3d ad de 00 00          cmp    $0x2,%eax //status data is 32 bit

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
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
2.25.1

