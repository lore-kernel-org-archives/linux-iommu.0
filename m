Received: from gfmail1.glenfly.com (gfmail1.glenfly.com [106.75.234.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4D2FC1D
	for <iommu@lists.linux.dev>; Sat, 11 Oct 2025 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.75.234.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760150815; cv=none; b=e2QJJ5bNjHC6Wx164NPjJUODAPG+oR7eX73SWclTrWj/K5l3ElKXJZOtw+jFxJp/vuiJLB4/bZP11wi7JMs8JJ1ROo4aEp7tDCxKqk0o1tPyLMGxElCtGGSkVJ60NXHFxWNn4t00M4jBZG0CVwflQSbF68ZFI8JC1laBt4eztDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760150815; c=relaxed/simple;
	bh=Yhv4pHlqoa8JML2XCsLrnsHokPg6xfTY7V1h7EBTC9c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ogxiY4NUXzMgaCHm3RPNERSeV+P7/R1CVfKXiLPfasO+4ggFQxqZiiYjXOQuojfjq3b8YTsULmWdNmOcwS9qA/10RPjcgPd1IByDU7QUCsi/ji4gncnb9r8VUuveVToIZitRI3kJ5RrRjfO9jWtvtq86Tj66U5ucA42bLQUGW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glenfly.com; spf=pass smtp.mailfrom=glenfly.com; arc=none smtp.client-ip=106.75.234.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glenfly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glenfly.com
X-ASG-Debug-ID: 1760149803-196b4b048bb0da0001-Djp6mn
Received: from GFSHEXCH03.glenfly.com (GFSHEXCH03.glenfly.com [10.5.250.53]) by gfmail1.glenfly.com with ESMTP id wl0dZeELfCuJW1jC (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Sat, 11 Oct 2025 10:30:03 +0800 (CST)
X-Barracuda-Envelope-From: ReaperLiOC@glenfly.com
X-Barracuda-RBL-Trusted-Forwarder: 10.5.250.53
Received: from glenfly.com (10.30.16.59) by GFSHEXCH03.glenfly.com
 (10.5.250.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.59; Sat, 11 Oct
 2025 10:30:03 +0800
From: Reaper Li <reaperlioc@glenfly.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.5.250.53
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<reaperlioc@glenfly.com>
Subject: [PATCH] iommu/arm-smmu-v3: fix probe device bug due to duplicated stream IDS.
Date: Sat, 11 Oct 2025 10:30:03 +0800
X-ASG-Orig-Subj: [PATCH] iommu/arm-smmu-v3: fix probe device bug due to duplicated stream IDS.
Message-ID: <20251011023003.159922-1-reaperlioc@glenfly.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GFSHEXCH02.glenfly.com (10.5.250.52) To
 GFSHEXCH03.glenfly.com (10.5.250.53)
X-Barracuda-Connect: GFSHEXCH03.glenfly.com[10.5.250.53]
X-Barracuda-Start-Time: 1760149803
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.5.252.52:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at glenfly.com
X-Barracuda-Scan-Msg-Size: 1594
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.148472
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_RULE7568M          Custom Rule 7568M

From: Reaper <reaperlioc@glenfly.com>

Commit 9246b487ab3c ("PCI: Add function 0 DMA alias quirk for Glenfly Arise
chip ") add quirk to fix hda dma request issue, but IORT logic populaties
two identical IDs into the fwspec->ids array via DMA aliasing in
iort_pci_iommu_init() called by pci_for_each_dma_alias().

Signed-off-by: ReaperLi <reaperlioc@glenfly.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8b46b94..996d3c0f8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3476,10 +3476,21 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 				rb_entry(existing, struct arm_smmu_stream, node)
 					->master;
 
+			struct device *mdev = master->dev;
+			struct device *existing_mdev = existing_master->dev;
+
 			/* Bridged PCI devices may end up with duplicated IDs */
 			if (existing_master == master)
 				continue;
 
+			/* Dma alias PCI devices may end up with duplicated IDs */
+			if (existing_mdev != mdev &&
+				dev_is_pci(existing_mdev) && dev_is_pci(mdev) &&
+				to_pci_dev(existing_mdev)->bus == to_pci_dev(mdev)->bus &&
+				pci_devs_are_dma_aliases(to_pci_dev(existing_mdev),
+										 to_pci_dev(mdev)))
+				continue;
+
 			dev_warn(master->dev,
 				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
 				 sid, dev_name(existing_master->dev));
-- 
2.34.1

