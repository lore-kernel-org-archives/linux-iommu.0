Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7B23D7D4;
	Fri, 27 Feb 2026 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198611; cv=none; b=r7cPWvHVT5cE01MV39RNtw7yAoqRBA+siGytsr+pCzib+1WZPmJpKLfPqnYEzquhFL8+1EkHeQ5Lwu/tAqF4LljxI0/yF9w7uQXPnV3tS1q8pQz7vbGPhbaPAw/3ldxvY40mRCpzA+z/SF1hziI4pqhnaBA13rZEN46m4jZN+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198611; c=relaxed/simple;
	bh=lF+i+xxz8lYHMRYmo1vByp6VuKj6IU9jz++U5QsC7WA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qworUcUPgqOqhQm+yMPHI5E/ej02Uk1O0pbTyS8HDmJvNqk9vzb3/hvehycFaudcX8GNbBNLzEnydvs6kyxXQJvfFQLQsS3S1EWCV0aiiKsj/FXoIlUZ2jHtdX7WoU4iKZxdX1QBcA0SwdFQKvqP6aaGUMnGTsYTRue8YVDapnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spNxsULn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spNxsULn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55AEC19423;
	Fri, 27 Feb 2026 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198611;
	bh=lF+i+xxz8lYHMRYmo1vByp6VuKj6IU9jz++U5QsC7WA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=spNxsULn1c97LGHfoREc9Ejotyp/5sCoG59B6vC9RQj+/XjyarKa3hGB3DhBOdIga
	 +5JqtltDrqUpLXSDXp5d86oY74y75IPN7C99GeFXPFuSIPAiKhJgqDrxZ3+/0VEwOZ
	 Ja3YeZ5oEl8o62bccbXR/JkUHa3HdJ1l+VGYZ58VawsDVE4RmqNF9w9OI9z8vW1P8y
	 WzVVYiJbR18F1kwzNOR3IzYTPFjx3TcyGETrFoJKiW+ilIQQLbyeAs1c2kyoTKJz34
	 +okLqmjo4XyyGZT7glMb0h+miMm7mt9S2PAqvdB2f8BQqzjLrL1WblPemNN+U+pe2y
	 z7sZua2/8u+9g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Feb 2026 14:15:44 +0100
Subject: [PATCH v2 5/9] mm: cma: Export cma_alloc and cma_release
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-dma-buf-heaps-as-modules-v2-5-454aee7e06cc@kernel.org>
References: <20260227-dma-buf-heaps-as-modules-v2-0-454aee7e06cc@kernel.org>
In-Reply-To: <20260227-dma-buf-heaps-as-modules-v2-0-454aee7e06cc@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, linux-mm@kvack.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lF+i+xxz8lYHMRYmo1vByp6VuKj6IU9jz++U5QsC7WA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkLZ+3UDXM3YsozKdlkntAT9Pi0ZKBI6evPP/JLvrfmT
 LVoLJreMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYSPpux4VxNT8HVPpFC/S0m
 TyYt9eWXbA5+9quamb1LatGC59G/5vVpNT8O/O01NaD3cv3045wbGOv9X2872SPgU7PmTpGz+pc
 7IfeFbaaf5F9e9J6jR7M59+jbn01b5n/OXc/gfsbv70qvt94A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The CMA dma-buf heap uses cma_alloc() and cma_release() to allocate and
free, respectively, its CMA buffers.

However, these functions are not exported. Since we want to turn the CMA
heap into a module, let's export them both.

Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 mm/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 94b5da468a7d719e5144d33b06bcc7619c0fbcc9..be142b473f3bd41b9c7d8ba4397f018f6993d962 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -949,10 +949,11 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	if (page)
 		set_pages_refcounted(page, count);
 
 	return page;
 }
+EXPORT_SYMBOL_GPL(cma_alloc);
 
 static struct cma_memrange *find_cma_memrange(struct cma *cma,
 		const struct page *pages, unsigned long count)
 {
 	struct cma_memrange *cmr = NULL;
@@ -1025,10 +1026,11 @@ bool cma_release(struct cma *cma, const struct page *pages,
 
 	__cma_release_frozen(cma, cmr, pages, count);
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(cma_release);
 
 bool cma_release_frozen(struct cma *cma, const struct page *pages,
 		unsigned long count)
 {
 	struct cma_memrange *cmr;

-- 
2.53.0

