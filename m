Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCC1EC013
	for <iommu@lists.linux.dev>; Tue,  5 Nov 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832666; cv=none; b=BQdc15QBldwbqBFHb/pzgbsKUSVMI4uQqoSoKLmCunPBmN3aLr2cowOJk95SUeT9q5qVIW4ZJOs6eYcz8CD4am6TbCT39A8HLoDRAw3V8F/VCaI50hlHElSXg59AUJ4LFTKoERuaDNfJSuFaYDOE+vq40iFJPxRq+RjfJYXAsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832666; c=relaxed/simple;
	bh=nJnTbD5cGZ0OfD00jTtdrajsLazl3DFTJAxArG9Ps+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCJrMyr2aTzlegLfXvUm7bJOT8lenJuU6/NlPVfZjLxyOBIWfX/ZCAovOtgE7JE1xWCFFmH0GjFngaqvUdX8UgsLfaZ8AGnB/clmB1YhRXTPoPgfi8hsR71iCYpzY5pSYLp4O9O+aLUGTih6V/gBhIByu1MuM9M4loXlpCE/uaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kVJCL0yu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kVJCL0yu"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1488fde46so452142085a.2
        for <iommu@lists.linux.dev>; Tue, 05 Nov 2024 10:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1730832663; x=1731437463; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C194RVyLAfjN0SwVJhWOGUoO0421PCIPswUt8quSHT8=;
        b=kVJCL0yumyaaLRbGpWOJWbSiIQiFVGjNvzQH4dnrPNvpoUUq8xUDl2LFQHDUGVNRb0
         aZRdwQf2gtdV69wf6Se/nucXUdIA2uhHjrTkCgd/CHpT3lYZo4HK/laIZF62ES49+YOD
         phUO3x9cR2JP9bGf7ITPemdeKeDPm3jxf9kHwhpbU0Ut/jpZVqVBktsSAeCSAxVr74s+
         GgqNQIg3aMOUwmPwgQu2hJ9J+ll7xNU+5W4otFGVuX01iP43qCSfE9bW1nOHR6VVhKHe
         7BzNd+ctN5kSJr5EBfTsjjHDP/+vVQajaPJS8A1Ir/vn7NUc5sqMFcgRqyXro/Wkimld
         afug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730832663; x=1731437463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C194RVyLAfjN0SwVJhWOGUoO0421PCIPswUt8quSHT8=;
        b=DI3tV2bdVAp9Fxw0hl6Y3d9IQ/qLx1sJKAAXOcJTAaSjA4oU8D/ewXbAll30V4Xjbj
         BDJ5/GoMURde6um6Dkh3771z30eor9eI+QiOEd1RuYEvRSNefgS1pim1Dc2x4hKl22QI
         hRbuLbc/u2IvYhhSw5QyI0YlYO1FbKC/zJoYRAY99o3/DteuTJKvuqZDoWT7OI5Yu44Z
         ajWkVzRHT9z1mNQVO3WeOl2Nv/yLRu5c/7MIt9vwDFuShaMF11xCZo41ZIofZOahMlI7
         PZKbUjxW2a5pTi7Z+9PIZWtgNfbqOtDQAEaRpmnSdjyPhTUlcMYOt8q2wgGwCKP7WZFh
         GDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5ia6c6oK0TiT6kpsr2bWwUnjv/7HMAJVNLly5YKh75WpyQFLyzTQyloShlcCtAC0pSyfIIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpJfKdUtbwiB8kvauAoSQfcHaJgfLbdqeMa1c0IMyzMgW5VNjY
	MM4twhZpsCKEamwlnnOuvGmXn5+V8xupvuX8aaRdye8ZBiUixCakvHNtC7n6WTg=
X-Google-Smtp-Source: AGHT+IGWpBzbxGzBgv9Gx5tLlQAZYsSh7jgfOX8tW5mq4qsvhcUPgq93VZEIR90XeqIlAFYpEQmgSA==
X-Received: by 2002:a05:620a:1908:b0:7b1:481f:b89c with SMTP id af79cd13be357-7b193f0a206mr4853751585a.35.1730832662826;
        Tue, 05 Nov 2024 10:51:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a70971sm549852785a.77.2024.11.05.10.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 10:51:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t8Odp-000000023WW-0CZJ;
	Tue, 05 Nov 2024 14:51:01 -0400
Date: Tue, 5 Nov 2024 14:51:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
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
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241105185101.GH35848@ziepe.ca>
References: <cover.1730298502.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730298502.git.leon@kernel.org>

On Wed, Oct 30, 2024 at 05:12:46PM +0200, Leon Romanovsky wrote:

>  Documentation/core-api/dma-api.rst   |  70 ++++
>  drivers/infiniband/core/umem_odp.c   | 250 +++++----------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  12 +-
>  drivers/infiniband/hw/mlx5/odp.c     |  65 ++--
>  drivers/infiniband/hw/mlx5/umr.c     |  12 +-
>  drivers/iommu/dma-iommu.c            | 459 +++++++++++++++++++++++----
>  drivers/iommu/iommu.c                |  65 ++--
>  drivers/pci/p2pdma.c                 |  38 +--
>  drivers/vfio/pci/mlx5/cmd.c          | 373 +++++++++++-----------
>  drivers/vfio/pci/mlx5/cmd.h          |  35 +-
>  drivers/vfio/pci/mlx5/main.c         |  87 +++--
>  include/linux/dma-map-ops.h          |  54 ----
>  include/linux/dma-mapping.h          |  85 +++++
>  include/linux/hmm-dma.h              |  32 ++
>  include/linux/hmm.h                  |  16 +
>  include/linux/iommu.h                |   4 +
>  include/linux/pci-p2pdma.h           |  84 +++++
>  include/rdma/ib_umem_odp.h           |  25 +-
>  kernel/dma/direct.c                  |  44 +--
>  kernel/dma/mapping.c                 |  20 ++
>  mm/hmm.c                             | 231 +++++++++++++-

This is touching alot of subsystems, at least two are mine :)

Who is in the hot seat to merge this? Are we expecting it this merge
window?

I've read through past versions and am happy with the general
concept. Would like to read it again in details.

Thanks,
Jason
