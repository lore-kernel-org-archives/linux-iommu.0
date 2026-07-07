Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5EF4315F
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783425155; cv=none; b=EZzQGuPBbd4ZV4im74tFwkxptyyhsleq5bbfUzF6uHBJ43JwGmwyda2vP9oqfGz2qDqWXqO8RvuCSbhS4cp6UQppDL5+mMkaF3ltNn+DKo1aX18q0C/6ZuEmI6Vh7IitZ4VXd/AFwzTTr2kdowsyu1QlrxAzAuUnOKf6i8O0Hd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783425155; c=relaxed/simple;
	bh=8zbnjzeZV7T4GeRDKSJpJT7HdFcjcjnriEr+9hvhyIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T18qqRlVi/yJkuhNoOvRD2ccg2K1AgSB9myNaboiSFpjLOu0VXEn8xIBeN5ksaqoyaVnn59t98YWxVMSZRyHk/ye2LigqtTe2MiHHNO3zR3rJy5261Rf690YQCwo01h+ylpcJmIoX4owf6N/4loNYU4jGpHdcu7QLO21V0ac3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bhv7viPq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bhv7viPq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b8d99342so26085e9.1
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783425152; x=1784029952; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cH1o0f7+Xgp89WLi95K+Rx7Uq4DeC7XdXtfbyGqV9hg=;
        b=Bhv7viPqnvOd1D3Ds+kktOSf2VIswrFpUgGDVqG6uEfh/akxFfbK/AD505j20vacJu
         e9gWKOr9xSQQ/svkYp5RErj3rN5RaL2zns7MUBBNsSVA5/15Pi4qUf0wdo9pP+T4/z64
         QQiqDPbECgPNh9eStzBYQuwE6oGYNxkLwhUvBDPFTcttJc70gxk+AEZTpRK66wfvfJOb
         qRLE5oSy87ji5omoTrdaD9Qtsf0oJj7olj5N+SUQ9nlI7IWaABfv4UV1DinTEX0FomFt
         dARUP/0u6eAnYVYrMJZKDPU8H1VqWk4R2Xif4FKDqx7MRlCKgubaKxxDyjScbZ1v0mcy
         ZjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783425152; x=1784029952;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cH1o0f7+Xgp89WLi95K+Rx7Uq4DeC7XdXtfbyGqV9hg=;
        b=Qj7wUr2grElhf1no5O7+iMbIWf/Q0gnXc5VVhMm23GCvhvZt8hBc59z/od37c98EON
         QEjmtxuOicUJzhv6D2f7RFH36hL0Qv7Rh0YRj+k6hWKyLrl87q6rAWeIfWQ+mSPO5jq2
         pibpz7V4LuMAg/39gKzGqtIx534ChU8rvAkBGZZh29EKgZaYb9ebLBQ5QFjjj4pe4HEP
         nYm79BwTA3n8zFQWjSTbrXc2o7/+KOTEcUY0A1g9N3e2CwP4xO4ehn096/nbRfRHGccz
         3PaAkmNQK/NQCZ3WHnaAK5FIb/P+joD+S1RyZwJkNHo8vAsNKziIa7eQXo+Jznb0BATW
         h7wA==
X-Gm-Message-State: AOJu0YxlnOs0PNT5iQAWdOnzh9Kjl42H+gOTErHDRjlzVScqOdxhoHKR
	zmA8JiKZeByApdkHwlRz4Y67DyXWmZtQhtBpgkQ17rNuZyrduF26Gz+sqxqo0T6PGA==
X-Gm-Gg: AfdE7cn2somsKTXYvUwabfqzbwv3/+sEziLPhECnUG5ptrNcXCNJCdGd375ZyfQDFfe
	2viLI2A2cZdhZqrzTp7PDu78k/4uD+Sx5VC5JTaE11Dz3xx6UHQNxYxnZl4dkq29LVE+Asnl5X+
	2o9BBNbczu1YLTm4f+1gr9E0qHqZhVoggmlpUm3IiH3L24SPIH701XEZsVtcCSOIFkHbWhfUaJL
	+mE1giTe0hU2Iio2CbLts1jLPxBhHAbXsI4TjeljROJw5CC90J913quGBdc4hjiZ5C7nAt511aj
	j5d1t55woQ+VlqJFzzcd4WJqIrQtDnQv0XahKiY/F0TB8yg1XLd8LZFM0fzQreVLO5mCmhZNa9w
	BP+hnJMZFfYwLWBl2tcsIKzAKxvkG19lJlnpVSjHRRWKSzE2gVqLQNUW+p5PAxKvVYOF3XT1FUF
	3DBzoWCeN+/HGQfh6vKPIe/GQxKWvIVYrOlKJw3yl6o0EulTcg
X-Received: by 2002:a05:600c:1c0d:b0:492:203f:a378 with SMTP id 5b1f17b1804b1-493e121b8cdmr1175185e9.8.1783425151514;
        Tue, 07 Jul 2026 04:52:31 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f40912sm47378305e9.4.2026.07.07.04.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 04:52:30 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:52:25 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v2 5/8] iommu/arm-smmu-v3: Precompute the invalidation
 commands
Message-ID: <akzoeexW-4W70QdU@google.com>
References: <0-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
 <5-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v2-43074a57a53a+fb95-smmu_tlbi_jgg@nvidia.com>

On Mon, Jul 06, 2026 at 01:26:42PM -0300, Jason Gunthorpe wrote:
> Store the required cmd data in the tlbi and just copy it out when
> processing each item in the invs list. The cmd form only depends on
> if the instance supports RIL or not, otherwise it is always the same.
> 
> This avoids redundant calculations for each invs entry.

I do not understand how does this avoids redundant calculation?
This would be the case if the domain shares multiple SMMUs,
otherwise, a range TLB invalidation should be unique and can not be
reused.
And in that case I am not sure that would be noticeable with modern
CPUs/compilers.

Thanks,
Mostafa

> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 132 +++++++++++---------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  11 ++
>  2 files changed, 81 insertions(+), 62 deletions(-)
> 
> 2.43.0
> 
