Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A949CCA479
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 12:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6DCC840D0;
	Fri, 17 Jun 2022 12:58:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6DCC840D0
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oH4x2Pyc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zc55vnfOLq6Y; Fri, 17 Jun 2022 12:58:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 82F0C82C7D;
	Fri, 17 Jun 2022 12:58:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82F0C82C7D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 593AEC0032;
	Fri, 17 Jun 2022 12:58:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDF62C002D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 12:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 87FE7833CD
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 12:58:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87FE7833CD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ABbi-2vp0rV8 for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:58:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 67AB982C7D
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 67AB982C7D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 12:58:06 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1724FB8282F;
 Fri, 17 Jun 2022 12:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CBDC3411B;
 Fri, 17 Jun 2022 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655470682;
 bh=cLraNpkEnCzF/4zKCRGjwHG57BoDqUlRiy0OHq9zjK0=;
 h=From:To:Cc:Subject:Date:From;
 b=oH4x2PycGtrhhz35364UaeAzZu23iN71evljdxuntEZ1VsVln0947L4kgXWuEzLrC
 OLWEWoJhN8r14vT4yHg3QQ8tQZDKO4OIba+kSPV417/BH7s5oxSh7c9Yljg6Gr1afz
 xj6FbXz6U/9X2aXj04KSLFiOeD9C/zZoF0JfQi5Xj9zHHyGlm4nv/8XJxqnfGaiKhC
 xU+lb1e94omoeQ0C4aaO2uCUV9m066p1W0G5moNKShM55uVOSpn4kV7bLBshwrY4Rp
 NgxDokayeZJhS/Gn+T5DZpIazOVqwZSNsiUx9537mSMzxTSIGDTQ6H1nn5bxhvpiW3
 g1++SMPFn7Evg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] phase out CONFIG_VIRT_TO_BUS
Date: Fri, 17 Jun 2022 14:57:47 +0200
Message-Id: <20220617125750.728590-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, Miquel van Smoorenburg <mikevs@xs4all.net>,
 linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, "Maciej W . Rozycki" <macro@orcam.me.uk>,
 linux-m68k@lists.linux-m68k.org, Denis Efremov <efremov@linux.com>,
 Mark Salyzyn <salyzyn@android.com>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Matt Wang <wwentao@vmware.com>,
 linux-alpha@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Khalid Aziz <khalid@gonehiking.org>, Robin Murphy <robin.murphy@arm.com>
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

From: Arnd Bergmann <arnd@arndb.de>

The virt_to_bus/bus_to_virt interface has been deprecated for
decades. After Jakub Kicinski put a lot of work into cleaning out the
network drivers using them, there are only a couple of other drivers
left, which can all be removed or otherwise cleaned up, to remove the
old interface for good.

Any out of tree drivers using virt_to_bus() should be converted to
using the dma-mapping interfaces, typically dma_alloc_coherent()
or dma_map_single()).

There are a few m68k and ppc32 specific drivers that keep using the
interfaces, but these are all guarded with architecture-specific
Kconfig dependencies, and are not actually broken.

There are still a number of drivers that are using virt_to_phys()
and phys_to_virt() in place of dma-mapping operations, and these
are often broken, but they are out of scope for this series.

I would like the first two patches to either get merged through
the SCSI tree, or get an Ack from the SCSI maintainers so I can
merge them through the asm-generic tree

      Arnd

---
Changes since v1:
 - dropped VME patches that are already in staging-next
 - dropped media patch that gets merged independently
 - added a networking patch and dropped it again after it got merged
 - replace BusLogic removal with a workaround

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org> # dma-mapping
Cc: Marek Szyprowski <m.szyprowski@samsung.com> # dma-mapping
Cc: Robin Murphy <robin.murphy@arm.com> # dma-mapping
Cc: iommu@lists.linux-foundation.org
Cc: Khalid Aziz <khalid@gonehiking.org> # buslogic
Cc: Maciej W. Rozycki <macro@orcam.me.uk> # buslogic
Cc: Matt Wang <wwentao@vmware.com> # buslogic
Cc: Miquel van Smoorenburg <mikevs@xs4all.net> # dpt_i2o
Cc: Mark Salyzyn <salyzyn@android.com> # dpt_i2o
Cc: linux-scsi@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arch@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-parisc@vger.kernel.org
Cc: Denis Efremov <efremov@linux.com> # floppy

Arnd Bergmann (3):
  scsi: dpt_i2o: drop stale VIRT_TO_BUS dependency
  scsi: BusLogic remove bus_to_virt
  arch/*/: remove CONFIG_VIRT_TO_BUS

 .../core-api/bus-virt-phys-mapping.rst        | 220 ------------------
 Documentation/core-api/dma-api-howto.rst      |  14 --
 Documentation/core-api/index.rst              |   1 -
 .../translations/zh_CN/core-api/index.rst     |   1 -
 arch/alpha/Kconfig                            |   1 -
 arch/alpha/include/asm/floppy.h               |   2 +-
 arch/alpha/include/asm/io.h                   |   8 +-
 arch/ia64/Kconfig                             |   1 -
 arch/ia64/include/asm/io.h                    |   8 -
 arch/m68k/Kconfig                             |   1 -
 arch/m68k/include/asm/virtconvert.h           |   4 +-
 arch/microblaze/Kconfig                       |   1 -
 arch/microblaze/include/asm/io.h              |   2 -
 arch/mips/Kconfig                             |   1 -
 arch/mips/include/asm/io.h                    |   9 -
 arch/parisc/Kconfig                           |   1 -
 arch/parisc/include/asm/floppy.h              |   4 +-
 arch/parisc/include/asm/io.h                  |   2 -
 arch/powerpc/Kconfig                          |   1 -
 arch/powerpc/include/asm/io.h                 |   2 -
 arch/riscv/include/asm/page.h                 |   1 -
 arch/x86/Kconfig                              |   1 -
 arch/x86/include/asm/io.h                     |   9 -
 arch/xtensa/Kconfig                           |   1 -
 arch/xtensa/include/asm/io.h                  |   3 -
 drivers/scsi/BusLogic.c                       |  27 ++-
 drivers/scsi/Kconfig                          |   4 +-
 drivers/scsi/dpt_i2o.c                        |   4 +-
 include/asm-generic/io.h                      |  14 --
 mm/Kconfig                                    |   8 -
 30 files changed, 30 insertions(+), 326 deletions(-)
 delete mode 100644 Documentation/core-api/bus-virt-phys-mapping.rst

-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
