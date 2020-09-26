Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAA2C2D0A8
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 10:26:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D90E238E5
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 10:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cfs5vJdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D90E238E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B477386B34;
	Sat, 26 Sep 2020 10:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T9IAmoKKNKII; Sat, 26 Sep 2020 10:26:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 226E886B2C;
	Sat, 26 Sep 2020 10:26:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BF11C0890;
	Sat, 26 Sep 2020 10:26:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7323C0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 10:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9934386C59
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 10:26:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPeDq3MdyBgZ for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 10:26:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 924C186BC7
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 10:26:23 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id e4so660537pln.10
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Qc1UwYP9QdaM2Uq0oUSNcfLLWO4N5zpmpQntw/iIfmE=;
 b=Cfs5vJdbDr7cTO/v2ezM4v5IhScmCFYmHRzvFPCXRtp5A7E81+lBnnSeG0EyD3t5Bl
 +CsDikE/tRp0Fe/vO9TVSBq7Cv+nJtvJSZE2ylLyIoFTsDvqOgSxd17Mxqim53/UDxQh
 YTg/IoEOHqxJ9slYtiDQ/vmxzndwd7FxerFnW3674CFwCaaluoqsA0rvQZeUj4qkYeSr
 s/WItQrveHnP9P/9WvgHHVqN6FR0w1Kz6so5YY0f/jGONDEnaPskXYlJnusZZVPNZbcR
 GyfVtW/i4KGezlD7XzN5KBFL78ohMzvYUOTI6K16EtrH9pRQAF+a1GUhzx72CzRMFm6R
 Bp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Qc1UwYP9QdaM2Uq0oUSNcfLLWO4N5zpmpQntw/iIfmE=;
 b=TCL5aDfLEpJTbQ5niE77s4CeGC7Lr9fbff06fKmbVJxRJp9qVez2OAVwEukb/7kV+Q
 PDCCHFlB9C3wXta67x2xOXZvJO5vicPRavq0fLDRvnfefY8fWoTG9xm16W8MvaUia8cq
 Smp0J1FBUpO34X5yAvqeo5Q8/bQTTI+Lb6BDO1wYL8Ng8+1+a255UysUYzphXUMC/oNS
 HB9GW3GyzLv9MZArGom4jnIV06uzTEmR3eMuf1YK/H6rXg92yVf8C5f8w5zD2Pi2GRmX
 vNf/GCIW74bBk1KJxgOceWWfJfADm4fOfMjujPNP7OGhZmYsooEyOlVmPZD4GFNKL9fh
 wYUg==
X-Gm-Message-State: AOAM530Fa36JGlQ47S+/MvzME78CgeXYex4Emd4XdNOxqmrR3bLuJLNX
 /y+XVpzBvntP/2m0IjMsyKQ=
X-Google-Smtp-Source: ABdhPJwUMl8jH/dygzu9qJiy4t4dHFHm8b2z9Q3wPG2fxKX2dNsWvHmhutrJt1kgG3cycvGdc9RqQw==
X-Received: by 2002:a17:902:eb54:b029:d1:f365:a5d2 with SMTP id
 i20-20020a170902eb54b02900d1f365a5d2mr3330823pli.73.1601115983058; 
 Sat, 26 Sep 2020 03:26:23 -0700 (PDT)
Received: from AHUANG12-1LT7M0.lenovo.com
 (2001-b011-e002-911c-e012-3c95-6cb0-1326.dynamic-ip6.hinet.net.
 [2001:b011:e002:911c:e012:3c95:6cb0:1326])
 by smtp.googlemail.com with ESMTPSA id s62sm4506037pgb.91.2020.09.26.03.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2020 03:26:22 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/amd: Fix the overwritten field in IVMD header
Date: Sat, 26 Sep 2020 18:26:02 +0800
Message-Id: <20200926102602.19177-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Adrian Huang <ahuang12@lenovo.com>

Commit 387caf0b759a ("iommu/amd: Treat per-device exclusion
ranges as r/w unity-mapped regions") accidentally overwrites
the 'flags' field in IVMD (struct ivmd_header) when the I/O
virtualization memory definition is associated with the
exclusion range entry. This leads to the corrupted IVMD table
(incorrect checksum). The kdump kernel reports the invalid checksum:

ACPI BIOS Warning (bug): Incorrect checksum in table [IVRS] - 0x5C, should be 0x60 (20200717/tbprint-177)
AMD-Vi: [Firmware Bug]: IVRS invalid checksum

Fix the above-mentioned issue by modifying the 'struct unity_map_entry'
member instead of the IVMD header.

Cleanup: The *exclusion_range* functions are not used anymore, so
get rid of them.

Fixes: 387caf0b759a ("iommu/amd: Treat per-device exclusion ranges as r/w unity-mapped regions")
Reported-and-tested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/init.c | 56 +++++++---------------------------------
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 445a08d23fed..1ba6b4cc56e8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1103,25 +1103,6 @@ static int __init add_early_maps(void)
 	return 0;
 }
 
-/*
- * Reads the device exclusion range from ACPI and initializes the IOMMU with
- * it
- */
-static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
-{
-	if (!(m->flags & IVMD_FLAG_EXCL_RANGE))
-		return;
-
-	/*
-	 * Treat per-device exclusion ranges as r/w unity-mapped regions
-	 * since some buggy BIOSes might lead to the overwritten exclusion
-	 * range (exclusion_start and exclusion_length members). This
-	 * happens when there are multiple exclusion ranges (IVMD entries)
-	 * defined in ACPI table.
-	 */
-	m->flags = (IVMD_FLAG_IW | IVMD_FLAG_IR | IVMD_FLAG_UNITY_MAP);
-}
-
 /*
  * Takes a pointer to an AMD IOMMU entry in the ACPI table and
  * initializes the hardware and our data structures with it.
@@ -2073,30 +2054,6 @@ static void __init free_unity_maps(void)
 	}
 }
 
-/* called when we find an exclusion range definition in ACPI */
-static int __init init_exclusion_range(struct ivmd_header *m)
-{
-	int i;
-
-	switch (m->type) {
-	case ACPI_IVMD_TYPE:
-		set_device_exclusion_range(m->devid, m);
-		break;
-	case ACPI_IVMD_TYPE_ALL:
-		for (i = 0; i <= amd_iommu_last_bdf; ++i)
-			set_device_exclusion_range(i, m);
-		break;
-	case ACPI_IVMD_TYPE_RANGE:
-		for (i = m->devid; i <= m->aux; ++i)
-			set_device_exclusion_range(i, m);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 /* called for unity map ACPI definition */
 static int __init init_unity_map_range(struct ivmd_header *m)
 {
@@ -2107,9 +2064,6 @@ static int __init init_unity_map_range(struct ivmd_header *m)
 	if (e == NULL)
 		return -ENOMEM;
 
-	if (m->flags & IVMD_FLAG_EXCL_RANGE)
-		init_exclusion_range(m);
-
 	switch (m->type) {
 	default:
 		kfree(e);
@@ -2133,6 +2087,16 @@ static int __init init_unity_map_range(struct ivmd_header *m)
 	e->address_end = e->address_start + PAGE_ALIGN(m->range_length);
 	e->prot = m->flags >> 1;
 
+	/*
+	 * Treat per-device exclusion ranges as r/w unity-mapped regions
+	 * since some buggy BIOSes might lead to the overwritten exclusion
+	 * range (exclusion_start and exclusion_length members). This
+	 * happens when there are multiple exclusion ranges (IVMD entries)
+	 * defined in ACPI table.
+	 */
+	if (m->flags & IVMD_FLAG_EXCL_RANGE)
+		e->prot = (IVMD_FLAG_IW | IVMD_FLAG_IR) >> 1;
+
 	DUMP_printk("%s devid_start: %02x:%02x.%x devid_end: %02x:%02x.%x"
 		    " range_start: %016llx range_end: %016llx flags: %x\n", s,
 		    PCI_BUS_NUM(e->devid_start), PCI_SLOT(e->devid_start),
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
