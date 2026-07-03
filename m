Received: from sg-3-44.ptr.tlmpb.com (sg-3-44.ptr.tlmpb.com [101.45.255.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9963B27E9
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070713; cv=none; b=Xy7S23wR1QrhpuKjnCFFfXe2zb7tFAfGeSsw0g0HEe7tumbEaP4Z/66pICa/WnRD5ZTnJ5zAJJ9ZBF9eXhV680qLHgLKDQwNGcWt0GkaPnEmJyMYJ20bHzE78iRQmrJkhF1/Rqh1aBl0/QMvc7fAEKFB+aP7dQ8pmI0Sn7++9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070713; c=relaxed/simple;
	bh=GmIJxHIR4xW2rqpeQ+gYADd/O7XD1jHFzcPZTkElOj0=;
	h=Message-Id:Mime-Version:To:From:Date:In-Reply-To:References:Cc:
	 Subject:Content-Type; b=Cm/OFOCjnvUEw/aempLoD+OsoiIMYuuSUbysqrYo3GAn81s0ZCDGmUKCeg5pWwF5SLyrfMCNsDn2vTCK1/tGM3vqwQZw13wH6WHehFxoIW1fpc91AxpH3JNettQus1Vdgk47C0cVSrAtSVzMjuo6mNyDkxhkU0lYchwSSjGgFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev; spf=pass smtp.mailfrom=liuxiaozhen.dev; dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b=aNnvC5HN; arc=none smtp.client-ip=101.45.255.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liuxiaozhen.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=liuxiaozhen.dev header.i=@liuxiaozhen.dev header.b="aNnvC5HN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2602171341; d=liuxiaozhen.dev; t=1783070660;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=dMekb9OblB3YFnyjXhC7YRqzP6YV7cQ9U/T8KEmbzoo=;
 b=aNnvC5HNH58nXa8WyTYYiW2MQQUgPXT6bK2IdOOR3lOoCVVsnHNhoqwlEelSSnSO4mUJWS
 gHA9ojPH0jR7e6xt14fs4ToPQnN0ueomyuUbo9t6CR1tiqxI8IuPzzt8CveksFtl0AkL9+
 qdyEvDVT+UYWRveJHA9C0SnFhEV9+B8ZRIJXN8SR+gyjBDYaCitBqEFIVe0z4NbY5mxvGy
 1BfZiTKD8E4+WKIA+2IVCCzI1GT7CCRwE+hbPEXNhDpSVMbYWQvjnUMKgqa7m0f5YSu3bL
 7Ks37oB+nQmCQ0nqzVQ9OGdtT6wf6moOL+K8mcluppf1LQdxDzPpq2B5YypR9g==
Message-Id: <20260703092348.17583-1-oliver@liuxiaozhen.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Original-From: Oliver Lin <oliver@liuxiaozhen.dev>
Received: from ThinkPadP15-Gen1 ([23.151.104.73]) by smtp.feishu.cn with ESMTPS; Fri, 03 Jul 2026 17:24:17 +0800
To: <baolu.lu@linux.intel.com>
X-Lms-Return-Path: <lba+26a477fc2+12ef7f+lists.linux.dev+oliver@liuxiaozhen.dev>
Content-Transfer-Encoding: 7bit
From: "Oliver Lin" <oliver@liuxiaozhen.dev>
Date: Fri,  3 Jul 2026 17:23:48 +0800
In-Reply-To: <b744ef83-6cab-4f4f-a22a-251e08b62656@linux.intel.com>
References: <b744ef83-6cab-4f4f-a22a-251e08b62656@linux.intel.com>
Cc: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, 
	<joro@8bytes.org>, <robin.murphy@arm.com>, <will@kernel.org>, 
	"Oliver Lin" <oliver@liuxiaozhen.dev>
Subject: [PATCH v3] iommu/vt-d: Disable IOMMU by default on Lenovo ThinkPad P50s
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=UTF-8

Lenovo ThinkPad P50s exhibits firmware issues when Intel VT-d is enabled.

With IOMMU enabled, the system reports DMAR DMA faults during boot,
TPM 2.0 (tpm_crb) fails to initialize with timeout errors, and the
machine cannot shut down or resume reliably. Booting with
intel_iommu=off avoids these issues.

Add a DMI quirk to disable Intel IOMMU by default on this platform.
If the user explicitly specifies intel_iommu=on on the kernel command
line, do not apply the quirk so that VT-d can still be enabled for
testing and debugging.

Signed-off-by: Oliver Lin <oliver@liuxiaozhen.dev>
---
 drivers/iommu/intel/iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 849d06dfe1ae..b34b5a60f349 100644
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
@@ -278,6 +281,19 @@ static int __init intel_iommu_setup(char *str)
 
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
@@ -2565,6 +2581,13 @@ int __init intel_iommu_init(void)
 	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
 		    platform_optin_force_iommu();
 
+	if (!force_on && !intel_iommu_cmdline_on &&
+    dmi_check_system(intel_iommu_broken_dmar_table)) {
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
