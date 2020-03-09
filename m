Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D02C3F2C6
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 14:11:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2CC22522
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 14:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0zZHAnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2CC22522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9C0468843E;
	Mon,  9 Mar 2020 14:11:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ChYMYI0N9uB; Mon,  9 Mar 2020 14:11:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 42D8A88443;
	Mon,  9 Mar 2020 14:11:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CE1AC1D89;
	Mon,  9 Mar 2020 14:11:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B1CDC0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3B035257B1
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:01:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kCtbLjPtGiVN for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 14:01:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id EA82B2578F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583762510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dwNeQ2bGQI9YeQt7X0VtkLkJtoPfZRFbqYALX2APQi4=;
 b=J0zZHAnr2MVy8YLcGZEVRmPLS/oqMyVTFFYPTfXnVsREe2UntKZoTm2xIIMUKhy2RAX7xV
 4WzQytjO4Naq4PIW80g9Zz/U6zJRJt5XTmvUq0AjAdglUhLww5v3+SxrUCMOG/omLqX0ov
 5Top3XTOXHILj1O2b69mmHD3KNTmzfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-uUEhLOoRPJSOV2WNfFkmqA-1; Mon, 09 Mar 2020 10:01:49 -0400
X-MC-Unique: uUEhLOoRPJSOV2WNfFkmqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6AF5CF98C;
 Mon,  9 Mar 2020 14:01:47 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEFA960C05;
 Mon,  9 Mar 2020 14:01:44 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu/vt-d: dmar_parse_one_rmrr: replace WARN_TAINT with
 pr_warn + add_taint
Date: Mon,  9 Mar 2020 15:01:38 +0100
Message-Id: <20200309140138.3753-3-hdegoede@redhat.com>
In-Reply-To: <20200309140138.3753-1-hdegoede@redhat.com>
References: <20200309140138.3753-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mailman-Approved-At: Mon, 09 Mar 2020 14:11:20 +0000
Cc: Hans de Goede <hdegoede@redhat.com>, iommu@lists.linux-foundation.org,
 Barret Rhoden <brho@google.com>, stable@vger.kernel.org
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
this when these are encountered. The WARN_TAINT in dmar_parse_one_rmrr
+ another iommu WARN_TAINT, addressed in another patch, have lead to over
a 100 bugs being filed this way.

This commit replaces the WARN_TAINT("...") call, with a
pr_warn(FW_BUG "...") + add_taint(TAINT_FIRMWARE_WORKAROUND, ...) call
avoiding the backtrace and thus also avoiding bug-reports being filed
about this against the kernel.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1808874
Fixes: f5a68bb0752e ("iommu/vt-d: Mark firmware tainted if RMRR fails sanity check")
Cc: Barret Rhoden <brho@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iommu/intel-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6fa6de2b6ad5..3857a5cd1a75 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4460,14 +4460,16 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 	struct dmar_rmrr_unit *rmrru;
 
 	rmrr = (struct acpi_dmar_reserved_memory *)header;
-	if (rmrr_sanity_check(rmrr))
-		WARN_TAINT(1, TAINT_FIRMWARE_WORKAROUND,
+	if (rmrr_sanity_check(rmrr)) {
+		pr_warn(FW_BUG
 			   "Your BIOS is broken; bad RMRR [%#018Lx-%#018Lx]\n"
 			   "BIOS vendor: %s; Ver: %s; Product Version: %s\n",
 			   rmrr->base_address, rmrr->end_address,
 			   dmi_get_system_info(DMI_BIOS_VENDOR),
 			   dmi_get_system_info(DMI_BIOS_VERSION),
 			   dmi_get_system_info(DMI_PRODUCT_VERSION));
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+	}
 
 	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
 	if (!rmrru)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
