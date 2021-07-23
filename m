Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832C4C4320E
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B05260F02
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B05260F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2264660A3E;
	Fri, 23 Jul 2021 21:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qdnR3_yRWTbn; Fri, 23 Jul 2021 21:40:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0151460BB0;
	Fri, 23 Jul 2021 21:40:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF694C0010;
	Fri, 23 Jul 2021 21:40:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB176C0023
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5DF860720
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P0fXjwNSBbJg for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 21:40:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82B94606FD
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1627076436; x=1658612436;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mh2H2AqgX7zCMJmvVV14kJPveSdfSaOx1iNS29W3dS0=;
 b=o+h9E4WmCQj9/XBkf3NWy2VSX3a/rukf81EL1bgquD89fmYBkkx9/3fw
 EsnJeBVrBozhNpFp/IWV3QIGwc/myeRdmcOHeBJflSTejbK7u/Mfh8hoG
 aEtLzP54eHCuOve+TMR5uv4dCiThfV168HCCjk5k1CY8Y+4BEsj2LxiQB
 ybJ91mk1bpir1HKHgPZsv/Vbt3K8YbAzFhIYF93oHot17TQfM3kwNtD18
 7f9yINKlBKLo4rC/apRd0747s4B+aNQZqhBSN7KXB92u9By0hJBUE1hxP
 +wu5bj0WsNl4EEITQBOBWhPfXIxeYZo4C696fTalZg3sk6cSxy10Cr/ld A==;
X-IronPort-AV: E=Sophos;i="5.84,265,1620662400"; d="scan'208";a="279198446"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2021 05:40:34 +0800
IronPort-SDR: D/q43S9qeJntfV+wrjune68QDivLzQGJVbu0XVjL9HUsM2rzkzlbS5p7qAJMIcg2mWUopdd95u
 fqQtCdoZqLECAymWh9PSWCDTS61MMjRos5yUWwwUZDtbsXtV41Ct75u9zxlOVs2eKBsJB935rt
 fwqF41lzaHkoElvprqE7mPVNayy28tmkgz93SOfOb4rIZVeDlUK16+rlZdmDi/11+jEQ6mA+zo
 W6rDaUht/dBELngOLXyWhC7dwOcYVNrw4SDziHOay/wM3IMDyn7P23fx09yKsVZchoXtnqyREt
 FoZwkd/nj6Iu7CtvXKy5IlMO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 14:18:24 -0700
IronPort-SDR: S4LhvUQ74NR2pVUEi2iTWK2rF8yj17ZaeIV3WL/BXkS6QFGmU8kh/4TeJIUSHlFaNwOsG1NQAn
 xppqY2Z9lrhrzfXSczZj+czih/cqibkinofktm7F6aEhMYJnPYQWxN/sknVi5xcjOpJVosupM2
 O42MX0dNi1Y+YMpbypuzOq4wGPiD/5HaOupgAhHRmSXp+gEce2HrJ/hdPg24Yln6P6Cbd2XCa6
 c1XNQeTqq0mai1j7h7sDxqR9fQFKgHDHx+clem2xb0gcj9Mh5q3l6kf8xgR9idp/ttiMgjWziv
 /HY=
WDCIronportException: Internal
Received: from ucfbox21.ad.shared (HELO hulk.wdc.com) ([10.225.167.4])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Jul 2021 14:40:35 -0700
From: Atish Patra <atish.patra@wdc.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC 0/5] Support non-coherent DMA on RISC-V using a global pool
Date: Fri, 23 Jul 2021 14:40:26 -0700
Message-Id: <20210723214031.3251801-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Tobias Klauser <tklauser@distanz.ch>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Atish Patra <atish.patra@wdc.com>,
 iommu@lists.linux-foundation.org, Guo Ren <guoren@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>
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

RISC-V privilege specification doesn't define an IOMMU or any method modify
PMA attributes or PTE entries to allow non-coherent mappings yet. In
the beginning, this approach was adopted assuming that most of the RISC-V
platforms would support full cache-coherent IO. Here is excerpt from the
priv spec section 3.6.5

"In RISC-V platforms, the use of hardware-incoherent regions is discouraged
due to software complexity, performance, and energy impacts."

While some of the RISC-V platforms adhere to the above suggestion, not all
platforms can afford to build to fully cache-coherent I/O devices. To
address DMA for non-coherent I/O devices, we need to mark a region of memory
as non-cacheable. Some of the platforms rely on a fixed region of uncached
memory that is remapped to the system memory while some other modify
the PTE entries to achieve that.

The patch3 solves the issue for the fist use case by using a global
pool of memory that is reserved for DMA. The device access the reserved area
of the region while corresponding CPU address will be from uncached region
As the uncached region is remapped to the beginning of the system ram, both
CPU and device get the same view.

To facilitate streaming DMA APIs, patch 1 introduces a set of generic
cache operations. Any platform can use the generic ops to provide platform
specific cache management operations. Once the standard RISC-V CMO extension
is available, it will also use these generic ops.

To address the second use case, Page Based Memory Attribute (PBMT) extension
is proposed. Once the extension is in good shape, we can leverage that
using CONFIG_DIRECT_REMAP. Currently, it is selected via a compile time config
option. We will probably need another arch specific hooks to know if the
platform supports direct remap at runtime. For RISC-V, it will check the
presence of PBMT extension while other arch function will simply return true
if DIRECT_REMAP is enabled. This is required as arious different config
(DIRECT_REMAP, GLOBAL_POOL) will be enabled in the defconfig so that a
unified kernel image can boot on all RISC-V platforms.

This patch series depends on Christoph's global pool support series[1].
Tested on Qemu, HiFive unleashed and beagleV. This series is also available
at [2]. 
This series also solves the non-coherent DMA support on beagleV but requires
additional beagleV specific patches[3] which will be upstreamed soon.


[1] https://lists.linuxfoundation.org/pipermail/iommu/2021-July/057266.html 
[2] https://github.com/atishp04/linux/tree/riscv_nc_global_pool
[3] https://github.com/atishp04/linux/tree/wip_beaglev_dma_nc_global

Atish Patra (5):
RISC-V: Implement arch_sync_dma* functions
of: Move of_dma_get_range to of_address.h
dma-mapping: Enable global non-coherent pool support for RISC-V
dma-direct: Allocate dma pages directly if global pool allocation
fails
RISC-V: Support a new config option for non-coherent DMA

arch/riscv/Kconfig                       |  8 +++
arch/riscv/include/asm/dma-noncoherent.h | 19 +++++++
arch/riscv/mm/Makefile                   |  1 +
arch/riscv/mm/dma-noncoherent.c          | 66 ++++++++++++++++++++++++
drivers/of/of_private.h                  | 10 ----
include/linux/of_address.h               | 12 +++++
kernel/dma/coherent.c                    | 49 +++++++++++++++---
kernel/dma/direct.c                      |  7 ++-
8 files changed, 152 insertions(+), 20 deletions(-)
create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
create mode 100644 arch/riscv/mm/dma-noncoherent.c

--
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
