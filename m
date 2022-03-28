Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628F1C433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 08:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDC76400E4;
	Mon, 28 Mar 2022 08:53:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hK9cMhoCW1XX; Mon, 28 Mar 2022 08:53:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A54C8400D7;
	Mon, 28 Mar 2022 08:53:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72E78C001D;
	Mon, 28 Mar 2022 08:53:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9069AC0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 08:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FC5460DB2
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 08:53:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QG5GgaBy-kTK for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 08:53:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C9A260AE6
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 08:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648457593; x=1679993593;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=KY/woiP3Ikl6M8527fLcfhM7r8Pg9Vb7dRAlz6bGG2I=;
 b=Toq2J827O79NkQco6uMmdljj2r1cwCECrTkcwuAZd4SK7Y/Tba32BE4o
 bkxGfMnokN+1CGckKgcEiwE65E+BG3DtcE4ke1GRpW9QoT8ZMHATMnVma
 FVG7mGZyIwU6Q5gG5IKI99hW8Cj9/OoHmen0QcEpRKVKPRtrInCdId8TJ
 FpXwSlsNVCNpsD6QeMNXFkl7sFdnOrZlMXm8CN1cWFoRQZSHFu8yz6fcP
 TwY5+Dkqa8azNa4YoiGRcR+JK7fRdOHPWrw8jsm12LIredslSBeJF3lma
 A/kBcQYHmxUoURKWgcm+5ULekEhy3Mrp95HHHMh3fhhHQp3JtHDMnGfCt Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="238883090"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; d="scan'208";a="238883090"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 01:53:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; d="scan'208";a="502440248"
Received: from zgao13-mobl2.ccr.corp.intel.com (HELO [10.254.210.12])
 ([10.254.210.12])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 01:53:09 -0700
Message-ID: <21bc406b-96f0-ae99-1606-9493f3cc2621@linux.intel.com>
Date: Mon, 28 Mar 2022 16:53:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: David Stevens <stevensd@chromium.org>, Kevin Tian <kevin.tian@intel.com>
References: <20220322063555.1422042-1-stevensd@google.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
In-Reply-To: <20220322063555.1422042-1-stevensd@google.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi David,

On 2022/3/22 14:35, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Calculate the appropriate mask for non-size-aligned page selective
> invalidation. Since psi uses the mask value to mask out the lower order
> bits of the target address, properly flushing the iotlb requires using a
> mask value such that [pfn, pfn+pages) all lie within the flushed
> size-aligned region.  This is not normally an issue because iova.c
> always allocates iovas that are aligned to their size. However, iovas
> which come from other sources (e.g. userspace via VFIO) may not be
> aligned.

This is bug fix, right? Can you please add "Fixes" and "Cc stable" tags?

> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
> v1 -> v2:
>   - Calculate an appropriate mask for non-size-aligned iovas instead
>     of falling back to domain selective flush.
> 
>   drivers/iommu/intel/iommu.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5b196cfe9ed2..ab2273300346 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1717,7 +1717,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   				  unsigned long pfn, unsigned int pages,
>   				  int ih, int map)
>   {
> -	unsigned int mask = ilog2(__roundup_pow_of_two(pages));
> +	unsigned int aligned_pages = __roundup_pow_of_two(pages);
> +	unsigned int mask = ilog2(aligned_pages);
>   	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
>   	u16 did = domain->iommu_did[iommu->seq_id];
>   
> @@ -1729,10 +1730,30 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   	if (domain_use_first_level(domain)) {
>   		domain_flush_piotlb(iommu, domain, addr, pages, ih);
>   	} else {
> +		unsigned long bitmask = aligned_pages - 1;
> +
> +		/*
> +		 * PSI masks the low order bits of the base address. If the
> +		 * address isn't aligned to the mask, then compute a mask value
> +		 * needed to ensure the target range is flushed.
> +		 */
> +		if (unlikely(bitmask & pfn)) {
> +			unsigned long end_pfn = pfn + pages - 1, shared_bits;
> +
> +			/*
> +			 * Since end_pfn <= pfn + bitmask, the only way bits
> +			 * higher than bitmask can differ in pfn and end_pfn is
> +			 * by carrying. This means after masking out bitmask,
> +			 * high bits starting with the first set bit in
> +			 * shared_bits are all equal in both pfn and end_pfn.
> +			 */
> +			shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
> +			mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;

Can you please add some lines in the commit message to explain how this
magic line works? It's easier for people to understand it if you can
take a real example. :-)

Best regards,
baolu

> +		}
> +
>   		/*
>   		 * Fallback to domain selective flush if no PSI support or
> -		 * the size is too big. PSI requires page size to be 2 ^ x,
> -		 * and the base address is naturally aligned to the size.
> +		 * the size is too big.
>   		 */
>   		if (!cap_pgsel_inv(iommu->cap) ||
>   		    mask > cap_max_amask_val(iommu->cap))
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
