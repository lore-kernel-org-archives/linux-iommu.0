Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5506EC433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 10:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E5C8140482;
	Thu, 24 Feb 2022 10:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JYhgHHUX1UVJ; Thu, 24 Feb 2022 10:17:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E3F9400EA;
	Thu, 24 Feb 2022 10:17:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36916C001A;
	Thu, 24 Feb 2022 10:17:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81465C0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 10:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6E25260B2D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 10:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y57MzPPhGHRl for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 10:17:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id A22EF60AC0
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 10:17:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E30E4ED1;
 Thu, 24 Feb 2022 02:17:01 -0800 (PST)
Received: from [10.163.48.178] (unknown [10.163.48.178])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E609A3F70D;
 Thu, 24 Feb 2022 02:16:54 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 10/11] swiotlb: merge swiotlb-xen initialization into
 swiotlb
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20220222153514.593231-1-hch@lst.de>
 <20220222153514.593231-11-hch@lst.de>
Message-ID: <e5564871-694e-58ea-a355-5d0c3ce5d025@arm.com>
Date: Thu, 24 Feb 2022 15:46:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220222153514.593231-11-hch@lst.de>
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
> Allow to pass a remap argument to the swiotlb initialization functions
> to handle the Xen/x86 remap case.  ARM/ARM64 never did any remapping
> from xen_swiotlb_fixup, so we don't even need that quirk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/xen/mm.c               |  23 +++---
>  arch/x86/include/asm/xen/page.h |   5 --
>  arch/x86/kernel/pci-dma.c       |  27 ++++---
>  arch/x86/pci/sta2x11-fixup.c    |   2 +-
>  drivers/xen/swiotlb-xen.c       | 128 +-------------------------------
>  include/linux/swiotlb.h         |   7 +-
>  include/xen/arm/page.h          |   1 -
>  include/xen/swiotlb-xen.h       |   8 +-
>  kernel/dma/swiotlb.c            | 120 +++++++++++++++---------------
>  9 files changed, 102 insertions(+), 219 deletions(-)

checkpatch.pl has some warnings here.

ERROR: trailing whitespace
#151: FILE: arch/x86/kernel/pci-dma.c:217:
+ $

WARNING: please, no spaces at the start of a line
#151: FILE: arch/x86/kernel/pci-dma.c:217:
+ $

total: 1 errors, 1 warnings, 470 lines checked
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
