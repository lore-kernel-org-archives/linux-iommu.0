Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408C130FF33
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601380; cv=none; b=Pup6PLYq0HEvtPdB7Dzzpdo2E2cN7S8NWqVVlc39LusmJASuHXRYx+B0qcQR4ExXUi/NIFzRmRHxVfdBXtNhxxXARv//KZHTMhS6BBRHU6zws5rfK9bXVnuc0wq1xgZnP1J5XCKch16xMwW/pUEJRsQmAWDRAdPDuKSFbZAMEHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601380; c=relaxed/simple;
	bh=1rF+5o+RxfvaZWaK/37ivP7Ic43xgdCjtd7a083Lyfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nas3WRBmyvApbTyNTfcvqwNcjj/s/jNgDQg2Er2IfS4IADgT09IhIBpECK7L2/GUX6mycGZljF77iNwpZ+UMorNnAKE5cA81PQJJEH9ianWB0BoglWHkb8A9dW2BgoVwfqdwh0yCroEdG9Qhis3o3ei87X9SWouXR8GlHwpNdEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVpQPRID; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVpQPRID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=++MSvPbbaixtOH+VkhbpdT2tKuVIlO7zEYO24bBcB2o=;
	b=OVpQPRIDj5fXqBg9A/hP4xVzLw8MYfD0RyVh4Bk3mpjidMcWQVlxb6UWCkDP88f6dbWF3F
	SvhRQ9LrJEXf8a4sePL5O5s/gicfHgSC7GHHwSCZoSo54sbVX2pEdbD1EQjHEf1CDNwLaQ
	fzhYe/ROFifr2sDRbPyDY0j+oMXFN/U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-6JoZC26yOa-dBiVSbAfjjQ-1; Mon, 05 Jan 2026 03:22:55 -0500
X-MC-Unique: 6JoZC26yOa-dBiVSbAfjjQ-1
X-Mimecast-MFC-AGG-ID: 6JoZC26yOa-dBiVSbAfjjQ_1767601375
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so96506675e9.3
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601375; x=1768206175;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++MSvPbbaixtOH+VkhbpdT2tKuVIlO7zEYO24bBcB2o=;
        b=UwxduGveiKWG0j88DtgwWlOM7HnPl1paii8v0gM/03rUlW7/Z1rgvg64H6z66tkciz
         y+92Og/7HJb+oiViHKsDcbWiFIyURA6orqB9MLEfh4YmVuA4R7ZxKvqLZ4RopIV3Z4md
         ZvUyzOMrkJSrBMmCBPVA7MmVeJhMUvtacIeNS0N5g4BVbYWvGnSKOuBkmRuUhGH5A7Ri
         Kr1FhLJVWFUfjkyF+8B9jNkkb5CCUW4w8jGEbdLZ7RZhbrtnPmJAyRzggiFVocBmzSM5
         lEoRh0t4upVgpq/fnDcUeKKTawqjL7xjdcIU9wWIPGwnobkrhuZM5st99/tOsFz39Scc
         7zaA==
X-Forwarded-Encrypted: i=1; AJvYcCURUs31UATwEY1bApcwU/FiFR6GrcYLevkbibwKMKKaGYNGNcK+bc1X5KDBTT6OZMlBDnLxFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9fc53IFSOOFhQmkumV+kPm8XfXnKL9Kgo8EVRomFTq0fKJdOO
	hojP0Mm/hSJpvfKwyu6h9BABxJKbPOhRApnvtbSTvIhAaH16AXqicec/ujDto0gu7hOYBVsEMFR
	kNK6ONwTAEyt9Od/BlKkXctDiXLqm3XO096vIKLbOHGo02eFcDAxwoTXs
X-Gm-Gg: AY/fxX6BJ/5Xqn5cRAcUJRmYSSoVthZuDXSD21KpgrVXlN6JNuC5CM/4Kvm3x/UWdKb
	074Aq24daK0ZJqM/HE/wSOlGFFYeO3KHhYHap+25jpyXaw1Sq5e8I/7ZEwZeTeeqE4P3B+lnKcE
	tzT1HqrzawIrVQKuMQdaG7P3A6IIHmHyGcqnJdGWJEzvNMRXjVt6vWUWrF0HzkJggpb8ET80QVI
	L7bdMJm0jWe++XZffSFl2THbe8489A2LDeUVFHqzkueGNaEvjaY6mFTMBgECYZyCYH/GUecUpv4
	aeZgZvb/LZ+tgNVZ16sPR7h/TuSy2Bhcw47YQJIRqRdmEe4okDXd2tozSpdcRZmTRy0kbBKXtaA
	2HqcdcsDloCfrK+7ajo6ivJmiEbRQ1Oph0A==
X-Received: by 2002:a05:600c:4ed2:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-47d1959eaaemr640737595e9.25.1767601374467;
        Mon, 05 Jan 2026 00:22:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXw2Pw2EoWGIJB0fy/EdgimCoNIlh1q5tf6OTMnGxG74FiSYxf17YyIIU15mHj+ck3a5eDtg==
X-Received: by 2002:a05:600c:4ed2:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-47d1959eaaemr640737005e9.25.1767601373905;
        Mon, 05 Jan 2026 00:22:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6ba30531sm56554215e9.1.2026.01.05.00.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:22:53 -0800 (PST)
Date: Mon, 5 Jan 2026 03:22:50 -0500
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
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 00/15] fix DMA aligment issues around virtio
Message-ID: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e2GAnLC5lqvCRM-Qn2v4d4_y0aQQ-pByymZhCtfer4o_1767601375
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

Lightly tested.  Cursor/claude used liberally, mostly for
refactoring/API updates/English.

DMA maintainers, could you please confirm the DMA core changes
are ok with you?

Thanks!


Michael S. Tsirkin (15):
  dma-mapping: add __dma_from_device_group_begin()/end()
  docs: dma-api: document __dma_from_device_group_begin()/end()
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
  vsock/virtio: reorder fields to reduce padding
  gpio: virtio: fix DMA alignment
  gpio: virtio: reorder fields to reduce struct padding

 Documentation/core-api/dma-api-howto.rst  | 52 ++++++++++++++
 Documentation/core-api/dma-attributes.rst |  9 +++
 drivers/char/hw_random/virtio-rng.c       |  3 +
 drivers/gpio/gpio-virtio.c                | 15 ++--
 drivers/scsi/virtio_scsi.c                | 17 +++--
 drivers/virtio/virtio_input.c             |  5 +-
 drivers/virtio/virtio_ring.c              | 83 ++++++++++++++++-------
 include/linux/dma-mapping.h               | 20 ++++++
 include/linux/virtio.h                    |  5 ++
 kernel/dma/debug.c                        | 28 ++++++--
 net/vmw_vsock/virtio_transport.c          |  8 ++-
 11 files changed, 205 insertions(+), 40 deletions(-)

-- 
MST

