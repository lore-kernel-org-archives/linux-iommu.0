Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03CE34389C
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999842; cv=none; b=RrYKPi9IaQ3jpm/Hd9kLwMpqmCf2ZZ+wKV6cV2kEeZE7rqNWc3xc90z/RIrS6NCZW2103HFhvo+1Tvyrh1cENYWNG44vhAA4Qsj+vX6ohUtuilQnhOixh4SQn7SAbHWjMzVmcjcHtyni/gv5qE9Jg3SzZT9KXlQdlzFwk9Dv0UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999842; c=relaxed/simple;
	bh=F6ojs5rWNCGgcIvYOOYdZlatLwDA9SzzUTg4lrzHeVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GgJop0tT2OOYnUuW7EIBoP6PxuTkEZnFAU0Thmr+xYA993Y72a+Hdm5hSXRY1slgogOHNRkHUWOyqYaj4P0B014oYE0Ty/vmgYgeKFBC7XR825ctwWvEpTNzYim/2uzgecfo8PEb2X+3vubNNtAW0meZ4VlMZCcw8Wlvu/r9nTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uAFNobzR; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uAFNobzR"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c829366cf25so16842060a12.0
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779999840; x=1780604640; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6562tSqUW4FPLuBReRttsQP9VRgygDGjnIRvKk2fg8=;
        b=uAFNobzR6gsJh1l1KBy9JkTc0ZSngUAQw/af5foCYMYhm9el6Wic1B0T2SaaxzQEdO
         jEpPC+PJZOdnWgOBNLG1xjfNb8daKFw1GNwKwWPsqNOi/t7KGd47jCUh3YahWAM9zcNo
         WQ3F4WJWm7Blwd611BnSgEk26i9MBFeemqHwJ2qNxXDf8EOEH3vgMWQpxqUNhHztyqu5
         2aEn9V3sFrVcAgzMr0lC3tfrTlttr3m0anIHiBL7+AIoWXWvqyU/m/CkKmyj2/Wm6Iwv
         pufTPufxsURAmXlNTaSU9yrZbOLGg/VcbEYd/YxK0oIKHfo3mudUIb/6oID2axLgIyw4
         VkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779999840; x=1780604640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6562tSqUW4FPLuBReRttsQP9VRgygDGjnIRvKk2fg8=;
        b=HDCEH6aEtLcBE+zV22mKM4kPSsnpcpG6G0rffn4OX21wJKr96vvhWLceqD8HSbPqg1
         gCYwgqaz8xUQFb6BRlqJdSRPFmHN22edi1bsMoD4kAUrMblqmMsHOT8++CE3vU/MQPcD
         9QlOkKjT7IggqNI/ygDdfVeZsatWJIxujpk7NBwwGvNwcdCNlZlqx9SUeIIp2hv0m3mJ
         /JINSrW+wAtFaK1WSmrFIe16kWEkMoxoKovFPZ6kdmAHYdcJtrXfQew4um2fFGUKxlAH
         UkChIENeXxW0Pp5IBIVKGE8OfbGpNr0A1+37T4t+2ygyxiie05FQLVMLiNBaMyQVyKZR
         NA1A==
X-Gm-Message-State: AOJu0YzFEjkczA/c6oewpLkTHL3sfykIKmPTvr87UKpVZialsIB4IbW4
	FcErVmziEIumWR9jZmhZg1woSyMu7otlK+667nNca/HcS/reX6oQIiYTluMKH+aEs90NXKQIlj1
	bRHAjHjW4piAUHLyAGBbgsNniDW1ZRb+1uRRgPpJeLxyzFPZ8NbVUXoIXrh/4JqzVMJX8/TlCFo
	XcN5nskq2QK3QDygM7yA+HWDHquMH5mA==
X-Received: from pgk38.prod.google.com ([2002:a63:a26:0:b0:c76:9c2d:449b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:648f:b0:3ab:18cd:7da3
 with SMTP id adf61e73a8af0-3b40e2c7eddmr314116637.1.1779999840003; Thu, 28
 May 2026 13:24:00 -0700 (PDT)
Date: Thu, 28 May 2026 20:23:48 +0000
In-Reply-To: <20260528202353.3422206-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260528202353.3422206-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528202353.3422206-3-praan@google.com>
Subject: [PATCH v5 2/7] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
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
	Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

While every PCI Function that implements ATS has an independent ATS
Extended Capability structure with a Read/Write Smallest Translation
Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
driver to configure the STU on the Physical Function (PF) before any
any Virtual Functions (VFs) are created.

Currently, pci_prepare_ats() bails out early for VFs, assuming that the
PF has already been correctly prepared. However, this creates a potential
mismatch if a VF is subsequently prepared with a different page shift.

Update pci_prepare_ats() to validate that the requested page shift (ps)
matches the STU already configured in the associated PF. This ensures
early detection of incompatible configurations and maintains the kernel's
policy of consistent STU sizing across all functions associated with a
given SMMU.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 679a3c3c1d54..8057c24b0469 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -73,8 +73,13 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 	if (ps < PCI_ATS_MIN_STU)
 		return -EINVAL;
 
-	if (dev->is_virtfn)
+	if (dev->is_virtfn) {
+		struct pci_dev *pdev = pci_physfn(dev);
+
+		if (pdev->ats_stu != ps)
+			return -EINVAL;
 		return 0;
+	}
 
 	dev->ats_stu = ps;
 	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
-- 
2.54.0.823.g6e5bcc1fc9-goog

