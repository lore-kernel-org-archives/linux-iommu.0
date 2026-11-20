Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136849;
	b=mr+jx5WEIGDro5EQ9FV2nb0IP2Fzk3T0ZoplIPe2gT9kfxOH5i4OQ9hEkmE3/2z3BEps
	 wYWdRFYgWenT9cb+HbB6b2C/SWi9XKjHSLMMPgt+q6xp/7RAKUOpcXJbxUKbf9R1tt/Ct
	 7ceFFfJucUpXKaACU6KHpc/Itz5M/Cd1iV7t4kzVyRos6KCQRL+XuH5hwKsuDbjm6udrt
	 C4RaZQZC0DH7pR9q8/Gf+xevtMZ1jEkBqOa3uKuMkwLafkjzibI9k4pkJ7GAx/ZHVVjul
	 5PTKewjxoU956+fBdIpKYtCJaWivEW/WAmgAmzOa0PVE1Rz82rjzf415NZnzFeGA77Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=G58QRfdEQzG7y46akZhuXorptjXMkpo3OuC8LCJ2NV0=;
	b=I0F3dzdMI4VvtF1wJ3jHK3QriRI7NnzVaSozHGQd0Qqq3v3K2BgEI/4j0k98GxkBXqCW
	 fbW1YEzeHp0hmNLbOxP8HK3eSKvqNHDMp0bq9UYTKxmV8lvOAOJYUDapmDtJD70QhlSXK
	 xR12+2vuD/pG9FVsDCJiY2gNgIvj+OSt8cgq2JkrNi/5YALYoKnEgDYd0B2ZjpGDOYeq1
	 9lAT43mnOIAV/IzoEUZ+S1Kh+KXrHoyRDbc5cJBeUfEFQiXp1w5XVbcSxk77x6/3guC9k
	 aDL7SeI5v9m1/2XT0T5fpYbHGG1crdnZOb55OC6LgLS30IwqRxA5oJdlwpj+YswvWnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PUsuwlnQ;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B960A5BD4
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 01:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 838B960A5BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PUsuwlnQ
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b763d2c2cdso268334a12.2
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 17:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136846; x=1795741646; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G58QRfdEQzG7y46akZhuXorptjXMkpo3OuC8LCJ2NV0=;
        b=PUsuwlnQeTd3a0V2n8EADFO0d696g6V1vVesfY7+9ZXnVjyxvfMDirXBsNwLgmhEoT
         3Vf8eqNnPtUwQ1lZC29kmKnGvvmLtr2ki+UeVXW2L52s5iG2zRlIgl3z7UehD9Aercxc
         WT9U1Cgbl/RzsxCs6akN9UjXP3gfkdHeKUgfSb1zxVZw25Y8mqEKRbDOZ5bGro2cFzgM
         kQyHaF6pfs1/1p66moeKnmHRzdYZFkAPi6EYyHy3awXlus+rneWRR8mRS3NxZ39sER3/
         AdhV8J9TMxS5mrwxq5hAX9oPixL+0tlqMcNm4ZK1gP4sN8aCF5wObQMN3qAmkoqpcQ1y
         40RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136846; x=1795741646;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G58QRfdEQzG7y46akZhuXorptjXMkpo3OuC8LCJ2NV0=;
        b=YVFfsBhW2CZZVEPa05Nm5GCHiDUvBUh6Su/FqZwTO64H011OdSPulctxDJy04LsP9Q
         lcakdyNPX4Ff/RYcr018yxdnQmDX6P9YtFDBEokeWMkA7JSLdVqkWPxe7bU5BpnPRJ3u
         GOWdwheAfLQQRhGmgn2E5akIIIrZGwG481zD/uxB9ELnsmuJ+YGDDfvwNHwH/PEDNU6g
         yZRbID74vsxg1i/RqycXE6pSzZixXntqxcyZLiYfPcdt1VdRwojLXlMdB5K/F6XdUK3j
         2hVF3eBB35RPciAloAiOTUmb4nwhCk6gxd8jq7e7l2eDF8RpDc7bxgntQVZ+DzzkANJW
         kFXw==
X-Forwarded-Encrypted: i=1; AL+hErHCdWucrkn0LqBxJhIrQdu5mJjPsPG9fkMFj02ntV+tVvyPz2zNhgo2wtMHGsZyW37kbBvIAA==@lists.linux.dev
X-Gm-Message-State: APuU4Z++4orCpjwG/8fqkL7FBtLJ61xbwPkqfbjXnEGAZrlbwJBdvofP
	sU+w+I80KzgH3d8yKzKLwh9Y/yXpeyal+gGdsZVPixWVwcPRXSKkCJae60N9U9rkxsa/Y/4S+O0
	sU3pWAg==
X-Received: from edag35.prod.google.com ([2002:a05:6402:3223:b0:6b7:7926:2af4])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1c05:b0:6b9:c43d:892
 with SMTP id 4fb4d7f45d1cf-6ba37c7bebdmr666829a12.1.1795136845436; Thu, 19
 Nov 2026 17:07:25 -0800 (PST)
Date: Fri, 20 Nov 2026 01:06:52 +0000
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
Message-ID: <20261120010655.467825-23-lrizzo@google.com>
Subject: [RFC PATCH v3 22/25] net/libeth: Use GFP_KERNEL when pre-filling RX rings
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

libeth_rx_alloc() is called both when pre-filling RX fill queues in
process context (for indices 0 .. fq->count - 2, when buf->truesize is
still 0) and when refilling RX buffers from NAPI softirq.

Use GFP_KERNEL during the initial process-context ring fill so page_pool
and PISA page allocations (including set_memory_decrypted() under CoCo)
are not forced into GFP_ATOMIC context.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 include/net/libeth/rx.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 0e736846c5e8a..4361dbcf03cb1 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -106,10 +106,17 @@ void libeth_rx_fq_destroy(struct libeth_fq *fq);
 static inline dma_addr_t libeth_rx_alloc(const struct libeth_fq_fp *fq, u32 i)
 {
 	struct libeth_fqe *buf = &fq->fqes[i];
+	/* fq->fqes is zero-allocated and pre-filled in process context for
+	 * indices [0 .. fq->count - 2]; slot fq->count - 1 is first allocated
+	 * in NAPI. Use GFP_KERNEL for initial pre-fill and GFP_ATOMIC after.
+	 */
+	gfp_t gfp = (buf->truesize || i == fq->count - 1 || in_softirq()) ?
+		    GFP_ATOMIC : GFP_KERNEL;
 
 	buf->truesize = fq->truesize;
-	buf->netmem = page_pool_dev_alloc_netmem(fq->pp, &buf->offset,
-						 &buf->truesize);
+	buf->netmem = page_pool_alloc_netmem(fq->pp, &buf->offset,
+					     &buf->truesize,
+					     gfp | __GFP_NOWARN);
 	if (unlikely(!buf->netmem))
 		return DMA_MAPPING_ERROR;
 
-- 
2.56.1.809.ga0b61035b5-goog

