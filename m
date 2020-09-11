Return-Path: <SRS0=FRM4=CU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43901C43461
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 10:56:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955E421D40
	for <iommu@archiver.kernel.org>; Fri, 11 Sep 2020 10:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S5AaYjku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955E421D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1767E87844;
	Fri, 11 Sep 2020 10:56:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iXgjCbBx72BU; Fri, 11 Sep 2020 10:56:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 024F186BB0;
	Fri, 11 Sep 2020 10:56:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8300C0052;
	Fri, 11 Sep 2020 10:56:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92E4EC0051
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 10:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 812E0873DC
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 10:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kUeuB_MxNKMU for <iommu@lists.linux-foundation.org>;
 Fri, 11 Sep 2020 10:55:59 +0000 (UTC)
X-Greylist: delayed 00:22:41 by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E5232873D9
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 10:55:58 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id y6so9034468oie.5
 for <iommu@lists.linux-foundation.org>; Fri, 11 Sep 2020 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=e46DHbzTBFXI2qUO06Xr5hYaBwt3naS56LAsBV+A8t0=;
 b=S5AaYjkuSLMxqDh1NKhipUCvP8LgUI4CrWq0Gy+35B9PP8LBCI/Pf2buHxS6pb8Wbt
 yYzgLIwcAA1qjq+oAhM6N2dy39Q70v5y0XGOPpwGVSn9Ihb0wWEQ1LccJDresNLt1Y1l
 MRykiJAhxTBrXPmgcaVL+jKTiqA9B+uniRY8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=e46DHbzTBFXI2qUO06Xr5hYaBwt3naS56LAsBV+A8t0=;
 b=HUhrK/+uGaqLKGm9OBuChrGkUnZFGDW7EtyvmfECiazJ6lnLr2u/K176+RHDogMLil
 tg4ZoJuGqO2qOegJHd9XeomgxnIkXPG5RbwQ0Fhb/EImGtSN1o5k2d80UpNwc2AVNCbC
 5E5CzupGBsT+c5EE8E0QpZ0XeJx0T2aHJ1X7xHDBOlboZlWtpIORfGpxo4Srj/rEkI15
 scRhM2H7KwUlxVDOb+XkMep/7nTd4zY8Pnu/nPpruGIoLkCwvNwZ7lzGTB0teutGafuA
 anmtnKms3Or3KnIKXmC9Ue3YpOiKJ764Ul0lFfe3sJbxatEx+vqP70NvzvrhC6JyAHmm
 T+sQ==
X-Gm-Message-State: AOAM531UvXlkfiQs680Ry5hIsRr+Y+lhkGMWUWFaJAAUqIQDGpDuEv6E
 BtpvUW4WQZEA7vv7DjKX/UyLtESwQUJ9yQ==
X-Google-Smtp-Source: ABdhPJxPDMHj7bY9B1+rquyIhx1L1LA2oRdhPi5GLC9/YQnGbN3wlM27C1EJ7k/EZkniTjjK6iCpNA==
X-Received: by 2002:a17:90a:ad8b:: with SMTP id
 s11mr1642230pjq.40.1599819948441; 
 Fri, 11 Sep 2020 03:25:48 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id i17sm1929584pfa.2.2020.09.11.03.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 03:25:47 -0700 (PDT)
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org
Subject: [PATCH v2] iommu/dma: Fix IOVA reserve dma ranges
Date: Fri, 11 Sep 2020 15:55:34 +0530
Message-Id: <20200911102534.25218-1-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
Cc: Srinath Mannam <srinath.mannam@broadcom.com>,
 iommu@lists.linux-foundation.org, bcm-kernel-feedback-list@broadcom.com,
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
From: Srinath Mannam via iommu <iommu@lists.linux-foundation.org>
Reply-To: Srinath Mannam <srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Fix IOVA reserve failure in the case when address of first memory region
listed in dma-ranges is equal to 0x0.

Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
Changes from v1:
   Removed unnecessary changes based on Robin's review comments.

 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5141d49a046b..682068a9aae7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -217,7 +217,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 			lo = iova_pfn(iovad, start);
 			hi = iova_pfn(iovad, end);
 			reserve_iova(iovad, lo, hi);
-		} else {
+		} else if (end < start) {
 			/* dma_ranges list should be sorted */
 			dev_err(&dev->dev, "Failed to reserve IOVA\n");
 			return -EINVAL;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
