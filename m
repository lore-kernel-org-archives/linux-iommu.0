Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5E215191
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113979; cv=none; b=GVLoBnJGmfAJI0j/CYv4/v8nOAYW58XE03j53V9a9+CZHOPOhWETJhPw+PCiJc19oAzDr11C4BtO1JNg6iuf1kVZoX6a8l1Dlg8hIYLGZ9gUwaVUJ2wM7GBLmUTQikfsS6eQRtmlvhKh9c1aIHSALFQI8kbaEwM5NblKX8L7lVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113979; c=relaxed/simple;
	bh=KrYOke53fZhaOdyqNU6WsSDo4eyk49qxBayckScAUt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLcgEkQsnbtFsAU0kmYnjwxFbMwUvZFWbFbhNAPQgtbl1/vO1Obev20509BxbP8BZfa1JJWdTai7UK+dZT4himF7x0A3qnb5d2LcpOVMVC6+B6GRNNLoNf/q61ao3mJMvqpJq3sMklHa/ESHcEXw698iN60saXTeCZjJSTnjFWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QxoK/Uvx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QxoK/Uvx"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235ca5eba8cso64865ad.0
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750113977; x=1750718777; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L4d+8ZjXH9zZ77lKYUp6/tF7Z8I85twtKvurv24F7nU=;
        b=QxoK/UvxOT6imK+6/EzR8YHqlT2ps2yCkwA2nvTl1aqUHiYpgJP5+YhL2OprVZvd0n
         2TTzEhLfHG3ESfVpkZvqWpZnp1BvyMOEQ/mr51+HXk33bCdgelgJSDM0LWzg2uZbx5Ab
         j7nToh27t3WMJplVwLy69l9XRT1GHlztYJazvHDC35F+BnVAxQb8ILbjAQ1mxW1kaLIw
         641gufy5F5bakIAXoAoRaPe0PGoowJ0ShYrJS1vd/BUkqKAj3/6lG3CdidVZjD2YEilw
         QNACwf1MW2+ygkfyRgB775ZI3fNpCoEhPT4cTlLTjT6A+9fmZ9MKt5+x2+7TwEEvHro5
         fX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750113977; x=1750718777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4d+8ZjXH9zZ77lKYUp6/tF7Z8I85twtKvurv24F7nU=;
        b=OqMMxr7lD8NH0hAnnxOUs8uAy35Mv2ARBVFIbEem8qZGn+HIve57SLkL6SkuuBcgm3
         sL3i83xo4dty+uV4uhV0IdMANgqTzEGae7MwzQGGwtlq9rN52sGUAtSKrmzrwJ/sTyPE
         ed0FRi6BhnIZE3TPRRYaOMFJwSgD83jE5QbSX13KrYQ+WeHQOcBp6V0Cj0eSizNW0cI9
         8MWgjy/9HkhGWbvDYqU3x4F1zCkByLtwzGNzekeDuuWU55cdTdlDR19j50965U1oPgA4
         dk3HjI16iK+jO456oa1GsPZtyOzJZUW6jDn6cS2Jbo3SN2LF2MLwWLYTM/d9N/Oapn5u
         RJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxxKjYUYeIEeEX9WyiDhVxyisfckTGhZ8d+fJy+4klgWf2wekGrBZJsnEj9hvFgXmB8+8QMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzr9lVeiAVnuk/XZgIfhS/k+n9MX2tqSzX75n2WxqldiDEELJJj
	6zGrPU8Wb5gzfq80Yiem5EEGPehDAFxvh5l8ZNZSd7M6Lts9IeBZtuZ7G7qut7GJuw==
X-Gm-Gg: ASbGnctBFWrWc3bU8H0nld3u77KkyEKJyZXvdwrxFG4vryGGdaDlDWotS9OU1A9glLo
	aSw+88REEusy31/Juz6XHVVhnUZrJDYU4hQrvWYZHsMl9KXKmpKZgp3oH/eHTCxaOHL4CbLDSwW
	LCSlDvvw8tkf6Te/0ibyY3RIoM6CAvgbOMJ2pLRxEaDKF6A9FPQ4NZKhyYIdwynrqscQGV2vXoB
	X7hBZpYqaDDcE/SoyYaaEZa9n9x+62NbuxLPd5syax0t+zA9UdfSdGmCbha8peo3exSi8bKYi4M
	HUw6bwb6P6bjwE2bqyjFqaTfNcHi6LTxVINnkpVtXQrO0iBWPWhIAExXrhsWKz4Ob2ujmH8D2cQ
	+jBM25XjsAJjGBpI9MhrV
X-Google-Smtp-Source: AGHT+IHbp2l3BN8cw3PKIKwKBRH+mwq9oeWC2v6BaROwnYe7V6Peft6fYvtgkHe+hYIr4hoxzIvQpg==
X-Received: by 2002:a17:903:b45:b0:234:b2bf:e67f with SMTP id d9443c01a7336-2366eef0269mr5944675ad.9.1750113976583;
        Mon, 16 Jun 2025 15:46:16 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890082a7esm7656250b3a.100.2025.06.16.15.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 15:46:16 -0700 (PDT)
Date: Mon, 16 Jun 2025 22:46:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, yi.l.liu@intel.com,
	peterz@infradead.org, jsnitsel@redhat.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 11/14] iommu: Deprecate viommu_alloc op
Message-ID: <aFCerw6zMXkyYKax@google.com>
References: <cover.1749882255.git.nicolinc@nvidia.com>
 <5b32d4499d7ed02a63e57a293c11b642d226ef8d.1749882255.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b32d4499d7ed02a63e57a293c11b642d226ef8d.1749882255.git.nicolinc@nvidia.com>

On Fri, Jun 13, 2025 at 11:35:23PM -0700, Nicolin Chen wrote:
> To ease the for-driver iommufd APIs, get_viommu_size and viommu_init ops
> are introduced. Now, those existing vIOMMU supported drivers implemented
> these two ops, replacing the viommu_alloc one. So, there is no use of it.
> 
> Remove it from the headers and the viommu core.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h          | 11 -----------
>  include/linux/iommufd.h        | 18 ------------------
>  drivers/iommu/iommufd/viommu.c | 20 +++++---------------
>  3 files changed, 5 insertions(+), 44 deletions(-)
> 

Much cleaner now IMO.
Reviewed-by: Pranjal Shrivastava <praan@google.com>
