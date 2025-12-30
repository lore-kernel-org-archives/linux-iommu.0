Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482712EBB8D
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089785; cv=none; b=momecr0uxYHURNu+KBnlVuej3GWqvLxLSWX1V1QuCVTwVsUT+XjWuuy1a23Sv4ydltKqQpw+Qc9a4rLo4Fu0Kjrlaq/Axu1AtsxlMANVs7EAEhsm0vBa9r6p0PqbsSO8cJHltJuhKcWeSyZ/DpY6QQwlRlCL5ZeK1XPwbGMDvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089785; c=relaxed/simple;
	bh=RzxSFhz+bpkLtGdr/5qvrDQOf7DHug0oDxHEj4NfN04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u+uOypMptarLQSFW7ZScWKnwUmXlXg4BZtPDfcDxLMIw7kZfkL1OXB6Vakw6geAuNFKspOoj2i7OtFZRUX5IvLd9AnDHl864tqlMql83iUelzVPXoxBDzM0UG+RmqJxEBj3gYDhfPq/AlYpQ5e8GF1RkCjIohpIk2QqlPAKlw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GG1e92xf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GG1e92xf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qjCbMizY1BaJF5yBWOLXV7DyUl9vbunxYIEFqfWmhYA=;
	b=GG1e92xfXwhdCfXUvWy8J123z+Vg7kCtHuNr/m3hKaNvn9RGC4OKv0ohda0Zxj4wQREy1p
	xe3xJ6sid7rHsX0+C6Pm/J5LoNli5rVoinLSSXriVcYFI7GrbodDENgbELVi+Zy+NJcMRI
	0sNj8PIu0WwXd5jsawV79NcWpsa05Kg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-6p95mUXCOLOiW9rs2C-Jrw-1; Tue, 30 Dec 2025 05:16:19 -0500
X-MC-Unique: 6p95mUXCOLOiW9rs2C-Jrw-1
X-Mimecast-MFC-AGG-ID: 6p95mUXCOLOiW9rs2C-Jrw_1767089779
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477964c22e0so70032765e9.0
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089778; x=1767694578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjCbMizY1BaJF5yBWOLXV7DyUl9vbunxYIEFqfWmhYA=;
        b=SMMg2gIyTSW2Nujb4gofNIzQKT0Mhw8Qf8J5DTJ3xok7MH58PJRMkVP8v65KS89B0i
         tguwoyu9mEGrmQDtmqQOnVr4Ab5H3tmyIGEvoBDENgv/d+R+dui5PjmYHosU+Tleenf9
         7cP8JUKnsbZkW2yL8Njo6/1d72mNBk0u3uGCwA7Dea844d7Ynj4nN4mNmHUucKvLyuog
         5kN0lGKam6E+5AENRahO2ZeApJvEB1awBFPVonmMufUdWG0zIjGnnZrQNinbjvuG1GmT
         R27xmHUTDXAZTWrxJw2BXgAEzSTYmwuS78FD6ZO/Vu3QIHRsERPOYDnn2qbDVorEbPWz
         Y4ag==
X-Forwarded-Encrypted: i=1; AJvYcCWtB8fZYLdEqnxlUNQTAdU49QXULR86rD235AFOMmmFuAF5xNp8v77jHrE/jUaa77H+B89rSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzN342WNudUw7L4UDB4g8NZl4DVrFyOA2U4Tzt3Jhhzg7BmngIu
	9FZ/CRJtRkxem0r2hg7xsCfd27YGXwFwGAtc2WtGdrkqs1KNTsOMgs3TDBNw1R3GffYa8ZUUfPc
	l90PhCTILinGPWtgB2bmYcE5QYZb02YE9QLYdC92Fzcl3vKXBfaN62aDD
X-Gm-Gg: AY/fxX6STEjzT6jyJO+9I/SWuejHKa2qS4KOPk2KgotQkCNZa2DXaOmsssJPDq6hgeO
	7bABQzUJH8vOnpKKPJwsX410MxwA25ihyVUVa0ZR1z6KYDXmJWvvBbX1dVdXr7lQ/wNwalx/ZDV
	0EME0ClPJ/3mvYmgWCfOiOyXyYMFH5jRgRKX1qQSZKpMyFBjmWHQzlv6kbga9OFqYtH4CU1GC94
	ZEjDOtJusPZIXznYr7XkdItVJO1Hrh47jxYBN3V/pNG7KfJIc1l0LZVLtiulybQ9kxGtPtPRbYk
	FJHMYGwq5NcXj0p3dkXBzQlgHRR9eqyz4TFWgvxO0Uvlc+2omI+xu/sKZ7Y2xVCE24xYVb1hKyA
	8b6cpytGzT3IzgHnwRvmkrvlipTs3r8bbrw==
X-Received: by 2002:a05:600c:c04b:10b0:47d:333d:99c with SMTP id 5b1f17b1804b1-47d333d09b9mr218755315e9.18.1767089778574;
        Tue, 30 Dec 2025 02:16:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT+g6nqLgyQkQdYiav+FpD+RF51wbupLPftlD1j+tQDbY3ul4LGHX6uIhkOPdx1xlKUXo8aA==
X-Received: by 2002:a05:600c:c04b:10b0:47d:333d:99c with SMTP id 5b1f17b1804b1-47d333d09b9mr218754935e9.18.1767089778175;
        Tue, 30 Dec 2025 02:16:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3aea77bsm247750305e9.17.2025.12.30.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:17 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:14 -0500
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
Subject: [PATCH RFC 09/13] virtio_input: fix DMA alignment for evts
Message-ID: <5f57d7dc13920517b3ed3e56d815ad1ba4cf36ce.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: yO4O1cM4n02-00Vp7kW-WlpA4RZg0jxbfsszno5j05c_1767089779
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

