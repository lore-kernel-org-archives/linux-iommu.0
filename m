Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A35360EE4
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780443417; cv=none; b=S9yL8XWOUn172xNEEtFWaCClfWM8arSjhmzfgMNDYr5fP4iPP+CWPHwlfu6u+TxC+9HEQPumN8YYq4ENxHbq+9tvLaSHkFoG1fZ84tHghmxseT9rSAX/Tw161XcmBfPdQUghSfAumfyIBY1HIKQ09fvmudkarLDe15ROQWS6ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780443417; c=relaxed/simple;
	bh=D3dEDDoT3aHbpPxK4hEFaV8P3ei5CFxGflWpK+in12E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SY4IdO5Kl0Ezdbu4x5nJcRB7/ZJspAf0WEgMidHlpzNU7tXJnePztwZdpWF0QdssTEob48abU/9DO+KIeZZq0LnVFwBhXo5Mk3+QbSUoifNru8EXCtfudKoUSjbJG+sPV5RXcJGVp7/SYXPng0736rwQXp9H4u3Ff4B+RFlEFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2PZkQ4L; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2PZkQ4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780443416; x=1811979416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D3dEDDoT3aHbpPxK4hEFaV8P3ei5CFxGflWpK+in12E=;
  b=D2PZkQ4LphsznuIIu24I6gUmYxuvGnZxPGMPrIfzPtzcUpgqnMIoNAvQ
   E1NyYj5aHlilLuShdRLtmMf9XpIKMav1ZJa7hFnMyn116Cunm1VKTHqfN
   ovHQ/Bu5sM4rzskglNZaLE5mjQ+294LHhgRLA9T2nHUMJNsUrr2CUF+dG
   1KYbcpgUVybGH7UNuwO3EP+5g/WeeCtfcDyb6xwERTHzcBFU2wQyvPPMo
   DNrdPa45yRyItrN9hDiT7Udc+WWlDWmCXLMmYsIZHSCAElTqkCL77gGeK
   oN/Tw2L6kLsW+RFB/7HrvAYsN3sZDHxQV8nTmESbXRvG6b3GOcGVlskQi
   Q==;
X-CSE-ConnectionGUID: CVWVsVLqRGOe9ZiVfWTyJw==
X-CSE-MsgGUID: j3gzgcqqRS61+0Wp0TdUEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81369752"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81369752"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 16:36:56 -0700
X-CSE-ConnectionGUID: eKaYI7brR8CKdgpaLEDASA==
X-CSE-MsgGUID: iiwI3scHSD+DxXDfdPpmsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="241068755"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 02 Jun 2026 16:36:54 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] iommu/vt-d: Fix RB-tree corruption in probe error path
Date: Wed,  3 Jun 2026 07:34:24 +0800
Message-ID: <20260602233426.357499-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602233426.357499-1-baolu.lu@linux.intel.com>
References: <20260602233426.357499-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pranjal Shrivastava <praan@google.com>

The info->node RB-tree member is zero-initialized via kzalloc. If
a device does not support ATS, the device_rbtree_insert() call is
skipped. If a subsequent probe step fails, the error path jumps to
device_rbtree_remove(), which misinterprets the zeroed node as
a tree root and corrupts the device RB-tree.

Fix this by explicitly initializing the RB-node as empty using
RB_CLEAR_NODE() during initialization and guarding the removal with
RB_EMPTY_NODE().

Fixes: 4f1492efb495 ("iommu/vt-d: Revert ATS timing change to fix boot failure")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260525205628.CD4431F000E9@smtp.kernel.org/
Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
Link: https://lore.kernel.org/r/20260531170254.60493-2-praan@google.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..849d06dfe1ae 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -157,7 +157,10 @@ static void device_rbtree_remove(struct device_domain_info *info)
 	unsigned long flags;
 
 	spin_lock_irqsave(&iommu->device_rbtree_lock, flags);
-	rb_erase(&info->node, &iommu->device_rbtree);
+	if (!RB_EMPTY_NODE(&info->node)) {
+		rb_erase(&info->node, &iommu->device_rbtree);
+		RB_CLEAR_NODE(&info->node);
+	}
 	spin_unlock_irqrestore(&iommu->device_rbtree_lock, flags);
 }
 
@@ -3254,6 +3257,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	info->dev = dev;
 	info->iommu = iommu;
+	RB_CLEAR_NODE(&info->node);
 	if (dev_is_pci(dev)) {
 		if (ecap_dev_iotlb_support(iommu->ecap) &&
 		    pci_ats_supported(pdev) &&
-- 
2.43.0

