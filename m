Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37C2EA754
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089778; cv=none; b=Lph3f6ZRlDIcds/TPkV76M66WiDXF7Pf61HBi9hyLE9FmUdTOuJSnp5nCA9jNvjuDq4CG/Vf5+YCeLkRRo913xKZGrrB7+HGXxfLPR/MVlNLvsfHMGBkez9zlcqVtAmzcG6hQ+zcBG0FzXca6DNn1uqwnFllieGT7bug3Zbm4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089778; c=relaxed/simple;
	bh=1nvGVVfYMss4t3CEcUrrF8Nk2cSppyMGKm3YyiTIiKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=A/nmFmV4Ui9jll5qzW8qjFot+9Ab6lDm0OGKhi2brCPekovrnBIdBPcsIqJW4mbza4Y9orMlUVKTILaO5qKHeDmGY2jRMvKkp/NxwVeOjrK969Y4ZzNBI2jAyuvCSa2RJbz3HxblTJLab76hwp0agHM+imuo0/e/NQeWZ8Dchok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUV93+Gv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUV93+Gv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N7TdGrHAal4YSCbHD/e5fBMwf7XbmUGP5Z2mh/ui0sA=;
	b=JUV93+GvNWX3nxpTw8cau2vP30RBijuoxCYWrIDxyYcvX4p3XvCk95xccbON6+L/U3eb9t
	si8hWuSvT4Mt3QErEjU5PTb0AlztpEMPM3HXaJlVfXud/33UjYfqDajJuESmoRTs+TkhT4
	8bBFTetu85d5QnbDKsQ6WrE2G/IJ4h8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-q53j6myKPJyd5jXLiU8A6w-1; Tue, 30 Dec 2025 05:16:12 -0500
X-MC-Unique: q53j6myKPJyd5jXLiU8A6w-1
X-Mimecast-MFC-AGG-ID: q53j6myKPJyd5jXLiU8A6w_1767089772
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fdc1fff8so4846589f8f.3
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089771; x=1767694571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7TdGrHAal4YSCbHD/e5fBMwf7XbmUGP5Z2mh/ui0sA=;
        b=FYrT6Ab0VWcc1JcWwe5csus2wqotJ1r1e9O1u0o5VpZbxDUKOQDVZeTiPevG+KrKdJ
         Ya7ACrK0p+PSV8YikpBudxq6GvuoIgtRcN9dWFORwsoGWv17OOOy9fbWpO23Wo/wOqo1
         F86uz8ych65DKluvGlkXmXTuzVItOhjLTL1f6i3uJHiLQMqA+QnOV7e8QDJttM+6x1gF
         1OWk/0LYTuga6K/0Tyq/s+2/K8Psr52lcuKu4DLBqPQ/6EjIJ/LH56mTFqydzEkzl3Lh
         DZCA+NfyJHvRna62o+NqIBByH2NXZtj+2izk2uoX1pTGXURJyBHSLAhimNsFibhhLRSj
         Vqfw==
X-Forwarded-Encrypted: i=1; AJvYcCV3D8uRONIiIv6r+MewuVVEfsRNBfLNz9X3ZXd5zdZ8Fq3jH07DaZgCr1gtAu/kWY3IYeY6Hg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUS97wuvwzVWRhp1t3l5jnBesGpL2+3Rl1De/tdwcv1+zJuhVO
	vlPcZAhHzl6nv3eHLboKkDIxBxXPHFwvPRs3jNRiZnKluS+0zXi8yce7Rf7gqD9a9qrthZcpy6q
	HOHEWb0GHii1eIxrvkGNPScXgodghqX/AlCSaQXni6GNpvTlm2iH1cugP
X-Gm-Gg: AY/fxX6x3zUJfbSJp6Wz1OxvcoAmNV1cYv82HWOPPhEc3BWjaaPo9vB3l0R/JX/ZknM
	SosJ45nm2OT4ZryAiRUGZiFvwoUo/BteaCfwNyiPJO1bNnaqxGxvmF5epA4sqGcoitw3nkA72OL
	2NlRRZ8rlggTqwxJpMh7K47fMN1r4A4Z/GCfLm5otAUpsKQAAw3yjqP3En+rp8IhIR7UFbPfC8K
	8sYZisbNCcROxlXjXcZScyVdjWG9HsCuoC/J+gHimDruXH9r6/HdKOG3C7vziM9+wernKxOTtrt
	Owm1PnYJ4vjeBj9UHvQwtWG2QGfYOs31wuLF2kRGOCeSfWQMOOyU7WYYAaGNFBoZ6rw/gig7b5g
	LiCSn9/QRYyKouPM+Z+panQN/P2SXMFW4Zw==
X-Received: by 2002:a05:600c:45c8:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d195558bemr375729775e9.11.1767089771413;
        Tue, 30 Dec 2025 02:16:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjzVX0GYuttaIVhsj3PIAp1ZJ2Zp++QasW4yFBwV4WaDkrZ/icz8/Y8CMg+xDJDk6ilEld2g==
X-Received: by 2002:a05:600c:45c8:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d195558bemr375729355e9.11.1767089770967;
        Tue, 30 Dec 2025 02:16:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193d4e91sm569777955e9.13.2025.12.30.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:09 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:07 -0500
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
Subject: [PATCH RFC 07/13] vsock/virtio: fix DMA alignment for event_list
Message-ID: <c195bc45032be85c3f0bad7362f0ba0a4e8a7726.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: mxFo7ZttiF8xZ25ZZuUPS0ud1qYIdAvV0xorthiLU4M_1767089772
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

Add __dma_from_device_aligned_begin/end annotations to ensure event_list
is isolated in its own cachelines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 8c867023a2e5..76099f7dc040 100644
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
@@ -59,8 +60,10 @@ struct virtio_vsock {
 	 */
 	struct mutex event_lock;
 	bool event_run;
+	__dma_from_device_aligned_begin
 	struct virtio_vsock_event event_list[8];
 
+	__dma_from_device_aligned_end
 	u32 guest_cid;
 	bool seqpacket_allow;
 
-- 
MST

