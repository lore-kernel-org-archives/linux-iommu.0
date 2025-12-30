Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68C2F1FE4
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089799; cv=none; b=WutF6/E/IuhLqpQKNvaJJWgOC2EJrJa6HkKhI7C3ijNV3on8xcZP/WDDv3jNrXVCpgirt6WVQlzE/yIbLkv2UlYHXPqhUnTwTbJsiiNaX4mavHZEaC4DWtBPVPEJt3ajXa3A6fq5dBT3XXnYDtimGcBUcXZAHmeq0WDJ/JUldOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089799; c=relaxed/simple;
	bh=ikTC7dMS0j+aOW64LriWXLGZXkKoO1gYmsQNBLOSYxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=f4pqucBN/YXuqinhKLBjh6bC9HkLCw+tJ/fS5lLP7q+yL7xj6Sk/FpwciStT7FuXvyhbZQT5ShnA+j+KEjxF7XVDD7Noi4+H7rbcHCi32h2OjBv6XfCf3xKGT+YO+AJ/XCVPo/ZDrKcxjR2PPCoQ5MJf2zVfFU8Lj/DZphjwkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hkow8Crk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkow8Crk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4agnfRlmC5GgzX5Rd2z2Ldj0cW20QjlA2/E3WP30vs=;
	b=hkow8CrkVcd0/haLmVWfJaO3wPZn9EqzxaBVlJ22Lw+2Cy0U4N5nUG/4UNoaIb8u7vGrKn
	IzHUiIri+MWYH/WXRA58FyNs1m+on2dZyCcpOK59HX7QMvhv9vNtGPhdRGsRbJ8uYiqmes
	Xy7oLS8R2MjBgpjmQsgJMcMhecOFpJo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-FEeH_xfdNhiBUUUoVpGwqg-1; Tue, 30 Dec 2025 05:16:35 -0500
X-MC-Unique: FEeH_xfdNhiBUUUoVpGwqg-1
X-Mimecast-MFC-AGG-ID: FEeH_xfdNhiBUUUoVpGwqg_1767089794
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477a1e2b372so77926195e9.2
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089794; x=1767694594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4agnfRlmC5GgzX5Rd2z2Ldj0cW20QjlA2/E3WP30vs=;
        b=Kll+4McPV3Xrktl49Ntb7NegqUm7Rm83ttSHlzgQ8crIrge1SCnLApX1NA8DMQNcev
         d/4rv/WYYOIbxUHlgeUqyOIRSN8Ge+f+RKO0DYEUzDABFnrchkQVre+19ZTqRTtOBFGC
         X0BcfZA5Na5WpLRsikA2NvoKmepO+ZD+LGye+WR/THl/ckmU2olKfYUr20O/qwuVAykw
         Fmj5syop1HSOsu0HoiGoTWZnX9jZH86ZiB9chlaw6jRCAhEujQjQWzLLW7KDm+9nXjzN
         xqMcFWgUoXmXenVK1ZHW4dwjwo16leuJ66dntIQUOjQJid6TndxvZhLGnsXLuMSEaZtG
         r97A==
X-Forwarded-Encrypted: i=1; AJvYcCXCbjCnGxmSbhE4N33D53LCB4DpKJmTUkNP/OE5K73dKjc2779yzTP5oul05SIQwm1adIwzYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMMrmyaRFgZc1wF1Y5naE7WOEAiGOqSJ2UP8yEmkJlnK0sGccm
	aBkh+DhTY+bJwsQ31z6wV9dKwvgGIGEynciFTARe/guvG3vWA8/W1+in4h/SrGepSLeGz/TQ72N
	MIxjFl/zi35x5lCl+Gkgrkp0lUUyU0fIvlP1ok2iE+7p+dLPY81Nb3W6/
X-Gm-Gg: AY/fxX46z6DZRp13Fe0D3Aw0YFOGhuP0T7hmsDXNHl9VIcDhXZuFpzCvfgeOqx/wu18
	wY7GS+cq7waTVH1tiOaDtXjtaG264V5odAVeR7azptmNOWoXwzva3Y8jbe/gEQMgy0ce1BMp32k
	l+0p6oaXhYqzq5j+8ezIEHC5qkWtycbNIyfw+gtPpjI2i2H4vW4JlPAkd1b6NmLq1GJLS6WHl01
	RnM1VS5miUGmf9tVzWHOzpIC8/uhaWdkI+pnbHlMsyFjTEQs3VqsQtLYf5sqzuKM1xxJ4wuXn+c
	rXUuisPWfvj90k+s6KOmxwK8BqMGeoDuOHfyQeVEamdwOeEaMJD+p+Ejbdj7gZO7L2qFcdNI3MV
	BkPE5ffo0IHSgHrFKNQZa9yLUewrHRsFPUg==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47d195aaf01mr352317325e9.35.1767089793781;
        Tue, 30 Dec 2025 02:16:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/8/udlvjg5mJuYpI0a3oxpEJUtwKIPq+rFtOrgdem6Ktq8tTHyeQzy9WGlYRf+5N+zum/GQ==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47d195aaf01mr352317095e9.35.1767089793385;
        Tue, 30 Dec 2025 02:16:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm638896415e9.12.2025.12.30.02.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:33 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:29 -0500
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
Subject: [PATCH RFC 13/13] vsock/virtio: reorder fields to reduce struct
 padding
Message-ID: <dc7de7774ae19968549cf17336c15503fa7d10ec.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: fIMfourdAUTfD12HhFr1JyEUiTbzNi7z4EPLhtQBWIE_1767089794
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
last. This eliminates the need for __dma_from_device_aligned_end padding
after the DMA buffer, since struct tail padding naturally protects it,
making the struct a bit smaller.

Size reduction estimation when ARCH_DMA_MINALIGN=128:
- event_list is 32 bytes
- removing _end saves up to 128-32=96 bytes padding to align next field

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f1589db5d190..2e34581f1143 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -60,10 +60,7 @@ struct virtio_vsock {
 	 */
 	struct mutex event_lock;
 	bool event_run;
-	__dma_from_device_aligned_begin
-	struct virtio_vsock_event event_list[8];
 
-	__dma_from_device_aligned_end
 	u32 guest_cid;
 	bool seqpacket_allow;
 
@@ -77,6 +74,10 @@ struct virtio_vsock {
 	 */
 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
+
+	/* DMA buffer - must be last, aligned for non-cache-coherent DMA */
+	__dma_from_device_aligned_begin
+	struct virtio_vsock_event event_list[8];
 };
 
 static u32 virtio_transport_get_local_cid(void)
-- 
MST

