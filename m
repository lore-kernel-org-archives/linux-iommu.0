Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B755C282DD
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 19:24:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D1D20656
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 19:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="DDuMzPBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D1D20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C1294842FF;
	Tue,  7 Jan 2020 19:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3e7EiKz4W4nS; Tue,  7 Jan 2020 19:24:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5081684029;
	Tue,  7 Jan 2020 19:24:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B444C1796;
	Tue,  7 Jan 2020 19:24:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0DEFC0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 19:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CDD0620454
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 19:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j41tBOb9vV87 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 19:24:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com
 [209.85.166.201])
 by silver.osuosl.org (Postfix) with ESMTPS id 0BC8D20451
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 19:24:50 +0000 (UTC)
Received: by mail-il1-f201.google.com with SMTP id i68so329367ill.23
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jan 2020 11:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=y/3Y+84X8KGEdDu3mHYqqD83QSqQOnGFBhxM1gmAosg=;
 b=DDuMzPBTfb5mTvk2tA0RozQW5ie2aNod7wT4RViu8B/nf9vMcTUrU7ULbhgLqQBN6r
 KDpUsLWDVLM4QYBI+8UBuswpKPwKpQnpknMuen5j0BiphGzq7teMMOLFy+e/ZY6jTqh/
 3/DYSfpKiP2S0EeuJgK0VDUxHz+92VyRWYeGMVYQ1moikKsJf6wuEr5nQIMuZOW1Bolo
 xqcaJ0eZ+JBMgJb79jhkbnOh3Ov2ZsCljwZ9aQetJM0UjKZt1sEEi1JzypSZ5epcWGji
 uPyALoRNMRPwe9iYTwsSzSMaXY1On2suH5Qdh8tiiZUZamEpBJQj/jHiwYyGaYulglN2
 Oniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=y/3Y+84X8KGEdDu3mHYqqD83QSqQOnGFBhxM1gmAosg=;
 b=lqrFYG/5dtXTzEXiPWPkkUT3n1d6iuVkrK2hA8qkdOFcLK/QYl+9V79eKFws+Ks6i8
 MXLk/nF9H7yIAHco0DVvQJ82a2tq6OafIYIhTRdkX7sjOVHTSnH4bO8cDDCRuub5GHxC
 d6B1oPOnXTvHUlFZrQZBCuwt3er5ILaWBjwNoJjjtRYos44xIFJXvuH1owOGWn/v5nqs
 UxGmrs1mvWSAi01G3hOmd2/GInIVX5Eoi77GQ6rKXYdV3xza3/jFq1j2DU3gklzJLIEz
 xsE2ZvTw5yyy5ng53PITrelyKlKOPIGl/HcBbXOO+RMfNIKxxE8RfhmYuG6wlEwOXlx3
 TIvg==
X-Gm-Message-State: APjAAAVEKYt1AZ82worCYfEj1nce1THKGRB79CT2R0mSwyInmIdo6uOx
 6VHUN84K0FsLOLNDp2QMWbEojZmS
X-Google-Smtp-Source: APXvYqzxgfDpppOV0rhBZT5hf3y4f+cubh/6cVj4eEfl3doeV+8L9UDvhdRPV0zPeLffKAyoDzGD3Xav
X-Received: by 2002:a05:620a:911:: with SMTP id
 v17mr822843qkv.251.1578424589791; 
 Tue, 07 Jan 2020 11:16:29 -0800 (PST)
Date: Tue,  7 Jan 2020 14:16:10 -0500
In-Reply-To: <20200107191610.178185-1-brho@google.com>
Message-Id: <20200107191610.178185-3-brho@google.com>
Mime-Version: 1.0
References: <20200107191610.178185-1-brho@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 2/2] iommu/vt-d: skip invalid RMRR entries
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, 
 Yian Chen <yian.chen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
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
From: Barret Rhoden via iommu <iommu@lists.linux-foundation.org>
Reply-To: Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The VT-d docs specify requirements for the RMRR entries base and end
(called 'Limit' in the docs) addresses.

This commit will cause the DMAR processing to skip any RMRR entries that
do not meet these requirements and mark the firmware as tainted, since
the firmware is giving us junk.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 drivers/iommu/intel-iommu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a8bb458845bc..32c3c6338a3d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4315,13 +4315,25 @@ static void __init init_iommu_pm_ops(void)
 static inline void init_iommu_pm_ops(void) {}
 #endif	/* CONFIG_PM */
 
+static int rmrr_validity_check(struct acpi_dmar_reserved_memory *rmrr)
+{
+	if ((rmrr->base_address & PAGE_MASK) ||
+	    (rmrr->end_address <= rmrr->base_address) ||
+	    ((rmrr->end_address - rmrr->base_address + 1) & PAGE_MASK)) {
+		pr_err(FW_BUG "Broken RMRR base: %#018Lx end: %#018Lx\n",
+		       rmrr->base_address, rmrr->end_address);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 {
 	struct acpi_dmar_reserved_memory *rmrr;
 	struct dmar_rmrr_unit *rmrru;
 
 	rmrr = (struct acpi_dmar_reserved_memory *)header;
-	if (arch_rmrr_sanity_check(rmrr)) {
+	if (rmrr_validity_check(rmrr) || arch_rmrr_sanity_check(rmrr)) {
 		WARN_TAINT(1, TAINT_FIRMWARE_WORKAROUND,
 			   "Your BIOS is broken; bad RMRR [%#018Lx-%#018Lx]\n"
 			   "BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-- 
2.24.1.735.g03f4e72817-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
