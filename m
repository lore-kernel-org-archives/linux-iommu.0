Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152EC31E44
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 10:09:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855F520665
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 10:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IXDbLqgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855F520665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3F2B910F9;
	Fri, 14 Jun 2019 10:09:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 540B410F1
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 10:09:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D6BA3174
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 10:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YuvfDmTRlrw28HgCcbxWCLme+ZpdUXZ77St9YzhMCWw=;
	b=IXDbLqgToWu6+SArZBz4mZAcV
	nNd5zi+VwoF0UG1YtG+D7ozFNxiUtyoC4WV4gEi3r3ad0Lj5XN8GbWQa/KNJ9DXHo+flRA5QSiZ/S
	k7T19ABuAfMaiuuEYhvHX/S8sfg7lUC1CxDtrMCedY80uHZBkuE5MsmXtbUlmIONWkZ7flCvw1yDQ
	XvylQaO6KMH8JIK2tVT9MCGIDTiIVzY1sBziAK7C6AIIepQtMppPy5xaDeOfZ4RXXejhfAGgPdHpL
	MD2dJKR+wpAmEF8O6bDGPSlE/2DLUjxZOGVlAYTHejDI8gRVQTNEndMqYgCUTDY9l9H20WVwPhjry
	aU7ZXabcw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hbj9I-0007sR-QG; Fri, 14 Jun 2019 10:09:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Greentime Hu <green.hu@gmail.com>,
	Vincent Chen <deanbo422@gmail.com>
Subject: [RFC] switch nds32 to use the generic remapping DMA allocator
Date: Fri, 14 Jun 2019 12:09:27 +0200
Message-Id: <20190614100928.9791-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hi Greentime and Vicent,

can you take a look at the (untested) patch below?  It converts nds32
to use the generic remapping DMA allocator, which is also used by
arm64 and csky.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
