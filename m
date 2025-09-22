Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3324309EED
	for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547838; cv=none; b=m7YyrYRqmV46PP/ECbQ1VPxPr2ugPuUzrzfIP5cpQrKbRGQxt6JdnDvo18rOLk0Pf17IF5uNz6lDfo+m89jW8hjpUztbpBrMbe9uf+s+IABaUMMyBZ1sM+JQnOMHFWqtiAK9NQIYU6b4TTGAbqyxB+2FcwKS83xZPNWGq5sYdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547838; c=relaxed/simple;
	bh=cz+EppApwySK07uus2Zumno8Nob1vgha5YKDQXFkMI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMHlcuIlyIYbWQkcFhASamgOtME6z1mCv2a/5v3WH+j25wfXNcqj8c89Veq9bI/SI+HucOHvfc8UT4HmsQPs3FbahuzHp4ylEQrKXVZvqjGF2douuI+j875zRvbD1ce7sT+LQmbsS88puFx9OGlYwvMX1pzozSBJ4WiNIkhf28c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MN0xH3Sv; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MN0xH3Sv"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ca049e90b8so8475251cf.0
        for <iommu@lists.linux.dev>; Mon, 22 Sep 2025 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758547836; x=1759152636; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=soQDxbku75wcKlRQCmyQHwxlcohTMFfAqg+ZHNumi64=;
        b=MN0xH3SvmeDJCsUyma45Xf8urhW01iQYZQNd8/Tyl+hwmGKwFJpWmhotBJaoveZuG+
         k5b79uPvGLsGtpTsVhseevT/3A7NzL/yqgmR8YkFkxMDeYZQ231bJ6tYxMhi0zLGGmeW
         BBVc3VVxCPIFtTMYFLYVZ/2gm8xOstJPqbzUocGsCxky3VV/bf80TivLlksbxHusLmEW
         uN7W3ZoffRFJLGo7bjBbZlSRsi4fJL2bC8qkO5bBe5aV8iZeZm4621kPbirwDgl0PbMu
         3EoGCLohW9dckbpGe0jpH00N+gdC366S8e02qb6Ra5gCd3Wt19cS9fmEb2LIx7O7LnAE
         /aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758547836; x=1759152636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soQDxbku75wcKlRQCmyQHwxlcohTMFfAqg+ZHNumi64=;
        b=tEflpu4XZPBd/FbzCCjLXhX03u6+zYWdAQ6ibQYnpVQ+U6lzp5hEjMlQdDlLcvIa0Q
         cjSaX7i3Xk1r3Vw0Ufnoj0fhYj1edZqcTxPDeULw4Tfq7q6K0HPsiJgThX6JvbhHOR/i
         XYkVfuu1ZnuYXx2Z8N7pqwJjCMJs7FAsnkr4wTMayi+Y72ovf6n/dqs8NknVKCmYyTy3
         l9Dz/6HLV5M81YkqcuoPg6AJhTXkZQxMRbt7asTgLgAxCOSvZ8gXdmS0SI7njd/bX+qj
         7E1Vpszmh9J58m//z4tZXpAQ029UOrzqDZoXcHIMEnFkaAvB2b2v9cxrPM2e8D5/bimZ
         80wA==
X-Gm-Message-State: AOJu0YyOKjH4m3JhY8yWruP7Ay1t5zMXrZVFZkrAqLtjLaXNzN/51MtC
	v271mqYsmqLq9dKbPXT618IPbyE5zziHOcOdX+bL7CXGEDjRNvOU0TF0z5h4xm+3u14=
X-Gm-Gg: ASbGnctHPK0vRWcQ5G8d6l0gXKAAVdD3mjDPiIgGZawMlWQiwAeCeVxPS2zXeaR7dhF
	6Hs3LMJY/YWJQVDMmk+lmlEd8mOBOUmV86481qC2R3lhgrLIGhQhnozNKrLg/3C3d8nJpJuX/qd
	8qIkwzJ2825RHyz+m7TIoF2bchs8DAgv7iDLLjWH3+GWEKVy5NLntzrgo2o/TcCKSxWwYxOOXu1
	HBnddh+w4U7d3dWCLjxd1OfnV2FvE1i8yNXWPTR1ICxlykCewiC9mB7ud1Pd/uLbWrYNkTNYdV4
	OOkrv65rnmFAQaBXvk/s+RjVc83eJZRCx6oHEzX3/FyJBgVThU5wVX6fitimWt7mPCiGjo7r
X-Google-Smtp-Source: AGHT+IHe9wJVlHUhgN8DEQ7hhP4hzex9JskPCNLwwhsPxRlegpEsHbuCwvoIfwhhlPGANj3noJQUlA==
X-Received: by 2002:a05:622a:a956:10b0:4c4:40dd:2855 with SMTP id d75a77b69052e-4c440dd2b41mr79485051cf.29.1758547835584;
        Mon, 22 Sep 2025 06:30:35 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda25aa5fesm70078611cf.18.2025.09.22.06.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:30:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v0gcj-0000000ALyq-2nW5;
	Mon, 22 Sep 2025 10:30:33 -0300
Date: Mon, 22 Sep 2025 10:30:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v4 2/4] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <20250922133033.GZ1326709@ziepe.ca>
References: <20250922090003.686704-1-smostafa@google.com>
 <20250922090003.686704-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922090003.686704-3-smostafa@google.com>

On Mon, Sep 22, 2025 at 08:59:26AM +0000, Mostafa Saleh wrote:
> Clean up the io-pgtable-arm library by moving the selftests out.
> Next the tests will be registered with kunit.
> 
> This is useful also to factor out kernel specific code out, so
> it can compiled as part of the hypervisor object.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/Makefile                   |   1 +
>  drivers/iommu/io-pgtable-arm-selftests.c | 208 +++++++++++++++++++++++
>  drivers/iommu/io-pgtable-arm.c           | 200 ----------------------
>  3 files changed, 209 insertions(+), 200 deletions(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
