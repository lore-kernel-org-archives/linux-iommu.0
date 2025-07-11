Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B58D1FECB4
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222437; cv=none; b=B9zuXRkz8c3iE1sPQPfPGLXQnEKxroFJojwGOsS+P3UTbOoYoZgyuK7bMbZ8BUJ81l0m+/L/Wp7ENnwJ+oWJEO2in2Zb9W7ujUuVn5I6o1Zbo45yrC+eKrfR4UovKFUwa8FDjXcnpZoMp67hdhU/8Jk2qkPsZ3xjk71PCNepkMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222437; c=relaxed/simple;
	bh=frSrt/16VypNMrhlklfbIhGb02n3jTIlRwU6eokGfkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFafhIKDdY4QD5Zd8eFLfRx6VQUcnO9jBZYjDxvhYZwYTD2IN284d0B+fQjPDqxMyG/dBb3kwY2Mrx/1wMqJ1Vw1h50OWMvyS6eZWGqiD0jp81MSHu9p9dqxe2YL3dBA2/whSKkfuhLTjCoAvoU5ADcqJ/CtuWD3UuWUpi6Y6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y09pysaZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y09pysaZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2357c61cda7so86935ad.1
        for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752222435; x=1752827235; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3wb1oowbSA1sVzCsjHghmLIDKPJGVzvuDr0F84v8tpM=;
        b=y09pysaZu1T2EnBpodGmlaCP4nfFwmk87R0ODFfF53R8T6PM4MXrI79nZASiogxV37
         08LKsCnO7GmJ4vM4J8rpd5J5t4t+LnhUbM5gXUySOxoEdK7ZQhN+LvqtB3E6ZoFqqu3L
         9xESe1RTk4S3j29dgezbWAkwUC/w4RHWit9ybWDfFejfwPA4xZsZueiOzCnjGtGSYFmo
         6CXI5yRqqxy/i8ca4ELZtdObmnkdl/fdDqCHqMtmmkxjmNa6gic211sJEb5hMaOo/Qdz
         IdwswP0pO1cg8O/YMkuJnjUPqhRxyMd2djcewxDyeiX1WIxA/yzFtZAH7mvkgvrmoL7t
         jnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752222435; x=1752827235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wb1oowbSA1sVzCsjHghmLIDKPJGVzvuDr0F84v8tpM=;
        b=Y5mOQsstDZr4K4jPlPzZxd5U+YyKXzxaLmnrFfvektQVVfcEdwm6fysD5zgEbVbeJi
         gQ6CX43G0JG+kw16LbRkMieYxPjIHJRqa9oPxviE3EsB8Ts4q52YwGao8fZgl/p997aK
         23A2bui2NScsAhlBKdBEVv8zN/0xcay6fHaou4lCY2Zd7Yu3L0hqcfG8yiOI2vPfoc6S
         8tw9pRIixX6XABaIcX+kaZv9QbjuK2tp07O91pxw9j9gxP5pJrkYKoqokENPGaILXJYJ
         Gt4/aQ8TTKUWv+Si7vK0Maj2C1mF8MAbV7JIVwnNmzss5OT/rY5mXypUqAv6Milr0A1Q
         67iA==
X-Forwarded-Encrypted: i=1; AJvYcCXc811N2EbvRNq5hkgaRcL9Q9/2fjt5Azqk9JEGIRxhTnxr4R/yJ6u42N0ju4+DXJewAvRGkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZTmYAdJa7zm67QUrW9WalYFLbRiHjCWlfVC05mK4N1UW5t40q
	Toq0VhQk0WoahE/vPBgRgJ6Fh29l/d4ToiHW9k98TeV3McA0DP+ZP25N1EUK49KK76tASO+n8r0
	JTmEPvg==
X-Gm-Gg: ASbGncu9/iQA9ZuerfL/TYxs3lMwBPzphkXajcFrwy4eJlG6qRaZq93fQFoEbXBTN5g
	UUbjMrRrCODDsjJ6QYXHPlNZ6AgMEhgF2biJJzW5ZWWiBl5XVWaFUMYvRoRETEzZUsv9t2F6E4B
	ueFpy3sWZRYNu9e08syaN7Jl/O7zYR5IRC7SaYNl2GrbDVOjfWEXv/WQwJWuEHRc4P5tcVP50Pg
	wPCmN12mZ220HQe6csCI8IQs+Qm9YSIGf5yDOiPyC8qN+O1EsOTVS5emQS/BJI28XS7dAhoj+F6
	SaBnsLeea6j6CQy92JTC/xFuc7HaKoUkuvOr7FRcbh7D6Rlxkw5lFo+y+x/juUng4qPexT0LVrR
	kxORp2ghv77soGsLkxRXKNhFuC0tVDnkFPe6PgImWcBM0G6zUu0iVtXsA
X-Google-Smtp-Source: AGHT+IGeQ9pS0bpSEY5lDbAotdJ5VOyrB44rPnDqbo9ssdh5gUYxMq4qPQG8JgMf7SMyjdyq4iZMZg==
X-Received: by 2002:a17:903:2b0b:b0:237:ef9c:ffd9 with SMTP id d9443c01a7336-23dee1c636bmr2323505ad.2.1752222434466;
        Fri, 11 Jul 2025 01:27:14 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aefe2sm42788465ad.65.2025.07.11.01.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:27:13 -0700 (PDT)
Date: Fri, 11 Jul 2025 08:27:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Revert vmaster in the error path
Message-ID: <aHDK3PIpwWvkwJtB@google.com>
References: <20250710233003.1662029-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710233003.1662029-1-nicolinc@nvidia.com>

On Thu, Jul 10, 2025 at 04:30:03PM -0700, Nicolin Chen wrote:
> The error path in the arm_smmu_attach_prepare() was introduced with the
> arm_smmu_enable_iopf(). Due to a rebase issue, it forgot to include the
> revert of the vmaster.
> 
> Move kfree(state->vmaster) to the error path, to prevent memory leak.
> 
> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domain attach path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks!
Praan

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 181d07bc1a9d..3c79cdbbd9e7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2906,8 +2906,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  
>  		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
>  		if (!master_domain) {
> -			kfree(state->vmaster);
> -			return -ENOMEM;
> +			ret = -ENOMEM;
> +			goto err_free_vmaster;
>  		}
>  		master_domain->domain = new_domain;
>  		master_domain->master = master;
> @@ -2941,7 +2941,6 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  		    !arm_smmu_master_canwbs(master)) {
>  			spin_unlock_irqrestore(&smmu_domain->devices_lock,
>  					       flags);
> -			kfree(state->vmaster);
>  			ret = -EINVAL;
>  			goto err_iopf;
>  		}
> @@ -2967,6 +2966,8 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  	arm_smmu_disable_iopf(master, master_domain);
>  err_free_master_domain:
>  	kfree(master_domain);
> +err_free_vmaster:
> +	kfree(state->vmaster);
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 
> 
