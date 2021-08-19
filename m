Return-Path: <SRS0=qbNH=NK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6BBC4320A
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 08:50:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34D16113C
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 08:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D34D16113C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A05E9607A1;
	Thu, 19 Aug 2021 08:50:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fJDhVjYqcMwn; Thu, 19 Aug 2021 08:50:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A78360BC5;
	Thu, 19 Aug 2021 08:50:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E2AAC001A;
	Thu, 19 Aug 2021 08:50:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A765CC000E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 08:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81B07404CA
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 08:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kzdi9KqW46kr for <iommu@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 08:49:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56EA34025D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 08:49:58 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9B4F767357; Thu, 19 Aug 2021 10:49:51 +0200 (CEST)
Date: Thu, 19 Aug 2021 10:49:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH V3 10/13] x86/Swiotlb: Add Swiotlb bounce buffer remap
 function for HV IVM
Message-ID: <20210819084951.GA10461@lst.de>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-11-ltykernel@gmail.com>
 <20210812122741.GC19050@lst.de>
 <d18ae061-6fc2-e69e-fc2c-2e1a1114c4b4@gmail.com>
 <890e5e21-714a-2db6-f68a-6211a69bebb9@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <890e5e21-714a-2db6-f68a-6211a69bebb9@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, vkuznets@redhat.com,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, tglx@linutronix.de,
 linux-arch@vger.kernel.org, sfr@canb.auug.org.au, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, Christoph Hellwig <hch@lst.de>,
 michael.h.kelley@microsoft.com, mingo@redhat.com, pgonda@google.com,
 rientjes@google.com, kuba@kernel.org, jejb@linux.ibm.com,
 martin.b.radev@gmail.com, thomas.lendacky@amd.com, Tianyu.Lan@microsoft.com,
 arnd@arndb.de, konrad.wilk@oracle.com, haiyangz@microsoft.com, bp@alien8.de,
 luto@kernel.org, krish.sadhukhan@oracle.com, boris.ostrovsky@oracle.com,
 akpm@linux-foundation.org, jgross@suse.com, martin.petersen@oracle.com,
 saravanand@fb.com, netdev@vger.kernel.org, dave.hansen@intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 rppt@kernel.org, hannes@cmpxchg.org, tj@kernel.org, ardb@kernel.org,
 robin.murphy@arm.com, davem@davemloft.net, kirill.shutemov@linux.intel.com
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

On Mon, Aug 16, 2021 at 10:50:26PM +0800, Tianyu Lan wrote:
> Hi Christoph:
>       Sorry to bother you.Please double check with these two patches
> " [PATCH V3 10/13] x86/Swiotlb: Add Swiotlb bounce buffer remap function 
> for HV IVM" and "[PATCH V3 09/13] DMA: Add dma_map_decrypted/dma_
> unmap_encrypted() function".

Do you have a git tree somewhere to look at the whole tree?

>       The swiotlb bounce buffer in the isolation VM are allocated in the
> low end memory and these memory has struct page backing. All dma address
> returned by swiotlb/DMA API are low end memory and this is as same as what 
> happen in the traditional VM.

Indeed.

>       The API dma_map_decrypted() introduced in the patch 9 is to map the 
> bounce buffer in the extra space and these memory in the low end space are 
> used as DMA memory in the driver. Do you prefer these APIs
> still in the set_memory.c? I move the API to dma/mapping.c due to the
> suggested name arch_dma_map_decrypted() in the previous mail
> (https://lore.kernel.org/netdev/20210720135437.GA13554@lst.de/).

Well, what would help is a clear description of the semantics.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
