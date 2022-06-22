Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0967C43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 10:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5168C8454C;
	Wed, 22 Jun 2022 10:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5168C8454C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JyZxBr61
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1WrFGMUBx0nY; Wed, 22 Jun 2022 10:54:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 15388844E9;
	Wed, 22 Jun 2022 10:54:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15388844E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED12FC0039;
	Wed, 22 Jun 2022 10:54:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B140FC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 10:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D8D361290
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 10:54:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D8D361290
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JyZxBr61
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DCk-F_p5Nyy8 for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 10:54:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2F6861060
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2F6861060
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 10:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=h6Ni4JY3NSS01Nb6TQNOQZ0HSFRdoJBUQ6dpTFFJhdY=; b=JyZxBr61+7LNv2xOpLLWy09ECs
 vXy9cu8Ppj0Kz441rbC9FXoY/AYGrnLU8edkf3+09otEtbWkxjeQdtMWfeGTao48tTp/skcnsCPhv
 YE/YhvZycdAO7sdt3v1ZmKoDyW1MLxzIhQDMzh5PcHLQlKdrTetEBnHoTfeDyAdysxXKji2UTfiOE
 uniVcOW8H52tnK/dOCU740qNa3JpbRpT0tQkKke9pJ5vlscSN3X7P+IWYvKH1ZCutvs0LYIHWz4ve
 W3eEO9m8exFyOPu6rLAGqVCJrSLKJLGAGDrFdsdANidX80xJ8bgIYFLIje0mLfJ/uJDSyq4y0r+he
 hMuBFJ3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o3y03-00A1BF-EA; Wed, 22 Jun 2022 10:54:19 +0000
Date: Wed, 22 Jun 2022 03:54:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tianyu Lan <ltykernel@gmail.com>
Subject: Re: [RFC PATCH V4 1/1] swiotlb: Split up single swiotlb lock
Message-ID: <YrL02y/fYxDkDRlA@infradead.org>
References: <20220617144741.921308-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220617144741.921308-1-ltykernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org, kys@microsoft.com,
 hch@infradead.org, wei.liu@kernel.org, Andi Kleen <ak@linux.intel.com>,
 corbet@lwn.net, damien.lemoal@opensource.wdc.com,
 michael.h.kelley@microsoft.com, andi.kleen@intel.com, bp@suse.de,
 parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, paulmck@kernel.org,
 kirill.shutemov@intel.com, songmuchun@bytedance.com, tglx@linutronix.de,
 akpm@linux-foundation.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, robin.murphy@arm.com
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

Thanks,

this looks pretty good to me.  A few comments below:

On Fri, Jun 17, 2022 at 10:47:41AM -0400, Tianyu Lan wrote:
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

This can go into swiotlb.c.

> +void __init swiotlb_adjust_nareas(unsigned int nareas);

And this should be marked static.

> +#define DEFAULT_NUM_AREAS 1

I'd drop this define, the magic 1 and a > 1 comparism seems to
convey how it is used much better as the checks aren't about default
or not, but about larger than one.

I also think that we want some good way to size the default, e.g.
by number of CPUs or memory size.

> +void __init swiotlb_adjust_nareas(unsigned int nareas)
> +{
> +	if (!is_power_of_2(nareas)) {
> +		pr_err("swiotlb: Invalid areas parameter %d.\n", nareas);
> +		return;
> +	}
> +
> +	default_nareas = nareas;
> +
> +	pr_info("area num %d.\n", nareas);
> +	/* Round up number of slabs to the next power of 2.
> +	 * The last area is going be smaller than the rest if
> +	 * default_nslabs is not power of two.
> +	 */

Please follow the normal kernel comment style with a /* on its own line.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
