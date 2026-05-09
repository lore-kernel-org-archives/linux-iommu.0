Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4D372B45
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294778; cv=none; b=I1ZfZV5jENfQdeLCW2TxuFr/3+ZEZfMjfZ3PJnrup2Yp3pYdpHjdgK8YQw+JrJrMhXwUTFXv7LibaO6RT6eFQAXt3Gl1ZYV1dODidt9lPRdiDXNdyFtEy4AkgmgVTDPcdqzwtiOP3SlNm+N579Hy1NHFRpiB34n3YKN/CR8fO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294778; c=relaxed/simple;
	bh=j2IZ8ftFcdseyJPG4Y3mCx8oB6Ve0Hj9MCGAsVr5CnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnDXeA1vPqa2U4NCPeQaJqHa/IpTH7wbJbxHGf1q2iDw4Jf0gRlx8wyhh+LIz3XaS0CqoNbflMb98aoeWi2SuDnV6yMBuUJ1kwGur7o3UUnybqD3fCo1jaFHw7SST5GSnGBuPvMPgcz/GxUlB0Wwu8IwBJl9RdMb7Y98WnEfqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkUBR8YQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkUBR8YQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778294777; x=1809830777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j2IZ8ftFcdseyJPG4Y3mCx8oB6Ve0Hj9MCGAsVr5CnE=;
  b=ZkUBR8YQQQ0FEQV3zeHhwO29W+iCxa5mc2F6ezmaAnvKOQrRltpsO1uP
   tUGpQ/LeOARmoOPaQKnRj7gY+QEkzXNre6d5UvpJsY5R2x9juxtLr4WfT
   UwaGLGHxtepyK59JdonFwVIj2vrati4Z3C7MW6E8pHWqg1BgjG/hE8tXu
   Nt7kd6u/E+wr2S8E15JjCslud8xAJ8QQ4LiUx8pLLnmbMJr+r90COxYyo
   eBcdEDSRQYSz6lmppXsDu29aDlh0PcUuOHXFeZ8975NwjqgK5mrBJmHli
   ExuXa7f/3IBJYzTz9DMjWWvz93Q7DwXH6GktnJiWle21YpNjj96I9C8c0
   Q==;
X-CSE-ConnectionGUID: c2R1CK2FReW1ydlBPTCWSw==
X-CSE-MsgGUID: 9a0LXtiTQvqSVPf7MDXATg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="83142504"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="83142504"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 19:46:17 -0700
X-CSE-ConnectionGUID: QUvbCRx3SaurHUea2YZjWA==
X-CSE-MsgGUID: LJKYb69YQAir1Gj1dHa6Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; 
   d="scan'208";a="236103469"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa010.jf.intel.com with ESMTP; 08 May 2026 19:46:15 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	=?UTF-8?q?Naval=20Alcal=C3=A1?= <ari@naval.cat>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iommu/vt-d: Disable DMAR for Intel Q35 IGFX
Date: Sat,  9 May 2026 10:43:44 +0800
Message-ID: <20260509024348.3516523-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509024348.3516523-1-baolu.lu@linux.intel.com>
References: <20260509024348.3516523-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Naval Alcalá <ari@naval.cat>

Intel Q35 integrated graphics (8086:29b2) exhibits broken DMAR
behaviour similar to other G4x/GM45 devices for which DMAR is
already disabled via quirks.

When DMAR is enabled, the system may hard lock up during boot or
early device initialization, requiring a reset.

Add the missing PCI ID to the existing quirk list to disable
DMAR for this device.

Fixes: 1f76249cc3be ("iommu/vt-d: Declare Broadwell igfx dmar support snafu")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=201185
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216064
Signed-off-by: Naval Alcalá <ari@naval.cat>
Link: https://lore.kernel.org/r/20260410161622.13549-1-ari@naval.cat
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c3d18cd77d2f..2a6b6813a78d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3937,6 +3937,9 @@ static void quirk_iommu_igfx(struct pci_dev *dev)
 	disable_igfx_iommu = 1;
 }
 
+/* Q35 integrated gfx dmar support is totally busted. */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x29b2, quirk_iommu_igfx);
+
 /* G4x/GM45 integrated gfx dmar support is totally busted. */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2a40, quirk_iommu_igfx);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2e00, quirk_iommu_igfx);
-- 
2.43.0

