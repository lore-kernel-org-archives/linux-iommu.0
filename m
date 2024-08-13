Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188A1BC5C
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571522; cv=none; b=gmRQgNPS/dCe3HK+iNZ5JMcUOx7Rbm3BsXs9/hNDCsv3ED1PdhnIqi+sXTYWGz7uNfEgmIbzgOfdtRp0v2uikk6+LpgRkXV+TSlAYN8YyLXNfCgz5inWcn8g9Pm0NY+I9QgneqaEYNI4S+vM0rlhVu7ihlME1eBwov8/Vd0QZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571522; c=relaxed/simple;
	bh=ntkDeJlYChEivTX0tyYL1K19WfOpIRbzhRHsrFfpQOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cwm6NyetjOGzrAEFZr5tAtmBQynmCIVnlhw5BY0mo/D6SgzOJOKbS5C3zLsjjCzJtPgCK/YApDvX6fVRg9mWMGwqiuS2ibdxKVMsourJnqGdRl7tQMIVHVWYdQQge3WV1kq2NKzUQWZPYWTqY4nZztuq90XTNg/l9GCcTDqeKhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AwmiDvWi; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AwmiDvWi"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1d024f775so384258185a.2
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723571518; x=1724176318; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A5G+oWQ6Rh5ISXgA0J/LF+tOSSrj10GPW8g20/rns1U=;
        b=AwmiDvWiPJ6soUHsW8sJ6Z5BJwLnHVgMBIqduEKQ8jynBdTdQ/BRnHmuQKYfjDWDTM
         frDSWfjIjRp0GW6flVMjyrWtRAc5yqnHdTBMBczyms+V6jBMhFKHIzYUg9WQO3RygjmP
         Ik6wLf3ihN3oM8cPvDM7KHKQz8l/rr51p9GsjP9PlwEED1FUKBfeZ0zHSeYXh+R9O/Rw
         Em3qc1tW+HzJht2jlWSloOZu7cavbRKY58/NVyXc58dJLCYAX1rkIudTjSsqjPBQ8OT6
         mD+wd+PTQeAu0lQpOL28oJO5xPCCdSq3a8OqveKK46JzcIXrCWDdw+t6xriPcqA+GbLs
         a0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723571518; x=1724176318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5G+oWQ6Rh5ISXgA0J/LF+tOSSrj10GPW8g20/rns1U=;
        b=GE8QmaT5vowy9DePiMQUJ4o/P48wNKylofwMvcGHYH9PUD/zR3XUszKZo3BWJWyuap
         FriTECYKQ1yp8xaOE4M0v/5Uj16M2Xm+guiYFyVb4IGDlubIHsazr031q1ww8P2WON5a
         duMlSj9nxQy0eOzVsWDuBSnwaDOhi6htamO0RHNUMvExfd6AbvX58qI3rKCbpmliJ9dP
         PkrRfylVkhV1ObvGPzBrkqr01cJnFPQCFwhM4Zx6c03KZzpDkVJ3wno8YKe3VyrV31j+
         iZpLy+UhgjcmJhCNJnOf358AwXeV+PeQtDn4s8Sx5DdqBVHV9CBH9/fGMH0FfMQLtwoH
         FMjA==
X-Forwarded-Encrypted: i=1; AJvYcCXDA/HHc1GWdTHz3ng4HF6U0NNT6j4SkEqDdBoLuW1GB8llOZiPnDFVnkI5fB1+USzobmdilE+Jn7aJFncjFUhgMD+6HUY=
X-Gm-Message-State: AOJu0YyZeq9LhdmnRkmE1U0azxrT/T3sMMDWF+VJ/84Dp7uuhJz5Gbi9
	fR6mw1/k8Onn2O5zbZ6f1Mc3bj0EVScPs31urVH7vwauEURv+Qp20VlElS7zMGw=
X-Google-Smtp-Source: AGHT+IGNfxxEytwtzg4vfONpxSKV6VhkyKNxntioOTjoDBXC/X1poTHbuNKyYTIkLBbprh5aPMRUaQ==
X-Received: by 2002:a05:620a:45a5:b0:7a1:6062:ed63 with SMTP id af79cd13be357-7a4ee33bdc5mr47040685a.29.1723571517942;
        Tue, 13 Aug 2024 10:51:57 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dedf8csm357399085a.77.2024.08.13.10.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:51:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sdvgZ-008nyn-MJ;
	Tue, 13 Aug 2024 14:51:55 -0300
Date: Tue, 13 Aug 2024 14:51:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
	mshavit@google.com
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Report stalled S2 events
Message-ID: <20240813175155.GN1985367@ziepe.ca>
References: <20240812205255.97781-1-smostafa@google.com>
 <20240812205255.97781-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812205255.97781-3-smostafa@google.com>

On Mon, Aug 12, 2024 at 08:52:55PM +0000, Mostafa Saleh wrote:
> Previously, S2 stall was disabled and in case there was an event it
> wouldn't be reported on the assumption that it's always pinned  by VFIO.
> 
> However, now since we can enable stall, devices that use S2 outside
> VFIO should be able to report the stalls similar to S1.
> 
> Also, to keep the old behaviour were S2 events from nested domains were
> not reported as they are pinned (from VFIO) add a new flag to track this.

I'm not entirely clear on every detail of this stall feature...

But from a core perspective device fault reporting should only ever be
turned on in the STE/CD if the attached domain->iopf_handler is not NULL.

If it is NULL then any access to a non-present address should trigger
some kind of device error failure automatically.

This is new core functionality since this code would have been
originally written. Now it is all handled transparently by the core
code. The driver should just deliver all fault events to
iommu_report_device_fault() and it will sort it out.

> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8d573d9ca93c..ffa865529d73 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1733,6 +1733,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>  	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
>  	struct iopf_fault fault_evt = { };
>  	struct iommu_fault *flt = &fault_evt.fault;
> +	struct arm_smmu_domain *smmu_domain;
>  
>  	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
>  	case EVT_ID_TRANSLATION_FAULT:
> @@ -1744,10 +1745,6 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>  		return -EOPNOTSUPP;
>  	}
>  
> -	/* Stage-2 is always pinned at the moment */
> -	if (evt[1] & EVTQ_1_S2)
> -		return -EFAULT;
> -

This makes sense at first blush since the domain mode shouldn't define
if events should be processed or not, and the events should be failed
anyhow right? If someone did turn on fault reporting in the STE then
it should always be processed to conclusion.

>  	if (!(evt[1] & EVTQ_1_STALL))
>  		return -EOPNOTSUPP;
>  
> @@ -1782,6 +1779,15 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>  		goto out_unlock;
>  	}
>  
> +	/* It is guaranteed that smmu_domain exists as EVTQ_1_STALL is checked. */
> +	smmu_domain = to_smmu_domain(iommu_get_domain_for_dev(master->dev));

Strongly discouraging drivers from calling iommu_get_domain_for_dev()
in async paths like this. The locking is tricky and the core code does...

> +	/* nesting domain is always pinned at the moment */
> +	if (smmu_domain->enable_nesting) {

This is not necessary - a nesting domain will never have an
iopf_handler set.

It immediately calls iommu_report_device_fault() which will reject it
because of:

	if (!group->attach_handle->domain->iopf_handler)
		goto err_abort;

Which after the rework will end up in find_fault_handler() at the top
of the function:

 https://lore.kernel.org/r/ZrTNGepJXbmfuKBK@google.com

So I think these parts are not necessary.

Though arguably we should be rejecting domains with iopf_handler set
in some of the attach calls..

Jason
