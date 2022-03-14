Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2300C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 07:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 487FE400D6;
	Mon, 14 Mar 2022 07:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kJJhs7LUWxum; Mon, 14 Mar 2022 07:31:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E6510400A6;
	Mon, 14 Mar 2022 07:31:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4DF7C001D;
	Mon, 14 Mar 2022 07:31:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4E75C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 07:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89208400BF
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 07:31:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qNy3ompc11P4 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 07:31:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A64CF400A6
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 07:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=HhGavQ6qvlf8H5F/ZlRZDjP5Hg4YmQaPJkbgnrtpMJI=; b=x1HmPcRq+EIQAGkkRG5r3Q2ccQ
 wnlPc6HT3VpJAMMRF1p4SFikzmXOQYomeT6ykxwmWCxoebP1bN2ceE+8XNvoM8N5VllZnT75DHXGC
 h4wekLHOCpTAFXijUS4GI7cBuhiIwxysA4rgf8RJTlGS2pKLIVQjT1AeGrirHMuQmzJkixPdmUiaw
 cmRW8o6cqr3klWE3JQHi+2CDOTmN7yN+qKBICbgnWeDRcK/2hY0uiepsrGceY5FvPtk+56Vn9gD0m
 a70FwFmi8fEZWw8s5/U6tP9pIaV7UquRjOae803zd4ky95pR5AVFQCHxkh5K/hYSfr0VZAdOqR1aQ
 rxPZmEfQ==;
Received: from [46.140.54.162] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTfAx-0044RD-TW; Mon, 14 Mar 2022 07:31:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: cleanup swiotlb initialization v5
Date: Mon, 14 Mar 2022 08:31:14 +0100
Message-Id: <20220314073129.1862284-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 linux-s390@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 linux-ia64@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tboot-devel@lists.sourceforge.net, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
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

Hi all,

this series tries to clean up the swiotlb initialization, including
that of swiotlb-xen.  To get there is also removes the x86 iommu table
infrastructure that massively obsfucates the initialization path.

Git tree:

    git://git.infradead.org/users/hch/misc.git swiotlb-init-cleanup

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-init-cleanup

Changes since v5:
 - split a patch into three
 - fix setting x86_swiotlb_enable for Xen
 - fix a comment about forced bounce buffering for guest memory
   encryption
 - remove the xen_initial_domain check from
   xen_create_contiguous_region

Changes since v3:
 - fix a compilation issue on some powerpc configfs
 - fix and cleanup how forced bounce buffering is enabled for
   guest memory encryption

Changes since v2:
 - make ppc_swiotlb_flags actually work again
 - also force enable swiotlb for guest encrypted memory to cater
   to hyperv which doesn't set the host encrypted memory flag

Changes since v1:
 - skip IOMMU initialization on Xen PV kernels
 - various small whitespace / typo fixes

Diffstat:
 arch/ia64/include/asm/iommu_table.h      |    7 -
 arch/x86/include/asm/iommu_table.h       |  102 ------------------
 arch/x86/include/asm/swiotlb.h           |   30 -----
 arch/x86/kernel/pci-iommu_table.c        |   77 -------------
 arch/x86/kernel/pci-swiotlb.c            |   77 -------------
 arch/x86/xen/pci-swiotlb-xen.c           |   96 -----------------
 b/arch/arm/mm/init.c                     |    6 -
 b/arch/arm/xen/mm.c                      |   26 ++--
 b/arch/arm64/mm/init.c                   |    6 -
 b/arch/ia64/mm/init.c                    |    4 
 b/arch/mips/cavium-octeon/dma-octeon.c   |   15 --
 b/arch/mips/loongson64/dma.c             |    2 
 b/arch/mips/pci/pci-octeon.c             |    2 
 b/arch/mips/sibyte/common/dma.c          |    2 
 b/arch/powerpc/include/asm/svm.h         |    4 
 b/arch/powerpc/include/asm/swiotlb.h     |    1 
 b/arch/powerpc/kernel/dma-swiotlb.c      |    1 
 b/arch/powerpc/mm/mem.c                  |    6 -
 b/arch/powerpc/platforms/pseries/setup.c |    3 
 b/arch/powerpc/platforms/pseries/svm.c   |   26 ----
 b/arch/riscv/mm/init.c                   |    8 -
 b/arch/s390/mm/init.c                    |    3 
 b/arch/x86/include/asm/dma-mapping.h     |   12 --
 b/arch/x86/include/asm/gart.h            |    5 
 b/arch/x86/include/asm/iommu.h           |    8 +
 b/arch/x86/include/asm/xen/page.h        |    5 
 b/arch/x86/include/asm/xen/swiotlb-xen.h |    2 
 b/arch/x86/kernel/Makefile               |    2 
 b/arch/x86/kernel/amd_gart_64.c          |    5 
 b/arch/x86/kernel/aperture_64.c          |   14 --
 b/arch/x86/kernel/cpu/mshyperv.c         |    8 -
 b/arch/x86/kernel/pci-dma.c              |  113 ++++++++++++++++----
 b/arch/x86/kernel/tboot.c                |    1 
 b/arch/x86/kernel/vmlinux.lds.S          |   12 --
 b/arch/x86/mm/mem_encrypt_amd.c          |    3 
 b/arch/x86/pci/sta2x11-fixup.c           |    2 
 b/arch/x86/xen/Makefile                  |    2 
 b/drivers/iommu/amd/init.c               |    6 -
 b/drivers/iommu/amd/iommu.c              |    5 
 b/drivers/iommu/intel/dmar.c             |    6 -
 b/drivers/xen/swiotlb-xen.c              |  132 -----------------------
 b/include/linux/dmar.h                   |    6 -
 b/include/linux/swiotlb.h                |   22 +--
 b/include/trace/events/swiotlb.h         |   29 +----
 b/include/xen/arm/page.h                 |    1 
 b/include/xen/swiotlb-xen.h              |    8 +
 b/kernel/dma/direct.h                    |    2 
 b/kernel/dma/swiotlb.c                   |  175 +++++++++++++++----------------
 48 files changed, 264 insertions(+), 826 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
