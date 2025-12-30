Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187328152A
	for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089760; cv=none; b=IF4U8nEFDu1kgMKACVLMdXw8YqtBfsHPe1MZ0HqdwpVHpYsJ/FDttSTGJfEGXQPED73dzle1r2F5hysf7zXFxQH4glwInpGG6qRKub4OLdN0fOvw7X4AsFGQeqRv5imPpZd4seyr08B7KkSBYLchdNZPPlcs9ydSMthYVnQchI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089760; c=relaxed/simple;
	bh=1JUA4c0efATkxneQm73kN9tTpnR2rWTicL6pMgMgIPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=njlsL+/cGcTeBRUm8y8wJym1VokoMmYC0nzhoAxzEUyb9M6SYSCul6e4tyGjz+Q396CTrEkDi7pr7xKrUVupuibaB95nDFUuAc9M8H7tqhwq3v46ADk7mChfIfkZuIcXKDWjtsU8nlHEeDhpZfdAzBrjSSN5ZSLL2ouE9cTZqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2NLIuUn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2NLIuUn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767089757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lIFloJTLYi5ioijSED2t687CZ+kUT7GxSlzISMtKW5A=;
	b=h2NLIuUnakOYM2M3AtVBzson9jC3pGMptwj6RYLDk0Jx+UrOlxB2ftVuUW9IZi5P6OcbLW
	Fqed+ptHCNEwsehEs4sdhKcqy7naZVmHPt7VSXVA3foaT8F6OlgAsRalk7CK4gD0MQHqE9
	C/pzisVrIN5SdlNwS4PrKCNEn+C/C4E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-wrKngCFdPuiztYa_CEC4Aw-1; Tue, 30 Dec 2025 05:15:54 -0500
X-MC-Unique: wrKngCFdPuiztYa_CEC4Aw-1
X-Mimecast-MFC-AGG-ID: wrKngCFdPuiztYa_CEC4Aw_1767089754
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47a83800743so53904805e9.0
        for <iommu@lists.linux.dev>; Tue, 30 Dec 2025 02:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767089753; x=1767694553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIFloJTLYi5ioijSED2t687CZ+kUT7GxSlzISMtKW5A=;
        b=wuxOLTXrMfvIf2R9mqIG9dQHjHl4RdQ2Tlql+bP01j+4kb3C7F8TisIjcDT5MRCj/Z
         ZtHcqJS2Ee7Bu1HinNtqDdDOfR8wK0m9pZryGF1tItA4pILaIBAzW8JoiwLoAHqYGSOm
         S6egdEZvJYG8SusCDyO3Wzld5FxkEl8518QYrbtK8I6v+SlDgICHB3Oj7Nj6/9yjd8gB
         i2tTLlKvuWkGzOG2GX/mCheKdjeCutyvbZ01fr6jRj6kQQFgpzTAnzB1kbc3bH/9EstC
         uoEfu5+H1zfJPA08RNCmg6y6eFzEV67vS1Lkl4MWPjAOLm9SoN7w3hcV/lFzCAoO4zca
         subA==
X-Forwarded-Encrypted: i=1; AJvYcCXUrDUpdNDkkOjixQToD0/nwhSPdKUjYWrgSXojXX7eGTDE8WP3MzF5qQFtiF8ZQ7+8ugRLOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWggucmg/aBcfcoVY6JUWABkaL2BK2gz90VUDPi62+qVTuDK/x
	WpBO2F9vXYQTCMXUkrB/hHBvv/xrXMe5h9NTFIty9W+nles2e7gBkp0gaGGvl7KbjcB5Tw/6Aps
	yBjU6PI0y2RhQ6wtnM3OHgSrmmhpkYkjZMp+6gIhQ5s9rydg6WtLKhs69
X-Gm-Gg: AY/fxX4fvOLaGHn2aRGmRr0hAWLUcMVh6li9hsE7qhSAcEJPEz4JhQY5Bu4W0MP0ep3
	D0rsFtOkc04b8eezrORad4FRePzO6leCVjyddCR1t8chVXfU2t1iqwKw648+NOT9sDygzdOpAss
	JxpBnxiasUYCSlR9MSlI49LaWxoPni26t1FacSjKkgZBd02eaWllbmaKfZN3FwJ3T5AAkfXgbex
	V2BIxHlSXLjlAbumHEkuMKK/6XP/iaLmr2mIJXOol3HFiJHKOwuU0oMebzTPhKv70ZJZu01ExNM
	gWFH7liYoHxGyzSJ9t0hzRO9GsgwStHYvdES+sggECjuRPAq6lEOU/GxABz7gFC4LIYbQkuHGW3
	NgbF0SBbZ8+oK0Rrfcd7ZrQ4V2RlJJrsltQ==
X-Received: by 2002:a05:600c:46cf:b0:477:9e0c:f59 with SMTP id 5b1f17b1804b1-47d18b833a6mr393752905e9.2.1767089753552;
        Tue, 30 Dec 2025 02:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0nrcJnS7RjupXcIyxgJ/7OwvI0dkgJ3plFmvdD3JvcGLBLhWJUwOhq1auRl2SqH+pkIX7dw==
X-Received: by 2002:a05:600c:46cf:b0:477:9e0c:f59 with SMTP id 5b1f17b1804b1-47d18b833a6mr393752425e9.2.1767089752979;
        Tue, 30 Dec 2025 02:15:52 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be272eaf8sm630001695e9.5.2025.12.30.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 02:15:52 -0800 (PST)
Date: Tue, 30 Dec 2025 05:15:49 -0500
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
Subject: [PATCH RFC 02/13] docs: dma-api: document __dma_align_begin/end
Message-ID: <192a335d783a2e54f539dc5ff81bf3207dafa88f.1767089672.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: BXoVLXitdkVbAc8KnltBQXjwVUJxL3I0dWqmMTyAkz4_1767089754
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Document the __dma_align_begin/__dma_align_end annotations
introduced by the previous patch.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/core-api/dma-api-howto.rst | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index 96fce2a9aa90..99eda4c5c8e7 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -146,6 +146,48 @@ What about block I/O and networking buffers?  The block I/O and
 networking subsystems make sure that the buffers they use are valid
 for you to DMA from/to.
 
+__dma_from_device_aligned_begin/end annotations
+===============================================
+
+As explained previously, when a structure contains a DMA_FROM_DEVICE buffer
+(device writes to memory) alongside fields that the CPU writes to, cache line
+sharing between the DMA buffer and CPU-written fields can cause data corruption
+on CPUs with DMA-incoherent caches.
+
+The ``__dma_from_device_aligned_begin/__dma_from_device_aligned_end``
+annotations ensure proper alignment to prevent this::
+
+	struct my_device {
+		spinlock_t lock1;
+		__dma_from_device_aligned_begin char dma_buffer1[16];
+		char dma_buffer2[16];
+		__dma_from_device_aligned_end spinlock_t lock2;
+	};
+
+On cache-coherent platforms these macros expand to nothing. On non-coherent
+platforms, they ensure the minimal DMA alignment, which can be as large as 128
+bytes.
+
+.. note::
+
+	To isolate a DMA buffer from adjacent fields, you must apply
+	``__dma_from_device_aligned_begin`` to the first DMA buffer field
+	**and additionally** apply ``__dma_from_device_aligned_end`` to the
+	**next** field in the structure, **beyond** the DMA buffer (as opposed
+	to the last field of the DMA buffer!).  This protects both the head and
+	tail of the buffer from cache line sharing.
+
+	When the DMA buffer is the **last field** in the structure, just
+	``__dma_from_device_aligned_begin`` is enough - the compiler's struct
+	padding protects the tail::
+
+		struct my_device {
+			spinlock_t lock;
+			struct mutex mlock;
+			__dma_from_device_aligned_begin char dma_buffer1[16];
+			char dma_buffer2[16];
+		};
+
 DMA addressing capabilities
 ===========================
 
-- 
MST

