Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DED2749DF
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516619; cv=none; b=lqjVvkZsqyf7/nkjAolr6TZqzHjw9jUyOudvWobUGGMTIrtT9k1qtjMWylvvaNb/9HAriEnZh1/M5r+68nbX6LaZrIFAaFLj0cAM486xJyn9yWRoPJjmaSGai5OEIxXNAjNeRsFr+F97PU93KmboXqXOjPtfTDpenL4DQfRDd9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516619; c=relaxed/simple;
	bh=WRvXVXQ26RCGWvbT6MxEpB5Ka5PWKo27ByYhMlYDDJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UDz3jCYV4EjiZO1NvyF1jOdfF6AdokfDhqlKDlbOJcUYW4UHML1L43Fh1KVZ6ihU3MuJywO1wShl8fJeJYWBCxx8T+ni1t+lOZlC2Ft10Vg+26YcIUNb90IVDRoLZmURmjRxrEOLfKWHjgk32E5iK+PcfpxHglZuD50gRWXOJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwOwYnLQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwOwYnLQ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adef9d486bso68068765ad.2
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 16:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775516617; x=1776121417; darn=lists.linux.dev;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=my2PUIEQIzV9RWRsrjtv0en9ZlG//OKErAUfNIV/bLE=;
        b=CwOwYnLQi9s1NZ8llml3/wh4xlzspFQ0GvrWxG6k0PMmguOqWKYVYTha3zTGhiRm8A
         1YVA3Ol85Sc1cwFd4o8oUuT3d9z60iWHLAGZTBqw1wVY2euWL4SS0t+W2m13ztz2umhu
         dlupbBlEyinU1UFuUbGbRhfCkjgLXbqZoykMPIFytXZUcYqnmqe0CfHFhutcxxL+GC9W
         Ojcle0REcDWsgAQ1gA3dZsxdL4iK67v5D+6QQs6h1QpfmjzCnOju0VUh0ZOurKuJZmB4
         VjPVM2cRqJIS+ojFIfCcs94y1zCtaZzhuRBgORgv3u5iDppwVg5luT9r1fDG/5B6SjuR
         Yzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516617; x=1776121417;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=my2PUIEQIzV9RWRsrjtv0en9ZlG//OKErAUfNIV/bLE=;
        b=cQLHgvcjThZ5zQD3zSxfYNTsRDCahByyVPWK7N+hU6nAE1H/D5R41PkoSJjumR9gKb
         OY5VUo4u2wVy7DN6K6voBb7vpd/7bOoOFl+Vn3entkebYmq6iIttSsPZ/87bUTJf5UZE
         qVjzxOhTN/olZkkVoSYrOH6O4RC6G8becDn2HIWV7bArDRPJ837EYK5lR0tkR+KCUGRL
         gjXmRrlTFoLUo/Rg5BC3BUOXKzFsQ13Q87+c3FuZxM/2lxYKN52A5V5T9x07r3QZTadA
         7AD+XoT5vgkB7NTB57Zl+ZndShl3BKFV42Ph2sU8mgOkoJYlpEtqJHW2862IbVHPZwOo
         qsUA==
X-Forwarded-Encrypted: i=1; AJvYcCXbhTnC5mbp+1GOeoceIx9YFZYzA8rZ0QroN4bOCmpMLGQoiOyIbRrc+BO1GBB/o/beXMnrkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzorJaqqAHuI3guk/4GfyDt9MnCOcyRTmts7vJgTI7kMr4hgj6y
	yRM2UoH0Lr08OxY8uC+M6uWsY9Cwj1WXTbQ53VXNO2gBMJQ0Ro7Ol6G3knMQgMeMPFJoJEoUG1F
	NVj562w==
X-Received: from plgi3.prod.google.com ([2002:a17:902:cf03:b0:2b2:4991:e485])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c7:b0:2b0:c451:aea8
 with SMTP id d9443c01a7336-2b28ecb83e7mr115431845ad.14.1775516616957; Mon, 06
 Apr 2026 16:03:36 -0700 (PDT)
Date: Mon, 6 Apr 2026 16:03:35 -0700
In-Reply-To: <20250315032148.2377902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250315032148.2377902-1-seanjc@google.com>
Message-ID: <adQ7x0FMmo4FG26t@google.com>
Subject: Re: [PATCH] iommu/amd: Fix a stale comment about which legacy mode is
 user visible
From: Sean Christopherson <seanjc@google.com>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 14, 2025, Sean Christopherson wrote:
> Update a stale comment about which of the legacy modes is visible to the
> user, i.e. can be forced via amd_iommu_intr=legacy.
> 
> Fixes: b74aa02d7a30 ("iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled system")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 23caea22f8dc..f7877abd0091 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -968,12 +968,13 @@ static inline int get_hpet_devid(int id)
>  }
>  
>  enum amd_iommu_intr_mode_type {
> +	/*
> +	 * The legacy format mode is not visible to users to prevent the user
> +	 * from crashing x2APIC systems, which for all intents and purposes
> +	 * require 128-bit IRTEs.   The legacy format will be forced as needed
> +	 * when hardware doesn't support 128-bit IRTEs.
> +	 */
>  	AMD_IOMMU_GUEST_IR_LEGACY,
> -
> -	/* This mode is not visible to users. It is used when
> -	 * we cannot fully enable vAPIC and fallback to only support
> -	 * legacy interrupt remapping via 128-bit IRTE.
> -	 */
>  	AMD_IOMMU_GUEST_IR_LEGACY_GA,
>  	AMD_IOMMU_GUEST_IR_VAPIC,
>  };
> 
> base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
> -- 

High latency ping!  A year later, and this still applies cleanly :-)
