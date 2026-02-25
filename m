Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F801917FB;
	Wed, 25 Feb 2026 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037729; cv=none; b=QVCiXdMRMDQ66S0tEVMyHYOPmcqNhqhFnhJgprt5V3PGFYRV/2K32PynWBQQR4HElwOtLgbdsNKeHUcHIgDx0Le2S9+sF8u4Ll9fh9yJ0w7YFovEu9ymEz9zurxlNvM+qvfKwqRJWAwJCQor787RLRdbVqDztcE6PLjZCPeMSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037729; c=relaxed/simple;
	bh=5t5YBl6F2Q9NBmrbuy0kWi5Y1JLcv4Ia1Fv2DnfmLP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I2ZPrbXaEFnRVAP9J2+f6n4DMlt9eL+vfgsAfgUmFoDzrZwucs7s1vGzp3p4q0xXk7ZNie0xFxjXANIbLaM9fU6ROsk4zYuEpUDPB4sJMwjpogoOnskAY/M4q2pu73EiFC2kTVslaKTmcyQDmKtTDKub3LHOHt48HnNpfcWWQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9SbsQH4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9SbsQH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C74C19422;
	Wed, 25 Feb 2026 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772037728;
	bh=5t5YBl6F2Q9NBmrbuy0kWi5Y1JLcv4Ia1Fv2DnfmLP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R9SbsQH4kO433LJbxIRQ9G2QyIvijqX+2UUdxf2AUxhpkZL8D/w1n1UnLOE5WcFHo
	 W7SnFVYG66c559MuvTJfU6g4OrKlyo7phg49rhhs6jppBjtf+u6SNVc8bIwsdjRrHB
	 ylDLpReT23aVYZp1JXVTm/ckzy/h9XZacpwGuWKcOCmiXOFiEPsdEnvbBV7C/HS/11
	 tT9zghsIuqAIhm8PKHKgLHVKNuAfAS3S1Z+unOmWa8txIeH9YgiZ92aP8lwlP+dvh9
	 KatmDuDrBKraDIZwCsQDrmLXCCpX4Tla0yk2aIZFbHV++fuiHkqFq2jlLL2kGuMjPS
	 iAIxksUcUg5Fw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 25 Feb 2026 17:41:52 +0100
Subject: [PATCH 4/7] mm: cma: Export dma_contiguous_default_area
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-dma-buf-heaps-as-modules-v1-4-2109225a090d@kernel.org>
References: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org>
In-Reply-To: <20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=mripard@kernel.org;
 h=from:subject:message-id; bh=5t5YBl6F2Q9NBmrbuy0kWi5Y1JLcv4Ia1Fv2DnfmLP0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnz1fwlD7HqzlzmFiUT9/locsXjSdPy5/duZv67Q2xH2
 cMJE172dExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJTJ/LWB/ps5DNXZhFfnPS
 0a/znj9cOXHb7Xz1BTOTd7PF+XT2KHwQvFN/ht8lk0Xkc/T6mR8KMxgbFu6MVBDJ9RL69WvG3mK
 ziocv1YyVTp6YUjW3Oe9TtvEBpZidmxSFCxta5F9+Vk6p4hUCAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The CMA dma-buf heap uses the dev_get_cma_area() inline function that
would either return the content of device.cma_area or the content of
dma_contiguous_default_area.

The latter holds a pointer to the default CMA region, and is stored in a
public variable. However, that variable isn't exported which prevents to
use dev_get_cma_area() in modules.

Since we want to turn the CMA heap into a module, let's export
dma_contiguous_default_area to allow modules to use dev_get_cma_area().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 kernel/dma/contiguous.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 14bd54fb758537f01a6fe27318e7b683964e20b1..fb64ccb99243e3cfea4890391a723130db69ee94 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -52,10 +52,11 @@
 #else
 #define CMA_SIZE_MBYTES 0
 #endif
 
 struct cma *dma_contiguous_default_area;
+EXPORT_SYMBOL_GPL(dma_contiguous_default_area);
 
 /*
  * Default global CMA area size can be defined in kernel's .config.
  * This is useful mainly for distro maintainers to create a kernel
  * that works correctly for most supported systems.

-- 
2.53.0

