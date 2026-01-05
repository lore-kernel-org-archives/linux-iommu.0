Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F732BF31
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601443; cv=none; b=nk+rUQ2KS0fYYm38uHOordZLLGvrPYtvgbCkft6tkByWXpC5GIBq5pJxwUnm6NwR9XwHMKhgpuexsp9kQ1kLY5c3fAofR9PUVz3j+Y9wdG49cq2suFUVa/6v4fvbmQEbvr31IpZJN7sk+SqzO1BWHRhFiGmIZXNuMBaQh/9sGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601443; c=relaxed/simple;
	bh=jIFi+Zvcrqx5KM1Tn7Vx/X/Ro5vONbP7sNW0Mf3F+ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KDXKxVQSHZSTQYnR7p2EgxVCfmam9gNyotqbiZv7zHFlRvbJYMfQDr6MAz15ycJeaMEc49XIMU1upNHBuQbsxy+3bMQnu51T89K7KXQi0WQpDM5n3TFCGaSGs+7hIcjUgKqp85hQMiN4u2rhsaTOgLIvKsucFfw8MfCtwdn61Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0EJGw52; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0EJGw52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ko5SEulg/0toBKRpZAMNGsguRweEFK2Nvy+yQ/ftdE=;
	b=U0EJGw525N36TsoWhwIOnHH1npKLZARnTZguj2NX/3prDCcmeRPQbwt+hNfC0WXAQ3xUXf
	72jxF5QIZDsJqNjXDrw/4uv/LyZg03zEUPojJb9o56hhsYdQgPliO9LIbaDzxu0dd7svGC
	fhwmZSYop0+2nnDzQJGqmS6QbD+QSn0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-hlo5oFpWOuebfjp1pCnt2w-1; Mon, 05 Jan 2026 03:23:55 -0500
X-MC-Unique: hlo5oFpWOuebfjp1pCnt2w-1
X-Mimecast-MFC-AGG-ID: hlo5oFpWOuebfjp1pCnt2w_1767601434
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so88358685e9.2
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601434; x=1768206234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ko5SEulg/0toBKRpZAMNGsguRweEFK2Nvy+yQ/ftdE=;
        b=BZblN4OeVpAjafRiTtTEqInCZRsrbRX7fOKsFMd0K+KzDJ9YLAkaQTy8zdye8P4P3d
         GBWNUJ2kz1XHJnL1VVCFKEMUbJy6r/8VMejYc5AoClUw/VyhLwwxWVf2gNi+4H+G+yR5
         QD7BaFplnbWsYGSFxwH8KXadjHw3IEpRZI0gC1n9uDc/anSSdTul88NhiBnprgty9yyO
         JIb6JpY54jwMkGIn75Gr5aJxE0be+sAzv1/UjTbaamqgNVPlcuTQ4xSb/lnjfhI3cAyj
         IoJ3kdjQiaHVtLgaCmaiwT6PKmtozFvFzCFZ/Q3n9Pk4NYbHPY2ThfjpMFdlv6FrCAYu
         sLiw==
X-Forwarded-Encrypted: i=1; AJvYcCUxrOjkBnMylGaVV95ZOhCZoDXFjodg7OM7YiCxoWW/5IAX1zDQ5s3E/I+RdsSCmZBjQ2BPAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFfDE1NcYJrXTYWAe5Hza+NIAW3AY9h6i2Dm3+dJ4GsSOaJjWP
	j8/jaKXeGnU+/buLp9iav4koeGgF3d641cwr26RN7An/7brhlNNvmBQBuUAM+MpXDIfRJUS/ju7
	KXivwqn5z2LeIJMu+TeQWFl4ajeY5eVn9WA7fNq1qvHitn4DlUnybS1Mb
X-Gm-Gg: AY/fxX4h8SLcaPBupom3eiVGN33ku0wsQdidkc3zQuG0VTtD2hlNZ9oh8+BzsPOcvPY
	4E+4zVFs/v92ZLWcHPe8B1wAh+bSK7TVCH+KPKD+LfsNnvQa0Vr4pQQxU0iKlE7yoDvFAHJsCot
	shkOr0if8FVsxSbVYA1Y2+VOjlgas/qm3uV/JOpIbbxnexbSqRrpc73KUi3aNg0OSIfV2V5AQIA
	/vJPkebQv4YBRPLNRt9Mslvdn3n4NZ0K+wqr9pSvgfvrPloV2WCEXt3huUUz/+wFOP0nmb37kSK
	iVZ1qPOcGcIdegCovpifKPPP4yHgR5voI1WvlO1bhGp7lY8xz9k5EzeYIab61dwGfvV/jGCoe2X
	Zpo2Nghv7InCImWvnSB5OIHnllv7WWo//ew==
X-Received: by 2002:a05:600c:4fd4:b0:477:9cdb:e336 with SMTP id 5b1f17b1804b1-47d1957afd8mr619221825e9.21.1767601433830;
        Mon, 05 Jan 2026 00:23:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMqr5RF3PmeKLntFlggNTcPo2ZIBIezL7tE6/J3AdeaKkIeEvwYa+UmsMabaObW/38gLAvfg==
X-Received: by 2002:a05:600c:4fd4:b0:477:9cdb:e336 with SMTP id 5b1f17b1804b1-47d1957afd8mr619221495e9.21.1767601433387;
        Mon, 05 Jan 2026 00:23:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm99141541f8f.39.2026.01.05.00.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:52 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:49 -0500
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
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH v2 15/15] gpio: virtio: reorder fields to reduce struct
 padding
Message-ID: <f1221bbc120df6adaba9006710a517f1e84a10b2.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: uCTJ_RsbIeSDNqn0bONWDlZah4vkNA7KZ23AcvqtCxI_1767601434
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reorder struct virtio_gpio_line fields to place the DMA buffers
(req/res) last.

This eliminates the padding from aligning struct size on
ARCH_DMA_MINALIGN.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpio/gpio-virtio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index b70294626770..ed6e0e90fa8a 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -26,11 +26,12 @@ struct virtio_gpio_line {
 	struct mutex lock; /* Protects line operation */
 	struct completion completion;
 
+	unsigned int rxlen;
+
 	__dma_from_device_group_begin();
 	struct virtio_gpio_request req;
 	struct virtio_gpio_response res;
 	__dma_from_device_group_end();
-	unsigned int rxlen;
 };
 
 struct vgpio_irq_line {
-- 
MST

