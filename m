Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC094C4363D
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 02:27:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170162071A
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 02:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+RQeWHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170162071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CE42085F82;
	Wed, 23 Sep 2020 02:27:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WWS2r1VF7XBw; Wed, 23 Sep 2020 02:27:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3ED8A84B1C;
	Wed, 23 Sep 2020 02:27:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10D44C0889;
	Wed, 23 Sep 2020 02:27:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83997C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 02:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7212886373
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 02:27:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ElMVfus9cb8k for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 02:27:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 77F308613C
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 02:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600828023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc; bh=d1zwNE/FijiTofGwoi7ffclzRV65K5GjqX+0bKQ26Fw=;
 b=e+RQeWHE0Gf3iSgehb0xrsN+s7RrTAl9JWBqczmy2vuUo99sJKTX8FJqQZSn8RJM2nSOKt
 5dvDGXImS58KOid4A8VNAPwQIj1o44nXBLL3vwyKrEJ9zSrt8VwEkMaRvJxMItDCwgdK8J
 XHrxFwbXVCs3+2qhqJue6FdeDRH8svA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-L6uzC-czO9mRA6XpsP-sbw-1; Tue, 22 Sep 2020 22:27:00 -0400
X-MC-Unique: L6uzC-czO9mRA6XpsP-sbw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0A2C8027E1;
 Wed, 23 Sep 2020 02:26:58 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-42.pek2.redhat.com
 [10.72.12.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33E3A277B0;
 Wed, 23 Sep 2020 02:26:56 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: joro@8bytes.org,
	ahuang12@lenovo.com
Subject: [PATCH] Revert "iommu/amd: Treat per-device exclusion ranges as r/w
 unity-mapped regions"
Date: Wed, 23 Sep 2020 10:26:55 +0800
Message-Id: <20200923022655.750-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

A regression failure of kdump kernel boot was reported on a HPE system.
Bisect points at commit 387caf0b759ac43 ("iommu/amd: Treat per-device
exclusion ranges as r/w unity-mapped regions") as criminal. Reverting it
fix the failure.

With the commit, kdump kernel will always print below error message, then
naturally AMD iommu can't function normally during kdump kernel bootup.

  ~~~~~~~~~
  AMD-Vi: [Firmware Bug]: IVRS invalid checksum

Why commit 387caf0b759ac43 causing it haven't been made clear.

From the commit log, a discussion thread link is pasted. In that discussion
thread, Adrian told the fix is for a system with already broken BIOS, and
Joerg suggested two options. Finally option 2) is taken. Maybe option 1)
should be the right approach?

  1) Bail out and disable the IOMMU as the BIOS screwed up
  2) Treat per-device exclusion ranges just as r/w unity-mapped
     regions.

https://lists.linuxfoundation.org/pipermail/iommu/2019-November/040117.html
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd/init.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9aa1eae26634..bbe7ceae5949 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1109,17 +1109,22 @@ static int __init add_early_maps(void)
  */
 static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
 {
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
+
 	if (!(m->flags & IVMD_FLAG_EXCL_RANGE))
 		return;
 
-	/*
-	 * Treat per-device exclusion ranges as r/w unity-mapped regions
-	 * since some buggy BIOSes might lead to the overwritten exclusion
-	 * range (exclusion_start and exclusion_length members). This
-	 * happens when there are multiple exclusion ranges (IVMD entries)
-	 * defined in ACPI table.
-	 */
-	m->flags = (IVMD_FLAG_IW | IVMD_FLAG_IR | IVMD_FLAG_UNITY_MAP);
+	if (iommu) {
+		/*
+		 * We only can configure exclusion ranges per IOMMU, not
+		 * per device. But we can enable the exclusion range per
+		 * device. This is done here
+		 */
+		set_dev_entry_bit(devid, DEV_ENTRY_EX);
+		iommu->exclusion_start = m->range_start;
+		iommu->exclusion_length = m->range_length;
+	}
+
 }
 
 /*
-- 
2.17.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
