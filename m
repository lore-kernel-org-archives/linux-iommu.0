Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC2824C07D
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195751; cv=none; b=P7RxfCPllF+YL8JQAtgyti+jhQFlOWIZbujMEXgnJq4m7AEcu+s4xId3sGAztNk7pUNDdOijzYd0zWUKGQsDcwcDYtefDv7Qx1aHUl+zUOtHYnSYWFmd0An0cx5x4gkegyou67oid6KJI12JXZ7jTjWPLxnxfBiLvenqmQ0fU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195751; c=relaxed/simple;
	bh=B1wNsGRlbNuh23FquOiVRPjfZ7QTWBC3oKDQKjyCdJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYtZK9BmSYLJfNzH3ga82wvRd3sRrQsVSLyLb0AZD3rKc2lHIR6Kf3x3GyUXkCkDYFrrwiQlk23SUGl3mtWUslGm2yKyQ73wG6psdLmyMuw9m5bp4CA2WkpLpdbOtM1UF2yLH977srOgKGXH8ec+hVvduYiho08loRrq1fBnpoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SSaeIXgE; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SSaeIXgE"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8e8da098eso7532136d6.3
        for <iommu@lists.linux.dev>; Wed, 05 Mar 2025 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741195748; x=1741800548; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c907La5P+bJluU/LHcR6Es6yd6jk3jgKb5ChVAM4Ut4=;
        b=SSaeIXgE/v6hKCvfl+8b7lSqrZfT03kOvst7/qvAD34+KC8y6CINl/u/C1a6HMUKKi
         Mg6z87U1eDEOB/pFymsUWoq9YucgjPSqYx7fvqwEQcNlTnwoECjOZ4TG7Nw2BLcPxu5y
         IVPCtVByMgpSqUm3xbmy3hUTZlEXBlcGKGfEFMTKLsTWMMNzNjqNq7CLV8k1+fJL1dlM
         lKhrj2wBN6VHePtXHRzfF6rDxM0QZBSMl1KjFfFjcvai4WMQUGrn3ONs6sMaIc3/EEVQ
         4HlrNBZ1zMaWdmlDh5+7ecAmou/BaBYJzu9J8jCi7I4303skVs6VPKZ9ar+Ap4GFgMNz
         Ze0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741195748; x=1741800548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c907La5P+bJluU/LHcR6Es6yd6jk3jgKb5ChVAM4Ut4=;
        b=Dg/dnBx+xdqd1epBzKPItzAmtWQPPHotA3lvGav+BP8/mcCnbTZEWO63U4AVpHFEg2
         2jEn8fWlnUkSXFvnIVxoBr2uLVAxm3TedgKX+W6RSnbyI3475jv6N87DTIAovm8i0+se
         TJPGvHniPhA7B2AKorPkGwTUSUrWXkc4lA3usouiR4vkN91gcgPOSC+QeSOnCXbjLlrC
         5EwtsW46cwzYsjG66GBXGGFZbl1P6VMrsuKG56qjPn+VssSVBJC4KL39haxEYQZLSKAx
         QvHRljiuWp1UHnctELJpT6W+8oEDiR7IuVkDHInnQJZ9ArYM/jNmiArFQnJB3AkKxk9E
         GpcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8r1kVfhMuiRLan7+Ww2EgWdeqlLz4zeSBunZ2cF1bJcHAb/17mBKT1iTZKuJKeHXqb5wlGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2ypD8frUVrsMqwayebLrrzg+i01EvIerHStiqL11amafH6AhB
	HeSqvoxerde3AGSLKc/45NgKmHSO242JjM5FA8+ZfYTg/WuXM8X8hBqFID7ZKQE=
X-Gm-Gg: ASbGnctrRwPpdygSi7Okhn9+xktXChDkJZQFIGC+pr4ViGQo+tiC5OOXR2MRV/lLwEl
	vDehCqkW1M0BeBerBrY2+kL3FKvRy7XQDjo4XaX0tBmk26KL8sQEukG8bDOfYjweN3QBJlTX8ID
	vSQV0YB2dP5iiO7fTbAkp+t5QQ82PWqiFo2MfBCGIlsHltsCH9vhBH3xY0Cu6Dl3gYLFiDhUXbH
	THY69A3UgwWQYLcZ0iRJlGgd4ei7tTxfc252EVY3D/B2yxiAtJ+EPZ4ljErAi3pyhCYtO6thpPS
	PN3ub9s0eggAQE0TinY=
X-Google-Smtp-Source: AGHT+IF4HNniD3vBEgV7Gc4XgcYAVaPywo5omCnN6AqAFGgL1Wjv+qwspVU+lTzqtNoHgcoOul5LVg==
X-Received: by 2002:a05:6214:2525:b0:6e1:6c94:b5c5 with SMTP id 6a1803df08f44-6e8e6d144c4mr53580176d6.4.1741195748275;
        Wed, 05 Mar 2025 09:29:08 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89765364esm81249136d6.35.2025.03.05.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:29:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpsYM-00000001TIk-3gw4;
	Wed, 05 Mar 2025 13:29:06 -0400
Date: Wed, 5 Mar 2025 13:29:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	zhangkun09@huawei.com, liuyonglong@huawei.com,
	fanghaiqing@huawei.com, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	IOMMU <iommu@lists.linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 4/4] page_pool: skip dma sync operation for
 inflight pages
Message-ID: <20250305172906.GG5011@ziepe.ca>
References: <20250226110340.2671366-1-linyunsheng@huawei.com>
 <20250226110340.2671366-5-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226110340.2671366-5-linyunsheng@huawei.com>

On Wed, Feb 26, 2025 at 07:03:39PM +0800, Yunsheng Lin wrote:
> Skip dma sync operation for inflight pages before the
> sync operation in page_pool_item_unmap() as DMA API
> expects to be called with a valid device bound to a
> driver as mentioned in [1].
> 
> After page_pool_destroy() is called, the page is not
> expected to be recycled back to pool->alloc cache and
> dma sync operation is not needed when the page is not
> recyclable or pool->ring is full, so only skip the dma
> sync operation for the infilght pages by clearing the
> pool->dma_sync, as rcu sync operation in
> page_pool_destroy() is paired with rcu lock in
> page_pool_recycle_in_ring() to ensure that there is no
> dma sync operation called after rcu sync operation.

Are you guaranteeing that the cache is made consistent before freeing
the page back to the mm? That is required..

Jason
