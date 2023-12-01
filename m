Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0E33E48D
	for <iommu@lists.linux.dev>; Fri,  1 Dec 2023 14:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GWlZlHR+"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7788ebea620so110691385a.3
        for <iommu@lists.linux.dev>; Fri, 01 Dec 2023 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701441491; x=1702046291; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXr7TXa/tMpuDEqpeATCPHGX6v9H50ZNaBHg4Hp0sUA=;
        b=GWlZlHR+dX2eJV8hHndPqMypMFmTYXP9AaQXwMqe4qOlRj1TSKSkRcX/GvriyJqPJY
         co88r2Qd++W9+5xbxMB9Qgs2zQ1cIvuYbz7iN/Is1jwsOLJXc65Kjgkqv/HcKb6+1+S5
         vb0ls0+0BvI/jSss4In+tc1TyQMo5dVOcf6e9e94HSypM+PBYQa47zM6uhIaL1JCAWyw
         Sb3U8RBDawXu1sJyvUoQklgJzM2oCLPSFSd1jWCaw1BeiYKfoWgoUIgYjOgLuuzJ6Yf4
         MoBs9WrsRAbBaXRWBrRP2vYvjpnBj3g3vRkRFmFPm2p2qml6aeLV7FgaHuxBITYtTtdC
         sULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441491; x=1702046291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXr7TXa/tMpuDEqpeATCPHGX6v9H50ZNaBHg4Hp0sUA=;
        b=gn+LzlQNvO7PuiGfqMkgA8xVKZmM0//GGzh/PqkisBPr1SXTkRGAH1OYLSo81X6Xuo
         O9Nql+feTqBlajI0l88kAsNpbOpC1lVyBT9O7Pyj+KUN9kPiL7w7H5eqrojeVIWkj9Yl
         Unsm6y7k4gxrExH4Ws0/IQ2ZBfoZqU2HLQFfmFZDs0DyNhl+QXcKoJ7KP4athKwt+Wrv
         ei+T/X0v0szW1vGv93Dx+gJQGAi/fwzyije2hg51zjQ6gYLgD8IA8EZ++rSk2Ez0RtR5
         RTkE4gjiv6AQd5D6L4IeXDGmwlDiD34/Pw//s8L9NyGHAQAispcel4Q+1uj6HLB7mcDu
         nfdg==
X-Gm-Message-State: AOJu0YyVF+gD9hq1haUpd7pDeWXl5zK8jKMc3qEP/fyo8mj27gQlOVOc
	gULR1vBKq/K7JSr/Tm/YpY868tY38w0eXyEeDBo=
X-Google-Smtp-Source: AGHT+IFe8E0VqRO1AEaToLaRVQzH95JILmWc2UsaE9FahWhPD0VYJtmSp9BHS2kePetr70qtmP4TFw==
X-Received: by 2002:a05:620a:c0d:b0:778:ba89:2fbd with SMTP id l13-20020a05620a0c0d00b00778ba892fbdmr22271407qki.36.1701441491386;
        Fri, 01 Dec 2023 06:38:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a110100b0077dd463da60sm1533049qkk.126.2023.12.01.06.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:38:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r94eg-006FYA-Dl;
	Fri, 01 Dec 2023 10:38:10 -0400
Date: Fri, 1 Dec 2023 10:38:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iommu: Add iommu page fault cookie helpers
Message-ID: <20231201143810.GK1394392@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-2-baolu.lu@linux.intel.com>

On Thu, Oct 26, 2023 at 10:49:25AM +0800, Lu Baolu wrote:

> +void *iopf_pasid_cookie_get(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
> +	void *curr;
> +
> +	if (!iopf_param)
> +		return ERR_PTR(-ENODEV);
> +
> +	xa_lock(&iopf_param->pasid_cookie);
> +	curr = xa_load(&iopf_param->pasid_cookie, pasid);
> +	xa_unlock(&iopf_param->pasid_cookie);

No need for this locking, the caller has to provide some kind of
locking to protect the returned pointer.

I'm not sure how this can work really..

What iommfd wants is to increment the device object refcount under
this xa_lock.

I'm not sure this is the right arrangement: Basically you want to
have a cookie per domain attachment for iopf domains that is forwarded
to the handler.

So maybe this entire thing is not quite right, instead of having a
generic iopf attached to the domain the iopf should be supplied at
domain attach time? Something like:

iommu_domain_attach_iopf(struct iommu_domain *, struct device *,
                         ioasid_t pasid, struct iopf *, void *cookie);

The per-attach cookie would be passed to the iopf function
automatically by the infrastructure.

Detach would have the necessary locking to ensure that no handler is
running across detach

Then the cookie is logically placed in the API and properly protected
with natural locking we already need.

Jason
