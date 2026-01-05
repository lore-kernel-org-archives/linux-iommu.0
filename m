Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50E32A3DE
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601429; cv=none; b=gScbuph2JMuredkXifMgTHP8cqgGFcoarT8ETOnVhGKr6OM5irqQZnwjX7ZH4Z0K3W/4dF0dFJfAabFSPWes7/MhNEXDuTpJHJvQoJaiwYLRzWn0TxcJWNqnfjYpPBtaflpXqpIcszDmnyE90Y9hO8v4cbyAuhh3U71nbQhNUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601429; c=relaxed/simple;
	bh=aG8SdrVHEUE18T+idL+tMCWXHe6vRndhmeQnti1MW2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fZfnxH6LDvz71dix5MLRKn7tVcN7yqlIjO7KqtaTv8v/l+ta5bg4VrOG3mch3UxVfl1/qhH2FH82FTce0GPjW6WjxXnUyagkw4qWYyGzbF19nzbXACVAkZrXj+T3NFliFHQnuGXdo45ERr8F96nx0ynEngzw7aE+wHze0Ls/aJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJLOHygn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJLOHygn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1WdygBrbpusefWmIaX+oAwz9bur1qkKHYd3aQzYNeN8=;
	b=IJLOHygn0jycrG+u+R2SxrrlpafXVcHrKb1JC2w8pPPPiq6z9M882Fus/umMrY5tKWf8A1
	c2c/0v7xocDq4o1d18R8L1W5IfUg5RCtcAsMWVq+xvCOQt5sSKnsHDvb9CJHHDCd0fqQtQ
	BPrSf5x8Yxr5NCkUB6i1nKgtt63QsTw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-kVQedstMOA2FX-yP3cjE4w-1; Mon, 05 Jan 2026 03:23:43 -0500
X-MC-Unique: kVQedstMOA2FX-yP3cjE4w-1
X-Mimecast-MFC-AGG-ID: kVQedstMOA2FX-yP3cjE4w_1767601422
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so117044075e9.0
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601422; x=1768206222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WdygBrbpusefWmIaX+oAwz9bur1qkKHYd3aQzYNeN8=;
        b=BQri33HndMGkjQ1P+msFo5mcxWvb5XVjgLhNo4tjuEBA0AsyjIE/oPdaSJqlpoBQHm
         38Wn1yd+n+PpwvjFI/NNC8rI+L59y1LFNwdOxu3he11esOVdFDm0VeNdyqxFLRjyo1yj
         Gs9BiLVUKYvyVQwkYtfrWABTvzpxdRtdy3yPs/TRxo5ObuWXfskTJTQdjXJ13/bmIloY
         2sxwGq0QMfTt2T7TeqYrqRSsqjyEz01UMfF0+r5tlu+VCdrM1R5PMNNic0axhXviZHbh
         6Cyl5nePf6UQwmpHanzg+J2RXRKlJ1ueNGm0FpFAaWECLoS/y5DBeENmI1tHy+zP2Z3Y
         KlAw==
X-Forwarded-Encrypted: i=1; AJvYcCWmnodxvYaYRwce7csZjpCDrZlXyb9WNlDcicccQOq1N/b5NWZEc6a3bFU3fi76Who4UwFT4w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl8CHgPZb9Y/wGSsIGEYsO+DpbE0Dz6I83RYaJ0RWrdQrpqBTQ
	h7exE0Wl94MXp8IKbrGf1HFoI/vmkerK/xwcN96IB2TTG1fTylZUaLpkA1nza9D476ly/5/NE5H
	n3rYfan9XfwOoEWTy1Co8gmCpdBNaB/M9/uM63af4y/sgqZSeHa3/DL80
X-Gm-Gg: AY/fxX729nzORmWT1jN8FYnc1qfHlHUc90hd6CTgD0qSFneC0jk/NSlwKVNtLSDVr3L
	Zgd2kz8B1lo/UDbhgCkDSA6wRbFUxXHHVMX6FuirWgNQdv8CiMQe6bSN5TPts2w6df82PeoTi3P
	TaQx29sORs+qJT9WPBwUPj6hCjr29yBvtVrFew+AGuqnJuYu2YTNGEaRbcc+nnbAU0wZ7gjM+mj
	nmydo9dFhW/YxpKR1f57+2pfHv16bKk4auDjLQlAOtQ+Yioyf6MpLVTfSdIJg8NPes+HZKV7c5J
	anPsI3xtcUuE/+Ityxu+Q6sQmL+NRVM2wYVWFdRgwTdKidHUNH62X1R7zyvgdkk0sX6V55cPVeq
	nvS8yKfixDdC5/Y+Bv8fakzt/Gr15XAhObA==
X-Received: by 2002:a05:600c:1e1c:b0:47d:4047:f377 with SMTP id 5b1f17b1804b1-47d4047f3e5mr400615195e9.36.1767601421773;
        Mon, 05 Jan 2026 00:23:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0AgOv9S8mcPvJ16vNEXPXT2v+oy4k5XMxl4opf9hSfJCRKVIgJxqAgfJFXStW11yISqh4Rw==
X-Received: by 2002:a05:600c:1e1c:b0:47d:4047:f377 with SMTP id 5b1f17b1804b1-47d4047f3e5mr400614705e9.36.1767601421303;
        Mon, 05 Jan 2026 00:23:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d33eefesm137323605e9.12.2026.01.05.00.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:40 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:37 -0500
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
Subject: [PATCH v2 12/15] virtio_input: use virtqueue_add_inbuf_cache_clean
 for events
Message-ID: <4c885b4046323f68cf5cadc7fbfb00216b11dd20.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: YKykAyHCb5uRRrXZMAdVa7ktz6rLbZL05pLdUc6v2mU_1767601422
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
index 9f13de1f1d77..74df16677da8 100644
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

