Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE18C3A59C
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 07:16:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41692133F
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 07:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cwd5nn8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41692133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BF6D0CC7;
	Fri, 16 Aug 2019 07:16:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1EDC8AD7
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 07:16:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D05C576D
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 07:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5slocbe6PQWQPCbfPHRmFcXbh8p3/1KOX8/V8eA6Q9A=;
	b=Cwd5nn8mGMcw08OzE0p/GngGiO
	XNDinPVA9h0z8gOXLwNvPC5+xGzUuqzVJ7bzHX6VrHtT2KWxhDwEh2w+4DScwazticFb/jTlov9+O
	ZsglZG/XJJ9o4ddV713LiunQaBw97yejihx2A6H9mBNjCWNm+CrvkGqbWkjZfSnppVn5Tc9zGVhYg
	c1T64d90DXi99E4doAqi5iXtVW1wIlubAneZwAcO699CTmXKuJCmMx70YR0/75mKUVOSCEwsALe9m
	J+CmrJ+zilbuREvyDod92BUSEGW1TzmHxcwBUEfT9HK4UT3AcOxXIQjmy7HHd4iFg+VVXFKVVOCIv
	h1CBNIwg==;
Received: from 089144199030.atnat0008.highway.a1.net ([89.144.199.30]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hyWTh-0000Zn-6C; Fri, 16 Aug 2019 07:16:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 3/6] arm-nommu: remove the unused pgprot_dmacoherent define
Date: Fri, 16 Aug 2019 09:07:51 +0200
Message-Id: <20190816070754.15653-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816070754.15653-1-hch@lst.de>
References: <20190816070754.15653-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Shawn Anastasio <shawn@anastas.io>, Will Deacon <will@kernel.org>,
	linux-m68k@lists.linux-m68k.org, Guan Xuetao <gxt@pku.edu.cn>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org,
	Paul Burton <paul.burton@mips.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/pgtable-nommu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
index 0b1f6799a32e..d0de24f06724 100644
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -62,7 +62,6 @@ typedef pte_t *pte_addr_t;
  */
 #define pgprot_noncached(prot)	(prot)
 #define pgprot_writecombine(prot) (prot)
-#define pgprot_dmacoherent(prot) (prot)
 #define pgprot_device(prot)	(prot)
 
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
