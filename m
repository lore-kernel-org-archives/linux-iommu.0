Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B154BC433E5
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:12:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A9FD22B47
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zUj8Ky/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A9FD22B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2F7CB8780F;
	Tue, 28 Jul 2020 05:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id elTHoai-LfxV; Tue, 28 Jul 2020 05:12:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4E85386D72;
	Tue, 28 Jul 2020 05:12:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 370E9C0050;
	Tue, 28 Jul 2020 05:12:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 141CCC004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F03B7877FA
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9M8UjltHWc8z for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 05:12:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4D27786D72
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:12:14 +0000 (UTC)
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 799682070A;
 Tue, 28 Jul 2020 05:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595913133;
 bh=SiunFkOH1KIyW1NC3iO0mc1YnQ8vPMqtL902CN9Sglg=;
 h=From:To:Cc:Subject:Date:From;
 b=zUj8Ky/ISJogZYImW1cerS7gxpsJPyD/s5COPLWHq2m806d7LS+KeFmOjturCkeKD
 HrFFBTdERy4l0XPM2jQi1NdsS/0AEv/DNIDcsxWU/Hw8p6tUQjHHE7reUbZz0w1jhv
 yHsh8/Ni8CjiRR1lxOFECz5g0SlMvzBSWjQUZxXU=
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 00/15] memblock: seasonal cleaning^w cleanup
Date: Tue, 28 Jul 2020 08:11:38 +0300
Message-Id: <20200728051153.1590-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Stafford Horne <shorne@gmail.com>,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 clang-built-linux@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Christoph Hellwig <hch@lst.de>, Mike Rapoport <rppt@kernel.org>
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

These patches simplify several uses of memblock iterators and hide some of
the memblock implementation details from the rest of the system.

The patches are on top of v5.8-rc7 + cherry-pick of "mm/sparse: cleanup the
code surrounding memory_present()" [1] from mmotm tree.

[1] http://lkml.kernel.org/r/20200712083130.22919-1-rppt@kernel.org 

Mike Rapoport (15):
  KVM: PPC: Book3S HV: simplify kvm_cma_reserve()
  dma-contiguous: simplify cma_early_percent_memory()
  arm, xtensa: simplify initialization of high memory pages
  arm64: numa: simplify dummy_numa_init()
  h8300, nds32, openrisc: simplify detection of memory extents
  powerpc: fadamp: simplify fadump_reserve_crash_area()
  riscv: drop unneeded node initialization
  mircoblaze: drop unneeded NUMA and sparsemem initializations
  memblock: make for_each_memblock_type() iterator private
  memblock: make memblock_debug and related functionality private
  memblock: reduce number of parameters in for_each_mem_range()
  arch, mm: replace for_each_memblock() with for_each_mem_pfn_range()
  arch, drivers: replace for_each_membock() with for_each_mem_range()
  x86/numa: remove redundant iteration over memblock.reserved
  memblock: remove 'type' parameter from for_each_memblock()

 .clang-format                            |  1 +
 arch/arm/kernel/setup.c                  | 18 +++++---
 arch/arm/mm/init.c                       | 59 +++++-------------------
 arch/arm/mm/mmu.c                        | 39 ++++++----------
 arch/arm/mm/pmsa-v7.c                    | 20 ++++----
 arch/arm/mm/pmsa-v8.c                    | 17 ++++---
 arch/arm/xen/mm.c                        |  7 +--
 arch/arm64/kernel/machine_kexec_file.c   |  6 +--
 arch/arm64/kernel/setup.c                |  2 +-
 arch/arm64/mm/init.c                     | 11 ++---
 arch/arm64/mm/kasan_init.c               |  8 ++--
 arch/arm64/mm/mmu.c                      | 11 ++---
 arch/arm64/mm/numa.c                     | 15 +++---
 arch/c6x/kernel/setup.c                  |  9 ++--
 arch/h8300/kernel/setup.c                |  8 ++--
 arch/microblaze/mm/init.c                | 24 ++--------
 arch/mips/cavium-octeon/dma-octeon.c     | 12 ++---
 arch/mips/kernel/setup.c                 | 31 ++++++-------
 arch/mips/netlogic/xlp/setup.c           |  2 +-
 arch/nds32/kernel/setup.c                |  8 +---
 arch/openrisc/kernel/setup.c             |  9 +---
 arch/openrisc/mm/init.c                  |  8 ++--
 arch/powerpc/kernel/fadump.c             | 58 ++++++++---------------
 arch/powerpc/kvm/book3s_hv_builtin.c     | 11 +----
 arch/powerpc/mm/book3s64/hash_utils.c    | 16 +++----
 arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++---
 arch/powerpc/mm/kasan/kasan_init_32.c    |  8 ++--
 arch/powerpc/mm/mem.c                    | 33 +++++++------
 arch/powerpc/mm/numa.c                   |  7 +--
 arch/powerpc/mm/pgtable_32.c             |  8 ++--
 arch/riscv/mm/init.c                     | 33 ++++---------
 arch/riscv/mm/kasan_init.c               | 10 ++--
 arch/s390/kernel/crash_dump.c            |  8 ++--
 arch/s390/kernel/setup.c                 | 31 ++++++++-----
 arch/s390/mm/page-states.c               |  6 +--
 arch/s390/mm/vmem.c                      | 16 ++++---
 arch/sh/mm/init.c                        |  9 ++--
 arch/sparc/mm/init_64.c                  | 12 ++---
 arch/x86/mm/numa.c                       | 26 ++++-------
 arch/xtensa/mm/init.c                    | 55 ++++------------------
 drivers/bus/mvebu-mbus.c                 | 12 ++---
 drivers/s390/char/zcore.c                |  9 ++--
 include/linux/memblock.h                 | 45 +++++++++---------
 kernel/dma/contiguous.c                  | 11 +----
 mm/memblock.c                            | 28 +++++++----
 mm/page_alloc.c                          | 11 ++---
 mm/sparse.c                              | 10 ++--
 47 files changed, 324 insertions(+), 485 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
