Return-Path: <SRS0=VpBQ=XT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE07C4360C
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 19:37:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA6F214AF
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 19:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA6F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4A000CF3;
	Tue, 24 Sep 2019 19:37:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0C99CC5C
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 19:37:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A5A9889D
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 19:37:46 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Sep 2019 12:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,545,1559545200"; d="scan'208";a="272735864"
Received: from black.fi.intel.com ([10.237.72.28])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2019 12:37:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D8A5F1C5; Tue, 24 Sep 2019 22:37:42 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Subject: [PATCH v2 4/6] ACPI / LPSS: Switch to use acpi_dev_hid_uid_match()
Date: Tue, 24 Sep 2019 22:37:37 +0300
Message-Id: <20190924193739.86133-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
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
 drivers/acpi/acpi_lpss.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index d696f165a50e..1e6d959bd968 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -476,31 +476,16 @@ static const struct lpss_device_links lpss_device_links[] = {
 	{"80860F41", "5", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
 };
 
-static bool hid_uid_match(struct acpi_device *adev,
-			  const char *hid2, const char *uid2)
-{
-	const char *hid1 = acpi_device_hid(adev);
-	const char *uid1 = acpi_device_uid(adev);
-
-	if (strcmp(hid1, hid2))
-		return false;
-
-	if (!uid2)
-		return true;
-
-	return uid1 && !strcmp(uid1, uid2);
-}
-
 static bool acpi_lpss_is_supplier(struct acpi_device *adev,
 				  const struct lpss_device_links *link)
 {
-	return hid_uid_match(adev, link->supplier_hid, link->supplier_uid);
+	return acpi_dev_hid_uid_match(adev, link->supplier_hid, link->supplier_uid);
 }
 
 static bool acpi_lpss_is_consumer(struct acpi_device *adev,
 				  const struct lpss_device_links *link)
 {
-	return hid_uid_match(adev, link->consumer_hid, link->consumer_uid);
+	return acpi_dev_hid_uid_match(adev, link->consumer_hid, link->consumer_uid);
 }
 
 struct hid_uid {
@@ -516,7 +501,7 @@ static int match_hid_uid(struct device *dev, const void *data)
 	if (!adev)
 		return 0;
 
-	return hid_uid_match(adev, id->hid, id->uid);
+	return acpi_dev_hid_uid_match(adev, id->hid, id->uid);
 }
 
 static struct device *acpi_lpss_find_device(const char *hid, const char *uid)
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
