Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5B45D19F
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988157; cv=none; b=Bxvjo4HwcVDTQFKzDZUbBZOlOmePlLxY25nqZw2xYXbjSzRJN3b7qEiMuFkB5f3NOwHGdFF5ljhIuzUuB3BpuhqKNsSkVlU9YzJAQ+T6kgeGOJ4ALQmxgBE8rfmI6xGzaUzJKOInXnQkK4+15pbJPJDbYcgMg3xRRJKY/NQkRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988157; c=relaxed/simple;
	bh=+e98k4168mAh10/uMiEYObv7JgiKCyhKONJNJqBtoX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsHJ5IIdDwfrXL4w7hCSl71yDG0v4XfG5hPbOIlbM8vwccyLwGbXrn2xIuji+CMKmQi4FBeU2AIxJ18/l6uBODC/CmlcZ/gw8XHhHWCRwUI+DfQoS5K4fmt3Od4BnebzfAfFMSyegZXjvB02lyf5LrnnpSKKRpuXPKZ6Mgp85qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zi4b4KaG; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zi4b4KaG"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f256eaedf8so36726686d6.2
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786988154; x=1787592954; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7xTL49KfLwAq5Qv044eqsaTTNVVybZ9ovZEhY6mKMv0=;
        b=Zi4b4KaGPEO8R3fWN4EuYcbJX/yQyVWxk9BbnlcWy8A5VWNyGMEhd4U+Zwnh+FGjHc
         It5PcAjGmtscuwjkaKZ+Xf1ZTDmRCA626l2soKJbLi+QjvBeVukOqgRy8BZS25bs8q5C
         DBMNSIaKQnzHl5LsnnZoYz8sBInlZtO8AFtfFLW3BjAYYl/2hbYI+jnwtA2tSshp71uh
         MlabMzokSXyaRUF7SE4UOai8Q+ovQJAqy4ug+0H6GyFKHfJ6cz1VUO6QRoAyVZrCUg4O
         gUmppOW9kL3CBa1a8Jz07lWRaGHT3gFJXIATFd88MbqnlL3lQDQrRVVVuBZA0e0rAdWy
         r3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786988154; x=1787592954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xTL49KfLwAq5Qv044eqsaTTNVVybZ9ovZEhY6mKMv0=;
        b=eX0dpdswt83CQ0IdgXUtwhEayn1tm2DzqpTc0YilTfhrVO2HEbc2RWHpBTD8nSyZpc
         5Y6g25K72YqXMtCygMDjiZzWaJxd131cbg9BeBtoNjmnhQO7zSz2QY2qmHJFmea/pRRv
         jicgwH6Qk5rIahVGa+9lZESusQ9yoNwSWyEWKqmU07ci9TvAaDl/i2kZRLi6WpCqtcoD
         KPmJ6NNhJHlpzpy9S7Z+JJvXNvNBGWyx7E0jtDniSW0+U3PNxW9MoLLpcajuAnafbmRz
         mMBftvd+SdjSIEmzZhfJ/Xo3mr4MkK5lkbnSGkNWo+GrG4TyLIoSZJoMNv8Ari1F7UYQ
         45Jg==
X-Forwarded-Encrypted: i=1; AHgh+RopACsAvjglxB8z0emhnj9DwH7Bc7IOLa9hp9LlOOyqXtRmfV8OGsaCRGEEbs8YCDIsL0q2+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTg9hyUreUOPxK90jHxcf7mipImNVzYEsPVqtBC0CX+JdHbtmr
	oOs6AL/k/1Lu8Vfq2Htnm51Z+S1ouLDnRxwQAiuo7RU0T7KPd3q8kJuZaFN1FProAak=
X-Gm-Gg: AR+sD12/ugxSFX3UgJJajerBHsRBIBMhPQ5S5cYx3qeodm04SucTjPTiI91jRqkNC30
	WiuxlvObhn+Hz2zNyR3XlmbjqnNlNMY9MSfQgkQRrXKun5DoFIqhLijbLEOeErUCWFdV9xeurSw
	AmlHl9jOPvt+x3AnQzYlXzY7UKvo3AjPEWD3HaNCQuhR7198d6kTsUPvCRgWlu8p2qIuS61MRFX
	NKt5nsdjPHcqoYwjiBPHgRveqzfrGMrF3fZhFSHPGeD9u63oxMpWJVZo2QaBsY70hgWeum4wphg
	aZ5y5fXZZPTgk2NcTz3ki8xp06/EasNIRmeTGZumlilTgOwJ32sVT11qH5y1vXbqs2pZY2Y9YH2
	wUSCIc+WplSoGoNswu+VZCZDG7yOKesvZwpjxmxAQ5CW/LF8gOUjCEwG48WMqxEuFwYj3YH0pa/
	BeT4zMei643ke0rBkdNQJfhYooilG0khw+8C2GoQ==
X-Received: by 2002:a05:6214:e6e:b0:907:bf7a:9771 with SMTP id 6a1803df08f44-90a91def3cdmr277120766d6.21.1786988154391;
        Mon, 17 Aug 2026 10:35:54 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4580f90csm13765356d6.9.2026.08.17.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:35:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ww1FY-00000006A9C-3bVH;
	Mon, 17 Aug 2026 14:35:52 -0300
Date: Mon, 17 Aug 2026 14:35:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260817173552.GA1418894@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
 <20260813224627.GA933791@ziepe.ca>
 <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>
 <20260817122216.GD933791@ziepe.ca>
 <gk7lcfk73uzntmnmf7eb5clp2h7q7oqb7lykj2qlrrkilotfvx@mf6wima2kibk>
 <aiioa6ospojivued3djhwadyfpit5temyvrgm3xxzhzt6aqbiv@hqz6q5bqnl6w>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiioa6ospojivued3djhwadyfpit5temyvrgm3xxzhzt6aqbiv@hqz6q5bqnl6w>

On Tue, Aug 18, 2026 at 01:22:03AM +0800, Yu Zhang wrote:

> So we could
> - either keep the duplicate check in hv_iommu_blocking_attach_dev();
> - or add code in our common helper, hv_iommu_attach_dev(), to treat
>   HV_STATUS_DEVICE_ALREADY_IN_DOMAIN also as successful explicitly. 
> 
> And since normal paging-domain attaches do not have this duplicate
> case, I'd prefer the first choice, to keep current check in
> hv_iommu_blocking_attach_dev().

I think everything can technically be re-attached and must not fail,
you have to handle that possibility everywhere.

So accepting that code as success seems like it might be needed anyhow?

Jason
