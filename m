Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24669322B76
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112844; cv=none; b=rcgiN7mEw5OjyD9nTHGTBjDZs8SXgo6Ce/c3mrLyc7y/fA6p49dQcYrykS2sn1f6ME6udqH6KudZYa/2Etl5276RcATEcJIxfdPu1KIrx6jb+GCoLB9pVupdRx2iwAgwNpjmCxH4X61a6MHwHgXm1i2aISLUQLTiQg4jqvAw9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112844; c=relaxed/simple;
	bh=rJvyv/DkZDnTdlk5mMz+iorYKgEElNGmDI1t8E4mVas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HmrSntNilHyEKkDo23fZ1s2ebyOEmv/nDnJxr4QDo9H3CvOPQtA1J6NiizK3nsWAm/vZlMMAEZ2XQRkPGgi/KggvdQxGdakwk2SoffxejgLy5ufAOJ7ILTDVWwS//GwhGs7jIgMRpxkCCrmro+wh8pRUuyLEunqwM/Zm5MORhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PH7LuFAs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PH7LuFAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767112840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RGewFge/6sMWyfD/6+VNEsuf36DWmJ0Q3xqEbJz+f7M=;
	b=PH7LuFAsj6XUk/4EbdGhLB7ISzz7kfm1g7oyx9y3XcUiyKMEa0BuFourlWUkkJpI7KaH6z
	zPLa7j7LiCDgNlBZNOKqezN6WUIounga/WNnWFpFmLc9Y+/VdByBk7jzhmhTHsxBRFbpX3
	TztSEUUMKL7FTjEWi8GQKqU1mw6Yh4w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-JafWD6UHPTug447F8Qo-hA-1; Tue, 30 Dec 2025 11:40:38 -0500
X-MC-Unique: JafWD6UHPTug447F8Qo-hA-1
X-Mimecast-MFC-AGG-ID: JafWD6UHPTug447F8Qo-hA_1767112837
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325ddc5babso3943353f8f.0
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 08:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767112837; x=1767717637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGewFge/6sMWyfD/6+VNEsuf36DWmJ0Q3xqEbJz+f7M=;
        b=o0im9CPadPqHuNLsdxH56G6ZJUfVZVh+6+X+Nmjr/8JE7HbIvkaVOBkPBrIlqKRWu9
         XgFNcyL870WS8F333YaKDfs1CMekSz6OeQt29p2BjhQMZnYKMXlsIpYPEWgE7WgPtLHO
         IpAzAjzQ5rW+E0igqPiqWtWM2To/P3uoCiHkdl06Q8torQHqkQ5SdMnJ9t00x+1JLgx/
         HrgJV6eF91n6TI5km+H1SDFtuZJkHrBNknmp18hLsq+NAagL6YnJORIrEhtAcgsB12dk
         m4r5iCOO4elHhYF0M4dKd0G3F5tD/5zgKJDjx6QhPFm1F4BxlEIfJbTiDS17DSRz4DKQ
         8Umw==
X-Forwarded-Encrypted: i=1; AJvYcCV5Y2cBgkJAb+x+GZZAP9D6JFO5VU4WujlXImXtQ9tRvqQju8L6BozJmX3D/5xeQyhHDnO/Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzrm5BfVmjv3ZBDxRjvDa/GKlTMCN3LS9N4M2qzs5P0fBNkdyyq
	jqNO5+/fJ7vgqVKT7HFFeUk8CQ8zienCnC/6J8A4J+XmsNN2el7xDMUQTqxdo8XeltJc/ruGWUv
	gAfEEJh+vBTujZ7h85OhQxUn4Kbit/tIjXTW7YZFk4uhXtQUoV4uKeQ7/
X-Gm-Gg: AY/fxX5ZuZ1Gnr7CI2vAYCvPdybB3FNItH1XINCwOOm11RAYdDQ8EHD0G3Pg1oX7N9G
	CYM5M4Wu5mnead+zxzHgmtQBTNnCRcXTS1kIec/F4oKZ4Jyeu6cBe8qhHG4EpbeHnQFbX/aqtR5
	/VI7cfR1qk+8+O4xcOZ2A5uo/NVPxXOBWqXTXZRfoflZpLi3eUfHHB6bkjTnWLHVIwq9eVJ2FnO
	/tI7ryqo2MzJe4aJGdgbQWSVNQJvkH6GneW2TBKr/dtwCor62Lk+LuWDoKu33CyEhJq3vfzm82G
	toifiHsQrQB17tZrwD3e0MI9vtgvTpU8haAkbD2n6Yu8Y/YFXPskCtSeYX0TMZSUNsmHZ79dJIK
	PoJRahv7idxnqluLyl/cR4dqNhBU7sK2QFQ==
X-Received: by 2002:a05:6000:1865:b0:42f:b9f6:f118 with SMTP id ffacd0b85a97d-4324e4cc03bmr47308968f8f.15.1767112837154;
        Tue, 30 Dec 2025 08:40:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJgojb32FwsKVmHhWZwfLhjoCLU41JBrW58xQS8ik2FTwcPC3e2aYiOOV4nGFH+isXC/64yA==
X-Received: by 2002:a05:6000:1865:b0:42f:b9f6:f118 with SMTP id ffacd0b85a97d-4324e4cc03bmr47308928f8f.15.1767112836647;
        Tue, 30 Dec 2025 08:40:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af2bsm69151255f8f.1.2025.12.30.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:40:36 -0800 (PST)
Date: Tue, 30 Dec 2025 11:40:33 -0500
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
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH RFC 15/13] gpio: virtio: reorder fields to reduce struct
 padding
Message-ID: <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 06r9Q-GRX9KqhrufUqI6s0IH5Xk7mJ3N_dMLYALfD-0_1767112837
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reorder struct virtio_gpio_line fields to place the DMA buffers (req/res)
last. This eliminates the need for __dma_from_device_aligned_end padding
after the DMA buffer, since struct tail padding naturally protects it,
making the struct a bit smaller.

Size reduction estimation when ARCH_DMA_MINALIGN=128:
- request is 8 bytes
- response is 2 bytes
- removing _end saves up to 128-6=122 bytes padding to align rxlen field

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpio/gpio-virtio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 32b578b46df8..8b30a94e4625 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -26,12 +26,11 @@ struct virtio_gpio_line {
 	struct mutex lock; /* Protects line operation */
 	struct completion completion;
 
+	unsigned int rxlen;
+
 	__dma_from_device_aligned_begin
 	struct virtio_gpio_request req;
 	struct virtio_gpio_response res;
-
-	__dma_from_device_aligned_end
-	unsigned int rxlen;
 };
 
 struct vgpio_irq_line {
-- 
MST

