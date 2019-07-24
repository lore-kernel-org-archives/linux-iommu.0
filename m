Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BD0C7618B
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:49:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE7121926
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 14:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bJ7ghFzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE7121926
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1203AC90;
	Wed, 24 Jul 2019 14:49:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2B7B3C6E
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:49:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D1160FE
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gj6vhBjXAzGh9jRMU6YR+yrj0IdWgFMq59EQg/9k+u8=;
	b=bJ7ghFzSFQMsTBd0wP3AqBV5KZ
	o8+R3qyOWbW/2i67yT4bnvLvsRttMcjNaaGGX9m9HsdLJYPh4oqUX+MuTncF56xAEolcxzQSybgqI
	GAFF0myGqKoKvI/P30X0SvuyGFHHvd4ZuJqykpUU2asA85NN3Ynx5qh895L5OuKw0NlF93Pzk4Dvp
	CfW19KczHwFJWzph29RVu4RDAybG5+FGrn5y3v9ihDLQRI/HN9ik5Be8VIGLyUnsjZL1iXUn8n/kw
	soljA8t5+voJS/ZgzC5peplaw0NUa6G6AkDp2lNkSYrvZUIoBvHABaydRJKHuwOHqNOq1jHbSygDD
	zJZhFirg==;
Received: from [46.183.103.8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hqIaZ-00039s-5G; Wed, 24 Jul 2019 14:49:57 +0000
Date: Wed, 24 Jul 2019 16:49:42 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fix for 5.3
Message-ID: <20190724144942.GA7893@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
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

The following changes since commit 7b5cf701ea9c395c792e2a7e3b7caf4c68b87721:

  Merge branch 'sched-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2019-07-22 09:30:34 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-2

for you to fetch changes up to 06532750010e06dd4b6d69983773677df7fc5291:

  dma-mapping: use dma_get_mask in dma_addressing_limited (2019-07-23 17:43:58 +0200)

----------------------------------------------------------------
dma-mapping regression fix for 5.3

 - ensure that dma_addressing_limited doesn't crash on devices
   without a dma mask (Eric Auger)

----------------------------------------------------------------
Eric Auger (1):
      dma-mapping: use dma_get_mask in dma_addressing_limited

 include/linux/dma-mapping.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
