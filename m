Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7633346E66
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541300; cv=none; b=LgLXYp2gETIL2MtDu6cTJYll/y3kA4PAUXnIwU0IIDV4o9GvF8TMgBlUrviqLa8REN6T8sfbEz93dMc+FklXPZ7e8fMHMzwjwqr0/WPoi0NNgZlj11DR8AFOrC5/naCNs3vkp+/w8L2EwyObiZTtpizjzZiGhkE3hkMMKDF20GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541300; c=relaxed/simple;
	bh=VpcxdAAdPOpdXHrvDAVNa63WDfXimLnTVF72oWUsomU=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=Fx82rsto5wQYLRPW1id0CS8qbUj7KQTRRsJmkyE93CWNnojb8b7TjkIBR5oPvAEEBl8ErIsyLZEA2M4SaUlftL2G0wH5ajxNGM1KfyCwqNcPLkaM6OkC4SsPSsy9ovl2QYrwD8DRnkHT3Et/YOGXuzTyff9DrCNwwivVykbexrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azJxnJ8k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azJxnJ8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772541297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlBrU2TSGeDaYB6/j/AShAP1tI2ewUQw53Z0nN5L9EY=;
	b=azJxnJ8k27Zuu+/ZoyMXU/E5BhLEc/es6UvTYkrrjBYrM/AwE6525om19CNIQLZIbiahs0
	pzMu0550XFVqiQ26gGSOXa5soLF48hfsxwiUGBLBFXbi3+xpCUvPA8lFmFXrtPvZn41b7c
	sOgALXXsFmUzstZLtSf5OAb9N0Tcfmg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-hBIsd64nMoeGa24QQzArnQ-1; Tue,
 03 Mar 2026 07:34:52 -0500
X-MC-Unique: hBIsd64nMoeGa24QQzArnQ-1
X-Mimecast-MFC-AGG-ID: hBIsd64nMoeGa24QQzArnQ_1772541290
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B63E21800451;
	Tue,  3 Mar 2026 12:34:49 +0000 (UTC)
Received: from [192.168.1.153] (unknown [10.44.32.231])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C868930001BF;
	Tue,  3 Mar 2026 12:34:43 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 03 Mar 2026 13:33:49 +0100
Subject: [PATCH v2 6/6] dma-buf: heaps: coherent: Turn heap into a module
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260303-b4-dmabuf-heap-coherent-rmem-v2-6-65a4653b3378@redhat.com>
References: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
In-Reply-To: <20260303-b4-dmabuf-heap-coherent-rmem-v2-0-65a4653b3378@redhat.com>
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
 Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772541243; l=1661;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=VpcxdAAdPOpdXHrvDAVNa63WDfXimLnTVF72oWUsomU=;
 b=QxLarHWId/17xsaNHf0kOi/7HBFfW/egmdOu/FyJddRAF7ngzFqWmINEC5Qr2jLAbTmJHKsWf
 pslZnCKJzvSCDN0Mk2i5dfcBvOuyHDZZAcrLTIFyGGITZiyHm0McL7b
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: HiFwfUKjRi8BhfAtWCatlaBZJcBAxFdYNeOj76Rtsrk_1772541290
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
index d033d737bb9df..cdf8efa6c1564 100644
--- a/drivers/dma-buf/heaps/coherent_heap.c
+++ b/drivers/dma-buf/heaps/coherent_heap.c
@@ -424,3 +424,6 @@ static int __init coherent_heap_register(void)
 }
 module_init(coherent_heap_register);
 MODULE_DESCRIPTION("DMA-BUF heap for coherent reserved-memory regions");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("DMA_BUF");
+MODULE_IMPORT_NS("DMA_BUF_HEAP");

-- 
2.52.0

