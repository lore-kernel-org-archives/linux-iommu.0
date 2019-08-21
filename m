Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37788C3A59E
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 16:02:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC94E22CF7
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 16:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC94E22CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A38B0EF7;
	Wed, 21 Aug 2019 16:02:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BF126EEC
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 16:02:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 2B5D2E6
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 16:02:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDC1D337;
	Wed, 21 Aug 2019 09:02:02 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 911053F718;
	Wed, 21 Aug 2019 09:02:00 -0700 (PDT)
Subject: Re: [PATCH 07/13] iommu/io-pgtable: Introduce tlb_flush_walk() and
	tlb_flush_leaf()
To: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
References: <20190814175634.21081-1-will@kernel.org>
	<20190814175634.21081-8-will@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <82c26b98-9521-1e2f-5322-d47da82dd868@arm.com>
Date: Wed, 21 Aug 2019 17:01:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190814175634.21081-8-will@kernel.org>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vijay Kilary <vkilari@codeaurora.org>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 14/08/2019 18:56, Will Deacon wrote:
> In preparation for deferring TLB flushes to iommu_tlb_sync(), introduce
> two new synchronous invalidation helpers to the io-pgtable API, which
> allow the unmap() code to force invalidation in cases where it cannot be
> deferred (e.g. when replacing a table with a block or when TLBI_ON_MAP
> is set).

FWIW we should actually be able to support deferred invalidation for 
TLBI_ON_MAP now that iommu_ops::iotlb_sync_map is a thing, but that can 
be a future enhancement if anyone's sufficiently motivated.

Robin.

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   include/linux/io-pgtable.h | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 6292ea15d674..27275575b305 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -19,17 +19,31 @@ enum io_pgtable_fmt {
>   /**
>    * struct iommu_flush_ops - IOMMU callbacks for TLB and page table management.
>    *
> - * @tlb_flush_all: Synchronously invalidate the entire TLB context.
> - * @tlb_add_flush: Queue up a TLB invalidation for a virtual address range.
> - * @tlb_sync:      Ensure any queued TLB invalidation has taken effect, and
> - *                 any corresponding page table updates are visible to the
> - *                 IOMMU.
> + * @tlb_flush_all:  Synchronously invalidate the entire TLB context.
> + * @tlb_flush_walk: Synchronously invalidate all intermediate TLB state
> + *                  (sometimes referred to as the "walk cache") for a virtual
> + *                  address range.
> + * @tlb_flush_leaf: Synchronously invalidate all leaf TLB state for a virtual
> + *                  address range.
> + * @tlb_add_flush:  Optional callback to queue up leaf TLB invalidation for a
> + *                  virtual address range.  This function exists purely as an
> + *                  optimisation for IOMMUs that cannot batch TLB invalidation
> + *                  operations efficiently and are therefore better suited to
> + *                  issuing them early rather than deferring them until
> + *                  iommu_tlb_sync().
> + * @tlb_sync:       Ensure any queued TLB invalidation has taken effect, and
> + *                  any corresponding page table updates are visible to the
> + *                  IOMMU.
>    *
>    * Note that these can all be called in atomic context and must therefore
>    * not block.
>    */
>   struct iommu_flush_ops {
>   	void (*tlb_flush_all)(void *cookie);
> +	void (*tlb_flush_walk)(unsigned long iova, size_t size, size_t granule,
> +			       void *cookie);
> +	void (*tlb_flush_leaf)(unsigned long iova, size_t size, size_t granule,
> +			       void *cookie);
>   	void (*tlb_add_flush)(unsigned long iova, size_t size, size_t granule,
>   			      bool leaf, void *cookie);
>   	void (*tlb_sync)(void *cookie);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
