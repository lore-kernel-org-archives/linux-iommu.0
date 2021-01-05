Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84512C433E0
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 19:04:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154EF22D58
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 19:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154EF22D58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B20E08725C;
	Tue,  5 Jan 2021 19:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yoL6pXl-XrZ3; Tue,  5 Jan 2021 19:04:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03C44871D9;
	Tue,  5 Jan 2021 19:04:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB3AFC088B;
	Tue,  5 Jan 2021 19:04:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11ABEC013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 19:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F042685F37
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 19:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KdiuhFJRXsUC for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 19:04:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 647EE85E13
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 19:04:03 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96F7322D04;
 Tue,  5 Jan 2021 19:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609873443;
 bh=y0kYfN+LrAWhyyR25aSsaoJEkY35C1Yxkk8M7N/E2J4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KvR75V8aW0d0ciN0smmFj7XNGclzJY1D0fCdUoBbFP3bv698eiuihjO6DssKLyqo1
 kYOq+e+47GaI40L7VXDgoPkPuHoj3ZX4YyoL6aHLvrDnGWmvLwOCdfM9zXpo1K2kXV
 dee8BFxFjsocF9h5r4v8pCwqTRDcpmFGl9SGXS7FyuScE71WXHux89tUxs83MJMK+/
 QjOAIWQVmWRyQKQJpwKd29WwFgbgFMdLIvNZvYK/l9Zc6xuBNa31aT/aCvD1dt+MaH
 vgoxkSv91SzuBdpk3MxebNk8vQPGx1ONrqxgWs9hmxRJwsJZ4wnCK9awCDSMyooSN/
 m32xt5SMBPR5A==
Date: Tue, 5 Jan 2021 19:03:58 +0000
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/5] iommu/vt-d: Fix unaligned addresses for
 intel_flush_svm_range_dev()
Message-ID: <20210105190357.GA12182@willie-the-truck>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201231005323.2178523-2-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Kaijie <Kaijie.Guo@intel.com>
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

On Thu, Dec 31, 2020 at 08:53:20AM +0800, Lu Baolu wrote:
> The VT-d hardware will ignore those Addr bits which have been masked by
> the AM field in the PASID-based-IOTLB invalidation descriptor. As the
> result, if the starting address in the descriptor is not aligned with
> the address mask, some IOTLB caches might not invalidate. Hence people
> will see below errors.
> 
> [ 1093.704661] dmar_fault: 29 callbacks suppressed
> [ 1093.704664] DMAR: DRHD: handling fault status reg 3
> [ 1093.712738] DMAR: [DMA Read] Request device [7a:02.0] PASID 2
>                fault addr 7f81c968d000 [fault reason 113]
>                SM: Present bit in first-level paging entry is clear
> 
> Fix this by using aligned address for PASID-based-IOTLB invalidation.
> 
> Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
> Reported-and-tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 69566695d032..b16a4791acfb 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -118,8 +118,10 @@ void intel_svm_check(struct intel_iommu *iommu)
>  	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
>  }
>  
> -static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_dev *sdev,
> -				unsigned long address, unsigned long pages, int ih)
> +static void __flush_svm_range_dev(struct intel_svm *svm,
> +				  struct intel_svm_dev *sdev,
> +				  unsigned long address,
> +				  unsigned long pages, int ih)
>  {
>  	struct qi_desc desc;
>  
> @@ -170,6 +172,22 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
>  	}
>  }
>  
> +static void intel_flush_svm_range_dev(struct intel_svm *svm,
> +				      struct intel_svm_dev *sdev,
> +				      unsigned long address,
> +				      unsigned long pages, int ih)
> +{
> +	unsigned long shift = ilog2(__roundup_pow_of_two(pages));
> +	unsigned long align = (1ULL << (VTD_PAGE_SHIFT + shift));
> +	unsigned long start = ALIGN_DOWN(address, align);
> +	unsigned long end = ALIGN(address + (pages << VTD_PAGE_SHIFT), align);
> +
> +	while (start < end) {
> +		__flush_svm_range_dev(svm, sdev, start, align >> VTD_PAGE_SHIFT, ih);
> +		start += align;
> +	}
> +}

Given that this only seems to be called from intel_invalidate_range(), which
has to compute 'pages' only to have it pulled apart again here, perhaps it
would be cleaner for intel_flush_svm_range() to take something like an
'order' argument instead?

What do you think?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
