Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5CDC433FE
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 10:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A00160B2D;
	Thu, 24 Feb 2022 10:19:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZYl3qv_TVyvB; Thu, 24 Feb 2022 10:19:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E9FB760034;
	Thu, 24 Feb 2022 10:19:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4F06C001A;
	Thu, 24 Feb 2022 10:19:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07BEDC0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 10:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D560D60AC0
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 10:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bgt3Fci6RH8C for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 10:19:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1EF1960034
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 10:19:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44D891476;
 Thu, 24 Feb 2022 02:19:03 -0800 (PST)
Received: from [10.163.48.178] (unknown [10.163.48.178])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAE743F70D;
 Thu, 24 Feb 2022 02:18:56 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 07/11] x86: remove the IOMMU table infrastructure
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20220222153514.593231-1-hch@lst.de>
 <20220222153514.593231-8-hch@lst.de>
Message-ID: <ff355270-b389-0f7a-e384-7c8a9ed9c615@arm.com>
Date: Thu, 24 Feb 2022 15:48:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220222153514.593231-8-hch@lst.de>
Content-Language: en-US
Cc: Juergen Gross <jgross@suse.com>, linux-s390@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 linux-ia64@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 x86@kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tboot-devel@lists.sourceforge.net, linux-pci@vger.kernel.org,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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


On 2/22/22 9:05 PM, Christoph Hellwig wrote:
> The IOMMU table tries to separate the different IOMMUs into different
> backends, but actually requires various cross calls.
> 
> Rewrite the code to do the generic swiotlb/swiotlb-xen setup directly
> in pci-dma.c and then just call into the IOMMU drivers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/ia64/include/asm/iommu_table.h    |   7 --
>  arch/x86/include/asm/dma-mapping.h     |   1 -
>  arch/x86/include/asm/gart.h            |   5 +-
>  arch/x86/include/asm/iommu.h           |   6 ++
>  arch/x86/include/asm/iommu_table.h     | 102 ----------------------
>  arch/x86/include/asm/swiotlb.h         |  30 -------
>  arch/x86/include/asm/xen/swiotlb-xen.h |   2 -
>  arch/x86/kernel/Makefile               |   2 -
>  arch/x86/kernel/amd_gart_64.c          |   5 +-
>  arch/x86/kernel/aperture_64.c          |  14 ++--
>  arch/x86/kernel/pci-dma.c              | 112 ++++++++++++++++++++-----
>  arch/x86/kernel/pci-iommu_table.c      |  77 -----------------
>  arch/x86/kernel/pci-swiotlb.c          |  77 -----------------
>  arch/x86/kernel/tboot.c                |   1 -
>  arch/x86/kernel/vmlinux.lds.S          |  12 ---
>  arch/x86/xen/Makefile                  |   2 -
>  arch/x86/xen/pci-swiotlb-xen.c         |  96 ---------------------
>  drivers/iommu/amd/init.c               |   6 --
>  drivers/iommu/amd/iommu.c              |   5 +-
>  drivers/iommu/intel/dmar.c             |   6 +-
>  include/linux/dmar.h                   |   6 +-
>  21 files changed, 115 insertions(+), 459 deletions(-)
>  delete mode 100644 arch/ia64/include/asm/iommu_table.h
>  delete mode 100644 arch/x86/include/asm/iommu_table.h
>  delete mode 100644 arch/x86/include/asm/swiotlb.h
>  delete mode 100644 arch/x86/kernel/pci-iommu_table.c
>  delete mode 100644 arch/x86/kernel/pci-swiotlb.c
>  delete mode 100644 arch/x86/xen/pci-swiotlb-xen.c

checkpatch.pl has some warnings here.

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#44: 
deleted file mode 100644

WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
#496: FILE: arch/x86/kernel/pci-dma.c:171:
+               printk(KERN_INFO "PCI-DMA: "

WARNING: quoted string split across lines
#497: FILE: arch/x86/kernel/pci-dma.c:172:
+               printk(KERN_INFO "PCI-DMA: "
+                      "Using software bounce buffering for IO (SWIOTLB)\n");

ERROR: trailing whitespace
#881: FILE: drivers/iommu/amd/iommu.c:1837:
+^Iif (iommu_default_passthrough() || sme_me_mask) $

total: 1 errors, 3 warnings, 389 lines checked
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
