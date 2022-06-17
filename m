Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A270C43334
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 12:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 105B582C7D;
	Fri, 17 Jun 2022 12:58:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 105B582C7D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nLNheZIM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3BAHIhb1_kEB; Fri, 17 Jun 2022 12:58:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B6971844FE;
	Fri, 17 Jun 2022 12:58:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6971844FE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D123C0032;
	Fri, 17 Jun 2022 12:58:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BA18C002D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 12:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E958682C7D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 12:58:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E958682C7D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JWK5tjDFYjNO for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:58:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DE08833CD
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DE08833CD
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 12:58:09 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D542061FA8;
 Fri, 17 Jun 2022 12:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593ABC3411F;
 Fri, 17 Jun 2022 12:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655470687;
 bh=PHa+k1YPCB+2jgYk545vxPTI79A930ycNAnnkPIO8Q0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nLNheZIMb11YnK30s1ue4ClOfmXib4scSxsRBkan3jiCrsYF14v8dRzqdsbD07xD/
 7CVlJX/9vypOil3A0ym7H4qwTjHxFVs2953dx4vTr/1tKVrlExjRwnVrNjB56/54b8
 mI5c0Afql8VfQwtkoOtgPCBjeHOOsjVos0BnP7RKevmdbYMVMVehSfmRtWEVM7Zo+0
 32Oor1aZzOjFgybMMdE7DBEwLj2FGEfKPYV0Lcgg2w1dTdhpLzSWnnUROwn+W6xw1r
 brAoIaL/gkUAawWzU4UY6DLRjidv0/55hJJFNX7mCSRMsy9E0xCQG8rGi327Q83BHu
 JVJbuHA/NBGRA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] scsi: dpt_i2o: drop stale VIRT_TO_BUS dependency
Date: Fri, 17 Jun 2022 14:57:48 +0200
Message-Id: <20220617125750.728590-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220617125750.728590-1-arnd@kernel.org>
References: <20220617125750.728590-1-arnd@kernel.org>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, Miquel van Smoorenburg <mikevs@xs4all.net>,
 linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, "Maciej W . Rozycki" <macro@orcam.me.uk>,
 linux-m68k@lists.linux-m68k.org, Denis Efremov <efremov@linux.com>,
 Mark Salyzyn <salyzyn@android.com>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Matt Wang <wwentao@vmware.com>,
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

The dpt_i2o driver was fixed to stop using virt_to_bus() in 2008, but
it still has a stale reference in an error handling code path that could
never work.

Fix it up to build without VIRT_TO_BUS and remove the Kconfig dependency.

The alternative to this would be to just remove the driver, as it is
clearly obsolete. The i2o driver layer was removed in 2015 with commit
4a72a7af462d ("staging: remove i2o subsystem"), but the even older
dpt_i2o scsi driver stayed around.

The last non-cleanup patches I could find were from Miquel van Smoorenburg
and Mark Salyzyn back in 2008, they might know if there is any chance
of the hardware still being used anywhere.

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
