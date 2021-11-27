Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DC7C43219
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 01:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96909402E0;
	Sat, 27 Nov 2021 01:21:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wDNPkydMd0sK; Sat, 27 Nov 2021 01:21:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 39BD6403F1;
	Sat, 27 Nov 2021 01:21:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1010EC000A;
	Sat, 27 Nov 2021 01:21:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80050C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E57740958
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="s5/7GiBA";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="a/lrAdft"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BFoRCkSC7xYd for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 01:21:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB6E14092D
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 01:21:27 +0000 (UTC)
Message-ID: <20211126230524.236729743@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1637976085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=MsQMrlpTATaTMzIfF99P8uE12mWb1u9o9W8ziR/qOrU=;
 b=s5/7GiBAGtnZQwXCkJzIoXGDFw9fPYYL9I/8KrbAHhCi6/W5ORyoYo+JP/YuAE87tFIeaN
 9SZh1+Yjo2XXaSZorgmLTxAILASF8j/epV2N0TcmWKedYc0YmJC2wlSVYBnaetuvYeO3gq
 r3SfD/wUrFi5PM1aRClsyPVz6/p4EV8WsYmtXWl27kfio/UReZ+Mhr6xzG652IFg6Q3Jqf
 j8tfy8ngFRv3cfTMQCMUYPCB9icEoD8VlOjnr4jH17O0cj03031NYyK9p2GW7qTEKtxzen
 4iMcZc1BgMq2pRy4AjD7pM+FJVv8+c3VXMeWs2KBgvToMKXWb2RD31F6atyAVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1637976085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 references:references; bh=MsQMrlpTATaTMzIfF99P8uE12mWb1u9o9W8ziR/qOrU=;
 b=a/lrAdftCCZrTdCpqSQ14M5irrmHGMbAkC15UyZUkW8R5n7eykGLYW3kV7O6o8qATLwkxF
 7RIlcPlxcQHtYsAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 05/37] platform-msi: Allocate MSI device data on first use
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Date: Sat, 27 Nov 2021 02:21:25 +0100 (CET)
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Megha Dey <megha.dey@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
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
Message-ID: <20211127012125.YWw3xuN-U0ipy2BqAkzd3Qs1yEuhNQL6l1fEJGF32js@z>

Allocate the MSI device data on first invocation of the allocation function
for platform MSI private data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -204,6 +204,8 @@ platform_msi_alloc_priv_data(struct devi
 			     irq_write_msi_msg_t write_msi_msg)
 {
 	struct platform_msi_priv_data *datap;
+	int err;
+
 	/*
 	 * Limit the number of interrupts to 2048 per device. Should we
 	 * need to bump this up, DEV_ID_SHIFT should be adjusted
@@ -218,6 +220,10 @@ platform_msi_alloc_priv_data(struct devi
 		return ERR_PTR(-EINVAL);
 	}
 
+	err = msi_setup_device_data(dev);
+	if (err)
+		return ERR_PTR(err);
+
 	/* Already had a helping of MSI? Greed... */
 	if (!list_empty(dev_to_msi_list(dev)))
 		return ERR_PTR(-EBUSY);
@@ -229,7 +235,7 @@ platform_msi_alloc_priv_data(struct devi
 	datap->devid = ida_simple_get(&platform_msi_devid_ida,
 				      0, 1 << DEV_ID_SHIFT, GFP_KERNEL);
 	if (datap->devid < 0) {
-		int err = datap->devid;
+		err = datap->devid;
 		kfree(datap);
 		return ERR_PTR(err);
 	}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
