Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04F242D64;
	Mon, 12 May 2025 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747034102; cv=none; b=Bsy5CBn7H1wiaXtskjewZncE+njcC1QCi2+LkTfet+Y9zGI0b/58B3pPPRTlQUrnKZ8Wc8ROlU1DMALmbgzeKHbQEG3EMnWMhA8UspfViB/akNsU5qXDpU0soI97o91Wjp9S03sMBiPmQ5cUmLTvS4PsFm3DjkJyfjUgCBudKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747034102; c=relaxed/simple;
	bh=Cbw+2lbNzTl44Wt8GRwA6T8D6WhEeQvbiA9InX1p4+I=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JDUGTSWile37nyv2+T/ZYfphsokRLYT45QXTYGmvP8rvmaA0HLKmlwvOU4Zx/uEjnsNZOHTigSAc6v6aYRjowvRMwZVzjfwue5ENzCRFbhts/8KrMSsMvcNUZbug7I7pWak25aaGbjuL4F0eVTnBUdCbK6FxzcEbpPhj7PjDAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 09:14:50 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.039; Mon, 12 May 2025 09:14:50 +0200
From: John Ernberg <john.ernberg@actia.se>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>
CC: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Christoph
 Hellwig" <hch@infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	John Ernberg <john.ernberg@actia.se>
Subject: [PATCH v2] xen: swiotlb: Wire up map_resource callback
Thread-Topic: [PATCH v2] xen: swiotlb: Wire up map_resource callback
Thread-Index: AQHbww2MQ91Fme3GEU6/lmK+Crf+Dw==
Date: Mon, 12 May 2025 07:14:50 +0000
Message-ID: <20250512071440.3726697-1-john.ernberg@actia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
x-esetresult: clean, is OK
x-esetid: 37303A2956B14453617466
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

When running Xen on iMX8QXP, an Arm SoC without IOMMU, DMA performed via
its eDMA v3 DMA engine fail with a mapping error.

The eDMA performs DMA between RAM and MMIO space, and it's the MMIO side
that cannot be mapped.

MMIO->RAM DMA access cannot be bounce buffered if it would straddle a page
boundary and on Xen the MMIO space is 1:1 mapped for Arm, and x86 PV Dom0.
Cases where MMIO space is not 1:1 mapped, such as x86 PVH Dom0, requires an
IOMMU present to deal with the mapping.

Considering the above the map_resource callback can just be wired to the
existing dma_direct_map_resource() function.

There is nothing to do for unmap so the unmap callback is not needed.

Signed-off-by: John Ernberg <john.ernberg@actia.se>

---

v2:
 - Just use dma_direct_map_resource() directly (Stefano Stabellini)
 - Incorporate some of the discussion and explanations from v1 into the
    commit message (Stefano, Christoph)
 - General English improvements in the commit message.
 - Just this patch now, 1/2 in the previous set was applied

v1: (series) https://lore.kernel.org/xen-devel/20250502114043.1968976-1-joh=
n.ernberg@actia.se/
---
 drivers/xen/swiotlb-xen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ef56a2500ed6..da1a7d3d377c 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -426,4 +426,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops =3D {
 	.alloc_pages_op =3D dma_common_alloc_pages,
 	.free_pages =3D dma_common_free_pages,
 	.max_mapping_size =3D swiotlb_max_mapping_size,
+	.map_resource =3D dma_direct_map_resource,
 };
--=20
2.49.0
