Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45D2C43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 14:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DF4B41A4C;
	Wed, 29 Jun 2022 14:09:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DF4B41A4C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PmT2nEDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id If2Wi6CT26Rb; Wed, 29 Jun 2022 14:09:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B2FAD41A38;
	Wed, 29 Jun 2022 14:09:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B2FAD41A38
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71129C0032;
	Wed, 29 Jun 2022 14:09:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13074C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 14:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1550E612F7
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 14:09:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1550E612F7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PmT2nEDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pmPPufS8_-Jm for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 14:09:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 417AE612ED
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 417AE612ED
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=vIUxXrfRpQPd8e40gcqC8UVMd7+p4lDNzJaouIvbYRY=; b=PmT2nEDFXm3So1eVE1/jDd8HHf
 SBr1ovtXhZNGhEX3cO3TljW/uC3u7F2rVs/Q4lNzxuv3f2n6g63cbtVdF0FT4qPSnkzoYtlB4fTqg
 EzgiixJE9MccFEPbvyjXv1iPzdKnUgK50Uh2pYgItsyr1gRT7Ue5MgiX6FI8/PsxwMCofGp1Gv2xv
 lSGsyL4aeAa83SX+OfZRPpp0ETDDXkwXHMXa+p9rRAL+eB2mAF1kh4M20vJFDw0uJiUGtaetgqJdt
 CgxAToCea/ywbU4/orOn0Q84PEghm6gYSuqpJC1Hr51fgxajTItnSpV6Ky3dp12IMeAp3BJPkP/qK
 aBg/2ENA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o6YNU-00CPbk-1y; Wed, 29 Jun 2022 14:09:12 +0000
Date: Wed, 29 Jun 2022 07:09:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [PATCH 1/2] swiotlb: Split up single swiotlb lock
Message-ID: <YrxdCHRTRS62pAON@infradead.org>
References: <20220627153150.106995-1-ltykernel@gmail.com>
 <20220627153150.106995-2-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220627153150.106995-2-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hyperv@vger.kernel.org, rafael@kernel.org,
 dave.hansen@linux.intel.com, pavel@ucw.cz, hpa@zytor.com, kys@microsoft.com,
 hch@infradead.org, wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>,
 corbet@lwn.net, damien.lemoal@opensource.wdc.com, x86@kernel.org,
 michael.h.kelley@microsoft.com, mingo@redhat.com, andi.kleen@intel.com,
 parri.andrea@gmail.com, len.brown@intel.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, keescook@chromium.org,
 paulmck@kernel.org, linux-pm@vger.kernel.org, kirill.shutemov@intel.com,
 bp@alien8.de, songmuchun@bytedance.com, tglx@linutronix.de,
 vkuznets@redhat.com, rdunlap@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thomas.lendacky@amd.com, akpm@linux-foundation.org, robin.murphy@arm.com
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

On Mon, Jun 27, 2022 at 11:31:49AM -0400, Tianyu Lan wrote:
> +/**
> + * struct io_tlb_area - IO TLB memory area descriptor
> + *
> + * This is a single area with a single lock.
> + *
> + * @used:	The number of used IO TLB block.
> + * @index:	The slot index to start searching in this area for next round.
> + * @lock:	The lock to protect the above data structures in the map and
> + *		unmap calls.
> + */
> +struct io_tlb_area {
> +	unsigned long used;
> +	unsigned int index;
> +	spinlock_t lock;
> +};

As already mentioned last time, please move this into swiotlb.c,
swiotlb.h only uses a pointer to this structure.

>  static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
> -		unsigned long nslabs, unsigned int flags, bool late_alloc)
> +				    unsigned long nslabs, unsigned int flags,
> +				    bool late_alloc, unsigned int nareas)

Nit: the two tab indentation for prototype continuations is a lot easier
to maintain, so don't graciously switch away from it.

> +			alloc_size - (offset + ((i - slot_index) << IO_TLB_SHIFT));

Overly long line here.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
