Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6640357CE5
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971754; cv=none; b=AB1EYptyUYjxkV3GYvvHTNB3JqUJQx9b3TnjvZtABbKsT28GbUKo2SIBzGz5TQaVpvQJ8oTcmHDBvG6b3yWVjfv4nqPif+vCNFmIJhDlKb3PYf3KXeBd505JddWyDLbz3qYDw8cOaTEKiCI07U8QxHZIhsV357m578yzRQcXMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971754; c=relaxed/simple;
	bh=LrC9TUnnqFTfebiht7I286OGjyOyXGf0/ejqHXWR6G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zy1jZ2WHPM/QJQiCdzgAyUKZZ9A5IyrjW3/higQyKRiqG1OIUm1gL2Mpt2LhcQtWK4t5Q/Pjt9EutSHV32tuRDgwZi5NlddvmlUQmgf8cbFelXa42A8+ddhl5Agw/63YHPP3b60e5NDHonJsi/GaJxHNu3ZkXlnyw9Vvfa2K4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G3RP5VuB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G3RP5VuB"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c15bf5000so20794691cf.3
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971751; x=1784576551; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1BBsjNZJ46p61GVJyRNvRKNhKTJyhEwUbX6XNXZgDe0=;
        b=G3RP5VuBQ27M3n1U0W3gt4792g2SVAS7zeaPdqW4hDfcuY46cz6vAGw7DYiLKroN27
         jVLjaPRDRudzbHmpq9ofuoSi3poLN+ZmLg0R0vnnv0ip3cxqfiOHIZ7nkPROfMDww2GQ
         iV/53JwWMW5gDzPhaCqT5AMcWWnGgnnucxmlys+S2PTrQZmL+IjLBoHF36/i9WFTemy9
         Kjh0yvPLjmW1rb63HxdWQNvKYSrByJU9+T13YvSRpvIa5E3UtxmKd1rANhJjTQj20y9o
         zYcKApEMG2xl2vMw43FpSJr7A8UaOj1G8DoyoNO6lx6S4uqtR40JzmzY/VQ9AxRvLrXE
         8QBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971751; x=1784576551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BBsjNZJ46p61GVJyRNvRKNhKTJyhEwUbX6XNXZgDe0=;
        b=UXwmGL4e/GIKr+3jyU2cd0Q3SKgdm4OX4Z9gMwxCgzFVX5oIZWqBuKilSXfaM3B0zP
         FVytm3OHTSxs2y7l3mKLY5vZ6pmcN//IArMhtWXptuI4j3Ypu9ifmtnv5jnXzkEWe0dN
         Rx3p3oNp5b5Siv3PqddhikVSWTNvM4ZRojADBuR63tb2P4ZAya1n6uSTAFv2pqk4buAQ
         PyMl8MjEOkzNxoyNSK6sfxUPIDA1l+Ccjf9gdlSztVaWgIPHqUWvdjrzBjhoIL4BkkcB
         eVgnXso+wOLPe6NQYr4suoA8GUP4Bmv1SRet5+Mt9IgH3WFw3PlOOtZzK4UYCBtQ/WL2
         iENQ==
X-Gm-Message-State: AOJu0YyXK1ZB2acycoGdyzCAfxPAfYJ+yRzICVOzXvyMoP/i6LEMqX42
	L9Zz8PJM/gVhDpsW6YGuaxF8K1CPiWQR7iprG4of1mHZdUEdJa9Z59X2JMG4RTbwYkM=
X-Gm-Gg: AfdE7cnqXxKpxgLqwtcuGScgHiItKGDSatEJ+tgIEckPxO3wfCnT/YlsOXPQD4wwBXz
	Q4gZK1W16mGhDGC+b/03j6E/J2UZfQiHzZJLpiEPk53afYuGmyYkLCXCGtIk577dQ7yCD3gO2wy
	ZbZPNSXGdF4p3s6G8TUcNVzDdXiI82MNHIprEy02fldScI3fpe0jZ/Zs3WRk0Xmez6o2canlDUp
	zAR4afBOHwjaGluDLh2XgAhbK/FG8IRYnM39CF5BSi4g7Zgmrki2WBYoxL64ZZrKmhQMGKFYvbs
	HeO/zmAr5BDWdOampPzFhm1NMIqWrFOw/i4ucxoTmrZtIF1P1Ib/eadSBBvC64ZTkKGJ8bAsbaW
	d9zwTcrm5XIOsZjKCQFTWW48yLEvecqFNJ4P5AkxmZsrFYymYkIEzLKdq87V8
X-Received: by 2002:ac8:7d53:0:b0:517:6550:2a0 with SMTP id d75a77b69052e-51cbf0b836emr108931441cf.19.1783971750625;
        Mon, 13 Jul 2026 12:42:30 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd5bbac2asm138277776d6.21.2026.07.13.12.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:42:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMXt-0000000E6oU-2oJ5;
	Mon, 13 Jul 2026 16:42:29 -0300
Date: Mon, 13 Jul 2026 16:42:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
Subject: Re: [PATCH v7 22/22] swiotlb: remove unused SWIOTLB_FORCE flag
Message-ID: <20260713194229.GB3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-23-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-23-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:26AM +0530, Aneesh Kumar K.V (Arm) wrote:
> SWIOTLB_FORCE has no remaining in-tree users. Forced bouncing is now
> controlled through the swiotlb=force command line option via
> swiotlb_force_bounce.
> 
> Remove the unused flag and simplify the force_bounce initialization.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/swiotlb.h | 3 +--
>  kernel/dma/swiotlb.c    | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
