Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B093DEFE6
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776210928; cv=none; b=RvMPClehBMdLjlo5uJ4VcuTEigA+7Cg3UmN0AzKfsZm8ceJce85/vMO/8nYQdKtyYZNaJgnpvvniV95DeRq99g6d/tTBa11dM4GyJWSVQ3OwoBsKjOSDoZwSLsrsbl0nOEOnpb+h/TIHTqpySE6Hyy9BWI+i3XNP+sMRc/GPxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776210928; c=relaxed/simple;
	bh=bXthyTyPD8HJXtbc7b/60AdsnLfDVgyQtpflPFJn5cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bz9ApXyjfNJTu8eW+5tknRgrvjFEbni9vnFoT03LUj/EZSya/1VxwopNj4tjSR8x8bX1mRbBexH5vTdVv7qosaJ0zkqaq1FZOlDzGjmjB7U+//tFY+VgdmKEkTlTW3sY49FOL/FWRxKfPUx3X2X7Rn5FhIOkQGaFm6LTs7p503Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qof3BvMt; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qof3BvMt"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270f10a774so51941c88.1
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 16:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776210925; x=1776815725; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpRjTKGiJT3SKKirJS2q6w9bl1zmBk9WenXtcrivl20=;
        b=Qof3BvMt36SZhH10IELpye1kI66flYCDPJVZLJp1sV5L5LMlIRH0uFd0WePoUkTf0h
         JL2mLZ/3uMMnMI3HN0GD2eZwqna1FIPUOniZHeRORMEUbl2W+GXbPW03MZsYE5/Ufp82
         NG+opXxhyhENb2gN6Ke+uRJdf33ZVxWS0vkqv3jRZrZP2Kg64ozawEcsy1KETVedIUuK
         kHu1H+LQixqS5VPfBTt/DkLBQheV2hkLQcftnNDAP6YfuyFznLtSJtjcc1An4BOuR0y9
         82c7D7NGvFA/FeAXwJ/7FvCBXb/efEclDXm2KadR7imo/T+DB9s1a0r/53pIJaWyrG7+
         t1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776210925; x=1776815725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpRjTKGiJT3SKKirJS2q6w9bl1zmBk9WenXtcrivl20=;
        b=Zul1HO/3rjxXWPVuV/a6rT9G/U5SACt6vrfRzhiYxwEop7N+jhpWDJu4QjtCM2/dIi
         hwwzIaBduphkJqUELTpdiP9IrmjgX5GAfVVxSRKblPiZ3GImmoU8+StA6yxRc83lWYlZ
         IEBcKb41jWhh8KpfQEiW9Kr9wHOGUX60kk8IOal5CAMtbaCory30fS3zGcHC2kBLvQ21
         HCBax/uPHKtugg3Lw2F9iMGUbzTMpbd0BWg9pw0vCrfc+QhbsiFfZqmZd2H72W7RXvI8
         0o6zDKDnNvbc6w2pqgJacLSXzjN1MgPqRIsuCzhjggQ3kVVBZsr4REv5ChcXsQk7jeb6
         haZg==
X-Gm-Message-State: AOJu0YwLpM5tQZZgcNsMje3+TLwj+FAlspzz7VEsjokPNu13fnk8VtOn
	JOeBK0YSCZYOAEWYr86xUqbwb4oaPsk9Q08ktxsaGZ/LgVGvLRsDvJVDODYxQTdULw==
X-Gm-Gg: AeBDies4lxPEIOPaEOkMcL45vgPTqCoDdVoUYwBpBvCizckPPaFVFMB+LxBmtOXk+8V
	DNuXG8RspE1z7CIVBk3DHw7ilT4dk7JkJ1ItFQl4QxEsffXTY4RFgNtcmw9J045YOS2I/WlUA1v
	IdThTBVAkKEANBObZOJaIecJJcwVEaAN/5gPU4OEj/1lzO+I+ij2ipsf0M1VmxVJY4wzyx5qUF5
	ksGrLG+QEM3D/buWT5hXpOedXkjLwE7dDCtwWac7THT77f2mhlIMFoQ1hORAekMXe47f8jj6Bs2
	uX+kLq9sBqSmtkCqy7PmHQeLi4LoPo/vD3y5165L9bE3VJpW4l95x2AtZx2WFAqxOJhaL7PtP36
	Wyv09lZMq8mZrSK2d2j26RVrtqH2KjmdU1M+DqC6UdPmhzX7uz0haNaixFfbDW8qodcCf0Xiokm
	FlCUcU6U3PdWDXzSPenRh2yNkhvW+Q4nTFgWGPzxw4QuLqZNcsYPcNJYjHI/wUXJ6fd68JKIAe/
	UeGZnnUrH4=
X-Received: by 2002:a05:7022:ec07:b0:120:5719:624e with SMTP id a92af1059eb24-12c5cf56253mr22645c88.21.1776210924021;
        Tue, 14 Apr 2026 16:55:24 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c345b6208sm22430017c88.8.2026.04.14.16.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 16:55:23 -0700 (PDT)
Date: Tue, 14 Apr 2026 23:55:19 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Weinan Liu <wnliu@google.com>
Cc: iommu@lists.linux.dev, jgg@nvidia.com, joro@8bytes.org, 
	patches@lists.linux.dev, robin.murphy@arm.com, suravee.suthikulpanit@amd.com, 
	wei.w.wang@hotmail.com, will@kernel.org, kpsingh@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH v1 1/1] iommu/amd: Don't split flush for
 amd_iommu_domain_flush_all()
Message-ID: <ad7TzkuA1VC26vkk@google.com>
References: <20260414210626.2097722-1-wnliu@google.com>
 <20260414210626.2097722-2-wnliu@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260414210626.2097722-2-wnliu@google.com>

On Tue, Apr 14, 2026 at 09:06:26PM +0000, Weinan Liu wrote:
>We have observed multiple full invalidations occurring during device
>detach when we are done using the vfio-device.
>
>blocked_domain_attach_device()
>  -> detach_device()
>    -> amd_iommu_domain_flush_all()
>      -> amd_iommu_domain_flush_pages(..., CMD_INV_IOMMU_ALL_PAGES_ADDRESS)
>
>      	while (size != 0) {
>
>          -> __domain_flush_pages( flush_size /* power of 2 flush_size */)
>            -> domain_flush_pages_v1()
>              -> build_inv_iommu_pages()
>                -> build_inv_address()
>
>         }
>
>build_inv_address() will trigger a full invalidation  if the chunk
>size > (1 << 51). Consequently, the guest will issue multiple full
>invalidations for a single call to  amd_iommu_domain_flush_all()
>
>Without this patch, we will see 10 time instead of 1 time full
>invalidations for every amd_iommu_domain_flush_all().
>
>Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
>
>Suggested-by: Josef Bacik <josef@toxicpanda.com>
>Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>Signed-off-by: Weinan Liu <wnliu@google.com>
>---
> drivers/iommu/amd/iommu.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>index 760d5f4623b5..bcec8721d228 100644
>--- a/drivers/iommu/amd/iommu.c
>+++ b/drivers/iommu/amd/iommu.c
>@@ -1769,7 +1769,8 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
> {
> 	lockdep_assert_held(&domain->lock);
>
>-	if (likely(!amd_iommu_np_cache)) {
>+	if (likely(!amd_iommu_np_cache) ||
>+		size == CMD_INV_IOMMU_ALL_PAGES_ADDRESS) {
> 		__domain_flush_pages(domain, address, size);
>
> 		/* Wait until IOMMU TLB and all device IOTLB flushes are complete */
>-- 
>2.54.0.rc0.605.g598a273b03-goog
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
