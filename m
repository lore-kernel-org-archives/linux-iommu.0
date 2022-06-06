Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB60C43334
	for <iommu@archiver.kernel.org>; Mon,  6 Jun 2022 08:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE46B403B3;
	Mon,  6 Jun 2022 08:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMWiBfax-B3C; Mon,  6 Jun 2022 08:41:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B33994052D;
	Mon,  6 Jun 2022 08:41:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85FD2C0039;
	Mon,  6 Jun 2022 08:41:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 231C3C002D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 08:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02F45416CC
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 08:41:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rBe4uO2CeBhV for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 08:41:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7B8B41677
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jun 2022 08:41:44 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 010E9B81240;
 Mon,  6 Jun 2022 08:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD17C385A9;
 Mon,  6 Jun 2022 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654504901;
 bh=sHZYUEjwBxBUleP6rLOntUs99pabhsyegEx2gHHwIp0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TzxWXINo1szvP//HX7+WO9BRKXewDZPzIIdGvyF/Nn5zCPrLG4V1kGVA4TZH9K9xm
 ChbDj2KBLN1GQNsPkNCOY3ZQ/jbpwcZpzlXpR4YxtQ+nVyRQQR2UQTc9bWaJfgAidS
 tavX/6u1PtZPBPln8CbqRNXSKoCeDaHDUbwMdeWjaklM8H4oAQJHfzLC35bfnMJixG
 HR6nFTHRz6awyzemzgxIDpsr0zAXvHqmyqqOp7TL49K2LcH6t+UqrChJ9Vhy+u8SQS
 7Nr9qd7nez9GTPFdOY3KVbc5cFAerEaIfHjq8kOVaiyzrnGlcs7SB9MNNemingOQuD
 sED60jF5bByNg==
From: Arnd Bergmann <arnd@kernel.org>
To: 
Subject: [PATCH 4/6] scsi: dpt_i2o: drop stale VIRT_TO_BUS dependency
Date: Mon,  6 Jun 2022 10:41:07 +0200
Message-Id: <20220606084109.4108188-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220606084109.4108188-1-arnd@kernel.org>
References: <20220606084109.4108188-1-arnd@kernel.org>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, Miquel van Smoorenburg <mikevs@xs4all.net>,
 linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-m68k@lists.linux-m68k.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Martyn Welch <martyn@welchs.me.uk>, Manohar Vanga <manohar.vanga@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Denis Efremov <efremov@linux.com>,
 Mark Salyzyn <salyzyn@android.com>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, linux-parisc@vger.kernel.org,
 linux-alpha@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Khalid Aziz <khalid@gonehiking.org>, Robin Murphy <robin.murphy@arm.com>
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

From: Arnd Bergmann <arnd@arndb.de>

The dpt_i2o driver was fixed to stop using virt_to_bus() in 2008 but
it a stale reference in a broken error handling code path that could
never work.

Fix it up to build without VIRT_TO_BUS and remove the Kconfig dependency.

The alternative to this would be to just remove the driver, as it is
clearly obsolete. The i2o driver layer was removed in 2015 with commit
4a72a7af462d ("staging: remove i2o subsystem"), but the even older
dpt_i2o scsi driver stayed around.

The last non-cleanup patches I could find were from Miquel van
Smoorenburg and Mark Salyzyn back in 2008, they might know if
there is any chance of the hardware still being used anywhere.

Fixes: 67af2b060e02 ("[SCSI] dpt_i2o: move from virt_to_bus/bus_to_virt to dma_alloc_coherent")
Cc: Miquel van Smoorenburg <mikevs@xs4all.net>
Cc: Mark Salyzyn <salyzyn@android.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/Kconfig   | 2 +-
 drivers/scsi/dpt_i2o.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index a9fe5152addd..cf75588a2587 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -460,7 +460,7 @@ config SCSI_MVUMI
 
 config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
-	depends on SCSI && PCI && VIRT_TO_BUS
+	depends on SCSI && PCI
 	help
 	  This driver supports all of Adaptec's I2O based RAID controllers as 
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained
diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 2e9155ba7408..55dfe7011912 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -52,11 +52,11 @@ MODULE_DESCRIPTION("Adaptec I2O RAID Driver");
 
 #include <linux/timer.h>
 #include <linux/string.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/mutex.h>
 
 #include <asm/processor.h>	/* for boot_cpu_data */
-#include <asm/io.h>		/* for virt_to_bus, etc. */
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -2112,7 +2112,7 @@ static irqreturn_t adpt_isr(int irq, void *dev_id)
 		} else {
 			/* Ick, we should *never* be here */
 			printk(KERN_ERR "dpti: reply frame not from pool\n");
-			reply = (u8 *)bus_to_virt(m);
+			goto out;
 		}
 
 		if (readl(reply) & MSG_FAIL) {
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
