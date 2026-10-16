Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C4849428E
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 18:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173929; cv=none; b=Rdw2mR+0gOc8KLJUbU0qq/xNCfJGf2qvz+LDuhRqAZt5DWPnqsr9pbf/jCMIsJlhgMg6yhm4uryMRO+Bwclv4oTmoc2PFP50oe28zIzf054TWtLBtqkEofLFWvDTLy10mZRVtjVF04mhELeyDZ+nYSkNLdCRf3Lz90nyQVJqRt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173929; c=relaxed/simple;
	bh=9/EH6Nh3IyjidhjX8ImjHAg8jsbvenySYa7Lj4rRnzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/nmxMs3/AGo04ZwfwTdsWtPeJEpiXf9og7J81w2DLRYInyFy/dWw38DIhsHESn3Mq9y88ub8WWsP0fTlmuXOmsxBFJI6JdaUz/MnvJulIUC6Do662mCfOdZbDaCiSSHVXRR3iJiFj4TKgT64a9nrqWBbXLtO02FxhyeVaDeiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AHtyY7o0; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AHtyY7o0"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93efc0452b5so16008085a.0
        for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792173923; x=1792778723; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bcPINE8kLYO7ad2h8AzZJW55DUCIX7EGWisyHohuTdg=;
        b=AHtyY7o0Zr8mAuVa3F4YpnPuZAbKFl9eGvRGn2N3JfMcsa+F96y7h/TcLnmAZb3lCR
         vknvMJqI1YmUKb3Sgwsa4LQoWdhYNJwJIyBkVMZyF96025gm9Bq0amQycGYgd2O+E1Qr
         ivkGYwslmeX03aE4MJlaWWgKm/bNjVRFffB37gvk9TSxJYptSK0SWsifDSvkH5YckFbZ
         geSW+QSfUVThbbo4dkyXTiv0/ZuZCfq/HuHutXPSTl7iwD8TPFbOOndSfm4SWaq5zllq
         wHmC93AnPUgrgWMTApBvbjXcjJa0UHE3HUZ3UywSNdJ1BjlkDJT2aFNmrwtLJvyGprh0
         dJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792173923; x=1792778723;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bcPINE8kLYO7ad2h8AzZJW55DUCIX7EGWisyHohuTdg=;
        b=ZgI6tBSlCbQhX6G+Ynwsq8189J10PcDE5s1GuHD6LGtuvBU/ubk1ykqM/vE4d5EK1s
         JBY59G0hlhReTa8Iwrn81zT+eILQyga9mdOzUr1jD32g0J7L1Pc92mMJ3eSdlvh6r01W
         rJAxt+Q876gwDItma5VczQDu7VDeMyDBKyLOsAgtTdTFfhk+js2NtMnFDDdWmzcreAQo
         WRB2gH/RyYDjXMStHxshCQpNSUWHMHZJpHw8xrYIbV/auUbq/Kvn7CWZ6bCpdpGQ4nm9
         xk3jxNI5i6OHQTeanggRYqfBGWC9DPGn/07FF+slDDjlcOTNPTDnMRO4oge3jDiLu8kn
         /jUg==
X-Gm-Message-State: AFq9FYJ1FFHy7Tb5Ha6gD69Igv/344qHCC1csFMJoLkgOQe3YvK/Stb7
	UyJIKGZRjFNM8v3Q+A4GJisbKm/8xdkxlRuoFOPLliN6TxCf2RGWr0xm57zYtHPiRX8=
X-Gm-Gg: AYBFou0O8n32eklTDL0kpd3Qk2AVlok8QFQS8JzwrQ0t/5wuw+CHbD1vIRebO3HF9wO
	ddXd/oXhCsnE6/h7GDFLFCZXTQBA/Juws1/RNZkWIA9QADALI9YvFmXdtsDum70BicmffPYBbvj
	g2JjW1U7eH+v5HZLQWQcx6RpOIa819oeR63jJJwdDkt3dJOiDIL3vdglFNiFFBciDUUYTxIMBKC
	u8pNYKPelIkMt3gWOway21m0STr6A+0kSYquAUiPyd3KQstc0XGtwDDJK9lvaJ3pgSnmxNtbXJY
	SMKRONe248JNAZl4Hm/2o5RrOost3QTqKNn9N61oobsfVw7jyOi/Hrnqr3anxuWmZTGd2BRgiL9
	0xx/ieKhVgWkehMSCLmBgmzo7jt3RkV2IsCvywnyRr1TuDQOkJyh1kB+fgb6b04nvxV2pST9HDw
	7MjUhFcUUrNsgfO/jUzUYdEVW0avSiCch+qRMtXDill+V22LE7smnDYeHG3CZ7+Eq+T0uGX1Ud+
	WhyV3S4xcPOvkKu9HI47KBpQ8sUtlPrrOABXxZlW2T2HfTyObMEHCSM00IBHu4gsHM=
X-Received: by 2002:a05:620a:2990:b0:93c:c08f:ecf with SMTP id af79cd13be357-93f29d69e08mr105371785a.53.1792173923072;
        Fri, 16 Oct 2026 11:05:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f23eb7ba5sm131256785a.27.2026.10.16.11.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:05:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHmIz-00000002FIM-2VOf;
	Fri, 16 Oct 2026 15:05:21 -0300
Date: Fri, 16 Oct 2026 15:05:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
	joro@8bytes.org, nicolinc@nvidia.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dawei.li@linux.dev, praan@google.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Align memory attributes for
 SMMU-originated accesses
Message-ID: <20261016180521.GJ14213@ziepe.ca>
References: <20261004195027.227748-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004195027.227748-1-danielmentz@google.com>

On Sun, Oct 04, 2026 at 07:50:27PM +0000, Daniel Mentz wrote:
> The SMMU specification defines several types of SMMU-originated memory
> accesses, including Stage 1 and Stage 2 translation table walks, stream
> table accesses (L1STD and STE fetches), CD table accesses (L1CD and CD
> fetches), and queue accesses (CMDQ fetch, EVENTQ write, PRIQ write).
> 
> While the memory attributes used for Stage 1 and Stage 2 translation
> table walks are configured in io-pgtable-arm based on whether the SMMU
> is coherent (ARM_SMMU_FEAT_COHERENCY), the attributes for stream tables,
> CD tables, and queues are currently hardcoded to Inner Shareable,
> Write-Back.
> 
> On non-coherent systems, however, memory for stream tables, CD tables,
> and queues is allocated via dma_alloc_coherent() /
> dmam_alloc_coherent(), which provides CPU mappings with Normal
> Non-Cacheable attributes. Having a non-coherent SMMU access these
> buffers with Inner Shareable, Write-Back attributes results in
> mismatched memory attributes between the CPU and the SMMU.
> 
> Configure the memory attributes for tables and queues in
> arm_smmu_device_reset() and arm_smmu_make_cdtable_ste() based on
> ARM_SMMU_FEAT_COHERENCY, matching the attributes used for translation
> table walks:
> 
> - In SMMU_CR1, use Outer Shareable, Non-Cacheable for non-coherent
>   SMMUs, while retaining Inner Shareable, Write-Back for coherent SMMUs.
>   This applies to stream table accesses as well as queue accesses (CMDQ
>   fetch, EVENTQ write, PRIQ write).
> - In STE.{S1CIR, S1COR, S1CSH}, use Outer Shareable, Non-Cacheable for
>   non-coherent SMMUs, while retaining Inner Shareable, Write-Back
>   Read-Allocate for coherent SMMUs. This applies to CD table accesses.
> 
> Assisted-by: LLM
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> ---
> Changes in v2:
> - Rename local variables 'cache' and 'sh' to 'cr1_cache' and 'cr1_sh' in
>   arm_smmu_device_reset() (Nicolin, Will)
> - Collect Reviewed-by from Nicolin
> - Link to v1: https://lore.kernel.org/linux-iommu/20260929032229.3532247-1-danielmentz@google.com/
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 37 +++++++++++++++------
>  1 file changed, 27 insertions(+), 10 deletions(-)

I think this looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Did you check the spec that this is every access? I remember there is
a table outlining every access and where the memory attribute lives?

Jason
