Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6420C001
	for <iommu@lists.linux.dev>; Fri,  1 Aug 2025 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036075; cv=none; b=rSs49nPMgrXkhdIm4b7PeJQM2lNaWGPv+q6ZmG17n4fBt2bht4cH5i3xfAWrHa7UPPohfodOod4exyc6BRCtHGZSkIMsmZ3yJMpr15/te7n9JacHbcojI8RmpfwFdTwn0Rjc6m57lNH39HIzUUgIcKy179MEP5uyCbAh9ZQzPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036075; c=relaxed/simple;
	bh=Hlg/KmabxBdC6Cwqj7rLCxayqHkkN63UORBc1c+3xAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo2sa8DpppU3OB4EAyO9dhqxaPwq2s9u2xVQQhlPQxF8h9JKJYv+Hy8fd+YtI34kPNn7uKJJ9AX2wDawhrzv4Ub/nQltWPCbZrRNMZExrojaC/InycfaNaV0Tew8AJYWUSfPtCN0lzJ1V4O6UQbQuOR08FU3fJ0D0/0EAm6db6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/LDbZZY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/LDbZZY"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-240708ba498so63695ad.1
        for <iommu@lists.linux.dev>; Fri, 01 Aug 2025 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754036073; x=1754640873; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vY5IloWsNQwsLIRSq+Jk0RbLuNAFATBZvlKueff9YnQ=;
        b=r/LDbZZYa0Sh8Q+sKl0+uPi3wEGVV0WpfviJRJ+86v0lebarlbbQH+bXA2UJ6/HXh6
         D0zbY9a00S2f1twxGCkd4Q4j03zglalgVc8N7Eh5F7pQnn5wt1nnGER4KZXNbFzBv5K6
         mUpd6pWiT/jeDtJMPNDWd1zHk+dW3KI9YTgxzZwBu7ft7l1Ulk2FA75ES2fEPQsaDjRa
         D03bC13Ut3q+pqb00gkcLcGSaU9TuRbzR1laP5ujrn2AjvVLRjhU5P3ChQBmMYmzmsr/
         D5/yo0MF/OXxIsbPPvQcd9JzGvYBHy2RM/AnK/cLDd1Z49x6Y7x8njU/9bMuG7YzZsXf
         5fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754036073; x=1754640873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vY5IloWsNQwsLIRSq+Jk0RbLuNAFATBZvlKueff9YnQ=;
        b=w2w/EkLUvE+G9Ja/E1menI7HKe8lYVVth6eHV+i8eo4EPvEJf4ATIkIC11Ns88EGsX
         P+PHwlLf8bWuVyI6ti9lFofzB3neDXZhEFE9jxbe88kH975ZcMFOrtNzPdxlnzy7r4Rh
         oIYxaWWGHuukLM0X4Ce/dfxf9Ctwj8pML3OVTL1A0DJhCxUxvVznENH23dLaP9iYicMD
         iU7Plyjg2UAPZ6FaxjUNDTAX16f7rr3YzSbdxPz5/h5aPfFa0EdOPFOB2f1GgSK+x/F0
         bxnn3vshe/6/g92zS16uT73hUmZsuFOQbm3rI4/eHy5vjXiCThD2qDeaemInMV4cAFpm
         rwOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcul9R0l9G9l3EmM05w+Bq0hbUb54b99kj+XL3bbTNR6QUrSgIsuQustsnUb8LuYfxXC6o/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQTr3dSDgIrnjgtnPJUKzMedPFVXaxuCYh2yKp4qomkvoCCnWJ
	hU4KABa4Z8+LC0ED3nFnvoXNnJdJP0bvvVvAUKemXjGH+xT6T1q9vmFwscMLovRiRw==
X-Gm-Gg: ASbGncvIyfXhiqeD4QpT2MqAyTJYXc7KD2lvXIRVMKMWuqghYp3O4akth+XEpJZh/6W
	UjtZnskuyVedLja0GRDW4CxtuEfenb8FFPBojisL9C1+/d3ehtUzNOgN9QoQZqH36ZI3Sc8vrv8
	No9P+3XxLT+HrBuIBQ48RDZ37XihXNtwVTLqJwaMdBb+asrk63QALML9C/peYMmQGE7iFs0CAjW
	ubjqQFvDQ1jcOyRvtILix4ZB06vrbAc+ek8yMD6wteuLNwEh+/XGCryaaBVw4mhI8p2cZqpR8/0
	EHBwagcsI4DDdKpvwbIMbdyRr9hQ1BPtudRPcdfkpku+Yofi2SNrmIIexDfkr0uWxhf+8WJqBoo
	uoJAzXMvV8lcIeVsIJn7llu6PzMcFN1JmP9fupaYFCFnXcD8R0y2K2WB0
X-Google-Smtp-Source: AGHT+IGXJ0oDUg8x3lalK0qa+IS9YcsVUdYwosMrUSgYdRWE/44m5WMnRi51aRiN1cRnb1G5Gn4Zxw==
X-Received: by 2002:a17:902:d490:b0:240:48f4:40fd with SMTP id d9443c01a7336-2422a435a05mr2506505ad.19.1754036073034;
        Fri, 01 Aug 2025 01:14:33 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1efe8sm36422045ad.69.2025.08.01.01.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:14:32 -0700 (PDT)
Date: Fri, 1 Aug 2025 08:14:27 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Fix smmu_domain->nr_ats_masters
 decrement
Message-ID: <aIx3Y3qIstTceTC0@google.com>
References: <20250801030127.2006979-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801030127.2006979-1-nicolinc@nvidia.com>

On Thu, Jul 31, 2025 at 08:01:27PM -0700, Nicolin Chen wrote:
> The arm_smmu_attach_commit() updates master->ats_enabled before calling
> arm_smmu_remove_master_domain() that is supposed to clean up everything
> in the old domain, including the old domain's nr_ats_masters. So, it is
> supposed to use the old ats_enabled state of the device, not an updated
> state.
> 
> This isn't a problem if switching between two domains where:
>  - old ats_enabled = false; new ats_enabled = false
>  - old ats_enabled = true;  new ats_enabled = true
> but can fail cases where:
>  - old ats_enabled = false; new ats_enabled = true
>    (old domain should keep the counter but incorrectly decreased it)
>  - old ats_enabled = true;  new ats_enabled = false
>    (old domain needed to decrease the counter but incorrectly missed it)
> 
> Update master->ats_enabled after arm_smmu_remove_master_domain() to fix
> this.
> 
> Fixes: 7497f4211f4f ("iommu/arm-smmu-v3: Make changing domains be hitless for ATS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

arm_smmu_remove_master_domain() needs to see the old ats_enabled state
for the cleanup.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 312bc31d7e8eb..3c81139faecae 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2997,9 +2997,9 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
>  		/* ATS is being switched off, invalidate the entire ATC */
>  		arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
>  	}
> -	master->ats_enabled = state->ats_enabled;
>  
>  	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
> +	master->ats_enabled = state->ats_enabled;
>  }
>  
>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> -- 
> 2.43.0
> 
> 
