Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD183DDC5
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999849; cv=none; b=WSAHKQRsPIA8wq8KTCdZmhTVxFrEmujO0v6/CM1j8iK/g/rgRbNTgg19Q26kXBD/hLxoX18OWasmavtW9CLtAQf81TVS1AIKmiK/KdSZv5PWQpJP5QtczwyDQ3EVJpTH8F95kQbt4Pd66AJl13Ytc8x9GU3DFpgsA2uU0jUc7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999849; c=relaxed/simple;
	bh=VfVdmXQxQXa/JgZYgCma2WxLIqTFBKl4v9hiZjMAj/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QSv7gXyFLJORbpSIE3ShWvyjq4G9Uv3q0Ndcj9t6gbi0vj21ntBPFx+7xAReyNBUHYvQJ9GG40BhTQU9iySWaSc3vGLb1m+C58P8hd0JnpsCwOcNcgEWxKNIxVroE+cv6IrqT//JEFRlneZ0MNO/VouA0zkT/yibTAY+NXY7+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7BgZQuG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7BgZQuG"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82ac893940so6598820a12.1
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999846; x=1780604646; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQXNgdZN3cKQ+g08vXrIsLwNysE31EdhoJp0+kzR5Os=;
        b=L7BgZQuGecJvUI4XwVQjKQDuh8+aaO2eadMzawECsb59mtwAFk9wkCzRtYN/YNKZZA
         oC3vtc8Je5cGJl6WKLybSMmOr7CBWaW+UsXqbC1PB4C1szv2eTbcmkziSCjgTjX4317z
         NlXaFg3mvVS604T0ECRYgf7fQYVQdRyqmd3ky3eWvSW6RD4pjXjs9b8sALomBJ7J67ot
         MHCh4JECgb8bQmqqoJr6dFpmOwFioJM8e3w/VRQPzn1oLqcFY/yylxxJY9BIBiGmvhtc
         Zo5fzcfxuVZ/b1hfMZy1nJllat4K92CJfaZbo9iW3v6D9qf4Z5UvvGZaVxlhXar0QTjn
         Jirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999846; x=1780604646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQXNgdZN3cKQ+g08vXrIsLwNysE31EdhoJp0+kzR5Os=;
        b=gyX2tT/C1YWCzRCUIWkvB9nBXDJAap+6gAeB+/k4KALg16J8MfSw/MnJj/muUuI28j
         uqGrS/XIz9ut8RSEzLDsldf/cVbW1D9ySFSr9ADw57bi91/gRToOa6L9MvOwMUKS2SSJ
         R32//id/6q9795xbI1hF1tBNOx/qPYgTsKZ2MbBrMGpWPkZbcMgX5olLeM9VLDQ/GILO
         +D5RHrRi5kVI4z/LybQwY37/RwlTTiiOAvrGSfljc81tTG2xD+yH3vTCVfvzwy5sUOM1
         ShyfoOQzwlridKKLUQVh5n3WFM7uSpVoO5JvhBXzwtDkGhu6BLSUR7FpvpoCvMvM7fxn
         rG/Q==
X-Gm-Message-State: AOJu0Yw1R2z5xF+sM6qL+sf3dwaO7yYh/4yQ7bHn9je26sJHwprSswEC
	d430oMoepxv5Rt9x8YiY/cVXfmTIsUna3sG6AV3mJ0pe4IIvI/jTeTVXUAGtRShU6QXDYyF58hL
	rs6T42T3gxf7nk2DtRIa49fRRDcb2M7SDeY2GkF3edejhvnxUAJ/1Pvca8Oy73VogjpTdO+/UbM
	E1Fe1GgVPCzSNeTgX7vpWfuCWH40fkOg==
X-Received: from pgce23.prod.google.com ([2002:a05:6a02:1d7:b0:c85:104d:a751])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a9c:b0:3b3:9815:3e8f
 with SMTP id adf61e73a8af0-3b40e578036mr320728637.24.1779999845986; Thu, 28
 May 2026 13:24:05 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:51 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-6-praan@google.com>
Subject: [PATCH v5 5/7] iommu/vt-d: Fix RB-tree corruption and Use-After-Free
 in probe
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, David Matlack <dmatlack@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

The intel_iommu_probe_device() function contains two pre-existing
memory safety issues on its error path:

1. The info->node RB-tree member is zero-initialized via kzalloc. If
   a device does not support ATS, the device_rbtree_insert() call is
   skipped. If a subsequent probe step fails, the error path jumps to
   device_rbtree_remove(), which misinterprets the zeroed node as
   a tree root and corrupts the device RB-tree.

2. The info structure is freed on failure, but the pointer remains
   linked to the device via dev_iommu_priv_set(). This leads to a
   Use-After-Free regression if the pointer is accessed later.

Fix these by explicitly initializing the RB-node as empty and guarding
its removal. Additionally, ensure dev_iommu_priv_set(dev, NULL) is
called before freeing the info structure in the error path.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260525205628.CD4431F000E9@smtp.kernel.org/
Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/intel/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4d0e65bc131d..ed6d3a0203f5 100644
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
@@ -3316,6 +3320,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 clear_rbtree:
 	device_rbtree_remove(info);
 free:
+	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 
 	return ERR_PTR(ret);
-- 
2.54.0.823.g6e5bcc1fc9-goog

