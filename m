Return-Path: <SRS0=f6HJ=CI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A7EC433E2
	for <iommu@archiver.kernel.org>; Sun, 30 Aug 2020 06:31:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA702078D
	for <iommu@archiver.kernel.org>; Sun, 30 Aug 2020 06:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cnqnp0AE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA702078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C2FEC8782E;
	Sun, 30 Aug 2020 06:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qa8xqtFJPoSH; Sun, 30 Aug 2020 06:31:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 931478780D;
	Sun, 30 Aug 2020 06:31:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78929C07FF;
	Sun, 30 Aug 2020 06:31:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0808C0051
 for <iommu@lists.linux-foundation.org>; Sun, 30 Aug 2020 06:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A22AB85618
 for <iommu@lists.linux-foundation.org>; Sun, 30 Aug 2020 06:31:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9qpBPHmVy8GN for <iommu@lists.linux-foundation.org>;
 Sun, 30 Aug 2020 06:31:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 53DCA850E9
 for <iommu@lists.linux-foundation.org>; Sun, 30 Aug 2020 06:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=w4rdv8966e/ci26pS2v3qeUYzDOBI3t7rgVpxPk1vag=; b=cnqnp0AESXTufJkmw+5NN2Xb/N
 4VPK2PuL1Sb8xnYL1iTN85h2qjRgCTzmInTNmiD4bzi/dRt30jGHhWUJgBD9HoMUZHOEIxAlFOS/8
 6/uTTlDaGRYoM9B5M64KwwP0+/XACA1pkscZxMsyHnr+eGBQzuQff/XMVDpoYAtJ/LH5d76nES6W9
 jqNY6pn2xSfnaXvOXuWSbtxV1lfb1uuDxCLOLUX2zy3u0wPwBtuFyeyQs5buvRYcMM0CRZ1tCcvJq
 WZhHHvE6jh0mUlV2vvOCX7JwhwIby+dKVcp6vUlzYNP6YzYnpzwriIZxZaUlV8ikXrgSEBA/8t8lc
 nzBEVQ+w==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCGsK-00035u-EN; Sun, 30 Aug 2020 06:31:36 +0000
Date: Sun, 30 Aug 2020 08:31:35 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fix for 5.9
Message-ID: <20200830063135.GA1224156@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

The following changes since commit 15bc20c6af4ceee97a1f90b43c0e386643c071b4:

  Merge tag 'tty-5.9-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty (2020-08-26 10:58:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9-2

for you to fetch changes up to 892fc9f6835ecf075efac20789b012c5c9997fcc:

  dma-pool: Fix an uninitialized variable bug in atomic_pool_expand() (2020-08-27 09:22:56 +0200)

----------------------------------------------------------------
dma-mapping fixes:

 - fix a possibly uninitialized variable (Dan Carpenter)

----------------------------------------------------------------
Dan Carpenter (1):
      dma-pool: Fix an uninitialized variable bug in atomic_pool_expand()

 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
