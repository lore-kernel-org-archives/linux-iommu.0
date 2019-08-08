Return-Path: <SRS0=VhCt=WE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542CEC433FF
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 11:06:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E40421479
	for <iommu@archiver.kernel.org>; Thu,  8 Aug 2019 11:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E40421479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D7395108A;
	Thu,  8 Aug 2019 11:06:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EEA241086
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 10:17:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 6538F14D
	for <iommu@lists.linux-foundation.org>;
	Thu,  8 Aug 2019 10:17:15 +0000 (UTC)
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
	helo=localhost) by youngberry.canonical.com with esmtpsa
	(TLS1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.76)
	(envelope-from <kai.heng.feng@canonical.com>)
	id 1hvfTt-0002dR-0f; Thu, 08 Aug 2019 10:17:13 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: joro@8bytes.org
Subject: [PATCH] iommu/amd: Override wrong IVRS IOAPIC on Raven Ridge systems
Date: Thu,  8 Aug 2019 18:17:07 +0800
Message-Id: <20190808101707.16783-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 08 Aug 2019 11:06:51 +0000
Cc: iommu@lists.linux-foundation.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Raven Ridge systems may have malfunction touchpad or hang at boot if
incorrect IVRS IOAPIC is provided by BIOS.

Users already found correct "ivrs_ioapic=" values, let's put them inside
kernel to workaround buggy BIOS.

BugLink: https://bugs.launchpad.net/bugs/1795292
BugLink: https://bugs.launchpad.net/bugs/1837688
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/iommu/amd_iommu_init.c | 75 ++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 4413aa67000e..06fd008281e5 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -21,6 +21,7 @@
 #include <linux/iommu.h>
 #include <linux/kmemleak.h>
 #include <linux/mem_encrypt.h>
+#include <linux/dmi.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/apic.h>
@@ -1109,6 +1110,78 @@ static int __init add_early_maps(void)
 	return 0;
 }
 
+struct quirk_entry {
+	u8 id;
+	u16 devid;
+};
+
+enum {
+	DELL_INSPIRON_7375 = 0,
+	DELL_LATITUDE_5495,
+	LENOVO_IDEAPAD_330S_15ARR,
+};
+
+static const struct quirk_entry ivrs_ioapic_quirks[][3] __initconst = {
+	/* ivrs_ioapic[4]=00:14.0 ivrs_ioapic[5]=00:00.2 */
+	[DELL_INSPIRON_7375] = {
+		{ .id = 4, .devid = 0xa0 },
+		{ .id = 5, .devid = 0x2 },
+		{}
+	},
+	/* ivrs_ioapic[4]=00:14.0 */
+	[DELL_LATITUDE_5495] = {
+		{ .id = 4, .devid = 0xa0 },
+		{}
+	},
+	/* ivrs_ioapic[32]=00:14.0 */
+	[LENOVO_IDEAPAD_330S_15ARR] = {
+		{ .id = 32, .devid = 0xa0 },
+		{}
+	},
+	{}
+};
+
+static int __init ivrs_ioapic_quirk_cb(const struct dmi_system_id *d)
+{
+	const struct quirk_entry *i;
+
+	for (i = d->driver_data; i->id != 0 && i->devid != 0; i++)
+		add_special_device(IVHD_SPECIAL_IOAPIC, i->id, &i->devid, 0);
+
+	return 0;
+}
+
+static const struct dmi_system_id ivrs_quirks[] __initconst = {
+	{
+		.callback = ivrs_ioapic_quirk_cb,
+		.ident = "Dell Inspiron 7375",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7375"),
+		},
+		.driver_data = (void *)&ivrs_ioapic_quirks[DELL_INSPIRON_7375],
+	},
+	{
+		.callback = ivrs_ioapic_quirk_cb,
+		.ident = "Dell Latitude 5495",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 5495"),
+		},
+		.driver_data = (void *)&ivrs_ioapic_quirks[DELL_LATITUDE_5495],
+	},
+	{
+		.callback = ivrs_ioapic_quirk_cb,
+		.ident = "Lenovo ideapad 330S-15ARR",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "81FB"),
+		},
+		.driver_data = (void *)&ivrs_ioapic_quirks[LENOVO_IDEAPAD_330S_15ARR],
+	},
+	{}
+};
+
 /*
  * Reads the device exclusion range from ACPI and initializes the IOMMU with
  * it
@@ -1153,6 +1226,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	if (ret)
 		return ret;
 
+	dmi_check_system(ivrs_quirks);
+
 	/*
 	 * First save the recommended feature enable bits from ACPI
 	 */
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
