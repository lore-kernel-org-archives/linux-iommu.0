Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0CA2EC54C
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089788; cv=none; b=JIKhJ0jXkDws+kM6OLxsKUlHNm1pkwdjim9URiqD5CXFpnSruXIal0k013rv/jW67W/UvgLH2z3yCLNyml9UC2WJ0ljBXeGJYHNyb8YUo5MxQHEIB/b6kINTGqSEjwDgu1SaUNpf5lcEhCohp2LbsI3cRN+gJ8h2RiiKKEA+owA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089788; c=relaxed/simple;
	bh=GajfymOgkcPkdkaB0RAuWogZvPX10QSebBxhGC7QBSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oxtzwa/953Now6yjBomKloG04//BemXA5v1wpPvNXrX8x3oISWbywF9BmJGmlIqUQbXXiSqdxb+OaXB+Mz5JhIVw1QhwVXyJiijeeam4U1Oh+NqHvYFETI+2RhD9N6vZKjyWt6w71MdE4svhlMC9OCnD/6p36dXAVg3sjM9EoBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GtakrPnD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtakrPnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGgwtCzFbkcOM+PDCBbTUD1kyCibNYOBRdnG12nNQ/w=;
	b=GtakrPnD9VVF77RKXUv5av0bgB58CRcxJ4hjMSeD50drQAJiksqcggGsoK6cFAbsgIViOP
	Q/CTu/yIkyAhh02nGNBBjpWNWfO2rdUo3/SWvp/u2vCK+q33Xr3iQHBmm8EnmSnaSLnTgr
	KC8qXZDYrG7Lf++5d3BDEXv5bl9w9SU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-fVx4BnbtN16Q-7lK2y6jMQ-1; Tue, 30 Dec 2025 05:16:23 -0500
X-MC-Unique: fVx4BnbtN16Q-7lK2y6jMQ-1
X-Mimecast-MFC-AGG-ID: fVx4BnbtN16Q-7lK2y6jMQ_1767089782
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4325b81081aso5255721f8f.3
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089782; x=1767694582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGgwtCzFbkcOM+PDCBbTUD1kyCibNYOBRdnG12nNQ/w=;
        b=ONb1BjBCNs9p7MTNNcvD8Xj5B40mGnDcsMMhcEgvx+p4wBkjBHjsJCRROi1HT6m2D1
         RCuPrImlY6JPvzGnV9jN4cT/8YLnfx3fPjdNhdC+MK8NqYBcl5v+0veIOPKgzpKVei1w
         cruJM8vC7/RLkKa1O0ssd5xxp8RtBcw31fDBke2D4hR0f+FWl8GAjj5OZzeT1L26g72r
         SbHvZb+QYrbe6uHm5OlOUVVb++wIArI1niM16hIMQeqTXwLU4oiAHooGe09QiqXb+7DP
         5s4bZPj4+lgALJEI3lOkCmqPgqFolVoD+EyNGyErGV9SzyT7+SuDbTm4yRaHXenySmhM
         HEXw==
X-Forwarded-Encrypted: i=1; AJvYcCWWMyjN3pd6JCFoIzd8D5sEGFtcTZ/P+42M4Ao93aoQgyCO3V2j1lt/RfA58ECOHm4sGES0qg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4+hdPnPVcyH2A7/QpXwJE33RUWgbJCNvrGSJl1YJnMl26iWlT
	IZKaAwc/aMpJwfzoKV0zpq3SbwtXwXUXxGWvJhod/dFxbFo/0mGiLYWUpKhZKKMgjgwrgXVP/LE
	U8DCX44nVAjCcYk69GXeyeSd+gfBvQdRZ+i3lal0i3Q8buHjjSIkuCPkn
X-Gm-Gg: AY/fxX74nC9wp3ZjBP3MjV12WMyViHuKHuFKFE5grL1sSK2WLk+bwq+yX5bNRkqtEot
	Uq3G2WXXCzfbtbYx8g+7AOpxToZCHaGzwilDrvL8FWWcX9HF+dyfFFmzTkApHE9Ex907A0nnG94
	gE4bZua/LOUp6Pbou7lV2Nf96y4cGG74QLiUV9RqOOAplsgmc5vojr/YXQogK23A0vLs94zPIDW
	xTDDoIkrjt4qjdoh4LGEXbjFt4K7WIdSC3PKy60gNt9/CTyenvYUK1LN45b+6h5i0oKsgDZH9eL
	bOXNa/tN+nlw8Xttbhl0v702KpQPKtI5Pu5Y2PlY18i3CfgDstl6tocFz29le6tZOuVsNWoJody
	9ggeqeMdtW1d5hw9BNadMVyzMSwD7rZXtcQ==
X-Received: by 2002:a05:6000:40db:b0:42c:b8fd:21b3 with SMTP id ffacd0b85a97d-4324e70b2c0mr42681802f8f.57.1767089782065;
        Tue, 30 Dec 2025 02:16:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4XayC4ymFC/bWs00E9fRypXNJ9u10o1pYrVldfljsEtp9WZrRKo/7Fbn9vwkm8J3pD7bCzw==
X-Received: by 2002:a05:6000:40db:b0:42c:b8fd:21b3 with SMTP id ffacd0b85a97d-4324e70b2c0mr42681761f8f.57.1767089781587;
        Tue, 30 Dec 2025 02:16:21 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432613f7e6esm57256214f8f.21.2025.12.30.02.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:16:21 -0800 (PST)
Date: Tue, 30 Dec 2025 05:16:18 -0500
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
Subject: [PATCH RFC 10/13] virtio_scsi: fix DMA cacheline issues for events
Message-ID: <c238ea28521dc0433350f848361b46e7d451b96c.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: UuIZ9VFwfhwwmYNeqzjH7bJZFENvxrm3uU46JX8lEzM_1767089782
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Current struct virtio_scsi_event_node layout has two problems:

The event (DMA_FROM_DEVICE) and work (CPU-written via
INIT_WORK/queue_work) fields share a cacheline.
On non-cache-coherent platforms, CPU writes to work can
corrupt device-written event data.

If DMA_MIN_ALIGN is large enough, the 8 events in event_list share
cachelines, triggering CONFIG_DMA_API_DEBUG warnings.

Fix the corruption by moving event buffers to a separate array and
aligning using __dma_from_device_aligned_begin/end.

Suppress the (now spurious) DMA debug warnings using
virtqueue_add_inbuf_cache_clean().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/scsi/virtio_scsi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 96a69edddbe5..b0ce3884e22a 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -29,6 +29,7 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_devinfo.h>
 #include <linux/seqlock.h>
+#include <linux/dma-mapping.h>
 
 #include "sd.h"
 
@@ -61,7 +62,7 @@ struct virtio_scsi_cmd {
 
 struct virtio_scsi_event_node {
 	struct virtio_scsi *vscsi;
-	struct virtio_scsi_event event;
+	struct virtio_scsi_event *event;
 	struct work_struct work;
 };
 
@@ -89,6 +90,12 @@ struct virtio_scsi {
 
 	struct virtio_scsi_vq ctrl_vq;
 	struct virtio_scsi_vq event_vq;
+
+	/* DMA buffers for events - aligned, kept separate from CPU-written fields */
+	__dma_from_device_aligned_begin
+	struct virtio_scsi_event events[VIRTIO_SCSI_EVENT_LEN];
+	__dma_from_device_aligned_end
+
 	struct virtio_scsi_vq req_vqs[];
 };
 
@@ -237,12 +244,12 @@ static int virtscsi_kick_event(struct virtio_scsi *vscsi,
 	unsigned long flags;
 
 	INIT_WORK(&event_node->work, virtscsi_handle_event);
-	sg_init_one(&sg, &event_node->event, sizeof(struct virtio_scsi_event));
+	sg_init_one(&sg, event_node->event, sizeof(struct virtio_scsi_event));
 
 	spin_lock_irqsave(&vscsi->event_vq.vq_lock, flags);
 
-	err = virtqueue_add_inbuf(vscsi->event_vq.vq, &sg, 1, event_node,
-				  GFP_ATOMIC);
+	err = virtqueue_add_inbuf_cache_clean(vscsi->event_vq.vq, &sg, 1, event_node,
+					      GFP_ATOMIC);
 	if (!err)
 		virtqueue_kick(vscsi->event_vq.vq);
 
@@ -257,6 +264,7 @@ static int virtscsi_kick_event_all(struct virtio_scsi *vscsi)
 
 	for (i = 0; i < VIRTIO_SCSI_EVENT_LEN; i++) {
 		vscsi->event_list[i].vscsi = vscsi;
+		vscsi->event_list[i].event = &vscsi->events[i];
 		virtscsi_kick_event(vscsi, &vscsi->event_list[i]);
 	}
 
@@ -380,7 +388,7 @@ static void virtscsi_handle_event(struct work_struct *work)
 	struct virtio_scsi_event_node *event_node =
 		container_of(work, struct virtio_scsi_event_node, work);
 	struct virtio_scsi *vscsi = event_node->vscsi;
-	struct virtio_scsi_event *event = &event_node->event;
+	struct virtio_scsi_event *event = event_node->event;
 
 	if (event->event &
 	    cpu_to_virtio32(vscsi->vdev, VIRTIO_SCSI_T_EVENTS_MISSED)) {
-- 
MST

