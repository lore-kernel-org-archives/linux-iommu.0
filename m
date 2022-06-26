Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BDFC43334
	for <iommu@archiver.kernel.org>; Sun, 26 Jun 2022 05:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B03441859;
	Sun, 26 Jun 2022 05:52:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B03441859
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F3sWX83I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qg0mLTFeTItM; Sun, 26 Jun 2022 05:52:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 08EE541851;
	Sun, 26 Jun 2022 05:52:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08EE541851
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA683C0039;
	Sun, 26 Jun 2022 05:52:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4A5FC002D
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 05:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B02B4028D
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 05:52:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B02B4028D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F3sWX83I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 70XzqKXlZbXa for <iommu@lists.linux-foundation.org>;
 Sun, 26 Jun 2022 05:52:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F06E400AC
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F06E400AC
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jun 2022 05:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=zwx5Svpj0Ro/UPJKmY0oNTC1x1wYqztY5B1xeCB49S4=; b=F3sWX83IIuJpvV9ZkcA03mtXNl
 oAYusD5wkL0bBiKKKoGb97E3gewpXr5zD2wQ/89ljziXzithgG++He30A2OG5RjbcGfKJ48b2UB9w
 +fEIBZugUDAZp/h37kG6zPd87Or1zAbCtus5CiuqxosDJZhnEXZCc6/RBTeQQjRmA38YoAU66PTTJ
 vB8UTie4nAZ6VeN492Z2rN80FuLgHgkAxiXgpOzP8VMs9Zt4Ogrq0mc0IzbwHopLH0la+6ppg8c+7
 Ljkmmf2U9f6xYoE9JjiAMPaLOSTo2MZxfb768N6/58eNE9YDapH97eC9Nv6m1AYXPPuTidAEmBGo3
 v+M2sWig==;
Received: from [2001:4bb8:199:3788:15b9:a02f:7fe3:abaf] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1o5LCG-009vHw-T9; Sun, 26 Jun 2022 05:52:37 +0000
Date: Sun, 26 Jun 2022 07:52:34 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping fix for Linux 5.19
Message-ID: <Yrf0ItiAJ4cVfdPf@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-06-26

for you to fetch changes up to 3be4562584bba603f33863a00c1c32eecf772ee6:

  dma-direct: use the correct size for dma_set_encrypted() (2022-06-23 15:26:59 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 5.19

 - pass the correct size to dma_set_encrypted() when freeing memory
   (Dexuan Cui)

----------------------------------------------------------------
Dexuan Cui (1):
      dma-direct: use the correct size for dma_set_encrypted()

 kernel/dma/direct.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
