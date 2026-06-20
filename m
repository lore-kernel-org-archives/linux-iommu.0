Received: from sg-3-42.ptr.tlmpb.com (sg-3-42.ptr.tlmpb.com [101.45.255.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D082C1FBEBC
	for <iommu@lists.linux.dev>; Sat, 20 Jun 2026 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781983440; cv=none; b=Zg03CEMWvb1e/hgPr882ODheMdwQslYdy5aVFP4danYDtxUHTLBeFWYNY6EOAkfk5qJB9qsMCRctCg1nnFpxbHO5sz/1JVT4bWj0UK0QFgwNEa5rzNCkV+9KjOVeN1pVP8WiwlnRGW0WcXS+pjPSE4r/DYDtnNtVYYZzQ7SwL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781983440; c=relaxed/simple;
	bh=Uc6zHrFk6cv5NcRhEXIhMtxbnnc6HSnWeT/Zd+4hrA0=;
	h=Content-Type:To:From:Mime-Version:Cc:Subject:Date:Message-Id; b=QD1admrilPdue4qXKSHi/TK0ll3mv+Fu8GEVHUxHFSJjK+Y1+CIUQGbSU800iPcolt7lXUI2AHadZcFlYzZA8+QYWNACVGTTfZ+Xelu+YLNKn+pCs3kA/UsQOHgh8nfwgwDlgUBztseWwuSEjH331aGh/r3JtxMeNE3hUOBJRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=uPPFbMnk; arc=none smtp.client-ip=101.45.255.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="uPPFbMnk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1781983386;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rgZ5dPNXc030XtqW79xB/xJMpy5F01dmg5p2NRZxrw4=;
 b=uPPFbMnkcyiUglF0Z4Dg0VWAm9KgNk8toVWe8MgHJ73dtSgWFWEVxVWa1G9KebqpVLJUqX
 zHzueKLy+xxA58bC4ERpHf2ZjBPb4f0IO928cFEovewwoAWNXM+FGo4fNOWfQPB+soy+mf
 xNC77h2LOgoWs0bkGNUIdD+AOXC+YUDNtVacRHODIRFwzdmHPMuHglxdtgn9t2HNW7wAT8
 1R1vy5BbUdBB523W3n8oupj6967ouzsv5MRHvmnHUG8z8uJirGpZxp+CUVlH5ZtnODpuZQ
 5N32JipdH96cAfyrOqlVBdS4dT5akCYBxeXv76yfK36rLGeuLC63h/Y4V5Pi2w==
X-Lms-Return-Path: <lba+26a36e899+5f6071+lists.linux.dev+oliver@liuxiaozhen.dev>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8
To: <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Cc: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>, 
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	"Oliver Lin" <oliver@liuxiaozhen.dev>
Received: from ThinkPadP15-Gen1 ([23.151.104.73]) by smtp.feishu.cn with ESMTPS; Sun, 21 Jun 2026 03:23:04 +0800
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
Content-Transfer-Encoding: 7bit
Subject: [PATCH] iommu/vt-d: Disable IOMMU on Lenovo ThinkPad P50s
Date: Sun, 21 Jun 2026 03:22:14 +0800
Message-Id: <20260620192214.923500-1-oliver@liuxiaozhen.dev>

On Lenovo ThinkPad P50s, enabling Intel IOMMU causes TPM
initialization failures, suspend/resume issues, and prevents the
system from powering off completely.

The system works correctly with intel_iommu=off. A locally tested
kernel with this DMI quirk also works correctly without requiring the
kernel parameter.

Add a DMI quirk to disable Intel IOMMU on this platform.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221674
Signed-off-by: Oliver Lin <oliver@liuxiaozhen.dev>
---
 drivers/iommu/intel/iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 849d06dfe1ae..a072e9ef63ef 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -278,6 +278,19 @@ static int __init intel_iommu_setup(char *str)
 
 	return 1;
 }
+
+static const struct dmi_system_id intel_iommu_broken_dmar_table[] __initconst = {
+	{
+		.ident = "Lenovo ThinkPad P50s",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20FLCTO1WW"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P50s"),
+		},
+	},
+	{}
+};
+
 __setup("intel_iommu=", intel_iommu_setup);
 
 /*
@@ -2565,6 +2578,12 @@ int __init intel_iommu_init(void)
 	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
 		    platform_optin_force_iommu();
 
+	if (!force_on && dmi_check_system(intel_iommu_broken_dmar_table)) {
+		dmar_disabled = 1;
+		no_platform_optin = 1;
+		pr_info("DMAR: IOMMU disabled on Lenovo ThinkPad P50s due to firmware issue\n");
+	}
+
 	down_write(&dmar_global_lock);
 	if (dmar_table_init()) {
 		if (force_on)
-- 
2.53.0
