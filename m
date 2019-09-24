Return-Path: <SRS0=VpBQ=XT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206B4C432C2
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 19:37:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B8E217D7
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 19:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B8E217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6D8CEDC3;
	Tue, 24 Sep 2019 19:37:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 228AEC5D
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 19:37:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A594587D
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 19:37:46 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Sep 2019 12:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,545,1559545200"; d="scan'208";a="201009978"
Received: from black.fi.intel.com ([10.237.72.28])
	by orsmga002.jf.intel.com with ESMTP; 24 Sep 2019 12:37:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B5A22E3; Tue, 24 Sep 2019 22:37:42 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/6] ACPI / utils: Describe function parameters in
	kernel-doc
Date: Tue, 24 Sep 2019 22:37:34 +0300
Message-Id: <20190924193739.86133-2-andriy.shevchenko@linux.intel.com>
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

Kernel documentation script complains that some of the function parameters
are not described:

drivers/acpi/utils.c:462: warning: Function parameter or member 'handle' not described in 'acpi_handle_path'
drivers/acpi/utils.c:484: warning: Function parameter or member 'level' not described in 'acpi_handle_printk'
drivers/acpi/utils.c:484: warning: Function parameter or member 'handle' not described in 'acpi_handle_printk'
drivers/acpi/utils.c:484: warning: Function parameter or member 'fmt' not described in 'acpi_handle_printk'
drivers/acpi/utils.c:513: warning: Function parameter or member 'descriptor' not described in '__acpi_handle_debug'
drivers/acpi/utils.c:513: warning: Function parameter or member 'handle' not described in '__acpi_handle_debug'
drivers/acpi/utils.c:513: warning: Function parameter or member 'fmt' not described in '__acpi_handle_debug'

Describe function parameters where it's appropriate.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/utils.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index e3974a8f8fd4..dbd1c4cfd7d1 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -455,6 +455,7 @@ EXPORT_SYMBOL(acpi_evaluate_ost);
 
 /**
  * acpi_handle_path: Return the object path of handle
+ * @handle: ACPI device handle
  *
  * Caller must free the returned buffer
  */
@@ -473,6 +474,9 @@ static char *acpi_handle_path(acpi_handle handle)
 
 /**
  * acpi_handle_printk: Print message with ACPI prefix and object path
+ * @level: log level
+ * @handle: ACPI device handle
+ * @fmt: format string
  *
  * This function is called through acpi_handle_<level> macros and prints
  * a message with ACPI prefix and object path.  This function acquires
@@ -501,6 +505,9 @@ EXPORT_SYMBOL(acpi_handle_printk);
 #if defined(CONFIG_DYNAMIC_DEBUG)
 /**
  * __acpi_handle_debug: pr_debug with ACPI prefix and object path
+ * @descriptor: Dynamic Debug descriptor
+ * @handle: ACPI device handle
+ * @fmt: format string
  *
  * This function is called through acpi_handle_debug macro and debug
  * prints a message with ACPI prefix and object path. This function
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
