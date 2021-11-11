Return-Path: <SRS0=Rhk0=P6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4643BC433F5
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA12561354
	for <iommu@archiver.kernel.org>; Thu, 11 Nov 2021 06:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA12561354
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CB8860799;
	Thu, 11 Nov 2021 06:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P1bvn72mQrnc; Thu, 11 Nov 2021 06:50:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 60E9F60710;
	Thu, 11 Nov 2021 06:50:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BCB0C0036;
	Thu, 11 Nov 2021 06:50:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71E60C001E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5D296404EB
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ak84GlqKu84h for <iommu@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 06:50:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5882F404EA
 for <iommu@lists.linux-foundation.org>; Thu, 11 Nov 2021 06:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=gn6Wkb8BiEOx+rEvSApCDWGoKlUiGNT/5yYSUIyeRHQ=; b=aZOeGPEb0CkcSYbM3td7cfhxJr
 T2TMexwANmprETDryNPYhM1C4RnoOuhBrTaSFgT4t2JoPjn+BDDsbK3gBAKYH1+Jpv0HsvVcwz1Yz
 NX5ZS1HUVax9owhfqyO0jJI/A++pJlT5aT+PGl3718alHSMTl3bTotbajYP//tptOB2OtdL+xVjp6
 T/AaWKxUocnpa+7wkdBfFJtsAk6vq/byScFhGT9YMu7sWr5li+m2tJm5abSx8K3E86hxu/RhQ3Y5R
 CZZr61cZ4eZj2T67E/6k4zZX9+fSaiJ7svJeAOHiQhzuELnsBlbWQ6JrApy6wuiQhp32/x41kMGyL
 socQucxQ==;
Received: from [2001:4bb8:19a:7ee7:dc25:8b64:278b:ff22] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml3um-002Vwt-8E; Thu, 11 Nov 2021 06:50:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: dma-direct fixes and cleanups v3
Date: Thu, 11 Nov 2021 07:50:16 +0100
Message-Id: <20211111065028.32761-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Robin Murphy <robin.murphy@arm.com>, David Rientjes <rientjes@google.com>
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

Hi all,

Linus complained about the complex flow in dma_direct_alloc, so this
tries to simplify it a bit, and while I was at it I also made sure that
unencrypted pages never leak back into the page allocator.

Changes since v2:
 - don't call dma_set_decrypted on remapped memory
 - move the leak printk into dma_set_encrypted
 - add another local variable to clean up dma_direct_alloc
 - return NULL when the is no way to make the memory coherent

Changes since v1:
 - fix a missing return
 - add a new patch to fix a pre-existing missing unmap
 - various additional cleanups
 
Diffstat:
 direct.c |  234 +++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 138 insertions(+), 96 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
