Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA70324B10
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601401; cv=none; b=qUp2cu23wdXzelsAbHKqHo5Ro4Qdf7QqHO61mcRjTLa7emUTyfQhC5gS0ogyx74PJhGaQGDXLdoItDJBr1B2SJHsNNx3uLMkRc+T419aw1Gqwm7zjQckfks3ka4lZ89qI/HIWxFAjarmLm39ra1FC0TmtaKDDAe+xpDN5YfGuNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601401; c=relaxed/simple;
	bh=9iEzgPHvQMQc1JPQHZR4+0WH0pS0RVDvpJpTVteo84E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WnFkVKd2S93rWhkdDF/U4Mnzrn2cCafm+svEn9Fef+VXeeEC44E/XdDeKc+3r5JYmwNU8MYkO698Eoa8tducPstldVnJIQsusdKmYT2dQEN7tUvk/TzCDz2x43xbAShBaNXpxa2jPpyEGSItHHom3bctQOuhPAmwOPYfY84pQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkJ9m35O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkJ9m35O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ceg01Cw9H4aJK1m/G33nz2CzBje4q7tNz5vOwZlPzjQ=;
	b=OkJ9m35OxyogYFe81sl3PtZ+rAxvLVS8Bj/sQwvCGn1yKxcIpEh2GHLFKUq0oda106zQ3i
	NevIe6tIPBMmAU8VArmEXiy9noLdP1uSsCsNQdRXs6CbbLoyPNgod4l2VSh/nC1YWwXqOW
	fySZXCEgl/RuGchr/o0Z5Xov5dGCa5E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-gDjHRLi_MUefSikPzBFrjQ-1; Mon, 05 Jan 2026 03:23:15 -0500
X-MC-Unique: gDjHRLi_MUefSikPzBFrjQ-1
X-Mimecast-MFC-AGG-ID: gDjHRLi_MUefSikPzBFrjQ_1767601394
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477563e531cso92453665e9.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:23:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601394; x=1768206194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ceg01Cw9H4aJK1m/G33nz2CzBje4q7tNz5vOwZlPzjQ=;
        b=Oae0NLqPBjlRW5tqB18XabBbf3Ih5CeNiKe7/V7WbMMlG/JM9Ut+cu+WPgyo3yVVHI
         x2Opb4VjTDZvMu9h2y/INlRgc5d2LgkKJBgnHlIhtMJNTLfhq/8Ehi8RpFhB9zQC/wy7
         En4PrdDE6ONXOmBV549YFYj/kpbyL020XIazp15LHQ1kRHlVmGTq/KNJjiniZonpmR9R
         wn6Rda+Dt43Y/ye5JyjMNXAVOP+tpI0afcchjpr/aWkLWsqQZ8sZLpe1K2N24jHqMSms
         +IVLiBHfAa+Vy9cJ3SK6YcNhPDUQbIYo3rvTxxoGEFJImph2dOaKko9eo4MnXK8Ka+AU
         itSA==
X-Forwarded-Encrypted: i=1; AJvYcCW5W7TnK+b1M3iK3wjx6c0ST44Q3R7vYgj5okZtJewIJ1lAUToq7tzKzaczDMFYsICkNj1Hkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+p2eCKKo3I2POGlhmEGnBP+hFxmIosSIXA68k/sbcf4fatinh
	WWSlem2seQXHrjw9cAPDeqTvuBOS16M1iBuH4ZPOZZ/5D9GHndDFJRQOryjFCKNL2TbhmtfPeu2
	HKv9hCfdFaMdUwanin5JMxE9ZsX+jN4DIavp9A3huCgJokpdbiFJHvyaf
X-Gm-Gg: AY/fxX4tKMMmZgUBqIS4/Qgiq0eq0em4Qrpn4WP7cBa4jCliIxU3twi5dHj0+q1VMo/
	MCV+9gZkQIzQfZQdryM3Q3HyKKZ+fTEDfys6hXiZeHeFlOoisdJWytllYa6gAWxxHeRG/E0fRDJ
	aL/LUq9sdNMVZ8nMH7Yud1SKqQC+tuJQHSABi+keEV0k2w4EOidK8ZVhzmSv1OYVx4IAfJiwiCt
	HEBzIo4GbKA07+4yL7PkNwVdQGb82KmsRIUBKnFsn3u/20sIuzdasR5HH5IZHqqqWWd+cfIugao
	UdJxva4XAk74tPj7ihf7Mb0wfJrK+dWIdUDOj7MxC/anck0nV3oVC9ZAWRneKh7+AlrdbrgokzM
	GFaptjuhv42HGx5cSv++s/oE6CzK/cJlbLQ==
X-Received: by 2002:a05:600c:8710:b0:475:da13:2568 with SMTP id 5b1f17b1804b1-47d19592102mr548338165e9.25.1767601394170;
        Mon, 05 Jan 2026 00:23:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQnvRLWDf0aCqCDaI87q/fN7cE8aCZoYxHw4jznq03tUl25BjWNTLdD3S8QBVZUoY2t9i3vg==
X-Received: by 2002:a05:600c:8710:b0:475:da13:2568 with SMTP id 5b1f17b1804b1-47d19592102mr548337795e9.25.1767601393663;
        Mon, 05 Jan 2026 00:23:13 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d13ed34sm142315025e9.2.2026.01.05.00.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:13 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:10 -0500
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
Subject: [PATCH v2 05/15] dma-debug: track cache clean flag in entries
Message-ID: <0ffb3513d18614539c108b4548cdfbc64274a7d1.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: WDT0icN4CAEt0TuTBJmSGovmuOLqEfnlgbTGjj8zG8o_1767601394
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If a driver is buggy and has 2 overlapping mappings but only
sets cache clean flag on the 1st one of them, we warn.
But if it only does it for the 2nd one, we don't.

Fix by tracking cache clean flag in the entry.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 kernel/dma/debug.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 7e66d863d573..43d6a996d7a7 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -63,6 +63,7 @@ enum map_err_types {
  * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
  * @paddr: physical start address of the mapping
  * @map_err_type: track whether dma_mapping_error() was checked
+ * @is_cache_clean: driver promises not to write to buffer while mapped
  * @stack_len: number of backtrace entries in @stack_entries
  * @stack_entries: stack of backtrace history
  */
@@ -76,7 +77,8 @@ struct dma_debug_entry {
 	int		 sg_call_ents;
 	int		 sg_mapped_ents;
 	phys_addr_t	 paddr;
-	enum map_err_types  map_err_type;
+	enum map_err_types map_err_type;
+	bool		 is_cache_clean;
 #ifdef CONFIG_STACKTRACE
 	unsigned int	stack_len;
 	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
@@ -472,12 +474,15 @@ static int active_cacheline_dec_overlap(phys_addr_t cln)
 	return active_cacheline_set_overlap(cln, --overlap);
 }
 
-static int active_cacheline_insert(struct dma_debug_entry *entry)
+static int active_cacheline_insert(struct dma_debug_entry *entry,
+				   bool *overlap_cache_clean)
 {
 	phys_addr_t cln = to_cacheline_number(entry);
 	unsigned long flags;
 	int rc;
 
+	*overlap_cache_clean = false;
+
 	/* If the device is not writing memory then we don't have any
 	 * concerns about the cpu consuming stale data.  This mitigates
 	 * legitimate usages of overlapping mappings.
@@ -487,8 +492,16 @@ static int active_cacheline_insert(struct dma_debug_entry *entry)
 
 	spin_lock_irqsave(&radix_lock, flags);
 	rc = radix_tree_insert(&dma_active_cacheline, cln, entry);
-	if (rc == -EEXIST)
+	if (rc == -EEXIST) {
+		struct dma_debug_entry *existing;
+
 		active_cacheline_inc_overlap(cln);
+		existing = radix_tree_lookup(&dma_active_cacheline, cln);
+		/* A lookup failure here after we got -EEXIST is unexpected. */
+		WARN_ON(!existing);
+		if (existing)
+			*overlap_cache_clean = existing->is_cache_clean;
+	}
 	spin_unlock_irqrestore(&radix_lock, flags);
 
 	return rc;
@@ -583,20 +596,24 @@ DEFINE_SHOW_ATTRIBUTE(dump);
  */
 static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 {
+	bool overlap_cache_clean;
 	struct hash_bucket *bucket;
 	unsigned long flags;
 	int rc;
 
+	entry->is_cache_clean = !!(attrs & DMA_ATTR_CPU_CACHE_CLEAN);
+
 	bucket = get_hash_bucket(entry, &flags);
 	hash_bucket_add(bucket, entry);
 	put_hash_bucket(bucket, flags);
 
-	rc = active_cacheline_insert(entry);
+	rc = active_cacheline_insert(entry, &overlap_cache_clean);
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
 	} else if (rc == -EEXIST &&
-		   !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_CPU_CACHE_CLEAN)) &&
+		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		   !(entry->is_cache_clean && overlap_cache_clean) &&
 		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
 		     is_swiotlb_active(entry->dev))) {
 		err_printk(entry->dev, entry,
-- 
MST

