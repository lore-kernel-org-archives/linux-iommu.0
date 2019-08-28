Return-Path: <SRS0=f2Pc=WY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E61C3A5A1
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 14:15:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A47233A1
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 14:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZMIM2nWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A47233A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5239C30C1;
	Wed, 28 Aug 2019 14:15:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 57EAB30B2
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 14:15:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1441113A
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6ZfA2t0V1DsXTcYJTI/PW4o+4h9V1E2c8O8ixWWPKp4=;
	b=ZMIM2nWGQT7ao/o3bSPXDNhdXd
	CCsYN6Sn11RqqUTEuIuAy+lZ9tJp7rrJbndUY1/HGuZyUUamoeTz6aHyT4BIT2n91cEedwlEhs1Zn
	8OqW5mwR2iwa6CM68DzwYsRYjEOjlRRyl8Zh8yhTrdJmug+Jiq9tYqb6uQWhNc5+3ZlbfhLsdCxht
	wGNvpYpUyWBSuhJoNvU5ONwHZOg36J7PIJbG0ziTH+4FJ4hUJdNsftcGWAREfKcBjbvy4xnluyh3n
	HR14xELs8owXLAkCzYe/HvdaoVal7fi9WJu+Mx5wuyrBVkcDorVPqMYsttNJckrJvKosnRZidfoU4
	DWwe3E0w==;
Received: from [2001:4bb8:180:3f4c:863:2ead:e9d4:da9f] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1i2yim-0000T7-Ay; Wed, 28 Aug 2019 14:14:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	"Derrick, Jonathan" <jonathan.derrick@intel.com>
Subject: [PATCH 1/5] x86/pci: Remove an ifdef __KERNEL__ from pci.h
Date: Wed, 28 Aug 2019 16:14:39 +0200
Message-Id: <20190828141443.5253-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828141443.5253-1-hch@lst.de>
References: <20190828141443.5253-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-pci@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, bhelgaas@google.com, dwmw2@infradead.org
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

Non-UAPI headers can't be included by userspace, so remove the
pointless ifdef.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/pci.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index e662f987dfa2..6fa846920f5f 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -12,8 +12,6 @@
 #include <asm/pat.h>
 #include <asm/x86_init.h>
 
-#ifdef __KERNEL__
-
 struct pci_sysdata {
 	int		domain;		/* PCI domain */
 	int		node;		/* NUMA node */
@@ -118,7 +116,6 @@ void native_restore_msi_irqs(struct pci_dev *dev);
 #define native_setup_msi_irqs		NULL
 #define native_teardown_msi_irq		NULL
 #endif
-#endif  /* __KERNEL__ */
 
 #ifdef CONFIG_X86_64
 #include <asm/pci_64.h>
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
