Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722F137B84
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 13:23:58 +0000 (UTC)
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4Qb9h71GgSzZB6mj;
	Tue,  6 Jun 2023 21:05:43 +0800 (CST)
Received: from a005.hihonor.com (10.68.18.24) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 6 Jun
 2023 21:05:45 +0800
Received: from a007.hihonor.com (10.68.22.31) by a005.hihonor.com
 (10.68.18.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 6 Jun
 2023 21:05:45 +0800
Received: from a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7]) by
 a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7%10]) with mapi id 15.02.1118.021;
 Tue, 6 Jun 2023 21:05:45 +0800
From: gaoxu <gaoxu2@hihonor.com>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>,
	yipengxiang <yipengxiang@hihonor.com>, "wangbintian(BintianWang)"
	<bintian.wang@hihonor.com>
Subject: [RESEND  PATCH] dma-remap: Use kvmalloc_array/kvfree for larger dma
 memory remap
Thread-Topic: [RESEND  PATCH] dma-remap: Use kvmalloc_array/kvfree for larger
 dma memory remap
Thread-Index: AdmYd4mQIRgJP4x9QqusZkCY0/hvWA==
Date: Tue, 6 Jun 2023 13:05:44 +0000
Message-ID: <3eb3b4b4b08c446591a3e25ba9fa7287@hihonor.com>
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
allocate 128KB mem.=20

Call trace:
[14977.928623] qcrosvm: page allocation failure: order:5, mode:0x40cc0
[14977.928638] dump_backtrace.cfi_jt+0x0/0x8
[14977.928647] dump_stack_lvl+0x80/0xb8
[14977.928652] warn_alloc+0x164/0x200
[14977.928657] __alloc_pages_slowpath+0x9f0/0xb4c
[14977.928660] __alloc_pages+0x21c/0x39c
[14977.928662] kmalloc_order+0x48/0x108
[14977.928666] kmalloc_order_trace+0x34/0x154
[14977.928668] __kmalloc+0x548/0x7e4
[14977.928673] dma_direct_alloc+0x11c/0x4f8
[14977.928678] dma_alloc_attrs+0xf4/0x138
[14977.928680] gh_vm_ioctl_set_fw_name+0x3c4/0x610 [gunyah]
[14977.928698] gh_vm_ioctl+0x90/0x14c [gunyah]
[14977.928705] __arm64_sys_ioctl+0x184/0x210

work around by doing kvmalloc_array instead.

Signed-off-by: Gao Xu <gaoxu2@hihonor.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
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


