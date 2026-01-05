Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB32327C13
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601408; cv=none; b=lF1gEh4xBxIqe3Z1RGb4qYrOJW6aYD4RWD+OFkxZHHCAItpin+EzIFg5/UGOUFXoc3ZsBSwiR6NMGdGQlOPRsS8tu88vn9t8WUHD5kvbwcF542WZ35QwPIuH2OJMFztYGdJL8WV0uv65OhkJmEVvsAAh2SLJLosJdneXS4Oe7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601408; c=relaxed/simple;
	bh=UZnbRwVvRPHcRgRCzpxYejrN2eYzh6K3qUvMvD+slXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PtUIUbcj5ridRaXn6QOmXuIiem/83coLYja+z01lHbKxeh/6cC+OIUYc9n4w/XhACzOVwQWA8y5Sm4lHhiBiKiS5yOxP4+9/q2awUUX334Zr4SvQFSr2WD8WDbo2qSHktaZGKGXcd1WUnTwded9+PlKaBV8Z7HmfQ2mxL7EfN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiMxA1GK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiMxA1GK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ixiBJgqmLTQwR4hP1VcNBLxgwUtr+SaYhPMs/HYsyIA=;
	b=UiMxA1GKlCyYnSewUrFe7zpqdtwyEQezuzB1rvo/N/30bTAli5xzBGb3UttSm5zgPz9bmW
	ZOPyKEV4to4Y+8s2XSgwnxn2RYACV6z01vx/XyJ/4qklW8QBklyEGy0xpigGJ5jeuWA8H1
	FgVqgP0fE5+/io6UvmFU14N8SaBgMUs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Y2y-RwhBMoSPBDxUIDcZfQ-1; Mon, 05 Jan 2026 03:23:23 -0500
X-MC-Unique: Y2y-RwhBMoSPBDxUIDcZfQ-1
X-Mimecast-MFC-AGG-ID: Y2y-RwhBMoSPBDxUIDcZfQ_1767601402
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43009df5ab3so7868503f8f.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601402; x=1768206202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixiBJgqmLTQwR4hP1VcNBLxgwUtr+SaYhPMs/HYsyIA=;
        b=OGP63kSvR+8K2k5Zka+Awnf4ErURkvx1VdepWivCM4LQWFfm/VZaMX57Ubw7adan0Q
         wX7BDu9piKegfm4nHeM0O7cwPMghPslhZRNZRYSCdtEFaeVwSSsbmT9s1nv6NVY3twOx
         iEwjpuVzCD1EH0qX8wIhJRuP6YZWyMbZKoJjtAFu8wqci3XeZT+RARW2u3wNM4VVEzOZ
         F6ORe2Zbu9wAKT/oP5wQgHOw5gaczb3ZNteZFgI5PA3s+7UrT/e+3sLAOiDRY6iWmK/M
         EZCgeyao2NuEXEwSgH+9U9EONQcgCFT3nnJZTLbm7fgNk7ivf8Nyh2YhnpaBiJuWyjU/
         SQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCXDdw5XoBCrNlZ153fdYyCal/DtIxzk7I3d4OmKErqFhGkCx6kI+oZDV1aybTcrNnUsQS5QPA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywbp2/oE1cxXZBImmyps9emN2Sq2oVj8TXuRDyEwM/0Cz4CVXhZ
	7v2P2hf2LbUfu26XjDIgX8yBYMGUR9cR4LunHRMi9b7A+Dvf6iS5xvHsnVEwcvcApPZQXMZzJBl
	sgxRfPe83TI49eS5GFwx9p/+Og03jF1BI7pi6kPUL8ZCu7OODAXuUPl21
X-Gm-Gg: AY/fxX5e1i4NbRd6Pppkw6CDgPD1NaifXCIy4Yi2j4D/wJpCf61Q4OWZIzCBYfXc8OS
	lKnwpOskWpHgg7d5O/I8RdN6FvBMoezx3EmqwBZTxqKfw06AMv9BFgIGJNQuiCTsksQznAf8BgX
	FK/llwGmJrzA+CVVN5m72LREfkr69DWKNqKxBj3I0KIcsdHWblboSSpSyP4Zoi9aw1jm2G+F/4Y
	Uj3l6Dkg4Ip22hlAsGlkVsbRWS9mhTOJ8kDsuf/cCjzipFMStXFP6xVyeWypwdG+TQogFVcXRyO
	oM+ReSoC67vcQX5pF7QzeSr0209bXk/xJWBA/lG8vVygadPUDJ1ix+xsITg8nNcQBuLcMiAnyP3
	Lf3BRtHsxVll0YH5hjLFB61W9ONuWsJEKNw==
X-Received: by 2002:a05:6000:220b:b0:430:fbce:f382 with SMTP id ffacd0b85a97d-4324e4d04d4mr58561445f8f.25.1767601401649;
        Mon, 05 Jan 2026 00:23:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx1Nl8KRgrNe9z8PJkEy+oAdnaqu11UpBKN0xrzW8x/NIJB12I9Y53VIEzJyG5l7t+8XCSPQ==
X-Received: by 2002:a05:6000:220b:b0:430:fbce:f382 with SMTP id ffacd0b85a97d-4324e4d04d4mr58561401f8f.25.1767601401124;
        Mon, 05 Jan 2026 00:23:21 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm100730503f8f.37.2026.01.05.00.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:20 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:17 -0500
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
Subject: [PATCH v2 07/15] vsock/virtio: fix DMA alignment for event_list
Message-ID: <f19ebd74f70c91cab4b0178df78cf6a6e107a96b.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: asMFw2-SPRMy4prbABhENMDJTSWjJ6AIQHNp-FYUx5k_1767601402
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On non-cache-coherent platforms, when a structure contains a buffer
used for DMA alongside fields that the CPU writes to, cacheline sharing
can cause data corruption.

The event_list array is used for DMA_FROM_DEVICE operations via
virtqueue_add_inbuf(). The adjacent event_run and guest_cid fields are
written by the CPU while the buffer is available, so mapped for the
device. If these share cachelines with event_list, CPU writes can
corrupt DMA data.

Add __dma_from_device_group_begin()/end() annotations to ensure event_list
is isolated in its own cachelines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 8c867023a2e5..bb94baadfd8b 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -17,6 +17,7 @@
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_vsock.h>
+#include <linux/dma-mapping.h>
 #include <net/sock.h>
 #include <linux/mutex.h>
 #include <net/af_vsock.h>
@@ -59,8 +60,9 @@ struct virtio_vsock {
 	 */
 	struct mutex event_lock;
 	bool event_run;
+	__dma_from_device_group_begin();
 	struct virtio_vsock_event event_list[8];
-
+	__dma_from_device_group_end();
 	u32 guest_cid;
 	bool seqpacket_allow;
 
-- 
MST

