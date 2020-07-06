Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F56C433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:32:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B313E206DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 23:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="J9lTuX6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B313E206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8A57787011;
	Mon,  6 Jul 2020 23:32:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mdJw5BQmzRH2; Mon,  6 Jul 2020 23:32:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1BF1586FD3;
	Mon,  6 Jul 2020 23:32:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA5C7C0893;
	Mon,  6 Jul 2020 23:32:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93BA6C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 739FF261DB
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vw+3lZtggv5d for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 23:32:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by silver.osuosl.org (Postfix) with ESMTPS id 707F9227AA
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 23:32:45 +0000 (UTC)
Received: by mail-pf1-f202.google.com with SMTP id o5so18230611pfg.10
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=4fIH4GN6n6dAxulY3f2rwIOekdlU8y7grvtSAmvPzI8=;
 b=J9lTuX6BUejRFhEHNFaUM+EGnZQ/75bZdLy4iNsT5Hfg9e9Vp2ZjxgzbX6pUw+Lcpn
 tg1r43Kv4uTk2BFurA1fcOtde1w2S5Je2ywaJQQJWmwP1e8BwNtQBgUHZQNR3MaXk813
 KuuesbqVFVvSo/GTlZp2ModcBzp2zvzYYFI+7B3gCdZbgJX8NyUO1ctAA8jzvSYvoZ2S
 XjPbtdKmePRNKr5bdqJi4L7kLsiJO1NYgKJn8l9OGXLA+HENv1Ai/LM+1uZFkp7+mArP
 Lt24vuKQtog0Wr1766hzamg6DKROwdRAxNd37B1qvIDbC2ELunnN1EbkQ2Lt4eBKXH6n
 Gyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=4fIH4GN6n6dAxulY3f2rwIOekdlU8y7grvtSAmvPzI8=;
 b=sbajv+bWZmip1RjHNgbeq6r0RbL9Y4ySOJEjGJdp5U2SeQ2DDkdFphdAz+XR85GxCI
 MVJof4LQB0bUXGk0FOq4fxh7uB16oOE7ixQqjaI1Ipw9h7iIJzSwu//uwdhCJbsfMmxe
 ajbVgUvM2cKrTuf2sT1L9IQYoLc4/O0pvS6EusnKiWjHcKkcnCSOafwf+geSaBmStbIB
 OL+X5BTNNJ0enljFOg3Fe9HBza7gzA5Lj4RY8IrdwcLub2x6Lcpj+QUvg75VF2bZagV9
 dL5GIzxfCObHZOczp2PTIWmN5wYGzLzwrng4PmcQTFtc5FYtP7ywmJPm8WBRmKdi8Ct4
 aLwA==
X-Gm-Message-State: AOAM530COPP2ujjbbLksO5JOUCcw0wdq++4oBq1rMiUmsMnhb5orhRT+
 gbiYEoSIPGEPLvyUwR1F2PgsltpTHKXH
X-Google-Smtp-Source: ABdhPJyzU+Syk8Z8h9GVkTKPHXiJJGlAsi/qdcYnGS/wnQmGjay+JpyjugMliaODOoNeHqqjGG/4eRSGb/8V
X-Received: by 2002:a17:902:8c8a:: with SMTP id
 t10mr40175484plo.153.1594078364821; 
 Mon, 06 Jul 2020 16:32:44 -0700 (PDT)
Date: Mon,  6 Jul 2020 16:32:40 -0700
Message-Id: <20200706233240.3245512-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH RESEND v2] PCI: Add device even if driver attach failed
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
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, stable@vger.kernel.org
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
Resending to stable, independent from other patches per Greg's suggestion
v2: Add Greg's reviewed by, fix commit log

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
