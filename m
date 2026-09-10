Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3144A0150
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050429; cv=none; b=lfCKOyXXve64zK9IDsdRA2gVxkmdTWKDH7jLbDjEIeDbzo/Pc7GqkUzHIBlwIujpOO2x1ntIML8gxeyz3ZPsKkfyThWenC4OVD9RftXiU+H08pk9QpeU0LWYQ7V6WfMEOEaRP1l8RxGs23y8LL5dF9nfWQ8Mj86b0d53fMlihxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050429; c=relaxed/simple;
	bh=YYZVAnbeYsjJUQMqHO19xE7fLWQGWh0V5fiC80emyOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ROT7rlSDtBfdraczZ3xgxzp+nLELXpUE57Wxpw5JvVTY+KAJWK8qfChuWs9jQV9X1NGf0CNHi8cJxzVXXlCGO03FhGRH/w49xL8jJnX1hIiRWyzAMvYLFDoDY1RLR7r2ZcI+d7O5jJxV+bpzfOirl5R3mGU9ENcGUwN+MgsMUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4DfO5sP; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4DfO5sP"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso7167839a91.2
        for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789050426; x=1789655226; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2x6uJrq0uW0oJaL9sX59+iCeuYUCoD1qgfJpjGmx3Y=;
        b=T4DfO5sPoeroSh8yX4feejkhutV1pTNFbHFbpmxKkeThEqqGaAWx7PzTXmb5NL9EEg
         /xzNjqrzd/x6F5yqtC3xv/VFMbBaEy7i1tSc0GJJswDgUyYcrl31V4xWWZJdoW8X4N/n
         2Ne5dZxFzJZQ5OxfzeHqOQvWmYeTtE8zD2dwgdvxcmohOvnQZhzoKud7/m5OjqoIeFWl
         JgYHwZK7pQ3eZd3++4uTqm3TVf7RXk0xOrClnExKgStG3egwSLH/QxaD27AEXziq/TxB
         9CEtpp7HpRhpf6faCd+zAUUdzxIyk8C39fua4v1Qm/Ah2WIyJhrnUP2s7DNtspCpHXdv
         XwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050426; x=1789655226;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2x6uJrq0uW0oJaL9sX59+iCeuYUCoD1qgfJpjGmx3Y=;
        b=pyD7Vi4m3W9ZjzaQt0kajOyXvT/j3VjjWYIA1icD6CxcQ6TnqHBqe0nLFJFiVn54eP
         CnqMQbkr50v/Kozi+BmlDZidqlv2IF5+/PKCM1/kmQvU0SJ5dyM/Y8fuTLHwciYynbYp
         +yH/3lNaqhE0PV8jCvzktIFnGCqlofMHV8IwdV52qKxqDU6rFbfps5dpvn6ElAcSjN7O
         F6MfR8ceejb3s6R0O/9Rz7oXIykb8dPInCRfhJ0RQmT4VjfK0Z8Luy97kMaAA1j2y2dn
         DHt9uwl/NZE2O62U0bYiN6VWTuJaiPuVjgpdvx+ECipf9YQxqGMzsDXSxIgOpvAMczPx
         aoog==
X-Gm-Message-State: AFuF++mGLK990nrE+VKMpI3WKty1krRkLTirfKGgs99d3rsn/fTTwinE
	j/GWUSjcmHhksdRWT3quW/5yVD2U5mg8Ov/x1UAjCZaZgauwqEr4AlGYN3Kt1mHgZ+ymSXi9g7T
	/inceNhVfPoBRn18Qk0uoPBx/vK5jwHWuXP1T3cpP/pTFrgAZORn3zVD+4JXYbeMLClmt8Xsugr
	lfAmtUO0fDoX1zTuIbrNMzPOEtztzkIg==
X-Received: from pgmm13.prod.google.com ([2002:a05:6a02:550d:b0:cc4:a477:43cc])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c05:b0:393:288:29e3
 with SMTP id 98e67ed59e1d1-39b26106c44mr63990436a91.10.1789050425503; Thu, 10
 Sep 2026 07:27:05 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:26:53 +0000
In-Reply-To: <20260910142655.3281464-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260910142655.3281464-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910142655.3281464-3-praan@google.com>
Subject: [PATCH v4 2/4] iommu/amd: Remove iommu_ignore_device()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

The iommu_ignore_device() helper was historically called on device
initialization failure to clear the primary Device Table Entry (DTE) via
memset() and nullify the rlookup_table entry.

However, clearing the DTE on probe failure is problematic:
1. During normal boot, DTEs start out unconfigured (blocking DMA), making
   clearing redundant.
2. During kdump boot, pre-existing translations should be kept running
   until deferred attach rather than abruptly clearing them, which risks
   breaking in-flight transfers.
3. Writing to the DTE table via memset without flushing the hardware DTE
   cache risks aliasing & torn writes.
4. Clearing the rlookup_table entry breaks interrupt remapping for
   devices that fail probe or operate in translation-less modes.

Remove iommu_ignore_device() entirely and simplify the error return
paths in amd_iommu_probe_device().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Vasant Hegde <vasant.hegde@amd.com>
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5e144a60c397..7f8b51c28a7e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -728,22 +728,6 @@ static struct iommu_dev_data *iommu_init_device(struct amd_iommu *iommu,
 	return dev_data;
 }
 
-static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
-{
-	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-	int devid, sbdf;
-
-	sbdf = get_device_sbdf_id(dev);
-	if (sbdf < 0)
-		return;
-
-	devid = PCI_SBDF_TO_DEVID(sbdf);
-	pci_seg->rlookup_table[devid] = NULL;
-	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
-
-	setup_aliases(iommu, dev);
-}
 
 
 /****************************************************************************
@@ -2528,9 +2512,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	dev_data = iommu_init_device(iommu, dev, devid);
 	if (IS_ERR(dev_data)) {
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
-		iommu_dev = ERR_CAST(dev_data);
-		iommu_ignore_device(iommu, dev);
-		goto out_err;
+		return ERR_CAST(dev_data);
 	}
 
 	iommu_init_device_caps(dev_data, dev, iommu);
@@ -2544,11 +2526,9 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (amd_iommu_pgtable == PD_MODE_NONE) {
 		pr_warn_once("%s: DMA translation not supported by iommu.\n",
 			     __func__);
-		iommu_dev = ERR_PTR(-ENODEV);
-		goto out_err;
+		return ERR_PTR(-ENODEV);
 	}
 
-out_err:
 	return iommu_dev;
 }
 
-- 
2.55.0.1003.g10538fe699-goog

