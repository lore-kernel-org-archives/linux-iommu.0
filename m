Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D41EA91
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537766; cv=none; b=eJTgp8wAg1SKKUvmyR8QdnYXDC6kfk2P9MLbrPqPMNha+e1qQkWuLWwbf2vuiB0h22Y562qCVlyL2UNlVOJIcn9xBtuEIxPjGF2FAqwe1mxPrVvyaxRCBQan5lCosIpx4qMRG3VIZBkq3EAX141iD7e1O7mKqO2rrBb7hLBfpI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537766; c=relaxed/simple;
	bh=+izSO9NS1dvQ44Usea+/PRyoKVzL4dwBWWq0o77ECgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT3b0sfhn5R2kLvAoP4K8bJEnj+qAWybhIPYH3CTDKdHt7SgmucxVf5POIHFY9U+ktr8E9+cfn23ESHVq3SYPxwi5mQZtzhmAX8KM+H+xfEe5rgoCE8OUqj8x2Py8aOR2pwchEPk4n8Ui/cFFwjp4+sV0QewPGdpmk+E8kMWJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GYplrJDa; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GYplrJDa"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c07c83b388so157627085a.1
        for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 04:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739537762; x=1740142562; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FH+3dIVQQni58kSeXATaEmatfH+mLIwTZncYsTQFMPI=;
        b=GYplrJDaWXDZDQMSuFcwwx0hJZM2SWPMGPazmCKwrrwMFL1lp6/Xk+r1lUCk5NsOwm
         dbsOS3R9X7qNzAd0WFqM8GwkEJn6ZKG9SqX182++haweiu3uBy5ekJmrw2etujPhz/9t
         Q09me0KUFge860YjFMRs39Dr45PEokEFKqPmculYoXP91xt54p2+Hpq1bJniexmGxSrd
         A3u4/acrfFvbRvZdS3ZovFml4zOimcwT9h82rkOsAPrPYjyJm2JR4wHkq6ZlqEGZphRY
         aJIrPmByFCsR/tOT+WQfazuCL31dLD7UzS0VxZZcyGUXr6D4liWUOY3Bdfk9xuVLGIVD
         J99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537762; x=1740142562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH+3dIVQQni58kSeXATaEmatfH+mLIwTZncYsTQFMPI=;
        b=XBQEupQofoS2B6+hLbOaWXOKMF2xvjpsxvFDd0WdPfBVH39FopUgwNVDrveuVQYj13
         j9NPGtfM+uLi4IRkdDrmFoU0k5Ze/9JI7i2cD72ldvY2c+090Uj1j4yM47L1WdG0w/Pe
         PfOWbdfexR6aEoaUWxilicpe/oV+Nc3sT183rUAcwq7KFL7F+I1rnWByfTVsnp85MZpg
         spWEOmliTLy5iJjXXin+jy80uUvRqBjNtKsyJ1qoInzzLDeTC651pp47lWOU3vGXydr7
         Lr3AFUfe4ZEmxae4QZSJ53hhgM1MoZw4CNHjaXflXomYIUzsOFGFi+g3F89c41yAHsn3
         QHBw==
X-Forwarded-Encrypted: i=1; AJvYcCUnaNeXJW9FZkoKCDmMQ55LrPeFoglsWJwg57U6h+gcER4XtAFXA9tSRum52GD4FC3zsY8Crw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzbxi8ElGlLbCng5Vrteatg08b8UI1fQ3dscdhGyifdJ8UKi/fC
	VT4CIwC1qACfP8HSMdO8pbN7lvTUdkXDq8BBtxOv9dircrD4jTAyg+OFBZ9KsBc=
X-Gm-Gg: ASbGncvtzXzpqCzC/gmGoN4MaN0XnnqpbbsaecdNFE5pVTuoxtubL46pany+NKu+a/s
	uVFFKmItrdGi+FLwlv099X1E/QvkBMKxe3LpLJr3/D70hPpLrR2CBdwGTtgGLOGMrdqeNYVIadE
	7YXFR3ZQWY4gBSVzmGSYfaCgK7pEz2Q2yU7MuHHNTYNuNQZQjcYmNzoR9vhpqgMdsupfZeH3fy8
	CIqB1rCW3eQt1p3UG5sIBlqaw5+13Nvic4KY5NSmtYvPT/i99mpRQ3li/hxmTaoBB9Pb9x1/H0s
	H+0rxeD5IP3pa9AmS1w7SXx2PeOeYqqamDs0bxinZs+NArV0wm4ZyEL3yP49AJK1
X-Google-Smtp-Source: AGHT+IGMIC3l7eVX94N3JlHj6ZSg431KPepsQwfE1ziDaH5SNrBWCEEkMlKeHd+rscMrHYshY6NB2Q==
X-Received: by 2002:a05:620a:3d93:b0:7c0:70f3:7ae8 with SMTP id af79cd13be357-7c070f39c3emr1175810885a.35.1739537762217;
        Fri, 14 Feb 2025 04:56:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c5f3560sm202459385a.21.2025.02.14.04.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:56:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tivEe-0000000GisN-3M5g;
	Fri, 14 Feb 2025 08:56:00 -0400
Date: Fri, 14 Feb 2025 08:56:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Message-ID: <20250214125600.GA3696814@ziepe.ca>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9FMy7oVt9+enSpJxXvkux+czMFqbsPZVgmBV+rFWWvhGA@mail.gmail.com>

On Fri, Feb 14, 2025 at 04:43:12PM +0800, Zhangfei Gao wrote:
> 3. qemu boot multi device,  test fails, host kernel reports
> [Hardware Error]

More details? Can you bisect?

Thanks,
Jason
