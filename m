Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9095DC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:50:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAC02067D
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 04:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EmhVGqKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAC02067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3AE2287C4F;
	Tue, 30 Jun 2020 04:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IIJegefR5xgZ; Tue, 30 Jun 2020 04:49:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 68BAA87BAD;
	Tue, 30 Jun 2020 04:49:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DCFFC0865;
	Tue, 30 Jun 2020 04:49:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 240BEC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 03CBA20460
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hWK4q8abcTm3 for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 04:49:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73])
 by silver.osuosl.org (Postfix) with ESMTPS id AB4AA204BD
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 04:49:56 +0000 (UTC)
Received: by mail-qv1-f73.google.com with SMTP id v10so2999246qvm.17
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 21:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=1pgr6KaNRkuRhLLKbqD3ulE84r9BXBrKXG+wTgasJBs=;
 b=EmhVGqKj1hxcynFazVyM9BBAatcEV5Glfv6IolcJAU+WZt80BhCC7S95uetkKS69rG
 moLJ6mFVxETH0uu9E5a71IdGi1EO4Jhlu5hsB7433iTczY02C02gemnhGbY2HbNsmeK9
 p89uUnKxxwP9D13BCKNLWLjQu3I1+cvnyQpwfOIonoAfzeqNwq8mWanYN1hfu7UVEnqu
 7AVkwFxIC+IhNltLvEX3U89fGJ3pMmvPsScLgILybybvho+KO8QYE5NqN/pAWR+OXe8w
 GvuFxrbWomAp5dLYDnySp6VAEjs1FyccCG1hfRZ3TOXSnaYyLVsaVOXiMQes4cgLhzF1
 WihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=1pgr6KaNRkuRhLLKbqD3ulE84r9BXBrKXG+wTgasJBs=;
 b=NzHfpew+FXHwcEbRU2J6uaaLJ01MRq/lcJnb+9lBWI1WfZ8vDGAmKCPO6mT2WvBfZ9
 t69Mdo6sUAmChbGIfoau1/qQazuZUdx0icH4z9jsK9SrkZRzQ9qzUGUH/z05Li0EtRBe
 nW5eQm7m9Vbq91tUNcraILNN6L3P0ON+la43Vui/QztVLEcTeZwF36zCaog4qIBnKjSy
 +XJ+C2nu9E+IZWiN8toWMrOFWlurDmm7Vi6GB39sRb2Afsbrm6W3WeXznKuxCF8GH/cT
 vUYuISgJfUf8jKbgQq/nPIkTl4ppejAkmEOaoGQI0PWXEdhkgaKVDjSJ6ZkR3if+Yvrw
 JYkg==
X-Gm-Message-State: AOAM533sbeMv8XoVBzjj/58OkwnJ0ykT+gkQ/9rTYH2QWrFPATIal53c
 bJJhxgJLGQ3AFiAxTEHwnb5NtlwWSh7h
X-Google-Smtp-Source: ABdhPJxPqRsEUkTJy7xBvIqn4j64tLwwndWDL29Mu8/+Z31HqzfgXJZ/paNZUVBIuCrmANpGN0BjB5/3u/Zp
X-Received: by 2002:a05:6214:18f2:: with SMTP id
 ep18mr7665592qvb.96.1593492595480; 
 Mon, 29 Jun 2020 21:49:55 -0700 (PDT)
Date: Mon, 29 Jun 2020 21:49:40 -0700
In-Reply-To: <20200630044943.3425049-1-rajatja@google.com>
Message-Id: <20200630044943.3425049-5-rajatja@google.com>
Mime-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 4/7] PCI: Add device even if driver attach failed
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, oohall@gmail.com, 
 Saravana Kannan <saravanak@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
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

device_attach() returning failure indicates a driver error while trying to
probe the device. In such a scenario, the PCI device should still be added
in the system and be visible to the user.

This patch partially reverts:
commit ab1a187bba5c ("PCI: Check device_attach() return value always")

Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: Cosmetic change in commit log.
    Add Greg's "reviewed-by"

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
