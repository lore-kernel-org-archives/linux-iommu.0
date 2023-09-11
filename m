Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4DD523B
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 10:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1694428451;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vr7M0lJDP6Yqe/QM1nLbUlF67hKLZvdZZflgFleV6io=;
  b=Exy/FC7zV+JfeRemiJ9ziqhi/46wAzulN4pXNccRQ9sT+nr1IvLEhhHJ
   rG4TofBlGq0TXI6FnOqQNOsDBFghkpGBmWlfT8y7gp/+kMURI3XQx81LY
   MTM4xu+K3X1z1Rj/gy+UhhaZo+VD8utL0L2Vt+w+ZU3zCZdYEGTwmRB21
   0=;
X-CSE-ConnectionGUID: f32WsORCRIiO4z3zlOcPDw==
X-CSE-MsgGUID: iUDnIAWSSES1TKydEgDDRw==
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 121511210
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:rOyfHqB1Jm9rqBVW/8njw5YqxClBgxIJ4kV8jS/XYbTApDxw0mMPz
 2VKWzjQbKmKamDyfd5zPY2w/U8P657UztBrQQY4rX1jcSlH+JHPbTi7wuUcHAvJd5GeExg3h
 yk6QoOdRCzhZiaE/n9BCpC48D8kk/nOH+KgYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbCRMscpvlDs15K6p4GJB5gRlDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw9L0tPnppz
 9ciCTEqMgLYleaRy4qXVbw57igjBJGD0II3v3hhyXfSDOo8QICFSKLPjTNa9G5u3IYUR6+YP
 pdHL2M1N3wsYDUWUrsTIIg5h/zugnDwfidHoVaRjaE2/3LS3Ep6172F3N/9I4bTGJwMxB/Az
 o7A12XELhc7HeOk8he+q06Pl+Pikg/XYp1HQdVU8dY12QbOlwT/EiY+VFy+pOSRjk+lR8kZL
 00S5zpooaUsnGSrRdnVWwak5nKJ1jYZHcFCAvUg7x6Wyav8+A+cHXUCQXhKb9lOnNUxTz0sk
 FqUhcvpFBRmqrjTQnWYnp+MoC+ofzQYNmYYZCxCQBsZy9n+qZ4+j1TESdMLOLSyhNDvBTa22
 DmRtzUWh6gaksMKka68+Dj6bymE/8aTCFRvv0OOAzzjt1kiDGK4W2C2wVaAt8lbC7yydHiAm
 yQWwNqay+s2IY7YwURhX94xNL2u4v+ENhjVjlhuA4Qt+lyRxpKzQWxDyGogfRk0a67obResO
 RaO4l0JuPe/KVPwNcdKj5SN59PGJEQKPfDsTbjqY9VHefCdnyfXrXg1NSZ8M40A+XXAcJ3T2
 7/BIa5A7l5AU8yLKQZaoM9EitcWKtgWnz+7eHwC503PPUCiTHCUU6wZF1CFc/o06qiJyC2Mr
 YcDbpLTl0UHC7GmCsUyzWL1BQpaRZTcLcqqw/G7i8bZelY2cI3fI6C5LUwdl3xNwP0Oy7agE
 oCVUU5E0lvv7UAr2i3TAk2PnIjHBM4lxVpiZHxEALpd8yR7CWpZxPtFJsRfkHhO3LAL8MOYu
 NFcIpjQWaQSFG6Wk9nfBLGkxLFfmN2QrVrmF0KYjPIXJvaMmyShFgfYQzbS
IronPort-HdrOrdr: A9a23:LU4loqNQDwN3ZMBcT2T155DYdb4zR+YMi2TDiHoedfUFSKOlfp
 6V8Mjy1XfP+U4ssRYb6KG90ci7MA3hHPtOgLX5Uo3SJjUOhlHYeb2KgbGSpQEJ9UXFh79gPY
 kJSdksNDTbNykksS7CiDPIQ+rJKrG8gfKVbJ7lvilQpGJRGt5dBmVCe3um+xZNNVV77PMCff
 L2jKcm1lnQHQVxUimiPAhhLqz+TvLw5cbbiHU9dmUaAWe1/EqVAH+TKWnD4v9IOAk/sovKxV
 K14TARq5/T+c2T+1v57Sv+/p5WkNzuxp9qA9GNsNEcLnHWhgOhdO1aKvS/VGRempDM1H8a1P
 335zswNcV67H3cOkuvpwH25gXm2DEyr1f/1F6xmxLY0I/EbQN/L/AEqZNScxPf5UZllsp7yr
 h302WQsIcSJQ/cnR76+8PDW3hR5wqJSEIZ4KwuZkFkIMUjgf5q3MMiFXpuYds99ffBmcEa+O
 oHNrCr2B8ZSyLeU5njhBgZ/DWdZAVHIv64eDl3hiXs6UkroJj3p3FomfD3vk1wvK7VGKM0rN
 gsZZ4Y5I2mCPVmIJ5VNaM6WMOyPGTGXBLLNwupUA/aPZBCAWvEr6j96K5d3pDyRLU4iKEqkJ
 D2S19As3UuEnieUfGm7dlw6xjIdn+2Wy/go/suoaRRi/nHXbLuBzeITksjpcumvpwkc4rmZ8
 o=
X-Talos-CUID: =?us-ascii?q?9a23=3ANXLMcGuciVKoNoA3zQL/HIKB6IsrKSfi11DqCHW?=
 =?us-ascii?q?ZCEE1WuaHTXibwI97xp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ARd74Ow/BigCI5RQBhRMfuPSQf8ZVz6KPIX82qrg?=
 =?us-ascii?q?94vWnJCBdNBuxtiviFw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.02,243,1688443200"; 
   d="scan'208";a="121511210"
From: Ross Lagerwall <ross.lagerwall@citrix.com>
To: <iommu@lists.linux.dev>
CC: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr Tesarik
	<petr.tesarik.ext@huawei.com>, Roberto Sassu <roberto.sassu@huawei.com>,
	"Ross Lagerwall" <ross.lagerwall@citrix.com>
Subject: [PATCH] swiotlb: Use the calculated number of areas
Date: Mon, 11 Sep 2023 11:32:51 +0100
Message-ID: <20230911103251.572558-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Commit 8ac04063354a ("swiotlb: reduce the number of areas to match
actual memory pool size") calculated the reduced number of areas in
swiotlb_init_remap() but didn't actually use the value. Replace usage of
default_nareas accordingly.

Fixes: 8ac04063354a ("swiotlb: reduce the number of areas to match actual memory pool size")
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---

Compile-tested only since I saw this just from code inspection.

 kernel/dma/swiotlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 394494a6b1f3..85dd94323b98 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -399,14 +399,13 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	}
 
 	mem->areas = memblock_alloc(array_size(sizeof(struct io_tlb_area),
-		default_nareas), SMP_CACHE_BYTES);
+		nareas), SMP_CACHE_BYTES);
 	if (!mem->areas) {
 		pr_warn("%s: Failed to allocate mem->areas.\n", __func__);
 		return;
 	}
 
-	swiotlb_init_io_tlb_pool(mem, __pa(tlb), nslabs, false,
-				 default_nareas);
+	swiotlb_init_io_tlb_pool(mem, __pa(tlb), nslabs, false, nareas);
 	add_mem_pool(&io_tlb_default_mem, mem);
 
 	if (flags & SWIOTLB_VERBOSE)
-- 
2.41.0

