Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20F388371
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126058; cv=none; b=BN4KeckuCqB/yjuTX24SHZ4FkPzd27XEkS2fICpM+mY8gcp1xzTffsrMWcWh171E4pneQQRtwEhGCJHI9mK+GwQW8q+lC3dEsKpaQTxrGE6q8dqtzPdHBEdrsJYV5j6rNG3i4LeSVq4851tpnYztyX1juoay1off7DBLu51Niww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126058; c=relaxed/simple;
	bh=k8eKHIpCaaPLKTjtgUqCHzqXzJ9WDZ7k24XDEaWgMaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3SuSpDA/XK9+0ssC4QepptTpKlUwTuOCeReczyDJJM8lulMCnfsRXX59cDB5bxsrTPKEYa4gcWJKAGfFLq2kzFVKddxgW2lD4AyM75qJQoymHsVTeb5mvnZ7D9XHadXixdJjiiAyN3VZY/KTpXiR+wXoAL08r6iYb13EQQEGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEU/jQv9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEU/jQv9"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4720d22c94aso2375321f8f.1
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784126055; x=1784730855; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=knIg8/634584Ytue9vf6OuJG9Of4+644gUu2jDQuGXU=;
        b=iEU/jQv9FWo56wu+l37oMd60MoHhZqc0izobT1lGiZk0ZU6D5c9GnPaJvE3E1aF1ip
         hh4ajrhs2dzvWc8LLixIGcqp0tgtgc54wSnFzFXPOr/5f4v4Rjaru0ccAwakltvV42Eq
         Kj8msDxPfOaDbDWgUA5RkKkYO34Zuz/IhCvlYrsMO73SZWSvY2qTlllE/CvNzz9b87OT
         358ErdI1QG0a2mmyNSJAS1NCpUM70LMx963qjuj/iRrq5g8q3Mp31kyz6HzqzPhLsP0Q
         54kxsbVktLBeTrVRR/5iiyv8qXDwpPjN8YppMSG6VfdQMRHziU4zYHYjIIuozXxrpwlv
         U+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126055; x=1784730855;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=knIg8/634584Ytue9vf6OuJG9Of4+644gUu2jDQuGXU=;
        b=W+fKS7Uybr36cfSMRvKyEnETN4HKWcwv4pxZgWIW4Yir6833+kSmbQ2/3ZVoRdM/Yr
         tUSLegV9OJSdJf22kAzIa+wey7c1UCPj7X/KL87D+o5zQE9lF9xvr8VDS6nlCEyPmZD0
         jGzMaol/NjVwlm+fBEJXBwz9ODmG2KU7IidteHca7OkFtGokB1u2oKm4Jh1kWx2lS4HS
         OzzSkjSCQfkGj3XwveQps+b92IX+OiLekG79/+jvAIwqQf/gA0xB0FQO84sBqTTOlsMw
         rn/TnlLnwOozms6bNxeX3OrYigINV1iaDXRGX/5YvLSxdRkKjUk2A6dWOOBJSUNfk7ml
         OWwg==
X-Forwarded-Encrypted: i=1; AHgh+RrvauEl+SvRdt2rQejxopz8jzrx4ZsiZe/R9pWXVeIU7Dpd0V7m1ue9EixdHxj29phi58oSGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YybJmK6BPjJbyYA3FqPxAyePzqJq1Qk9AE/sN4ez/aKuJr/evHn
	RJeMxor8CVoceohXgFn4kFXcRfVqbEjYfPwe/wTcINm5VEF3tPmt3HGg0rjCTMNJjA==
X-Gm-Gg: AfdE7cnmbI8wvNWQvitfQksq6Hx1TWL/zyipRd/hZc8BpMdvz4uMQYajUUDGnX07Kbz
	1F7dWlWDuiSvCjaIVrZdzNJ5b1ySoYzu8GqlXJ94/CSDTxSBkLWqszo2Oa1+vOx9B/4x9rBXjiR
	C4DrmqjH93r5mwL/nO7M0Ulmpmi704DSi1oHiHx7k2elVDoDoUug2EodMrI+mW0jbkZI09L7yFu
	6AoXen5T4pEDgn5ATQIYrVRN7oOZHPMSmE2OpVDZox/JS3/u0zHrcRJTq6L7lkUxGDZpp+q7Sdv
	8D4/0kRu/TOphC0q81LyMd+rR+foyh7t3YkBp8zxxsUULcBKwy0doYzZI28Oa/ejk4rz8XTRz0/
	KHBx+st9okt1J3ugVL241yfCDZERHOJK/Jl5U7JCR9NAhhoIJaqYXUfs53AddKyBdsTNHHdhFYl
	orv9n0KdN2Nb/ZD0NEt8wQzxgXsep/hHDBWKb/EH9MQa4z80wJLCJXeVmTI0CcKA==
X-Received: by 2002:a05:6000:220e:b0:474:e0f2:905c with SMTP id ffacd0b85a97d-47f2dccb729mr19822692f8f.26.1784126054166;
        Wed, 15 Jul 2026 07:34:14 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96cfsm17087436f8f.20.2026.07.15.07.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:34:13 -0700 (PDT)
Date: Wed, 15 Jul 2026 15:34:09 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v7 01/24] KVM: arm64: Add a generic clock
Message-ID: <aleaYVz5m19veRjT@google.com>
References: <20260715115906.2664882-1-smostafa@google.com>
 <20260715115906.2664882-2-smostafa@google.com>
 <alePwq2eKV5g_7Gc@google.com>
 <aleVozZEcxiGE4Y3@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aleVozZEcxiGE4Y3@google.com>

[...]

> > #define smmu_wait() {
> >     static u32 window = arch_timer_get_cntfrq() / ARM_SMMU_EL2_POLL_TIMEOUT_US
> >     u64 timeout = __arch_counter_get_cntvct() + window;
> >     u64 cur;
> > 
> >     ...
> > 
> >     while (!(__cond)) {
> >       ...
> > 
> >       cur = __arch_counter_get_cntvct();
> >       if (cur >= timeout)
> >           __ret = -ETIMEOUT;
> > 
> > 
> > No risk of overflowing u64
> > No init necessary
> 
> It believe init will be needed as caching arch_timer_get_cntfrq()
> is much better that re-reading everytime. But I can make all of this
> contained in the SMMUv3 driver and remove this patch.

That's why I have made window static :) (well of course it is per callsite...) 

> 
> Thanks,
> Mostafa
> 
