Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB5367B90
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597286; cv=none; b=XZlFcWnvuPNtKasjT5UcBXI6CLw4AXwFcWk/oRoYJRMBztIpcs5NFwFuogVvB0lbnGh64ooLOf05dCv0CUo1alRAHkbVUEq6Q0iLSvUR+d9gI/XieJMeM80QFQON2ZrWzvpUITvivJvJs/z9GJ7PQjSuEMvlyhP4jvUhbwk1xyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597286; c=relaxed/simple;
	bh=Es1v8sdHF6j+zSSIs3uGcU7RSkCWnEMk56BnyfML4Gk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D0Pozynz6ac1yldExw7YKAI8STZJmOZYJyMu/dQ1Y85VPNbjNy09jmwsSHi/V4p+8Qk110iJb4sZs1IFcu+YtY7I78X72vARxtNv5ISJOYbqYcztCdKg/tSksimWPtGCW1ocDnv5rawyt5PYaDBrC7VnrRTaqqkr+VviAIvUtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8R/TBn9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8R/TBn9"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b6f019so1234986a91.2
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780597283; x=1781202083; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xpzlsU/13g3vBsNTBir2ktpGFm/ePGN+o4IZaBkeOg=;
        b=O8R/TBn9+8n0xUinVj5OszUPsQhp2MJUljN9/kzCHq08hJ7a8hr+Q1x7dFZvBkDGSo
         6S5LKpMJSkl6EXI4TTXaktUAbYPsyrQlF/Xwjs+00T/jN/xtAtF/EMjQXhN/CEjBLnro
         rR+yQqSxJ8VrV+hSUUA3MA23lDjW7HQaoa9nz67J2EJ39hNy/kSo1uHGgpFsadTxb7QJ
         S7vPK7vReM0/hCVgPZP701QeKTfG/zxeOZGIF6kMoVhSQiSE3Ej07V9L9VNxGxG3mxUX
         1fVn1vKancG1ufN8Cwvp8opwVujec7GQTndUXZVkdY6bOFU5SEJoam1gtYHeGGVXBJjl
         fSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597283; x=1781202083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xpzlsU/13g3vBsNTBir2ktpGFm/ePGN+o4IZaBkeOg=;
        b=PmBP6vEkOXIJ33qVp2cUAHCxR8j8cuAOClHHfHmI04h+JDka9cETHpfQF3hiGpJpQS
         G0vgw9tqVRYid4IeKmoAhY3YqlRURaN3JzyoL++98TIzc58SaxBZzS/0p6r55KvUSicY
         ZO+5F94R+A+N+jYq7yWHS38qZV9M/xipDvZD90ifNIN09hFWTpMLW2rFNfn5W6wWto7H
         xnZokBFSAmnu8LjnrsKpBtQvrgboJV4sCc3tAMH33c7SNDuRTyxrOCFNYnO1DowmThOl
         MvT2Km3JUZJc8y55v+brUWXzkHkmSdjwchbwWySeeuUo4+YLwOskGyoRv711FzemNTHM
         af0Q==
X-Gm-Message-State: AOJu0Yw1mb/IP2OX/jAospOjMxBHzrrvUB3rcBuPbAWhczRniInmmOBn
	HJzcfQaoHZEXqEEoxC1wrW1AtJJGwqQ3eiKdPjjxL41w6QT2wwgPUCYzGvr2mOrEtIz6h9wAh0z
	YMxV8gNVNGycDo7/Z91O6KZ82s9WdF0g8K5UsvtJOly+iopxdUZai9Qx1yCtHIL54/S00crnYDa
	s1ZfgHPdFnLtlMuwZ+Bq3GHwZc7avhUg==
X-Received: from pjbmd5.prod.google.com ([2002:a17:90b:23c5:b0:36a:f1b9:c389])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b87:b0:368:b01c:85a0
 with SMTP id 98e67ed59e1d1-370f0b54dc0mr99930a91.14.1780597282715; Thu, 04
 Jun 2026 11:21:22 -0700 (PDT)
Date: Thu,  4 Jun 2026 18:21:13 +0000
In-Reply-To: <20260604182116.3179005-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260604182116.3179005-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604182116.3179005-2-praan@google.com>
Subject: [PATCH v8 1/4] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Update pci_ats_supported() to additionally check the associated PF's
status when called on a VF. This ensures that PF-level quirks and
untrusted status are correctly propagated to VFs, providing a robust
support check that aligns with the kernel's PF-centric ATS configuration
model and is immune to the timing of VF-specific fixups.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 96efa00d9743..679a3c3c1d54 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -40,10 +40,13 @@ void pci_ats_init(struct pci_dev *dev)
  */
 bool pci_ats_supported(struct pci_dev *dev)
 {
-	if (!dev->ats_cap)
+	if (!dev->ats_cap || dev->untrusted)
 		return false;
 
-	return (dev->untrusted == 0);
+	if (dev->is_virtfn)
+		return pci_ats_supported(pci_physfn(dev));
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
-- 
2.54.0.1032.g2f8565e1d1-goog

