Return-Path: <SRS0=YF8t=OU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A62C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 18:50:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B736C61209
	for <iommu@archiver.kernel.org>; Thu, 30 Sep 2021 18:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B736C61209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81DD96067E;
	Thu, 30 Sep 2021 18:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2IH6JFxjHkBG; Thu, 30 Sep 2021 18:50:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 40A4060602;
	Thu, 30 Sep 2021 18:50:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2597CC000F;
	Thu, 30 Sep 2021 18:50:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF062C000D
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 18:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4E7560625
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 18:50:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lfePWXY7rUWR for <iommu@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 18:50:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 71F1060602
 for <iommu@lists.linux-foundation.org>; Thu, 30 Sep 2021 18:50:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8244C61216;
 Thu, 30 Sep 2021 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633027842;
 bh=sHuklxRhVNrOUIGACjRjjFQjjWujtmMEebA4SOO7XVI=;
 h=From:To:Cc:Subject:Date:From;
 b=uHnQO7KnOuN+F6Kg/VYMCkYNZKP/FQuRQKsHlQ02RSvOU+Lsr6a/Ejf3NJuypnQ0r
 wgcHaC0oqgL3wh/+Bjpr7enKokEpGkilkhAcBEHhE9uLRLhpb0YgHbs+X+j4bqDpV7
 0AkfKl3RUdJBxJT+ECt+6aVhpjwQ315nbX0A7Nb4a9ZuqQ7VSnVENanCiGErOWceKw
 TlOjeEhAK0IhpTcaKezOnHkaHC7hBR/4sk1qUNqqo7JqlIbR9UE+BEQUtaXKIMytSU
 2kYuIhxuTpWdfCtUUQdGYdGcDoSXL5vM5e4zMX86OIlLp0nscaVxPuacUtXLN3LJw1
 +kT+1vHV0j00g==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] memblock: cleanup memblock_free interface
Date: Thu, 30 Sep 2021 21:50:25 +0300
Message-Id: <20210930185031.18648-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mm@kvack.org, kasan-dev@googlegroups.com, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Mike Rapoport <rppt@linux.ibm.com>, xen-devel@lists.xenproject.org,
 linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org,
 linux-um@lists.infradead.org, Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>
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

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

Following the discussion on [1] this is the fix for memblock freeing APIs
mismatch. 

The first patch is a cleanup of numa_distance allocation in arch_numa I've
spotted during the conversion.
The second patch is a fix for Xen memory freeing on some of the error
paths.

I agree with Christophe that doing step by step makes the thing easier to
review, so the patches 3-6 do the actual cleanup step by step.

This time I used stricter coccinelle scripts so that only straightforward
uses would get converted.

There still a couple of (void *) castings for the cases when a virtual
address has unsigned long type rather than a pointer type, like e.g
initrd_start.

Since scripts/get_maintainer.pl returned more than 100 addresses I've
trimmed the distribution list only to the relevant lists.

Juergen and Shahab, I didn't keep your Reviewed-by because the patches are
a bit different this time.

v2:
* split changes into several patches
* use stricter coccinelle scripts 

[1] https://lore.kernel.org/all/CAHk-=wj9k4LZTz+svCxLYs5Y1=+yKrbAUArH1+ghyG3OLd8VVg@mail.gmail.com

Mike Rapoport (6):
  arch_numa: simplify numa_distance allocation
  xen/x86: free_p2m_page: use memblock_free_ptr() to free a virtual pointer
  memblock: drop memblock_free_early_nid() and memblock_free_early()
  memblock: stop aliasing __memblock_free_late with memblock_free_late
  memblock: rename memblock_free to memblock_phys_free
  memblock: use memblock_free for freeing virtual pointers

 arch/alpha/kernel/core_irongate.c         |  2 +-
 arch/arc/mm/init.c                        |  2 +-
 arch/arm/mach-hisi/platmcpm.c             |  2 +-
 arch/arm/mm/init.c                        |  2 +-
 arch/arm64/mm/mmu.c                       |  4 ++--
 arch/mips/mm/init.c                       |  2 +-
 arch/mips/sgi-ip30/ip30-setup.c           |  6 +++---
 arch/powerpc/kernel/dt_cpu_ftrs.c         |  4 ++--
 arch/powerpc/kernel/paca.c                |  8 ++++----
 arch/powerpc/kernel/setup-common.c        |  2 +-
 arch/powerpc/kernel/setup_64.c            |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  2 +-
 arch/powerpc/platforms/pseries/svm.c      |  3 +--
 arch/riscv/kernel/setup.c                 |  4 ++--
 arch/s390/kernel/setup.c                  |  8 ++++----
 arch/s390/kernel/smp.c                    |  4 ++--
 arch/s390/kernel/uv.c                     |  2 +-
 arch/s390/mm/kasan_init.c                 |  2 +-
 arch/sh/boards/mach-ap325rxa/setup.c      |  2 +-
 arch/sh/boards/mach-ecovec24/setup.c      |  4 ++--
 arch/sh/boards/mach-kfr2r09/setup.c       |  2 +-
 arch/sh/boards/mach-migor/setup.c         |  2 +-
 arch/sh/boards/mach-se/7724/setup.c       |  4 ++--
 arch/sparc/kernel/smp_64.c                |  2 +-
 arch/um/kernel/mem.c                      |  2 +-
 arch/x86/kernel/setup.c                   |  4 ++--
 arch/x86/kernel/setup_percpu.c            |  2 +-
 arch/x86/mm/init.c                        |  2 +-
 arch/x86/mm/kasan_init_64.c               |  4 ++--
 arch/x86/mm/numa.c                        |  2 +-
 arch/x86/mm/numa_emulation.c              |  2 +-
 arch/x86/xen/mmu_pv.c                     |  6 +++---
 arch/x86/xen/p2m.c                        |  2 +-
 arch/x86/xen/setup.c                      |  6 +++---
 drivers/base/arch_numa.c                  | 10 ++++------
 drivers/firmware/efi/memmap.c             |  2 +-
 drivers/macintosh/smu.c                   |  2 +-
 drivers/of/kexec.c                        |  3 +--
 drivers/of/of_reserved_mem.c              |  5 +++--
 drivers/s390/char/sclp_early.c            |  2 +-
 drivers/usb/early/xhci-dbc.c              | 10 +++++-----
 drivers/xen/swiotlb-xen.c                 |  2 +-
 include/linux/memblock.h                  | 23 +++--------------------
 init/initramfs.c                          |  2 +-
 init/main.c                               |  2 +-
 kernel/dma/swiotlb.c                      |  2 +-
 kernel/printk/printk.c                    |  4 ++--
 lib/bootconfig.c                          |  2 +-
 lib/cpumask.c                             |  2 +-
 mm/cma.c                                  |  2 +-
 mm/memblock.c                             | 22 +++++++++++-----------
 mm/memory_hotplug.c                       |  2 +-
 mm/percpu.c                               |  8 ++++----
 mm/sparse.c                               |  2 +-
 54 files changed, 99 insertions(+), 119 deletions(-)


base-commit: 5816b3e6577eaa676ceb00a848f0fd65fe2adc29
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
