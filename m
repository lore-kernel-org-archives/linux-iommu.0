Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90134348448
	for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243160; cv=none; b=oDNAwIIjKpAzBuYBsMZ/nGVJtj1zy7m1u9mhP06tXlH1q3V4UhLdUNnGAB/57CExyqN4P2oUgub5XikjzveOxoVY/qmEMmCyq6e+w1W2kFICBF/doCoUljheGveQY8ypQMPcxANh/O06xht2nGtXJxaiM6g4etfMVQgwk0ZV3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243160; c=relaxed/simple;
	bh=LBnfKUDTw6Ut96cNOQwpeXVHk5a80pg/4FNF9IBsbZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOlZBASI+4h9oXzaJKiyddZyLAWw/EyO6ztDIUlOSRA2YNsPZ4pZDAWm1kmsDo07w/EaOr5JEfcLLsLBrcKh7Z7JHNbBpQNu5hsTNSfnD7Smqv7nMpE6Ma7l0sjRc4bEosMACTGn7DhZ3iaItbekk2c/eUttF7pTgZp1JxG3U38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kkpuBemT; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kkpuBemT"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso845709a12.0
        for <iommu@lists.linux.dev>; Thu, 23 Oct 2025 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761243157; x=1761847957; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOU/kElSaCjd9f7zwYG7ZjeJEeWR4TSXwf/lG3jqcY8=;
        b=kkpuBemTvbJ6M3+r7+IssAO3hNtzIm0cOnU30y1rfc7xThplCO+YTaudSO1PIHsHyE
         Hu98z1ERQY0o1w3ytkNW98l1waOKUoL6B1WqZ1op5Pj5n70bJ6PMFKitmixQi202sxbV
         Op7nHd+iye2HzdJH6pwl7Y2FWz634lat/AXkb+u+6s7FgNyvVUY72xpzZ7Z4yaTbmhuw
         dF2dD3Z8zPIyLQVCUYc2Xc5hQQxf8SaBxI2o0w7b85vZW8W2yVT4U6ecgkMSfc+RWRpi
         0Hn3Y+rHZLgorKJqorKodQZo7VUTCNigNoK4TfrDOnv6a0LYIRPxAmRQPvvfWtgwrVdS
         6DaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761243157; x=1761847957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOU/kElSaCjd9f7zwYG7ZjeJEeWR4TSXwf/lG3jqcY8=;
        b=tMObkwGFBv8ZqMCF+fsmkEdUosFaEIktZExvNJpTd8C4dDwvU+dLItYNfXsACuTamM
         yiQOot9HOR9w9lDsVrqMbaRD/zBNTJ274Fnna+g7qKsX+AXSk55MCmYvLeMl+CK1fcE3
         YXjdGi+xToEIBus95OkrTpNOxYGs9Wn/djA5gJFqVCetpr1xtn/Q7N2fMZMUrkdGBfJc
         mt+Fcec4BcrefRpnZ5s+5LLhIlVXKL89skIaYcT1ReH1T+OemjPwJLyUuZClIgoFVSKV
         M+WCBMSX1aD4sj8Bm264weUw8OeNPbuP8Xe+AKjf77ngW8IJg6NuDY3EN9HoFbKDS/eA
         A0WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCE7r6kbq7ysstepGuLvNpJtntxJakGd1mM+iu+jc8m7fMNHjrtuwV1RcPECm3XewOcXUbcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7s6UTSdVvB6a4+BxCAar+qycVYKMoDMpzcbUmR+ciZ8Xih8NZ
	+KC1tfzs2cTy6+ECYRjYRmoPsx/AtzOAG7FgeDXn3CjbYJNR7VwD0E+e120WZKtmiInRS0l5T5j
	dAdJb
X-Gm-Gg: ASbGncvxeVoQn2ArkX8JxDm0gm+ujwuR8c+bwqfpAE/srDVhwzkkhj+Vi17w3pkABXt
	dVZ7V5zptLbacm8G14LvANwGFmJ0mRBYS3dlbOKq2v6F8ef4ZJ8YwOqOa4keowVnWsBvZ4ogmWp
	bEIH74jcnU6OiBlE4QnDfFR/wxoK/AFxRJpGdSGUf3gLvv/jLbGPvhcVvwsU0B3lSvJfVoGG/we
	FPfZgI95D8YlBDzV4YDHzw1+i8JjBt5Kfi+cijnrU+IdFKnd7EyvYxFRlPQaScDAo5eOyy8GFJ9
	Cna4bqJQt7pfc0zFLFyu45Jxm3oaOF1mGkf4HRt44gVUQYq1EZEBxIRAfS/HQ03NnL3DcD2qXw2
	izex7ppzh/fwGFqg4iX8swO20E2KeXCDOyNrPAf+yqKOyzouR4pQOGcHR5waT
X-Google-Smtp-Source: AGHT+IF1WEdpusCP+BeMXzNhxGYpnraKs8rtFDbaJHh+VNXtmmVcLIGFG75EjXdN+9DNv8IrhqEt/A==
X-Received: by 2002:a17:902:e743:b0:290:ad79:c613 with SMTP id d9443c01a7336-290cb27c76cmr315785155ad.47.1761243156831;
        Thu, 23 Oct 2025 11:12:36 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e2578desm29726705ad.106.2025.10.23.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:12:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vBznf-00000003Bqs-16NV;
	Thu, 23 Oct 2025 15:12:35 -0300
Date: Thu, 23 Oct 2025 15:12:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Reaper Li <reaperlioc@glenfly.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: fix probe device bug due to
 duplicated stream IDS.
Message-ID: <20251023181235.GH21554@ziepe.ca>
References: <20251011023003.159922-1-reaperlioc@glenfly.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011023003.159922-1-reaperlioc@glenfly.com>

On Sat, Oct 11, 2025 at 10:30:03AM +0800, Reaper Li wrote:
> From: Reaper <reaperlioc@glenfly.com>
> 
> Commit 9246b487ab3c ("PCI: Add function 0 DMA alias quirk for Glenfly Arise
> chip ") add quirk to fix hda dma request issue, but IORT logic populaties
> two identical IDs into the fwspec->ids array via DMA aliasing in
> iort_pci_iommu_init() called by pci_for_each_dma_alias().

I'd rather we not have duplicate IDs in the same fwspec, can we avoid
that at the source?

Jason
