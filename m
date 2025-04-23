Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF228A1D6
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428557; cv=none; b=DDLx0ohCfXC3G3QRFowMqs5rvb99KTBY8MsYIkwIxYAW+Rn0N1nSujsEIaWH7q8UTyorCeBl3A0AEeCvPcoP3kmHiCUxf5Ul6jCc3C0qgj5VF/cE+8oDCg+S4naTTYlM0Mjzu/1l6yx1m7ezPpsWxFjmRq8nU59fLFdl7HGNz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428557; c=relaxed/simple;
	bh=vMXucndq2S6GHUftC4QAjKIvCRBxtQ3mQadyEEn05iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on30cp1LYW3RdJXvGBsQTHiVuxJLM1z6yzIHGVA4tkBjMcaNQSe0BhvW49oDaDAH/COBJHD2oRaYGCekLTxtavjOhgJZxLjRmZJKcpNSlfU8XvCRWF1Psf0LBO4cp97eUY5MFqTKXUWj9LCNkMNhYoXoC6MQcpqcincKjf/TOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oSwryxhA; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oSwryxhA"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5568355ffso6056385a.0
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428555; x=1746033355; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5HpTnu16aeUYpErbp5yUwht+j3Mgf+r7FFUrUseQ0w=;
        b=oSwryxhAgVWSvLjRiiHnQQFxOkpzaTYs2zIeqWHCyqzW0fIH8rzDVuPurgKzwKPZLw
         JChrNXAb4zSapBbUeTDNDb5vYmk14giYH/QXHzlO3iyaVQcXXVteiKqVT11qSd8C1mV1
         z6XJKvCjgC5QaKPVJIvm75G81kYQUM6qbuABJbhFJqbuJ/u2LMOMYtqlZ+hqtk28FAWl
         zr5XzQ1SL/qtFeQtoqXU1/yXo6JVdNhfKVi96y84WjhpCXgrSI0ScfaCEJn5IGf4Hv9A
         qNm56xITyGhTTR0HjKoqJqIHUJ1WGl9iYRyDUzspMjRueeDkOqcvppTyanALSOinOqrs
         Ps5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428555; x=1746033355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5HpTnu16aeUYpErbp5yUwht+j3Mgf+r7FFUrUseQ0w=;
        b=eooZyT/TPMEcsS+fA11Oy7YvOWSevRQEuJBlZwtV0tZAKgaVLeIfCrCsVpTDsc7kyu
         I9L36lwuxuPQsgSjKNMH0YaieM+6xYjNRuUxLHIa8OreGqS+wjjWuaVOJWetx0KHH+h/
         JtNr+qNgLdWUAQDNOrgG9GZ9UQ7xeo6335WHScchGtB18+MM8AP7Zt7IDQlqbDo3rJ/8
         Vp5ed/YgnAO5dT084OPs+9f86ihPkC8soBEvHwRVTEIDIOAqSqZ1+wBh5qT3Ve3+uB8J
         nL4h7/MHteZWaO2EyQJuJ8wwG9F8Iiwe94FSS7Uv5vpdM33sRwVVZrdA+b5ZEGAcq1N8
         YS9g==
X-Forwarded-Encrypted: i=1; AJvYcCXtH3LlO7ZcacA4hiU2/Rphw5K0cPybUFsMrmvD0ZsNXazXBJIQODPz//QqRXh3pYPJT9KCJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJpWvrOPZmVIAhHPyJe63ZIbvQGuQmYXpN5A8oABSHNru2DBIg
	v+vD92JMtMyn+9h/9WWy9UVOEnaOMH+euxPxWl9UsiZzppW36//Qkil4hyd8bVw=
X-Gm-Gg: ASbGncte7Nt1VFlbrEft+U6vThtsHEgfVFuykCIn2tsyPfMEg669Y5TILieBOhaEX53
	DwvJ0up77nZzFQXk2jHj9kgUlX1AghrddKovcOTtH9S/ltXTuoLBXzQu4lzcp2cZ4bih5WxexXf
	mHVwEfJ6jMV1nxgtiWv7fWIarUU5nGSGNO66V/qIGz+ZbxaKVm6YWy1zMhgWjZ19iq5wsCZOTWL
	Eie/4OP9TL6JkJa8w+4z49yjNP/hzZSdfpCZBh9GjkDlgqfAUcnIIDcsSTJh4oIIaFOmuXgb/fa
	ixlb9gprK5RWkax9woRhdRt4EIMGr2jY4/2I4Wuyp6RcDOlAGVUpu8MEqZDny3Cskj/91oX2agh
	bhmdWizK56RUQGfJOgvE=
X-Google-Smtp-Source: AGHT+IHusnUQ6QwwVsDnvg+0qYOM6lcQLPltCEX7WmRgNJP3vwJodfip7PxZnn5pgy7BG5cQ6pnE/Q==
X-Received: by 2002:a05:620a:4456:b0:7c7:a5e1:f204 with SMTP id af79cd13be357-7c955e14768mr54555485a.56.1745428554903;
        Wed, 23 Apr 2025 10:15:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4e93asm705867885a.70.2025.04.23.10.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:15:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dhR-00000007LQy-3kud;
	Wed, 23 Apr 2025 14:15:53 -0300
Date: Wed, 23 Apr 2025 14:15:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 04/24] iommu: add kernel-doc for iommu_unmap_fast
Message-ID: <20250423171553.GK1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:12:55AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add kernel-doc section for iommu_unmap_fast to document existing
> limitation of underlying functions which can't split individual ranges.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Will Deacon <will@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
