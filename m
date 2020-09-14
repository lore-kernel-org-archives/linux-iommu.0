Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA960C433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 07:31:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9C82192A
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 07:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ALCuuDTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9C82192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DBC2D8694C;
	Mon, 14 Sep 2020 07:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 85QsPNVwlkJA; Mon, 14 Sep 2020 07:31:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4BF0686947;
	Mon, 14 Sep 2020 07:31:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AE66C088B;
	Mon, 14 Sep 2020 07:31:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A34DC0859
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 07:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E956320023
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 07:31:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KMJ0vo9eACQL for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 07:31:14 +0000 (UTC)
X-Greylist: delayed 00:07:28 by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 29613203D8
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 07:31:14 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id y1so4523161pgk.8
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 00:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=FgYJJ59Xq6gP9NQOhQuV3NPG4SMshHnKOvl37XR57Lg=;
 b=ALCuuDTCtnPChypI77VManpug+BEsagYoWT+KEAHORA/1P+QrrUxiNNAJFMdfgEnEr
 zqpmfXqDzDMhYJwyeyhWYi8cQCJbRyKNErkealPqobOMABvkZFzfrNSmPMCOCo+WyUIG
 dFkLXiDMDbcAd3zJQ5BE4OZr/nc7CM4s0ZMks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FgYJJ59Xq6gP9NQOhQuV3NPG4SMshHnKOvl37XR57Lg=;
 b=hqrv3rvX0NWwaBmzie42sN3epxE7foZafApBngGbfd8DquN7/zT7hbSbiNHYgow41l
 u9lsdMdvSYoqL9R0Uxj5jzJxrPaGL28Qi27TVYk2WwLLhiSKIjm6ztwKm/R36aTUiJv2
 Av1JbN5Ttjl0FGPt0mJsAHiiM/iIX/25MnfX/chhvtM7a8WI2z492aW7wUAC3EwiOe6J
 rTrOxo2QA+Um+e5TbXznko1pYlFLZ+gVUp2Ba9I+o8VH0WQBBW9X4oVlesLBN4k0kJCp
 inmrPEhSQGuaLqz1KQJ9t3cH7qEv0OjEtAOgX6pTXdeQkpnZLjiQDVUwHvJ4jyQjPn+S
 D+zw==
X-Gm-Message-State: AOAM531hHkWzf7pTVLhCX407uKSHnqNS/JjaTY5nJYmMDHNOBj6+YWfC
 yTeAGYktxf1VJns+LntbwEmPiTuCdbfLKZlU
X-Google-Smtp-Source: ABdhPJzwO0XCFMYQ+LPRxhAGL7kKJAYluHoXtdQmAfZmBI5GxErXjKfeazcrGKA97FK2ZccycGRY1A==
X-Received: by 2002:aa7:9484:: with SMTP id z4mr12319563pfk.32.1600068225293; 
 Mon, 14 Sep 2020 00:23:45 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id z11sm9573077pfc.181.2020.09.14.00.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 00:23:44 -0700 (PDT)
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org
Subject: [PATCH v3] iommu/dma: Fix IOVA reserve dma ranges
Date: Mon, 14 Sep 2020 12:53:19 +0530
Message-Id: <20200914072319.6091-1-srinath.mannam@broadcom.com>
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
Changes from v2:
   Modify error message with useful information based on Bjorn's comments.

Changes from v1:
   Removed unnecessary changes based on Robin's review comments.

 drivers/iommu/dma-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5141d49a046b..5b9791f35c5e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -217,9 +217,11 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 			lo = iova_pfn(iovad, start);
 			hi = iova_pfn(iovad, end);
 			reserve_iova(iovad, lo, hi);
-		} else {
+		} else if (end < start) {
 			/* dma_ranges list should be sorted */
-			dev_err(&dev->dev, "Failed to reserve IOVA\n");
+			dev_err(&dev->dev,
+				"Failed to reserve IOVA [%#010llx-%#010llx]\n",
+				start, end);
 			return -EINVAL;
 		}
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
