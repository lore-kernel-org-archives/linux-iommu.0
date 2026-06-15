Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28C356766
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567446; cv=none; b=l3EXnXefS3vdEGC9e5eR71RupFdl3gJDhxqUTNoSGuVT4wb5TFcvCJUfdIJZXRFNtOR+nTxDWHWnBuLddH0Yuu4ZnoIcYZUxZvMNUNxGTj+cfcx+qiFg5R9LH87U/BwvsVD3l5GX7Hzp2ELNH8uQsSJHFqy8EiUkNaq71a9sWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567446; c=relaxed/simple;
	bh=OJiFxKUeERlCwujCCZlS3ElgKdijyMyNKAedq9NKq0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NXK+Hp4h5kWeVkKYhxx2WVWSx6UBVhM1U/PU+NpqO6eQYYyE8Yf/Y4ggSItr38G9f9NDPh2J6YCf/ysi4MzrO2i2oOFuLuwZvzcSNsfDahG5R0RneIVFNrMNYbJrGO0wuoJHOjLX//aXUX901fkdWWC9RAluWFsL2F6Nkz8uJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUURYBLl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUURYBLl"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3773f1eaf91so2747595a91.2
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781567444; x=1782172244; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PA8pg/E5d0cjaYhQA4UoQX60B9QG7sbpSeEUfY/VxIY=;
        b=OUURYBLlalVBT8vw4RKNVHItadpCQWJ2BCjycD8ss+WHeAQ4NhwF5V7Hj/VUKc6woq
         aWVOgVWGyYsB8CpIuyrB2k9Ormdn8Tqb4J0fo6FXVocBJUCR/AAaGhHQsyIs3Fpskpm9
         3bPIdBQgE0NOsdMssUHuc9nIfrWBVzR6eE0JdJD/ZteD9yciykOor6WFXjHO7Q60UROD
         p14TO0j2rdR+CCG3hPsrbWHBtaYezXQpZh5m0n2E+0XTXTw/UeiWra8Fdro25++P44tm
         a47iqVdv087vePzdsGZaayRSz1xBK+KbEdsiz1OSU3RI22YSHfStmj22KwViGJLDlHLZ
         wFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567444; x=1782172244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PA8pg/E5d0cjaYhQA4UoQX60B9QG7sbpSeEUfY/VxIY=;
        b=XkLS9ISpHWHQgr62gtevURm1XezxUZlaeNNRvAAcS2vhtimqaee7MudEpAfbITJr1g
         RPV3BWbftZORPpnoe7E0yDjoWeMiMHzwjkUevW0b5n2WJcTeeGiG6WQZzL/7Fki6MkgH
         z1ItCFsHHromCOixTMZ3JRV19xy3vJeGUmkqQlXxoy41/9PUjLLsDwdicdfljtDdtF/f
         grdlDxOolN3C+mfgNXMUP0fSMlG/ZqXGO3ru8fxHHqPs1JfcADqkEBO9zPGMbeJj44Ef
         tnlb85exwfFTqc0fFWb+5nB9kqwcrNFBMe3AJP2Yvu7vPN84F055F6mlxXboEpcDe3uU
         SJcA==
X-Gm-Message-State: AOJu0Yxn5jWosH91O/arqyZ6c2tzT8YYykwPg/lnmpAfsplgmu2tQ1kY
	HWVbqov2zvyoOwkCrTydckPDzhBHgyWsY0nNyoTT+vbYHchK4mqIRUcHKlOVstsM65tW8JC/nRp
	dBJILEhshMq1j4byDcCXGmE7MPmhTLaijoTH2BXCSejZBdoYEBZP5JSbregC0eNc2O4DzvjsB6k
	LVvosGOoAFU+IP6UHUyN5QuL1kzqKsJg==
X-Received: from pjzd5.prod.google.com ([2002:a17:90a:e285:b0:36b:8553:3c3a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fcd:b0:36b:bb66:fbd0
 with SMTP id 98e67ed59e1d1-37c52803059mr1143918a91.4.1781567443395; Mon, 15
 Jun 2026 16:50:43 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:50:34 +0000
In-Reply-To: <20260615235037.259909-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260615235037.259909-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615235037.259909-2-praan@google.com>
Subject: [PATCH v9 1/4] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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
2.54.0.1136.gdb2ca164c4-goog

