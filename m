Received: from va-2-47.ptr.blmpb.com (va-2-47.ptr.blmpb.com [209.127.231.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C6384CFF
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988407; cv=none; b=tjFvXo0zDaaSpp3IPVZ8O9FHiVdIa+AAN0Y2c00NeZwXED867xrwK+e4UAD7B+AlpqV/jRfPfzTDb5HnheLi5sRj52t2ZRLrQqbb4aypDQ6DvLz/OAG+OX623H7AlmLkwpWMrsecPHT6RpVvU7h0B9sdhrQdZ56wU57Ojczulxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988407; c=relaxed/simple;
	bh=nZwYwYMg8Syy6ptlmYhadTDoRFr/Hiecu+eau2AzEHI=;
	h=Content-Type:Subject:To:Cc:From:Message-Id:In-Reply-To:Date:
	 Mime-Version:References; b=U5LsgocI0noZKQL9iYU7KJjtl+atxBPW62oUmYk8nCz7eaSUGAbDSATM0xWbAE5/MC2epVe2X/9A0AXuX9Qtuxm77IR04XyhToMduLhHXDFZa3ZKCCUx7cZjL0fU8V8wKxo4H+EM3vnc2vbAuMHPqnG58X6dLp9yNE02jz0/kO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=HQ7w3UWw; arc=none smtp.client-ip=209.127.231.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="HQ7w3UWw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1782988393;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=NfVIY4wu+NNat4zXsYBCv4STeOf4c/IYuLGn0Xvy4R4=;
 b=HQ7w3UWwI66a/OLvi7ypdvJ1891igKfJKmxTVOcv7xpP/YhMeouy9coeTU4hsGXbTTDrmE
 vAufyfuBaYHTusPEUe0XimRnzs7V/Xs+jm6960pnhPMKSvH/EXHb0tawuMk15pr5EUqG/f
 np246bpNgDKJkFwjIfXIpQGjuqLdEcn0cb27GmJqc+CJKX72O4sK5qpPXW182u/ekpDIHY
 v9LF4PxT0J12Ri9Vs84COBH8594jwJjX8lX/sN2dHxnHhb6Laf+T/WHAAFAMe7rStmYSva
 CD26VVx5GSkmmuv4PwwUZMIzdoBL/6YRvumgy9vnyuY6FXyRgi9evf/0N81b/w==
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] iommu/vt-d: respect user override for intel_iommu=on on Lenovo ThinkPad P50s
Received: from ThinkPadP15-Gen1 ([23.151.104.73]) by smtp.feishu.cn with ESMTPS; Thu, 02 Jul 2026 18:33:10 +0800
X-Lms-Return-Path: <lba+26a463e67+3559ea+lists.linux.dev+oliver@liuxiaozhen.dev>
To: <baolu.lu@linux.intel.com>
Cc: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	<joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>, 
	"oliver" <oliver@liuxiaozhen.dev>
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Message-Id: <20260702103137.508709-1-oliver@liuxiaozhen.dev>
Content-Transfer-Encoding: 7bit
In-Reply-To: <8d131b2c-978e-4aac-88aa-21b39237344a@liuxiaozhen.dev>
Date: Thu,  2 Jul 2026 18:31:37 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0
References: <8d131b2c-978e-4aac-88aa-21b39237344a@liuxiaozhen.dev>

From: oliver <oliver@liuxiaozhen.dev>

The current DMI quirk disables VT-d on ThinkPad P50s unconditionally,
even when intel_iommu=on is explicitly requested via kernel command line.

This breaks kernel parameter precedence and user intent.

Make the quirk conditional so that it does not override explicit user
enabling of Intel IOMMU.

Signed-off-by: Oliver <oliver@liuxiaozhen.dev>
---
 drivers/iommu/intel/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a072e9ef63ef..b34b5a60f349 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -201,6 +201,7 @@ static void intel_iommu_domain_free(struct iommu_domain *domain);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
+static int intel_iommu_cmdline_on;
 
 int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);
@@ -241,10 +242,12 @@ static int __init intel_iommu_setup(char *str)
 	while (*str) {
 		if (!strncmp(str, "on", 2)) {
 			dmar_disabled = 0;
+			intel_iommu_cmdline_on = 1;
 			pr_info("IOMMU enabled\n");
 		} else if (!strncmp(str, "off", 3)) {
 			dmar_disabled = 1;
 			no_platform_optin = 1;
+			intel_iommu_cmdline_on = 0;
 			pr_info("IOMMU disabled\n");
 		} else if (!strncmp(str, "igfx_off", 8)) {
 			disable_igfx_iommu = 1;
@@ -2578,7 +2581,8 @@ int __init intel_iommu_init(void)
 	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
 		    platform_optin_force_iommu();
 
-	if (!force_on && dmi_check_system(intel_iommu_broken_dmar_table)) {
+	if (!force_on && !intel_iommu_cmdline_on &&
+    dmi_check_system(intel_iommu_broken_dmar_table)) {
 		dmar_disabled = 1;
 		no_platform_optin = 1;
 		pr_info("DMAR: IOMMU disabled on Lenovo ThinkPad P50s due to firmware issue\n");
-- 
2.53.0
