Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7CC45BD7F
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778080020; cv=none; b=laVyY354D5FP8BsuUdwRVDps96VoujThR8N6vNRKIXOvsT35PJDzxwJ6+k7YUWeTVQREcfCftdsZ3ZeGnhmPKYgxX9zKzhhZB/rsmk/YozlMLootTsXLUVplb7LLl/ekeBbssEsp86X6DrdAiX0DFKLSypJu/Djr9zQSybRAnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778080020; c=relaxed/simple;
	bh=OuisSi4WUPK2fXyPvtufrJOll0ZxMCjuB8pVYGwZG/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWOHWLPa4b6Offc98aCJYnRfCpT84j1DFUZQiy4IcNPNJ8bX5CqA4n8chKwEFWuE78H6/iOZMwR+pxTVUAFzzXIJxRYZYSZITvlm81bgSP9R3BprguTy+8LnUBfXdvuqrC7s4v4PL2giOJsdAFh7WWVVnyN6RxJlXKtwPOmgQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=QIZ9/1Ri; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="QIZ9/1Ri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1778080019; x=1809616019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/rvMeUsp+Th3MTKB/4X5GkEFsXCvCrhahVYSvDtQ1Y=;
  b=QIZ9/1RiELaA68XvmXg7AJdSTJ6d76i5h0vSH70prnLuJMo4fmubXHDE
   dYmvFJ9p/owPih1PU6PBTrU9iODhaPxdKE2+3HYfG865S/tZdCCOxn9bj
   d6mJ/QijeOWrE1mKwjSHgP06ClX7ENWxJQX9XxRzBR60/7KYa1mt47fA0
   rx1G+CjAokQdyVp+9ST3Tokiu72SuYCsl+vQiOmmig4PrPCtYxSo5Wm7J
   qMMOgvsUiKcnC0Vg9dYTGqXWCowrjUEtFXmOTFIcgOrBUzKBsUvxwos7h
   jPmDxi0NLD4FObfebCvbzZj3iOy0wdCEa8z8pFya0hxALC1AZ7MI+yQW0
   w==;
X-CSE-ConnectionGUID: pBgyRvOKTPKCQgsJmnMkdA==
X-CSE-MsgGUID: plt9Ar9xQ5mQMllXEPvCpg==
X-IronPort-AV: E=Sophos;i="6.23,219,1770595200"; 
   d="scan'208";a="19005044"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 15:06:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:23550]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.153:2525] with esmtp (Farcaster)
 id b8767516-fa69-4398-a5c2-3a41f5800182; Wed, 6 May 2026 15:06:55 +0000 (UTC)
X-Farcaster-Flow-ID: b8767516-fa69-4398-a5c2-3a41f5800182
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 6 May 2026 15:06:55 +0000
Received: from dev-dsk-yigitogu-1a-d17f6574.eu-west-1.amazon.com
 (172.19.100.7) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Wed, 6 May 2026
 15:06:53 +0000
From: Yigit Oguz <yigitogu@amazon.de>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<suravee.suthikulpanit@amd.com>
CC: <jgg@ziepe.ca>, <nicolinc@nvidia.com>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Yigit Oguz" <yigitogu@amazon.de>, Lilit Janpoladyan <lilitj@amazon.com>
Subject: [PATCH 2/3] iommu/vt-d: Add PCI segment and vendor:device ID to DMAR fault logs
Date: Wed, 6 May 2026 15:05:38 +0000
Message-ID: <20260506150541.60467-3-yigitogu@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506150541.60467-1-yigitogu@amazon.de>
References: <20260506150541.60467-1-yigitogu@amazon.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Include the full SSSS:BB:DD.F address with PCI segment and
vendor:device ID (VVVV:DDDD) in DMAR fault messages. Uses
iommu->segment for the PCI domain and pci_get_domain_bus_and_slot
to look up the pci_dev. Falls back to segment:BDF without
vendor:device if the device is not found.

This brings Intel IOMMU fault logging in line with the ARM SMMUv3
event decoding, making it easier to identify faulting devices
(e.g. after FLR) without cross-referencing lspci.

Before:
  DMAR: [DMA Write NO_PASID] Request device [86:00.0] fault addr 0xe0000000
	[fault reason 0x05] PTE Write access is not set

After:
  DMAR: [DMA Write NO_PASID] Request device [0000:86:00.0 8086:1533] fault addr 0xe0000000
  	[fault reason 0x05] PTE Write access is not set

Signed-off-by: Yigit Oguz <yigitogu@amazon.de>
Signed-off-by: Lilit Janpoladyan <lilitj@amazon.com>
Assisted-by: Claude:claude-4.6-opus
---
 drivers/iommu/intel/dmar.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d33c119a935e..225fa498d714 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1890,30 +1890,39 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
 {
 	const char *reason;
 	int fault_type;
+	u8 bus = source_id >> 8;
+	u8 devfn = source_id & 0xFF;
+	struct pci_dev *pdev;
+	char devid[48];
 
 	reason = dmar_get_fault_reason(fault_reason, &fault_type);
 
+	pdev = pci_get_domain_bus_and_slot(iommu->segment, bus, devfn);
+	if (pdev) {
+		snprintf(devid, sizeof(devid), "%04x:%02x:%02x.%d %04x:%04x",
+			 iommu->segment, bus, PCI_SLOT(devfn), PCI_FUNC(devfn),
+			 pdev->vendor, pdev->device);
+		pci_dev_put(pdev);
+	} else {
+		snprintf(devid, sizeof(devid), "%04x:%02x:%02x.%d",
+			 iommu->segment, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+	}
+
 	if (fault_type == INTR_REMAP) {
-		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
-		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
-		       PCI_FUNC(source_id & 0xFF), addr >> 48,
-		       fault_reason, reason);
+		pr_err("[INTR-REMAP] Request device [%s] fault index 0x%llx [fault reason 0x%02x] %s\n",
+		       devid, addr >> 48, fault_reason, reason);
 
 		return 0;
 	}
 
 	if (pasid == IOMMU_PASID_INVALID)
-		pr_err("[%s NO_PASID] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[%s NO_PASID] Request device [%s] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write",
-		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
-		       PCI_FUNC(source_id & 0xFF), addr,
-		       fault_reason, reason);
+		       devid, addr, fault_reason, reason);
 	else
-		pr_err("[%s PASID 0x%x] Request device [%02x:%02x.%d] fault addr 0x%llx [fault reason 0x%02x] %s\n",
+		pr_err("[%s PASID 0x%x] Request device [%s] fault addr 0x%llx [fault reason 0x%02x] %s\n",
 		       type ? "DMA Read" : "DMA Write", pasid,
-		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
-		       PCI_FUNC(source_id & 0xFF), addr,
-		       fault_reason, reason);
+		       devid, addr, fault_reason, reason);
 
 	dmar_fault_dump_ptes(iommu, source_id, addr, pasid);
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

