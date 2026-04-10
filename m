Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6883DB648
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837801; cv=none; b=UwGF4NC2aqzPagzHZaewQ/grxgdQ8iJvkV3pAnPJYSpHY84FmqJmikoK8JWylTTnSl1ezKSXDcUtvkENop7KIc73dkxoE+A8Lrv7RaFCvSE2XgMhmA3kNtXQcH7erVKKKLRVHFEGkLq+tX2e12jDfRSQ0FCKSBIELsm3G10pq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837801; c=relaxed/simple;
	bh=heP25xDBCVEvHfawA5GItZKYTRc9WkwcxkO9qM2grtM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=unCE/ybjf7QyewyfYYMgaQ/9FLOaE9hY3YN45g7FKrtI6mBReRxSR7HV8JIIGWAeupMpGHyeFBpb4B+HK7UJ8GMvKd2mdUT2d3/VLnKi+8mBwUDImFkxo6ZcrMlTvXr+GoFKTuTFjK7zwL8is2PfIEs7icyotMTK8VvhoCNVp7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=naval.cat; spf=pass smtp.mailfrom=naval.cat; dkim=pass (2048-bit key) header.d=naval.cat header.i=@naval.cat header.b=fvkppFad; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=naval.cat
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naval.cat
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naval.cat header.i=@naval.cat header.b="fvkppFad"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 85B9F263D7;
	Fri, 10 Apr 2026 18:16:31 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IRpnkGISFLvz; Fri, 10 Apr 2026 18:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naval.cat; s=mail;
	t=1775837790; bh=heP25xDBCVEvHfawA5GItZKYTRc9WkwcxkO9qM2grtM=;
	h=From:To:Cc:Subject:Date;
	b=fvkppFadRPWa548Bq68W2LxOjQN4SmueKWE+8M4LaQJ/JnulH3KJcV8g4kvfzhhuR
	 5WJKtblnomwZoDfCFY96hgvGmgFJ9x1mVm27K7c+YnvMPXQaxHjDIuvmkL08dNNDrE
	 4pzSW3VGesiv1qP0rMgida6axKg/nkp/TBbkOCqUJvNW4WAFrEL0VhGsUJwzuwmJJy
	 LgWqteBeSLCfm+B94pe6xW28bl0uU03aM0erzLYEUlw/PSfyg3239zAHBZA96cjTPW
	 8lGB5I42S5mrF8JhvbQAoRWnHjIM8tENpGxmOPFYIdayDPKeTAjJrTTCfn2rcXHl4L
	 gZkZRTOqIUAhQ==
From: =?UTF-8?q?Naval=20Alcal=C3=A1?= <ari@naval.cat>
To: 
Cc: =?UTF-8?q?Naval=20Alcal=C3=A1?= <ari@naval.cat>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev (open list:INTEL IOMMU (VT-d)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/vt-d: Disable DMAR for Intel Q35 IGFX
Date: Fri, 10 Apr 2026 18:16:17 +0200
Message-ID: <20260410161622.13549-1-ari@naval.cat>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Intel Q35 integrated graphics (8086:29b2) exhibits broken DMAR
behaviour similar to other G4x/GM45 devices for which DMAR is
already disabled via quirks.

When DMAR is enabled, the system may hard lock up during boot or
early device initialization, requiring a reset.

This issue has been reported multiple times and remains
unresolved:
Link: https://lore.kernel.org/linux-iommu/20161205215841.GA20819@beast/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201185
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216064

Add the missing PCI ID to the existing quirk list to disable
DMAR for this device.

Signed-off-by: Naval Alcalá <ari@naval.cat>
---
 drivers/iommu/intel/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ef7613b177b9..8df0692e1fed 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3933,6 +3933,9 @@ static void quirk_iommu_igfx(struct pci_dev *dev)
 	disable_igfx_iommu = 1;
 }
 
+/* Q35 integrated gfx dmar support is totally busted. */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x29b2, quirk_iommu_igfx);
+
 /* G4x/GM45 integrated gfx dmar support is totally busted. */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2a40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e00, quirk_iommu_igfx);
-- 
2.51.0

