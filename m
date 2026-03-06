Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C537FF78
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793474; cv=none; b=JHVgv4eReM7V7yuQ6IxznYDmaf+Wg8FwwHYYvWF27tTwZ1mNDKx2GNAovdWspE8n+nVkkwVbc8yJw+OXEI+sZGB1r9vRTI5MtYdIAG9BbRLr/qUQtGk0v1kvgVlVZv42sUSYDfqnv3xM0sqg6Fpu2/nDDGCC6sfzYsUWWTp8NDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793474; c=relaxed/simple;
	bh=8dYJXakMo93Mc3lLZ5xLZ8QfYkIluXNTvVn7oLOYyd0=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=uzCavlsOOU6WrlrUSMpwSqO4k9kwTB/dxDXZ/3V0udM72L6mBEllIxYfnZTJz8iVpM/6NxSvKlyj7KiQf4RB7X+ACeb41/O629V+rQg72HBInYjeadsomBhBRUUzUPAguvjspiOJPZZVP8s8re5BA8PiA9zC/SGHDeQcHfFSj2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5Nud/PN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5Nud/PN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772793472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlzQWM0pQarIoPqm3Nl91hQ8QPCgoigzmRIhUlpi9M8=;
	b=g5Nud/PNpHQhAqBQZ+SiSiMu7cu4hpRbgFPrGt1YkZqYPsxLIxE7fjo1buAcNcMQ7qXvae
	2/ucyyWLqaqdAbZHvkJDg4UKDNKrTLanqnq+RBQ+cspPM2FCcUQmgpsqAiYTRAvv/E+R7T
	xNEURcSnWDDGBxJ31Tw47mEMoQDzzWU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-UUtSeqiXMbu1DAjH5sRbQg-1; Fri,
 06 Mar 2026 05:37:47 -0500
X-MC-Unique: UUtSeqiXMbu1DAjH5sRbQg-1
X-Mimecast-MFC-AGG-ID: UUtSeqiXMbu1DAjH5sRbQg_1772793465
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBFDE1956088;
	Fri,  6 Mar 2026 10:37:45 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.45.226.103])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4D89180035F;
	Fri,  6 Mar 2026 10:37:39 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 06 Mar 2026 11:36:37 +0100
Subject: [PATCH v3 6/6] dma-buf: heaps: coherent: Turn heap into a module
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260306-b4-dmabuf-heap-coherent-rmem-v3-6-3d00d36c9bc4@redhat.com>
References: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
In-Reply-To: <20260306-b4-dmabuf-heap-coherent-rmem-v3-0-3d00d36c9bc4@redhat.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@redhat.com, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772793417; l=1661;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=8dYJXakMo93Mc3lLZ5xLZ8QfYkIluXNTvVn7oLOYyd0=;
 b=Qm2/NTv+NibwQ4NUgIiBv1ELR84Zemc1608Ij5MBU+ZNmcVHDkvPQnkB17rRPklxBL/kLazKf
 4Fi3uUXQDF+CAD44A2H9aDZK/GjsuL7JYH0er/9W85JKFYPQp+70MJH
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 5a-ITsgUL3AiixKqV2CrGQRfMkL27O-OI6o177rI3g4_1772793465
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Following the current efforts to make CMA heap as module,
we can do the same and turn the Coherent heap into
a module as well, by changing the Kconfig into a tristate
and importing the proper dma-buf namespaces.

This heap won't be able to unload (same as happens with
the CMA heap), since we're missing a big part of the
infrastructure that would allow to make it safe.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/dma-buf/heaps/Kconfig         | 2 +-
 drivers/dma-buf/heaps/coherent_heap.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index aeb475e585048..2f84a1018b900 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -14,7 +14,7 @@ config DMABUF_HEAPS_CMA
 	  regions, you should say Y here.
 
 config DMABUF_HEAPS_COHERENT
-	bool "DMA-BUF Coherent Reserved-Memory Heap"
+	tristate "DMA-BUF Coherent Reserved-Memory Heap"
 	depends on DMABUF_HEAPS && OF_RESERVED_MEM && DMA_DECLARE_COHERENT
 	help
 	  Choose this option to enable coherent reserved-memory dma-buf heaps.
diff --git a/drivers/dma-buf/heaps/coherent_heap.c b/drivers/dma-buf/heaps/coherent_heap.c
index 55f53f87c4c15..fdb3f5d907e88 100644
--- a/drivers/dma-buf/heaps/coherent_heap.c
+++ b/drivers/dma-buf/heaps/coherent_heap.c
@@ -412,3 +412,6 @@ static int __init coherent_heap_register(void)
 }
 module_init(coherent_heap_register);
 MODULE_DESCRIPTION("DMA-BUF heap for coherent reserved-memory regions");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("DMA_BUF");
+MODULE_IMPORT_NS("DMA_BUF_HEAP");

-- 
2.52.0

