Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB8EC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:21:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE9064EB9
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE9064EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 952376F65E
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OCOGUxAa-kjs for <iommu@archiver.kernel.org>;
	Tue,  9 Feb 2021 06:21:50 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 5361B6F69F; Tue,  9 Feb 2021 06:21:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3921F6F61E;
	Tue,  9 Feb 2021 06:21:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05F86C0174;
	Tue,  9 Feb 2021 06:21:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34FB7C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:21:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1B7E886F63
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:21:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KBMUfXV3iVrB for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 06:21:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3694086BB4
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:21:44 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id l18so1038728pji.3
 for <iommu@lists.linux-foundation.org>; Mon, 08 Feb 2021 22:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d/9o6gw27S6UN8MkYq1blVrCI9BLsI4+H00tlbC8EBE=;
 b=favimtx+6weGe8M555lmQOBhCoy54oReElTcJzpJXeVeBgHQUImtrzhR4xL2PNQ4hj
 B61sBGHNGjtqai17pbRiKkfpKFlyf3N7SfEZNhj9p694hdjwUDNvbaxplQIoX3Y2HB75
 oM9e2a4FzCjXRLbXyImmgB1sz2HO9c4H1yk+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=d/9o6gw27S6UN8MkYq1blVrCI9BLsI4+H00tlbC8EBE=;
 b=GiE6xU9DS30+irer6f+owVT/IN3lOPfQXEm0mBGCCLivS6QFnQKnC50j/Cngp+OqOw
 XYOiRLanToT+l+6dBksGcnSLiD5ws72t+rSKazFxnZ67QNdl/p2cGR/ZtTha5tQhOcDQ
 scLQqcxOKLuMIupUz1OKQ/hj96JiJzaeIAcAnjzCbZ13jauZwVTmwb36kH7t6bpZKXMS
 Pc0KFwi+A/yCfvUns2OH5+ZyXuiC9ypYf0KcxJVqg0LvzGteSl/39QgSnmHz2AGg/Iw7
 5JGL7D6zX2caz5iDf2Pf7zcPt75Rwj+514bJUEbceyu85ad7BJA1qj8H1673LtWLquz1
 I3rw==
X-Gm-Message-State: AOAM533yFZItvlxzqmJEWx7TsVyhncPc0pYyGbBBb6XzIvmp2dU3AfxN
 HdFPuPV3n+Btid3ruda4sptrTw==
X-Google-Smtp-Source: ABdhPJz0oyYOZadpQA/7+OnNYsgqbz6PN7ozvQBTUr4giRuwP1fH3QYLnHESLb3E3I02eo5S/4aG/w==
X-Received: by 2002:a17:90a:4fe4:: with SMTP id
 q91mr2479504pjh.165.1612851703796; 
 Mon, 08 Feb 2021 22:21:43 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
 by smtp.gmail.com with UTF8SMTPSA id s23sm21047537pgj.29.2021.02.08.22.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 22:21:43 -0800 (PST)
From: Claire Chang <tientzu@chromium.org>
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 00/14] Restricted DMA
Date: Tue,  9 Feb 2021 14:21:17 +0800
Message-Id: <20210209062131.2300005-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Nicolas Boichat <drinkcat@chromium.org>, Claire Chang <tientzu@chromium.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>
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

This series implements mitigations for lack of DMA access control on
systems without an IOMMU, which could result in the DMA accessing the
system memory at unexpected times and/or unexpected addresses, possibly
leading to data leakage or corruption.

For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
not behind an IOMMU. As PCI-e, by design, gives the device full access to
system memory, a vulnerability in the Wi-Fi firmware could easily escalate
to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
full chain of exploits; [2], [3]).

To mitigate the security concerns, we introduce restricted DMA. Restricted
DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
specially allocated region and does memory allocation from the same region.
The feature on its own provides a basic level of protection against the DMA
overwriting buffer contents at unexpected times. However, to protect
against general data leakage and system memory corruption, the system needs
to provide a way to restrict the DMA to a predefined memory region (this is
usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).

[1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
[1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
[2] https://blade.tencent.com/en/advisories/qualpwn/
[3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
[4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132

Claire Chang (14):
  swiotlb: Remove external access to io_tlb_start
  swiotlb: Move is_swiotlb_buffer() to swiotlb.c
  swiotlb: Add struct swiotlb
  swiotlb: Refactor swiotlb_late_init_with_tbl
  swiotlb: Add DMA_RESTRICTED_POOL
  swiotlb: Add restricted DMA pool
  swiotlb: Update swiotlb API to gain a struct device argument
  swiotlb: Use restricted DMA pool if available
  swiotlb: Refactor swiotlb_tbl_{map,unmap}_single
  dma-direct: Add a new wrapper __dma_direct_free_pages()
  swiotlb: Add is_dev_swiotlb_force()
  swiotlb: Add restricted DMA alloc/free support.
  dt-bindings: of: Add restricted DMA pool
  of: Add plumbing for restricted DMA pool

 .../reserved-memory/reserved-memory.txt       |  24 +
 arch/powerpc/platforms/pseries/svm.c          |   4 +-
 drivers/iommu/dma-iommu.c                     |  12 +-
 drivers/of/address.c                          |  25 +
 drivers/of/device.c                           |   3 +
 drivers/of/of_private.h                       |   5 +
 drivers/xen/swiotlb-xen.c                     |   4 +-
 include/linux/device.h                        |   4 +
 include/linux/swiotlb.h                       |  32 +-
 kernel/dma/Kconfig                            |  14 +
 kernel/dma/direct.c                           |  51 +-
 kernel/dma/direct.h                           |   8 +-
 kernel/dma/swiotlb.c                          | 636 ++++++++++++------
 13 files changed, 582 insertions(+), 240 deletions(-)

-- 

v4:
  - Fix spinlock bad magic
  - Use rmem->name for debugfs entry
  - Address the comments in v3

v3:
  Using only one reserved memory region for both streaming DMA and memory
  allocation.
  https://lore.kernel.org/patchwork/cover/1360992/

v2:
  Building on top of swiotlb.
  https://lore.kernel.org/patchwork/cover/1280705/

v1:
  Using dma_map_ops.
  https://lore.kernel.org/patchwork/cover/1271660/

2.30.0.478.g8a0d178c01-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
