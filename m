Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D64EC4363A
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 07:00:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCBE238E6
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 07:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCBE238E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1B6E986B74;
	Wed, 28 Oct 2020 07:00:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q5kTfU+8R+kR; Wed, 28 Oct 2020 07:00:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EDCF4868E6;
	Wed, 28 Oct 2020 07:00:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5690C088B;
	Wed, 28 Oct 2020 07:00:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4053FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 07:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 16BC986B74
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 07:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V0C8js2PUgj2 for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 07:00:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
 by whitealder.osuosl.org (Postfix) with ESMTP id 11121868E6
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 07:00:35 +0000 (UTC)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id ED6EFAE80273;
 Wed, 28 Oct 2020 02:59:51 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 0/2] DMA,
 powerpc/dma: Fallback to dma_ops when persistent memory present
Date: Wed, 28 Oct 2020 18:00:28 +1100
Message-Id: <20201028070030.60643-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Cc: Michael Ellerman <mpe@ellerman.id.au>, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This allows mixing direct DMA (to/from RAM) and
IOMMU (to/from apersistent memory) on the PPC64/pseries
platform.

This replaces https://lkml.org/lkml/2020/10/27/418
which replaces https://lkml.org/lkml/2020/10/20/1085


This is based on sha1
4525c8781ec0 Linus Torvalds "scsi: qla2xxx: remove incorrect sparse #ifdef".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  dma: Allow mixing bypass and mapped DMA operation
  powerpc/dma: Fallback to dma_ops when persistent memory present

 arch/powerpc/kernel/dma-iommu.c        | 70 +++++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/iommu.c | 44 ++++++++++++----
 kernel/dma/mapping.c                   | 24 +++++++--
 arch/powerpc/Kconfig                   |  1 +
 kernel/dma/Kconfig                     |  4 ++
 5 files changed, 127 insertions(+), 16 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
