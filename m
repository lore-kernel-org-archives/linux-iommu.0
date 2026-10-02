Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF124ACC74
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947918; cv=none; b=BvFs0nGBZU6tk5hKV8LFPffoWpCTpkGXw9qLTEh/Y0mVV6I43Wvag9ZRi5HCAd1WgtwC6BzEUpeD55aKyNmYwktxr5Ochxf485rXsy5nZwoX5/Zd+H78joXZorJ42wPD/uESkcKAUgwOaz4ffqj3wMCqIzKCGhCoO3cje+9MQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947918; c=relaxed/simple;
	bh=osc7Bs2PrTQAuRxp4Vg65RRTN9ESX9QDgpxPBG4dOZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrPfC7QM2RYJcgpeSVDqqVlxMNvNrZ+c0kuMewDJaKbfdoYO2kCLmswoXUOuMscp5OTUNcKMObBm+QJij+H6y6+aa/2OlgUNxtzOaqHwqEo3iIEgvcvtS/Zfekdu1QK0qMVS4KynWdm8+w1oP83gT+FREYrcc7LvW6/UEUdHS50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=dTFmj4Tt; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="dTFmj4Tt"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49fe8bf173aso296955e9.3
        for <iommu@lists.linux.dev>; Fri, 02 Oct 2026 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1790947913; x=1791552713; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9n14yfRryIKsVd2VYTqhCugxHgfRwCkDigMRwboBnXI=;
        b=dTFmj4TtuV0sMvYaI+hy2kf//9tTQk9vf+Y5EPt5ZexztIctMBBXcSesmy/u2+J7iD
         a5Y3XVHIyl7Z05rHW+b2DO2H/4CZR8cAVrBNhhmWeSd/fZFmwZV3rDlMYARfYNVsCQpP
         Nm7mh1zgVe5YT/AJqbK8SQ7MU5tZcfB91ZM3Wlr4MPMG24V+BBY9VSTSfjPaDsSJUlwh
         f84sn7/A1qWcP+txjpSV5MgQ947k9OP4lpWxpa8OL47TXBEPQW0hAdF0qKc2104nbl3b
         qCiP3OULwG1ENIF84gpgUsQSVzG9QLMMqa6OW36kd3W2Ho/vD/Cr0JnwUANui0HRltsn
         eivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790947913; x=1791552713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9n14yfRryIKsVd2VYTqhCugxHgfRwCkDigMRwboBnXI=;
        b=nJArE6a3nHCSdW8YnA/pxOdp43vwO8+BzvAz4moBG4ytEvBdVNdx34SfGb6bNkZOjw
         dnAU3ETcdcF72idw4BEXzFH4F041iSMai35WzVHlT0q4T/0stc5N2PVupV7tSp4Gt0Tv
         wKaMTaUhvgiwBmdlg0C52OAVqc0q8N8hsmlEIeSzPsMGRWFli9Cnd7yS7qUKAl/WhIdt
         wo/xusjwK4yNJa0nGnWX+UO5n444H1VU9TOK5sRL9dCy71sO2WACWALOUCzFDyfqNpSU
         919qw/EC/XbEOg8+LtVDEu8uDa6/j60pBvBsvPS1iaPiKg/YYMEaR4RAB7BzzXB5b7uN
         Bnrg==
X-Forwarded-Encrypted: i=1; AKwUvBz66f0LDT9uO/gJIIE9rLwUjnTmxjAI4fOzj3qk2fPI4Q89KQtTBmD7ulLTZHNuK/jHtGF21w==@lists.linux.dev
X-Gm-Message-State: AFuF++lJH57yfk17k77FrMAoxKr4SMRSlqCcLhZtgNPxsymUF5gTqVTt
	OeMxhs6TtM6YPKEbrV/9oxAcvTdxOgsJByswXZ6o16zLI/jrXWxWRny2K+4HyF356Us=
X-Gm-Gg: AYBFou0ZFhBbXmRM7pN/FRLVt13QnhYDGP16RGvM8WwBHdzKQUSf2VpnbQAYFf8E0LP
	Bwz4cnQ0XWWjzpj043mEJStEqlArUkt6AX/qRX3KtWqlX20Tc7gC9G1g9Rb9D9kHtvb5Z8ZM7yo
	DildA41p3xXq/IV3A21aaUBsqYZ1okfPAmYZ4gwpCvlojbeaGdtLVPqD8nXGvkfbZAbRmKSLi2L
	2okfWPrGQ3dFFTgZzZxw6ZOkCKwOxfcE2ps1BaxFWa2PnDaWPohAS6ZjXqrh6OESfcXRqEL7ErQ
	l4bCaLonc58K542CwyqiTBbAngs+twCmiQvTTej5VMNgK5sEqpjTVoWVOgYZ1C/XqENAAmZlozg
	yTnByfit38pf0+yqJQ5hzpn/1D1h4qGV93ruDEi8ut2yGaMltoltsDJghgE14FWOOUtD8Gz/Og1
	lMR89HTEB/B+YozVtbQR4eLH70fFOqj5OEj3Y3MjietOHt5YLFD/lPwECOmeUQAaL8/HJGlYN0
X-Received: by 2002:a05:600c:46d0:b0:49f:ce73:5e94 with SMTP id 5b1f17b1804b1-4a02769ac69mr53033795e9.34.1790947912805;
        Fri, 02 Oct 2026 06:31:52 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:ebe::178:143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm60543205e9.2.2026.10.02.06.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 06:31:52 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Sairaj Kodilkar <sarunkod@amd.com>,
	Baoquan He <bhe@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH 2/2] iommu/amd: Don't allocate kdump device table from DMA32
Date: Fri,  2 Oct 2026 14:31:43 +0100
Message-ID: <20261002133143.3628181-3-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002133143.3628181-1-matt@readmodwrite.com>
References: <20261002133143.3628181-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Booting a kdump kernel with crashkernel=X,high crashkernel=0,low on an
AMD system fails the per-segment device table allocation because there
is no memory below 4G:

  swapper/0: page allocation failure: order:9, mode:0x40104(GFP_DMA32|__GFP_ZERO|__GFP_COMP)
  iommu_alloc_pages_node_sz+0x7f/0x150
  alloc_pci_segment+0x4bd/0x650
  iommu_go_to_state+0x213d/0x34e0
  amd_iommu_prepare+0x39/0xa0
  irq_remapping_prepare+0x83/0xd0
  enable_IR_x2apic+0x61/0x370

On our E810 systems, the kdump kernel booted but ice MSI-X interrupts
never fired and the TX queues timed out.

Commit b336781b82cc ("iommu/amd: Allocate memory below 4G for dev table
if translation pre-enabled") allocated device tables below 4G. At the
time, the kdump kernel programmed a copy of the old table into the base
register with the IOMMU still enabled. Keeping the table below 4G means
it doesn't matter that the hardware splits that write into two 32-bit
halves.

Since commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
the kdump kernel reuses the previous kernel's table without writing the
base register, so its newly allocated table is discarded when reuse
succeeds. If reuse fails, the previous patch programs the new table only
after disabling the IOMMU. Either way, the kdump kernel's table doesn't
need to be below 4G.

The previous kernel still allocates its table from DMA32, so the kdump
kernel's check that the old table is below 4G still works. Drop
GFP_DMA32 for kdump kernels only.

Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 drivers/iommu/amd/init.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0572e1a674f0..16c26d75f46f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -648,8 +648,19 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_
 /* Allocate per PCI segment device table */
 static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
 {
-	pci_seg->dev_table = iommu_alloc_pages_sz(GFP_KERNEL | GFP_DMA32,
-						  pci_seg->dev_table_size);
+	gfp_t gfp = GFP_KERNEL;
+
+	/*
+	 * Keep normal kernel device tables below 4G because a later kdump
+	 * kernel only trusts and reuses old tables below that limit. A kdump
+	 * kernel's new table is either discarded when reuse succeeds or
+	 * programmed after the IOMMU is disabled, so the table does not
+	 * need DMA32 memory (which the crashkernel may not have).
+	 */
+	if (!is_kdump_kernel())
+		gfp |= GFP_DMA32;
+
+	pci_seg->dev_table = iommu_alloc_pages_sz(gfp, pci_seg->dev_table_size);
 	if (!pci_seg->dev_table)
 		return -ENOMEM;
 
-- 
2.43.0

