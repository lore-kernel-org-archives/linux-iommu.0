Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3A2857CF
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429700; cv=none; b=OvVcq1MicABJjBKqVYMLxI7lXDIYlp47d1Xw1mJ9nalv04YH8nzUNkXnouliXyCuBB1GtF8S/YQaDcmdKb34A8R/RWrelKO5egcpHPeE4UEaK9S1MAQAX36CT8i/JoKjOBb1weg0/Bu11GQMNwPMQzPY85phWRMD4mtcmUkfyXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429700; c=relaxed/simple;
	bh=zB24IJl1jZzMHzgO4K1Iy0NHxHgoWs9FaxvjZYsQalw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inTzuD33tbYeHep3+u0aE0lLsF6gPGGfjPTp5rbAl8BKBBSMbLhsT/RhW6/FanpdEgGyPNXUScJsFejLeVUe2VYZiHwZcKiM2BkIpHGDKPdUP7U4NkdibbvfO7qwtO0iY35+795VQlVdBvi/KUzaLU0QIsUhYWAusW37EXk9v3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ms0kqM+b; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ms0kqM+b"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be49f6b331so8411085a.1
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745429696; x=1746034496; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I+fayQ/PBTnrOfxtrw3IgFnI1QJK9xAjEiHuuXs7Kpg=;
        b=ms0kqM+bYXWucNlnhj2+zrnrLXdIi1TcKHj7igHyBUuQubt7wwuK1Kq02tqYNqsoWj
         YIXD+XUCg8k3uttQ+GpJlBrs8HRBv+Mf9fqgEZe5EmhZDSrPvfaGOohKqnGwjIzhYqgd
         t5xh1ma5SEP38uuDwDgUSi1O7GjiDAMCOqLJJVlOXpYpQoue8GU6JHSGNd6UaJSjVIuN
         m/3o+tBRUCYH+6N4rYxGrUaDkKu4XGv2AjnMC3w0PfDZh0vpILi5J0AaezZODdFc2DsQ
         crnEGpmJX/BpPJRWn3hMCfLcwTQIF4lo7OhMP6QoOzNWbaYUepn3YxytD+0IfRHlRXl0
         dedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745429696; x=1746034496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+fayQ/PBTnrOfxtrw3IgFnI1QJK9xAjEiHuuXs7Kpg=;
        b=rfDNcBSuYsmjDLcFbWapRI4YBpnGhoj0cNgUfdLplV2upLs1WeHIU1bZWEbWT1Vyey
         9G82RogJfrCBq2tUh/UWIurD3RQCkk4gIbjQ91Nw2WWWg/pyZjgdp+Fl5EpiBtDVpvgG
         8T3SceKmDwJHmHH6YxTilg35bhnQtTh3ELeeaFG6Oclg/JfcpVJ4l//AlWpzmFV4JQvG
         LrEBNqLP3q0vbLFp5jiWLnBewAVAnPnitHgUwlLUHUIBKNh198164aXcsseH54sa1Xsv
         eW+DL/YhjvENdQI9fKcPZ87buhNUvXlQRZaK9K6YO/U6fS1lUyYLkFd8+3kxohZX7eGO
         eCIw==
X-Forwarded-Encrypted: i=1; AJvYcCVC6MUeYglNwy0GdHX+sVxkx6DpowxNS/rCDTpF2AUKmOjVZUu5/dQOPVT9PLKDvcUBnzeLBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbKsSEHrpxhpAhVMpbcvck7AzzXUAQLnAPXfQPsSjzeoPESSxm
	7uJTn4+MPzeUk8MLmeaUEBOPpzTe+P6pVcWmYCyhPmD9PdhgQwcUo26GBZj3w1g=
X-Gm-Gg: ASbGncu6j9nla/1GPn5mt460nR5gWzG1vawbauUD//FbWM0rvDpcXxGBvAeOyWzzYJQ
	D6RbU803EPUNB6TLeQSekNGpMlPNy1sfcxzGzToSv/PPeHGOamvhqzL7thG09mprJt7Inq/PpyX
	ErwL+bpYGWXX1BDRvnXAJIlAPLLjasKOOiWY2z8weZsjA2FjeB5ZOPd4e0etT1vusBW1ecPV5he
	J8HsUX3yjf4uxPFa32uZs3SAlHsXcRm/iZ8bxueJiEH9hivNuHW+YVfzaCwxzD+PKvwePTkRgdA
	hvQhfhoKzNXG9xZBvndIib8yIGR4h4kHlHKS9nDtt2TjRB4vkI1+ucOgwJyClZ+nQ2GtJUV1bbb
	j7j35Co3Gv1H5RvQOKyQ=
X-Google-Smtp-Source: AGHT+IHrcKTZfJXCAhkO2WaOum0PT2hRMW3vGaRhpe2sCjwAXzgjbldqD9beTUKDcznlrIIPKNuBAw==
X-Received: by 2002:a05:620a:2953:b0:7c7:97ff:ca42 with SMTP id af79cd13be357-7c955e7c7d7mr65261285a.41.1745429696505;
        Wed, 23 Apr 2025 10:34:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8bf65sm707741185a.25.2025.04.23.10.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:34:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dzr-00000007LbA-2PtY;
	Wed, 23 Apr 2025 14:34:55 -0300
Date: Wed, 23 Apr 2025 14:34:55 -0300
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
Subject: Re: [PATCH v9 12/24] RDMA/umem: Store ODP access mask information in
 PFN
Message-ID: <20250423173455.GN1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <f81331e55cf95b941e6c57f940a2a204141bf2e1.1745394536.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f81331e55cf95b941e6c57f940a2a204141bf2e1.1745394536.git.leon@kernel.org>

On Wed, Apr 23, 2025 at 11:13:03AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> As a preparation to remove dma_list, store access mask in PFN pointer
> and not in dma_addr_t.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem_odp.c   | 103 +++++++++++----------------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |   1 +
>  drivers/infiniband/hw/mlx5/odp.c     |  37 +++++-----
>  drivers/infiniband/sw/rxe/rxe_odp.c  |  14 ++--
>  include/rdma/ib_umem_odp.h           |  14 +---
>  5 files changed, 70 insertions(+), 99 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
