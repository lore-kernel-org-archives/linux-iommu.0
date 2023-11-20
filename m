Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58641BDF4
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E406WB+y"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58cdc801f69so120675eaf.3
        for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 06:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700489256; x=1701094056; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=92tZ6SZMCW6Rm9Jpds4d9aM0YVAWPI0Lxc7DBxrVWsM=;
        b=E406WB+yu2lU9Bq6ZPsCgqV/CQXPAHk2vYoDRI5wPwERxSJp6/c7nnxfA4c2jZU28R
         PFWCKeMxqNkw3Ed3R8bCUaO5mvn7ORIziWnQ7IaUQkNw5OZvO6M/dfy4m4z7jyVa9vcA
         HRM2fA4NbJ1GXVZwQbpnqkZiiC4D+Tobmkbv4qvfJienbY7MyILXBtftb0ndfVraGqVU
         qasZA11dZ1rIG1Af49l9X2B8SvEIGLe2OGFKLO6Kg2sv/3P8ReLKI8T50V+p+XLKumwa
         25eCO4DIKd0kJWWRO9Nebe21mFvwYmMzyV/dAVTumZxho+7yNNTOPKUQBoBLHfmY4UYk
         ld/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700489256; x=1701094056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92tZ6SZMCW6Rm9Jpds4d9aM0YVAWPI0Lxc7DBxrVWsM=;
        b=VVELNNYgLoI5gSFqrieERsGKqsHH5f/JF+C1tOH00uXxVlv/b/Chc3s8fiz0Tfzsq0
         rSUnf5SerLb3afDXVaKsY6DpV3xiOekHmTQEOJFraUifYDI5+Dm5f16bvbAQeE3QbNIx
         4jyulXmqYBME3guduLxlIMZUUHSHJyzaqUN7MDeZ9o+goEhQDm88uTORkNjkYDARrJLL
         ZZYDt4bKau+x/+YUx68Eenmz1BTT3V924DxNuIqUgn8NH4vSyDfZL55ElufurZUxjhqx
         NK6ejWpZfybO0XT9Lxa5H4mmqNMV0kXsFPCdxyLQxwEnmnqDFuubhj/aL2LeLRLNRyNV
         h5PQ==
X-Gm-Message-State: AOJu0Yz3ziUyLwswXkbPi5Ubt5GoeqWSdSDXmP28obeSoZRwV4hSshyr
	c8d3XAO+g8o6SZhk1dK5c40/7Q==
X-Google-Smtp-Source: AGHT+IH6nCadtndcP8MoadqJOEI1uE2x4sdLOvyEq8pu1hVPGC0TaARjdXuTNslbQyHvhistT7ejrg==
X-Received: by 2002:a05:6820:81f:b0:589:f58f:8641 with SMTP id bg31-20020a056820081f00b00589f58f8641mr8070209oob.2.1700489255838;
        Mon, 20 Nov 2023 06:07:35 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id e189-20020a4a55c6000000b00586c4324f5dsm1460999oob.35.2023.11.20.06.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 06:07:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r54w2-000Hy2-EB;
	Mon, 20 Nov 2023 10:07:34 -0400
Date: Mon, 20 Nov 2023 10:07:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, kunwu.chan@hotmail.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Set variable intel_dirty_ops to static
Message-ID: <20231120140734.GC10140@ziepe.ca>
References: <20231120101025.1103404-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120101025.1103404-1-chentao@kylinos.cn>

On Mon, Nov 20, 2023 at 06:10:25PM +0800, Kunwu Chan wrote:
> Fix the followng warning:
> drivers/iommu/intel/iommu.c:302:30: warning: symbol
>  'intel_dirty_ops' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  drivers/iommu/intel/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
