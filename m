Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D98DC433EF
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 10:00:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27C461BD2
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 10:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C27C461BD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F9424090A;
	Wed, 17 Nov 2021 10:00:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M0JrZNKx2vkD; Wed, 17 Nov 2021 10:00:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7440E4054B;
	Wed, 17 Nov 2021 10:00:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A6C6C002E;
	Wed, 17 Nov 2021 10:00:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F029C0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 10:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 78E874092F
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 10:00:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RIdjIJ8EzBwF for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 10:00:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F8B64054B
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 10:00:01 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 863B668AFE; Wed, 17 Nov 2021 10:59:53 +0100 (CET)
Date: Wed, 17 Nov 2021 10:59:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH 1/5] x86/Swiotlb: Add Swiotlb bounce buffer remap
 function for HV IVM
Message-ID: <20211117095953.GA10330@lst.de>
References: <20211116153923.196763-1-ltykernel@gmail.com>
 <20211116153923.196763-2-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211116153923.196763-2-ltykernel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
 kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 wei.liu@kernel.org, sstabellini@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, decui@microsoft.com, hch@lst.de,
 michael.h.kelley@microsoft.com, mingo@redhat.com, kuba@kernel.org,
 haiyangz@microsoft.com, parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 jejb@linux.ibm.com, bp@alien8.de, luto@kernel.org,
 xen-devel@lists.xenproject.org, tglx@linutronix.de, jgross@suse.com,
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

The subject is wrong, nothing x86-specific here.  Please use
"swiotlb: " as the prefix

> + * @vaddr:	The vaddr of the swiotlb memory pool. The swiotlb
> + *		memory pool may be remapped in the memory encrypted case and store

Please avoid the overly long line.

> +	/*
> +	 * With swiotlb_unencrypted_base setting, swiotlb bounce buffer will
> +	 * be remapped in the swiotlb_update_mem_attributes() and return here
> +	 * directly.
> +	 */

I'd word this as:

	/*
	 * If swiotlb_unencrypted_base is set, the bounce buffer memory will
	 * be remapped and cleared in swiotlb_update_mem_attributes.
	 */
> +	ret = swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
> +	if (ret) {
> +		memblock_free(mem->slots, alloc_size);
> +		return ret;
> +	}

With the latest update swiotlb_init_io_tlb_mem will always return 0,
so no need for the return value change or error handling here.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
