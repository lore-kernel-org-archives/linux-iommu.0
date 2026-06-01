Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6443BF677
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324611; cv=none; b=TH+WC9WyVRNE6VTi+6qj3l5b3PX7alo/fO8g5Qeduy5TTMWeocvG3vHTjoys0zP5MQkOggw+K6gs3Is6aGHxMAXxIcKGs13v29UxbKoN7M6OS60PNpGRIjpew4LrKzjz459FGWcoMCKpFbTl7iQKmEvsaJF7V1Fw8iCi9x0jJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324611; c=relaxed/simple;
	bh=zLhKJQfxvv+d9aNsqJrU4irOe5OKs7/A2799Tf2JNWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qF3d4aDu95wK4FzArqeBwq3LIcJcPE5LsfgpNfiysAsifNhK+4J5bcIKgotO6q12H8meBEHV7/tcpfQGO8rLOk6KM3SvBObHqzj854rCetpAwt8XU5n6XfS4NEn9UkuYVRPwL1vJQA4Hx42/jbrLX/f5EVb15TXaxebCBexhX2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+nfmcKA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+nfmcKA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf243973c2so22512865ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780324609; x=1780929409; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1WHbQ1I/exyopX3p7b75ehhnkD9ODb3Bve7jByn9iQ=;
        b=b+nfmcKAih5Fqd/kDKyiEARGzh4YzwELRN+DwIYIdYGbc54jTXjLJv0xTwJ9d1Z6+R
         zpYBS773UjrGh51X4+oL1j2PC1z895tCR6+02B0Mf4otUMt7/0bCSEK7HMKB4BLHcTdS
         u3j+PWyleVOZyp/LxMLjgInlc3nO5/SaSFgS7chjcFtKlLH7wkNi8Py9Pb+YS2Oc/zdZ
         +xLjRyeWPAvLa4jsFLCCBXFthrQ9etvJj0eQAmZHrb9TmoLkpdNiV4d1lupUDzoyOgBK
         bw5Y5YBb3SsCgsDqL7DvTIrt8hor9xulsZH0c6jFVD+3Nr8Ic3pZKmvEMosqM8AmfCql
         DAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324609; x=1780929409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1WHbQ1I/exyopX3p7b75ehhnkD9ODb3Bve7jByn9iQ=;
        b=NLuUpIojvlkncgNur3r6Zo9KuI7Rp5FU3CRZPgMaTkhFRdR4bZNNgPuybsayVWmOMH
         6tQaEhg/0XYrr+gO+UbZr6oYbdVuepqdae+cHoNxumQfpr5p9SgXtAHury6xYvRK6pXn
         AT90D+l41rN1hjhBo3v2qvtYz52MbzcRf7zYkcevMf4Ql7S3GhXcqkScsqAxb9Dyd4hw
         H1kx2zarR7PJSz7kSnlVsPZCf0J8JwiIbKDnl5CJZ1RCmXAqZSAfJaDlwsL956kcXGtH
         57tNr5KmgsVrvgumyq5s3mQI/qDhVyddZZzawhdTg96s5fZ+LgFmJZU2x5wJSsNffO51
         JYuw==
X-Gm-Message-State: AOJu0YwYk9AgSkBIqdBB+nPxGssz2QHogR8YZEnH2FoMGGqV53ofttYu
	1B3ZGw2TJJKB2FnWwgj03pZmZpaMykZAbOrCKyENr3zqXA2/9PKn7zFbKffITG6NXMvL5xAv8Mc
	8dhY4U2wrSOeqyxDNV2g0Ti7K+f/5qAHinNV33yRJcxaNSV4DbFaJKzcrpGoVw8uxwc+x6dnC/d
	C/n0KkHrP/GbUIS65UUDOJ3Fu28c1pIw==
X-Received: from pldy13.prod.google.com ([2002:a17:902:cacd:b0:2b2:a70b:98ea])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b07:b0:2c0:b6c7:2273
 with SMTP id d9443c01a7336-2c0b6c7267emr92934605ad.3.1780324608765; Mon, 01
 Jun 2026 07:36:48 -0700 (PDT)
Date: Mon,  1 Jun 2026 14:36:40 +0000
In-Reply-To: <20260601143644.2358771-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601143644.2358771-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601143644.2358771-2-praan@google.com>
Subject: [PATCH v7 1/5] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
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
2.54.0.823.g6e5bcc1fc9-goog

