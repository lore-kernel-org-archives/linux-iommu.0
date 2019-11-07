Return-Path: <SRS0=3PM5=Y7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E0C5DF61
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 15:07:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F97F207FA
	for <iommu@archiver.kernel.org>; Thu,  7 Nov 2019 15:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F97F207FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 25B9A1576;
	Thu,  7 Nov 2019 15:07:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8DE1CB88
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 15:07:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E9C9A87D
	for <iommu@lists.linux-foundation.org>;
	Thu,  7 Nov 2019 15:07:08 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id ED301B24F;
	Thu,  7 Nov 2019 15:07:06 +0000 (UTC)
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: rubini@gnudd.com,
	hch@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] x86: Get rid of custom DMA functions
Date: Thu,  7 Nov 2019 16:06:43 +0100
Message-Id: <20191107150646.13485-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>
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

sta2x11 is the only x86 device that depends custom DMA direct functions.
It turns out it can be made standard by carefully setting the device's
DMA masks and offset.

Originally only patch #2 was sent but I realised patch #1 is also
needed, which is a good addition as it's also a prerequisite to get
proper DMA support on the Raspberry Pi 4[1].

[1] https://lkml.org/lkml/2019/10/15/523

---

Changes since v2:
  - cleanup dma-direct.h

Changes since v1:
  - Small cleanups in sta2x11-fixup.x
  - add patch checking DMA addresses lower bounds

Nicolas Saenz Julienne (2):
  dma-direct: check for overflows on 32 bit DMA addresses
  x86/PCI: sta2x11: use default DMA address translation

 arch/x86/Kconfig                  |   1 -
 arch/x86/include/asm/device.h     |   3 -
 arch/x86/include/asm/dma-direct.h |   9 --
 arch/x86/pci/sta2x11-fixup.c      | 135 ++++++------------------------
 include/linux/dma-direct.h        |  12 ++-
 5 files changed, 36 insertions(+), 124 deletions(-)
 delete mode 100644 arch/x86/include/asm/dma-direct.h

-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
