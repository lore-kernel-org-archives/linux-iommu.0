Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F93B1ED0
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321346; cv=none; b=rCzJyOhIxvFMiZ7kXT04+kqQVWwIx7EX0olVc/MxNae8PCcIzrNZe6/6Uk5TW8MYUyZ4cAKcKzZgOGhQTYJhYhs9ofiAocU+dsY6KKHHPMzYygvY+K+oXOrnVfA5EcNH906Pdo5mNqD382zxUYYMTbuqYflJwthcv5m8MZl56hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321346; c=relaxed/simple;
	bh=w9aL2jXBkSQc60s7PCYdOXjxGsJtviB4VjNKmXS4Hw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b3OBneg7XGRuACRApg6uIIv0PvIp2sfD4UUeZcLqaHxf1dI9ZZ2nKsLiTGnu92mcFUL/PteEVAZyVhvQyKvO1qGwTbCDSqedu4pAbEFnMOCA3WEEPyass8J8BeO1hlEUCr4LpCO6x+rm8ZKH1aqW2JxGHvNwopmxnjd8QVlAUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dHtpFk57; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHtpFk57"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf11699875so45111315ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321345; x=1780926145; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWexhegNnVMZtjViVug1/DougZixUK6pa8KgAqOhU80=;
        b=dHtpFk57Ioq5suDwg5UwyMnsBUaw2sjaLGvUfxrAD3ghSiVZUnwmyczlPw1wtWisXI
         9z+b5mUb/wlZx4mFoLboSazvNSmuGvLVvyoPozkz4RvMemFF2TRgUzHBakyipMa/w0k9
         YMDfzzoyijUV7BVz013h6y/nbMDa3PYCLfpiMZBHxzgUH7Um243TwRolyg5jalJmmc6m
         iIoN7SLNYehpg1jZG39Ze9kjsfNkk7EN5XY9FYuC8Dom91dDuBFPFm9bqVorJjEyNTIC
         ZYbKzJdtUu53z1a4xztQYr85genB/o6+cMCRXxixs0d03M4G6dl6S7AaIsvHsd4k4q1r
         6DWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321345; x=1780926145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWexhegNnVMZtjViVug1/DougZixUK6pa8KgAqOhU80=;
        b=Kt042sAGHXRW32z3lNLhj1Uuh7MZlGNDb1nGDxsHCVGeEVLMyJTGTCUloT9yNDs6vl
         pHo9bdwpchTc6bKfy1Ucuarh6QPHokk0spjytTGguWlVUps1r75E66GvoB649ajR9YJl
         t50Yv1/RyfKe5B1nPiWD603D21o58dYjEJYLmBXmlg2eDg2QBIoauqfud+XyfxBBHBKP
         uzKxC7fI5RAeNihgYjbB29HghqYA75R/yH4HMl+UfsZ3EmVj0LcPSqZdCG4T9Gf+QSoj
         SvNceQwhE2V5vpBgviOlnLwnBx4tkWmVnSCkzvJrwt/p3Yo8U/NDZyHo+OHd64Lj1Z/7
         xNJg==
X-Gm-Message-State: AOJu0Yyn519nEuzw4tkaCKfe1jAP3lHB+3Y+uQgj034axojC+kpI5Yk6
	NdzAkwbifL6ekdmSHbkRtCWwWZzeZGArigJ3VRObN4ev2Koxfm22rqJKqw2niummOmCtoGAF1xU
	BjMhnNlqqM0abACFazhvU9/CILEkNFF4Uuf6zhTMo0tdEnpe1E5VO6H+PiQIGPuryr89hVaWJDI
	ZGnuDs1l4XTW3BEV7LsEpSPXAPdZihFA==
X-Received: from plbke7.prod.google.com ([2002:a17:903:3407:b0:2bf:1274:55fb])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cecc:b0:2c1:6ed:513b
 with SMTP id d9443c01a7336-2c106ed52bfmr2564075ad.16.1780321344530; Mon, 01
 Jun 2026 06:42:24 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:42:04 +0000
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601134204.2150602-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-7-praan@google.com>
Subject: [PATCH 6/6] PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Currently, pci_prepare_ats() internally calls pci_ats_supported() and
returns -EINVAL if the device does not support ATS. While this provides
a silent safety check, it conflates support detection with configuration.

Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
the function supports ATS.

Update the function documentation to mention that callers must verify
ATS support (via pci_ats_supported()) before calling pci_prepare_ats().

Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9..e10a0ceb2645 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -53,7 +53,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
  * @ps: the IOMMU page shift
  *
  * This must be done by the IOMMU driver on the PF before any VFs are created to
- * ensure that the VF can have ATS enabled.
+ * ensure that the VF can have ATS enabled. Callers must verify that ATS is
+ * supported by the device (e.g. via pci_ats_supported()) before calling this
+ * function.
  *
  * Returns 0 on success, or negative on failure.
  */
@@ -61,7 +63,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	if (!pci_ats_supported(dev))
+	if (WARN_ON(!pci_ats_supported(dev)))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
-- 
2.54.0.823.g6e5bcc1fc9-goog

