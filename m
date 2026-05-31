Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12243914ED
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246981; cv=none; b=t7Y9ktaHJ9i2olchTv+ssVrzNYhcqw3zWjmSkMJUhyGJ/UI0Euyd7ncfaAcmIclRtTcUbcIRGZfdU5PBgGm8CKeNq4Dxjya1e38Q1Z2ydTzvk8lAtXQ2KKWw5gf19ipRSzAdXyZbBju5rKxS4hiEZ8UQmBwfrqpjeh/FI6De2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246981; c=relaxed/simple;
	bh=FWe+zkG6d1dSp2BnJpzvZr07OMSiwnHIAa4IQItE6Ig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LoEsAHfx6q8gdPKT33aUyjC5tbzz+AEES2GbTF62PYWGOD+ohtzpsrOIdzkFb6AdKiU7LwvjdbwhpClT76fuzvhRRai+nMIxxrt4UYyYZA0AH3XwMiuwq2afY3z4SDJEdm8Mr3p8T4mvx/YoDeR5iyLrmwyQS6KUGfsF+X9RF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOSx1p2X; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOSx1p2X"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c272e532so6551385ad.1
        for <iommu@lists.linux.dev>; Sun, 31 May 2026 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780246980; x=1780851780; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWXlHKTSa6jbTlPQqXflZFEjWNMHtxbOFAcz50SUsYQ=;
        b=pOSx1p2XGriWVtjwLoYWdxhW9WTO3yrgKCNJJcc6rj+KoldokNQWWgChnug5/telDl
         BuMEjk4P/ADDIn1I/bDnIP52+jqt5zoE4bH/1ZWt5YXjB6PSZRNDTGxRQaoNdbEiRqQA
         tMOLWiwBoggX9hfMP25I5uC7gOfiDwE6lth6jadzTppeROPyHsb4+lriIrwLDr/F9W86
         vmxoFX8zP5qeA+4FOAzrAg6+3Hr5r0gqLjjjx7V9itf7Px5pkBob+pg21Fo607G+mFBS
         dvPh7W2Ho8RliR/zyklq8poCzivE5SyqPVQybaOC1PkfWmx8AC0ddjw0T27saULNfvlg
         skhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780246980; x=1780851780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWXlHKTSa6jbTlPQqXflZFEjWNMHtxbOFAcz50SUsYQ=;
        b=qUMP9inbuG3QZmL/MaVN/JxSkzB4RrXrNZofofd4hbz1Hn0KfemobIhU1FFQlgGrPj
         uzojJjBva0L+9JB2BcAXtIdJABDS1U7Z6xqRmTH3+bNc6+1tJ2CjTambEHwtZfNmd6RG
         hz+gvc6sv8WGA3CaURNOBGgE7G46f2t38c8LTtptVCXTaZ2gLbwPmpkC3bDgyeAgDE4F
         bQAvlyUaiOvYftdQxw/M070txrkRSiwNf0QaZxSBYe5OxudLSTbAVP3edZPnSFF2aBw5
         89SGFzBFs3m5TqFZvytwcOYy8ynRjd/iwQn2d0b18b5Qm2bl359ToONOvcBcDrSwsUcK
         aSoA==
X-Gm-Message-State: AOJu0Yw7ef7vGJMWYawnLl9VeuUhbCMt26dzfD3EDb7NzkX/xVbwDBmy
	Wng2djhfSiWUCpQ7egGdyPdo3/96AJxMT8Ijcvtjp+l6KQQceT24PaWp9+Bw+ax21ZqRzZgM0z6
	ER+AkHEdKQ2/poT8tDSf7M0Q61svq2wJDBhbgo/yM742Y+8GUV7vRXLhbIMg0clr8NbyZUf2qkU
	PsCbuSsUEspzqp0Pqfe5TCH8xP5n9Dsg==
X-Received: from plqu18.prod.google.com ([2002:a17:902:a612:b0:2c0:b770:dccc])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccc8:b0:2bd:ba44:6c07
 with SMTP id d9443c01a7336-2bf367f292cmr78806815ad.16.1780246979738; Sun, 31
 May 2026 10:02:59 -0700 (PDT)
Date: Sun, 31 May 2026 17:02:53 +0000
In-Reply-To: <20260531170254.60493-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260531170254.60493-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531170254.60493-2-praan@google.com>
Subject: [PATCH v2 1/2] iommu/vt-d: Fix RB-tree corruption in probe error path
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

