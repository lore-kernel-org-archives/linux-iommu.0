Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D354329C79
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601431; cv=none; b=JPeN4UbElOg1yD7WMJqjC26p72miTPcLLWOTv2t5k/92peTO6zd0YkEoX3Cg6b/nOAFVpfD93Va9RDtmJmsIUFDb5++O+Nb1O4zGOc6AFLR/LLM5xveHIqtBG2V4zNvIh/pjvl97AqGwmJAVULgEIuP0nEAcBrrrY8cxUeLuKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601431; c=relaxed/simple;
	bh=HzYnyY7SZLB21Zw4R22hNRsG3Q5nx5zt5Jv7qf1jNBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V7Ed2URPS3RN055gRmFoJ08S+f8heQShbYRnikq/WSJV/kjyR1opE4tH+PwU3TZw0Ho33oKJqsgmCojm4YY37AwX9Ms3XNbE1/XXJZZvuUMnIUnkBSvkb5Xy2GTOodUUEjfaDyXGeiz8W8XM24R8DJ2H6a+aDwcapZ9GRHgCGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AG5sQUCG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG5sQUCG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/8txVkwqMRJjWWbc/atl6vQI7/U+u3Ckdz87v1ZTBF4=;
	b=AG5sQUCG7U5QWAr+Q46BSKAKSwAgf3KFF2ZYHdoWdSv3pwkK9HGoNnO23TLNBOBkHs+9rJ
	OQDsPzlL/G9CjYRWQnGflJ0CyuD1yz6mR9wUCiY4OxUXwaR551T0+hnW9m26yCR9PCP3hE
	79FQS+nw7tAx2MZ8+AMDdRX/qNkgYTo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-JMO8hLFiPlq4WuuBP3sr5Q-1; Mon, 05 Jan 2026 03:23:39 -0500
X-MC-Unique: JMO8hLFiPlq4WuuBP3sr5Q-1
X-Mimecast-MFC-AGG-ID: JMO8hLFiPlq4WuuBP3sr5Q_1767601418
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477c49f273fso171310525e9.3
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601418; x=1768206218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8txVkwqMRJjWWbc/atl6vQI7/U+u3Ckdz87v1ZTBF4=;
        b=cMKMMe5K7Y8REBdlQjsZZTWdPE1k9UOoPjH6KgccxLvri0XHDgjmNy/0BBBLCiN8Cv
         h01R/HliFpSB8ohRV60kfIxC3UZ2npvZU61VJeYOmfvtJk/FB4IRZjNbz+CxsXVgShSy
         L2q/DKB+hmGU5lb5pzw2WyDwOXXRtRnqcL6XV3NAtizcood2mLrsf1ltcC0z0geWXm41
         +dynP3TaHcgVgD7GKf6tXH2DyeZlWr1HoRpgf7dWp4KS5J5rOdeAzm33x1kSIAsH/d7M
         Wc5uro7XbHr7QqRjS00217R63amoB2dDW4Zt8JckgjUluui5XyAlmXnnqMubmdAziif1
         JMKg==
X-Forwarded-Encrypted: i=1; AJvYcCVNmUD4TUCCvjADYDXp4NgAjlRlM4+UIPrh9HHrLRVAE0yBbA4DtJWP7Zs5saS/TkTQ3mH6oA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmA3mKc3wz7DhKp8aVen8pp66X3P6TLQmMj4VMNl3+TOKgamYz
	CRlhGbREGJ7rRrvXfuQ1WSMVv35LAnfFMX0nJD9AgRiWq+mYb1Axmd4ruw1ag5uSPAFqrt4rjX7
	C4nRjZzymy4zviN5WXEJj8QzDlZbbdN2T0PjOFQWDSs7U8LTGEkSt1/jp
X-Gm-Gg: AY/fxX7bNKc7gloSeucqwqnd55huNhirPNFt7/q7GFJME8bP/ryi3KjqWJE5DxYq4fW
	dPqDkheBC2koUIA7OaBP9q/SKVNUTRswvIwVJFkF6S56xo2MObXCTGItyX3w8A0GdFTlhEbbrIf
	0K48PAaEehoQySOLuNbJSuKhR1lWYxrPl+rslx+7lOim3PF0HWG8AyndWcKbmlJbtOJ1jz3Ar1k
	wYkYc/LLI6SrEh8dHptQKvbXpCoYGUeEz9PAEZIIOM7faoMLet+2U1oRFJaUrj3p5ajSnhgSNGu
	p/RoYJ9lsTR6ETgHBIIYrXkNGhpA0nwRRAXrqey5hMpvnUpZvfd/6dPZYjW3wp/mtirt7RbdNOW
	/vStRlM9CrsZbG+2tDulSlikBiKjeoc+GHQ==
X-Received: by 2002:a05:600c:858e:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47d1c629902mr472043195e9.4.1767601417336;
        Mon, 05 Jan 2026 00:23:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVSX2iBXTT4S7tXy0ZYHsUHRdZMVGE7PsYbGyf8OKqSDfiJqG7TGaTn+6DDGk03BIi3LI2pg==
X-Received: by 2002:a05:600c:858e:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-47d1c629902mr472043065e9.4.1767601416846;
        Mon, 05 Jan 2026 00:23:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6be6b202sm54210025e9.6.2026.01.05.00.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:36 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:33 -0500
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
Subject: [PATCH v2 11/15] virtio-rng: fix DMA alignment for data buffer
Message-ID: <157a63b6324d1f1307ddd4faa3b62a8b90a79423.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8Gr7NNu391pZkDC5YgY4U_bN4On7wcrm3X1TlC6uRc8_1767601418
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The data buffer in struct virtrng_info is used for DMA_FROM_DEVICE via
virtqueue_add_inbuf() and shares cachelines with the adjacent
CPU-written fields (data_avail, data_idx).

The device writing to the DMA buffer and the CPU writing to adjacent
fields could corrupt each other's data on non-cache-coherent platforms.

Add __dma_from_device_group_begin()/end() annotations to place these
in distinct cache lines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index dd998f4fe4f2..eb80a031c7be 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -11,6 +11,7 @@
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_rng.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -28,11 +29,13 @@ struct virtrng_info {
 	unsigned int data_avail;
 	unsigned int data_idx;
 	/* minimal size returned by rng_buffer_size() */
+	__dma_from_device_group_begin();
 #if SMP_CACHE_BYTES < 32
 	u8 data[32];
 #else
 	u8 data[SMP_CACHE_BYTES];
 #endif
+	__dma_from_device_group_end();
 };
 
 static void random_recv_done(struct virtqueue *vq)
-- 
MST

