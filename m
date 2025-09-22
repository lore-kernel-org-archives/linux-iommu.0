Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7B30C609
	for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547814; cv=none; b=CHxl9zEFUoEujwTd5nOszkWpm2QV9U+BPIqnGp9gKIKYQQScBmlbnYfnDDrByVnlKOudon8TRlR8cCgly7tA2vJyBhFdvTuWJEvEJqnGfo5QI1L3P7vHEPXA7KBwPFRvCp9iFLizVmXl8RRSPpaOTjnCf6DozO0AVwLIXpEt/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547814; c=relaxed/simple;
	bh=y2+sNh8F7BJ4b0OtGqFkua6WrDm4Bnv4O9Hd644lllQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4AyHGOMwLXFw8IldzyyTMGtGn/ksoJStJSMvEvmq7sf3BmZ+EcLcOhBaTXru6Rcjymv3FavprRSCjrtKSbthohJtIIOOkXuLc714c7oDcYtWhWA7Qkff115GZ7awsPO8xaucnLLai9w0Bj8BpyumpYHAI30umKo5tuJFbB3Y24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=euJQyDz9; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="euJQyDz9"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b34a3a6f64so35331591cf.3
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 06:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758547812; x=1759152612; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y03k4DFLRprDfdbyLDspwlWtQehDogFzjJI6AMgeKrM=;
        b=euJQyDz9lyRXJsm+yx2jy3OLdXrpXZTOL1PYhJQT1ljF1r5eOMrGEhvw6V6JI21/YM
         vfTpg9WrdLzO6JHV/73SybzfJ27MphUIuEL8tRfBCtfGKy3QzQ9aRgd84Mcmu78wl12s
         uMjGaTWj06EyP1vUCAEXc0Mz8z0NPFYlC/YtVo4ClM/GfTc7P74c2OpTRGNwJcUbJqw5
         pCL8bW9wTnmtno6lya6Tg5omB7Qf4N6Fc28uR130kFRba+0ECLv4SwQalAmMkimu1wOV
         J5r5DoBjvcAMYwaszHxaje6wPF0c37cZN5hbqf7wdY+EG/tEgIYPCRZ0gUPR2ENd+JGE
         x+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758547812; x=1759152612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y03k4DFLRprDfdbyLDspwlWtQehDogFzjJI6AMgeKrM=;
        b=sgWGK9rW8bi0I9RPnw0jZboweG5x4o/bMGFxtW0WhHKKaqDl84b9nYcQToSKb+Lkd/
         vNNnlsgx0NAgs4umKAprgYDjy9rM3tUNbtyeknDRXC/i+A/eXdkOqAf82G8XmwkjxTpH
         048+aeACYSU7ShRINLIrBPJmGUT7Gd2+XQB7O0BTRb2Ik5atuj3QjXQ7avN1r6eAWQjQ
         3fqDkG+Ilvz2TAeeWJbGDyeC3mMHBF3VzssmVTnkW42s7nYs3p0NX/l2xM2u7IR4Oj7V
         TAReRw8DrgHCiLrllC4jdQX/v01UMCmM34/PVnaGPMfE/5umHupsEwOhWkOmeK6usqnK
         f4Pw==
X-Gm-Message-State: AOJu0YzzucGAqxB51zspX8HPCfzPl0t1Ggh5tir6ZcjZ/vypYmRqLGN0
	iF/PwIv1Vxb0wlR6BhoAVTe9baxIVGJeKSw9MQ/6YKb7bPSTVqKS4AEh/GupJaddbsk=
X-Gm-Gg: ASbGncv7uYd3r+MxgN8k/HJxISuxgX1qlte8QHX78oXGwXP8b2F9jJAF+bkvJX/WcGk
	qxS0sSKc8XBH3xvAkRGgQ9qE6+0shKmRcKGMqv5tOfAm77gEYJbb97aPLBZUF62gY03ib17xMIg
	BGEE+YQ4dhKweo9pwje9rXK0hooC4UdGnpu8nhb1Ce2zjJ5pwiSkP7YixqoWfGJ57yzJu98+5Gu
	IrJKq5P2tgyTNxFDJpyIAyVQ5lWMja1Vh98Rt4ciNyW/ddHQLZ2MygFlJpH9D9ZrPtxUW7ZlEux
	PovYrPJ1TSiC1Es4G9kZA884lt9R+tBIrwsscxHYjOdde5HnOxabX5xjibOIrp51Tpl82VYw
X-Google-Smtp-Source: AGHT+IH4XwIxdKdRzW2o+GACM5iQvve0syctd1r00LPQSbC18rDTaAU9S+ss/ne+khceFU/HXjRUbA==
X-Received: by 2002:a05:622a:488:b0:4cc:6d84:8199 with SMTP id d75a77b69052e-4cc6d8484e1mr38598321cf.13.1758547811879;
        Mon, 22 Sep 2025 06:30:11 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83d1352f390sm566847185a.15.2025.09.22.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:30:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v0gcL-0000000ALyP-3XIB;
	Mon, 22 Sep 2025 10:30:09 -0300
Date: Mon, 22 Sep 2025 10:30:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v4 1/4] iommu/io-pgtable-arm: Simplify error prints for
 selftests
Message-ID: <20250922133009.GY1326709@ziepe.ca>
References: <20250922090003.686704-1-smostafa@google.com>
 <20250922090003.686704-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922090003.686704-2-smostafa@google.com>

On Mon, Sep 22, 2025 at 08:59:25AM +0000, Mostafa Saleh wrote:
> At the moment, if the self test fails it prints a lot of information
> about the page table (size, levels...) this requires access to many
> internals, which has to be exposed in the next patch moving the
> tests out.
> 
> Instead, we can simplify the print, using ias, oas, pgsize_bitmap
> and fmt is enough to identify the failed case, and the rest can
> be deduced from the code.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
