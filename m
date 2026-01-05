Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF0A32AAC2
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601432; cv=none; b=oP2qVmKD3/tHjXKYtrMinZrHYsrJB555InXhsRDHM7MwWnGQpixMJQJd/f7DQG0Q1/Re3ERv48xMF9BkXURKzNi0b5XKY92VRI6S1TaYlUfI+cnfbuShpr/JSNk95w+CSZHZHAmXJ6jTiaOrU0iNhs9xTJ71iT+yqs0RsnGOA9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601432; c=relaxed/simple;
	bh=SZ7yoG8PLS6oSz/uClprybkzflRSWBjZBPmgt2pUyWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mwG73qOCX0qSHnssNckyFg8gFHKVo61Z+S7TIR+jrD2SwLpfPffydxD5weZMiOZtiyDu1QqF35+rm0hYAFQm7NaIwsTpCT//vdAO0+G3dp/E1YD+GYg4ciiVTYJ1n3g7ecFeSWd4jtneT6gJTfukaw/7ksuZ3PV/wqgQFXx897Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Io/btUN1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Io/btUN1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UCCLeq+lwQP+R3LKzuvNuhkNhAmceABICngBBmDYRE8=;
	b=Io/btUN14Pz93JGjiSMLn8JU4k3jep6SAudvCUMDNbgMvcAm2YiJl2peavOlnsbE3tNs9W
	RS3bNAH4RsEwQR5x43TvQxfxwUrHlRmlJ0bniPMQ/RN82e8xmwbFtqQH9OiNWkEoxz9iEz
	H9Bb+vvTkYL05LQ8Dy1BccJ7DxXDg78=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-IuaT7QlFMey2bQiW8thUrg-1; Mon, 05 Jan 2026 03:23:47 -0500
X-MC-Unique: IuaT7QlFMey2bQiW8thUrg-1
X-Mimecast-MFC-AGG-ID: IuaT7QlFMey2bQiW8thUrg_1767601426
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477563a0c75so51126685e9.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601426; x=1768206226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCCLeq+lwQP+R3LKzuvNuhkNhAmceABICngBBmDYRE8=;
        b=rHC44AUn6Gxt+kFxMwrH9DprpQiPPbhYRoGrCuUb2Q4AXQ91aTaOyUoYX4WTAVKZCE
         htf0CLOX58SA8VDisXs53upc+O2Q/MQrL6m7Jyd88ryOOCl1A1kqMt/5x2ZAGAKGxf7f
         66DeV9CvEduD5GL4byacyR3GXM4lYXLKIq41Cz34NS7Y/k+fiWSgi79BZT5pU5BlUiZW
         4U5MCRyT+h9Wnsi9Ib90TM9BQj6xImbgTMSIU2hE91wf5sdrm8OrYiTzaL/VQ0iTgwD+
         yZ+XLPjQ3MoTCS8z75j3ZllY2xEqj7kTV9tQP1EOvdDmfxEQoi3ApgmaiW1DvwimRfbA
         b+vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEH+NoKBw7AdvPdkHOc1IhahS75DTJ7/d/oGSWxGNE8N8OZjfWUdgt3aHfAklzhb/+1uxMSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkmxdtTeMY4+CctOT0b7Vf0EA49/vdjFHSYYeq2o550YQCMTGX
	Sj6cH4A569LkVk2QOPDJJ5YP+b8i0yf/XdU7sHcAKc6VCPKgiSu+/Www9ko6qQou7kw2mHUe/bS
	cAx6h36m6hH2/+U7238cva7pSDiOQ/Iw2gBCxsUmiiKMMYATsnejxiGfj
X-Gm-Gg: AY/fxX6BCRjBhy3VcyjaP2EjpiD0UCkuwM0WqgEPFErvF23JVfTeja/m+v120gvug1v
	iu7eOr1m+T5HyHzbbDeKDTUNVhwAYGd4y0Ax8VviVknyQYuURXJr3J8+0xdB3wapOrg5OUQEDsO
	6LffHPItBUhBnQNidbZNLgodHgUGdIsDQ01oCPuraLijqMuPlyM0whsaVrkCkTO1Lewe2H4Hrqn
	a+VFU/FhNOQzrL7ZE2zbRyj4PcBp+VpzsgmE9In+c2fHYVXEZ7jyqi9Wa1G21b9H7X5JcyMJufV
	HyOEaVbIAv55epn6U57Zzk8HgQGlFgALdszKTxlDmer71zHHCYijr9q7vAimX/WMUkQO0BRvlUg
	OrWS52OC0sMQq8J6y4n2pjBsjER02ZK+zUw==
X-Received: by 2002:a05:600c:6287:b0:47d:5dae:73b1 with SMTP id 5b1f17b1804b1-47d5dae7628mr228845955e9.23.1767601425890;
        Mon, 05 Jan 2026 00:23:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF11RG7JP48/6nhX1x0r6bivcNnxiVBPQ+hub/0+kajaGoE0Knx7g5Xjp0dkxgQjwSwKtknIQ==
X-Received: by 2002:a05:600c:6287:b0:47d:5dae:73b1 with SMTP id 5b1f17b1804b1-47d5dae7628mr228845285e9.23.1767601425245;
        Mon, 05 Jan 2026 00:23:45 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm100331450f8f.20.2026.01.05.00.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:44 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:41 -0500
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
Subject: [PATCH v2 13/15] vsock/virtio: reorder fields to reduce padding
Message-ID: <fdc1da263186274b37cdf7660c0d1e8793f8fe40.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 8ywJR7E-mAK7w3xfv5AxJwEwqCmPJ_xOGpVIWcM3ck8_1767601426
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reorder struct virtio_vsock fields to place the DMA buffer (event_list)
last. This eliminates the padding from aligning the struct size on
ARCH_DMA_MINALIGN.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index ef983c36cb66..964d25e11858 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -60,9 +60,7 @@ struct virtio_vsock {
 	 */
 	struct mutex event_lock;
 	bool event_run;
-	__dma_from_device_group_begin();
-	struct virtio_vsock_event event_list[8];
-	__dma_from_device_group_end();
+
 	u32 guest_cid;
 	bool seqpacket_allow;
 
@@ -76,6 +74,10 @@ struct virtio_vsock {
 	 */
 	struct scatterlist *out_sgs[MAX_SKB_FRAGS + 1];
 	struct scatterlist out_bufs[MAX_SKB_FRAGS + 1];
+
+	__dma_from_device_group_begin();
+	struct virtio_vsock_event event_list[8];
+	__dma_from_device_group_end();
 };
 
 static u32 virtio_transport_get_local_cid(void)
-- 
MST

