Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3487C31E50
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 13:36:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECE7208C4
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 13:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECE7208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 576DBB7A;
	Mon, 17 Jun 2019 13:36:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E77BCACC
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 13:36:43 +0000 (UTC)
X-Greylist: delayed 00:05:20 by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 254E57E9
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 13:36:42 +0000 (UTC)
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
	(mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
	1MMWcT-1hsbSL1duZ-00JXkC; Mon, 17 Jun 2019 15:31:02 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: fix integer truncation
Date: Mon, 17 Jun 2019 15:30:54 +0200
Message-Id: <20190617133101.2817807-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:chTa38z/gjbzCpsUfTMZ6NKpNwxA24x4uqV4fTfRNlScDoohZxE
	1UR/Jwd1cvsBZi9Cwv+CO14naU7ifAmSljpXWNFEf53fU9hdB6iM1CqSUCsspUGu0vXhGrA
	eGscsZlCrDJPIncYviaP81EDiKdWdO3eE8blN7GXzwc0BPHW8ybWkzP+mCcPefHu5pCJXDe
	etGOFg30YMgkRmbiSvkNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1NjCUdjOu0=:SEJel/EVpLfEYtiHeSyvW5
	l7qrhS/jANDYIaHTGQxHY8iWrWEG/41t92kfVTtv596Sz4+GZep7abNb/6MpQDxO/xl4vXbf8
	nIcOCySTSh6R1guGXPIe4EAOTkrXuGGD9y7cDI8oXhRsI8LIaeNd+xyVgb0eDBiscwHNVXhR8
	qho0NlniNddWRA3+DMpUoBtSBMH6izNUaLl7Tcvprha7FFrKvLajuNEk8IiX+bN+2oS1EZa/B
	zbZlGT4lPCiZBkdwwg2YgC2QBCZzqF3PB87eeLHJy9KuWzlEU59HNmsRY7kH2WM55QiY7ALYv
	vJ39juepGKMgMORwSX1lnt/UpzPgjJ1c4lqfp1CNU9rxKIN9VAYPMwWMIQGz+DKJ0qOivn9f1
	T67scECvh2F4Y3tRTvnpVD+ZFVv4RYIj71plypfVVQtXsC5RVdjAVfZFkodRxgQ0xUQQOI0sU
	YZrgIBnbBqAo1KWhO/ak4jF4E58dUerQeVtIYDXdTJPcA1aPgkrbrSfpgoprKinmcZQA0vxrT
	f2qoXxV/HJcJidF/g6Vwn+Oi17/f7c6fzqLT34miuQWktdUUHBdK1dzZEedGOZxBJqiRiR98z
	6ZeSsN5xWZWkG3iGf8pQ0PSNNhAwLUgp3iR85dOX4v1vmE6ozeZuTawYE/NRd7qZWM2owyDUh
	NzuPQWnBdbiNmaAo1Pt5hMBroL7mwnpij3YEZtTHfXkbxX5tXYhG4bniIxNl7D1RsZg1qL2ju
	pFsOBraww5YYFvK1OFOyUSJPHZEXxQ2Qf4kHow==
Cc: Oza Pawandeep <poza@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Julien Grall <julien.grall@arm.com>,
	Srinath Mannam <srinath.mannam@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
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

On 32-bit architectures, phys_addr_t may be different from dma_add_t,
both smaller and bigger. This can lead to an overflow during an assignment
that clang warns about:

drivers/iommu/dma-iommu.c:230:10: error: implicit conversion from 'dma_addr_t' (aka 'unsigned long long') to
      'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]

Use phys_addr_t here because that is the type that the variable was
declared as.

Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/dma-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index cc0613c83d71..a9f13313a22f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -226,8 +226,8 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
 		start = window->res->end - window->offset + 1;
 		/* If window is last entry */
 		if (window->node.next == &bridge->dma_ranges &&
-		    end != ~(dma_addr_t)0) {
-			end = ~(dma_addr_t)0;
+		    end != ~(phys_addr_t)0) {
+			end = ~(phys_addr_t)0;
 			goto resv_iova;
 		}
 	}
-- 
2.20.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
