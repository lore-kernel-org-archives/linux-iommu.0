Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1976417D87
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574242; cv=none; b=CxdvWURqRfQ4czUiIXeHa1X636hZzsWfRDNVHXFZ2k1Q45LObcrbYHOhAjdKl573GwfKMljI4CBZ15TWEUoZh92fae1dprFjrYd4Xq2LC68uqc3jySwnsYnSthtwDpK35STCmcCOCFFLq1Xi07uDMXHnh/omd7fxfJT2L02o5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574242; c=relaxed/simple;
	bh=utWFHovcSEde6W/vWMYRzwYuhpxsLViMJhURbUW/E2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KmJKzTu1LEov7v9fo9fpIiLb7NyfRjYhAkcUF+9tKKR0cZAa+sXnSwIhV2tEGDWbSUSIhPcK1XHchnjkLbVSF0MquSzRQnSceJ3hFWxVimbyPvWZhJsKmoxNYCTTv6Euc4/jQFFsF+PASsigRax/1tdk6YPh7IPAwPSW7QQPHZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z7REUUWV; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7REUUWV"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84f0d3ab2f4so2511313b3a.1
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787574240; x=1788179040; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2J3oy2a4JSIFvlr7/nvXqs5ymVUNBWbqafx9KZERE8s=;
        b=Z7REUUWVpxpRJeY45kcFJVlfc8aTvvWsrQj85gdA88/XRs2oUAddetUCwKynEU/XQW
         e6mlCjNRAKejx8dPcP2H7PwNoeWITqjh/u0bynSSPHKpL9X52iOn9NbIm4ttuutJ3pS6
         0nIDzq/CupwaMqA679c6h8Nfy0Oi/9LPGFxYPVHwko5ZDE3omSI9BQOs9JJKRwwwsGVr
         o2IY09F5uOcTd2QKb6d4mAhyybSLVAko9pJsSS94877irdQsF0dWi7LKXOKEECPVLrEY
         oKbqfOOnEs8hn6vgfi3aYfrTH6o9z2t4XoygHiHpOyNw2mgwUVEwOWiH7yq/x/KDpvyO
         W49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574240; x=1788179040;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2J3oy2a4JSIFvlr7/nvXqs5ymVUNBWbqafx9KZERE8s=;
        b=qbWAmmo1mM9CBg1z5lAOQ23gWZMLswa6lw/u8Z2MRutP5BNyn9raLCBkXZnK9CD3Ir
         Bm61oXvkC7U9jPZnyGDI7Wn6tUmWpXT1jt3+8uMevmBOWkZqgj8Zq5ZM26Di4vzv+wN0
         j8uDipARt4ET3rkYL3UT3RkVQer05f48k1RoBpqokhmIe59DRKQDZVW7+k0zTrxeXA5y
         Zh16S4YRY8I2U0h11tS+pQfupJpo2hB+EZLnHeMkC06VgYFJDeY9XCTCsj+y917hJm3B
         Yfy8yFLBMYM+0xb5jtV+GEou+GOlf0CCg/V5vF3+SwOYKqnlNQIBvRpH90Ied0F8q1Ht
         0BIQ==
X-Gm-Message-State: AFuF++lDVRexavSzYx7BCu+ELxfFhAOugHaHQLlF+xP7u3yaV4phEaL6
	PeksD352d4kj640Hg1Qu72YwfOcKyd2bRAo37lt9wjy7atV3k4t5wT+ocK3mh2JWR3Rr0xViW3b
	yfbOKQAEBMHkTS8K25QiA1b7b8sa2AgGlzJUlbWxPPIWHgoWVuMGWCKCPa3lJxtk8zFvDprR6ly
	MvxEksmUshIlKiUWh5mABW65/zU8IaOA==
X-Received: from pfbea20.prod.google.com ([2002:a05:6a00:4c14:b0:848:5453:d5d1])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2383:b0:835:6388:655d
 with SMTP id d2e1a72fcca58-8520ba30a62mr27879947b3a.14.1787574239879; Mon, 24
 Aug 2026 05:23:59 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:23:44 +0000
In-Reply-To: <20260824122347.1588592-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260824122347.1588592-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824122347.1588592-3-praan@google.com>
Subject: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename iommu_ignore_device()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

The iommu_ignore_device() function currently uses memset() to manually
clear the primary Device Table Entry (DTE), which risks torn writes as
the hardware reads DTEs as atomic 256-bit qwords. Furthermore, clearing
the primary devid in the lookup table before calling setup_aliases()
causes rlookup_amd_iommu() to fail for aliases. This prevents clearing
the DTEs for DMA aliases.

Fix this by replacing the manual memset with a dedicated helper that
invalidates the DTE by clearing the lower 128 bits (having the Valid bit)
first, followed by the upper 128 bits. The cleared state is then
explicitly cloned to all aliases before the lookup tables are nullified.

Rename the function to iommu_disable_device() more accurately
reflects its intent, as we still support IRQ remapping for these devices)

Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 53 ++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e1f9fbb63837..8e382317709d 100644
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
@@ -2233,6 +2217,41 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 		clear_dte_entry(iommu, dev_data);
 }
 
+/*
+ * Invalidate a DTE by clearing the Valid bit first.
+ * Note: Lockless; Not to be used on a fully probed
+ * device with live dev_data.
+ */
+static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
+{
+	struct dev_table_entry new = {};
+
+	write_dte_lower128(ptr, &new);
+	write_dte_upper128(ptr, &new);
+}
+
+static void iommu_disable_device(struct amd_iommu *iommu, struct device *dev)
+{
+	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	int devid, sbdf;
+
+	sbdf = get_device_sbdf_id(dev);
+	if (sbdf < 0)
+		return;
+
+	devid = PCI_SBDF_TO_DEVID(sbdf);
+
+	/* Clear the primary DTE */
+	amd_iommu_disable_dte(&dev_table[devid]);
+
+	/* Clone the cleared DTE to all aliases before wiping the rlookup */
+	if (dev_iommu_priv_get(dev))
+		clone_aliases(iommu, dev);
+
+	pci_seg->rlookup_table[devid] = NULL;
+}
+
 /*
  * If domain is SVA capable then initialize GCR3 table. Also if domain is
  * in v2 page table mode then update GCR3[0].
@@ -2521,7 +2540,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		ret = PTR_ERR(dev_data);
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
-		iommu_ignore_device(iommu, dev);
+		iommu_disable_device(iommu, dev);
 		goto out_err;
 	}
 
-- 
2.55.0.766.g2966f0265a-goog

