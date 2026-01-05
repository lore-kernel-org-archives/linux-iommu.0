Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB9325729
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601410; cv=none; b=BDPqzdoVu1fsRuGXGdJjD4mbY84XWaydA9lAILo3kBxwjiCuioldftlxFrnmmcBcphpwZTEDS2keYsES4ghudl6OLQRcliLIriUpfHIueeSgBho2gT0QIQHL3r4FJez8jN1C4dNn1Ziaa4swHnVRAgKNu1Ogs6/fundVDJuXjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601410; c=relaxed/simple;
	bh=m98JsLLlZnpLuynLg3Syt9uCZ7QvI0/Lv10M2IDOLnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fPNPKCuVYT/RSeVoLW3oRO4v5ohYi8YYQh2mATAnxSnRZTyYuiiwqzoiOY0JzISYhWL2mGic8KM8b4UGIJQwS6Kdz8cLXShNgnEyTDSEKxZqtBO18HCGTrLPijzuh89gIH/7jYZf+PdVp58kbLl05N+Yq8cPqzTHsfsQC57mFho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYx6RUs6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYx6RUs6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I9g6na9OJuiciu3rQw6J7JsbFxwpCGTH1jubl50jggg=;
	b=cYx6RUs6goTCeNY6aVjYx4YQS+ptNWYGgTbCMRXb5PRiY2lkA1apxrYhN0AxiumV7LBBBx
	FmJcuAkjj68Rrek1YWBGWyn+h/uK9jApFFWVtLwi6OLNalnuM3UW6EYKXmtWaCokZXoNDf
	Di1SYtL7U0HIk1/BBsvLv38zbHZtl+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-g02tZd4qN5CibOLeZ14lDg-1; Mon, 05 Jan 2026 03:23:26 -0500
X-MC-Unique: g02tZd4qN5CibOLeZ14lDg-1
X-Mimecast-MFC-AGG-ID: g02tZd4qN5CibOLeZ14lDg_1767601406
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso184533905e9.2
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601406; x=1768206206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9g6na9OJuiciu3rQw6J7JsbFxwpCGTH1jubl50jggg=;
        b=m4jRj7QSiqta3RcVXNuNdi8Nt6B9BiBacufaCUeAB7nIfnzrkRRfJDccQLngFcq+1Z
         w803Nez7pPNbaDYP3Pjh0pkQwgdN9KGkXY17MtFjCVZENV9izkS9RM/p5CGETXu588GT
         WVzTj7NTXzTqDosggYrs8Qx2vM2rN+rpM+DG8W82EebVfGIk84PIvYIcdQ5qDz3RBqbo
         LetnEUCTteISeTTQgLv700/ngwG8vcL+cmdUaB7Zg2+sVBgEW72Ywqzr42NMUZnt3iNm
         FK6/OxYaljUOnRvETAX4PbaGjPxwMh0AzldfM3g8xagrc3LqYq9TVOfPicJnvsBf87lW
         Gkcw==
X-Forwarded-Encrypted: i=1; AJvYcCXKHr0F31xnergOZ+8Oc6WDN+iTJdqaos1l3kWhpJln7SG4BmzsGxn4A2IkkWAcSnFnDGTeGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWhxarGWDZBOrOvDsdDH5erBBr3CeNWThdLpGbzjycjeyTQmPE
	Lp76H5DuGAStMSfixE9GmIwD/Zy83xhKv2LajEG7PmTnDHsH0FxCC7RZR2q448dN32h9Am+f3c/
	Yc9ESDqVLkApQT+C+Uzn/pyswA+U/VJIocg+hk4WE4nWJticNX9UYHx12
X-Gm-Gg: AY/fxX4Te/9yAGI+JkQpCDQ57p8/qo6N4EjCtIrurENnIEFklgu+O8Y2+eYLJZO0KFH
	HIjxvUxuCR8HDTxtEpCFMgquXO4dYhpKyGUOH2Y96Ic4ElqESQ+Y+8b9TKMAgz/L5UeOugn5G1w
	cZ4tHSQjDAMqAs/xR7DPR7cNrG8BSdPOmI9b4fpwnR966adZRc8mypKcS+r35rCAWiX9PHOAYLe
	SPuJYpmVGhkRhPrCRGJ3H+i/rpOTKtgIbDSg75YC8AjlWkp9LLSQEFerPm1HiYJnHNGGJxUCVX3
	HHspSgLgZFLLXcLb5J09KGZW8eRMK1rZeBn4bwU6hFrHL+CcjXR6+VnaDFf2kRoYxiLqHOfdoPh
	/eWVoYd74OmmxA6U0vcum4X2xRNuFKeAJNA==
X-Received: by 2002:a05:600c:4446:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47d1956f896mr633168495e9.16.1767601405657;
        Mon, 05 Jan 2026 00:23:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv7DIcbBq1VkvqQ23EJm44n2GxyGgRTRuTvRGBj8avn63Zc8/z+R9wImAFB24DC8Gpann5cw==
X-Received: by 2002:a05:600c:4446:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47d1956f896mr633168065e9.16.1767601405201;
        Mon, 05 Jan 2026 00:23:25 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6c08f56dsm51171265e9.9.2026.01.05.00.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:24 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:21 -0500
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
Subject: [PATCH v2 08/15] vsock/virtio: use virtqueue_add_inbuf_cache_clean
 for events
Message-ID: <4b5bf63a7ebb782d87f643466b3669df567c9fe1.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 4C23vpJQy_yBinnxILcyQbAcvXNP8y2dNGp8UfDP7Cw_1767601406
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
index bb94baadfd8b..ef983c36cb66 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -392,7 +392,7 @@ static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
 
 	sg_init_one(&sg, event, sizeof(*event));
 
-	return virtqueue_add_inbuf(vq, &sg, 1, event, GFP_KERNEL);
+	return virtqueue_add_inbuf_cache_clean(vq, &sg, 1, event, GFP_KERNEL);
 }
 
 /* event_lock must be held */
-- 
MST

