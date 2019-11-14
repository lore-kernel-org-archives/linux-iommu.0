Return-Path: <SRS0=E0xS=ZG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05145C432C3
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 06:15:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF67D206DB
	for <iommu@archiver.kernel.org>; Thu, 14 Nov 2019 06:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="helgkKDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF67D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 557FEAD0;
	Thu, 14 Nov 2019 06:15:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C3675ACD
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 06:15:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 054264C3
	for <iommu@lists.linux-foundation.org>;
	Thu, 14 Nov 2019 06:15:00 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id 29so3027979pgm.6
	for <iommu@lists.linux-foundation.org>;
	Wed, 13 Nov 2019 22:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=pFG7QE3nqjUfCRtw34E4VTg7ua3tIrAigEHp+GEaDvI=;
	b=helgkKDA/YEhwFMQNo+ylZo3JGkZCaBQsO0WR/CyunRdHi4tInn9y3gfXWGGIE6HZq
	IH1a5zAPMYcRjy2gcDbiD+IJzSNbPuqPEGhEtrBNtx4El/CuRc2tCwUYA7IR0gywFNDG
	ptWH1Dhje94oloqsw8uzxPw8zH+1BCPMBMy8F8HfUhg/9tq4Hpnjm2nPDfB0i9/sc7GX
	gavmK+ya/BELIpsfKlGtqgT+6esx0TzA5r4if9yT+y4ack9gX+lGXzHVLufqRP4uHNIK
	FNTECQIkfh6olBfuUOJd9CYa4IwwpcyWMgDDcJfaDHV+f/UmtUV90JRs2aSRvSjnfDyZ
	0xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=pFG7QE3nqjUfCRtw34E4VTg7ua3tIrAigEHp+GEaDvI=;
	b=jAfXGrGqoOpqLzDNC+JEY67wynW9kg6dA7vw0s4wp9OOMZru0jARfosOwYrmY9exTA
	5eKJZ/iKJBKDEgMta0ck6reQ/fEn56NPx4znQxJlz29tSSaMGwqT1Z3IrWwVuy9M7IMa
	q0LUUoGvFKjZ8DcoWc/3c12maR4ajgUAx89FdI29/iJFXQKk7W8FIacpr30E8Y2uNxAY
	Wd/DMEqubQ7P3UfirayXRt6DgkgJ7lY5gSAzp5xRJyXFVUe6IUGbqO2bv7js4jFwuuAa
	ISYuATkRWycPkEaMuGk5nsi8BnPNuUJDu2jYlGyAyhvJwqgSXLVPj3UfQ4qnYcwds27n
	sgeg==
X-Gm-Message-State: APjAAAU8ET4kHg4E1EB18eJ6TNE1BXbLzTu/nVNpRE/d7sJza+DzL/ZN
	qi15AXkQW7V7ZRzylBJlKUU=
X-Google-Smtp-Source: APXvYqyN2z/0ER0+NR12q35TzuYSWw7fJAetQWeyTpmt/sOKfuHLbT9t8OHXI8Coi3YKIBu+YsBjwQ==
X-Received: by 2002:a63:1a14:: with SMTP id a20mr8056080pga.181.1573712100323; 
	Wed, 13 Nov 2019 22:15:00 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com
	(122-121-104-250.dynamic-ip.hinet.net. [122.121.104.250])
	by smtp.googlemail.com with ESMTPSA id
	q1sm4025759pgr.92.2019.11.13.22.14.58
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 13 Nov 2019 22:14:59 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/amd: Treat per-device exclusion ranges as r/w
	unity-mapped regions
Date: Thu, 14 Nov 2019 14:14:47 +0800
Message-Id: <20191114061447.14604-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>
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

Some buggy BIOSes might define multiple exclusion ranges of the
IVMD entries which are associated with the same IOMMU hardware.
This leads to the overwritten exclusion range (exclusion_start
and exclusion_length members) in set_device_exclusion_range().

Here is a real case:
When attaching two Broadcom RAID controllers to a server, the first
one reports the failure during booting (the disks connecting to the
RAID controller cannot be detected).

This patch prevents the issue by treating per-device exclusion
ranges as r/w unity-mapped regions.

Discussion:
  * https://lists.linuxfoundation.org/pipermail/iommu/2019-November/040140.html

Suggested-by: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/iommu/amd_iommu_init.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 568c52317757..1b65302e07b1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -71,6 +71,8 @@
 #define IVHD_FLAG_ISOC_EN_MASK          0x08
 
 #define IVMD_FLAG_EXCL_RANGE            0x08
+#define IVMD_FLAG_IW                    0x04
+#define IVMD_FLAG_IR                    0x02
 #define IVMD_FLAG_UNITY_MAP             0x01
 
 #define ACPI_DEVFLAG_INITPASS           0x01
@@ -1121,16 +1123,14 @@ static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
 	if (!(m->flags & IVMD_FLAG_EXCL_RANGE))
 		return;
 
-	if (iommu) {
-		/*
-		 * We only can configure exclusion ranges per IOMMU, not
-		 * per device. But we can enable the exclusion range per
-		 * device. This is done here
-		 */
-		set_dev_entry_bit(devid, DEV_ENTRY_EX);
-		iommu->exclusion_start = m->range_start;
-		iommu->exclusion_length = m->range_length;
-	}
+	/*
+	 * Treat per-device exclusion ranges as r/w unity-mapped regions
+	 * since some buggy BIOSes might lead to the overwritten exclusion
+	 * range (exclusion_start and exclusion_length members). This
+	 * happens when there are multiple exclusion ranges (IVMD entries)
+	 * defined in ACPI table.
+	 */
+	m->flags = (IVMD_FLAG_IW | IVMD_FLAG_IR | IVMD_FLAG_UNITY_MAP);
 }
 
 /*
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
