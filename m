Return-Path: <SRS0=J3yl=YT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080B9CA9EB9
	for <iommu@archiver.kernel.org>; Sat, 26 Oct 2019 05:45:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2047214DA
	for <iommu@archiver.kernel.org>; Sat, 26 Oct 2019 05:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jvYPutk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2047214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5DE1AE43;
	Sat, 26 Oct 2019 05:45:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 99757DD5
	for <iommu@lists.linux-foundation.org>;
	Sat, 26 Oct 2019 05:45:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8763B102
	for <iommu@lists.linux-foundation.org>;
	Sat, 26 Oct 2019 05:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+5wJzXbxCtQrwDXJERufHrvtviLSbDdpQ5zkUXtHDM8=;
	b=jvYPutk33nLzO4xA4Vlidwi/f5
	UAGY171Z+5TWnFxLCnOY5/kamSI5NYbuCWKB+fxvnX8Wky7h9PNRx30ftSb/2St3cZezWNq+gTfxi
	EZv2U3SHmkI3ci4WyYcYIpV5BTH5OSegZBTYr/8RD6HEFG1FCNcpxRGMp44JATFjpTi0RW8WtTYc/
	/Fvc/+4pSutIo7Ba/lbk4bndvsQYg2vviwjIaeGCP7TLncb8tWFUsI9s/GttnLpPdlHd9AR3Lk1E6
	SEOFYDz+x9/TCcVxPE54ufSPozof7kRkft+WHziQ7XhBMHFJBHJhybDyBghNd3AxRM5Z0u+VspdhI
	tW6aPHgQ==;
Received: from [2001:4bb8:184:47ee:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iOEtd-0007iR-Bq; Sat, 26 Oct 2019 05:45:53 +0000
Date: Sat, 26 Oct 2019 07:45:51 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fix for 5.4-rc
Message-ID: <20191026054551.GA5340@infradead.org>
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

The following changes since commit 0e2adab6cf285c41e825b6c74a3aa61324d1132c:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2019-10-17 17:00:14 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.4-2

for you to fetch changes up to 9c24eaf81cc44d4bb38081c99eafd72ed85cf7f3:

  iommu/vt-d: Return the correct dma mask when we are bypassing the IOMMU (2019-10-18 17:19:20 +0200)

----------------------------------------------------------------
dma-mapping fix for 5.4

 - fix a regression in the intel-iommu get_required_mask conversion
   (Arvind Sankar)

----------------------------------------------------------------
Arvind Sankar (1):
      iommu/vt-d: Return the correct dma mask when we are bypassing the IOMMU

 drivers/iommu/intel-iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
