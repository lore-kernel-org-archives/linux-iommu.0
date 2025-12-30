Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C448320A0B
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767112839; cv=none; b=OPv/fTq18tK/Fr4d1frQ2cKeA0oxN3qWivkcoAfsjP3AOdDr9X0Me3XgLocltjt9SzLdKEr35FMw57pl28PIzN4g1fBodQP+WMLkip9QPNZTGpSXnBr0sYzIhIqHJsrxJY6dL9fKXfGo14CaArPzhRbBDeXzht/gpeIT5hEFWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767112839; c=relaxed/simple;
	bh=R3ssxNR/IfKvvzigNkiBKuIwzZmdFCE30Vek2VE5a/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k+ZM+ZKPIuYxVeG978hWcfM07szWetvhekqSFIrb+d8KRjD0ngDJlcGWpC5xeFoPmNg59UDLfK4UtxHuP8HuEXyAno5UBVHRnnrJdKZm3GkUbW7touxAeWYm4RQG0UKBpt+a6EZUe4y0EfS/0fhKph+u5F6FIoe7gZBKCJgmTAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBO92N53; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBO92N53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767112837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7J8z1fD7DSMGZ6iKBx0OqXIx7XfW+ZYePKweShXuH2A=;
	b=FBO92N53VqhhEsAoKDp0hCn3spCXwgIQWtQW6ZRto3gf+xD0J+wmbu1IpLvIwIp0GMwU+0
	CtjXhCac8SHkjJEYXal6cyXWxLH/a1X0bfkHekniDDqPcL0QsWkA8UChItDxFYvQ/hmkeL
	b1mRkM3cB5QLhwZZxgMct+X4+BY9OAk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-h77z5xjqNE22EgkfDA0Fmw-1; Tue, 30 Dec 2025 11:40:36 -0500
X-MC-Unique: h77z5xjqNE22EgkfDA0Fmw-1
X-Mimecast-MFC-AGG-ID: h77z5xjqNE22EgkfDA0Fmw_1767112835
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430ffa9fccaso7916558f8f.1
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 08:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767112835; x=1767717635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J8z1fD7DSMGZ6iKBx0OqXIx7XfW+ZYePKweShXuH2A=;
        b=ANsicf0KnYmapANA9he/AKGHiSXcQ9Dds11DX/aruSLCU2kkEGoY5itq1T3/wf/N72
         5L4z7+Jpve9V9E6Omxfpd07zD8bG5xG3h1ryzaRWdjMsqltb27kURRkJXiOuDshrSMYL
         2VZTCyqykgQ9IGwk75mygI7isuDQEOo3j+gJxLjKuef7n14EK1Msv3iyyJqitAd0JSxB
         E7turlj0jpjFeSOnTWte2Ge3gC84LRRR8G4wYe/ppXubUV1UwWh3K8vIRiDy8Sn9/Pyu
         RzHYk0lb8G+WWmd+TPBNnC8iyhWGbHgZiR0f64clSYnrZ0ppJIlfdve/gyFCB8RB7Lol
         al0A==
X-Forwarded-Encrypted: i=1; AJvYcCWw92Iulqv4SE7mMucr4Q+HNZVbvztiPiiw62ezjAsTCam/NooVxKEoayPSDNOyQ9q2zT9ayQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwXmE/X47Ns5GH38LOoFFmlwUWlNjqM9nv6Fqj4jT7PWZ0oVsa
	9V2y/bCIFUZeXRWk6bqXSYEpDJMDl1cFoSL+Z3WcyA8cLCXt+kGfnTuA23iZZsDp4xXJu6Q6gdY
	P8UIqZLQVk493gx+j+ZgX+8m9WwqL98U6zL1yVYDBQe56B0BOvD41V0U/
X-Gm-Gg: AY/fxX74UWRWs8sNzIpTJO3JveM8IgKkpORYEr3ekh2BrkV4Z94Nnr9JOjIrHFU80UU
	1GZLsWrFR5F/vlkSwumsH3USeHB+VdUUEYodzfrkD9FvSuNe9rYlMureU1XYjaf2COXLoaZYug9
	rM1kPL4k/kpZIq41gmVItAj8LldiSR1tP7p/3OuaJ4rIN1RbxjasG4112QJFA62opK/kjHIFc9E
	M4A7CxXe0weN2dF1MYI+fyfDhs+jOQM6lfbUlcXDfCVkeTcsU/Jrxpx6kKtNGhUjIA8rNGkr/wY
	+rZwUIrBZi3gRuCKW3z2Vc7f+gjO/DdoqddceC9kbBh08werS9TKXuy9spIlSOYMCJ+RdKu6G/t
	hS7jJC98e4XoKOdVlbWgTJFgLOSGgY6t33g==
X-Received: by 2002:adf:f144:0:b0:431:855:c791 with SMTP id ffacd0b85a97d-4324e4c1501mr32588435f8f.3.1767112833335;
        Tue, 30 Dec 2025 08:40:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECVSdNBMTG9k8N96cOa931b+MOajxv263SWbXaTmkKbkTS3ub+IC9yjT+L/YMFbjvC3biqWw==
X-Received: by 2002:adf:f144:0:b0:431:855:c791 with SMTP id ffacd0b85a97d-4324e4c1501mr32588393f8f.3.1767112832791;
        Tue, 30 Dec 2025 08:40:32 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm69573295f8f.7.2025.12.30.08.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:40:32 -0800 (PST)
Date: Tue, 30 Dec 2025 11:40:28 -0500
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
Subject: [PATCH RFC 14/13] gpio: virtio: fix DMA alignment
Message-ID: <6f2f2a7a74141fa3ad92e001ee276c01ffe9ae49.1767112757.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 5J4uCQOvd31w0_0t1_p9K1GY-QT1w-4Kp2gFFEXm3vs_1767112835
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The res and ires buffers in struct virtio_gpio_line and struct
vgpio_irq_line respectively are used for DMA_FROM_DEVICE via virtqueue_add_sgs().
However, within these structs, even though these elements are tagged
as ____cacheline_aligned, adjacent struct elements
can share DMA cachelines on platforms where ARCH_DMA_MINALIGN >
L1_CACHE_BYTES (e.g., arm64 with 128-byte DMA alignment but 64-byte
cache lines).

The existing ____cacheline_aligned annotation aligns to L1_CACHE_BYTES
which is now always sufficient for DMA alignment. For example,
with L1_CACHE_BYTES = 32 and ARCH_DMA_MINALIGN = 128
  - irq_lines[0].ires at offset 128
  - irq_lines[1].type at offset 192
both in same 128-byte DMA cacheline [128-256)

When the device writes to irq_lines[0].ires and the CPU concurrently
modifies one of irq_lines[1].type/disabled/masked/queued flags,
corruption can occur on non-cache-coherent platform.

Fix by using __dma_from_device_aligned_begin/end annotations on the
DMA buffers. Drop ____cacheline_aligned - it's not required to isolate
request and response, and keeping them would increase the memory cost.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpio/gpio-virtio.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index 17e040991e46..32b578b46df8 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/completion.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
@@ -24,8 +25,12 @@
 struct virtio_gpio_line {
 	struct mutex lock; /* Protects line operation */
 	struct completion completion;
-	struct virtio_gpio_request req ____cacheline_aligned;
-	struct virtio_gpio_response res ____cacheline_aligned;
+
+	__dma_from_device_aligned_begin
+	struct virtio_gpio_request req;
+	struct virtio_gpio_response res;
+
+	__dma_from_device_aligned_end
 	unsigned int rxlen;
 };
 
@@ -37,8 +42,9 @@ struct vgpio_irq_line {
 	bool update_pending;
 	bool queue_pending;
 
-	struct virtio_gpio_irq_request ireq ____cacheline_aligned;
-	struct virtio_gpio_irq_response ires ____cacheline_aligned;
+	__dma_from_device_aligned_begin
+	struct virtio_gpio_irq_request ireq;
+	struct virtio_gpio_irq_response ires;
 };
 
 struct virtio_gpio {
-- 
MST

