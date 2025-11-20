Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB38393DCD
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763659272; cv=none; b=j6eeXn0voUX2cJyh7PMIcq5/J6VyCUZtnFd+DQjekvHQss5irMn2YJhlq4JjVeHxQdpAupHQjNKz5aEU8LeQKqoAvt47yNl5wDKuHLhOnYlkW/ME7XLnKOstGDtszVXkIlkY//vMhNDKUyc/c51sWqajDMM52IlfIZzFPxKrUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763659272; c=relaxed/simple;
	bh=ntvfmH0IL6LFDQipCfZjpKFtccePXmZHFCQ/8ZR6Mp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmVSjVMz3zYbZm/XbhQrE+zgjHZk0dZTQ+yk2zMyZc0PjuF4S9frhWgp/dduNPitSKr6UNV1MIq136wa/KxS4zi/m8oa929H7TIKBcHS2PzbAr3zMcdJjW90oe/aQleyioHZgx3y8kFHN8gyAcNMAxCERONdplHc9SJei+37wkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NE3YJVAW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NE3YJVAW"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee2014c228so8876331cf.2
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 09:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763659269; x=1764264069; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUzGjoXB05ZMohyTHrUFBCoWhBluIMK5wztNDve5nnE=;
        b=NE3YJVAW+nUMV2vCgfs9Og5G+HYIM4/ar7ALo5BqGcgbQ5Q2SiVGtt3toO1SOIKOwL
         aoR4ESxwVNB4tVWZMHvH3MrVzzCZU1qJAq5ryx2a6mJkw8y3+3/2H/ae43bzHgt9hpYG
         EgbG6KBBfQxCbQTUHtLUhqHiXzec5vwv+YOqMBQgyMvynfic6da5l7tS/M1R4YKHpb2P
         KiBwByaULyxjRubMmf/NCwQJTxtcAzOl0o4c/cU4gzwPOgWjGMU1BGUSOg70FKBj219a
         IqOx07pmElJ5nRZS4Eo+NPbl2/Xc4LGhIalPcgc5WbhECmPzxXhpLgzZUmCmhto3C4dU
         +nrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763659269; x=1764264069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUzGjoXB05ZMohyTHrUFBCoWhBluIMK5wztNDve5nnE=;
        b=szwOYWoJRiB3j4aZWKq8MQmnR36at9Z0OF8oL2zzvHbKp6lcS8sncB6Hxn85NYG8X6
         FufVOW7z2v3NI0/QGOXcRTu5vetSZI1BKjogJTb/9wkbXti1CP8w1/hTvsrHEbLXjevL
         IT/9d5ed00xhsV5SJaIH++1pufw98/whTydtjwdMOMU2/Tu6e4sIOJOENdWrHCJRdeIO
         v3eCxWdaazo/4i4Ol8i7tjqN57mopu/fX+FLpBabuiuSJv5O4MqFbP0Itf+2h1A10hBQ
         QPPFVA3qE5HsDee+MRZu7WMEqFYUzPa3JtD+rjdoAlzBIQLchFkNcEcD8j4Fzdj/xnOo
         4Rfw==
X-Gm-Message-State: AOJu0YyFi08YMSWcmlzDwxPMPfIksVQ2GW102Wo7wJ3+vcn9pMCqxY5V
	ADcwio3hX65HZ59Gri2rx3XOO7rKumVTnEUkyyJNYrgiJ3B/e5ThsJatd517jXj7EcZQnsOsNOM
	T8JRO
X-Gm-Gg: ASbGncutMd6dYeeq3gE2isbjSZlqeO+/9gFn2n7O2H5fULuhNe7KBlKk37Ag8xtGX0Q
	E1o2+GgzcsNi0sR7gIS5iJgCedW/bSYcN50vqpA7cqK07aC6a/fO7rKum7pCQIxNROaPt622UAB
	aEGOcxfxZd5yYXeCoC8vXgtFQ1EET6VqoACnpWX1ilP+ljIewVrKwZWSB3AMnm892qz0rcE1FiL
	Z5Ql3wAjVhry3k8CVyP+NE4mrS10NiXZ96YIjL35CGF/O3QhBulDdS7mh3jgapK5Q4kuiowANYS
	BgAy6mMYapuwa+GhNHjtPYuyMu7vNSXZmpmVucuzohO4wPplzDX31vBqEXXRdijwcVH8KMrMDX/
	kufoW+RuhBM/YpWuNVUauAVZmJ2G8F8x68xZngBGKb2kds+Xz1dliz8o8PXsFalGvfFrpXgbS5z
	rFgLmYjBL2Uw2k3ByWKpHLk43lftZNSDu9M7Imjs7CMqUDlXiJOW7n6af9
X-Google-Smtp-Source: AGHT+IE7N43csbO43IPVF5qn1c9L3r5RS93fBME2/qsBruLh/ZkEPq+XLLwuLMLoH2C2JoQQWE465g==
X-Received: by 2002:a05:622a:242:b0:4ed:a744:adc with SMTP id d75a77b69052e-4ee493fe3c1mr40451991cf.10.1763659268927;
        Thu, 20 Nov 2025 09:21:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e46a0a9sm21745256d6.17.2025.11.20.09.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 09:21:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vM8LD-000000012YG-3pLW;
	Thu, 20 Nov 2025 13:21:07 -0400
Date: Thu, 20 Nov 2025 13:21:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: iommu@lists.linux.dev
Subject: Re: [bug report] iommupt: Add map_pages op
Message-ID: <20251120172107.GA233636@ziepe.ca>
References: <aRwgNW9PiW2j-Qwo@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRwgNW9PiW2j-Qwo@stanley.mountain>

On Tue, Nov 18, 2025 at 10:28:53AM +0300, Dan Carpenter wrote:
> Hello Jason Gunthorpe,
> 
> Commit dcd6a011a8d5 ("iommupt: Add map_pages op") from Nov 4, 2025
> (linux-next), leads to the following Smatch static checker warning:
> 
> 	drivers/iommu/generic_pt/fmt/../iommu_pt.h:752 increase_top()
> 	error: uninitialized symbol 'new_level'.
> 
> drivers/iommu/generic_pt/fmt/../iommu_pt.h
>     665 static int increase_top(struct pt_iommu *iommu_table, struct pt_range *range,
>     666                         struct pt_iommu_map_args *map)
>     667 {
>     668         struct iommu_pages_list free_list = IOMMU_PAGES_LIST_INIT(free_list);
>     669         struct pt_common *common = common_from_iommu(iommu_table);
>     670         uintptr_t top_of_table = READ_ONCE(common->top_of_table);
>     671         uintptr_t new_top_of_table = top_of_table;
>     672         struct pt_table_p *table_mem;
>     673         unsigned int new_level;
>     674         spinlock_t *domain_lock;
>     675         unsigned long flags;
>     676         int ret;
>     677 
>     678         while (true) {
>     679                 struct pt_range top_range =
>     680                         _pt_top_range(common, new_top_of_table);
>     681                 struct pt_state pts = pt_init_top(&top_range);
>     682 
>     683                 top_range.va = range->va;
>     684                 top_range.last_va = range->last_va;
>     685 
>     686                 if (!pt_check_range(&top_range) && map->leaf_level <= pts.level)
>     687                         break;
> 
> Smatch worries that we could break on the first iteration.  I don't
> know if that's possible.

Hmm, I wanted to say it can't because of the caller, but the locking
doesn't work like that, so yeah this is a bug. I will make a patch

Jason
