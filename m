Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E52EC32751
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 21:33:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1043C21743
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 21:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGYpMKK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1043C21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CAE69A80;
	Tue,  6 Aug 2019 21:33:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 09471A7F
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 21:33:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B850382D
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 21:33:27 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
	[73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id E160F217F4;
	Tue,  6 Aug 2019 21:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127207;
	bh=9ROhGXK6rd4BaOKuMuPMhYS46hgPSYfBc0TGKxduK+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGYpMKK6/tkud0U+Iu8DI+se9agLP045bN6ncjz9iDJUEOOylxEVF6MrIe5ImGM9x
	zacQXbzoxvaeGGznUEqf4IiPgFIAew2Xexx/A15NGKPxfd095Nl5u2Bzg01p2Y/ALh
	C3T+HyGEL8cCifDdLqDO7l6f9hGMrWdc6JnISWc4=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 06/59] dma-mapping: check pfn validity in
	dma_common_{mmap, get_sgtable}
Date: Tue,  6 Aug 2019 17:32:26 -0400
Message-Id: <20190806213319.19203-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
	Christoph Hellwig <hch@lst.de>, Vignesh Raghavendra <vigneshr@ti.com>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 66d7780f18eae0232827fcffeaded39a6a168236 ]

Check that the pfn returned from arch_dma_coherent_to_pfn refers to
a valid page and reject the mmap / get_sgtable requests otherwise.

Based on the arm implementation of the mmap and get_sgtable methods.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/mapping.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index f7afdadb6770b..3401382bbca2f 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -116,11 +116,16 @@ int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
 	int ret;
 
 	if (!dev_is_dma_coherent(dev)) {
+		unsigned long pfn;
+
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN))
 			return -ENXIO;
 
-		page = pfn_to_page(arch_dma_coherent_to_pfn(dev, cpu_addr,
-				dma_addr));
+		/* If the PFN is not valid, we do not have a struct page */
+		pfn = arch_dma_coherent_to_pfn(dev, cpu_addr, dma_addr);
+		if (!pfn_valid(pfn))
+			return -ENXIO;
+		page = pfn_to_page(pfn);
 	} else {
 		page = virt_to_page(cpu_addr);
 	}
@@ -170,7 +175,11 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (!dev_is_dma_coherent(dev)) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN))
 			return -ENXIO;
+
+		/* If the PFN is not valid, we do not have a struct page */
 		pfn = arch_dma_coherent_to_pfn(dev, cpu_addr, dma_addr);
+		if (!pfn_valid(pfn))
+			return -ENXIO;
 	} else {
 		pfn = page_to_pfn(virt_to_page(cpu_addr));
 	}
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
