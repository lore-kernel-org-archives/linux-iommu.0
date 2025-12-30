Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F42DD60E
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089795; cv=none; b=Q/PsuGGGJHkiJs1Oo2J6esZ+LBvcwws5H2ja3gq+lRsBv8nf77VQDi0/Tk7Pg6hZpLUHg5j/RNSD5DeQnr+VEGSNu5bukUWFa9GeGX4xOCte0ZAoVkvZxt9GdIyNz0QeTuYugflZGJX+ySGUd3wHlvGJrNLoLpZ4AS5H3nTHa0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089795; c=relaxed/simple;
	bh=8AS5gGTh0N3CZpFV6rLA6D3VYpNHgRiCO3euR1uUYwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lNzAfRQhgorSUrb0yHN+Hqhgu2DQ+/mLErEn3mqjyl/zh84xtmRmFrxMMbuIswl7xt6a+TWWjeBq5UrF+N8oQ2AP/HKTfv0DYBPRaFrQ8nt+02ng2ugM5p7cV9k49BR8ElBjOAmTNUxOCjsmKz3YFpnYfejU0ssCv7rDu/4++64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHCTfOQv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHCTfOQv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U6HBtTZLBj4ioaYYzWmnMsK87TR+uoHLBYHR1C0qpbA=;
	b=VHCTfOQvrJ1iXazIEf5ji9mLXER0HppwvqCYgpvqLGdM4FW6H009wO/ADV5uoQzdJoeaqa
	A5L8DzaOC754QH8uqkxfDeqfMxi5fwATk0k68nCRN2KRvb3iDAeuI0va3nmODsHg6gVub1
	YONZXmNsdlQYbO2IvWIgoIBnfpm8/xE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-B81unXVyMZSBcOGcwZ7QOA-1; Tue, 30 Dec 2025 05:16:31 -0500
X-MC-Unique: B81unXVyMZSBcOGcwZ7QOA-1
X-Mimecast-MFC-AGG-ID: B81unXVyMZSBcOGcwZ7QOA_1767089790
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so70919525e9.3
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089790; x=1767694590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6HBtTZLBj4ioaYYzWmnMsK87TR+uoHLBYHR1C0qpbA=;
        b=ON2GJhscnRsr3EynjGAgBXJCZpF3k55L0PIxX+KCuYfQRAZQosZFYkCyIhpu0/VBIi
         dE/YC/6FHIlpebWS80RgLrLfL14cJ5OcRyVtfWBHOGGosUJm5ai/DosKbRObUeUzRYfz
         1+CW629OxVVhd8bxQuGo58JamM3dElL90DjE0UOGhz6mqW4043mUlyQJE8OF00gx4/Ym
         eaQpFNSgf/bpubSSmu2nW6HKNn4em8AeggumrXgAofz2jTZeOsH/jHMC9zM8GobO0kWL
         iiA89bq9EQwbke/toBjp6kx+FBYN8i4YrtfYn3Tz5lI1alRfHeIjQvY9GU1oQgTVOxym
         5zcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgrYpBjuseSlUIK01QVXDaqdEZAoxQhJ+yZ+9+1g+/Y6Msta3H/7zxJxyz/4pe+9MUm1lDEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXtSuux1Hq0zzTOWUtE42X+qDR6nO9C5sgeRtjASCgMTVCv0jl
	T5gFYfC56SwD7WeStFpey8HZTEQ2gzUseXOhYCpZbLLNWlWI4GTuqFBZvh8qjclhoRj9OuCNarm
	GtbogZQF7rHiB1faisIgmTJyKAjaT/6idIx2e/d9JhVhsucfldpLKtq49
X-Gm-Gg: AY/fxX69+IIhckMHSwvxbTn1SyprnbMX/IX5zhbwM+Evd1NAwovmU0CWnpnWxqIjl+/
	72h0Jwx9QlJl2tvMBv9DZVFyyOLINv/D94l/OnoP9tYCm6mfiB3kTtDkC8lfyUdT03USoqFzTsl
	EZNencY1pJncDb0NUWwPIyVHNRUdQWp9WOzBHji3ei8nn9CWh+gHkLuA8MyRmv2xLqU5LPFnFKY
	Wig1Pb6wLGmjSzzhRYeBkOv2ljDb902k7pzTiCEhuiT1Yhh8DKWg25x7Amm3hliA6z8S1ggUyZ3
	lfw4TNVXTwHzKdkjyri5JlDIAALnlFbN9G6sDNc6yNK2bThy09lbWu5ZqbTnJ7nMOvRXYC2eArK
	UzxWyPe0OqxKdMJsrCbKsROXZ7c+FQbZqvQ==
X-Received: by 2002:a05:600c:1988:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47d216f9b5cmr259854285e9.2.1767089789795;
        Tue, 30 Dec 2025 02:16:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFX2lgJn+l6zys486wjxZAQuCHTw6CP6YgP3vRl5nTR1Kl1YBeU1stpLcP1P+bgygg19A++Mw==
X-Received: by 2002:a05:600c:1988:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47d216f9b5cmr259853855e9.2.1767089789344;
        Tue, 30 Dec 2025 02:16:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193cba81sm575858095e9.10.2025.12.30.02.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:28 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:25 -0500
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
Subject: [PATCH RFC 12/13] virtio_input: use virtqueue_add_inbuf_cache_clean
 for events
Message-ID: <797e9046d85137053c86012de026cd1aefcd02ad.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: py81kRTZ3XTJvHrG8kroxRIFUF2NB4RahnKk8_CtcVg_1767089790
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The evts array contains 64 small (8-byte) input events that share
cachelines with each other. When CONFIG_DMA_API_DEBUG is enabled,
this can trigger warnings about overlapping DMA mappings within
the same cacheline.

Previous patch isolated the array in its own cachelines,
so the warnings are now spurious.

Use virtqueue_add_inbuf_cache_clean() to indicate that the CPU does not
write into these cache lines, suppressing these warnings.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 774494754a99..b26db7d6a49f 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -30,7 +30,7 @@ static void virtinput_queue_evtbuf(struct virtio_input *vi,
 	struct scatterlist sg[1];
 
 	sg_init_one(sg, evtbuf, sizeof(*evtbuf));
-	virtqueue_add_inbuf(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
+	virtqueue_add_inbuf_cache_clean(vi->evt, sg, 1, evtbuf, GFP_ATOMIC);
 }
 
 static void virtinput_recv_events(struct virtqueue *vq)
-- 
MST

