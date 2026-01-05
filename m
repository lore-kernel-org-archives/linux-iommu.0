Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89AE328B6F
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601415; cv=none; b=nx4omRdVNkS7o/mZg5RYbDA/vtW4oXCbkZlBfNydlxokN2Gc+wljiAvPwVheg2GFuk1fZ9h3Pf64Q3BFzBp0TBigQ/0kxWBbO8GemUAc9iWVZRlVpAnyNtHoMDTTCigFbwzZIyBFuKeWik5wYXuMzsa6eAQwTY8jkW7XxP5MPPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601415; c=relaxed/simple;
	bh=yZFREYe+kB50ig8I4QfoDGYH7fn5mVvqsTw8oxG1/Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EzL+FEeIzsE44lBzeXD0m7AyPsry72dnxhR2lVhqiuZPIQ9UXID97fxwUd4S9XX+rRVeQowI8GXgeSHbiVbPMUryPLhZUMnn6rjN3kBaktPkCpJBPc7EMM3IrfXBGsR6fZiLaODG1hlt3MmaVaJF0c4goivXCNzDAUJau7ssX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZYTig9O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZYTig9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WFAlf3bglsAJtkYzmv+ft5xqaztKYGlID1/+YOBMr0o=;
	b=NZYTig9OxvGi33F4alaWAZlkgFHbRRcFArIH3y7Q9dfkGB/LHrLqml34x1LL0cGWiYvYM+
	fAsyB2BkedFdFLAa4HE3UL/dr8TC37QshxQNcCNFpL3qDJ8hTqHXHFPOfFQhuIGruLWad8
	9qEcT25D7DdQTok8IduKVbMQqAvC3Gw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-tzCuM7cZOAmU1EHBrmgoZg-1; Mon, 05 Jan 2026 03:23:30 -0500
X-MC-Unique: tzCuM7cZOAmU1EHBrmgoZg-1
X-Mimecast-MFC-AGG-ID: tzCuM7cZOAmU1EHBrmgoZg_1767601410
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47918084ac1so120298755e9.2
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601409; x=1768206209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFAlf3bglsAJtkYzmv+ft5xqaztKYGlID1/+YOBMr0o=;
        b=SnfudYKG4FN10n+p13cN3xyXT/74hXARUn0/grYy96bobG4RbTIkOiXnvswph/VHqJ
         qwgPUiJE9u9DIDO0rUsMv1liIe5PHFkuHmMZ5AMIhJuSuoZE2ynrG3O7ZwYecUpcuewD
         ISomsaSb4v7HzuYEIa7O3AS3YuSn68rvqgk2Esb8ciObwH9oxO86KtzHAU6hYq75EsXi
         nmJQdXCnGrYO8tZKBlVbIvQeb0mdf55VrEfIoXFX/xQMoOlmN9KeLwPDJ1KIDwMRVMVP
         PP6B/mikBNm1MRsqlii3++CLpKsThEkSfZpdns9slALIxqaavgNfH3724HmUCCyBS0P4
         xCxw==
X-Forwarded-Encrypted: i=1; AJvYcCWsLEdw9xnhEse19TMdAfjrX9d6kOus9Si6CjQFdQtf/8IgBGpwRG309AKjN1cJQRYkKutDRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcGwwsGmkqgeglV1Fgux8Q+OxJJG4B0gBqL6UtnqK4QaN9cCYV
	/rcrXSLsbUKHnukZezXCb96qLtSymMc5vk3Q+NyN9h3q4YYiNE/cpIfSIPocfhFqgn08SGMlkNC
	NkUVXxZpZUEB0aHZfvvhagURUqlvILCFCOQFaBxgVFFAbsIeLQhQmNmuj
X-Gm-Gg: AY/fxX7HTODifd/yvk2dBQ6nX/b66tnpy/jseg++Ceb8iSyAQoYw5c0K4ufwTU3/fkF
	JNoPnbLK3ZgpP0t2Bf374elSwUEtQRcaIj7QTin2iVEFFvVMwrVmw5tbpmDWkxPaXcx5Sv88fGN
	vgJ4f29Ac2nu3xyyq8QkmD2oUg4KgdVuQDwHT+clXe/4EtrHvEqv5LWDvTvbQrKLOrEAH7pG9In
	YvqrXEE/4734k18ijZBTp1mdWfziNBRvpcG08YgmoLJeWIr5GtYUndEcS5RrH/sjMGT8JPlaLYJ
	L1LgBLAy0ysyn/ESTyjWZNv0GPxCO6stYu6TG8/4L/h2tZqJw2UNJeZsjHFkJJm/JAZ/2JDChwx
	dXn+jPaBIYHjvetCIxMjzxttaS8/tYiscow==
X-Received: by 2002:a05:600c:4fd4:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-47d1958a43fmr573308475e9.19.1767601409536;
        Mon, 05 Jan 2026 00:23:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwNUq77RyeyS0obHX/fGtVMqKrfm8Lk7lx8bL3zrRbRdvbJ0vPOnUhK5sFwtMU1HFVUtXhCA==
X-Received: by 2002:a05:600c:4fd4:b0:46e:4a13:e6c6 with SMTP id 5b1f17b1804b1-47d1958a43fmr573308005e9.19.1767601409047;
        Mon, 05 Jan 2026 00:23:29 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d145162sm142697615e9.4.2026.01.05.00.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:28 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:25 -0500
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
Subject: [PATCH v2 09/15] virtio_input: fix DMA alignment for evts
Message-ID: <cd328233198a76618809bb5cd9a6ddcaa603a8a1.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: qQS1zPeEV73My-aVVluFbr5UznXEr3-h5ge7ejJZY6s_1767601410
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On non-cache-coherent platforms, when a structure contains a buffer
used for DMA alongside fields that the CPU writes to, cacheline sharing
can cause data corruption.

The evts array is used for DMA_FROM_DEVICE operations via
virtqueue_add_inbuf(). The adjacent lock and ready fields are written
by the CPU during normal operation. If these share cachelines with evts,
CPU writes can corrupt DMA data.

Add __dma_from_device_group_begin()/end() annotations to ensure evts is
isolated in its own cachelines.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index d0728285b6ce..9f13de1f1d77 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -4,6 +4,7 @@
 #include <linux/virtio_config.h>
 #include <linux/input.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>
 
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
@@ -16,7 +17,9 @@ struct virtio_input {
 	char                       serial[64];
 	char                       phys[64];
 	struct virtqueue           *evt, *sts;
+	__dma_from_device_group_begin();
 	struct virtio_input_event  evts[64];
+	__dma_from_device_group_end();
 	spinlock_t                 lock;
 	bool                       ready;
 };
-- 
MST

