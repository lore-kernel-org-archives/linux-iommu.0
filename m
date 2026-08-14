Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3293D3D09
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672617; cv=none; b=hq+40ImlrcojGnDYAxD4gpBPJmIzEb9/OzleO8VQp9hd7vgU3ZvwC9plBh+P08xYsQwxMtzwpB9KindZvO4pP6NFdg0Jn3BRzIhaZ9oF2AoziQrJPTOB3TctqUkX2AymMQ8mT2UZTfIIBEvnlya8UoEIR2cmzOqH1QfsqROwAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672617; c=relaxed/simple;
	bh=qmV1Q/0KI4p+2B8V3vN0lUGtxGexx4uGynYE7GUfOq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uwln/VbP3QRF/tFcOUolWHKruOgXLGnSYVOglGaCM1sCtLoPM1yKF+rBAgUiVdvX2JKHuYNJOCosXDvPFr94aUpKJuBziShZAX7gC6kWkEh2wcZaXIq2oiAcaNFegfykJMzoMmcdMjqf+i0aQodSoqOY8jgSWXtU5L2AIwqR/fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=At1Z/yEO; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="At1Z/yEO"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbef7b172easo964269a12.0
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 18:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786672615; x=1787277415; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wsMfzFkg0enOrt2eV/SCy7RWuY9LmtCK54cwxYbF5/g=;
        b=At1Z/yEOAv7tE339gmVHzdyycX2TQUOyjA3ZU17YvXoO9knCUEzBRb6Emb9FXeSqTv
         rps3a33OWv+EbIo0JbTKErTSRSSeoOVFurhjLa5m72bOo6LCPGu1fzVb5Aw9d9c2Vdmw
         eYDScnW70fh9RlCtUjaK3keRsinrBNdHgfznl5TFbMS81bM6slJdcteApApQLww/gYQJ
         snjQm+nbcUeQ6MJeSJ7cZejyewrCEZa/do/cpCyDcZfEjk5vAMjIwHdalGu81WVAyAjj
         TlU27STIBP9bcw4A8KSuxeXwf6KzCI00+SdlQReaVAsGiV8KhqtOtlL16GsWZcrs1rWj
         8u2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672615; x=1787277415;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wsMfzFkg0enOrt2eV/SCy7RWuY9LmtCK54cwxYbF5/g=;
        b=D0iCA87ZVYUpTY1oic+5usotuerO+5Q2Of83jhDZHBolmBbmk1BGPq8bJltNMPhiKz
         fRQQUz7xt7736pUo1cKQ3GgIReWdphUP+ZlmFOMfBi7voOnOa5noZO52Q9/LPZoEOjmu
         yOIVuLgShAKob4jMg+xAJT2LqT4x8YzPugIB452BE7+bSbKnFbL+IQQia6ZyokB5c5G1
         h1HWpZ9CbfdmUy6lNFCchSawb71Xp5MsdySC9CUdn4Whvo7mNkOFnHUxTmOTQFdzwRKh
         Benl2ud4KLvHgogEEZkQJVABN/Bg1I14TvGP8DUiG8Zu80CPLaMHzpq4FiEjTxlgclQA
         yGBQ==
X-Gm-Message-State: AOJu0YxGlIwqr9Yefgd6an+BtFNYplD4sYujf2B9E87xIc4A/zJTKjl5
	DbYi1IT8HiVuclGN/6Z959jlcV9lWP5M+5uV9oSVy7yjQT2fmO5oVt2pQI0cOc17+/eguq7WgRf
	2rKJ2+fV+yFnMNd1/jQMnKVCdk5mVTJX07OLekAUe7VHgVJJTo7/U/jP7uHaKIiR9NMO/q9ngwn
	gMXdyYsfZ5ZSF5+d7N2eipd0uWC2HmXg==
X-Received: from dybgo36.prod.google.com ([2002:a05:7301:25a4:b0:315:9b2e:850a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e613:b0:3cc:55ed:dbfa
 with SMTP id adf61e73a8af0-3cc71cd3ee1mr2499125637.27.1786672615150; Thu, 13
 Aug 2026 18:56:55 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:56:44 +0000
In-Reply-To: <20260814015647.3370124-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260814015647.3370124-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814015647.3370124-3-praan@google.com>
Subject: [PATCH v2 2/5] iommu/amd: Fix DTE clearing and rename iommu_ignore_device()
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

Rename the function to iommu_disable_device_dma() more accurately
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
index 9b8ad131ba79..911a95527d74 100644
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
+ * Note: Not to be used on a fully probed device with
+ * live dev_data.
+ */
+static void amd_iommu_disable_dte(struct dev_table_entry *ptr)
+{
+	struct dev_table_entry new = {};
+
+	write_dte_lower128(ptr, &new);
+	write_dte_upper128(ptr, &new);
+}
+
+static void iommu_disable_device_dma(struct amd_iommu *iommu, struct device *dev)
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
+		iommu_disable_device_dma(iommu, dev);
 		goto out_err;
 	}
 
-- 
2.55.0.691.gc56d675ccc-goog

