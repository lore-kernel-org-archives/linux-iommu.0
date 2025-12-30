Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91621B9C5
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089753; cv=none; b=m0/8+D9YB0poJEqlr/uCauAjH798ODs3l7Ue8KW99tZvoNiYtsFYAYU21JlPakkg0aaKkoT7ESXwsIfP4tPf/LyncDA4r1ULiUUif8wbvrtI+thP3PNpC4yuIpJr2HcUwYV+vBlFaHglgvxOEsvP1Cvrk34DMADGdmrb/ufnITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089753; c=relaxed/simple;
	bh=LCt+6pV3SVXX+jVlhPofZ+B+PV2iA9I/7Ha5xrB3hCU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RwyCZEVCse2Fc+qX0Fm8sB73pKJPtNV79PXrKbxLYPj+2k2UQ1lmRxg2bbELnnJYmbGJRr6xWaamFy19N77OoqwKbH5awGUkax77K/hrDVOOfxIINHNchImkIo8fV+OR85B3FBfZtdNLSOV52O8Pe2XSyA7u+EKqOY+7ayilx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0yYMVW3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0yYMVW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QPeHJm+twCiufdOXqLeCn+SgUmZXimx3Kj8OMbSgWcg=;
	b=P0yYMVW35jxYgBF3YWX+d5Ks1WvgEpHVbY7hSsHdHk78Zw0WyrCeBBSmS2yyK5oTbRjjF3
	I2ThzC+UAqPDYagw+qh9Y0x6x56cCzUJauXeqWrqndmgRCxf/08HSGzrcABR2iQB8QGVxM
	4lSXGaXGdADw9gUk4PbTfeYlI1of3DM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-ch3wjNNSOZOeejjugjyTEg-1; Tue, 30 Dec 2025 05:15:48 -0500
X-MC-Unique: ch3wjNNSOZOeejjugjyTEg-1
X-Mimecast-MFC-AGG-ID: ch3wjNNSOZOeejjugjyTEg_1767089747
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fcf10287so6886327f8f.0
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089747; x=1767694547;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPeHJm+twCiufdOXqLeCn+SgUmZXimx3Kj8OMbSgWcg=;
        b=jSzPo9GB758OcpfLoYi7QfWs6L8hZSAM0RrHMjUfjsJt2CRWHiw984UkbUhG2Anz6o
         Ye6LtYPr8kJzUkaTsJLbMujUv75CZNMkzEQzDUVO5VLUF7wG4WeZd5INp/iXwgqSEqDn
         FuT2jdLKZLY9ZbRgqMOU+HVag/4BmYPgpPU6KlHGz3r59q/O/voQSvwVtFztK/+fJZtp
         YRaFqB/V1N86p7PfrhSNk+8N8QbUdIhhLdBK4ZcK9aSwG/u9p1yhiGH+kFKbL0UGXfot
         L0UaH7M+4dPOkNFBn5vlGIxq3O44S6JokdExS3zMhBdVm/LK0i5s/I+X5qz8M6CtXZ8q
         IyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdXMC1WylgobawRYshls2/sVb2nZy2bNaW1NnfgRjqWysN/AVLHmq0Fmh9CsvKif5O91Bglg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbysBdqheMZNHd7dTSE1CyuxFAlSzDIp07tER9Fqeo40fjQ/gl
	co1WvoF8IIKgxmvvIhPA6/TyQ0pUSKlaj52yj5l2e+xRhvq1Np5++GgCrib+I6C7eLPIUsjlCJV
	tWoQqhXH/obWc7iOjPn4v1X0Fn/QOkGkDF9gm7NxUxiKNFldMAFvEEN+H
X-Gm-Gg: AY/fxX4MEdZAYcMQk47AScJ+Uo7kU9syOkeB/DOyrbIkZfkYtKSSJGhJULnCn2g2Ln/
	xRYXeecrVxxfQOHyL4CSiXyl+6xsJHpegq2cxLCCV6Q0TvNAwBc0OYyI+90WbSJ8GCDgf4vE0PR
	obqbqsKuD5eVNwCIrxdo0L1ztNa/FbT1WkJPKFYI9vecyaqnOJm1CrLSJRyflnXVUkLtxUxe4Qf
	vDgG1OYIVAf6EsMNSI7+tTJ5aipIr66pVu3VeS1GyEm0Jo9ajCJDJS9mV3balTtcq8tFYeD9vk1
	HYXcUxW8/8V8QCXfHkDriXqa/zn4+vYFs631MHVYGn16+eN41RfgE8nbXmaGfluwPhGLzUT8yES
	i447bxiq41zMNgdEvr8PPsp6t5MwpHiXO0w==
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id ffacd0b85a97d-4324e4c1219mr30005603f8f.8.1767089746603;
        Tue, 30 Dec 2025 02:15:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbvOFHJ91a0TKLxq+k7tMABBS8U1GQCYZPCELRU5Zsc1Gaj+GYCwYcD6RmChYOtX8+5x3fqQ==
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id ffacd0b85a97d-4324e4c1219mr30005566f8f.8.1767089746108;
        Tue, 30 Dec 2025 02:15:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm67681523f8f.0.2025.12.30.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:45 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH RFC 00/13] fix DMA aligment issues around virtio
Message-ID: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MSgCq_OJ54cF7M003lWCEx63o-YlNJntliBuRSiPv00_1767089747
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Cong Wang reported dma debug warnings with virtio-vsock
and proposed a patch, see:

https://lore.kernel.org/all/20251228015451.1253271-1-xiyou.wangcong@gmail.com/

however, the issue is more widespread.
This is an attempt to fix it systematically.
Note: i2c and gio might also be affected, I am still looking
into it. Help from maintainers welcome.

Early RFC, compile tested only. Sending for early feedback/flames.
Cursor/claude used liberally mostly for refactoring, and english.

DMA maintainers, could you please confirm the DMA core changes
are ok with you?

Thanks!


Michael S. Tsirkin (13):
  dma-mapping: add __dma_from_device_align_begin/end
  docs: dma-api: document __dma_align_begin/end
  dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
  docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
  dma-debug: track cache clean flag in entries
  virtio: add virtqueue_add_inbuf_cache_clean API
  vsock/virtio: fix DMA alignment for event_list
  vsock/virtio: use virtqueue_add_inbuf_cache_clean for events
  virtio_input: fix DMA alignment for evts
  virtio_scsi: fix DMA cacheline issues for events
  virtio-rng: fix DMA alignment for data buffer
  virtio_input: use virtqueue_add_inbuf_cache_clean for events
  vsock/virtio: reorder fields to reduce struct padding

 Documentation/core-api/dma-api-howto.rst  | 42 +++++++++++++
 Documentation/core-api/dma-attributes.rst |  9 +++
 drivers/char/hw_random/virtio-rng.c       |  2 +
 drivers/scsi/virtio_scsi.c                | 18 ++++--
 drivers/virtio/virtio_input.c             |  5 +-
 drivers/virtio/virtio_ring.c              | 72 +++++++++++++++++------
 include/linux/dma-mapping.h               | 17 ++++++
 include/linux/virtio.h                    |  5 ++
 kernel/dma/debug.c                        | 26 ++++++--
 net/vmw_vsock/virtio_transport.c          |  8 ++-
 10 files changed, 172 insertions(+), 32 deletions(-)

-- 
MST

