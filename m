Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F435AC37
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971806; cv=none; b=S5yq2WjmGDYLrzPynG0uUBdoLQHpowBU/reUkcFaUnOW7aayd65StnW6y8Pq2tte9TP52cr3sJxdWvZT0XyVAKrFQJ0hH0BEZiyeSaDcGF2qAy9poAtl1ltQgrHbdgS8Mr8lNYGEQEEdq78lh9UmrgVWpmENV2IB8AsYE73PG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971806; c=relaxed/simple;
	bh=0npl5BvtjzaikMt6SIylqQSymiXrW9C26cahZl14wSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1QUFaiRfKFCGlTivnvsuCHKjUWsBV3QoeBy1GvCVOPvzqXr2dHGirZFgCTQUUb50LVYs1wDFEA9e4hJvoYfcWqdd3vAL+AhAPD5uHoKmvbC/W9/q6pFQi0T4M2jubnnDt2PfEz6rcPyiq6JWeaMw4tjSWyly0lZHxLoixLyxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VORMpffP; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VORMpffP"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-902f92b8504so27399346d6.2
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971804; x=1784576604; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0npl5BvtjzaikMt6SIylqQSymiXrW9C26cahZl14wSc=;
        b=VORMpffPRMFry0Xf5/rMK9YnBk9iyfPGjeYBhGqdEZWl9zUCdNX13NywkCmYHCDkdM
         fkSV2eW6Js0DYyd7gCvYbY3zKufkS71rEb2cj57AAXo1WD1V91UduVGCbZBqXWbLgdwl
         yX0Hy4DlZjO3gKULGrsx1ueEuYrhFTIUF8WgnLdiqNAWX1mxzfftHqQPm4CVkNhMSmxx
         aoMSqZimyyfJ4pQjA5SFgWK6qs+eOLqnL1NpTGTk+boWjIFLFM+eLj1ggJ4kCtosTQ+t
         CVodXcdy9qkJNGgIOR8Yf01QaEQ2i5QSk/7mWgcn7qK783wxjLH6RIixEOqdHRm21sQF
         LwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971804; x=1784576604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0npl5BvtjzaikMt6SIylqQSymiXrW9C26cahZl14wSc=;
        b=P0FZcfFlGHDVU6bSoaELRCSsQvDWmGUPQ+RK7LzETlx30OPKoZ/BdyQJ5/pnz8KzAe
         /PU85LA46PqrZwv3lxJbqMNucYyDUJh2DMmHCjixZhfr7x5lX+wNqaJNHq3tM69N1bvD
         n8dU2KyoHu8yCZWybDNjL1tWpGIeChfkxl0XYkcGXbksFXIpiFrOXjKVNHSSBnV+/yF1
         +l3m1boHMDQwZYif+VKjfFrLwmwGJsVHCJFdRO9uakfgfbNOgmFldZ79huDKA3STFsZT
         wjya46eTYQPkPguu5sA7qOJbTJDXRqc7T/aUM2DNVfIqZhwnRUaGqVqvDARCF8k1QCg4
         tskQ==
X-Forwarded-Encrypted: i=1; AHgh+RoN9U0YzZDWkdB7yZddCSKf9aIk3Q3Bpv58a3nuT7nih3ekJyD/pCJRZKuofW6Qyh9aijhAxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNiOZIIbbNCajm1esKZPkbcMrn0uHXn9MQaaGLmEAgaizZztrI
	XqrLfJEZguzBnaajL9MNquvSF8HZF1Elq8ZJa0O/qPj78mkw+ISI+lADAM9PEXMLFb0=
X-Gm-Gg: AfdE7ckQWh38XNQxP7MYKpoQmM5B4iTAlg5ydTVyusHqhkvrQvTM9TM9reQ2cYoBIYf
	aWh5fMjun4PrsLpxgIrLtHwxKoD0ef2UYp4Hvlvf6itGTsg1IO13NqeeQePN4b0qLeUhhD2TBIA
	KH8dBWrVN7zygjtzTYyb4+hN9yN8YrKSSslI93g872MBt0oYsUiYyslXJ4G7DZ3alkKfwD7Z3tu
	mtloZZ0S5bkBmScyVpHmF48PTqAALunjy/nDrISSfkk5XhWOBI211G2pdr69CsY87qRJmXkcpu5
	qhVGT6VkMVBqkx6mMoQMy9Z2d5Of8+5uQNC23STZ+bwqmfgYHJYfd3cyQHdh5LkP+25uY0C3lmH
	CUvJuBVtF2AOomGoxNYhXgaJuM0f5gEfUtJl8bgfMcP6q8fMaZ+nR7fjHdeDInJNl0pxZHYI=
X-Received: by 2002:a05:6214:3302:b0:8f0:63b6:5881 with SMTP id 6a1803df08f44-9040236cc47mr114290366d6.26.1783971804298;
        Mon, 13 Jul 2026 12:43:24 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c9500sm137858946d6.46.2026.07.13.12.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:43:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMYl-0000000E6yO-1CDU;
	Mon, 13 Jul 2026 16:43:23 -0300
Date: Mon, 13 Jul 2026 16:43:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <20260713194323.GC3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <CGME20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1@eucas1p1.samsung.com>
 <yq5av7argr65.fsf@kernel.org>
 <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>

On Tue, Jul 07, 2026 at 03:03:48PM +0200, Marek Szyprowski wrote:

> I'm fine with merging on top of the topic branch and I assume that this
> patchset is mature enough to give it a try in linux-next, but first I
> would like to get a review or at least acks from others with good CC
> knowledge or experience.

I think it is good to go from a CC perspective, there are still some
more items to fix up (like the MMIO) but I'd rather they be followups
at this point.

Thanks,
Jason
