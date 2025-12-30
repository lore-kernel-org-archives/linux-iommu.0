Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA82DEA83
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089783; cv=none; b=I4U98TAdWjRX3XgIsPim0g2RNobw3nSSYpBSYUaSVZUd9zFkKzguL9OpOeYWxVQVKL2T+EOg5mGDTulXTktYiDWzHRnXyv7FPbwoEhTF3TWeUl64fMF07/IkQ4UXql5qG9XV90VefmJAWYhvVKixOvV90OZW7AClpLtnNKhrXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089783; c=relaxed/simple;
	bh=d79M2iBKtK7/e3UWQBP6Z7XMZcGHJdPNMKAqQ6Eyk7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=vGklqG77b2z1DsDPf1ADCngedlM9Dq4ghHc42p6QnbrEU8bmWFPFiGu/oRXc+jB3JgVqEdE2LVnZFw3X0axcWxiPnTI6hZHvIfjjABRAHFIfgNrF6BHoCFPyVyoaPmepTO1Cvz4U7Xwt0akQ0PMWA2XE6vpZbC7K2xoTDCZJF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejYUk1rL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejYUk1rL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awHY3MD6YI7UgDTD6QKfkNuaN+VrZkEZlRiSgXqWnPs=;
	b=ejYUk1rL/4/xC/SeuvqlSizjOTFA16yIVrcVxZFu2jjrtRJtE/sU+Js1D00Ai01Hhygr70
	4QPxn/TMjQrZI3y9UcAsSU5ff9c/hrWLkpmNcUpGTlDXEuWTPKv5VU095aXTHBmfKJxEAu
	fepOBPhd3gKyhusFZ2g8jJenmeWmj+M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91--x2ODoBEM06JgKs9fHfPQg-1; Tue, 30 Dec 2025 05:16:16 -0500
X-MC-Unique: -x2ODoBEM06JgKs9fHfPQg-1
X-Mimecast-MFC-AGG-ID: -x2ODoBEM06JgKs9fHfPQg_1767089775
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d3c4468d8so24994425e9.2
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089775; x=1767694575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awHY3MD6YI7UgDTD6QKfkNuaN+VrZkEZlRiSgXqWnPs=;
        b=saS596gMvEnsxrTkrkbplHxbOODaikOgk7ZB2ubdiL7sFGv2VXxg00bxRyqXh4U+gH
         mwQNYIcveZGYnOlpKFYlMcy+0d0E7VLkO6fEIQww7n/nef/1V8OHC0MLfMHMCOllXS6y
         xE541BoON7me0epZ9f/Jn0e7SbFRR3BBVzMzByFrICfI3OiD43fS1Z7kWsC8Weq36Iex
         WAWgj89YNVuYPpFqxXYLRp7T9XbvDamv/SykCA6a6IZ4wjIOxiTxkTKMfmh8dc9Bu8/5
         nHlKNNSkv5JkiPSxbZV+OHsM/Gb+vvassVsvcJDLN1foNR80qDSix5vCEYMIQrGA+8+Y
         fvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZWEA+Wc8xsIpcMm/+tCnySKStyH9ifFCSBp4U3QPdlJ1TkIDqVXjzGAvm7LTxoTrlVaeMmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+Rtp8aZxDSnvYeemmqO7ixtRUsUJTiH1IWzqay2qu7zJt/wp0
	3eMJh300zhiC4J+8RIB/SQpdHXGIWmjmVXcat9/XmN3nNjxV/SzheEsVG21O3UobqTIJKffKGEc
	m+GxwSWRV1sm9GXBJRL0jvss5c4E1I1sNTycWMFJoYncH2BxHIj2sdzjB
X-Gm-Gg: AY/fxX47zCYFCSDubqkLUvq/hAnwBxKq85xg4yM/g3X3NcUzP0S3oqNWjTWhOaWouU5
	NnyC7evBfr20JdAxHQp3/TlXU+v1yojrBBM4iVQ3pNm19DRfoKrWccCU0WUVT058UKt19m7dAhB
	PJDJqitTUDVXqsqSDZ/3k9IucrRqt7gDiAyWXqUSub4L5/wX6rzf0o+Mv2ch6cDXMGlD1KPkHAQ
	W3M3VMnUaLmbp6SxBghFDDB7dQDCZdt2UdL9y7/e0z/x/A5r3mwTT5zkSbmxZkZuXwhhSt2+qco
	LgGVVZMi+4a/Cg53JqjEz0X6U8DE47rB9R5DBBSewbd/u9H8uCS2TTRYRp7hqT9FV2+F31rY6eO
	lTDfX7s9+kqQYMIeD9n38ZUOHOn7e7g8Ggg==
X-Received: by 2002:a05:600c:500d:b0:47d:576d:8140 with SMTP id 5b1f17b1804b1-47d5b261006mr54433935e9.24.1767089774868;
        Tue, 30 Dec 2025 02:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhdLHPqUgLnPyVKN6hwhRQFuXWAPZjO+w56XwRJ3KNAI+UkHXfY0sXelHGWgys0dAYrWVbAg==
X-Received: by 2002:a05:600c:500d:b0:47d:576d:8140 with SMTP id 5b1f17b1804b1-47d5b261006mr54433635e9.24.1767089774436;
        Tue, 30 Dec 2025 02:16:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272eaf8sm630015255e9.5.2025.12.30.02.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:14 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:11 -0500
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
Subject: [PATCH RFC 08/13] vsock/virtio: use virtqueue_add_inbuf_cache_clean
 for events
Message-ID: <34e5e1af186fc92ab4ea6cf6c9f5550a40c9567d.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: LEm30GT6srJfM2TspkND6Ce3omVwxzeYSi8tzTr9geo_1767089775
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The event_list array contains 8 small (4-byte) events that share
cachelines with each other. When CONFIG_DMA_API_DEBUG is enabled,
this can trigger warnings about overlapping DMA mappings within
the same cacheline.

The previous patch isolated event_list in its own cache lines
so the warnings are spurious.

Use virtqueue_add_inbuf_cache_clean() to indicate that the CPU does not
write into these fields, suppressing the warnings.

Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 76099f7dc040..f1589db5d190 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -393,7 +393,7 @@ static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
 
 	sg_init_one(&sg, event, sizeof(*event));
 
-	return virtqueue_add_inbuf(vq, &sg, 1, event, GFP_KERNEL);
+	return virtqueue_add_inbuf_cache_clean(vq, &sg, 1, event, GFP_KERNEL);
 }
 
 /* event_lock must be held */
-- 
MST

