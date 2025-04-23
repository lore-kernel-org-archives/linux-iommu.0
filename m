Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130C28935F
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429938; cv=none; b=YDNziamnT2Xf6h0LJm3szaUUjNkmlnYAV8pAajV+VSB56J//UZvcmayROovbPQ5nJ4ffwvfn9xCptYwmyg/HJVTSRm+JDRAwIJSp/GNgSHABhXaV3MLPuCs3aCwk5vrQAFdpA/ywGt6S3XQsy23emiV8O5MGPeHaaj3R9QFoc4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429938; c=relaxed/simple;
	bh=jyCSrAMbJeJJMtfyLp932NW76okHOgg35e8+PFG3Bes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7Q9hdEQb+ioMTN70rR9GP4e/Qwe+WsS9Q3cxg1eH2igWxiu67s04OX6TMjtfCesf9fBEULZ6kTi4Z87jxXKgnuCpH1POt1BEMLH7vOjKlwZULDpuky2qziDGzPVsPkpv6hPHNFWY8hCnMkGY8n3VVLWKu635pvIfBAkBtgFnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AEmttZvL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AEmttZvL"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c5675dec99so10035085a.0
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 10:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429935; x=1746034735; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=AEmttZvLNoXQhMhfbwN9/oSgp1i4lp6t7qC7IBq1DWg8kFraGjBLGG/BtkNdHH59vn
         3jHrAzdWkclLtVfg8Pit2juIZu04l6GLWHrV6pALXNcZw62XkP2GNxk+3hiHd3Ha/SRG
         i6WDvxBH4eHUN5cLGTPQIvH+WdW4rNw8mWNaV+slcNPAzoCiMpDKKhZqxRshMEjMlRzx
         ty8VM/eoXzbGx+fvn3NlNe4kB2uf3BfjGWiR4dWzgk3Z85e17A7pYoMnNdHh99M6IfWu
         6yi52dDDhOhZuAUkEupXvEnRGGGfSco+eH2JngeKBkethXj+fzvnEcnK18b9vmhx2v1L
         YjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429935; x=1746034735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZKbLbO/VBglO/Va9GZRrTXMgQWmFJOWwhYhgpmasyg=;
        b=w1NbIjZ6fIQEOWWcVqWKP2tggSvgF86mbsVYr3p352l0Fu2PDETpmsL6PLTvxFb1iY
         B9b49+7piO3HKvFRXmALXUej4q0ZPtEZ8UIFnoWctgJuHLh5V7rYzjk3zEQK2Gt74lPZ
         biEto2NdKg+MTDohI2/zrbTnC4g5111MympP2Rh55zquuhaZwNUyzSL3hus486zv8Aqy
         pgblaXgz2HIBm14kiMTOu2+8euhXK/VtbOaBfRmcU75igAgwIGInVrB25q+8j30WEbsv
         8tXL7W3mhqEzNAqX3M2r2B4MM2yqYhw4GwoqJ/yT6xUnlSMHLpEaAkxlrl+AoRIV+LRf
         y8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWO8jdjpIap4Z4OCcK4XfiXJee+Rj2nmT2+nW7WZhTQQHsaVjb1twJEOQeUXIu9PZ9ouMpEmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYUq1wcpYu8I7KFj5qiUE2UrdM9Yc6jGRUJ7NWASzkxGsHv285
	WzHc1o9QGJdRLXt/mWJy/ZTL+PUIEm4LQnldXrXRET7Ps6RQ7yxLoexw8WAH6VQ=
X-Gm-Gg: ASbGnct5EKQD0hnJ1Mvh3vDVZV6kip657NtJYKrHt0M5k6iu3KdD3TYXQAONVpRMivE
	FmltomIgNpYhG6yl+/NnDPvwMR6CyfjrmofKFvm+KCsP9jJe2T5vYrc/F1eYgp33H2Aa5EHtSHM
	7ZIcu15dUmhXU6K5G390t1crriQxfl3lbKoM+Dcu2TOFbAolfUV2TzFp3AYgUapVgPHSN7InhD4
	etFWxAhwSmraUCNrIqNwOLjBBqbZfnyBpu8CkWZKbhxTFaloCcbjsAtGRwWNDXEzNngHj6gR/cj
	UD0NyHDwIQ/wJjH4+A2/pHUisPvSx5k4IEMbbge5rIOhKCNAPj+kwD3gUrcE32IWRCcrQROoO7g
	eLmClrFbPGyTyHEbqOzI=
X-Google-Smtp-Source: AGHT+IGgN3qsfS6onNY8+gQMZCTHD3MSF9+S5w+6n1/7VM1d4IchwJLfZsPm7/0ZCJyeB599ZskZwg==
X-Received: by 2002:a05:620a:1917:b0:7c5:ae20:e832 with SMTP id af79cd13be357-7c927f6ff15mr2997015185a.11.1745429935582;
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8c9f2sm708523885a.29.2025.04.23.10.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:38:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7e3i-00000007Le6-2jjE;
	Wed, 23 Apr 2025 14:38:54 -0300
Date: Wed, 23 Apr 2025 14:38:54 -0300
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
Subject: Re: [PATCH v9 14/24] RDMA/umem: Separate implicit ODP initialization
 from explicit ODP
Message-ID: <20250423173854.GP1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c79721bb70988f60fa23fdfb6785e13f6ef806c5.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:05AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Create separate functions for the implicit ODP initialization
> which is different from the explicit ODP initialization.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 91 +++++++++++++++---------------
>  1 file changed, 46 insertions(+), 45 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
