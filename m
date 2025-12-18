Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25DA86323
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766076167; cv=none; b=JONbjS8A/ykYGkSx6k4lUdZ9Lb/wbJVU6SNQqwduH6v40/2NvLMgktJiHYz/WgpQFV6hA3+DSZD3r0/hoW+Lpc5GCmAInQukUBFvM7Jj8coPtaJ5Nj5Fx49JmRpi1jO0TQPmWNKxD7ztAzoMuRico7HCc/6jzqJT7evp+rrFotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766076167; c=relaxed/simple;
	bh=btvc2jktmF+7SAu2JcVFJ+v3fCICkZ0RXvPo9gzYvlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBnCHGNNFU56YiPtfVCKYkQsW/SL6W35Gem0ZWB7aJXvkpEjYi12jvj90lzmHHcL99RtxWjKK6W8kL7oXSLHi2pOUNa0bAbVpkqV7JmQtjjZk/bpldxlhWnLuXagzRuenEKFwzgsRSRwKc5ueMD2rPcSedzvHSCGxaVmkvIZf9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bakc4y1C; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bakc4y1C"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4779e2ac121so73465e9.1
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 08:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766076164; x=1766680964; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+IFgshQmWOBMUvxTwruPAcrC79l+n1VOqPFKCVMtLyY=;
        b=bakc4y1Csim4WP+I31w5EnbUKGK5+gQkikq7z79p21VhnZjdoNHTzPRqBSQPiTGsKG
         Nu9L3ZGQfuvIoAiz+RJKVHhAxii8f4awzssEJQAAtblxVqc6boAhiAGBEh1q3rySZXeV
         NuTfE7+a/IufQ+oZVz8D0hMvdSnFFlVf2aPzb3EAJc1P9u43Z0tJyPjAFLNfIynpAshx
         wl6LIdfFYpEgKf9/bmsV7ekBMV8L3T4wYdQ9RlQYrbilG/dZgkMbCp0BFW3Z31d0Gm3U
         khPkwf19lOPtyX454G/B9zd3f5aOHBVnQaJRalBDPkajPhSOtrIH9mqwqp/yErSXOhUZ
         nG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076164; x=1766680964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IFgshQmWOBMUvxTwruPAcrC79l+n1VOqPFKCVMtLyY=;
        b=BbWfPjng/EmSj0WGHyB3vAUjIS/hUq5+UJAJECNFUb0P8fp7D6X21IBjqeh1EkIJq0
         460kxlygYPtXGsW1mRU1PDW989HFDVomNsKp7CPZDElsQbxUwYZwU2OyiCWVzPKK+0QG
         s03BnF5F/x/pkCW6aCC7Y7Capt7mqi5ZON5F9Bf+1uKvhCNsdOC/1+oU3XGj125/OueQ
         DhhAXCvm06lv9KUCv3q+ufUkYXnV7O2tekosnHzp00SezekG5Kw3eUvUczbbddJQWmnY
         6Kmg1d4s2jSxVQ+cP6G5+XD3D/r7/RJj7jcq7M24wZnwk9LB/EhcGAzZYOfaG3YAMUKN
         d+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrNvXdXcc9DMyzViv34qv36rduGV3sOsG7cq2/lbTmzvkEG3Ppj8yKByNujYWl0iPk9jgq4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgnfhyQMkMTNVe6KgT3+tqx2RZwA2ViJqSSZ69/2cUEgTNSD5r
	lEo73TC4mkbWhqwojN1vVz2zIg2an8PY0C4AazBwbM5gUUa0HUqBtmeVM6f1SHNUiw==
X-Gm-Gg: AY/fxX6lO0EMS1RRJpoNIeOzYGaolEumNwSx5hkUSNTmGejrwg5DcPIxVrrOzDapabi
	1VDoRLAYvZbLXk0uVvBZvs6ofaI+YDnAAi/yz/6wDJcE0HZtycxPMvfGFe8trkrx+lz3hTP3xOe
	ydoXIYjxIMNuPozqTNw9mrN500sNFB7zHGbtJiE65ny0r1rpC/4f4Xdqw/FbEe4iDBqS3CAsYZS
	8Lsu0oxf2PaX69s2J9CjsL9OhvJ+JE4DytykBzj+Ygh9yMdoy9c++rieOZe0lKQpEeXcjVakvYh
	QWFAqCePE/iTkFJ4x8UWtqtw5H8OMSodPUlYWTp2F6M00C8T5WuAI8yNZVftkvtjUDra0NCzCE5
	VA6/R8126eazTFKvqsxqVLMCC4EQFdzNxudcbFU8SJeQGfRnSQzOtAvWL1e6cyfInD7tP6rlQHm
	b2tKKdwwpz/1drrFXL9pkEzX2WzQ8YYfFIAUJqcMIlCKjdBaYviUpwyvElSWVs8iY=
X-Google-Smtp-Source: AGHT+IHHeIFx2+0vxOZyFtZ+vCiLpMtmd8EAFHGp/iCDxGY1OQ+0R1arRjVNTaj9Hz0mThE+88JGgw==
X-Received: by 2002:a05:600c:574b:b0:47a:8a6d:f4f0 with SMTP id 5b1f17b1804b1-47bf6b69182mr447195e9.1.1766076164138;
        Thu, 18 Dec 2025 08:42:44 -0800 (PST)
Received: from google.com (171.85.155.104.bc.googleusercontent.com. [104.155.85.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449adac0sm6085692f8f.42.2025.12.18.08.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:42:43 -0800 (PST)
Date: Thu, 18 Dec 2025 16:42:40 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	praan@google.com, xueshuai@linux.alibaba.com
Subject: Re: [PATCH rc v4 3/4] iommu/arm-smmu-v3: Mark STE EATS safe when
 computing the update sequence
Message-ID: <aUQvAKjVUT1L3N7j@google.com>
References: <cover.1765945258.git.nicolinc@nvidia.com>
 <adf08c3b9f289188aca4fe80e506dca7aa48aa19.1765945258.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adf08c3b9f289188aca4fe80e506dca7aa48aa19.1765945258.git.nicolinc@nvidia.com>

On Tue, Dec 16, 2025 at 08:26:01PM -0800, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> If a VM wants to toggle EATS off at the same time as changing the CFG, the
> hypervisor will see EATS change to 0 and insert a V=0 breaking update into
> the STE even though the VM did not ask for that.
> 
> In bare metal, EATS is ignored by CFG=ABORT/BYPASS, which is why this does
> not cause a problem until we have nested where CFG is always a variation of
> S2 trans that does use EATS.
> 
> Relax the rules for EATS sequencing, we don't need it to be exact because
> the enclosing code will always disable ATS at the PCI device if we are
> changing EATS. This ensures there are no ATS transactions that can race
> with an EATS change so we don't need to carefully sequence these bits.
> 
> Fixes: 1e8be08d1c91 ("iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 12a9669bcc83..a3b29ad20a82 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1095,6 +1095,15 @@ void arm_smmu_get_ste_update_safe(__le64 *safe_bits)
>  	 *  fault records even when MEV == 0.
>  	 */
>  	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_MEV);
> +
> +	/*
> +	 * EATS is used to reject and control the ATS behavior of the device. If
> +	 * we are changing it away from 0 then we already trust the device to
> +	 * use ATS properly and we have sequenced the device's ATS enable in PCI
> +	 * config space to prevent it from issuing ATS while we are changing
> +	 * EATS.
> +	 */

I am not sure about this one, Is it only about trusting the device?

I’d be worried about cases where we switch domains, that means that
briefly the HW observers EATS=1 while it was not intended, especially
that EATS is in a different DWORD from S2TTB and CDptr. With all the
IOMMUFD/VFIO stuff it makes it harder to reason about. But I can’t
come up with an example to break this.

Thanks,
Mostafa

> +	safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_get_ste_update_safe);
>  
> -- 
> 2.43.0
> 
