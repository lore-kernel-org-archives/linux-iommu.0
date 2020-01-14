Return-Path: <SRS0=+KdK=3D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4612BC33CB1
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 15:17:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0897D222C4
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 15:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UXrUv4mD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0897D222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D358986C03;
	Tue, 14 Jan 2020 15:17:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C8ooIgrrjAg8; Tue, 14 Jan 2020 15:17:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40FBB8545D;
	Tue, 14 Jan 2020 15:16:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28E77C18DD;
	Tue, 14 Jan 2020 15:16:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C2DEC077D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 15:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0938B86074
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 15:12:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uKNd82w+wJTz for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jan 2020 15:12:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CD649839C1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 15:12:23 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id i7so5757853ioo.5
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nkGZG7SrCg/dkC5ag7U6FC/+BJoAtyAPaz4N+sK3NTU=;
 b=UXrUv4mDNhE+LH+9At0LmtyxUu2Z40+9NS0Ktltdfw4q6iyq6yksNKateEPraVHvkM
 b9GWB7C4mBdDiOES6HOfWXBe/0MMUg5+9nNgoB52WFEDKHAt8UkdzxeI+IadsQBCsBd5
 EArO0SwQWXOGFiXKu7oun4s5rm2kd2HdlRlto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nkGZG7SrCg/dkC5ag7U6FC/+BJoAtyAPaz4N+sK3NTU=;
 b=R/bIIC2NUnM6uu7fw67I5m2qFLN1eJwxBlvXTgVQH3F+B0UNSkkfN256Vuh4L54iUV
 MlHcMnJ4wHUUVhPKvTJnGp0GuLy6/NLDmG/9CbjYG/cbn7GYO1V6qs0NrQD+0sMYe5/q
 +AlJTnZ38n4Kgy3F9gqivB4XyODEl9xd8PvSgTxudTHC502QdVdnFfYeqscYe2yp7K6B
 c+GQcsaIYL4rG4AuqNjpecc5agDr9+VeB/9l6jwzFZ5TLdfHIGYv+W0nPQB/Vh6cgoU4
 /AWht0kkvGbMsHIfo34SbFSsVHwogipbkkIQgi8qs89wxWnrC6coc9TEQjy2rBi6nHCg
 XZ1A==
X-Gm-Message-State: APjAAAVodhu91JtJoRcgS/nQZnHpod+G1IvkgP663zTsm7y33O26NHRj
 XSiwTY1g6mDa9zdBWkAK4Vho0B7r
X-Google-Smtp-Source: APXvYqx7NRi22leRc5ddyOl/X7SLLbpIm7rIxKyIP+F/4ZOOcaI37n9oV2Ou7EI/V2rDZItw6s/SwQ==
X-Received: by 2002:a05:6602:235b:: with SMTP id
 r27mr17579379iot.51.1579014743030; 
 Tue, 14 Jan 2020 07:12:23 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net.
 [24.9.64.241])
 by smtp.gmail.com with ESMTPSA id a9sm4958922ilk.14.2020.01.14.07.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:12:22 -0800 (PST)
From: Shuah Khan <skhan@linuxfoundation.org>
To: joro@8bytes.org
Subject: [PATCH] iommu: amd: Fix IOMMU perf counter clobbering during init
Date: Tue, 14 Jan 2020 08:12:20 -0700
Message-Id: <20200114151220.29578-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 14 Jan 2020 15:16:45 +0000
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
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

init_iommu_perf_ctr() clobbers the register when it checks write access
to IOMMU perf counters and fails to restore when they are writable.

Add save and restore to fix it.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/iommu/amd_iommu_init.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 568c52317757..c0ad4f293522 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1655,27 +1655,37 @@ static int iommu_pc_get_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 static void init_iommu_perf_ctr(struct amd_iommu *iommu)
 {
 	struct pci_dev *pdev = iommu->dev;
-	u64 val = 0xabcd, val2 = 0;
+	u64 val = 0xabcd, val2 = 0, save_reg = 0;
 
 	if (!iommu_feature(iommu, FEATURE_PC))
 		return;
 
 	amd_iommu_pc_present = true;
 
+	/* save the value to restore, if writable */
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, false))
+		goto pc_false;
+
 	/* Check if the performance counters can be written to */
 	if ((iommu_pc_get_set_reg(iommu, 0, 0, 0, &val, true)) ||
 	    (iommu_pc_get_set_reg(iommu, 0, 0, 0, &val2, false)) ||
-	    (val != val2)) {
-		pci_err(pdev, "Unable to write to IOMMU perf counter.\n");
-		amd_iommu_pc_present = false;
-		return;
-	}
+	    (val != val2))
+		goto pc_false;
+
+	/* restore */
+	if (iommu_pc_get_set_reg(iommu, 0, 0, 0, &save_reg, true))
+		goto pc_false;
 
 	pci_info(pdev, "IOMMU performance counters supported\n");
 
 	val = readl(iommu->mmio_base + MMIO_CNTR_CONF_OFFSET);
 	iommu->max_banks = (u8) ((val >> 12) & 0x3f);
 	iommu->max_counters = (u8) ((val >> 7) & 0xf);
+
+pc_false:
+	pci_err(pdev, "Unable to read/write to IOMMU perf counter.\n");
+	amd_iommu_pc_present = false;
+	return;
 }
 
 static ssize_t amd_iommu_show_cap(struct device *dev,
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
