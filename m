Return-Path: <SRS0=3qkl=WH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8975C0650F
	for <iommu@archiver.kernel.org>; Sun, 11 Aug 2019 08:06:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEB932173C
	for <iommu@archiver.kernel.org>; Sun, 11 Aug 2019 08:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ax6p9oKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB932173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BC85CB43;
	Sun, 11 Aug 2019 08:06:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6950FAD8
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 08:06:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6A66B6E0
	for <iommu@lists.linux-foundation.org>;
	Sun, 11 Aug 2019 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aUU+hlkhrpiLGkqb9yLX5LvOZKeD+UrNctlDkcRT8c0=;
	b=Ax6p9oKF7TWgXYyF2WtzSWjagk
	BNniHtPluUBTFd5mJ4BNzxO+5vwnyPP+WI4FttbLmW95pNEwCTg9EEg4TxYK/KQN/+SW9a7GWZdNo
	mi6f6w23oeCxIkPeacRf+yLhLZaeSzP9myORxWiiyuLCoQAf5yVL8xQooQRb9nlhBcaOnDnPrjHCa
	kApazYa2o6vGOugcHVss6tyBINKprccgFsl3UnouAW7RRuyvy1YWboeKHZWWl5DrrTtm1fMx7kzna
	sYOJ6cTc19mjBErMnjoZ8B/LFS5VxAbkBEm3fO8V9dhRNhnLtBS5c2C7dFe2rF1UMEO/1/iJkAxex
	t+4T26aQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hwirJ-00021E-C9; Sun, 11 Aug 2019 08:05:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH 6/6] driver core: initialize a default DMA mask for platform
	device
Date: Sun, 11 Aug 2019 10:05:20 +0200
Message-Id: <20190811080520.21712-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190811080520.21712-1-hch@lst.de>
References: <20190811080520.21712-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-arch@vger.kernel.org, Olav Kongas <ok@artecdesign.ee>,
	Gavin Li <git@thegavinli.com>, linuxppc-dev@lists.ozlabs.org,
	Mathias Nyman <mathias.nyman@intel.com>,
	Geoff Levand <geoff@infradead.org>, Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
	Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>,
	iommu@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Shawn Guo <shawnguo@kernel.org>, Bin Liu <b-liu@ti.com>,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

We still treat devices without a DMA mask as defaulting to 32-bits for
both mask, but a few releases ago we've started warning about such
cases, as they require special cases to work around this sloppyness.
Add a dma_mask field to struct platform_object so that we can initialize
the dma_mask pointer in struct device and initialize both masks to
32-bits by default.  Architectures can still override this in
arch_setup_pdev_archdata if needed.

Note that the code looks a little odd with the various conditionals
because we have to support platform_device structures that are
statically allocated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/platform.c         | 15 +++++++++++++--
 include/linux/platform_device.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index ec974ba9c0c4..b216fcb0a8af 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -264,6 +264,17 @@ struct platform_object {
 	char name[];
 };
 
+static void setup_pdev_archdata(struct platform_device *pdev)
+{
+	if (!pdev->dev.coherent_dma_mask)
+		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	if (!pdev->dma_mask)
+		pdev->dma_mask = DMA_BIT_MASK(32);
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &pdev->dma_mask;
+	arch_setup_pdev_archdata(pdev);
+};
+
 /**
  * platform_device_put - destroy a platform device
  * @pdev: platform device to free
@@ -310,7 +321,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
 		pa->pdev.id = id;
 		device_initialize(&pa->pdev.dev);
 		pa->pdev.dev.release = platform_device_release;
-		arch_setup_pdev_archdata(&pa->pdev);
+		setup_pdev_archdata(&pa->pdev);
 	}
 
 	return pa ? &pa->pdev : NULL;
@@ -512,7 +523,7 @@ EXPORT_SYMBOL_GPL(platform_device_del);
 int platform_device_register(struct platform_device *pdev)
 {
 	device_initialize(&pdev->dev);
-	arch_setup_pdev_archdata(pdev);
+	setup_pdev_archdata(pdev);
 	return platform_device_add(pdev);
 }
 EXPORT_SYMBOL_GPL(platform_device_register);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 9bc36b589827..a2abde2aef25 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -24,6 +24,7 @@ struct platform_device {
 	int		id;
 	bool		id_auto;
 	struct device	dev;
+	u64		dma_mask;
 	u32		num_resources;
 	struct resource	*resource;
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
