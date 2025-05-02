Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CFF2517A4;
	Fri,  2 May 2025 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746186972; cv=none; b=SPc28mr4DiqIYj7Yr4Q7EofF4F7LOp1dke3133ifvjl0t0pWj9YWS9JguolaiPiXOZopZ1/EvkJfHr90A5SC0CSrLGKfhikWMVvrPTrkaHdbRVy6JjPJEV6x4NaMKl0f4eQiuipL67inoWLTD6DMR3ZlAkfkmlqDWSRuLfq5AZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746186972; c=relaxed/simple;
	bh=4qEqoKqvg+Xasg8DNYrixWeFQHuSwAzHyApDRtQCJ+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BefWA2ZMR/1/BSBrHNq85BQvOSXrOqmV2+ZNOHth7OJMmJKxUUwSwEQu6s5o/r4opMFSiiwePmHZgRyh2uQc2SoGWiXwydNSnpWEFCqpn7OMfFSWtVJCLhzjWPoEEbV4o/CdU9r+0QnFtfqBVUU+PQttQqM9oc/SDXOLQerHfO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 13:40:56 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Fri, 2 May 2025 13:40:56 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>
CC: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, John Ernberg
	<john.ernberg@actia.se>, "stable@kernel.org" <stable@kernel.org>
Subject: [PATCH 1/2] xen: swiotlb: Use swiotlb bouncing if kmalloc allocation
 demands it
Thread-Topic: [PATCH 1/2] xen: swiotlb: Use swiotlb bouncing if kmalloc
 allocation demands it
Thread-Index: AQHbu1cQNcuPrbmRHEK42QDjG7hf6w==
Date: Fri, 2 May 2025 11:40:55 +0000
Message-ID: <20250502114043.1968976-2-john.ernberg@actia.se>
References: <20250502114043.1968976-1-john.ernberg@actia.se>
In-Reply-To: <20250502114043.1968976-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
x-esetresult: clean, is OK
x-esetid: 37303A2956B14453667460
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Xen swiotlb support was missed when the patch set starting with
4ab5f8ec7d71 ("mm/slab: decouple ARCH_KMALLOC_MINALIGN from
ARCH_DMA_MINALIGN") was merged.

When running Xen on iMX8QXP, a SoC without IOMMU, the effect was that USB
transfers ended up corrupted when there was more than one URB inflight at
the same time.

Add a call to dma_kmalloc_needs_bounce() to make sure that allocations too
small for DMA get bounced via swiotlb.

Closes: https://lore.kernel.org/linux-usb/ab2776f0-b838-4cf6-a12a-c208eb6aa=
d59@actia.se/
Fixes: 4ab5f8ec7d71 ("mm/slab: decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA=
_MINALIGN")
Cc: stable@kernel.org # v6.5+
Signed-off-by: John Ernberg <john.ernberg@actia.se>

---

It's impossible to pick an exact fixes tag since this driver was missed
in the flagged patch set. I picked one I felt gave a decent enough picture
for someone coming across this later.
---
 drivers/xen/swiotlb-xen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 1f65795cf5d7..ef56a2500ed6 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -217,6 +217,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *d=
ev, struct page *page,
 	 * buffering it.
 	 */
 	if (dma_capable(dev, dev_addr, size, true) &&
+	    !dma_kmalloc_needs_bounce(dev, size, dir) &&
 	    !range_straddles_page_boundary(phys, size) &&
 		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
 		!is_swiotlb_force_bounce(dev))
--=20
2.49.0
