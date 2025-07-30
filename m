Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4181FFC59
	for <iommu@lists.linux.dev>; Wed, 30 Jul 2025 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905535; cv=none; b=Kh1eWLwq4kh+7xakyPKyo66qsK5bzAJFX/2YlBBGjdY0H1FeGCYiOcHCnGCm36HheD8KRxhBi8BUPzOzEQyI5jOeDzUNV7f7Lu/t5EeVcL8WURMXbiys8VvgLgfWuogSIqMP9tBZDJ6sRx/MG+k1dNirvOA41riTdUggVJb5AOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905535; c=relaxed/simple;
	bh=CG5SKXa8zPOQn3DCX5/e8odAxj8sWImHdXc+IA7A+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxjkNcD/t29mpZcv6kWmTd4f1CUGhoXvhNCn7ne3JJDMF1UEaIWCS6R9ZIddQX8nfjcS07ourYppjso1nqHTOfIximDTv2Rq2rHMzvllxMGnG9oGwOLFrGRiEFNGk0AYlyjSdPIvWQYMxfNwkh1UHvKQK/NATIxp9nFW1hIVDuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zwipy1d/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zwipy1d/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753905531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MJ8yWqGXhru7WhV5DGnUZnDJthF7Yg1ZkZASyV+JWoM=;
	b=Zwipy1d/+aYeX49YUl3RPWoAUZbooFhei0QjfGCwO7B6gicBefkcYFOHLVp3nRcdVyAnK8
	fz9dbP/EKgOzMP/UlVW7s06aAtjY3f8I+AnGHnlKsxTV+SZKY9U+K8UdHAtu69hNexPuN+
	a5nOYkou2V0wu0FmawyGX5zof/5RgdY=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-ZGeQfyztN7mnKX9HqKFgSw-1; Wed, 30 Jul 2025 15:58:50 -0400
X-MC-Unique: ZGeQfyztN7mnKX9HqKFgSw-1
X-Mimecast-MFC-AGG-ID: ZGeQfyztN7mnKX9HqKFgSw_1753905530
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-881327e173fso3159639f.0
        for <iommu@lists.linux.dev>; Wed, 30 Jul 2025 12:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753905529; x=1754510329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ8yWqGXhru7WhV5DGnUZnDJthF7Yg1ZkZASyV+JWoM=;
        b=GVnq+CO51v9vmgzttGUdx4Sooq74pKiVXclbXW63m/db5qV70eVccARB3YjDDtR2fW
         Ou7JaMqK5QXtiPiJQyf3900MWBL9NsOY7lkrmzSWTD5h1WbFZWVf0LE2eAwi7LsZD7Ok
         91QehriE1q/nTxCYLfC9XcGR4UyrVP334DqhntwfVfhP4XP11TYI6t67FDb2HuZooF/v
         CIez1KMWhIN8Ntxz7xTdaovHGOB95u6AT//ErTxAnwmgTxGgiTrljonbllykEdydRnEQ
         u2OGXu4VCiUHvwOzc78HtguFVqw7aOGJrLin659NlEfvJ2/Q6sW5evcbzaRB5VYRrC9H
         m4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU6WZ+2AUwdAN3oxdnDczeLEoSrbA3T9YCHw8g/OJPdWbc4gTnI4f0tGjFyYPy0ZzE/HzFOiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLQbwMAJAv6IG7rUzs4814XQ5qtzyAcbX0aC+mFzwoeoUxq4PZ
	FiBPvMhd/rMiDGTuNIwsb79vnkX3Ap3g6q1NdeYfGGCNZEMLDb6YKdyza9HJIbyWAhIrNMtprM9
	eKA5GWmY04uO7IkoAQuX7HUnIFHUwqHlMCkYzgP4ulDparSqgK7AP0H7O
X-Gm-Gg: ASbGnctzhXDuKzfyKN0MCKf8c09nk/umqb12vS3Fb3dysVoxiz8LOiCpCphNHlqDOQX
	yxrdxtZ4Nj4hSLTVUkmyB3bVSRGXv257nyKZmpu3QFYs5T6fcbxNfb4Wuk9GbZOw/GJKghW4JVw
	USW5fE7+rzNmyqa4bykzQyXYsrjx/4SChLyxVUvNMtlHhCBL1U263oaHpHUOTPW6hc5h7TlFd5H
	K+v9HAdCJzu6E/7bf5yeB8JWtAVbQSCr3NnYmFNOVE/Q41O39A2rlv8zcyq6UtO3tCgIRnEdaAF
	ZboaYAUqCs2hk12bH3fkLwtQZi0uI60p1ByHodH9uFk=
X-Received: by 2002:a05:6602:3403:b0:85b:544c:ba6c with SMTP id ca18e2360f4ac-88137489c1bmr247637339f.1.1753905529639;
        Wed, 30 Jul 2025 12:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqzTNDwtWgU4diezEDNzfWAqDpdNRdRLffgeb0LuFILxM3AuzO6OxVkpYobVhQ8ZrxcWgziA==
X-Received: by 2002:a05:6602:3403:b0:85b:544c:ba6c with SMTP id ca18e2360f4ac-88137489c1bmr247635939f.1.1753905529204;
        Wed, 30 Jul 2025 12:58:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55da3278sm19521173.84.2025.07.30.12.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:58:48 -0700 (PDT)
Date: Wed, 30 Jul 2025 13:58:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jason Gunthorpe <jgg@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, Jens Axboe
 <axboe@kernel.dk>, =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Logan Gunthorpe
 <logang@deltatee.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/10] vfio/pci: Allow MMIO regions to be exported
 through dma-buf
Message-ID: <20250730135846.2208fe89.alex.williamson@redhat.com>
In-Reply-To: <cover.1753274085.git.leonro@nvidia.com>
References: <cover.1753274085.git.leonro@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0WIoR0hog63OPAL3z2iJXu8DFmYUzHSL_-iwJJkOSlM_1753905530
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 16:00:01 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> ---------------------------------------------------------------------------
> Based on blk and DMA patches which will be sent during coming merge window.
> ---------------------------------------------------------------------------
> 
> This series extends the VFIO PCI subsystem to support exporting MMIO regions
> from PCI device BARs as dma-buf objects, enabling safe sharing of non-struct
> page memory with controlled lifetime management. This allows RDMA and other
> subsystems to import dma-buf FDs and build them into memory regions for PCI
> P2P operations.
> 
> The series supports a use case for SPDK where a NVMe device will be owned
> by SPDK through VFIO but interacting with a RDMA device. The RDMA device
> may directly access the NVMe CMB or directly manipulate the NVMe device's
> doorbell using PCI P2P.
> 
> However, as a general mechanism, it can support many other scenarios with
> VFIO. This dmabuf approach can be usable by iommufd as well for generic
> and safe P2P mappings.

I think this will eventually enable DMA mapping of device MMIO through
an IOMMUFD IOAS for the VM P2P use cases, right?  How do we get from
what appears to be a point-to-point mapping between two devices to a
shared IOVA between multiple devices?  I'm guessing we need IOMMUFD to
support something like IOMMU_IOAS_MAP_FILE for dma-buf, but I can't
connect all the dots.  Thanks,

Alex

