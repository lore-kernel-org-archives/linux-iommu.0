Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DEE379C30
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734635; cv=none; b=P7MBfoznr5SzGGfs1tdEEWObdPIVspGq9PWNKIZRThoFulkq5moYx9uaXIk16tEs9mvIbcboX7dlz+d1/dHl26TbpPGLx7JaUZ9G1f+VZOZMu5CKp3o1LMIXlxneMl5wNPEGToiOzHWpb5y5wDoDtd1nZhiV1kMWd7gwyZMoBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734635; c=relaxed/simple;
	bh=4rSy3o0s1t2X0KnAOSHjI7mBWu/hrM5yp05yahxxfi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tdy582oQKHCYUhKIT82mYnOdnuoO6YS0ZXIg3Hw4msO1zHCqN5KaKdBGNs0PkXYAwIg1RFjzIZjfYrikSU6jEAWGUirXlWDhlLrBe8bbmZzne9mJYbyijanfBL7u6Jw0Eb4MA3hIWAk+A2UZ7Rb1pFT2tq1oOgfedElnkztleiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qxXlUEC7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qxXlUEC7"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-367f715cbd0so9690279a91.0
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734633; x=1780339433; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U//oE56krJ8X0dzRdJlpBkAz8D7rzP/0SvFlnQu6n1U=;
        b=qxXlUEC7t3ff1VdHB/hpGZ99xp9YIB+fA/0ybWAlpjeKcnbkMVFbg3PNCKA4OCyZL2
         Yqp2NWxd3cJpKF7y8fxjBqtqzmJsjF6o83BoqerDwZgPrY1N3pkvdh6kqj1Bxwb9qeOb
         ZVHAine2oZxvYaGQC68VpMkXdnIUL2uHwYjs1GEJqysVA2o2Sd9G0QME5U4eWbqxi9Ea
         gYUDyfmi3wkFKrPjQRtlPUnlv7TSlG4Vxwt6vWctXQYPR0h3NPLOxJwXIHYTDyNmWAgB
         jesj2MfkRqGEUxeP7OE+kmE3U2gceNnkYvdSNO17HPyW2rmnmQP7ngQXICs4MU4aBdar
         AK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734633; x=1780339433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U//oE56krJ8X0dzRdJlpBkAz8D7rzP/0SvFlnQu6n1U=;
        b=p+aNfSiqFkbSm6ln7tYJfFNg4G1hiEOU2sQ6dWG1xkKSNMzHOY47FdCUZqpN/WY3uL
         Ii4F4SxOv63t27ZoU+Y7uFZ62L1CiKHDreJjwM8sGoI7IJcEkMLiSPgDKz/V2umnbUFv
         gO4iCB3iVwtAWF03pmV0o5qr54i5hNUjtUrUZrFzXoosKKYgDX1YXbfJuUtDTlBDVOqf
         HTPvnPAJ8q6Wczz3IyF2GK+ud8iV3EHeLeji2rlYzbyi8FWwUkKY5WF93YGqC794Tl7z
         V9/iN8TUE4WQ7KosTPRF6AwMv0abBuoVwPdHhxHB2HFiYXYMAjtGQrpH/USrJGVggjFz
         0Xzg==
X-Gm-Message-State: AOJu0YwMoYNQfuioVA/Sdock0lPKyCCqg79xxoAlms0E4HEh1ZKf/92/
	Hl44cwGzs8e+AJLCX5ZuSRlxAs4Uq4x8iDcTwHN3d4lIw1nxjfmVQAsX+FwXhmF1dJf9m91NLaH
	8zjGkI6LtXSA2yD64/KmGQdKJ/8Z1STZ8Goorm3vxg8ngpbZSyd+jlxUn/SiAi5XGq45MhJJAhQ
	eJ3thAWqw136CzFZicSsphyvOsKKfaiw==
X-Received: from pjob1.prod.google.com ([2002:a17:90a:8c81:b0:369:c5f0:e8f6])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57c8:b0:36a:f612:e695
 with SMTP id 98e67ed59e1d1-36af612e947mr2150738a91.17.1779734632985; Mon, 25
 May 2026 11:43:52 -0700 (PDT)
Date: Mon, 25 May 2026 18:43:43 +0000
In-Reply-To: <20260525184347.4059549-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260525184347.4059549-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525184347.4059549-2-praan@google.com>
Subject: [PATCH v4 1/5] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
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

Update pci_ats_supported() to additionally check the associated PF's
status when called on a VF. This ensures that PF-level quirks and
untrusted status are correctly propagated to VFs, providing a robust
support check that aligns with the kernel's PF-centric ATS configuration
model and is immune to the timing of VF-specific fixups.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index ec6c8dbdc5e9..a5fa7745bce8 100644
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
2.54.0.746.g67dd491aae-goog

