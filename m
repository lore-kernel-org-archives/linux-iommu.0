Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E98C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:20:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAF12133D
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EAmU8yLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAF12133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 15562220D;
	Thu, 11 Apr 2019 07:20:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AE6421ECF
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:20:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2B7D1F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9rgLBTobUlfyW0kUm7uO449bZqYFnsJPAG1/oEP8+gU=;
	b=EAmU8yLU7flnhOpuyBNS9HbTT
	0BCQvd1NuJKFCjYlXQ7yOGSORH+Gb9VO+5Ajn+IrbtdIvZlDXqNHQf5tyg3jzEraucGFKX4lUrqWV
	CJdjkenVhUYRoeZ2MKBTxmOTD0YYNxecUOYMPcPL1vJBaVFpKyEJsV0SAL4nH44v95caoby0LLk5U
	cSndaAImyZGIwHJN6h4dAQe1U7ryRRZeZoqKX19IduJVk5gGxptSPQjm1LYWT6rI+cni+lUshtmOy
	pMaqDPmNyythaxBzBFexRUZ7wKzZc/LPtg2K/2+jAbMcPYUrUJ0wc+s3SggZ+15Pbtm1hqhdcz0yc
	V+dPU9vbg==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hEU0U-0002ie-Ga; Thu, 11 Apr 2019 07:20:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: a few xen swiotlb cleanups
Date: Thu, 11 Apr 2019 09:19:56 +0200
Message-Id: <20190411072000.4306-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411071956.61g7mVf2N72t9td_wH71SxyW85AxKOEepuhqS-OYw2k@z>

Hi all,

below are a couple of cleanups for swiotlb-xen.c.  They were done in
preparation of eventually using the dma-noncoherent.h cache flushing
hooks, but that final goal will need some major work to the arm32 code
first.  Until then I think these patches might be better in mainline
than in my local tree so that they don't bitrot.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
