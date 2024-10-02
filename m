Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A41D0797
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878796; cv=none; b=bO1dgP7qYBKVRTJK6wYHD8MTtlYY/DzrLNa7TgeR03lzKtYQfMAiVjRKPkp8kGCRfsfwWkHYXpYIiqo1RzKY6Pug/00noyQkpP6vwVnRXq3cVQBAfgC4hQw8SwB03pA/BbAj+ziN6QM5Mg11XmTPWBju0myCclF3o2wHBpg6ClU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878796; c=relaxed/simple;
	bh=FWG0vBf2cYe/65iB0LKsJB46KHLpoyWi8RZ656yJ3wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD9vM3y572GTIg5xziiQ5mJh4+Oz1T/0mSbN/Lw3e147laK8SWh5lqpqoDGqrp3DYcG7+EqSJNLzUp7YdoE5Q4hYodGs+k+GxTzDrUJYJf5IVPTuFPdtyiRjzkE1fNnUQzghZNJnFGQxaxAWbWmzeWEHQBx0Nz+XIYefx3YTItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XNB4ALw4; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XNB4ALw4"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4585721f6edso43043141cf.2
        for <iommu@lists.linux.dev>; Wed, 02 Oct 2024 07:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727878793; x=1728483593; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiI5hCJOby62i85xKopQA05jR5pLNWBtzFXYDjEdUvQ=;
        b=XNB4ALw4y6XhhYj8/rGZJzv5hQYCerSr0OswULLA2XHOPhlJOl0qbY9H9/F11vKiw2
         Zm70TCWNZb7unV1Fc85RwLI++OUirdh+PszGnSH01ZKRJXfB/4BMu11CoIL5OKSV+mwo
         2AvsyKc7kSOBKtIF8ijBLptnhx6BucJcBvvlmFEC40MfQVi321s8ZBD9FWCooi46lH3W
         nd0ftVZ5ALrEIoOIOsh7x7WIxxNfYcvynRwen7J8pYXqklkAngyxeW93iJFfcEWdUpse
         mMLSmtlCZk7ZUc0zVT6ODLtA/UwqR4lDYmzcTNZ6JqZTciuBISp4jFn13xPCx1h5aVGs
         Zy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727878793; x=1728483593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiI5hCJOby62i85xKopQA05jR5pLNWBtzFXYDjEdUvQ=;
        b=WfBu1t2sb8OU6BAMUcBPQUjqqKYvKDIzwm3kzyB9yUXar0tRcKDclwPFS6A8NzrnOF
         Y1mCw7ksPtwaUBqrO6f/yLD+OT5L/lIiVf7zMgJyCXmU1ANeR9EH967HYjzLofr5nK8B
         nEUodZkc4mhCgBZyu5pacBpuX0yR08whq0ywhLhLbt/RjaiKiAJ9/GNtAnvYv73faLyO
         mjXQe7DhE1Bp9gIQijo4Qj4Jz9XZk6GO/AUgmTiyRUOfDJ8+RQVJ+Vr009EelIGn+nku
         XZ4gbTtTfggs+UyPZFv6nT/q74/xHzRUTfEk410CUyKtiI5ypi2qOmyq2MqJsgDRYgou
         gLBg==
X-Forwarded-Encrypted: i=1; AJvYcCVE5Q5gjHcsblJHmYWO8WVqcU0PdtKhj8kd/FEsflKxKGiyz663VqzbKWXLV8aqdCLum+tyuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzZePIWbSPSm7sDy2qz0U6p6vQ0LREKzpRCUMeugk6UR+4NHkU
	Atc/1cazWAi9ZSmPgK9zc2M50FzXb/udaUhzuEg/5moBPTVuSbFMKAYVdAjXiZOQ6zoeVIQO78Q
	H
X-Google-Smtp-Source: AGHT+IGqvpEDsT+Juitq6JKxi2ESGxJEf5Ld+w6MhBnR7Cd3NoXX+siJ67U5n3rq5Dw/R68G2doFRg==
X-Received: by 2002:a05:622a:50c:b0:458:2f22:ee74 with SMTP id d75a77b69052e-45d804d7fbfmr57224281cf.32.1727878793117;
        Wed, 02 Oct 2024 07:19:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f33946esm56399151cf.68.2024.10.02.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 07:19:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sw0Cl-009Z9n-DR;
	Wed, 02 Oct 2024 11:19:51 -0300
Date: Wed, 2 Oct 2024 11:19:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
Message-ID: <20241002141951.GF1369530@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-2-vasant.hegde@amd.com>
 <20240912210207.4ba164c2@DESKTOP-0403QTC.>
 <d092766e-bae2-4dd0-b274-69fbf5c27971@amd.com>
 <66fae60d.170a0220.280357.3d11SMTPIN_ADDED_BROKEN@mx.google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66fae60d.170a0220.280357.3d11SMTPIN_ADDED_BROKEN@mx.google.com>

On Mon, Sep 30, 2024 at 10:55:23AM -0700, Jacob Pan wrote:
> Currently, we have ftrace like this when I do:
> echo DMA > /sys/bus/pci/devices/0000\:38\:00.0/iommu_group/type
> 
>     iommu_setup_default_domain() {
>       __iommu_domain_alloc() {
>         intel_iommu_domain_alloc();
>         iommu_get_dma_cookie();
>       }
>       iommu_domain_free() {
>          iommu_put_dma_cookie();
>         intel_iommu_domain_free();
>        }
> 
> With this change, it will be:
>     iommu_setup_default_domain() {
>         iommu_get_dma_cookie();
> 	__iommu_domain_alloc() {
>         intel_iommu_domain_alloc();
>       }

?

iommu_get_dma_cookie() accepts a domain pointer, how can it be after
intel_iommu_domain_alloc() ? That would be a bug, right?

Jason
