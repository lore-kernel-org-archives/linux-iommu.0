Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4FC56202
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6F721D46
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 18:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UvbZ4McO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6F721D46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4C08387556;
	Fri,  6 Nov 2020 18:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yzocnqwIwBOs; Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6F4D287526;
	Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A819C0893;
	Fri,  6 Nov 2020 18:20:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75605C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6290486BCB
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SUd8MYacGGft for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 18:20:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A736E86B14
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=1dFKN2o+8kGazOe0y0HWPZu2S++bPIj+AcbHCPxryog=; b=UvbZ4McOLpOwJWOz+h2K0DGiKW
 8IqA/63MkyeH9sXCs+WR4yyskuEGXQPn/ntXaYgsUmxz8pzMw3Cpcny/esZina2l6btoDBVnE5yFP
 Tokid9KGZQh+ci67f4/jGk64yF/6TibtKwEAaalyjFjV3UdsL/8oaPzXDCjc0gbxv6n8iw5WP2DqF
 fLUNqYuvoiqElCT4+FDDzM38BuhTS7ETMJN9/+dPTp+tD0YWeup4lrqg5FvcKhraHhzTakK7Vu6hO
 yf72Kb2EPORXIss8whgM9u2ONWuB+A78s5+C9uRj+YY1ZHxR1jqJjFZ1FsNwKOAJMDAAdC861M4Rw
 wL6+NGgg==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb6Kv-0005dA-PY; Fri, 06 Nov 2020 18:19:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 01/10] RMDA/sw: don't allow drivers using dma_virt_ops on
 highmem configs
Date: Fri,  6 Nov 2020 19:19:32 +0100
Message-Id: <20201106181941.1878556-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: rds-devel@oss.oracle.com, Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>
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

dma_virt_ops requires that all pages have a kernel virtual address.
Introduce a INFINIBAND_VIRT_DMA Kconfig symbol that depends on !HIGHMEM
and make all three driver depend on the new symbol.

Also remove the ARCH_DMA_ADDR_T_64BIT dependency, which has been
obsolete since commit 4965a68780c5 ("arch: define the
ARCH_DMA_ADDR_T_64BIT config symbol in lib/Kconfig")

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/Kconfig           | 3 +++
 drivers/infiniband/sw/rdmavt/Kconfig | 3 ++-
 drivers/infiniband/sw/rxe/Kconfig    | 2 +-
 drivers/infiniband/sw/siw/Kconfig    | 1 +
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 32a51432ec4f73..9325e189a21536 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -73,6 +73,9 @@ config INFINIBAND_ADDR_TRANS_CONFIGFS
 	  This allows the user to config the default GID type that the CM
 	  uses for each device, when initiaing new connections.
 
+config INFINIBAND_VIRT_DMA
+	def_bool !HIGHMEM
+
 if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
 source "drivers/infiniband/hw/mthca/Kconfig"
 source "drivers/infiniband/hw/qib/Kconfig"
diff --git a/drivers/infiniband/sw/rdmavt/Kconfig b/drivers/infiniband/sw/rdmavt/Kconfig
index 9ef5f5ce1ff6b0..c8e268082952b0 100644
--- a/drivers/infiniband/sw/rdmavt/Kconfig
+++ b/drivers/infiniband/sw/rdmavt/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INFINIBAND_RDMAVT
 	tristate "RDMA verbs transport library"
-	depends on X86_64 && ARCH_DMA_ADDR_T_64BIT
+	depends on INFINIBAND_VIRT_DMA
+	depends on X86_64
 	depends on PCI
 	select DMA_VIRT_OPS
 	help
diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
index a0c6c7dfc1814f..8810bfa680495a 100644
--- a/drivers/infiniband/sw/rxe/Kconfig
+++ b/drivers/infiniband/sw/rxe/Kconfig
@@ -2,7 +2,7 @@
 config RDMA_RXE
 	tristate "Software RDMA over Ethernet (RoCE) driver"
 	depends on INET && PCI && INFINIBAND
-	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
+	depends on INFINIBAND_VIRT_DMA
 	select NET_UDP_TUNNEL
 	select CRYPTO_CRC32
 	select DMA_VIRT_OPS
diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index b622fc62f2cd6d..3450ba5081df51 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -1,6 +1,7 @@
 config RDMA_SIW
 	tristate "Software RDMA over TCP/IP (iWARP) driver"
 	depends on INET && INFINIBAND && LIBCRC32C
+	depends on INFINIBAND_VIRT_DMA
 	select DMA_VIRT_OPS
 	help
 	This driver implements the iWARP RDMA transport over
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
