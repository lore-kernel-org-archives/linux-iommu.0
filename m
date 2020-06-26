Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43035C433DF
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 00:27:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0718A20767
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 00:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="gsWwDuEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0718A20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A023624B59;
	Fri, 26 Jun 2020 00:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v1XJA15zE5UT; Fri, 26 Jun 2020 00:27:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7B23E220C5;
	Fri, 26 Jun 2020 00:27:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C0EBC088E;
	Fri, 26 Jun 2020 00:27:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37DCCC016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 00:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 263D0884CD
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 00:27:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GeY5a132WE0m for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 00:27:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8DC4B88455
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 00:27:16 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id f130so7796678yba.9
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 17:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=iv7sfYwPBb+T3sh9Tm/gYiOZsGJSNCHeo7sHuB/mAjU=;
 b=gsWwDuEWxxXpafc13YiTJ2OicmolQf5h7KB/1owTbiu6Ee1j93pn2eUyAh2einvluw
 E8nZ02G/7r07CFhIK5dPv0ZlK2iUzky20NJwNJzL3BmkInHkfTJUi0whj4v7SeoBFp3g
 L/3uvCEgLYksFm2o4W1T7X4v2l1c/6dVt1wvCZUbCr3HPRrMHD/Wx73XJpbZlJYqrhpV
 KaBzdZ96OBEfsKzgIwFT42MUz/2ka3sVvK4ATXx/XlaVPmoIodvUZOQza8cC5ubLjNIz
 E74HpampI/OVzg9d/tQFsKbYUOV6dBx9FZXpN2zmmaEvoJ5q72zzytovyjewoIGXtbDl
 naBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=iv7sfYwPBb+T3sh9Tm/gYiOZsGJSNCHeo7sHuB/mAjU=;
 b=FEVrEHjwTkEpd4QXqPSTCqYMtmXgJHNLmEJH0+wG8b1rgoB0UKQRhd/mTiaxEFnzxL
 OYjJuRx5+vhppwtLamZ3o3fHyDU1fSa2UU0YOksEWz/SLTMKYQZYjPAj9OtiyoLuunn9
 4FUveO8TXLHCfrlzTTbrY62ul+PUkhS8RenyjEpZLsS6A+ixWeRkqNjA03jsRa5/0wPs
 fDzMeBiN60RdHar+Sie+Fsdldomn+CZiYD1BC0/zZFgx5CR/eWjhlq5CUQof/M9AR/vP
 7DKjbkQ1rHPNjZfuZ4ey5tCm/6kbUHRsZt7bsTlHuTBUjY251wxelgKlWsCXkW1TCwd9
 dZdw==
X-Gm-Message-State: AOAM533SG+pd/cmo0ahGj5Fn9M7EjgBsRY+NZ3uBMcG597LHajI9AywN
 rb4YrDHbBPOuzVO0kikkbwUtz3x2UDiM
X-Google-Smtp-Source: ABdhPJyJZ32y84BWOCzPlXnj6DBPie+kwwNvt36mcjomQYjcSGXpCQX3nGJKpsx74v22jf/R8UEafr0WqCf3
X-Received: by 2002:a25:aaa9:: with SMTP id t38mr763977ybi.312.1593131235516; 
 Thu, 25 Jun 2020 17:27:15 -0700 (PDT)
Date: Thu, 25 Jun 2020 17:27:09 -0700
Message-Id: <20200626002710.110200-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 1/2] pci: Add pci device even if the driver failed to attach
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
 iommu@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>, 
 lalithambika.krishnakumar@intel.com, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Prashant Malani <pmalani@google.com>, 
 Benson Leung <bleung@google.com>, Todd Broch <tbroch@google.com>,
 Alex Levin <levinale@google.com>, 
 Mattias Nissler <mnissler@google.com>, Rajat Jain <rajatxjain@gmail.com>, 
 Bernie Keany <bernie.keany@intel.com>, Aaron Durbin <adurbin@google.com>, 
 Diego Rivas <diegorivas@google.com>, Duncan Laurie <dlaurie@google.com>, 
 Furquan Shaikh <furquan@google.com>, Jesse Barnes <jsbarnes@google.com>, 
 Christian Kellner <christian@kellner.me>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, oohall@gmail.com
Cc: Rajat Jain <rajatja@google.com>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

device_attach() returning failure indicates a driver error
while trying to probe the device. In such a scenario, the PCI
device should still be added in the system and be visible to
the user.

This patch partially reverts:
commit ab1a187bba5c ("PCI: Check device_attach() return value always")

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 8e40b3e6da77d..3cef835b375fd 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
-	if (retval < 0 && retval != -EPROBE_DEFER) {
+	if (retval < 0 && retval != -EPROBE_DEFER)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
-		pci_proc_detach_device(dev);
-		pci_remove_sysfs_dev_files(dev);
-		return;
-	}
 
 	pci_dev_assign_added(dev, true);
 }
-- 
2.27.0.212.ge8ba1cc988-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
