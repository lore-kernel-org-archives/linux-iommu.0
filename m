Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43DF1B5ED0
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722770; cv=none; b=lIWAh2D2b6x1Unut0svlOMNomrlvqMOckdZxBrS68uXQHISsuxGC4+aWqhzB27HWT/zX79TtwDQKqv40QzkHBDC7+QR6qaOenQJ4fPFJQdp/5+FoAoknsOj4z4eUAJ5nKYjNSsFrj8oh+F4oCzBpNPDTSv37B3kcsapDIqAKtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722770; c=relaxed/simple;
	bh=WafvJUVr8z2C1zDRQCvtKO+6K1W+UrIoTEdLDQdvuUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCW6e9RoABZNNPoHoy0z4F9lN/TiOtQH54m8rOFxQfrEF4Z48gNghBo2jj9pLvEGKn1rV920w1EuE7SaBuH5rxgucvmx0a0d2D6lWtdQzsY+gdRlbAjKbpXXmJV4Vf1IOlSCPNl81dZTbFyltEb19XViv2wMYeML6uddFaQiONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AhxcKSvX; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AhxcKSvX"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbe9e8bbb1so30847236d6.1
        for <iommu@lists.linux.dev>; Mon, 04 Nov 2024 04:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730722767; x=1731327567; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tx1bOostXz+VH0GPtKgcyKswUQOWFhDDl/A9OfJb8HU=;
        b=AhxcKSvXZBr74d6SY1/MD4rPuxL18rzrsKuO5YN7OnU5Nu1Vg78dWwbAZtRgUYhztR
         sKlxqeU84PsHoMt3jMqNIvEVd5uRZ5Q4WPGiLrxpzB0qAYw/uMIe4p+Yrh3LvUv99VUu
         0WvI6ml/DFgQrCuj5BQOTfwxMliiluo26m65WpnJzZcJzG5fs7gqNY3MqS8n91z6bPVu
         BPP4eF5mC+8PQqdaP/2aeQHi7u2igZWLyY2xSuWH8YCEM5V+TbXownz6cazbEVVJJrDR
         QZJ7X2H4rr4kU/wHFNLAiaPHIeIPDD3cMVSScj8xvwMy2bNSUdqjIp7eBkTiRqOzoUud
         HxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730722767; x=1731327567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx1bOostXz+VH0GPtKgcyKswUQOWFhDDl/A9OfJb8HU=;
        b=RosLspIhrgyhlXQrlDXF9RBBNjow0r/iOVBml/bgdf3gHotTJSqsAMmkKmDpEDIdQ5
         QXgt/611s+KwenCXe3N641uphW0HFKon8Jjgf6mcsEIcvh5P3egxA2urmfVq5lsjncsi
         2uDq1pG8s5E5VF+QRgtdwXw+mXkW+X9Xt/NpcToLyUXNTCqHZJW2MNVDSkG98NnDu/Qb
         n8WBVUOPzmWOV7WzLT4IL5Bitvou2QOgv/QrQ5R+9NgdCQTjzqht4VmiCQjdtV85DWNH
         sYHfMf3DQ4FSr9RgjbmKfcwYZOevr+vsE25+KA4baGbEwIW5/SrJuqb2IkSz+QnAy7PR
         Xctg==
X-Forwarded-Encrypted: i=1; AJvYcCWast7nK72U85lJHAECybbvPsGiQ/k6SKVPhtwzX1tEgXGxHXMNBSB1VyCzkRj0EjhW9O29Xg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yweq595g9oN2HqzZT2JUKYYHQzO09xfA/zrDTplZuH++F+4TQjT
	vnrvNCeZkibuIStLvTPZvzG/A9fpC/npt8I6/JFNjuCaTaTTFsQ94r7RAkvUZk0=
X-Google-Smtp-Source: AGHT+IGGw97HgDqXEc70DPdglFSAiLC2/hvL6iix2sWZheUlrSMhSyN4gGvDNAQMyTZfPVibvICZkw==
X-Received: by 2002:a05:6214:3a8b:b0:6cb:c199:462a with SMTP id 6a1803df08f44-6d35c137657mr208089456d6.27.1730722766648;
        Mon, 04 Nov 2024 04:19:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc718csm47611946d6.38.2024.11.04.04.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:19:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t7w3I-00000000hJn-3gHO;
	Mon, 04 Nov 2024 08:19:24 -0400
Date: Mon, 4 Nov 2024 08:19:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20241104121924.GC35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
 <f8c7f160c9ae97fef4ccd355f9979727552c7374.1730298502.git.leon@kernel.org>
 <51c5a5d5-6f90-4c42-b0ef-b87791e00f20@arm.com>
 <20241104091048.GA25041@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104091048.GA25041@lst.de>

On Mon, Nov 04, 2024 at 10:10:48AM +0100, Christoph Hellwig wrote:
> >> +		arch_sync_dma_for_device(phys, size, dir);
> >
> > Plus if the aim is to pass P2P and whatever arbitrary physical addresses 
> > through here as well, how can we be sure this isn't going to explode?
> 
> That's a good point.  Only mapped through host bridge P2P can even
> end up here, so the address is a perfectly valid physical address
> in the host.  But I'm not sure if all arch_sync_dma_for_device
> implementations handle IOMMU memory fine.

I was told on x86 if you do a cache flush operation on MMIO there is a
chance it will MCE. Recently had some similar discussions about ARM
where it was asserted some platforms may have similar.

It would be safest to only call arch flushing calls on memory that is
mapped cachable. We can assume that a P2P target is never CPU
mapped cachable, regardless of how the DMA is routed.

Jason
