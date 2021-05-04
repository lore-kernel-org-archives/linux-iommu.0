Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286F9C433B4
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 07:58:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A16556139A
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 07:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16556139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5161E843C1;
	Tue,  4 May 2021 07:58:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0RPZ19wT7ek0; Tue,  4 May 2021 07:58:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1748183EF6;
	Tue,  4 May 2021 07:58:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2A79C000D;
	Tue,  4 May 2021 07:58:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38866C0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 07:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17D92402DA
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 07:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ACb53lqFZDOO for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 07:58:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BE78402D4
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 07:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=sXgrmVuHfa4aFek6+BLNJ7tIPk2rJFVZ+IKiwBfq8WY=; b=L46wAmpOtecCf5PjUSrZ1TMpt6
 mAgLFqGcJF9vkNLDepdEdZuI7fgvIO/10TZru/mnGyHPBGx96t/baKdM9UbvGwSMIJcqq0sjuAA+e
 n9G1d1xOzFeOe+qswGS8MWIShIgxZnsqu6bS+qAcqyp1ynvnRSOuyaJgEnkKfe8I4ZnWl5S5ab9ic
 H/ArbDzj2Cd86bpFrke12ZldcjdZONcJ0CZwRVIxt0nWI7r0yJ7iM7G7NwswqqZtZciOTpWf8S+DW
 BBp7LmHLi8lKeYlrC+xO08g7iYD47os7sKmUmC4Y6N4B8VHkZ6A6wjQXU3YRKlUYP2jXEwVaE1eoi
 uyF2fPrA==;
Received: from [2001:4bb8:180:9479:4770:b9a9:306b:b991] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ldpwn-003moi-Qp; Tue, 04 May 2021 07:58:26 +0000
Date: Tue, 4 May 2021 09:58:23 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] dma-mapping updates for Linux 5.13
Message-ID: <YJD+n2zT+BOA7ar8@infradead.org>
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

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.13

for you to fetch changes up to a7f3d3d3600c8ed119eb0d2483de0062ce2e3707:

  dma-mapping: add unlikely hint to error path in dma_mapping_error (2021-04-02 16:41:08 +0200)

----------------------------------------------------------------
dma-mapping updates for Linux 5.13:

 - add a new dma_alloc_noncontiguous API (me, Ricardo Ribalda)
 - fix a copyright noice (Hao Fang)
 - add an unlikely annotation to dma_mapping_error (Heiner Kallweit)
 - remove a pointless empty line (Wang Qing)
 - add support for multi-pages map/unmap bencharking (Xiang Chen)

----------------------------------------------------------------
Christoph Hellwig (5):
      dma-mapping: add a dma_mmap_pages helper
      dma-mapping: refactor dma_{alloc,free}_pages
      dma-mapping: add a dma_alloc_noncontiguous API
      dma-iommu: refactor iommu_dma_alloc_remap
      dma-iommu: implement ->alloc_noncontiguous

Hao Fang (1):
      dma-mapping: benchmark: use the correct HiSilicon copyright

Heiner Kallweit (1):
      dma-mapping: add unlikely hint to error path in dma_mapping_error

Ricardo Ribalda (1):
      media: uvcvideo: Use dma_alloc_noncontiguous API

Wang Qing (1):
      dma-mapping: remove a pointless empty line in dma_alloc_coherent

Xiang Chen (1):
      dma-mapping: benchmark: Add support for multi-pages map/unmap

 Documentation/core-api/dma-api.rst              |  88 ++++++++++++++
 drivers/iommu/dma-iommu.c                       | 103 ++++++++++++-----
 drivers/media/usb/uvc/uvc_video.c               |  94 +++++++++++----
 drivers/media/usb/uvc/uvcvideo.h                |   5 +-
 include/linux/dma-map-ops.h                     |  19 +++
 include/linux/dma-mapping.h                     |  37 +++++-
 kernel/dma/map_benchmark.c                      |  23 ++--
 kernel/dma/mapping.c                            | 148 ++++++++++++++++++++++--
 tools/testing/selftests/dma/dma_map_benchmark.c |  22 +++-
 9 files changed, 456 insertions(+), 83 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
