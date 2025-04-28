Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211681FE455
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846195; cv=none; b=BFUxo4hWo9+i3lfHUMSlJKlNz7UkLi0OltXylsxG1uWkTww05183dfyhOpcGgNgYeCmmXAXRADDLWI9F0AbqcFLyqpHqA6UXlsL3rXlaYlYWHkj74MjvKYHsn7IpwThEe0YSrRUXbNAcauHtMftDgvwBbDGbTdeeL8n81U4N5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846195; c=relaxed/simple;
	bh=NW84TxEhdb7ZElUc5cFUgz5zc5jpHgx7GoeBgURA278=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/nly2meZNNO+LCZVU5163iMP2THm7sr6xrgAK7P7ZVcKySBqobSROZOezzJN5lFIXNvPGb+mqWuyR+CTqxS8A6tKVSBW4/CdJ1RUiTAO8DQ9g0lFFrX088lCnJGxyyN2t3tkC3nmvPbJbAJH6BnloY+D33qUxjwElzILiUxaCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ar5ApTtt; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ar5ApTtt"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8ec399427so45886326d6.2
        for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745846193; x=1746450993; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4DHTb7AvO4YicH+xSWtDalbuQanacnJSYHX0xM691I=;
        b=ar5ApTttzAuk3GWgiDBQnhtksOCw2tvqyxaYI+PUWWNdoCF5Acqkhx+hEBbQrXKPc3
         /dYe9aMW3Wl+BfU3V1jcb4sa6scibOdswpDIDulv/mNtDDPZDFKtmw+GN1G0OhINsvBj
         e5HBDuQD9ialniwUM3ajNyZu6Ji+uB6PfgptH1BpJpzbnYk88bLL043uFu412GAS1LKI
         MSlsIIFqeJBo5CQezcqgLHG8chIqFWHfaEky2RiYyS7B5FMbyjkVpjlIZxbjEdxJz3w3
         0E99K2UdOUmlaVNdsZTlV4Cw+0cjhMRnMx09/kblw7yNKMdRKPKqTzVshA6W37VF98TU
         1AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745846193; x=1746450993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4DHTb7AvO4YicH+xSWtDalbuQanacnJSYHX0xM691I=;
        b=lE196Kz+5PBvRN3ZO/43H0CN8zcDBVq5o2uP7fkAl3dCCmDKA86tQ+ohJEwA029N6M
         EuFkV0Ro3VaO5fqzdCc0SO0yRhgqNsaj4k6Y5Uh4pooGL0KeXjXfNkUrDQjDLRb5kCaP
         2gwaUnuMY19X7kFuu9KL8K8VB5+W9/5k21LN5gHAJhcC7z9I6ORk4eDAguKysltIJO1D
         QseYJH/TIeNFx9GETXu8XrWpOGiN3mCS1hkLd1kJuu+MI4DIHuWkPyoMtwGv+x4bwLDG
         Pf7e8mkgotIpGMLJ6Rs7UdLoTfoNIKQYZ4UYEmabHE21m+veKkAOFEVGbw3Z6EQ80a+i
         leJg==
X-Forwarded-Encrypted: i=1; AJvYcCXYcc+/Guz6qEsueCRdkjsz1sQ4tY5o4YsPva9i7D0B0Ic8iWXzQ/csPi7cI1KLdBbQjNiDBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCTLAfqDnEWBv3SYMCvgWCpMe4Wv8DGUVJkOlEpL7kZ1L3CJl4
	FHSh37ulujWXKQOTRVrFjSH07CKnFKxhUVAfkK6UNwMbXlBgoIhPBGS63fjffBo=
X-Gm-Gg: ASbGncuUUuSOUwHZmKa2hRnfYVnUXAr4F41yvd5wDhKlH28xeaX5CsTgNMG2RXAj+4x
	n53oEHhxNVQuFLWyyWPbISsgqbYmxGPyKe0R2/SVNoFuGBBB2lj5Q+d9YFSuG7VJVrvcSrA6pgz
	KLzirjttDIW9Lv1gsmS9dNvu8w9t0pJkrHY983AFK8AdnAtc0XlWxIz8jhCwPW5uR8JM9PSXntO
	I32j0JXAvgyjHhHlUaseNznfN2sjETMhKYqcoFtBJNt0FtwndGoxzQkKUjd7u/pq+LywgKjdUpf
	99vpFHOSSAUN+w1tOwbDfK2CGPOMl1M+VDgnX3vQsBZy5/yf50E8U+YxpPBZFeV3l+Aa+QqxLtt
	oMshnlpPw3K5CMTcQM8A=
X-Google-Smtp-Source: AGHT+IGm1OrVyo7NrhtixKONc1TT2Ec0eky4BVMvt9fZIav2cWhkRh7ddfgsBqvKXcfpG60XtXV5Kw==
X-Received: by 2002:a05:6214:76c:b0:6f2:d367:56bf with SMTP id 6a1803df08f44-6f4cba51bd9mr207427746d6.31.1745846192886;
        Mon, 28 Apr 2025 06:16:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c74d3dcbsm53164536d6.50.2025.04.28.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 06:16:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u9OLX-00000009TaN-1zxp;
	Mon, 28 Apr 2025 10:16:31 -0300
Date: Mon, 28 Apr 2025 10:16:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
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
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 07/24] dma-mapping: Implement link/unlink ranges API
Message-ID: <20250428131631.GB1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <2d6ca43ef8d26177d7674b9e3bdf0fe62b55a7ed.1745394536.git.leon@kernel.org>
 <aA1iRtCsPkuprI-X@bombadil.infradead.org>
 <20250427081312.GE5848@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427081312.GE5848@unreal>

On Sun, Apr 27, 2025 at 11:13:12AM +0300, Leon Romanovsky wrote:
> > So arch_sync_dma_for_device() is a no-op on some architectures, notably x86.
> > So since you're doing this work and given the above pattern is common on
> > the non iova case, we could save ourselves 2 branches checks on x86 on
> > __dma_iova_link() and also generalize savings for the non-iova case as
> > well. For the non-iova case we have two use cases, one with the attrs on
> > initial mapping, and one without on subsequent sync ops. For the iova
> > case the attr is always consistently used.
> 
> I want to believe that compiler will discards these "if (!coherent &&
> !(attrs & DMA_ATTR_SKIP_CPU_SYNC)))" branch if case is empty.

Yeah, I'm pretty sure it will

Jason
