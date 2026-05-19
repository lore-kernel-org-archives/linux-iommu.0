Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2E35202C
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198818; cv=none; b=AXYWQt5mEAKR0OYjNuAB8droN9LgHRVlh114AMTqysyesNGbGBsQAUi1A2Ifc5eTswu3skeZNDzk+uLxWUa+JRgFaKQOb9JtPhjNmiCHZay/mXSly6sflJimdCx9K8Ncs8wMMpNKGAeUqLZKlfAcOXmrqnT48hdBFvn5dpgY5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198818; c=relaxed/simple;
	bh=ftPuSF5fEorm3tcHSoDg4t5CQW9EzadJM051EBrSzZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jNSRU85yrD6zH2JF3vB+GAWepXbSWcJhozqOkzJnBqe606gHJ7jnvwDaGRDB5Z3ATYI9HzWbqcCK1zQm+MfFI+oDgHiOAQ6CL331QMLZHF8h85ZuYHQTKWB+rDQZif2woXCprCSBHXGzZnbBph3TP5hs4fEDwfxV0l96Rt1kXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qDMYKuU0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDMYKuU0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c802545ae0eso2241466a12.2
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779198816; x=1779803616; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTRxUJzZLnF7O6lqa9s49yWKPCyCP5ATHRikunHLlWs=;
        b=qDMYKuU0bfXglmuMXR1f/PCon6QH1frwNOFGKrJ0NxqIgZPYlyUCn4M8MZMowKpBic
         m3S+p/ml1HyGKwkt5dFdRpaurq6pfzkC4/WIjkNqs2otIp1X06Gw2VUb9WBrR2etgZln
         AKeilZxOUU2JNKFQ9U4XT5WA7t9UyZ+b0aaKnBtT6Pp/QZXmENydZvjbdKE+unXn5fTS
         GkNoVulSCIHi0MYdqRQuw98Ee1QbaU5IoXBbtis3vPw6EUj6gzYE+y73sYAeW8q5cG2s
         Cr5h7uQlmKesYtqsXYKMExvuTmsr3aA2TVk0oG4oGPVV1AJQiRP/L64IrBbJfz5ykOCE
         jSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198816; x=1779803616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTRxUJzZLnF7O6lqa9s49yWKPCyCP5ATHRikunHLlWs=;
        b=TSyvzaurgJ4CPgCwO6p3lmx41GhknuPTM8MDYd8gDfNPu8OPRhcl2tfm3oQoOW2cP9
         Y5kVnf/DhDPaIjkiXVAjl+0bXyRUki1OfTQdFGhUrbNW6EfoJXyesCGV8EZWRn5R6yHr
         RSH/BoLZ8aHZXmGjCE/L1d7iICufrxo9Ubrh65KCwJkdLL2TS2GA9CBCumc7pmbBdbDA
         qB2NIKP1RGkg/ukB5kLjICF15RYKl5wwlYQfPBEVsvcoDRTxs3GPg6H1m4nnW77IbBxg
         yRuf3jnXqB+rV/FwtPheRz8xzMppd7oRKQ89oykmHZFX8zrR/ssJs6QMFdAhTRwO91am
         Qp6g==
X-Gm-Message-State: AOJu0YypzBi8zcF/c6kvOs156Sama7BVRFdQ1KJKx0IZNcBRzGXkVGNQ
	6rEnbq+CVxOTftwOY2cPPn4neiqrJyn0QoTY3zOf3IvifvE2CP8S2Ir21agmoyHtkDgw4cMV6jY
	jHYdB8PguL2xC1shLTixFE7zGUp7RwDHhay/AQ+W24i3OdBDiLaCj79r1KJ+hMKZlfiQ035n3xh
	nin0O8dTC7w97fbfLfs7kayQhxoNRPgw==
X-Received: from pgv5.prod.google.com ([2002:a63:1545:0:b0:c82:7761:9941])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244d:b0:3b1:884a:c3d5
 with SMTP id adf61e73a8af0-3b22ebd8ce1mr20588569637.24.1779198815838; Tue, 19
 May 2026 06:53:35 -0700 (PDT)
Date: Tue, 19 May 2026 13:53:20 +0000
In-Reply-To: <20260519135323.1558777-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260519135323.1558777-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519135323.1558777-2-praan@google.com>
Subject: [PATCH v3 1/3] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Update pci_ats_supported() to additionally check the associated PF's
status when called on a VF. This ensures that PF-level quirks and
untrusted status are correctly propagated to VFs, providing a robust
support check that aligns with the kernel's PF-centric ATS configuration
model and is immune to the timing of VF-specific fixups.

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
2.54.0.563.g4f69b47b94-goog

