Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C58F3B19B4
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321344; cv=none; b=Ep3E1aLIZzP9tF9CKNCngPLTVFOcvOeRT32HctfCIFDpovFLLeWL2SwXI1DLRpFlAA4IUNiLkdFOFFzRMLK7wmpm6yfYt49RBWlfqgwTsvue0j7BCNJf2psA0oQ8U9BT5w69KEcLhbolsL7hoC7hSh1UDSWclayua87uIkuGfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321344; c=relaxed/simple;
	bh=auMnztirMjgLsVdaqQpnSuNWy8GRXz3WqB05wPcZf6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g0oTaT8wJsN7gTx9JdxOm0bKAuj4Ch5DTZ05ONZToVvpVEU/YGUL3jHWLh6rg1N3hPO5h2BTwF63W0hNXPAT0Fp6G5vrjaqLT2sysmJkl1EvDIKo90R1hymvv2mpLvK604HPVzdUfT/U0OjickRtglCuPU0qDS8VhG2wPQIjQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ibvve3F0; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ibvve3F0"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf08c2a24bso45538255ad.2
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321341; x=1780926141; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7R6BZcslBAGGRXzQms4jp3f5RHV26tlAI7OzQzhdeIE=;
        b=Ibvve3F0Qc9klyxKBqJX1uhNtVFNFpU1QVSSDnkNLXVw0fZTM0H5chd/JcrnPktV8m
         xJdAN2MiQZnKzgupBYynfv9Ber4y5m8hD5kz+N5WyWjCH+furtv3vjR9AqCox5ouyF0l
         ymO/w5VjGI6P1OU/Qh4w49rKWJF4HZtCAcessZAANuOi+tQNXi9asyOgBIc2hGHMBijy
         nkLVzdW48e/yT6zDtuvaInhmViPS501viTCduThwhlzY2vn388OzPDwxIe8S0C4iS9Nj
         j1aYomfbQ5x/L+4ynoTbCW+seRspEi7q/IfH6EKz5XBVIVv92OA+fIjwHXHhOwKF67av
         ruGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321341; x=1780926141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7R6BZcslBAGGRXzQms4jp3f5RHV26tlAI7OzQzhdeIE=;
        b=EFowHFNFJGuHRuAAhjJtp1axl8N6fe735KYcczwQDfBEMrLX6yUa/BvYsgPsWCX+kt
         fJQc0O7JdWELXQsE/W6wBmsB5P4Vlbld9wKWxCW71dhK10urL8D6c7KLZohyRL+xd/BC
         TQjKp6HgYSKlCOwafQDvqfSPJQs8XhQ+5Qrj1BnqTjLOHjQ7/HFU/Sx0R70d04TOXtv/
         pil4mpJRVqDIuCYC0BPxnTJPx511h/1q5TF9ZIzOOvX4afCoWIJ6cj+QXgU+BgBwgdtp
         iVlgVbC1+NCIwu49BnzLuga+dzKhvfJZAfcZK2oplcS1BrGkPxxjl4agWmq27/4H/5gE
         utQg==
X-Gm-Message-State: AOJu0YzgjGhmxkxdYCtQ98puqm100zK/gu/hZeLTijDSvkl4+MKl6GvQ
	163+Elk+doHwWZpIWgU2mALcdXVS+20Nl0k+47eim38u2rWGwrYL3KSuEkAoW7BaTpIbrRk3ljK
	6M1KyvNQ9Vah/QAMyxVgczVj7aDakhJcjel/JcR3T0DXL1k3/ihcIqm2kF3oMupreNF8MvY1GGx
	peSggoQqroZcPESETcGW+N04dd7WWrow==
X-Received: from pgbgc5.prod.google.com ([2002:a05:6a02:4b85:b0:c85:80d8:9229])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8213:b0:3b3:f46:1f0a
 with SMTP id adf61e73a8af0-3b427f5bd3cmr12362565637.42.1780321340582; Mon, 01
 Jun 2026 06:42:20 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:42:03 +0000
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601134204.2150602-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-6-praan@google.com>
Subject: [PATCH 5/6] iommu/amd: Fail probe on ATS configuration failure
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the driver to call pci_prepare_ats() after checking if
pci_ats_supported() and fail the probe_device if pci_prepare_ats()
returns an error. Additionally, update pdev_enable_cap_ats() to WARN_ON()
a failure in pci_enable_ats().

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4ef6024c5a4e..783f53cb8599 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -566,10 +566,17 @@ static inline int pdev_enable_cap_ats(struct pci_dev *pdev)
 	if (amd_iommu_iotlb_sup &&
 	    (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP)) {
 		ret = pci_enable_ats(pdev, PAGE_SHIFT);
-		if (!ret) {
-			dev_data->ats_enabled = 1;
-			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
-		}
+
+		/*
+		 * pci_enable_ats() should not fail here because earlier
+		 * checks have already verified support & config.
+		 */
+		if (WARN_ON(ret))
+			return ret;
+
+		dev_data->ats_enabled = 1;
+		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
+		ret = 0;
 	}
 
 	return ret;
@@ -2514,8 +2521,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	else
 		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
 
-	if (dev_is_pci(dev))
-		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		if (pci_ats_supported(pdev)) {
+			ret = pci_prepare_ats(pdev, PAGE_SHIFT);
+			if (ret) {
+				iommu_dev = ERR_PTR(ret);
+				goto out_err;
+			}
+		}
+	}
 
 	return iommu_dev;
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

