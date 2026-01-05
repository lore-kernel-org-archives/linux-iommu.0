Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC7314B81
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601392; cv=none; b=dg+0uk5vcA0NmO3MbTAGDif6Nd4SYF8Mucwsu0x5m5pHNOco772PmjNDhl7MyqfGqgOx9x68iNkHhPcG/prR1IMvr9MB+dpseE9kouKoNyZ21lNp/0NgRFJfoyVGbRzJLSg0WDn9AehhgG5qnpK/hT6bTQPSpILezr9BphomS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601392; c=relaxed/simple;
	bh=IXDkDZtAt0m+aQ314vUNmBOnLJtrDRmmzuRNBy60P98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dg7QuMYR52/6qXwHPISzakNiEsaCFRALueyQjIWnrcN8Py+DP1/ePNHLoSEiGAUMc8pMAjUq/5V99w5DDFFuJgh2aOOFZy/VMBgkCozpHNpnIlUg4v/99V88dG29AiOMrDfjBEAb4nPNzRvtowZTqcUNG/UE+91d42Bslve9Gvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEBaeALe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEBaeALe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GET0dQPIEY4INQeC72jj/1xpmrzV3mfvZ6nPpr/HKY=;
	b=AEBaeALep1zaNbb0x0/0n6NT1Y1yen9lZPR5QYlhYaryR+slD065Hydx5X+LHnUm4eUQ40
	VsnNwXHsVoJeAFuMARDPi/7suOmiuEbeUE7BrqGpulBIrlIdhNRbHBmcn+ZpbA+uWUT/GU
	NDS4V23B7nFdBRCQcv7uCdN8wAaJZOM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-Rz2hHixMO0etFTKTxiK3dQ-1; Mon, 05 Jan 2026 03:23:07 -0500
X-MC-Unique: Rz2hHixMO0etFTKTxiK3dQ-1
X-Mimecast-MFC-AGG-ID: Rz2hHixMO0etFTKTxiK3dQ_1767601386
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775d110fabso121207195e9.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 00:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601386; x=1768206186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GET0dQPIEY4INQeC72jj/1xpmrzV3mfvZ6nPpr/HKY=;
        b=rLC7W6deahkJpH5XpIL5TTt/J7DhNbCrYDn31k2pM6J6I97JRyEFJR0sarnq2Dz77C
         w+/XABtKFafQE7Y/sjtcQXihNi2/djVncmpNEcRG+lFQTCffexrr8y5hk5x7JRj/jLa+
         tbXWGFf35pj7/bKbNVrWAphGoF5ZW4NWpXn4bGz6w4ffLqqspcc7gJ4LHjjRU6RPBVmz
         jUcfERaCtiOYpgHs/RVNuA5e+/YU4dR11xlcenFLeEUh0+x0V3KJEjLgbsT3WegEF0Aq
         Xfry79GztKI1/kGYtbDePFhm+h4HQ3wpk5xKhZzOX5mv2ILkzDNelo/dTOoPSfmWNVhx
         bIbg==
X-Forwarded-Encrypted: i=1; AJvYcCU+kwfIdTo3sS2SomP20Ns36dMi8C+7Qj3yzV5mF1qbPiXZ+Mmr/0k+C7GkW1M/7/dkKlwMGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc8XIRCeP39hMoh/XRtLKm4VLQzrHrbBbgdWzB5oS6bAP0f47j
	Va+k4FKpE3f572zWahcVUI0oUEaWIN2Nx8YXScS+tTLWZXxZwUseFMXXG6PNezu5OE9qa2KnU80
	mW71w1Zu4+t8IqZzR+2brCemdZ+U/5ikafW7g57SwnUdPV9C4IYAw/S9c
X-Gm-Gg: AY/fxX74tPrb20XDR4XtjaUs2bPDvpF1aMUcQXPzPeeQ1sM9Dpig8HGfPJKo4yxa5l9
	jGvnep1/o3anCY9JtbbanLx8UOpphyHqwo9q+vG1/1YKFrrnXL7EL9mWIWP09gD1k7+M03VnQPn
	jr/H6ocYYZ/Q8ZW5SzG61nSkAxh/6PA7W6vXoV2kyA+3hnUiI8TzaQuerCwSaxTpc/EkJ35Zh9+
	P0uQvrVuTT92irUuAw99xO95jh+LVhj6IW8oN8aIuGX9CSEsgaG8vKXIdiZdtEHXaBRwLkncUIz
	DyoP15hkj/leZXl/AjrNgjj15+YNqUE7wUeT2kDt5V7fV2jo/aBEatcDmVInXn6D3usUtoktUDT
	6/EKufu1Sv9+Xal3AyY5weBsszllilrvFuA==
X-Received: by 2002:a05:600c:8107:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-47d1959441fmr614821395e9.33.1767601385773;
        Mon, 05 Jan 2026 00:23:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFnRSrw61tFPN3ingmu+tnGwj19lkkHlcV8EUdBq7ZpNk54zAQl+NVy05hzMsFUOEhZ22F+w==
X-Received: by 2002:a05:600c:8107:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-47d1959441fmr614820945e9.33.1767601385198;
        Mon, 05 Jan 2026 00:23:05 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6c0a1d89sm52159655e9.12.2026.01.05.00.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:04 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:01 -0500
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
Subject: [PATCH v2 03/15] dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <2d5d091f9d84b68ea96abd545b365dd1d00bbf48.1767601130.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: OqpYUduq5ztBu7GnYDd2UWA3KqyD0Bd1lOc-ryNIM8I_1767601386
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When multiple small DMA_FROM_DEVICE or DMA_BIDIRECTIONAL buffers share a
cacheline, and DMA_API_DEBUG is enabled, we get this warning:
	cacheline tracking EEXIST, overlapping mappings aren't supported.

This is because when one of the mappings is removed, while another one
is active, CPU might write into the buffer.

Add an attribute for the driver to promise not to do this, making the
overlapping safe, and suppressing the warning.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/dma-mapping.h | 7 +++++++
 kernel/dma/debug.c          | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 29ad2ce700f0..29973baa0581 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -79,6 +79,13 @@
  */
 #define DMA_ATTR_MMIO		(1UL << 10)
 
+/*
+ * DMA_ATTR_CPU_CACHE_CLEAN: Indicates the CPU will not dirty any cacheline
+ * overlapping this buffer while it is mapped for DMA. All mappings sharing
+ * a cacheline must have this attribute for this to be considered safe.
+ */
+#define DMA_ATTR_CPU_CACHE_CLEAN	(1UL << 11)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 138ede653de4..7e66d863d573 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -595,7 +595,8 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	} else if (rc == -EEXIST &&
+		   !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_CPU_CACHE_CLEAN)) &&
 		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
 		     is_swiotlb_active(entry->dev))) {
 		err_printk(entry->dev, entry,
-- 
MST

