Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353632FD7BE
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089803; cv=none; b=SxMxhB3QeBw1U8g1FxCmi447D2LWeTDs3N0oeEFQ0lyps2ZtqI6y7WC179kEg4QBQsxSh7Ed6y34tkt+rf+wBCRCPNuArlLtGHcOtK6T+LvbCRNhYjiwQU8EFPzHJBzOkbSYSCY063ZHie1z5Tos1MFRTXZesIdQHCXEK6bw5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089803; c=relaxed/simple;
	bh=RzxSFhz+bpkLtGdr/5qvrDQOf7DHug0oDxHEj4NfN04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=t2dNe5XVgmtOO83azTZIYcaTfvlkx+VzexBAJ+K0eg+6HNJIsuvJbUEtTp84dTz1AGoXVRDrfDTuUCFxPYUbo548Qf/kuCMwKrGd9fLhCsvRsezXnQbFwEoZNL2JvM7TbKfDCmNJOrnTQQLAKgoyHEbopy5Dq6rjevtn0or/8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gp+/QrIb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gp+/QrIb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qjCbMizY1BaJF5yBWOLXV7DyUl9vbunxYIEFqfWmhYA=;
	b=gp+/QrIbF1nc+WyvdgEXty3YI5FINourt6mIKYBAsBIlirZqD3Wv6GDJqWKr+sOkvIVh5s
	dxF4qPLzJl4rAKwYN2oF5C8IJzaUmBXxK7ZXJ8WfrH56+Q52ofgILo/Kz+PUAPW0lNSNS6
	ZdoLeuRp1ebeR+fGPTrAvbpiSTvmlhk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-IlkNqOhTOXyRGN8pVrDknQ-1; Tue, 30 Dec 2025 05:16:39 -0500
X-MC-Unique: IlkNqOhTOXyRGN8pVrDknQ-1
X-Mimecast-MFC-AGG-ID: IlkNqOhTOXyRGN8pVrDknQ_1767089798
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4792bd2c290so94173295e9.1
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089798; x=1767694598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjCbMizY1BaJF5yBWOLXV7DyUl9vbunxYIEFqfWmhYA=;
        b=sxssmpxU0tZRGOqxD9DdoZVFHiS16kYJBF4xGXLgLhzJRbDgQENFBbF0/4wGoMKvHA
         r4yE1vq0HLXsUHOe5i6rvQc/bYJHBCNcufynJPiG7WU8W7s6FweFy53G5k+N5RZqLIaA
         R8hcOVC7QJPs4hxHBxMTRAU/jun0eKow8wXuh/f2u4ZVzq2h/ZGgww4LIRJQfnMd7j/F
         p6Ah+RjbRg6uRbEJK/r/SUXLOp46YGHlzHDYOUK1FXsz2BcnBplu2yJl8shKmsH+sw2/
         Olt8qe/F02w2nGWVhgOgP9SM5jC/Bu4W+zw+zOrpPIKsT8w5IzxlDe7OOuXcpnA7F4i/
         Tj/w==
X-Forwarded-Encrypted: i=1; AJvYcCU0bHdC3cm9Drz8qU8/Ig0QIzxk5pVCm7NFx7tMfSqGAiaFp62acjzvNlyNbbMA0mLzMkzhGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhxvY2O3V7J5bBsA9pPRZfaM35duzu1j2rKfkOUrpBs0huROnW
	lQSbBsNjcu0NlXjEDDsLYMnD9VsNSsTjBZ8M42vAYMmX0RYvnUBp+bYTjnklhonCoXSSpl0JHuw
	8CNsnuwMyJRdzTsEXnv+8eQqqU1AmZefT4TrTTXpPSwPQ3Ph4CliLnrZZ
X-Gm-Gg: AY/fxX4ajdAV5139jjqm1pb+S8Sm+mIiopmsds+NvrD0V0gCT6Rx/Wy6FZnjvBVnDo/
	UL7oCeu3SYEiN8Tp4aquNncWcNv40wkiUqaCL6Sb45Mac6HJv9whbvl1/oZ1/eof3GWR3tNF30e
	Tk3eRX3RrJDUKSKUgD7pH9YXVAnHbe0+HEUBged6Rj4SwxMG99qq2WTtiI3zLalmK0A7l07jzU8
	SdBi7X0rglsNf/0Tg9+WxscDa6BAUOjTOpVrs2apbIvO4f/00UWw9QsG+isqLc9KyOsKyY0+m9u
	vk6SLl5ZJ802rLqNnq+JZyK4xnXCz78Twfev3DT+EhWTQeRdTotHCqVAX32kyRp3UYeW3+8yZqE
	yCEkqAgshEQtlLSL7fJF09vJb+pVjiu1+xQ==
X-Received: by 2002:a05:600c:620d:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47d19569c23mr469752785e9.16.1767089797984;
        Tue, 30 Dec 2025 02:16:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj3WKIKEzUGPKu3zdwQlyOBMeOTgJhitK/YOLHPeOIUg2zxiErnT0jngxXmWGMEmg7Rb+0jg==
X-Received: by 2002:a05:600c:620d:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47d19569c23mr469752175e9.16.1767089797499;
        Tue, 30 Dec 2025 02:16:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c5f8sm610551235e9.9.2025.12.30.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:37 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:33 -0500
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
Subject: [PATCH RFC 09/13] virtio_input: fix DMA cacheline alignment for evts
Message-ID: <ba80d103c159a9dc36b89705e00f91bcff8857c3.1767089257.git.mst@redhat.com>
References: <cover.1767089257.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767089257.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SuJ5BXJfHMdaFokEmMu8eJ3LFNqesL910WoLFiNq0r8_1767089798
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On non-cache-coherent platforms, when a structure contains a buffer
used for DMA alongside fields that the CPU writes to, cacheline sharing
can cause data corruption.

The evts array is used for DMA_FROM_DEVICE operations via
virtqueue_add_inbuf(). The adjacent lock and ready fields are written
by the CPU during normal operation. If these share cachelines with evts,
CPU writes can corrupt DMA data.

Add __dma_from_device_aligned_begin/end annotations to ensure evts is
isolated in its own cachelines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index d0728285b6ce..774494754a99 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -4,6 +4,7 @@
 #include <linux/virtio_config.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>
 
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
@@ -16,7 +17,9 @@ struct virtio_input {
 	char                       serial[64];
 	char                       phys[64];
 	struct virtqueue           *evt, *sts;
+	__dma_from_device_aligned_begin
 	struct virtio_input_event  evts[64];
+	__dma_from_device_aligned_end
 	spinlock_t                 lock;
 	bool                       ready;
 };
-- 
MST

