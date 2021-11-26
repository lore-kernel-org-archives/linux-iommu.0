Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22060C433EF
	for <iommu@archiver.kernel.org>; Fri, 26 Nov 2021 07:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEE06606BE;
	Fri, 26 Nov 2021 07:40:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yFkDcYKjaQAQ; Fri, 26 Nov 2021 07:40:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 618D96068D;
	Fri, 26 Nov 2021 07:40:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 252E9C001C;
	Fri, 26 Nov 2021 07:40:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34833C000A
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 07:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12164401E1
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 07:40:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JfebEc3acTUt for <iommu@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 07:40:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB0E9401BF
 for <iommu@lists.linux-foundation.org>; Fri, 26 Nov 2021 07:40:30 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id F195168AFE; Fri, 26 Nov 2021 08:40:22 +0100 (CET)
Date: Fri, 26 Nov 2021 08:40:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH 3/5] hyperv/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Message-ID: <20211126074022.GA23659@lst.de>
References: <20211116153923.196763-1-ltykernel@gmail.com>
 <20211116153923.196763-4-ltykernel@gmail.com> <20211117100142.GB10330@lst.de>
 <c93bf3d4-75c1-bc3d-2789-1d65e7c19158@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c93bf3d4-75c1-bc3d-2789-1d65e7c19158@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, Christoph Hellwig <hch@lst.de>,
 michael.h.kelley@microsoft.com, mingo@redhat.com, kuba@kernel.org,
 haiyangz@microsoft.com, parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 jejb@linux.ibm.com, bp@alien8.de, luto@kernel.org,
 xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, jgross@suse.com,
 martin.petersen@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com, davem@davemloft.net
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

On Wed, Nov 17, 2021 at 10:00:08PM +0800, Tianyu Lan wrote:
> On 11/17/2021 6:01 PM, Christoph Hellwig wrote:
>> This doesn't really have much to do with normal DMA mapping,
>> so why does this direct through the dma ops?
>>
>
> According to the previous discussion, dma_alloc_noncontigous()
> and dma_vmap_noncontiguous() may be used to handle the noncontigous
> memory alloc/map in the netvsc driver. So add alloc/free and vmap/vunmap
> callbacks here to handle the case. The previous patch v4 & v5 handles
> the allocation and map in the netvsc driver. If this should not go though 
> dma ops, We also may make it as vmbus specific function and keep
> the function in the vmbus driver.

But that only makes sense if they can actually use the normal DMA ops.
If you implement your own incomplete ops and require to use them you
do nothing but adding indirect calls to your fast path and making the
code convoluted.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
