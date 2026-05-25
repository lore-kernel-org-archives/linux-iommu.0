Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FEA37C91A
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734638; cv=none; b=kMMzX0XqlgYBHSR/ZeQsXN1Ot2jH/x+4tkoBke3x9XDHxo8yyTAcz/YMCaMKU5AcRWDsBMjgoTY2szBsvn5YDZ9EEAbp4wRQYOnwmXi9Ro2SFaTuI0TQ0k1gTgw4RSpzm25KaEN6/TBivvf/eztEpZckp/B0dZaDSsMkvwtqL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734638; c=relaxed/simple;
	bh=By2955+3i/9aSqhHbbWD/5u7eCz9r5l5gY9iiYCu0WQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GaXjtdrArar13AsyXuimrQvh/yKa56AbsNWG1/KRo/b4I0khKPF29kz1S/6bxPbgIRYOemNIofhUkCFuTwIY33+sO7WAA4fJQCY8fD7dN8Kjh1bSMQdrtnytLT209XbPgzaFPfdijkE/gWJw7j2m+AaknuWboSAAw02lQ2YFVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rul6oYd+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rul6oYd+"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3684cb22502so8932983a91.2
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734636; x=1780339436; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=owlSh2MmqvAnTYupb6o8O6jSpQ6Nv1/iuRHiC459FvE=;
        b=rul6oYd+U+TWpV7ffKk0R3+cFcVKNT5uqJo4sRfCML/iS+71/Gwic0XZiK7dqA0xfO
         lWmDNs4BIrJh+NPBYRKWUk6b0rboFPW+QDXsktWKshokymiCqdHsunzamSnWea9fPxxi
         6cDZWJBLitvOVQQINdibnhf4hS9PhkBY7ttC4ir3wAKwSVhKIi7yt2xxkwVo/w3B0bne
         y7L2fMtib7aOu0F2gVzDj3Ho+0pD6YIwwo5uV1sw8m1XB1F9F/H/K3B+mvp+QbnWHFra
         xUMwFjhC0c/DJljA+jU1giNBOp8cjdRNcmxu+JTaZqFUEBzwH6qO7hOojrzZPYdUh/lm
         n9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734636; x=1780339436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owlSh2MmqvAnTYupb6o8O6jSpQ6Nv1/iuRHiC459FvE=;
        b=A0SnrklinrVjqUO/hXQnvFU6by55Rjk7ceu5fU202rQ60OdA4XXKfB5cbDvFLW4kj5
         SDOsmfEukTlPUl9Q/xDZ7TX0HGnV1hpwcYqxOt8NxNa3h+kjiTAEaieKbajueLFrLa3w
         pJtJA83zyM1vZyLL+KkPiYpfoKVdZ3UoCMeMNGoABDBkRE/iWFzF78Ee9YQDqKQuSPq2
         X2YpjZiBQsjtZFTyfy3096uIAOXuD6QE1FQ24HMGDwJOdp7UUUhUk+JmStZU6mi/lTnH
         hnbT5qyu5CToEP/B+ajtr4aYlW+MRHuG4AWOmndk4iEuzS1dTwTvWxeaV4zNKJt3mKXv
         L1PA==
X-Gm-Message-State: AOJu0Yy1cazSdeTNyun1xDNaBU+PRKqhrITJ6cI8TQa3+bYTdmy8QdYY
	KV+Hxie6LcupAFijHy5zScHQCODYHWDG0WFvDx6B5utSA7p6axf4PmYqvfof8GLlBPOq/+tvZVW
	57cOZ74RrGCwTvM2oKHwt7auF/6LcVvFYXiY8MebrsFlg5Fi40E5ZBY3fyy/9SaaMQP44Juzddl
	lbsl1GlLWzmQ0VvJPxz8A54owwfMV6wg==
X-Received: from pjbos3.prod.google.com ([2002:a17:90b:1cc3:b0:366:4086:51a7])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b52:b0:369:7421:75cf
 with SMTP id 98e67ed59e1d1-36a67508574mr14714152a91.16.1779734635610; Mon, 25
 May 2026 11:43:55 -0700 (PDT)
Date: Mon, 25 May 2026 18:43:44 +0000
In-Reply-To: <20260525184347.4059549-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260525184347.4059549-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525184347.4059549-3-praan@google.com>
Subject: [PATCH v4 2/5] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
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
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index a5fa7745bce8..54319854bfd8 100644
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
2.54.0.746.g67dd491aae-goog

