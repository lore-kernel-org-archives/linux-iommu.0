Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110653DA5B1
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061188; cv=none; b=CiKxFyLgKPOBGqCnlLlgpaVU6m1+qkNWpGBIj1GDtEOV1jvNZZYRv1racYrbX4pwNkle1tAZQY62qwPAXwdBkzZkdYuQBFYCokuyWcn3urHa/bh7IhAXFLEBU8g5MJTuUq5g2EqSBDuRYBeJ16jFqPZHHU2dhxzanYkCine9KWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061188; c=relaxed/simple;
	bh=iy0/b1/iujcmeLTqUoVHzOR2Klz/M0/2Lh//DNx0Le0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn2/cO+81qglz7OYQxAFxLbav5xpDTM9ZyFoKKKeMg4650S/OYVidRu8PUUFs14wMOabNc4mPC0ioPAq8knJAq1oBsSfzC4Xkas+4z/zMWm98LothcisbWSxCOQ53mYid8cFLBQ7vEG28AXow5zudx5rfwbsKBNTEGdmA8VWc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xh6ENKr2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xh6ENKr2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891b0786beso41124025e9.1
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778061182; x=1778665982; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+7tvgQz0muvH8bYR5hJSB+XsuzIRTcHXfFlIskt4q6c=;
        b=Xh6ENKr2gs42we4Q4nWl/uH896rTudLAx45TVu3uy/JovouuhHGWT4ThfKFmHnukl6
         CDkpPjGuoI8nfaf8+9+sS3sAmgCqrxZcm6VOomgeZxUQSGR84gjJbrExdV/ovvMPz0fU
         EE2ITMEligdIPt+JBrVY75/dXV2/ib8g1rdPNd2Ga1EJ/N4X90ZzKkmygVfxVcSDP0Rk
         yKHisSOX8cDGYLnNtSemy8kHP4+heV1ng4DqBi7rnp5cJ+xhc5fCuL/03ZROFwnc7iBZ
         nx0Q1AAtht5LPz7A0KMXzziOU5w0LPdE3ki8G7yhaRNlg33WTGckXwI9/qPmA4rSQPmJ
         ok6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778061182; x=1778665982;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7tvgQz0muvH8bYR5hJSB+XsuzIRTcHXfFlIskt4q6c=;
        b=ooNj3MH7nVuxm8G/XTjC7lhl0HzodeHQ2HrjIMdIGs31QsVn13zaTIh7jmfHd01dQg
         gO0M3pcpRfdvtiQZTXFPGKowWxNyYAKrXHX0FKqUjr+PZIJSFhjGpr5HTDwifKhAB3q3
         ikuEov67pIeSaiEI78P+EYqWfRnRdDDAB0dSxGuEQxj05M/NyVCfHRrJqwCis+kvktV/
         5e856fPgqxwOKUJQV66QqYAuAY6Lrsdh2YM5APxodo8O9UGOo4Qb8MAE9JB8FflbmZsI
         QaVDrlcPx+KvcPZdOFh5g8GTu2mvvRyHX2CZRIl6BJQtY+tNBb7Wp4/BQxRx28q0MpPv
         CMJg==
X-Forwarded-Encrypted: i=1; AFNElJ/JNXsYDkWIRPifTdf5o3kdoWuwsoz1RuHY1uMZybzQgpK0KDLaXgDSxRZincXjxoEZPn1VNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxF35DH62jc+8ykTJJ1aBSSe/5h4oZ7AM+PPcOKcWwXoPq8yVlh
	k3+27h114LZoRKQCB3sye5ctXw1sNZ7sBGMmhjsxF+wlfg1Q1AOC6BfytSFjb4LONiw=
X-Gm-Gg: AeBDiet/sDYqU2O3sDMIMKDGF+UPbqlHAE3gfxcJiwCyrfQztWIe8y/rlFHcIiYxbvt
	v3lBJF02QAlFHBmwRwARaEnzjMrtSn8WcAMGx7GvGD7YAejypbCXcGWkN9nHnta+0Wdp9/x7qJ7
	ZqkduEDB1J5H53NKq6WRdtBQO1QccKNuf53qabt2amNm7L50N0IyUcBG/qV66C0eqYV8GiGKx7a
	oxbHervk4JgliXFReh6aLAXklMN1w73c0EhZBlXgvfrD3BcUchtYS3ybvjjlDELS1rfIGMWZ9NH
	xjGnnWoIp/6GLsdYpMYyZe3BystnZUWMi8X2z9OKKbWKKuJonH1ao5TWYeXgeJIOegMRuon1beV
	it05Ba7oElH3+rrM8g5453Ddl9Zuq8JteuGERttkDNdOzxz3hIMZrtuxzTyfSx3sslkckVryn2W
	DjFv+knUPr3B+qBCEQvA==
X-Received: by 2002:a05:600c:b8a:b0:48a:5574:3a48 with SMTP id 5b1f17b1804b1-48e51f32bf7mr46777065e9.16.1778061182206;
        Wed, 06 May 2026 02:53:02 -0700 (PDT)
Received: from ziepe.ca ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538ca8c0sm33324735e9.13.2026.05.06.02.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:53:01 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wKYw8-0001fR-Fw;
	Wed, 06 May 2026 06:53:00 -0300
Date: Wed, 6 May 2026 06:53:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 04/25] iommu/arm-smmu-v3: Move TLB range invalidation
 into common code
Message-ID: <afsPfEzgGtAFrN5P@ziepe.ca>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-5-smostafa@google.com>
 <20260501124143.GB6912@ziepe.ca>
 <afiN1UwS9q6F6A_v@google.com>
 <afoYBYIJOTClsdLS@ziepe.ca>
 <afoeIVIGE-JjYy22@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afoeIVIGE-JjYy22@google.com>

On Tue, May 05, 2026 at 04:43:13PM +0000, Mostafa Saleh wrote:
> On Tue, May 05, 2026 at 01:17:09PM -0300, Jason Gunthorpe wrote:
> > On Mon, May 04, 2026 at 12:15:17PM +0000, Mostafa Saleh wrote:
> > 
> > > I am not sure if it’s worth it, the hypervisor is much simpler, there
> > > is a single page table, it’s locked (also identity mapped), it’s
> > > updated on VM boot/teardown only, we don’t even use iotlb_gather at
> > > the moment, although possible but I wanted to keep this series as
> > > simple as I can then we can add more features later.
> > > So this patch is the least intrusive change, as whatever the main SMMUv3
> > > driver does, the range tlb invalidation logic is the same.
> > > But I am happy to experiment with that when posted.
> > 
> > Okay, then maybe just always push a full invalidation?
> 
> Like full address space invalidation? that will not be optimal and
> will affect every device on the system, why would we do that if we
> know the address?

Not every device, just wipe the VMID. If you say it is rare then keep
it simple. If you need to be narrow then use the proper infastructure
with a gather. No reason to make something boutique for pkvm here.

Jason
