Return-Path: <SRS0=VpBQ=XT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B99C432C1
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 12:02:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D743B20872
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 12:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D743B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AB993CF6;
	Tue, 24 Sep 2019 12:02:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6AF17CD1
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 12:02:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CDD6D87D
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 12:01:58 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Sep 2019 05:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; d="scan'208";a="389834451"
Received: from black.fi.intel.com ([10.237.72.28])
	by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2019 05:01:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6705C338; Tue, 24 Sep 2019 15:01:54 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Subject: [PATCH v1 4/5] mmc: sdhci-acpi: Switch to use acpi_dev_hid_uid_match()
Date: Tue, 24 Sep 2019 15:01:52 +0300
Message-Id: <20190924120153.8382-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924120153.8382-1-andriy.shevchenko@linux.intel.com>
References: <20190924120153.8382-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Since we have a generic helper, drop custom implementation in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 49 ++++++++++++-----------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 1604f512c7bd..f913c3f57bbf 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -61,7 +61,7 @@ struct sdhci_acpi_slot {
 	mmc_pm_flag_t	pm_caps;
 	unsigned int	flags;
 	size_t		priv_size;
-	int (*probe_slot)(struct platform_device *, const char *, const char *);
+	int (*probe_slot)(struct platform_device *, struct acpi_device *);
 	int (*remove_slot)(struct platform_device *);
 	int (*free_slot)(struct platform_device *pdev);
 	int (*setup_host)(struct platform_device *pdev);
@@ -325,12 +325,10 @@ static bool sdhci_acpi_cht_pci_wifi(unsigned int vendor, unsigned int device,
  * wifi card in the expected slot with an ACPI companion node, is used to
  * indicate that acpi_device_fix_up_power() should be avoided.
  */
-static inline bool sdhci_acpi_no_fixup_child_power(const char *hid,
-						   const char *uid)
+static inline bool sdhci_acpi_no_fixup_child_power(struct acpi_device *adev)
 {
 	return sdhci_acpi_cht() &&
-	       !strcmp(hid, "80860F14") &&
-	       !strcmp(uid, "2") &&
+	       acpi_dev_hid_uid_match(adev, "80860F14", "2") &&
 	       sdhci_acpi_cht_pci_wifi(0x14e4, 0x43ec, 0, 28);
 }
 
@@ -345,8 +343,7 @@ static inline bool sdhci_acpi_byt_defer(struct device *dev)
 	return false;
 }
 
-static inline bool sdhci_acpi_no_fixup_child_power(const char *hid,
-						   const char *uid)
+static inline bool sdhci_acpi_no_fixup_child_power(struct acpi_device *adev)
 {
 	return false;
 }
@@ -375,19 +372,18 @@ static int bxt_get_cd(struct mmc_host *mmc)
 	return ret;
 }
 
-static int intel_probe_slot(struct platform_device *pdev, const char *hid,
-			    const char *uid)
+static int intel_probe_slot(struct platform_device *pdev, struct acpi_device *adev)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct intel_host *intel_host = sdhci_acpi_priv(c);
 	struct sdhci_host *host = c->host;
 
-	if (hid && uid && !strcmp(hid, "80860F14") && !strcmp(uid, "1") &&
+	if (acpi_dev_hid_uid_match(adev, "80860F14", "1") &&
 	    sdhci_readl(host, SDHCI_CAPABILITIES) == 0x446cc8b2 &&
 	    sdhci_readl(host, SDHCI_CAPABILITIES_1) == 0x00000807)
 		host->timeout_clk = 1000; /* 1000 kHz i.e. 1 MHz */
 
-	if (hid && !strcmp(hid, "80865ACA"))
+	if (acpi_dev_hid_uid_match(adev, "80865ACA", NULL))
 		host->mmc_host_ops.get_cd = bxt_get_cd;
 
 	intel_dsm_init(intel_host, &pdev->dev, host->mmc);
@@ -473,8 +469,7 @@ static irqreturn_t sdhci_acpi_qcom_handler(int irq, void *ptr)
 	return IRQ_HANDLED;
 }
 
-static int qcom_probe_slot(struct platform_device *pdev, const char *hid,
-			   const char *uid)
+static int qcom_probe_slot(struct platform_device *pdev, struct acpi_device *adev)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct sdhci_host *host = c->host;
@@ -482,7 +477,7 @@ static int qcom_probe_slot(struct platform_device *pdev, const char *hid,
 
 	*irq = -EINVAL;
 
-	if (strcmp(hid, "QCOM8051"))
+	if (acpi_dev_hid_uid_match(adev, "QCOM8051", NULL))
 		return 0;
 
 	*irq = platform_get_irq(pdev, 1);
@@ -501,14 +496,12 @@ static int qcom_free_slot(struct platform_device *pdev)
 	struct sdhci_host *host = c->host;
 	struct acpi_device *adev;
 	int *irq = sdhci_acpi_priv(c);
-	const char *hid;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
 		return -ENODEV;
 
-	hid = acpi_device_hid(adev);
-	if (strcmp(hid, "QCOM8051"))
+	if (!acpi_dev_hid_uid_match(adev, "QCOM8051", NULL))
 		return 0;
 
 	if (*irq < 0)
@@ -583,7 +576,7 @@ static const struct sdhci_acpi_chip sdhci_acpi_chip_amd = {
 };
 
 static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
-					  const char *hid, const char *uid)
+					  struct acpi_device *adev)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
 	struct sdhci_host *host   = c->host;
@@ -654,17 +647,12 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
-static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
-							 const char *uid)
+static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(struct acpi_device *adev)
 {
 	const struct sdhci_acpi_uid_slot *u;
 
 	for (u = sdhci_acpi_uids; u->hid; u++) {
-		if (strcmp(u->hid, hid))
-			continue;
-		if (!u->uid)
-			return u->slot;
-		if (uid && !strcmp(u->uid, uid))
+		if (acpi_dev_hid_uid_match(adev, u->hid, u->uid))
 			return u->slot;
 	}
 	return NULL;
@@ -680,22 +668,17 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	struct resource *iomem;
 	resource_size_t len;
 	size_t priv_size;
-	const char *hid;
-	const char *uid;
 	int err;
 
 	device = ACPI_COMPANION(dev);
 	if (!device)
 		return -ENODEV;
 
-	hid = acpi_device_hid(device);
-	uid = acpi_device_uid(device);
-
-	slot = sdhci_acpi_get_slot(hid, uid);
+	slot = sdhci_acpi_get_slot(device);
 
 	/* Power on the SDHCI controller and its children */
 	acpi_device_fix_up_power(device);
-	if (!sdhci_acpi_no_fixup_child_power(hid, uid)) {
+	if (!sdhci_acpi_no_fixup_child_power(device)) {
 		list_for_each_entry(child, &device->children, node)
 			if (child->status.present && child->status.enabled)
 				acpi_device_fix_up_power(child);
@@ -745,7 +728,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 
 	if (c->slot) {
 		if (c->slot->probe_slot) {
-			err = c->slot->probe_slot(pdev, hid, uid);
+			err = c->slot->probe_slot(pdev, device);
 			if (err)
 				goto err_free;
 		}
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
