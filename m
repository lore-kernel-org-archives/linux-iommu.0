Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88432692B
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 23:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516713; cv=none; b=Nfi9Lvq/cOy7hiTuuj5zhpuuAd02AJYjR/b8TiUwy/WKMHky9RsT6JBSvek/7CWAIN6IxPzJMKHNxmp4hJUHQDgctiiAc23QyMkMJn2ftQjHHLTuH9wSNkiTcypxGdhspG8OKywsi8tZ8F2hNjrLcmEFBEiqigv7P1qjYHIwc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516713; c=relaxed/simple;
	bh=ybU40crsJbgKRM+lolfywi67b9/Q/ZY7FuGF+CQZn98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=apjK4dZwn4XaGXkF0QQ24j5TNTMO+Uskdlt2vMfrcWoH8Wk2k/Z9+HEMTM+WyBRrBlTt44qKPRWDVhS1yuWnqGZV94JC2Ptph5MLe5NjqH77jgOt7KlXGcIWAH2mI9ZY8GtO3h8jokQnn24r9wRRW4jgYfeJUfSwH5tDE7nwj98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjhhetPo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjhhetPo"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so2543082a12.3
        for <iommu@lists.linux.dev>; Mon, 06 Apr 2026 16:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775516711; x=1776121511; darn=lists.linux.dev;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8U6D1Uqq+dz9m7XIvKQ1cp57uujuAzr1lxBVyWDa42Q=;
        b=hjhhetPonKhh+CHW4cYXEAjwG0uT5cfxp64PGiVkYX3VpRwxM8YDMMMij5Bz8YtEII
         c+DHnFrKB2dERewRVs/+bWU0Y22CtrtIfun25JcbgWUzL/qywlXe0la+1TRHixXrRgKO
         ZnutGIWzstq9sNR9RN6SpH6zuTEwL9xp4yc7Sa+0L6mLVAN5G8ylXV1QwhCI3wSQvUoi
         qHoBNpl9Jy1AUVjx1jVjv3Hhm1TJtgi+tE01tqRALWPdtXbzCBdW6rgOf6yT4bIXPCCI
         tAXOIWSSae7qliWGuCYalQjbgGSXCyz9OM0XxfX0WLsM4MntUiGD/47rwRPT/W7/GPSO
         VeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516711; x=1776121511;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8U6D1Uqq+dz9m7XIvKQ1cp57uujuAzr1lxBVyWDa42Q=;
        b=gXqqs3iH98RyrXW3SSjLs65UBjvCz6tKjN/p4wXvAUMJVHbx9Q7rKnJx+CMGv8PhfU
         lnZrk3pjL1OWpUep7ICW87Vs55g3R9RbRX6NFKb+uipf+iM95B1ePWCq1BDYbucqRG48
         TgDr/VUjHuckIOWzHWLrTZEe9MzG0/L+zVz8IsNSpS9K9+UfH9ogim2DH94Fsts8ekcD
         PLEIdZ6mHZb9Hlwkx2dl1D0S9/7rBNGwGtlatY9qK6A4q1SHC6f7Azf+d/DhuAnvBZeU
         lWUKJLmydBGfGx/07AJ2no2WyZaqSiH8E0p/OiuvB2I9pJJ4tMutfai00eyKal6ckalU
         jVgg==
X-Forwarded-Encrypted: i=1; AJvYcCXbg8O1h0hI5uMDTIA6ISxhhdtN9PFQVWH5Vcp6YHy+2HH8GugcGYIGkvjDNngilfJstzyf2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhwT770ichUsMLkwU0cIGkuUxFvhSft+om4760gjuZne/AflPy
	yQIEs1TUN/BwNzH+c/FdLnFioybJiSCtePyOvUJFP83o9Jqj2Jc55w85rAv1jZRkz5LMYpoxCBp
	FVOAHiA==
X-Received: from pffk2.prod.google.com ([2002:aa7:88c2:0:b0:82c:d5a8:7271])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab84:b0:82c:225e:63c5
 with SMTP id d2e1a72fcca58-82d0da4cdf1mr13212073b3a.18.1775516711309; Mon, 06
 Apr 2026 16:05:11 -0700 (PDT)
Date: Mon, 6 Apr 2026 16:05:09 -0700
In-Reply-To: <20250315030928.2373250-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250315030928.2373250-1-seanjc@google.com>
Message-ID: <adQ8JeCu4c1dzpL8@google.com>
Subject: Re: [PATCH] iommu/amd: Explicitly bail from enable_iommus_vapic()
 when in legacy mode
From: Sean Christopherson <seanjc@google.com>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 14, 2025, Sean Christopherson wrote:
> Bail early from enable_iommus_vapic() if IOMMUs are configured for either
> of the legacy modes, as it's absurdly difficult to see that
> iommu_ga_log_enable() is guaranteed to fail because iommu_init_ga_log()
> skips allocating the ga_log.
> 
> Opportunistically have iommu_ga_log_enable() WARN if it's called without
> IOMMUs being configured to support AVIC/vAPIC.
> 
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  drivers/iommu/amd/init.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index cb536d372b12..05c568da589a 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -931,8 +931,8 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
>  
>  static int iommu_init_ga_log(struct amd_iommu *iommu)
>  {
> -	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> -		return 0;
> +	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
> +		return -EINVAL;
>  
>  	iommu->ga_log = iommu_alloc_pages(GFP_KERNEL, get_order(GA_LOG_SIZE));
>  	if (!iommu->ga_log)
> @@ -2863,8 +2863,10 @@ static void enable_iommus_vapic(void)
>  			return;
>  	}
>  
> -	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
> -	    !check_feature(FEATURE_GAM_VAPIC)) {
> +	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> +		return;
> +
> +	if (!check_feature(FEATURE_GAM_VAPIC)) {
>  		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
>  		return;
>  	}
> 
> base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
> -- 

Another ping.  This too still applies.
