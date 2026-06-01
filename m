Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36323ACF06
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321332; cv=none; b=WZtMbi1rcYy7Ui3XCln8O2TAd09kKysWqxa0vokr9uQdJcMg+262dN7bpTotwikX+n1ox/t/mlRwbOQWn/k9gyzaxyh6TdLdZ5nC/RreOE1kEk7SQ85brCyUAtBCLieS59IQGWOMkyTlVNzC+LYS2HroKybwxQ6GPDI52iCikpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321332; c=relaxed/simple;
	bh=0y/oGJrRC3jE45D5ExsR9EmSG6axfTipRPStNl6A4f4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nBEQqNnuZNffXV9IQ2pbfutSn+fQ0AWHz2N64NUJGZHYnUaR4yNwUX2hxf4GO5/2thosLt+7AjDLgXuMep8eT96M3yYkyJOBVlb3HkxpcLc2J35/xEcZHBEskUjHzPe8EY7OTZzDyE1cIbghblYmuNw8tt5qr0Q1AcWigI11Leo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/3IuNiz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/3IuNiz"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c20f7581so15648325ad.0
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 06:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321331; x=1780926131; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3cDewhvIRKNQtJoPSUw7b+ZCGblkR4c9l/2JildOedY=;
        b=e/3IuNiz7bL3fQNcm0yeLyVJ3CucyvMGG83LLBe17c/F11NKgudQSVGRPunoYAKgYI
         nptLhmA9ZJi1m5Z4T3PF79HbBNfeb0x01BdT1sh9qpvGYIQJgSrJ/MX7HXIF7ZWq7+Tb
         yXzdx9J7FIhl/FyMs5mLRs33AxA9r2FpzALnvCl9f5IFVhK0Lb2mDQS2CU5X1jUdiRqK
         srjR8YaLVd1UKDDA6LJFMYPNd7bnwk2G0IHypjw5EtxxtU6ti2It7E+Nh1CW5hYss8K3
         aGjLvcaAggpaVoMkrNhyDMAKmh3tNiHE+Hs3dSiDZ/NGCDzf8MA0AVPFVI0wB3m/FOvc
         mnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321331; x=1780926131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cDewhvIRKNQtJoPSUw7b+ZCGblkR4c9l/2JildOedY=;
        b=JbPTvOk5dyx7dsolfwK04z3z7DY8voNVJPaaehwmEaw6tte7qo2Rax+KXRQwEmRwVs
         vtSWEOQM35LjitGC0y4nUmba+8WkLmDjD+0hxVMHHGJl/543sOIv+d5ImsYcVAms/spd
         vjhcaDIgCRpQ2x0hx+kqNhzfnGkNWDBbs9EkDmMDMNNbYXGgHACNxCfwXQBPR5yqn8r+
         ccysAEGfUYQjzbxwzD8qi2R0ThLLALvBMl+fjVJWGdnVXeZl1TP2s7iahaGAzjXtIKWA
         wTDFAmZm9NFfWJ5+ER20DMQCFrBGSB9VCXULfJ/lhEV0wPBXzTh/ksI6J1FNtRCJmN9r
         VHIg==
X-Gm-Message-State: AOJu0YyG3n/T4yDEFZHpn2jA0tzbVj2+ynrffYkmMgT0briZbEiCCnc2
	o7cXeN2mbPGt7RRbtLUNWT4MdBVy78n0VypIqz8Zyzxn66WMtm/Y6iHp0ws3Egg/PNeQg4kGXQX
	DfhfInlw0caD1j7G8lVYZ9ovTV0ZhJNNGOAUM0F0oM1UNt++AifchTqFa2gbY23xFpPbq5O25p8
	YI01dJw/jYwNQcmojuPjXgp0Vse5Efuw==
X-Received: from plbmn13.prod.google.com ([2002:a17:903:a4d:b0:2b4:6553:4533])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:380b:b0:2b7:a350:463f
 with SMTP id d9443c01a7336-2bf367c0cbdmr133865095ad.10.1780321330651; Mon, 01
 Jun 2026 06:42:10 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:41:59 +0000
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601134204.2150602-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-2-praan@google.com>
Subject: [PATCH 1/6] iommu/amd: Clear aliases before setting the rlookup_table
 to NULL
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

In iommu_ignore_device(), clearing the primary devid in the lookup table
before calling setup_aliases() causes rlookup_amd_iommu() to fail for
aliases. This prevents clearing the Device Table Entries (DTEs) for
DMA aliases.

Fix this by moving the setup_aliases() call before clearing the
rlookup_table entry.

Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f1333071da10..a94de66a885e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -745,10 +745,12 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 		return;
 
 	devid = PCI_SBDF_TO_DEVID(sbdf);
-	pci_seg->rlookup_table[devid] = NULL;
-	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
 
+	/* Clear aliases while rlookup is still valid */
 	setup_aliases(iommu, dev);
+
+	pci_seg->rlookup_table[devid] = NULL;
+	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
 }
 
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

