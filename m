Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B82BDC33
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235924; cv=none; b=OWZTl0uDHE52lZYSCQsXIl1DTpf1M0TDzt2A4Bm2uq7kswyWoBb/sx8Pmt8Uu9R1INDklUmkvfs+ktC+HgRGF+6xa/jYXM8u3zOkIWuzF4gWne2yXQ0aeqrlx09zFQ8v5WjR0FT1+bGxL4UncBBKJMAj/gRh7dXv7U8kA/wvKx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235924; c=relaxed/simple;
	bh=xV29DIU2TbOmuryVDQ1P7PnHetrjWHc87hnpdn8mfxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjZeANbDmRNIa0H2nT+vRDL96Xhs0C0YPaAA/90XaOA9vpooex9THaggG6a5TDkvqiQ63Z+hszLrww3znPf1Ymx/uQcMkz3Ni08atlUrLoQaJxNthYmVpKzLXHMvIz7PxlorzGR8PjGrGhkO+JinPUVkKLWmjw8XtJ6sHdsNLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AhX2tddi; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AhX2tddi"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ddabf2ada5so58530331cf.1
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 05:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759235921; x=1759840721; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBYh4sqVRv985C07Huopg2HBOyHMdBgVTsPZLDQuV38=;
        b=AhX2tddi6iFLdishtUGVnFkXmVwz9mr5GyyqzFyse7/PueBvApYAB8cPlJet7fHH3h
         mu/+SzZfS4Hv9Vy3oaVOxu2BOFMqs27+T7FsVbNlyM3NYDt+wO5qIm+r7J2L7UyHWpg/
         i5FseoDyd47jevTS2mQw69RD9K4wSB6dNT3vhOg+i0C2IyTv9jM7PzIi3e+eg951N9Um
         4UsE+iziGhhcljWbYj5GUiXuUzvJNum1VYffaP0htRmRrGwRG5XHQXx2j2jg3Z7vLQ7A
         I37pKddwN59dsx4+tvphIs2cJFi/sL/yRbLfbpJhxPq6YPTQghnWW9FswGJxNwxBL8s8
         VlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235921; x=1759840721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBYh4sqVRv985C07Huopg2HBOyHMdBgVTsPZLDQuV38=;
        b=nQrI55N0C19A3tFn5CMdKCY0XROOqoQv33rwUU3g9YkivhjyLoMXtE3TrQZMIYyP/1
         0rf9mutn94iG+spD+2IEhrEghqey0O+ZxszhuYxcd7J/j6OCs2FhkniwFt+kpgp2jEBi
         m26uLle9MbrsSRUoCE9k6Ve097LXtnZ5wFKHTm6LWaLn+oiagZ/wj+ulyKuzDF2Kn9RQ
         8fKVMKXSx0i4b3GF2qTmTumEbN3TziolXi7Q2GzgC+JoBgDlgwe2lP51Mr/4WmeIs083
         4dkMvTsyd9lWjY2KW5kyXzPws+gXH/jIAvooaL5Ld8QqVgJ79tixrMpx+r3AhtJ09j6W
         eXNA==
X-Forwarded-Encrypted: i=1; AJvYcCWtiz6P7u7WuF3DmgRD8lIK2Fye7RgybXftV8gLWJRKIsAgRc/CPhXe8YWmkzvv5yqCcPQYaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNMxc2b6p/i7zB7t8ZQqCAi7ovZUtnZ808vPKNwq2LZCycMZ/S
	OTr5J0Ze6EEm4FS5ouV6ehRiuUek5Sc0d/s1X73l3rNH8+0DeXVIYA4OFoKxegnI+a4=
X-Gm-Gg: ASbGncuVCpgHEIcmkNhml5i5AqpATWpRSpWGKpCvTXdQ2Mq5sWRs5mJdzZDUF6hMYUF
	8kBbmzH48lIgUQELvT4iT1BiJhY97sdTuM0zApBczMMssE73gfQjCbNW5+HVO6aAAPeTnFAiboF
	FcCDQwrA9MSYbgg/cGjXeE4Vgj7M0hk4XN37/9MKC9E3R9adNsDjrznj09Q5hZC+ce3XOMOpVDn
	njjG+GdWEQjf1zBq0NczSP4LhkPWE2uBtrtQJY9O+Ea9yJqEaJM8X4xxnf3BId53J6ECCu4bJ9w
	M5ayphY23M7vyllfOTZdOW9wRKH16wAmo0kRDn1F6aXziuse+fwszkohsSfvdKpuhKZ84nxRZKX
	1QDMvX5d4ddlHC9+zxreJmmttvQMJF6h2UQfKlCZL4w==
X-Google-Smtp-Source: AGHT+IHgKpbQVt29fnjPpYGRGvSeW5uUhJfqcsuhp73OzWARyNjA6lxGY/bFMFic1Y10TeqPQbcyEw==
X-Received: by 2002:ac8:5c88:0:b0:4b1:247f:4e0f with SMTP id d75a77b69052e-4da4cd41ec5mr281429761cf.57.1759235921370;
        Tue, 30 Sep 2025 05:38:41 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e34ef75712sm8696611cf.7.2025.09.30.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:38:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3Zct-0000000CWSm-3Tg2;
	Tue, 30 Sep 2025 09:38:39 -0300
Date: Tue, 30 Sep 2025 09:38:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 10/28] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <20250930123839.GL2695987@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-11-smostafa@google.com>
 <aMA8vz0v0Vn-02QP@willie-the-truck>
 <aMlzLsj5slPQhWEr@google.com>
 <aNamXlTErXDs1K8Z@willie-the-truck>
 <aNpm9odmzv__2RyA@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNpm9odmzv__2RyA@google.com>

On Mon, Sep 29, 2025 at 11:01:10AM +0000, Mostafa Saleh wrote:

> > If the SMMU is in stage-1 bypass, we still have the incoming memory
> > attributes from the transaction (modulo MTCFG which we shouldn't be
> > setting) and they should combine with the stage-2 attributes in roughly
> > the same way as the CPU, no?
> 
> Makes sense, we can remove that for now and map all stage-2 with
> IOMMU_CACHE. 

Robin was saying in another thread that the DMA API has to use
IOMMU_MMIO properly or it won't work.. I think what happens depends on
the SOC design.

Yes, the incoming attribute combines, but unlike the CPU which will
have per-page memory attributes in the S1, the DMA initiator will
almost always use the same memory attributes.

In other words, we cannot rely on the DMA initiator to indicate if the
underlying memory should be MMIO or CACHE like the CPU can.

I think you have to set CACHE/MMIO correctly here.

Jason
