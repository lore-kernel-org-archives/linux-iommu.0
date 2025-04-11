Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F623026C
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399806; cv=none; b=q0HV3qOosDUIbzDcCV2MDT6rJLwDnIesVU/fQUmbpmh5ehziydYkIoNsvx2IcyQkrRtfsqmeVAtde1k36PEtDLv3MR1NTGdSMWKYS+3RKCk7sI/hlQPu7QycEh+f/lMW/C9tcTRbV55uvehenWP/aCqDP/7FzPAbnW9C8fiQkf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399806; c=relaxed/simple;
	bh=Io2eF9HidXVtlDJh1Q6ns77Y9U+dwCs2nYTK8tsIOoE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UH4agQKc9uRQz0Y6AAB/662rMJesXfqNld/c8JxQ7QsMP3Itb/ziGv5dZ43Z7d1Ho4OtoI55pqKd2kXi3xjfmVIM8ijXLYLhi8lwup64pA1GswVPVL5C/fBYIF9p7uwZzkijvS6lQ6ZqSX/mWd9SfWYuLfb31Qp2OxdTjOShHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUupjpMg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUupjpMg"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c135f695so1685392b3a.0
        for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 12:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744399804; x=1745004604; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1kBZrHYQ8er2J5WV3BfpgQvOA/o6C/K+dCwlHG5TwA=;
        b=jUupjpMgx7WSkLELKFwl7x0r1ydxRu04PJQBxH3E2Dg4KBlU6zh+WySjql5MRZ7M/4
         mhcrFfEnZL6XkDRQYYheF0nY1ceMbjjWKJTRWiH1Y3eWHcHze/o4tk8wq3CiN5v0KKnZ
         9u/HXed8tOkEc8OsqxIILXDHNY1w0iejyHHlhWevZnQ6k6QNo0rKu8p/Zu0yyZkn1Jsv
         FKLvZTb7R2CIS/P2/fLwX2MGfRxhZXUmBsfWXyO7hsn8J1glIyar6fffYnIJTK7/r5zu
         Tv/+Tu1iMbkpCgTBmhjrW3lCgUGvTE0RtV5m7y8Ye+hu3cDLT+iRv2J3yhUJmOXeN3Wz
         rSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744399804; x=1745004604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1kBZrHYQ8er2J5WV3BfpgQvOA/o6C/K+dCwlHG5TwA=;
        b=RPHOlr0ivY4CPQ6TWH81DHGb9hpIowjPNsaYS9qIetEXE/XWuUoZv5099eqOtCFSZo
         4OQ8wc2B3QjIKJCyNCjV1QdUB2VYRF7deU8brjmg0Jd21qTp5r/KNLeclXDismqV+Ni/
         mqfdiqs1TvaQWgwmdDjy/iuibU7y2Y/9XFubfMaog7y+o+gzoRou0i08XScwOOuAY13P
         R4rFC/KP029acU37/W5QHsd+SxBH0TTSAhQEe7TvNGoC2YC31lIBnItaYbARHJXOOioU
         1PSqMDb0Zyx5AMFzO/hAx4/Iw+qcLmYKDqcM29Qek3cQipmSQSBvuIn3DfBGx+fMagJq
         2OYw==
X-Forwarded-Encrypted: i=1; AJvYcCWfD4QcHpc0Az+bqlmO2Fju94ASLT/dkoJCq8j0M3P0a4IzhTrRW5rz4/qbCiQpRrvgmGigpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKt6HBM5TV3U101/RUjxDpxC/PXlLaxH3YXx5fu2I9EBXaFRMP
	3/IG5GWnWbdVeTzXFzhH8yS672VUyYjIPcU4z0OmgI/SfqLtoWMc5q31n7ACsTf487VDnZoNUQv
	mUQ==
X-Google-Smtp-Source: AGHT+IGVl8U2KBqY56a0k128AK3K+DqrayE5kJJ9Ka7llkyB8RofmMumBTtnpOdnR0n8VfZ5T+q+Fn5nD+A=
X-Received: from pfbfc2.prod.google.com ([2002:a05:6a00:2e02:b0:736:9d24:ae31])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21c7:b0:736:b402:533a
 with SMTP id d2e1a72fcca58-73bd1192d3fmr4797212b3a.1.1744399804638; Fri, 11
 Apr 2025 12:30:04 -0700 (PDT)
Date: Fri, 11 Apr 2025 12:30:03 -0700
In-Reply-To: <304df156-0374-4e43-b261-754b438e937b@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-6-seanjc@google.com>
 <686dced1-17e6-4ba4-99c3-a7b8672b0e0d@amd.com> <Z_khsNAbh4kIhKVC@google.com> <304df156-0374-4e43-b261-754b438e937b@amd.com>
Message-ID: <Z_ltu8wl91JoBnN6@google.com>
Subject: Re: [PATCH 05/67] iommu/amd: Return an error if vCPU affinity is set
 for non-vCPU IRTE
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Naveen N Rao <naveen.rao@amd.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 11, 2025, Sairaj Kodilkar wrote:
> 
> 
> On 4/11/2025 7:35 PM, Sean Christopherson wrote:
> > On Fri, Apr 11, 2025, Sairaj Kodilkar wrote:
> > > On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> > > > Return -EINVAL instead of success if amd_ir_set_vcpu_affinity() is
> > > > invoked without use_vapic; lying to KVM about whether or not the IRTE was
> > > > configured to post IRQs is all kinds of bad.
> > > > 
> > > > Fixes: d98de49a53e4 ("iommu/amd: Enable vAPIC interrupt remapping mode by default")
> > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > ---
> > > >    drivers/iommu/amd/iommu.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > > > index cd5116d8c3b2..b3a01b7757ee 100644
> > > > --- a/drivers/iommu/amd/iommu.c
> > > > +++ b/drivers/iommu/amd/iommu.c
> > > > @@ -3850,7 +3850,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
> > > >    	 * we should not modify the IRTE
> > > >    	 */
> > > >    	if (!dev_data || !dev_data->use_vapic)
> > > > -		return 0;
> > > > +		return -EINVAL;
> > > 
> > > Hi Sean,
> > > you can update following functions as well to return error when
> > > IOMMU is using legacy interrupt mode.
> > > 1. amd_iommu_update_ga
> > > 2. amd_iommu_activate_guest_mode
> > > 3. amd_iommu_deactivate_guest_mode
> > 
> > Heh, I'm well aware, and this series gets there eventually (the end product WARNs
> > and returns an error in all three functions).  I fixed amd_ir_set_vcpu_affinity()
> > early in the series because it's the initial API that KVM will use to configure
> > an IRTE for posting to a vCPU.  I.e. to reach the other helpers, KVM would need
> > to ignore the error returned by amd_ir_set_vcpu_affinity().
> > 
> 
> Ohh sorry about that. Since I was reviewing patches sequentially, I did
> come across those changes.

No worries, I wrote most of these patches and I can barely keep track of what all
is happening in this series.  :-)
