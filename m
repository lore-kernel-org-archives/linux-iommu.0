Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBF1991B0
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098602; cv=none; b=q7ov3bSH7chiLYHGh77sMNP10U5Uta5Vidu2FGGaSnkyb7DWTtue8yFTB8xX1xMFUOc82mWylHjBiz6sZHKitW5uZLPLhNu9EW1k6NAKIePuiSrZVZvELzKCmJ4jAxQSFAveAUmvK1WHT9iW0zJpGSYjtzIm9xekQ5n7vqzea7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098602; c=relaxed/simple;
	bh=PWeh5vOh4Bf4cZ6I5oWkB8+DR0Lj/ijoH3W9pObImws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXCtWZOBmkqqQFs7EOnTaFMHmhgA+ANRN4urp7kQFcyEbEtNk2KUDlYlQA2+nWb6maqpT4HI687EQMCh2umaZPVIuIzcg/vHCI3JPgrhj8U2smGltp1Wh40qMV9+OiaH75stJ42B4XANLZSB2ruogzJea3XjPm4K03e+s/rbXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AGWMpsZO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AGWMpsZO"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a9ad8a7c63so475179585a.3
        for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727098598; x=1727703398; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvlhNE5piU/663urUfITp0zU/FAY9sAW/+6EGH8GxQ4=;
        b=AGWMpsZOuAy0hY1bHd95uMjw1u1Ktm0fxvh/IwOsW4rG551PffjbNgZyglNh3diqUn
         I2gnDDQHHErcNEpzYuou6UHWd/AohSse4N0XTiKioWpSGb70W+fdaWXzN7Pi6lsVMt9a
         /evvDfG0X6gQ+tu5Gx30vkS+52T9W9o/+/5KBIZ42ZxRzKrTRZ9DrWj4g8LnXwrECfe9
         BZE87nv4qcxKnvgV2McZxdwIXrOptb0zqlgmP2fylfTbRTzqS2Qlg5VJyZMjnevBIyKk
         ZNRKpfkXIZGn0Sge7gdZQ6xg1Nl1+vyGl1D4gUrBFdjPySnDydd/Z9dlrmqCCEitXG53
         6f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098598; x=1727703398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvlhNE5piU/663urUfITp0zU/FAY9sAW/+6EGH8GxQ4=;
        b=vYN7ED2eVc+p4NTPx4Dwj+Qw00NHi6pSSywOov2ErDpbt6eMi+anRccmtH85xQYidP
         Cwz9xQkgxd2mk8BPghw7kjjp+du1rdYpumH/pQVaJPAL1zT0bhTEAHNe3KIvv6fnB4XI
         6BJDM1KF832/7mNx0ayBpRjqdkW7sKGqGVpk8+N5D0ylaypvoV4kOVbhIl7r5zQLFbAF
         gmHUEWBMqZWUkHxeU2dOyQPNhYXW399n0WWNjMWEe8sKiY/2VR0SHkA52dj1DMohBYce
         3NkPaoMjGOq76F2ntkAvBcjXHwj+AA+2rhzMmf0hMEFCgCFHf474uhqkniNOV8tr5bE4
         XBkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVan6XKSM3pHtPSy/2c1ciluuJzpNQcfLYD37JFmuvRfbIsAqGFEl7tZlN/PWkOCPAuy1u4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUtDHEZBp7D0PL7rkDzz8xkfoLWypSL8p8kn/kvaUNwDX0b0rJ
	9KqmkKWyDJzLgjIrFNZklIYoJaPtLoJLzktPVYs5SjlikqauDgAqJ9c6eC8ZAnI=
X-Google-Smtp-Source: AGHT+IG8nY/c0nUDZcgS95wwLvCpwhg9bmfm8FtbDwp/EI/oonbUwEXDnYa9yx8LSj7p8zXd/swiGw==
X-Received: by 2002:a05:6214:568d:b0:6c3:59ce:d0fd with SMTP id 6a1803df08f44-6c7bc83f5demr172796246d6.48.1727098598596;
        Mon, 23 Sep 2024 06:36:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e576f65sm46990176d6.104.2024.09.23.06.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 06:36:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ssjEy-0002fX-P4;
	Mon, 23 Sep 2024 10:36:36 -0300
Date: Mon, 23 Sep 2024 10:36:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	nicolinc@nvidia.com, mshavit@google.com, smostafa@google.com,
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Convert comma to semicolon
Message-ID: <20240923133636.GA9634@ziepe.ca>
References: <20240923021557.3432068-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923021557.3432068-1-nichen@iscas.ac.cn>

On Mon, Sep 23, 2024 at 10:15:57AM +0800, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Fixes: e3b1be2e73db ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_ctx_desc_cfg")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
