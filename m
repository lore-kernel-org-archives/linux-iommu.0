Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DF2DCF69
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089792; cv=none; b=UZp5avUXKK7JDKIynlkx18eXno5p9ydbiQg83nZGqCJvxkupoZuqQfTkykaw1Kn6eRZTTwkIhjpqC71TbQGhmNVxYf49bAWAAFz55ihBfhp2XxJpFWcw1htNmeE2Ns3/6NGUEfGm3DTLv874Vsc89PWrwJIg+h134K0ZJe2tgOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089792; c=relaxed/simple;
	bh=7vYhvTa0EsKkdKbYw4kgKH5spensmAuucNSR/pooHKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xzzefy1eiE6zeQkcOLk/kS1V5+drlmcutsqNFt/+aqm5xRVklpnEC3z5qlZ6MBfiILUaXtLDTXf4q0KJw9K45S1rX1g8ZDFVXK9yKoip+zdUPG+XVK9EnaA+FnMwdJQd+m6tGSmuWRE+SyrOeiPEH3UsL/KrSZpPTMxZYUh9DMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pu28dPwL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pu28dPwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OZZOSut1u/TDBTxePQLgpeDsLzuX17NVLcEs6Y0hRck=;
	b=Pu28dPwLkQyY/fepeq/6f6wV1tJXIt27CyXrQL6+T/OQd/dYPessCswlz0urtroh7qqR/L
	NTa4KlhUaL7eLRa5AtliUTs9uPU7YYV+xKbfDqTOqz/yrNOg4NICR2A7r6Re7y/tp2lUxU
	fjxkLbBlGWetPmFtwlegjkf0jDDShqY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-2nZhXSJTOk6qYYNvBsw2lg-1; Tue, 30 Dec 2025 05:16:26 -0500
X-MC-Unique: 2nZhXSJTOk6qYYNvBsw2lg-1
X-Mimecast-MFC-AGG-ID: 2nZhXSJTOk6qYYNvBsw2lg_1767089785
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4792bd2c290so94170605e9.1
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089785; x=1767694585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZZOSut1u/TDBTxePQLgpeDsLzuX17NVLcEs6Y0hRck=;
        b=R7yamFSh8gbmLG/lpiHvYJ2Ql49KApStHqDQU3Ep/6OkxIrARzzcnLXOHjKKDwGzQv
         6R64WfXkVdTr6ncFnlsiveRxA9e7fDCWba+H4v0t/zWhmi2UeUpH9V7bf75IFUQUIUul
         DkqmLQv8sy0cBk2TQlklcHTp/gWAfnYzYhdTB74iLBuJ6UcIE9vC+bjDsMPtxXKnBiCd
         cWMwtud+INJFclm1p6s/OCDE4KxZUklzjU29ZI9/ixm5VrLwKXcNnLiC9YOri02Z7Nl+
         JTTvNwz69JDKZgct2y0X+cyNyVt1p2XlmlWtLKgaLdf71+bwlV6uAKjNtiMzX0rv/sEF
         ElUw==
X-Forwarded-Encrypted: i=1; AJvYcCX1tTk+UU2rvbCQKBkCedeQ4H81IXbB3FoDfaZ+r8u2DGgk/hM5hFjMoOsw5WYwffJK/ISIoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyK5DNbrn7nMakoFMIGY320ZnJxGKlti1y6bB+N0ADoyczh+I/3
	L1xlwdb4MkzSrHeu0Zky7FovWQniXueNolTE/rwxQ0G5xkYPS+aVuQDsCJBEBBd1h1qxyM4WvXb
	o0536NONSIfDJ76/oSjyN9cZWhTs2VYGW7GaRdGB0BFa7e+w20mkoUjmz
X-Gm-Gg: AY/fxX7Sm5WDPMhes+OH9u3n6QBNVzBvEY016wgbPy0xM1hYdehXbSclIssMZI7+8ji
	uOh4o33QwJMauwQBdN8T/DhtETeuThARgkNlQ8uDSUlPOQSnrb+kM2I5GnXLyl8y1KXIIyyXPcb
	qt5BBYdX1txRA12iKld+0jV6Wjvbb75YFXtMVx5lerjBJSnLEs6uuY8Wyyjtu1hMEK/UfKsCOtI
	nF+umDUOddYiAzaF528dfLbsVLe6c6qHDUJOdO3L1OJC3VT7166vg96BYsVEfjn9aHr8R3TLCP5
	IwKzJ0Ml45zkqvi4xlwBKQAMqffhVnmoiVNezNRovZBvz48Xj5fu7ByNCdQ9/BzAgUEwAcQH/re
	d2Cq2/YAChEmocXdf0p8TzjhNvzQPstRMMg==
X-Received: by 2002:a05:600c:608d:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-47d195667d6mr373409485e9.10.1767089785448;
        Tue, 30 Dec 2025 02:16:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG01+uSPzH44CAd+66VyYkAwuPn/pb8j51wL1G42pmMr4duS4CHLId/Zv5CUmzKtGwuKnJahg==
X-Received: by 2002:a05:600c:608d:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-47d195667d6mr373408995e9.10.1767089785008;
        Tue, 30 Dec 2025 02:16:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm646323275e9.13.2025.12.30.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:24 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:21 -0500
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
Subject: [PATCH RFC 11/13] virtio-rng: fix DMA alignment for data buffer
Message-ID: <318c48915a52f1739c23d46b2b99e3a51c7139de.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: hxdgYbxTOImNVPe6lA_HI8NGaKHhYMl2593VqrN86EU_1767089785
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The data buffer in struct virtrng_info is used for DMA_FROM_DEVICE via
virtqueue_add_inbuf() and shares cachelines with the adjacent
CPU-written fields (data_avail, data_idx).

The device writing to the DMA buffer and the CPU writing to adjacent
fields could corrupt each other's data on non-cache-coherent platforms.

Add __dma_from_device_aligned_begin annotation to place these
in distinct cache lines.

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

