Received: from mta17.hihonor.com (mta17.hihonor.com [8.141.223.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC1D15B9
	for <iommu@lists.linux.dev>; Sat,  6 May 2023 07:40:00 +0000 (UTC)
Received: from a003.hihonor.com (unknown [10.68.18.8])
	by mta17.hihonor.com (SkyGuard) with ESMTPS id 4QCzlj45PyzCrrZ;
	Sat,  6 May 2023 15:32:17 +0800 (CST)
Received: from a007.hihonor.com (10.68.22.31) by a003.hihonor.com (10.68.18.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Sat, 6 May
 2023 15:33:34 +0800
Received: from a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7]) by
 a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7%10]) with mapi id 15.02.1118.021;
 Sat, 6 May 2023 15:33:34 +0800
From: gaoxu 00016977 <gaoxu2@hihonor.com>
To: "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "surenb@google.com" <surenb@google.com>,
	yipengxiang 00013268 <yipengxiang@hihonor.com>, wangbintian 00013160
	<bintian.wang@hihonor.com>, hanfeng 00012985 <feng.han@hihonor.com>
Subject: [PATCH] dma-remap: Use kvmalloc_array/kvfree for larger dma memory
 remap
Thread-Topic: [PATCH] dma-remap: Use kvmalloc_array/kvfree for larger dma
 memory remap
Thread-Index: Adl/7N1/zhRx438JTrqVRawCg6p65Q==
Date: Sat, 6 May 2023 07:33:33 +0000
Message-ID: <18448ae569e24dfd84e811081ede376f@hihonor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.164.11.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

If dma_direct_alloc() alloc memory in size of 64MB, the inner function
dma_common_contiguous_remap() will allocate 128KB memory by invoking=20
the function kmalloc_array(). and the kmalloc_array seems to fail to try to
allocate 128KB mem. work around by doing kvmalloc_array instead.

Signed-off-by: Gao Xu <gaoxu2@hihonor.com>
---
 kernel/dma/remap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c index b45266680..27596=
f3b4 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -43,13 +43,13 @@ void *dma_common_contiguous_remap(struct page *page, si=
ze_t size,
 	void *vaddr;
 	int i;
=20
-	pages =3D kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
+	pages =3D kvmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		return NULL;
 	for (i =3D 0; i < count; i++)
 		pages[i] =3D nth_page(page, i);
 	vaddr =3D vmap(pages, count, VM_DMA_COHERENT, prot);
-	kfree(pages);
+	kvfree(pages);
=20
 	return vaddr;
 }
--
2.17.1

