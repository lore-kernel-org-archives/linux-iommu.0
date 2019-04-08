Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22277C282CE
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 10:55:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4ECA21841
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 10:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rV1rVna9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4ECA21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8AEC9ED2;
	Mon,  8 Apr 2019 10:55:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7FF40ECD
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 10:55:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2AE0B623
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mE6r+VqKccIgA61PV+7PKvY1trL7VA9MrernA232p18=;
	b=rV1rVna9S54v5fGpJjqmY4EAf
	5jiI+nVhJmj9/G//zFcS7693R0+uRMGTEcI7/fcm1vHnyEU7rTHqCtECJgoDpBpswJeQ9q9TQzYLw
	LurW0fZ5/mIa42t0zTaaWfKJViQohN99LQKqSTJ8A6jVwOTUzm1/0xypHrv4elnFRIa9o9/feq5Xg
	hQmAcFU6UeIUYJbpZTzvlTTSRaz4eib/c0zl6U+OuL5TXayYKvpaBEypxNm9pgRx2KwT1hds3ZZnM
	hCjYnIz/3FUvDdOMQlsJiKhkeykXPsLS25OKG91XdghqrqkT75KW5FGTXqgbrYujLcpseVQdPKeyY
	mF9crDvlA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hDRwI-0004jl-4f; Mon, 08 Apr 2019 10:55:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Hellstrom <thellstrom@vmware.com>
Subject: revert dma direct internals abuse
Date: Mon,  8 Apr 2019 12:55:24 +0200
Message-Id: <20190408105525.5493-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, Deepak Rawat <drawat@vmware.com>,
	linux-kernel@vger.kernel.org
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
Message-ID: <20190408105524.QgjbmtgWSgnV2wG9v9DfKyDZxbsJ2AeeY7ctjeYF_1E@z>

Hi Linus,

unfortunately it took less than a merge window for the:

/*
 * All the dma_direct_* declarations are here just for the indirect call bypass,
 * and must not be used directly drivers!
 */

warning in dma-mapping.h to be ignored.  This series reverts the offender
to keep our API clean.

Thomas: please talk me first about your needs and I'll be happy to figure out
a proper API for what you want to do.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
