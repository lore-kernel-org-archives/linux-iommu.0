Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61501C3A5A0
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F5D21773
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F5D21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DFF45E27;
	Mon, 19 Aug 2019 13:23:02 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C2D80DA8
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 13:23:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 54A968A6
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 13:23:01 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id DDBDB1C7; Mon, 19 Aug 2019 15:22:58 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 01/11] iommu: Remember when default domain type was set on
	kernel command line
Date: Mon, 19 Aug 2019 15:22:46 +0200
Message-Id: <20190819132256.14436-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819132256.14436-1-joro@8bytes.org>
References: <20190819132256.14436-1-joro@8bytes.org>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	corbet@lwn.net, Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
	Thomas.Lendacky@amd.com, hpa@zytor.com, tglx@linutronix.de
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

From: Joerg Roedel <jroedel@suse.de>

Introduce an extensible concept to remember when certain
configuration settings for the IOMMU code have been set on
the kernel command line.

This will be used later to prevent overwriting these
settings with other defaults.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c674d80c37f..3361ca5ef769 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -32,6 +32,7 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
 static bool iommu_dma_strict __read_mostly = true;
+static u32 iommu_cmd_line __read_mostly;
 
 struct iommu_group {
 	struct kobject kobj;
@@ -68,6 +69,18 @@ static const char * const iommu_group_resv_type_string[] = {
 	[IOMMU_RESV_SW_MSI]			= "msi",
 };
 
+#define IOMMU_CMD_LINE_DMA_API		BIT(0)
+
+static void iommu_set_cmd_line_dma_api(void)
+{
+	iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
+}
+
+static bool __maybe_unused iommu_cmd_line_dma_api(void)
+{
+	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
+}
+
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
 	__ATTR(_name, _mode, _show, _store)
@@ -165,6 +178,8 @@ static int __init iommu_set_def_domain_type(char *str)
 	if (ret)
 		return ret;
 
+	iommu_set_cmd_line_dma_api();
+
 	iommu_def_domain_type = pt ? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAIN_DMA;
 	return 0;
 }
-- 
2.16.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
