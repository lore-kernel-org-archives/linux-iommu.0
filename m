Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE07C433E2
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 15:47:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECBE20725
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 15:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJBiP+/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECBE20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5667F8996A;
	Fri, 10 Jul 2020 15:47:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6pCruBGcRWBl; Fri, 10 Jul 2020 15:47:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 971778995E;
	Fri, 10 Jul 2020 15:47:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79D24C0890;
	Fri, 10 Jul 2020 15:47:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52724C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 15:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3B27287F9E
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 15:47:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a3w23ialJc_j for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 15:47:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C953487F38
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 15:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=vCsywWVyci9HlOV4imkRZosCZdjmA3MYbicJkkOvp3w=; b=XJBiP+/bOFSCF5Jy4+oXiTpcf/
 GfMLG7vgyn7RjT7wuZPO8EsK9vVW7VtCui1m4vtMZAQdBruj/JiBXv7AFFNjDEDGLGjDH6d2k/DR4
 cQlTbrXt2FbA4yBDNeXJ6lWyyxsFbExvrx45MCi7plNEPHHN+/8Yj1yolOrDVIKoC44gayFlMF5U9
 j8UZ1oPrmmT/sJHAPzkcvQDhLuqfa9cTKyEFr17FCcqDaND4r2xEjp+Ty6H/6Rp58TUJfUdWijSiM
 oQfVYCo1N21McJfzmukC9lMz/NJTrA2/Z6kMPw+miERDkz2u3sRTaz2LZY7mjMDDIiWWAEvD/m4FU
 RmQcc/eQ==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtvF7-0001vd-8z; Fri, 10 Jul 2020 15:47:17 +0000
Date: Fri, 10 Jul 2020 17:45:06 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fixes for 5.8
Message-ID: <20200710154506.GA540305@infradead.org>
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

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-5

for you to fetch changes up to 68d237056e007c88031d80900cdba0945121a287:

  scatterlist: protect parameters of the sg_table related macros (2020-07-06 16:07:25 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.8

 - add a warning when the atomic pool is depleted (David Rientjes)
 - protect the parameters of the new scatterlist helper macros
   (Marek Szyprowski )

----------------------------------------------------------------
David Rientjes (1):
      dma-mapping: warn when coherent pool is depleted

Marek Szyprowski (1):
      scatterlist: protect parameters of the sg_table related macros

 include/linux/scatterlist.h | 8 ++++----
 kernel/dma/pool.c           | 6 +++++-
 2 files changed, 9 insertions(+), 5 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
