Return-Path: <SRS0=o1xy=ZV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7EFC432C0
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 18:03:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD0F2158A
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 18:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Sx3AvPOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD0F2158A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 86748885C3;
	Fri, 29 Nov 2019 18:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lVocaVp2GAO1; Fri, 29 Nov 2019 18:03:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CBE5386D2D;
	Fri, 29 Nov 2019 18:03:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABFCEC1DD9;
	Fri, 29 Nov 2019 18:03:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 031EBC0881
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 18:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E5536232D2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 18:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0wROZs9dTL36 for <iommu@lists.linux-foundation.org>;
 Fri, 29 Nov 2019 18:03:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 3A74220008
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 18:03:35 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id q13so14926692pff.2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 10:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=jPr5t/QGIk3dEsOl9u9M5NSjMqP5apTW3OFqc5H9bGg=;
 b=Sx3AvPOr6oH6nNcHg0XUMPQpmiIJP7Q/U/kiGocKGDuWxO4R+IjAXi9N/72XkHjjGE
 Uv5EZUMHijnKJkaoTxfO4oH9jxNVgkWtmtkNN8xKDL+UWCk2WayHJxC3Wbi1pvncWVIa
 zfjxSh6XMAX6ZIRuSj8sXl6i+dOHsbaAfxwr6JTXOM3g5lVe6KCuOgJYt34TQt9tu5JQ
 EoyiFuznkiQOIETC7NKnFkeS+G6U4NKWKqhbBdOS72SPyJ5gvQBlAwR6rge3tFOqKEKj
 g1xNLMLRgHqrTlOjW/9ELQ3oQe8UaNdpxmAvgzgfGCmdG82FHpCxdIYxyioESCqe7uXq
 Hagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=jPr5t/QGIk3dEsOl9u9M5NSjMqP5apTW3OFqc5H9bGg=;
 b=KF+l5lydzua5XCqv3+KcPY4BFu02qumFIg/uI/jmyFVo7r4ojts47SCx3LI4fUoQRr
 82gzNHvLZYG4eEBDdtyV0FGwSpYzQAkP7yXFNhNzMaR46lBYsQFLfGPlsvkg3p/EJ/bU
 b7274g3ZLpnpGEu7MDe4pcvDvUtD8Dx3PYo3zozpW6PozKtYIjXkN8HwZkc2+4WehQee
 Tn5dQ7yISkrQJQPdubIkmFTubtzSjfKyEbjrd6NUq5+7tGpnct/cNgeWqPcS8ZpjyaXj
 Q6Y5rGIPzTwsxFwlzc4UEEIJ/BKhNAkbfHOV24NWoafD/WUeF5jv2rkjTvKacu3RGxe5
 Yxew==
X-Gm-Message-State: APjAAAWcueX8FJjqpantBQ7HBjdxVWWv/ChIiWFQLhT2BUOyDXbEDpVw
 VaadeMvIVqKCOtw/JsG9nCoyPg==
X-Google-Smtp-Source: APXvYqz1sCR0hMaSTGt0Lcx6/V0omL2CwbAr16Ima8v95egYPkJJoY5hGsmY7XgRYbKLbpl/9vtKwQ==
X-Received: by 2002:aa7:90d0:: with SMTP id k16mr59548674pfk.131.1575050183849; 
 Fri, 29 Nov 2019 09:56:23 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
 by smtp.gmail.com with ESMTPSA id s7sm9962922pfe.22.2019.11.29.09.56.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Nov 2019 09:56:23 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v5 1/3] PCI: Fix off by one in dma_alias_mask allocation size
In-Reply-To: <d811576e-0f89-2303-a554-2701af5c5647@deltatee.com>
Date: Fri, 29 Nov 2019 17:56:19 +0000
Message-Id: <9DD82D05-6B9E-4AF5-9A3C-D459B75C0089@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
 <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
 <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
 <d811576e-0f89-2303-a554-2701af5c5647@deltatee.com>
To: linux-pci@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Dmitry Safonov <dima@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
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
From: James Sewart via iommu <iommu@lists.linux-foundation.org>
Reply-To: James Sewart <jamessewart@arista.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The number of possible devfns is 256 so the size of the bitmap for
allocations should be U8_MAX+1.

Signed-off-by: James Sewart <jamessewart@arista.com>
---
 drivers/pci/pci.c    | 2 +-
 drivers/pci/search.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a527..0a4449a30ace 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5876,7 +5876,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
 	if (!dev->dma_alias_mask)
-		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
+		dev->dma_alias_mask = bitmap_zalloc(U8_MAX+1, GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
 		pci_warn(dev, "Unable to allocate DMA alias mask\n");
 		return;
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bade14002fd8..b3633af1743b 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -43,7 +43,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	if (unlikely(pdev->dma_alias_mask)) {
 		u8 devfn;
 
-		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
+		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX+1) {
 			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
 				 data);
 			if (ret)
-- 
2.24.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
