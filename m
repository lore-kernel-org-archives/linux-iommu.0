Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05693C10F27
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 14:11:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C659321D7E
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 14:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZUl2f/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C659321D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 79BEA8842A;
	Mon,  9 Mar 2020 14:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ydxTog9KwRNL; Mon,  9 Mar 2020 14:11:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 182A78843F;
	Mon,  9 Mar 2020 14:11:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00D50C1D89;
	Mon,  9 Mar 2020 14:11:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5D08C0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:01:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9573686D73
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:01:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yGuPjRCXtX6x for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 14:01:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BDA4D86B2C
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583762508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmrIgOpC5xCUrW/eGnewrWRJsVzMqiKXr2pMquelru0=;
 b=hZUl2f/fnu9QhMG0N78mttj68F6db1q6iGFzhMbNcG27FgtDiPnfXigFR2OSqfYTC1FWWF
 DxoNgQSi0eun6tZj7kJQBQ2SqsSs1WyIzRoEp1j3yY9CW4AhvBOd17w/bR/mSh6/BPPKFZ
 vxNrQrCB3H78DwzOBqKwf6PEWZmkEK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-RMiKwbBMMEaQpN1NK9CkOA-1; Mon, 09 Mar 2020 10:01:46 -0400
X-MC-Unique: RMiKwbBMMEaQpN1NK9CkOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACE6C107ACC9;
 Mon,  9 Mar 2020 14:01:44 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C530A60C87;
 Mon,  9 Mar 2020 14:01:41 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/2] iommu/vt-d: dmar: replace WARN_TAINT with pr_warn +
 add_taint
Date: Mon,  9 Mar 2020 15:01:37 +0100
Message-Id: <20200309140138.3753-2-hdegoede@redhat.com>
In-Reply-To: <20200309140138.3753-1-hdegoede@redhat.com>
References: <20200309140138.3753-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mailman-Approved-At: Mon, 09 Mar 2020 14:11:20 +0000
Cc: Hans de Goede <hdegoede@redhat.com>, iommu@lists.linux-foundation.org,
 stable@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Quoting from the comment describing the WARN functions in
include/asm-generic/bug.h:

 * WARN(), WARN_ON(), WARN_ON_ONCE, and so on can be used to report
 * significant kernel issues that need prompt attention if they should ever
 * appear at runtime.
 *
 * Do not use these macros when checking for invalid external inputs

The (buggy) firmware tables which the dmar code was calling WARN_TAINT
for really are invalid external inputs. They are not under the kernel's
control and the issues in them cannot be fixed by a kernel update.
So logging a backtrace, which invites bug reports to be filed about this,
is not helpful.

Some distros, e.g. Fedora, have tools watching for the kernel backtraces
logged by the WARN macros and offer the user an option to file a bug for
this when these are encountered. The WARN_TAINT in warn_invalid_dmar()
+ another iommu WARN_TAINT, addressed in another patch, have lead to over
a 100 bugs being filed this way.

This commit replaces the WARN_TAINT("...") calls, with
pr_warn(FW_BUG "...") + add_taint(TAINT_FIRMWARE_WORKAROUND, ...) calls
avoiding the backtrace and thus also avoiding bug-reports being filed
about this against the kernel.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1564895
Fixes: e625b4a95d50 ("iommu/vt-d: Parse ANDD records")
Fixes: fd0c8894893c ("intel-iommu: Set a more specific taint flag for invalid BI
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iommu/dmar.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 071bb42bbbc5..87194a46cb0b 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -440,12 +440,13 @@ static int __init dmar_parse_one_andd(struct acpi_dmar_header *header,
 
 	/* Check for NUL termination within the designated length */
 	if (strnlen(andd->device_name, header->length - 8) == header->length - 8) {
-		WARN_TAINT(1, TAINT_FIRMWARE_WORKAROUND,
+		pr_warn(FW_BUG
 			   "Your BIOS is broken; ANDD object name is not NUL-terminated\n"
 			   "BIOS vendor: %s; Ver: %s; Product Version: %s\n",
 			   dmi_get_system_info(DMI_BIOS_VENDOR),
 			   dmi_get_system_info(DMI_BIOS_VERSION),
 			   dmi_get_system_info(DMI_PRODUCT_VERSION));
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
 		return -EINVAL;
 	}
 	pr_info("ANDD device: %x name: %s\n", andd->device_number,
@@ -471,14 +472,14 @@ static int dmar_parse_one_rhsa(struct acpi_dmar_header *header, void *arg)
 			return 0;
 		}
 	}
-	WARN_TAINT(
-		1, TAINT_FIRMWARE_WORKAROUND,
+	pr_warn(FW_BUG
 		"Your BIOS is broken; RHSA refers to non-existent DMAR unit at %llx\n"
 		"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
 		drhd->reg_base_addr,
 		dmi_get_system_info(DMI_BIOS_VENDOR),
 		dmi_get_system_info(DMI_BIOS_VERSION),
 		dmi_get_system_info(DMI_PRODUCT_VERSION));
+	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
 
 	return 0;
 }
@@ -827,14 +828,14 @@ int __init dmar_table_init(void)
 
 static void warn_invalid_dmar(u64 addr, const char *message)
 {
-	WARN_TAINT_ONCE(
-		1, TAINT_FIRMWARE_WORKAROUND,
+	pr_warn_once(FW_BUG
 		"Your BIOS is broken; DMAR reported at address %llx%s!\n"
 		"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
 		addr, message,
 		dmi_get_system_info(DMI_BIOS_VENDOR),
 		dmi_get_system_info(DMI_BIOS_VERSION),
 		dmi_get_system_info(DMI_PRODUCT_VERSION));
+	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
 }
 
 static int __ref
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
