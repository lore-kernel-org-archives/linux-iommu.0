Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769382F49FE
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554143; cv=none; b=BVCbWOjycki4KQp8tvMqzaQ7J49rG8XGsX6fKYVOdL4j14AzykL4fAOjTJYR2v2+F48w3WnW67fy65GYN9gFTI6MWaVEcv6LkANpW5F+3usggtlD0t2cpy1gYOGaRLIToxsn5O+AaCcvtYlDWOmUqS1iu/M5dUibVEouKVnKAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554143; c=relaxed/simple;
	bh=joFWG7Hooms9HHmPDBpxzWGrRsZoETvTZljAbbg12/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cd7wKRX6cpjSASg3sEW/n8xJyBw1AkoSwSbo641Ce7P8L7cGyt0LA354G00FH1VdTeRBtv/Wq2d6OClyevgwFObxAn5zq6rDEOXd/OoKOzLP5SDHvkTAw5AZfjpUzNpqTfJOxHwp/x4d44XehEsvE4QeMPKIvJ6LNKNXhgBjRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WOo+oOhT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WOo+oOhT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47a815c43baso132355e9.1
        for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765554139; x=1766158939; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gfg2SmLr3HbDKANFq8sDAahr7BVj1MWtGDCHWff86x0=;
        b=WOo+oOhTeYDcRIuVH5AMq4opHmR7R5tAATbtJbieeyTsY9KT3YzceXPqKZzeUNWtZF
         sNQ+Iqb5WaUNl52/lA8iBCF0GKZFkY6T7BGztM9vQ+aWHODiBdgm0Esiy6nnITk3jGYQ
         CBSUk3QAmgkhNp7CljELTkaGWc92bnTtSn2uXIe4ikbJzgUZZnK9Qu98pqBzSvEfN2V2
         sFCs5vBCCNP5mR3szD8pC3qd8t5BpFDEIdkS2J8vHsOb9VX6td1LiTkzP7zxkdqoGurB
         yMqjAPAbNtmNkgFsWF/0SWWEWb8W3lHxr594YbqweGrXriFnp6jNfVtlzfFVOkZQW7Qq
         FaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765554139; x=1766158939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfg2SmLr3HbDKANFq8sDAahr7BVj1MWtGDCHWff86x0=;
        b=KnPxeJnzJMRq8vlk/7kHu/12Lqhpu6ugsXMQ9E+2Oa++6X+8DjHsW5mcBtBWrjitt0
         SJM7V8w8CqDTPN+3P3EHYSSnbFD25igU9lFS7hsrJZQNmAHeanU8BwFfp+svwOFqn+NZ
         mUim9zKW1ePoeDucqH4uF5VH2DvTzvx0i7I8iEj5GXpj+Az+qX2bbFDgLH4dyqPc+rC7
         UnGIVftRheFj39qpEUl3HKgkmB6aCwThn7c0tGxUU2hwb/hl6732am3LFB9QT/k6WQvo
         FKgAHjzG5UD/RLzgMka+dW619CPCLc1V7j/OjCW2+V7tRX3jlcRtbBHYFCBZI8axa4n8
         kx/w==
X-Forwarded-Encrypted: i=1; AJvYcCXnGyTkgrFiRzTempv+9QrPtv/xvjxAxSTYrLERaV5fWNDkejwiuVE2LxchtWL+J15acOPl9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKe8PaSRylVS6k+sWwXLjZ//cIgQ/tv4dzCKIK5uODGtX1LmJ0
	WRB7HaonDzM3WS/WSW0nMntywHHGu1kpj5YoxvM/dHLyHr6OL7HMZc8f0KtdANKcgw==
X-Gm-Gg: AY/fxX45XqNG6nrLU4d15XuKh9Gg3KhwD8jO/qW9Ov6X851+CPk01S01z1Ff++DzW4N
	XdWBM5axRFqeN21GJknh7bVzV9+cGeEWCkM4XSnDKyXyppe46XrRpFbvm65cqwe1Ua/8CW6Yc6t
	uUMJRqhN1sMP517L3cbyNnM93eaQanXQEFJ65cUPGVSxRgKtl98KKuxilzR5Zp4jnzdqKrUrI1p
	6bUMp7hn0mWWTWJ6rgiRIxLMPUlXolQBGoCUAkbeRwLFWUdX4T6rg9RlvZCjfkFmsMAhFLNGo3V
	D7cZ+x99yiyDrRC+/98stH5QyQ6oZ8JlP8W0q3opnx7d3sBJhEwWTPyRVa6PJmIWM5HkFrDDAAr
	oPR49UobLHbNMXMTYoyJ/DKn54lkuftErjk0hzSHGgnTH7bEve222EWyVOL4rc997K4haApRC8e
	BfsHYJm2Z8QMuM674mtWNaZn/y7juoFDCegJyefHSZS7vYtzYFNw==
X-Google-Smtp-Source: AGHT+IGt3F8L3ODVzdoshKJbidZOroW1R1wmPFQ9WkER5xE0kT1roC/MUuXOsH8BQJj1YtvxKpKD7A==
X-Received: by 2002:a05:600c:a103:b0:477:563a:135c with SMTP id 5b1f17b1804b1-47a88b7b11bmr1671425e9.0.1765554139413;
        Fri, 12 Dec 2025 07:42:19 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b8a97esm15331584f8f.31.2025.12.12.07.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:42:18 -0800 (PST)
Date: Fri, 12 Dec 2025 15:42:15 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	praan@google.com, danielmentz@google.com, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com
Subject: Re: [PATCH v5 07/27] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <aTw31-mh8z81yi4Y@google.com>
References: <20251117184815.1027271-1-smostafa@google.com>
 <20251117184815.1027271-8-smostafa@google.com>
 <20251128164816.GC812105@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128164816.GC812105@ziepe.ca>

On Fri, Nov 28, 2025 at 12:48:16PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 17, 2025 at 06:47:54PM +0000, Mostafa Saleh wrote:
> > Move parsing of IDRs to functions so that it can be re-used
> > from the hypervisor.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 112 +++-----------------
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 111 +++++++++++++++++++
> >  2 files changed, 126 insertions(+), 97 deletions(-)
> 
> I don't see that this slow path stuff needs to be inlined?
> 
> +10 to my prior remark to not dump all the huge inlines in the main
> header.

They are inline as they are defined in the header file, otherwise they
get defined multiple times.

I am ok with adding a new common file.

Thanks,
Mostafa

> 
> Jason
