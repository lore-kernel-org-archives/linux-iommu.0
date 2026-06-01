Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF993ADB8D
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321338; cv=none; b=ohthfW7DXCqyGMGFMuiVaBKYJJf3kl45FjD6p3dGvNSRVUMPhUY36x2kKJFN5AjhTrKv+TpXb8+sLLaOhwolz9aRy/2uXdOFc+Ga13fGzNxLCTheQdr+COE272lC2S7YmVCiNcvtpV7YnqOmnRePXn0Kh6TvcuCCKGicDoUJ6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321338; c=relaxed/simple;
	bh=Ju72LWXz/B8md71qQh8t/Jq+vqDu3BYR+Mvmt3R6GnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NdvNBOrVBpkMR4FOu+O2TJkqwVHp7Vwrfd7JqfKq6hLhl9ajU79mQU1U3C2l3qZQ0NbPzOj/uV0tSdjHTFc/34OCv0OauRNbyTN/Prc2KY9zAm8uosF6kFy8PALLW9CbqvgFfGDycX6yBHtzws4l1IlI0Xur5yPLWITLgs9hXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSSrJvQ7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSSrJvQ7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0bf6904a6so27526165ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780321336; x=1780926136; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXVaCkW8Gnzx6rEb7LWE+bpldCw6MgCsucYo9vO+yHM=;
        b=uSSrJvQ7GBWs9ndfSoqoJcrO5PCi9xBA/AQTTPzisCuUSW5fqJlzbCmokfMSLDlZ4/
         h6sYMEA3ZXYqwNZt7FLlhuXskzCUTBJ3deeG1WpNSS529o5TPFsJ5m5ss2NB5sygHwSh
         A7BXjXLMIZlJSJ+Cccq1dCaUT41KsWVjM7rdlv1Ckq9rvaLLZk4Wxv/lTm9C/joyT9Ro
         PxWC0x4JgX9DDjPqIIKB5cBrjuix2TcU2rN/BYpFyXT+3c3TBOO8W1oamFeQ/p0j+r+t
         iJU2IjNFBJmL++83i3XyJO2Slot7WR5XSIhU76iOrcQyuIMdrv38keV+1Iqafcri//yR
         g8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321336; x=1780926136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXVaCkW8Gnzx6rEb7LWE+bpldCw6MgCsucYo9vO+yHM=;
        b=ZSl+BFj0eSit8IPAM/EOp7rFetACPhOlOzl7AVMMipCzvVkHt9k8gLHJa05gyIeKhJ
         +2FNKJzcsbN0rVCRApdRIgt9ZYjGfm5Q493X3ViEbM04gs0CCCCMdZVCFd1Ff1InVQlM
         nsnLbsoapC2IwC3tm/nnGkgkbk1CWukM7klHPJbFO+iO8qpZhAYiQoEXQ5t/P5Cqnu5J
         N10Ry0cktw2R0kcgDjdUhgHAZLNV07/r86U63W8wIc+SZQ/JXVYh4SCY5mJGYLQWj/QI
         WUfbPzs87VxL4rFI5qo5aPyLBqGIdn/tCzzDlUprDAWiQNOBtwI3JThPpBmXhOLBLUEP
         tNPg==
X-Gm-Message-State: AOJu0YyN96SgpvyN9MD6oPvY8mHPWpWTeyz/UQqMysNAKowAfNR+3fkR
	DC6Yv+nWkvPtF0r7IJ7VjM7rXMKJaaRWVWp/DEjtmg/dJucsT/u1xWXlxgxt2i9dgHI35UtgAJG
	GJaMXx4Nlf1kCIX56rzuw1WRObbaV7Jp61km/U6/P7x7c1HLkzqMGwFcX0ZldQL7zUZBRo+BNYX
	B3x/u9Co+a4euwWW9URoJAva2oOembnQ==
X-Received: from plrx24.prod.google.com ([2002:a17:902:b418:b0:2ba:f5a6:38db])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8d0:b0:2bd:c5f8:504f
 with SMTP id d9443c01a7336-2bf368d9ee5mr123694865ad.40.1780321335923; Mon, 01
 Jun 2026 06:42:15 -0700 (PDT)
Date: Mon,  1 Jun 2026 13:42:01 +0000
In-Reply-To: <20260601134204.2150602-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601134204.2150602-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601134204.2150602-4-praan@google.com>
Subject: [PATCH 3/6] iommu/amd: Split probe error paths to preserve IRQ remapping
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Split the amd_iommu_probe_device() error paths into err_deinit and
out_err. Proper init failures continue to call iommu_ignore_device()
while configuration failures (like PD_MODE_NONE or ATS mismatches) skip
it to preserve the rlookup_table entry required for IRQ remapping.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Suggested-by: Ankit Soni <ankit.soni@amd.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9b5861e241d7..c3b3750d4a22 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -737,6 +737,7 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	int devid, sbdf;
 
@@ -2477,8 +2478,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (ret) {
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
-		iommu_ignore_device(iommu, dev);
-		goto out_err;
+		goto err_deinit;
 	}
 
 	amd_iommu_set_pci_msi_domain(dev, iommu);
@@ -2512,6 +2512,10 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (dev_is_pci(dev))
 		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
 
+	return iommu_dev;
+
+err_deinit:
+	iommu_ignore_device(iommu, dev);
 out_err:
 	return iommu_dev;
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog

