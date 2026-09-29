Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA0556B93
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695142; cv=none; b=Vp2gTXVodg2qg6rZRRf47CsjS91JayhsikqcmMM3UFlLYZveh4wzGYOf8tOyzhyTXEhmnmurLizE3D53onketGWuNLlw1L2JYhjMCk52G4wcHAYvzlC1FNh4j8V6z112s/Dqr0Q28aIaCFYlTVKBknWxGiKkA7SML7ufuJQ7syU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695142; c=relaxed/simple;
	bh=zKMcXrgNjt+/vwNaSVtqeRlh5pMoIISoymHB9jKUNz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzQSW3C5QgkNBAJOU+qnQPAxRigndr9Lq+9Q8vFUkFC0eTGeBpkDffYuii4ytm3jPhWV/UChRdUuwLEmxfikS/7GTQC1qRwXF5XjKe7L6USdVLNQ+6Qfmawssb1C8Tz8EO0R/ZENOEm4yJIzu0368iSShIxX0Vd1dLnLiGi/2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novasilicon.dev; spf=pass smtp.mailfrom=novasilicon.dev; dkim=pass (2048-bit key) header.d=novasilicon.dev header.i=@novasilicon.dev header.b=FIjBGX3+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vkzlu8Rl; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=novasilicon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novasilicon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=novasilicon.dev header.i=@novasilicon.dev header.b="FIjBGX3+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vkzlu8Rl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id B1A58138004C;
	Tue, 29 Sep 2026 11:18:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 29 Sep 2026 11:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=novasilicon.dev;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1790695125; x=1790698725; bh=QVJg3PHXJO
	vnNC+I077H+SQLnE6FALr+r0kV8K8/IJ0=; b=FIjBGX3+Y+8Fn/KqFvs9mMkzFJ
	X11aTchD4ot35VZh77KNAmAxhm7N8YoAk8/OB9/qEJ2pLWbQN60y3IrKMd5RUny5
	s95ItACAqo4VA/LlO4sqzw9H/hz610Ou7uS4KLHZTPZ01CjajVjyEDsKqpKKWLD/
	miOzP9Jo3ti5+fboBcxpF6Hsuo36oULv3B96FyTjshR/gdzV/M/nxmtdBNb1mOiV
	MD143Qpkw9DuH7Z8WTQIC8X36jFG6ZMwqP2/VtD96WRq77kqT0J3EKBS3XC6z0Wk
	oSQOhmfyOffsl12sAzFYEOWcs69PVjAMWjUtHoHNJwtFBog0SYVc175J8fkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790695125; x=1790698725; bh=QVJg3PHXJOvnNC+I077H+SQLnE6FALr+r0k
	V8K8/IJ0=; b=vkzlu8RleFIqx+EmWpK9WoMQ3DBDLf0JM31sZ2Em8VPHexDKsI8
	0whhQZ1keMblqaUVFu8313HyCI9si4JHN599CKRwGxC8ZdeLVdcbr01wvb12wFQc
	9HTtQObFN4RfR7dLuEOtzPnkfFVVmY70V2zD7B2geWnRVrL1JroWHAPX3fhdw5bf
	MUizzo+rEPg4S09fZrDsBB50+oAdQHNkXVP49chxKKThEloi6wNWgayuJMRZnDji
	pMq0YAwFrNsEfEuuvZaDG7YNhUcrNa9hiWianClf22ku2HRq4FsNNr50/KksPHED
	B6nGnXbgKy8gEjZ6cwbuITBOAFBiURV6Ilg==
X-ME-Sender: <xms:1Na7auI7c-JfUWqZeAhB_faYfS455G0KGdTHB5KcdhZt9BgyRDNCYA>
    <xme:1Na7am355LE_Kg09nInd4IraKvfBypGSfbfengKzBQfutFIkvG0pBjE3SMgh0loTs
    e7Gu_4EIHOmqrejaXTQusdXyk0YiWir9MQNU3VygjOUZgUS_yk8Fky7>
X-ME-Received: <xmr:1Na7as71xjSqf_hVmu9IKz2C7gldJ8cMhCMqFoY7LKxJruwq4Ti8vM5PkGuJUcpYZJWquU0rLCcw6dXXMZ6q7YtqOylKwhpnG7wBVf5OelZY7vsQtjZvW7VZ0PeNPJiS6KgKuEkEZSS1>
X-ME-Proxy-Cause: dmFkZTFiT1SLmHPRMxxW2ZmVjh19tJuqnLfyUftrCp7hXb1Yx+HotkMRlqzhf2V2Dodzos
    cI1gRxHayodV/Y8DF3LIB2IiwK5gjvAKXW6iC5N9HC4KmKjWLDw5xf2GrAXInF0MJwoRvh
    hlU5/IMehK3L3ITPiey+fqpcbGUwpVwi7ySEeI4UM6p3TbVnwPBkxpVtXXSAmxwiVgiVy5
    EdwiKcNuYaN3578JEInIhU8V93qG8k+pZTqxPUDfE/4kb8chsrUP8nPDsQTaUcaT3vMcNj
    6yUdqPrO3Sb6WvkbgWivmrzR32RdhS87aSYYdX2ucSiuRCwnYb8+WVpZgvML4IxxenoOqr
    7DEA3GH0UaK126AOeaUS2TNRzatSm6QywWY6PKUEGpTBnv7tMiIgT4oZby1dG/j4F74yR7
    mfe7OWXcnbXDXk+Zn6wwPs/5qPTd3WL3SZ8/tGjN57jy989vJ2ZjjlPgzv5W/qR0cFTyS+
    ffEX44fOuVevo1GO9XR0ssq3fpUWemuxyj4YZOAZsljBKDGUHS5bMxYrDRM2L4sSsifZ8K
    COQyj8G+wBJ0Guky4TMjx0m6knHv1KrbopszxuR5+sR7JAPVLksU/uOdTGKirbHdwbnbbs
    L/SDku2y78d9mZoYdeGUI58arkK6FaPrvuM41Jab0rbcR++p7Y2o9XEx41iQ
X-ME-Proxy: <xmx:1Na7an8cw8nUzvfd-KPQU2ZR-5mlbb-xa25IDxb1jbvEh2bHb_tOEw>
    <xmx:1Na7arWXmw7_2QmzHkUj4-j9YhpOEDnrP8SihPGyjoFeP7cQICQb5g>
    <xmx:1Na7aiox0WGPPshy0-WkZwZjjP4yNJYJhLbwW4h0ixcQcstbl7aHRw>
    <xmx:1Na7atlogupKkp5p6fYZYJSZP2fNAB7MioksiPLWTk6i69F4d-Vv8w>
    <xmx:1da7armRoUExUyYFl1OLCsGm-qFaY8LJDw2-gmB36XJja2ZmJT0oeL8T>
Feedback-ID: i6dae4aba:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 11:18:43 -0400 (EDT)
From: Johnathan Chan <johnathanc@novasilicon.dev>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev
Subject: [PATCH] iommu/vt-d: Disable superpages on Haswell
Date: Tue, 29 Sep 2026 11:18:32 -0400
Message-ID: <20260929151832.80069-1-johnathanc@novasilicon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The non-graphics DMAR unit of Haswell client processors reports 2MiB and
1GiB second-level superpage support (SLLPS = 0x3), but DMA that goes
through a 2MiB superpage entry faults:

DMAR: [DMA Read NO_PASID] Request device [00:1f.2] fault addr 0xd1400000
[fault reason 0x0c] non-zero reserved fields in PTE
ata5.00: exception Emask 0x70 SAct 0x100000 SErr 0x440900 action 0x6 frozen
ata5.00: irq_stat 0x28000008, host bus error, interface fatal error
ata5.00: failed command: WRITE FPDMA QUEUED
ata5.00: cmd 61/00:a0:00:88:c5/20:00:39:00:00/40 tag 20 ncq dma 4194304 ou

The fault addresses are always 2MiB aligned. The leaf entries hold only
R, W and PS with a 2MiB aligned output address, which is valid per the
VT-d specification.

Until v6.13 this was hidden. The superpage level of a DMA domain was the
smallest common denominator across all active DMAR units, and the
graphics DMAR unit on these platforms reports SLLPS = 0, so superpages
were never used. An older report shows that the fault appears as soon as
the graphics unit is taken out of the picture with intel_iommu=igfx_off.

Since commit 7c204426b818 ("iommu/vt-d: Add domain_alloc_paging
support"), the superpage capability of a paging domain comes only from
the DMAR unit that serves the device, so on these systems every device
behind the non-graphics unit gets superpage mappings. On an ext4-on-
dm-crypt root on AHCI, large writes fail with I/O errors and the file
system is corrupted. Other reports show the same fault on HD Audio and on
a discrete GPU on Haswell machines.

Disable superpages when a Haswell host bridge is present, which restores
the behaviour these platforms had before v6.13.

Hardware on which this was seen (all fault reason 0x0c, 2MiB aligned):
 - Core i5-4690K, Z97 [8086:0c00], AHCI 00:1f.2
 - Core i7-4790K [8086:0c00], 2MiB coherent DMA buffer
 - ASRock Z97 Extreme6, HD Audio 00:1b.0 (v6.12 good, v6.13-rc6 bad)
 - Core i7-4870HQ (Crystal Well), discrete GPU 01:00.0

Fixes: 7c204426b818 ("iommu/vt-d: Add domain_alloc_paging support")
Cc: stable@vger.kernel.org
Closes: https://bugs.debian.org/1112627
Link: https://github.com/omacom/omarchy/issues/12550
Assisted-by: LLM
Signed-off-by: Johnathan Chan <johnathanc@novasilicon.dev>
---
Notes (not for the changelog):

An LLM assistant was used to analyse the logs, find the culprit commit
and draft the patch and changelog; I reviewed and tested the result.

Tested on i5-4690K / Z97X-UD3H [8086:0c00], ext4 on LVM on dm-crypt on
AHCI:
 - Unpatched v7.0-based kernel: the fault hit in 5 of 6 boots during
   normal use, losing file data.
 - v7.0 + this patch: quirk message printed; no DMAR faults or I/O
   errors after 32GiB of fio 4MiB direct and buffered writes. The
   tested build differed only in comments. Clean with W=1 and sparse.
 - Not tested: the other five IDs (worst case there is the pre-v6.13
   behaviour), and fio on an unpatched kernel without sp_off.

Is there an Intel erratum for this? I found none publicly and would
like to cite it if one exists.

 drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e3b3ab216f8..b108d1476d4b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4034,6 +4034,27 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e30, quirk_iommu_rwbf);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e40, quirk_iommu_rwbf);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e90, quirk_iommu_rwbf);
 
+static void quirk_iommu_no_superpage(struct pci_dev *dev)
+{
+	if (risky_device(dev))
+		return;
+
+	/*
+	 * The non-graphics DMAR unit reports superpage support, but DMA
+	 * through a 2MiB superpage entry faults.
+	 */
+	pci_info(dev, "Disabling IOMMU superpage support\n");
+	intel_iommu_superpage = 0;
+}
+
+/* Haswell DMAR superpage support is broken */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0a04, quirk_iommu_no_superpage);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0c00, quirk_iommu_no_superpage);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0c04, quirk_iommu_no_superpage);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0c08, quirk_iommu_no_superpage);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0d00, quirk_iommu_no_superpage);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x0d04, quirk_iommu_no_superpage);
+
 #define GGC 0x52
 #define GGC_MEMORY_SIZE_MASK	(0xf << 8)
 #define GGC_MEMORY_SIZE_NONE	(0x0 << 8)

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.43.0

