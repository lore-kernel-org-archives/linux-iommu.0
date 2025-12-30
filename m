Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2252FFF9B
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089810; cv=none; b=Ull8O+OZC0ZphFq3Bfxzek7FIssyth3p7sZK6Fak3dzSZx0cLHW6iRfEsBSNIOlElbtMvJkxLtGOJI3jWpxlKPylBDmt7bHS8RUlgJ1cbjkpyDuOzxV7j249AQqIoV+Cf1IeiIUOBSpvljqj7Pt8N6DVher8o+64OsJvQwdyRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089810; c=relaxed/simple;
	bh=t25qf9RPlFFNCOYEONgor27ZqKrRgzzuNghNz/03y7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XTZiFIeu0pmxF2WLUlyiu8HYfDSVnMd+tUTWMYDKy7cyZ+8NGyR672Rresp4lsnRDJHmI43APDfxIcVe5/90JGP1J5kqc5HB4RwOYS5gn/zN+rh7Vmb9/0ZL5phb5wmaopBmj9ocHimxwXSUw4e+9zQiMM4tJtTiS0OYNq35yG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=fail (0-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xiey2qO4 reason="key not found in DNS"; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xiey2qO4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BWhPgbCVUCKqyPHyev/7ivEXEOB+Fryu/YrpJpGLduY=;
	b=Xiey2qO4+y/w1ddg/TCEAUS44hFMfWdcMULG1eiTDggIaicLdobtlh80/eUBriqdqdnhpY
	gAaNxHAjIgQzV7dIbCoFCBKKktkJa0g7fIiDCO40IsKshWFZcusSTuvSHog0jfFwr4JftX
	JvI+CeAlsKtFST0QsOI+uWmpcXxuSqY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-pG_vWLFYNAG3CzW6OWKz7A-1; Tue, 30 Dec 2025 05:16:42 -0500
X-MC-Unique: pG_vWLFYNAG3CzW6OWKz7A-1
X-Mimecast-MFC-AGG-ID: pG_vWLFYNAG3CzW6OWKz7A_1767089801
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325ddc5babso3764317f8f.0
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089801; x=1767694601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWhPgbCVUCKqyPHyev/7ivEXEOB+Fryu/YrpJpGLduY=;
        b=nkM774y8f45b5T/fqLN0+0NsuPD3ndQGVXMt5LU+V26L2XxyjKxa0USjtBsHzc4iwP
         slryfdFdbdq2ddc86TiIHcUuRwYDYSnqrOLpCQtjY9Th9v/Zrc0qCyjUjBQb22br5lFy
         T3Q+U37Any6oqTre1TDOlKgpwzZqr0n44j9pK3eiDD9QcqF8ad8546p8iOao1F0QckI2
         GN2FE5fAkq4fcSOEm/2zXlV7mxwAGGm6E5WqR81QydQUEngK3GHwcfQRR1axq6Hlu7df
         PQDFiUsTGHIYarq0+B8LzbNoJh1qDXkOtf4JhrTOdkaBTmrkoOZtIA5hAlVb9rLfkr7V
         Gtqg==
X-Forwarded-Encrypted: i=1; AJvYcCWBN/GUJ/Zo85JvUbeNCCDzmkN3Pi7GmPDvaVB7ywtdFiAzadezuQXVlCdXRq8+NuGbQE9rYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLwkNri6oe/b/6sf0EMdO08oPcO8TbArJpLmE9DvVrNS8miFcK
	UDLWQK5EdGUjlWPG1jzE5L7SXQkhvhwEimJUNtTDAtJSBex4L6QQL0KYpIu767Gkhon7/pDVaf2
	Nfelgns0vxeI/sEkc3V2XkAC/IH24GO3hqrbKWgyB+pwHx3IlW22GcU8B
X-Gm-Gg: AY/fxX4laUX8hGHLc3iFy7iUpCZc0OUsMRa8+hCffRnuA1VfyB9OCyEAUSRsq9uuLWM
	1Y/N/xUopE/ndEmuuG+nCnvBSrr71/smYzTqOl00EPUz1/UzbifVnis/DHu7QFN8qD/uOTdK3El
	J6ijdp3Fdoaa8jC7Et1ql3PWaoW0XJszpdExuv8ZoT5tnoUppW70QmjBm2KWXExibWP5iOzs1/W
	ajdK5fERO+jXQ6NudrfiOoOKmLQei7PVfTFKC5geDWYAHaTOJpszIpsoJUf2CbSWXHDKtA4g3An
	ZmN3IWz69o+M7phizW0mYarUnx4Ih/GAP6g8NExEXmI4oM4dV5d7QPreIs1NqVYbCaqyKFxqIuU
	1cDcZjsU1vdMZG29hmbPaQwW2AmIA1PB5sA==
X-Received: by 2002:a05:600c:a413:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47d1cec8f39mr297842265e9.18.1767089801406;
        Tue, 30 Dec 2025 02:16:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf8BCC/QkGwDEfP5RddRZimNY2rmw3JwKmzFqtMOWIF8UhfXRlD/gfjFTVaD3LdsD6J0zJDw==
X-Received: by 2002:a05:600c:a413:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47d1cec8f39mr297841845e9.18.1767089800959;
        Tue, 30 Dec 2025 02:16:40 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be279c5f8sm610553745e9.9.2025.12.30.02.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:40 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:37 -0500
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
Subject: [PATCH RFC 11/13] virtio-rng: fix DMA cacheline alignment for data
 buffer
Message-ID: <b2e350ee2542c5c372b2973fb68d4fee67929d5c.1767089257.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 1B1PEF68lSbP3dvbJLqRUn6koTd1zEyUJnha81jFjEg_1767089801
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add __dma_from_device_aligned_begin annotation before the data buffer
in struct virtrng_info to ensure proper cacheline alignment on
non-cache-coherent platforms.

The data buffer is used for DMA_FROM_DEVICE via virtqueue_add_inbuf()
and is adjacent to CPU-written fields (data_avail, data_idx). Without
proper alignment, the device writing to the DMA buffer and the CPU
writing to adjacent fields could corrupt each other's data on
platforms where DMA cache maintenance is at cacheline granularity.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index dd998f4fe4f2..fb3c57bee3b1 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -11,6 +11,7 @@
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_rng.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -28,6 +29,7 @@ struct virtrng_info {
 	unsigned int data_avail;
 	unsigned int data_idx;
 	/* minimal size returned by rng_buffer_size() */
+	__dma_from_device_aligned_begin
 #if SMP_CACHE_BYTES < 32
 	u8 data[32];
 #else
-- 
MST

