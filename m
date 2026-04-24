Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307B3D4127
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036045; cv=none; b=ENnAh8kBWovhjIspzw4nQyyLjG5CDweyQUdypuedq07b09otYmaH4+vEEL0peTjCmXuI6Xbe1Su+DLIpfct0SwKAVg6ZIhlV/zxT2FN3TB/u9zaM455zBrcJM+cxCgXVwA4y+kHja2dPV4yNsA8K3/Sy23ZyCejThpkzwAZwGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036045; c=relaxed/simple;
	bh=sCDsqy7W85Y+a7LgGvlm9lAlQEpBmlPprmn2dzvWLuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMBs1LX09F1meAnUsWMMifKUvSs6ar1+N1qGL4oQGb+qct7HcovffWKz1ReLbURmi4lnfMg82DDgIuOozh7sfRNNujLbYh0JMH+oC8UdGRnJEhRKo7kKbzhU7iAJnj3D8aRrPIV8oanX+V90NdfWUoKNUsNtH1fjj0wucCnMnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KP76qVcb; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KP76qVcb"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a48deebe95so59581426d6.0
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777036040; x=1777640840; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFFzAgMltD5d+nB/EpmdoiPIkhUChneGMHd/GOz+Z24=;
        b=KP76qVcb1Wy7U2+FSzrOhBKTz2Qzw2TQS7yoN9QNgSIo1ZgrBatI9ELhihUeb3NQep
         RgbeJLvqhnTKMLbF4TU+uOkjkodeffGLwWR3NgSLyPG0oXQUptf60rPyPeUIOE7ed2MJ
         2eRc1b9SL2qUvSgCwDGAaJpHyPC/ie4TQOWLFShLRnfcVTb1Y9NtwhNa+LUpz9ALpmR5
         7DT46m/iv90URN0rGnMdzNeGjQTG3n1P6/QjFQNfsLp5RBvHEmDJ7TXp7yhzBfoe4Rbj
         yOnzhfBx+sx0wy8IPHG9T9zP84BPJziRnySciH/i1jdvk0A2xm3cV6gbbjktpqEjg07O
         SU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777036040; x=1777640840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFFzAgMltD5d+nB/EpmdoiPIkhUChneGMHd/GOz+Z24=;
        b=oUqg85wcG9q2UiQZKM4MAipP3EeZzD7dzQ/cHZTM6wpDn8vAIC2/usDpesZNMbKsZf
         uwtY8svFBlMwaH+/bdIRQenzv/Ns6DByqXk3MOjR3cIYotXjTt74iobDOx2wUcoLznk9
         VnIkHPSe6TZOdT9NDcXZWVpa/jg98NFLTZ8iecO87jspwe7W/W3kpAjhsgjDatcyCxRj
         Fb/I+7IsCXLocQlHUrrV9hDbZnA3ntbXbz7OrviA/1ZZuEiYO4uwK37DG1FR4rvJ4ziJ
         R5jkp2O3FTcO6uaro3rcxkgnUbHoixIS9cbbgHb4Srhq6VLaQlv0tTW+R6G5S2fNAjXd
         BIAg==
X-Gm-Message-State: AOJu0YwrdQzLB7pfYIgqitYQYOZuvTiCpdXNRCJEezS/EcTQ91NKjMKQ
	tr1JeYla/aqJpXWEnAjd7Vt7KbsSA7rR7BZgikAYp3p6f5BRLkOXImmts+U7N6MVWGQ=
X-Gm-Gg: AeBDieuLL1LdgywIoNhwkoFiWQR8DnGi0LglSsthmfxiDR4vbMTy2pRJnkIeJuvGQJ5
	2LB+06kTm8JS8ozDJkoGQZs8lntLQdLlbnO2bbfreS6YtJO8SlJJpH1HgjcXnpw+SBT5KL+jUvg
	SMw9JMbDgenSI820bTUZ/WHzEkskM3OrZwXMfbqL7bOFhDhhwIlEP9ouiMxOPXwDCCC47xfnNUY
	BW2WLKMjUqBCuTWr2HTQY+U9JYQ5Q9b/8Vj6A1zeoRXXYrJHkasvZDhM5FjvSi1JFQnEXgBvNBi
	F3mEXrVfWdlJ4KKZ1Jxdwzxb1FDb2DzkKLxtxhcB6CSIQWBP7IsK4FyzlodT3SxjN4IIm5ZhlLN
	CSKR0Wll7Q785oonJV4kevaUD3oReiDzfRHIGbm9PZgsXwcN84II6ZW8jIQiAQ1C7PLpdaM69gH
	CFtmPmEbxJI1fVR69aztNeeM3MhVFVVBOUp+yotBJlmZ1sBmNn4KLlVX83cWW5Xzcn1e2bWnwdV
	jCQ1iXp/xajBuAq
X-Received: by 2002:a05:6214:cc1:b0:8ac:b4b3:3ce2 with SMTP id 6a1803df08f44-8b02813ae21mr473334926d6.41.1777036040137;
        Fri, 24 Apr 2026 06:07:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5ec2dsm192148296d6.29.2026.04.24.06.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:07:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGGFa-00000002P8B-031d;
	Fri, 24 Apr 2026 10:07:18 -0300
Date: Fri, 24 Apr 2026 10:07:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
	robin.murphy@arm.com, will@kernel.org, baolu.lu@linux.intel.com,
	kevin.tian@intel.com
Subject: Re: [PATCH] iommu/pages: Fix iommu_pages_flush_incoherent() for
 non-x86
Message-ID: <20260424130717.GX3611611@ziepe.ca>
References: <20260424115051.2082174-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424115051.2082174-1-smostafa@google.com>

On Fri, Apr 24, 2026 at 11:50:51AM +0000, Mostafa Saleh wrote:
> The dma_sync_single_for_device() function expects a dma_addr_t, but
> iommu_pages_flush_incoherent() was incorrectly passing a virtual
> address.
> 
> Since iommu_pages_start_incoherent() enforces a 1:1 mapping between
> DMA addresses and physical addresses (checked via WARN_ON), we can
> convert the virtual address to a physical address before passing it to
> the DMA API.
> 
> This also  matches the behaviour of the other non-x86 in
> iommu_pages_free_incoherent(), which uses virt_to_phys(virt);
> 
> Fixes: 36ae67b13976 ("iommu/pages: Add support for incoherent IOMMU page table walkers")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/iommu-pages.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
