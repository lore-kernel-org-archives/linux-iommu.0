Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4471FC10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:10:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102AA21850
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 07:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jgGu0IY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102AA21850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 119032299;
	Thu, 11 Apr 2019 07:10:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 845612290
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:10:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 688D2F4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 07:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vlNlrI34Zr5Cyj2P1lmGJ+yO6NGkQWFQi0XBAP+2ijY=;
	b=jgGu0IY0G/vEsxzn5hYzHaa8e
	79HaBZJ4gJDjsFVlt/6mchybQk298ebWb/26Z0EdLnAurYKP+OvYJWCXBsHqexsw9TLZfrPb1EwwK
	t+IiInms0cZbUqhT7Ub42R7z/P9avaHtloXmcvdSU+b0vKFfC+4MlCQFS7XMOkcdTl6EBSh5uxAGP
	boQR+AxF9EIkNEalCLtFdh8oP7h4pxmuE8WDWd5YUKqcR5qSkkrFtDL2TyoRWi2g9O4TySdoG5H91
	TqyEC7EMGngZbeB20Pl3jWx+6oCS1w75oqyw8RhORDxFO1T2T9r33+FpWtFuMKc5dE7S8/oKvt+6r
	3coP3k6Ow==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hETqc-0006mr-NM; Thu, 11 Apr 2019 07:10:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Subject: get rid of dma_max_pfn
Date: Thu, 11 Apr 2019 09:09:46 +0200
Message-Id: <20190411070948.29564-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
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
Message-ID: <20190411070946.IG6cKfTddK1ONll0ZYcNQj-RokNnuqGe-duxx9t7zbI@z>

Hi everyone,

I though I got rid of all non-highmem, non-ISA block layer bounce
buffering a while ago, but I missed the MMC case.  While I still plan to
also kill off the highmem bouncing there I won't get to it this merge
window, so for now I'd like to make some progress and move MMC to the
DMA layer (swiotlb or arm dmabounce) bouncing for addressing limitations
and kill off the dma_max_pfn helper.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
