Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A11E498
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040689; cv=none; b=iKatOq+Oipsc+KG9VnZ8hYjcbxM0bXoO5zj148/SrTOqmxsx4Gnjx+aTukA737x3LX0/DCPuvuV6oVTvhypd/64dPbLVvXyViXyvp/1cZuq6OhJBvuuFPoj4SNXwD0RHchn2uVfgBbUZCKzUe71RY+Sqclx0M1ZFDDBXxtjXZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040689; c=relaxed/simple;
	bh=n9rffRvvZDo46Wm4EmkIP9rTg/Dg4fSh/n65t+tFCaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zohlf/f6/egYbsxc+nmw4fq/Jq4S905gnZAnSgBMmCQDGcUWxptqPg2iZEeOR53erPgcNZCCUBJ02qu/N8wvRjSP0Z3MUOijkcrTvX9M8fcZNVM5b+G8LUel0xr9PehAizeYMFJXmZUAOTNAif93BavOIszPGTp+TwN+asldA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WK8z/xzN; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WK8z/xzN"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f9a7120d9dso701409a34.0
        for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718040687; x=1718645487; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mLPNuDrUNKDp5u92gqFlS+I5przmPvAZoMgl2TmV6Gw=;
        b=WK8z/xzNJNSgv3AEH3kroBH/K38jbaO+4YbqCSBjoMPD6vTxBpZyvppOncCPIPEnlS
         LJwWo5IHSHRVpwtF+SC01DcrbX0oB5JqsQaiZ/qIzeN3m4oBf3Zq8jq6s9psGgnZ/Tev
         1F0B4oFMR4FyvcmrbLw6f6AhvvrznhWGrgBBXYlwb9Q5gINiRmmnUl1xsyPI5xpYxNhz
         +J9//jElp8M8TRaz5NbhNIjtrRO+u0kCheh53bt4BRUHnRWFEIy/R1yjN3uWPqTT9Hqs
         Buy/Adm1wbguhK97SOkZ6EsTDarVpEnCTCEnbr12GsMsEZAJAHu2J32ZF+rcTiY3XoN4
         C5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040687; x=1718645487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLPNuDrUNKDp5u92gqFlS+I5przmPvAZoMgl2TmV6Gw=;
        b=Lhn84KHptLU8IUl0ph2ifE1fg4rZD6iH/MeTQUib7Lq3Wxh9uh9RL4yhhLNoXPmTL0
         dizp85lRqvUvuriSVV79vemfP1RBlR3KBYaUQzjLeDK107bGRk1tr9vMJd+enD6bcBIM
         2su9s++kEUWF3Y5TIm/Xma8M7OoLBnt41fwkKe2w7z0oaOHA3prZ8Q5wqrpxtWM39Ala
         sX9ZOZBzZWL/XmtpJIiVMQ2snUSHQrYq1M1xaMxht4Z+ie/x0poTFcfI0rMxqO8z03Sv
         MYHgZJBJHsE310N4W0qcrZ+iqUtLp763LkT414OtLj7yQVqt38S9r73x5PmzvmHyS30y
         trUw==
X-Forwarded-Encrypted: i=1; AJvYcCVJvxzWImHsUehfgbHjQsTRXOzm1mpVK8fJvsOzYJGu0ooiz4sWRuvGEEu7FA90DdL8nkFXmjnyNlVhaasM5nJeYtGZHyE=
X-Gm-Message-State: AOJu0YyvNLojInk0Grj26e+MlyXX7UFpc1e7+/x8/KgDcP2KGoYyWJ10
	YoeDkzPiDcHLX7zA0cmrIsI+mLDsYBuhRuY3An7ozSgTfrT4t+Htxbak8x/PDv8=
X-Google-Smtp-Source: AGHT+IFXpbUysE/xAsd86TbRqWbmmSWkpKf5x4NJLkNSutmjNPooTKdkJFVMwrKZ0jmXH4RSO4kJuw==
X-Received: by 2002:a05:6870:ae81:b0:24c:ad9d:417f with SMTP id 586e51a60fabf-25464475e26mr11011556fac.7.1718040686697;
        Mon, 10 Jun 2024 10:31:26 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79550c14b4bsm266991585a.29.2024.06.10.10.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:31:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sGirc-00Eq4E-Gf;
	Mon, 10 Jun 2024 14:31:24 -0300
Date: Mon, 10 Jun 2024 14:31:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Make iommu_sva_domain_alloc() static
Message-ID: <20240610173124.GK791043@ziepe.ca>
References: <20240528045458.81458-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528045458.81458-1-baolu.lu@linux.intel.com>

On Tue, May 28, 2024 at 12:54:58PM +0800, Lu Baolu wrote:
> iommu_sva_domain_alloc() is only called in iommu-sva.c, hence make it
> static.
> 
> On the other hand, iommu_sva_domain_alloc() should not return NULL anymore
> after commit <80af5a452024> ("iommu: Add ops->domain_alloc_sva()"), the
> removal of inline code avoids potential confusion.
> 
> Fixes: 80af5a452024 ("iommu: Add ops->domain_alloc_sva()")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h     | 8 --------
>  drivers/iommu/iommu-sva.c | 6 ++++--
>  2 files changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
