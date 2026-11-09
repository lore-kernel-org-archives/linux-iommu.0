Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248752;
	b=brd/RrdV3+dG1hYgKnE3nEHrMRPumeDkNYBEf4fKWYoJirWnO6Kg4dr8iwKdZXV367D5
	 nRLnLZ9mN0ftiAvcFrmgAjNvzvNjnpjIUPzVLSArjTEoAkHB8ftJ9FxkFf9bITbpexn2v
	 gwFL8hTT7ugTn6vL+6tS5hn+MDpS+l2F8e1Ze8YSim329VjHtIPYRyYyUIwjwwdkX+OQi
	 c/an7gkasuSI88TVu1Q/eGHucwRTB04FDZzGOGws8NPI8GS8gPlaQj4WILPIx9t7puM5q
	 sJUkYq9ZEelGq63yl5O3k+sNCRWcTD6+y9qID9xSVf63cEIqgnoHFjF8lMJfxcGIbXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=NBXycfk6vA0iRzHtj3njzH1Lm9NHD4+ffX/6h9NPcU0=;
	b=g5JLdsFN/jXApHSA/3gtLOiYcZtLXXuFuVqoYpce+W1vApnP0hAQanR0OC1HvFXkcn54
	 U4GIX/5WSirYaC1Rm3E05RT6sYdM9FTf3iz0FYh9fv+fQoFgRkNUSqhTssS0EPADI6r7Z
	 dOU8YcPphhUTPXCCItMP4sy2a4rF7rm4SnG4wXcMT03Gs/FID0L0C73Pz/JMPqd0T7Vi0
	 oPbuohZ+VcktsyX6CsG11JdQUONBV4eFwnUlL9cocSjrJBxwPPdH8jIzmc5/P+dB8viUc
	 5AAjMBj1WoEBJyUBII6gF0Lk4jh416KKqvCJrCV9G6si0F7rEwteTz4GavoGsMRLxpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e1oFYxYe;
	arc=none smtp.remote-ip=209.85.218.69
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25D8606AFC6
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 18:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E25D8606AFC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e1oFYxYe
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c4d4d132bbeso123813366b.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 10:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248750; x=1794853550; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NBXycfk6vA0iRzHtj3njzH1Lm9NHD4+ffX/6h9NPcU0=;
        b=e1oFYxYe4M6+ej5HDIh4HNvOmlUJjbpWe8tN3+G4Kf9u9SsvY4odX4epa6q6vM9Qr0
         sUTmVFKlr0IF8/9VSQ3X6OOKfZo4mvcPyahrAufUYBtX4OjO+jMkKB3Zp5qU+/n0VLBd
         aXT2dqAYrTuLDcc1CIz6n6m9dB6KJok9I2xAL695ZhQ6Q4GvUt4qwjP6FwTg6JwZJNnv
         nhu6nXhuR7nRVzXetz6Ulw+pe+1LymwkoGiAxPiJEoWJam+e5m10rfdtDhw5Fx21maUL
         SPe/zOV72Gxh5XG+mXfvxlWw1qsd46a612kVwPjpC/jgFowlUdqNi3q9qbR0CxN3rcXl
         VJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248750; x=1794853550;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBXycfk6vA0iRzHtj3njzH1Lm9NHD4+ffX/6h9NPcU0=;
        b=eoCniocDAm4LaotH3VEf7PbcEV5Bv3n/QIX0HuNATLSNRPg/hOS2nSgBUWT8gJK4nJ
         2C0KPVj3hADfnLRLtD+UtYHQkv5llj0x+GyQahTyrHZLcjquV3T7IK5PeSJApspeFg/v
         7oWn0EZ0Igu5ygvzAn7vLhIZUF3wyLrUhV9l2jtiP13kTelHlJe0P0qg5fM9Ib2dCQgI
         gKeo8UrSmrMR/zr0sSer1teT09OEFpEnV9+fnDfVfYdhpfprq9FYYN/K+fJQKLwctgiG
         o7ON8qkRPNOx+fOr9d3qAMuLF1kVOQShaUiErfDEC57zo3HLIyzYTvIJkZHpH0JOyXYR
         fX2Q==
X-Forwarded-Encrypted: i=1; AL+hErG38/OO8fan5NsThlEWGvcxNclAmlEDDgJGd80bG/uy+l0X76YVbx03Ms25DCLLD6TmsUNrvw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8zqdJvtmG/C+FA/wwY56wIckSkrk3+Ds3d01B45rt2cDhuR9fr
	mA7P58K8Ypaum13absl8hcdP++hQ7b7Ug7LRzqf0obSej5wiW36hGQeMKYnP3J651XzPBpuT0jQ
	YMNwYxA==
X-Received: from ejbgr9.prod.google.com ([2002:a17:906:e2c9:b0:c4d:4f51:fd3c])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:d54e:b0:c46:78af:6150
 with SMTP id a640c23a62f3a-c5047a434a2mr29783866b.2.1794248750196; Mon, 09
 Nov 2026 10:25:50 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:21 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-14-lrizzo@google.com>
Subject: [RFC PATCH v2 13/25] net/core: Use PISA for page_pool memory
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
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
2.56.0.542.g3ef89b7020-goog

