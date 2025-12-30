Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDE2C08A1
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089765; cv=none; b=u8JW530CAaVa45L4WFOtbVFxYICerPodsp8YNpjsIvhu8iGA9YV5KXNKjsUtZFAUyPsU6uAh6mw6g1zB5pCW1lbZd+1LCZjXyz7hq6WCRlV/+crYOdOt0v9jhaDM5MwedyjwaufZwF2rha9rDk3KxM5CX8JWPr+5dH1E8soG2zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089765; c=relaxed/simple;
	bh=3EF4beueqssYSrJr7jAiyWtRxi/ynmIi31SbgxtAbxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=msB/3nyqmrQ4hopIbIVLSvlfIEofvtXh8AXpA/S6it9+GUwXwaJG3fB71f919bswHMnsgWyn0ZdiZgp2EqaefQhc4dePq8/2JGgrLuhP7pql5LmgzEp2v/r1ZVkavCXWoL4VI+iDfpXSv7UDI3KlJGwOeViHOYYAQ2GczwaK43U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ig5ep5oQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ig5ep5oQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
	b=Ig5ep5oQfWTSijshrhmphh1kZkOF0/D3T4IO0PkmzcUJ9LMbjzNp+u6jZ10CCW4QVl+zOX
	Tya5yn+N8eUQwS6+O8S7fVAFMqh66YiNsMIbM3BzPQPZVUlRDLR/1xsJMoY6lRsszddlWC
	jG9Ke2bvMqJsbN/EmJMgf0wOxMckYuI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-L5XfjzoeM4qD5IasIUGYVQ-1; Tue, 30 Dec 2025 05:16:01 -0500
X-MC-Unique: L5XfjzoeM4qD5IasIUGYVQ-1
X-Mimecast-MFC-AGG-ID: L5XfjzoeM4qD5IasIUGYVQ_1767089760
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43009df5ab3so5469984f8f.1
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089760; x=1767694560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlkdUJvLxIuG9RkypEQ1odBgc8hsD/vyeqVzWJtThQg=;
        b=JEDxSJtmT2Smv7z8E+UjpxnQZjlIWmgBDFDthHgVDD3pBp02JzTOo597VorNvOrLvO
         WC0kEAycW7KX2h/6TlCS/L0+5epoCwWtblIHK0bDCT1qnAElnd7NTFgKwc8l2lXh5mmV
         7Hsp5kgtphdHEzeP4OXsGd1wJqF/FY924r7uW0YKuMkwoW2a48+4b1DwOjqXfl9uwrnC
         1ZVY0ESaztzwpLZS80vTYBYW3B/D/l8QEsVtdcYTsW4lgZMspoYYNHrOnbBD+XNyxevK
         pL1Qj2RzclW5lRzrCCqfs+QEm7NMM2xf1Y1+ZooQHpZNlKQeERn4fNSlvLC6Bh6naWiz
         CdMA==
X-Forwarded-Encrypted: i=1; AJvYcCWbvx/poKvePIWVcr6w64WphE/VaQDVryBUeLmGbGiK9xTeaCsvMywo/+a4GXc98a5FEs7jVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz90J+2G1s4t36zO/9jD+yHs/bT1N6xBly9kQimFeYcZMOtTQEW
	WU53W90z6UlSdjTA8NUQAqT+ASsSKbSGJ9zeAveyf2PeHZyqeepqL3RR9NiqG7JZtsGLcmHiugu
	rzgrMIBy1JMM3s2QAkQZZc3zvK4kidtxVTfecfDnzKQIi1mRQ1U0xJxoU
X-Gm-Gg: AY/fxX4/GPSUUPyhcSs/90ZXhFwE+486VY488fy6F25shWI43GtmjQHAaW+sJC2P5FU
	ZG/87nzQ/yWqVTvbygOJiIAnqJEC3B+oNcHnRUjD19K0TEmc6ZfSeXon+u8t8TBabxzxq38+HxU
	A2Fp2Qdf+3U4MTSNjn3+jS6KB+nQ0hY5pimRf52rHf+12bEE8kac0KkJ142kT0XgLGFX2lzJwvh
	ga4n5erKMbPzkh3Rd4ejXYeFu6MATEB2+wKh+QoCz74irmQ7AYqC3hm7zd3ljnMPBkfGK4lQmTr
	Kw5/LB1P62BZwroYYSHxNeYtKFPt9LmznpF6QGb0wtmSWLLC5aUSys96up2IeYeXDElG4XqqyuQ
	VZBlZZV8ljlk+OrzuRU0M/00irDuAnBwOAQ==
X-Received: by 2002:a05:6000:2906:b0:430:fd84:3171 with SMTP id ffacd0b85a97d-4324e4c9e98mr39750120f8f.22.1767089760425;
        Tue, 30 Dec 2025 02:16:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHondA4WovcXdLOT45Lj3uVr7rduhIOKgQxT45AJwE7sF5CS5LqWM7ii/WKiPGqmcKK8QLbHQ==
X-Received: by 2002:a05:6000:2906:b0:430:fd84:3171 with SMTP id ffacd0b85a97d-4324e4c9e98mr39750079f8f.22.1767089759925;
        Tue, 30 Dec 2025 02:15:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm68448837f8f.20.2025.12.30.02.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:59 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:56 -0500
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
Subject: [PATCH RFC 04/13] docs: dma-api: document DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <818c7ea78e43b93d1bb3995738a217e5e414e208.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767089672.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gcm4y6WldLURxZqmf3CUPTWiPPCUN4ft7wKcPwBCqRw_1767089760
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Document DMA_ATTR_CPU_CACHE_CLEAN as implemented in the
previous patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-attributes.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
index 0bdc2be65e57..1d7bfad73b1c 100644
--- a/Documentation/core-api/dma-attributes.rst
+++ b/Documentation/core-api/dma-attributes.rst
@@ -148,3 +148,12 @@ DMA_ATTR_MMIO is appropriate.
 For architectures that require cache flushing for DMA coherence
 DMA_ATTR_MMIO will not perform any cache flushing. The address
 provided must never be mapped cacheable into the CPU.
+
+DMA_ATTR_CPU_CACHE_CLEAN
+------------------------
+
+This attribute indicates the CPU will not dirty any cacheline overlapping this
+DMA_FROM_DEVICE/DMA_BIDIRECTIONAL buffer while it is mapped. This allows
+multiple small buffers to safely share a cacheline without risk of data
+corruption, suppressing DMA debug warnings about overlapping mappings.
+All mappings sharing a cacheline should have this attribute.
-- 
MST

