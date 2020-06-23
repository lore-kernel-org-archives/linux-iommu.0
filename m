Return-Path: <SRS0=bNYQ=AE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75836C433DF
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 07:09:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208CC20738
	for <iommu@archiver.kernel.org>; Tue, 23 Jun 2020 07:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWgMqyKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208CC20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F17D9894F2;
	Tue, 23 Jun 2020 07:09:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ki4jekCGsCcj; Tue, 23 Jun 2020 07:09:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C4BC894F0;
	Tue, 23 Jun 2020 07:09:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42A50C08A2;
	Tue, 23 Jun 2020 07:09:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F9BDC016F
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 07:09:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 268702D61E
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 07:09:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vWLUJbRosnBH for <iommu@lists.linux-foundation.org>;
 Tue, 23 Jun 2020 07:09:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 102792035D
 for <iommu@lists.linux-foundation.org>; Tue, 23 Jun 2020 07:09:17 +0000 (UTC)
Received: from mail.kernel.org (unknown [95.90.213.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7EB142083B;
 Tue, 23 Jun 2020 07:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592896156;
 bh=DtczuADBn02KNsKn1zVUGW/fHxjVGsLwEaVwTv2OO34=;
 h=From:To:Cc:Subject:Date:From;
 b=KWgMqyKu9lNxDusflmUU8a73weNV3oAx3KrcZnO4Y/lhfevMn1bMNCpUhSxBeEyyz
 pcn/hN/y/PImTIDe4xsgCUs6ENSQ7w680agTfK7sz218NqZd4wR1zbXl+csUuAuOTY
 COVy/oxbMdnsaSGsHyNVCdTR4ngUEXje5YAadfc4=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
 (envelope-from <mchehab@kernel.org>)
 id 1jnd3Q-003qib-Tq; Tue, 23 Jun 2020 09:09:12 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: [PATCH v2 00/15] Documentation fixes
Date: Tue, 23 Jun 2020 09:08:56 +0200
Message-Id: <cover.1592895969.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: linux-ia64@vger.kernel.org,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-mm@kvack.org, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Sandipan Das <sandipan@linux.ibm.com>,
 linux-kselftest@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Jan Kara <jack@suse.cz>, Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
 Shuah Khan <shuah@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Will Deacon <will@kernel.org>, Helge Deller <deller@gmx.de>, x86@kernel.org,
 Haren Myneni <haren@linux.ibm.com>, Russell King <linux@armlinux.org.uk>,
 kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-pci@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 linux-media@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Borislav Petkov <bp@alien8.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
 Dave Hansen <dave.hansen@intel.com>, Alexey Gladkov <gladkov.alexey@gmail.com>,
 Akira Shimahara <akira215corp@gmail.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 Mike Kravetz <mike.kravetz@oracle.com>
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

Hi Jon,

As requested, this is a rebase of a previous series posted on Jan, 15.

Since then, several patches got merged via other trees or became
obsolete. There were also 2 patches before that fits better at the
ReST conversion patchset. So, I'll be sending it on another patch
series together with the remaining ReST conversions.

I also added reviews/acks received.

So, the series reduced from 29 to 15 patches.

Let's hope b4 would be able to properly handle this one.

Regards,
Mauro

Mauro Carvalho Chehab (15):
  mm: vmalloc.c: remove a kernel-doc annotation from a removed parameter
  net: dev: add a missing kernel-doc annotation
  net: netdevice.h: add a description for napi_defer_hard_irqs
  scripts/kernel-doc: parse __ETHTOOL_DECLARE_LINK_MODE_MASK
  net: pylink.h: add kernel-doc descriptions for new fields at
    phylink_config
  scripts/kernel-doc: handle function pointer prototypes
  fs: fs.h: fix a kernel-doc parameter description
  kcsan: fix a kernel-doc warning
  selftests/vm/keys: fix a broken reference at protection_keys.c
  docs: hugetlbpage.rst: fix some warnings
  docs: powerpc: fix some issues at vas-api.rst
  docs: driver-model: remove a duplicated markup at driver.rst
  docs: ABI: fix a typo when pointing to w1-generic.rst
  docs: fix references for DMA*.txt files
  docs: fs: proc.rst: convert a new chapter to ReST

 .../ABI/testing/sysfs-driver-w1_therm         |  2 +-
 Documentation/PCI/pci.rst                     |  6 +--
 Documentation/admin-guide/mm/hugetlbpage.rst  | 23 +++++++---
 Documentation/block/biodoc.rst                |  2 +-
 Documentation/bus-virt-phys-mapping.txt       |  2 +-
 Documentation/core-api/dma-api.rst            |  6 +--
 Documentation/core-api/dma-isa-lpc.rst        |  2 +-
 .../driver-api/driver-model/driver.rst        |  2 -
 Documentation/driver-api/usb/dma.rst          |  6 +--
 Documentation/filesystems/proc.rst            | 44 +++++++++----------
 Documentation/powerpc/vas-api.rst             | 23 +++++++---
 .../translations/ko_KR/memory-barriers.txt    |  6 +--
 arch/ia64/hp/common/sba_iommu.c               | 12 ++---
 arch/parisc/kernel/pci-dma.c                  |  2 +-
 arch/x86/include/asm/dma-mapping.h            |  4 +-
 arch/x86/kernel/amd_gart_64.c                 |  2 +-
 drivers/parisc/sba_iommu.c                    | 14 +++---
 include/linux/dma-mapping.h                   |  2 +-
 include/linux/fs.h                            |  2 +-
 include/linux/kcsan-checks.h                  | 10 +++--
 include/linux/netdevice.h                     |  2 +
 include/linux/phylink.h                       |  4 ++
 include/media/videobuf-dma-sg.h               |  2 +-
 kernel/dma/debug.c                            |  2 +-
 mm/vmalloc.c                                  |  1 -
 net/core/dev.c                                |  1 +
 scripts/kernel-doc                            |  7 +++
 tools/testing/selftests/vm/protection_keys.c  |  2 +-
 28 files changed, 114 insertions(+), 79 deletions(-)

-- 
2.26.2


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
