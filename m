Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136840;
	b=HDUaeaRjwxoFhKwlOCeSztxMZqRHU8jMl3ya8lfYMXpRzSofo+fcQNWjMShTDcpooGdo
	 u8EuZL5IqiFb1nvmymQhfMiuMMOp2mURJWLAz4ye+4aPeFvB0CuIMO/Ua1yB3ZaOahCl+
	 TF8yu++fb85Radkf4kV0WHGYpBIMmjT8NvHKBlG1gn6aDZmCcuLbKAPLF/AFK53kvHCmh
	 4bsBqOyD9WdeXzhZGx8VjKJD1E0ZLOzP+Fl7ooYZC2RY42F6n5y3hBjk/sLucFsueRpXK
	 FA/+xWx8mG3pEFSDnkJjyAFseiz85QWCztN4lIePvv6chavZfQOnMDXk83i9OefOTTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=vXU5FE3T392RxN9QNel254D35psegmPr29XGG2IaIcw=;
	b=qdWw7CC0kyvo96ZBcTfhQh9BRCox6jgZ+3jDTriilfDHAgfH0Dr6Vmbr+g8ftr+hjbgU
	 vosIniX2AY3YMpe1oVNXpqhgsz7jvtk3LBMZJJTkoWOCHT3IwSUBRAqjxCBZ3XmSD/bj9
	 dK0uAUr/oVeF6BMFINJLwaM0TqN1QzG3PP+WcL+/TfZ1Py+unFNZOyMwCzijgeevk++FU
	 UB7H5n70ZCa0TljMRkmd6lpuZ+XkA6kZ4AcbDfzvI8T0rlYMoCtx5QmI5pi3zpydXfMH8
	 2r3IvDxYyVw7G8MYqxwhQbjh6y1/so4SuV93wMW4wktFXEpp65FL/J9i3zKcgVHxnUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QbUTPWKs;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7C60A3818
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 01:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E7C60A3818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QbUTPWKs
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c50c9af44d6so28679666b.1
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136838; x=1795741638; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vXU5FE3T392RxN9QNel254D35psegmPr29XGG2IaIcw=;
        b=QbUTPWKs9UxltPvokhRyrF2tIEhGUQHhhLvby5CXY6u7ME8ZLHgDBc6LZO/iEfpmFo
         AH4259OWvZ1gKTE4hxT0p/lHDOFzpic6vyzfZWoPe00RT63RH5uFG0rZFcvbealln1S6
         dQqWzKf1mr2q2zYsdCO6sL2zT7Y1vAmPgP8ES9889fu2q7dyqafhPIyZfForzAqKBEgr
         ATNk/hCyzeRn2qg/UsHST1VS9jEmxoo8eRW5VJV7xY40NOjuuOQEtA7k0cB9BfLkQN8W
         d+Rqi0jkEg9vSnndsrttThSW8NORXcuhwbfvejUIhHzaXWPuMWbRVPHH/SAFIrudo0vw
         rJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136838; x=1795741638;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vXU5FE3T392RxN9QNel254D35psegmPr29XGG2IaIcw=;
        b=R5HbjKfihHddL851f7y1nTmAd92SA7zdwLVTco/0CEi6IP8rVNRqO7IZG/eXk0AkSA
         L2W+t99pG37HaOKXmS6tGhYmMSAeR5F8g6grRVlbp2zYw0i0ix9TymIOL0qZaU5Y2zCR
         FOnPm/9gCfNj7sT6h8MjJKMfZC0ccQ3OWcZ+eHmlOktDsVLNbOsat6IoqR6xi16reiNM
         jf4T0kvGSaWHKVPdqFCf8IyTf24rcwymqcEC2D0B3NvitWf09ybe6jvSySJedXyxkAg0
         Gb/A6EbKcvV4sxOysGgZhf0H2Gs8lDZ+zvYKoXDpUIfJz1imt5ma55h85IEye56K5PYB
         m5/w==
X-Forwarded-Encrypted: i=1; AL+hErFCfY6vDo4tCY+9teP5EaplZRFrVc5Ztvt7lYZfYmbFiwrNnDiTfmfymQx/O9vUF4wPLOGFLg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+/h/ezW8/WMRaWBV06kxubopAET3MX6NxHX7wa49q0sIUFXEad
	YdlhkzAekqq/5iZ0MarAT/TIwiZ7gvw0tZfo6g7TAWAlq2P61TaTUIq4TdcIpRsjm9HWMttSU8K
	z7/RxSw==
X-Received: from ejdlt17-n2.prod.google.com ([2002:a17:907:c651:20b0:c50:cd62:3dd0])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:4fc4:b0:c2e:62af:b6fe
 with SMTP id a640c23a62f3a-c513a5e62e7mr135377366b.8.1795136837193; Thu, 19
 Nov 2026 17:07:17 -0800 (PST)
Date: Fri, 20 Nov 2026 01:06:45 +0000
In-Reply-To: <20261120010655.467825-1-lrizzo@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261109182533.3594984-1-lrizzo@google.com> <20261120010655.467825-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261120010655.467825-16-lrizzo@google.com>
Subject: [RFC PATCH v3 15/25] net: Use PISA for page_pool memory
From: Luigi Rizzo <lrizzo@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Luigi Rizzo <rizzo.unipi@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Naman Gulati <namangulati@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

When a page_pool performs DMA mapping (PP_FLAG_DMA_MAP) on a device with
pisa_rx_bufs enabled, pass __GFP_PISA_RW to use PISA memory.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 net/core/page_pool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index d7c88c0b67e53..91cae5ba78373 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -16,6 +16,7 @@
 #include <net/page_pool/helpers.h>
 #include <net/page_pool/memory_provider.h>
 #include <net/xdp.h>
+#include <linux/pisa.h>
 
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
@@ -622,6 +623,8 @@ static noinline netmem_ref __page_pool_alloc_netmems_slow(struct page_pool *pool
 	 */
 	if ((gfp & GFP_ATOMIC) == GFP_ATOMIC)
 		gfp |= __GFP_NOWARN;
+	if (dma_map)
+		gfp |= pisa_rx_gfp(pool->p.dev);
 
 	/* Don't support bulk alloc for high-order pages */
 	if (unlikely(pp_order))
-- 
2.56.1.809.ga0b61035b5-goog

