Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD408329C69
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601420; cv=none; b=oTFcDg9+GRWwNP4/1yZv+Fm3bRmBrvitOCYfJ1lHzh4cnUP5dtTno+7fwkNcF324026rYbvEaeeFRapKOaoCdFSyAzVP0+3OIP4xrIyaKqDC+aTdnhv8gAYEvSEKBI6NRN0wqjo4UpycQGRLsXkf2Z/veyRJ84iM48Q+efvEu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601420; c=relaxed/simple;
	bh=S9cU9rMSKLAHqC3C9VUi030/VnGNztyhDP4UPj+0Vaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=D6G4LZ8IhPyTUzqjW9WZgiBetJwn9aVQfak2LACOxg5CdJJh5Ao36b+KNy5xzXU/MPYU4WU6NCkKy8De3QhfJqCz+SCVHm6JNaUJffTOga0kkHgUkujoJ528ZHJNBrSGK+kXoZqQUXD6Rn5TCzNBP1JC+688WwYtpEaQdFWip0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHMu/bTI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHMu/bTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TvLvTQPEJKAtkqGovGo2GHeF0+EOLKvEuwFpv+PiquM=;
	b=EHMu/bTID2Pkdo8VYM7TcofOJpTzj5lUk+sMHN10g8txKZJs1CMvhGbw1AN4kWdsL0Z4CE
	xC6eTh0UAZi74kMJopaoU/gMxdhSH44OOcyWIPpI6KTEkuZGqrAepHBPVmYjo6neohyHHT
	UQm0PfYG2F7IAtYpmUCD667zyFUqdSs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-EbI-H6xnP_6D_pKeRcAjsg-1; Mon, 05 Jan 2026 03:23:34 -0500
X-MC-Unique: EbI-H6xnP_6D_pKeRcAjsg-1
X-Mimecast-MFC-AGG-ID: EbI-H6xnP_6D_pKeRcAjsg_1767601414
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fcfe4494so12569166f8f.2
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:23:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601413; x=1768206213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvLvTQPEJKAtkqGovGo2GHeF0+EOLKvEuwFpv+PiquM=;
        b=hRYQ/qLIBiYp9Z2FSMD95znkuXhLYhdMs1chALEwkYRkzW4fejAgpAiVkbVhqhGd6F
         ImBDwGnq/MkOU9RTj8/huVsN0QHd58LHOl8SJO1A7LSmoDTZKXtKl27FiYjp392WDVKE
         zTeAI19hUOXl9q0TD7nlDTgfX6hVQK0xz0lHxWnZd9E0edDViYnGaUDr+AEesVdjRiee
         GzxkIdM56p5HFZM56JemUtCpAI860OXNXjv/7DBTNUR0ubAGkPxVRI4e7SQXv/YkB05v
         /eyjpsjXlLio7afdvk+tJVwAOMoQOZXZflK753xtIRXx47pxOUpl2QGWSZzTW7nToepu
         NZhg==
X-Forwarded-Encrypted: i=1; AJvYcCUaoMWhjqbQ8NzUvo5zxrNfyN3m/l7hfaLA67F+HvJ0FTzPXGs+ZFkeA8/z58mSniMRjgPXnA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn8kuRUER3zOXIW5P5PP6Qec6bDXXGzKTWA5vezVtWpVnPaneM
	rl0OG7J9y5DxyBUNGjPbDsqUyIDtvF5QgF93m7hZuq8YbLdY/iVmGFPYjvmCSLqwYmFbK1quf6Z
	wr0bsbURbcdKI6y1wzSZoSOEnSJdw7vqbsifI5DAKT5fwKpvr7Xzj7PpP
X-Gm-Gg: AY/fxX7LE2V4S6C0rrlPG+Bx001ofoNyk4eCU48RVIXY57PngTMMGVpoRCTFqHp9VGo
	YNC+0zNAOijVz/f+zW0OSuLEwdqKi+X9VBpdlLJFSBRtDEmeBPZdFZHidCkF7TrhYO2z3NWI8f+
	QZ00WHgQgUZA/b71jRTn5VywXyLbzA9IuFqOnEzS/wGtxQ0lBkmUDF4FR2UpCroJWDNC/HP/6mQ
	8rMTnoI20DW7eaychfhJPaRlppunmUsGRiBvza/7YnzG4jqn8V/bMTM5xHxTpPKPeHT8wpkerN5
	0/trAUP8LQmTflNMjw5gEB5/j8R1VIZAx5Zx3qL0nrOW2UMwtYEutsIDbnE2X0CfO5NZ2jA8GaP
	y1+m5sT6XTgtpXy/RRitV78NuEXLd4y3lvQ==
X-Received: by 2002:adf:eb04:0:b0:432:84ef:841f with SMTP id ffacd0b85a97d-43284ef8d0cmr31362896f8f.38.1767601413469;
        Mon, 05 Jan 2026 00:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx7eWbROO38mdjmsXsZ8eTRhzoo1KnfbPFeP9XiXzVU5+PKMGQRYrz1a7izR0YG2kvu7gW1Q==
X-Received: by 2002:adf:eb04:0:b0:432:84ef:841f with SMTP id ffacd0b85a97d-43284ef8d0cmr31362856f8f.38.1767601412963;
        Mon, 05 Jan 2026 00:23:32 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa2beasm98160481f8f.33.2026.01.05.00.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:32 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:29 -0500
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
Subject: [PATCH v2 10/15] virtio_scsi: fix DMA cacheline issues for events
Message-ID: <8801aeef7576a155299f19b6887682dd3a272aba.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: hJzR8iTJ212pnOiwNy_Mw_uCuwNi8dmHVfZR1fFhceg_1767601414
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Current struct virtio_scsi_event_node layout has two problems:

The event (DMA_FROM_DEVICE) and work (CPU-written via
INIT_WORK/queue_work) fields share a cacheline.
On non-cache-coherent platforms, CPU writes to work can
corrupt device-written event data.

If ARCH_DMA_MINALIGN is large enough, the 8 events in event_list share
cachelines, triggering CONFIG_DMA_API_DEBUG warnings.

Fix the corruption by moving event buffers to a separate array and
aligning using __dma_from_device_group_begin()/end().

Suppress the (now spurious) DMA debug warnings using
virtqueue_add_inbuf_cache_clean().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/scsi/virtio_scsi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 96a69edddbe5..6ff53fc8adb0 100644
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
 
@@ -89,6 +90,11 @@ struct virtio_scsi {
 
 	struct virtio_scsi_vq ctrl_vq;
 	struct virtio_scsi_vq event_vq;
+
+	__dma_from_device_group_begin();
+	struct virtio_scsi_event events[VIRTIO_SCSI_EVENT_LEN];
+	__dma_from_device_group_end();
+
 	struct virtio_scsi_vq req_vqs[];
 };
 
@@ -237,12 +243,12 @@ static int virtscsi_kick_event(struct virtio_scsi *vscsi,
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
 
@@ -257,6 +263,7 @@ static int virtscsi_kick_event_all(struct virtio_scsi *vscsi)
 
 	for (i = 0; i < VIRTIO_SCSI_EVENT_LEN; i++) {
 		vscsi->event_list[i].vscsi = vscsi;
+		vscsi->event_list[i].event = &vscsi->events[i];
 		virtscsi_kick_event(vscsi, &vscsi->event_list[i]);
 	}
 
@@ -380,7 +387,7 @@ static void virtscsi_handle_event(struct work_struct *work)
 	struct virtio_scsi_event_node *event_node =
 		container_of(work, struct virtio_scsi_event_node, work);
 	struct virtio_scsi *vscsi = event_node->vscsi;
-	struct virtio_scsi_event *event = &event_node->event;
+	struct virtio_scsi_event *event = event_node->event;
 
 	if (event->event &
 	    cpu_to_virtio32(vscsi->vdev, VIRTIO_SCSI_T_EVENTS_MISSED)) {
-- 
MST

