Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA4EC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 09:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9C84418ED;
	Thu, 24 Mar 2022 09:01:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8YBH1XmaFlDl; Thu, 24 Mar 2022 09:01:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 79B3B418E8;
	Thu, 24 Mar 2022 09:01:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39D15C0012;
	Thu, 24 Mar 2022 09:01:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39807C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 01:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 11261400F6
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 01:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=baikalelectronics.ru
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1MYCAWrh0P5U for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 01:56:30 +0000 (UTC)
X-Greylist: delayed 00:07:46 by SQLgrey-1.8.0
Received: from mail.baikalelectronics.ru (unknown [94.125.187.43])
 by smtp2.osuosl.org (Postfix) with ESMTP id 181CD400C6
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 01:56:27 +0000 (UTC)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
 by mail.baikalelectronics.ru (Postfix) with ESMTP id 8C8691E493D;
 Thu, 24 Mar 2022 04:48:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 8C8691E493D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baikalelectronics.ru; s=mail; t=1648086520;
 bh=AYgCGlj6XCp3KD2/KUlHJg+55HiFo50ys5cdSY8nwOc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=Gdpk4DVTE1MY+dgZ0kGVMp67RyX8d1SyCg2QO2NJHj25IYEGxOxb8VC4cSyQcFRx4
 sxb20q0ugu4aEjTmpg69ImHd3ruWyaaxda/H8iMTCWfSg/qZlBV6hI7F5qPAIl5pvM
 TH40nEUw788A0bI+6t728iRMW+6lqKWGI7yOKtds=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 04:48:40 +0300
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Vinod Koul
 <vkoul@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account in
 resource mapping
Date: Thu, 24 Mar 2022 04:48:14 +0300
Message-ID: <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Mailman-Approved-At: Thu, 24 Mar 2022 09:01:27 +0000
Cc: Rob Herring <robh@kernel.org>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>,
 iommu@lists.linux-foundation.org,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
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

A basic device-specific linear memory mapping was introduced back in
commit ("dma: Take into account dma_pfn_offset") as a single-valued offset
preserved in the device.dma_pfn_offset field, which was initialized for
instance by means of the "dma-ranges" DT property. Afterwards the
functionality was extended to support more than one device-specific region
defined in the device.dma_range_map list of maps. But all of these
improvements concerned a single pointer, page or sg DMA-mapping methods,
while the system resource mapping function turned to miss the
corresponding modification. Thus the dma_direct_map_resource() method now
just casts the CPU physical address to the device DMA address with no
dma-ranges-based mapping taking into account, which is obviously wrong.
Let's fix it by using the phys_to_dma_direct() method to get the
device-specific bus address from the passed memory resource for the case
of the directly mapped DMA.

Fixes: 25f1e1887088 ("dma: Take into account dma_pfn_offset")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 50f48e9e4598..9ce8192b29ab 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -497,7 +497,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t dma_addr = paddr;
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, paddr);
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
 		dev_err_once(dev,
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
