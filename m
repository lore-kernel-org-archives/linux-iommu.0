Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0533D813F
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054457; cv=none; b=jllCMAqtng0QWWX31DEtb/sHJtzqBw0z6wg73+dg7TOx+JVRYxnTD6M51IId2lAplTsc9QUwI5/j4rqrx4pTAx2AchDNpyFtAJXuO2FCzNi43xuQ5xKd0Nq1Rgu8gAAMQPnLkYRhTprAAKJXNvoyveyPHMKtL7dFUlZ6oe2lus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054457; c=relaxed/simple;
	bh=FWe+zkG6d1dSp2BnJpzvZr07OMSiwnHIAa4IQItE6Ig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A4SrbBf11RyTSbJZ7tL8p4kCww0rXZpHR2Ohrojud8sRg4RfaziufLmB6Veup3TzvY8fKcsKQXZ3acjltH56Pt2HmEEx5XzYA2GCHpFvlfXDzMYkH2XAfQ0BWag6/uKW73lOOuLHQRlWWdR97K6t2LLsxXzKYcTeKkPWcAoZWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DA0e2j9+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DA0e2j9+"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc7f9b2213so102907255ad.0
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780054455; x=1780659255; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWXlHKTSa6jbTlPQqXflZFEjWNMHtxbOFAcz50SUsYQ=;
        b=DA0e2j9+qTpYza431/oxgGXgBUpxu6yVzov2jUdsfAA0s9hgxxvtPVSIn8sznsDck2
         JmRHQ6jf8V9H4E0VA6LBXHSvsTTB8+5yn/38fO90OCVa3JvbRCc2B3nj0lTGfCA6jX+m
         JYcRkoUF7ciqrG33/N3sJyliwa0QZRSjHvqrJLdAWWYV83PhjhSYzo116hsJNKye5tG0
         vRbEwSM0p9ucdpTnwxPsOPScXlRVmKVfsifAFkp/58tCziOoUpsASKtFvOkDfH4eGocR
         8LE6z4/A/84VvNXHziBTgDywN9fwxSf0b0LOjtpwYK39Zb/UVX4d9YYmJK9+lk7LDqCC
         32gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780054455; x=1780659255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWXlHKTSa6jbTlPQqXflZFEjWNMHtxbOFAcz50SUsYQ=;
        b=GWZz6uubvjLnoai3g2XjJzNDWYKBd4my4Q2ye3Q/0+JXKQGFyI0HaBywS2F3icSBGE
         QrvBsKO87eoBqMos+kMGpTJIl4t+rUsN1XL3XQdjhEr/lIG8SyeWLA3vyp5kcvXc6+x3
         rdu6L79BKWfyL6CGglA2q1zRm970L6RxRfrNOD+rb1dBG1Qi3ff+umAdbg+Ng0Nc33CM
         PZFPYRf1IP4+4V1EZOYK4vI37lSK5KoR0hRgCf+XOpG7D+K9VPgCEBGk8moFCbiBunTt
         sDA8KIy3InKlqiGTmYALW7DL1BpfnBr26avm77OA9NEuKIyXQs9xqUtD7RugZBtksNmw
         qE9A==
X-Gm-Message-State: AOJu0Yy8Z3sths22PcMM+jnlV4zfdpyiiRk96GRN50ogOD1rZBze3AgX
	r+7MLNs6MILn/HKGstAf9XZgfPV2EbgZEIw+eTouytd2qNPDUTLDkQ91pU1gRRzkap8/qPp6Adl
	wvk0xEVUdCIlxVCK2k5B7WGdu0uM/m+PEdLYcOWzBddgldETuNJvhEJ0BFysFX/sC+uDqPbDdnN
	J0lwur5JxioLM/XG6bV+vW9P1srAzoIg==
X-Received: from pllg4.prod.google.com ([2002:a17:902:7404:b0:2ba:3f4e:3d6])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c9:b0:2bf:11ed:3d64
 with SMTP id d9443c01a7336-2bf2098181cmr34231215ad.18.1780054454473; Fri, 29
 May 2026 04:34:14 -0700 (PDT)
Date: Fri, 29 May 2026 11:34:09 +0000
In-Reply-To: <20260529113410.491538-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529113410.491538-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529113410.491538-2-praan@google.com>
Subject: [PATCH 1/2] iommu/vt-d: Fix RB-tree corruption in probe error path
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

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
---
 drivers/iommu/intel/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c3d18cd77d2f..2702e9aa2241 100644
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
2.54.0.823.g6e5bcc1fc9-goog

