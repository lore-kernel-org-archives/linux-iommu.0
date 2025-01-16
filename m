Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B26522FDF5
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058737; cv=none; b=Od0AA3j3sG05dzF+IEceQqoz87LfNqwzSx3wqnVyuY27VD1mcLErO3JNvoDl1zd6cKDEaWPVaz6dEN37ODs1NPyLPWyWH+JD3h+mKFtEFijNVq1hYnlYyCYjL8r1lkjZiP1k8gdUlJ0CEr8PoYrdGY8dRvSHuLNYGx7wjaGElAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058737; c=relaxed/simple;
	bh=TW2t02hwCcCvA4dY7CqwLTCEluJxPrBR26gpeJGJ43c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XISH1JGyYll/78krmKRHxFcJ8HXuX2d3BLmBkdDrbDeslyeUPO/LiXDtY8ogGwhSrOq9HqbFwWEqytctHY7mazT5y9sKtynmAsTBhWuGfK6MTo3q/BwOe3PNp6cZOIw+T+eWYq1e2+Xa3t+9TnRxeRsWG4dA75hI93VzRq9zYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M7MymmnW; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M7MymmnW"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d92cd1e811so22676536d6.1
        for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737058735; x=1737663535; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjLKJevC2V7Xu5ADPJrgzXE+Cum0TiiT74cho1sXgi8=;
        b=M7MymmnWYEJCMnqxcJW+em9M0bx1oBessWZ4u9+PzsNjYQjHL5Bbb7iuiTOrdRHhdG
         9i2U1VKvaIXfZep/MjE+eNWwtN3X4uKU/Og0rx70GJsZNTMBrIH0HM3D43XBbmwOCE0r
         u89YtWPUTcupj5/OSk6herYkBXXyVs/ZHH70wfi9ZpuC7HWOMMNx+Bk1fkcGWp5ZI4IO
         w0RqFARfsXz0IxAJZmtLnG8NOJ0ZsoZTMiztVbVCOHuBVtvfVEvUFw7bme9eh5DHKdWs
         5Ba9Xsf5mn6kE9Rkup5hiWHFpppcU/wePX1weZUcAa0iETr+VzpHboIoHTtgDLs+am/O
         CV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737058735; x=1737663535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjLKJevC2V7Xu5ADPJrgzXE+Cum0TiiT74cho1sXgi8=;
        b=TH9tf+3Q8yO2Z0DzQRCUEQnWO0BFRzFQO3FS/5RDD2AnQQCbRTdxWrUWsNntIRwmhv
         mGyDLqvNK1FGNh8HK1vBAHc7nq25nqYHxYffkiexH2D2jdV4oAp1veKZjl9p9kZBLPJF
         B0ePgl/wrShvMGmjD7ukKxhGmr3VBg0exh+xh86752OhVovnWjEV4QkiX2Rd0jbd7zr/
         j2qmB1Zpx7rfRkQX6H0hMDb5w6SkeUjbMB310Bv33TjqV0OUlyPm4RpdvC9t3nIYfTD6
         viSkU40z8vWcYHgZALC/aYZ88scRckq6qgRIWX5Z9vhAFNZmLPs8xQtEfqjwtVZEhUZz
         3V1A==
X-Forwarded-Encrypted: i=1; AJvYcCW8BMbu8hkZ/EemiBA5fNYlvQ3UqhN1UTY67jHTIZvRtParV4dDAoGsV+3/JlRN0kFCQgV5rw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7qVt1xTeRGFgm6KvDcjMf72lTSHTwhC0icjXW+xy+LvkkeEdu
	RQnnJEsaEBpAIj5e+RPAQiIx4iqMn4cAAwwmh23Rc/LZnWGwt5jx0Kwh/BOlds4=
X-Gm-Gg: ASbGncuz7X0hiQlNoE218zAv4dpPPnDbI+StHekafBt8sNk+oy7k5WNPEWZyKSl57a1
	gMNBfOZ+17v+Uo2SQsHJ6rugt61uicV0lsVsLVBd6oUrsIn17sIod956qJ4VEQoIUPwO0qR6BnY
	qFeC8kvdxxAc2c/WcF/QBwu32G7aObFKnpWjwQwjnwWph4gTxuaUQG/R1Dnj9Z3VY+06GjDhH2s
	OidPqV1CI3PzI8KHuU7rFR2eUNwazSihiP3hBJVyByRNvUnpcybiZHmLD/1kt3dLno9iOFO1yB1
	CB/DDMmf7Rf/JVeh0pWeplm2u3XqnQ==
X-Google-Smtp-Source: AGHT+IGiuhJCb6CE3xcrJekt3qGHV8KtpIud5ATr1ePaT30zfzK6ww+BnPBnVPMzNC6cTFY+JSWjmQ==
X-Received: by 2002:a05:6214:20a2:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6e192ca312amr104688286d6.15.1737058735081;
        Thu, 16 Jan 2025 12:18:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afce4695sm3441426d6.104.2025.01.16.12.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 12:18:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tYWKL-00000002y1X-3wBD;
	Thu, 16 Jan 2025 16:18:53 -0400
Date: Thu, 16 Jan 2025 16:18:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20250116201853.GE674319@ziepe.ca>
References: <cover.1734436840.git.leon@kernel.org>
 <fa43307222f263e65ae0a84c303150def15e2c77.1734436840.git.leon@kernel.org>
 <ad2312e0-10d5-467a-be5e-75e80805b311@arm.com>
 <20250115083340.GL3146852@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115083340.GL3146852@unreal>

On Wed, Jan 15, 2025 at 10:33:40AM +0200, Leon Romanovsky wrote:
> > > +	do {
> > > +		phys_addr_t phys;
> > > +		size_t len;
> > > +
> > > +		phys = iommu_iova_to_phys(domain, addr);
> > > +		if (WARN_ON(!phys))
> > > +			continue;
> > 
> > Infinite WARN_ON loop, nice.
> 
> No problem, will change it to WARN_ON_ONCE.

I think the other point is that the addr doesn't increase, so this
loop will lock up.

Possibly just do return? I suppose something is hopelessly corrupted
if we ever hit this..

Jason
