Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B362809
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124105; cv=none; b=fDMtozUSHK2lPXyZbxlFhI4+kbD4RNEvWzGdpa/qjl+cRixpOEGlv2B/+zEffszf1nKwg/gH5d7Zz4zCxOHn90H5BnP9wCYSmhwbAB7NMONLMkeVacsl4k0ZugQMfsw6ZhJPyo8WOKfKlKRB22xLTtTaJoZ2fziArsn8hWQ8j/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124105; c=relaxed/simple;
	bh=6CjXO5V0dFEIJ0NLzTCAryvwu1xsh0eAB12oETCo1Wo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fY8aOSXbVgNg5YOVLVRJCzw5C0uqAnR/3lTfS/YrPgR1H3j68DzcOG+9+/jPWic3nQaamdgDKnKk6Pjjx7MCKq8nnjaE7U8UzNciUGXLno+thQhbZFcQNEOmqEU54B+1ktFGiahcwc+RvNsRrTCeTLFEROI47u6eLyXvpBd18UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ml0yt601; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ml0yt601"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6473HX6I3059320;
	Wed, 6 May 2026 20:21:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=xmxWwBaG8
	aY9eZ5nONu3HL/L7rxspP0mF57gfOA5Arg=; b=ml0yt6018ya27ieqSFBx/FJUU
	YuluNLaExt22mg3jfA1bDmo/LaqCCBPguf2zZhhuCoh0e8lfDEtc0HuUYpS+r7iN
	iWTu24r0PQjmhBY1cdOAwBF740snJUXiDBAXaDAwZOZOP5uFkGAQ0zWll7jgAJpW
	El4fHBK5JQWf/c/6TBDKWOUc6et/S0T/DMg43GZM0gPtZ9FaqrYwlZsHxxFfwqfk
	2FL51CN34A9n/ic2vj3A/Iqda34VTKckDZxNjJqVix3afaORR7Cvuz9A9K4xN7i/
	UagzLPy41STv09ppw4e3Nq1rL1Eyect0bKuAtAfUyBrpHaAitUq93846AnPZw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dwchywsmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 06 May 2026 20:21:24 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 6 May 2026 20:21:23 -0700
Received: from pek-lpggp9.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 6 May 2026 20:21:21 -0700
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
To: <m.szyprowski@samsung.com>
CC: <robin.murphy@arm.com>, <leon@kernel.org>, <kbusch@kernel.org>,
        <jgg@ziepe.ca>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Subject: [PATCH] dma-mapping: remove bogus test for pfn_valid from dma_map_resource
Date: Thu, 7 May 2026 11:21:20 +0800
Message-ID: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAyOSBTYWx0ZWRfX2LHKRiS6AIK0
 T+p8BdNGwswetjsm7KGzxF0hqn3eiDlN/n2/ze/Nls9+IpAI1FdZ31gci4nvZnHmkS8NSjmrpXU
 ticW7QvraLcD4lewZxZbayezL+EfjpBs/TNAyP/VS5MMt9YhZTjgDcach/+ZUHTbXoeVjlf2PPC
 Z1aAAH8CDaLER5yZ2KIdXmrLsV09M4vFHK9z4hkegThGVrtZpdE2dsQtc+5LZSEiQ821mQwRg6N
 txZGFSl8l1qFRYT4ZMsvUkPl3E8mjlfh/0+CkpciW79E8bwe8ZAeW12DHt+eURYr9M3Iz2slOex
 xHtSeqAAhmR0dcOaCacKOD51anvkNAAMjpD4tZAmRFCPjvQvu9JIJPgbP05sLOD1HJJ0+Hy7q3N
 /VBoFsiOuKeVdWtpsyYnSIKVT7Lb6+XPxlxw0j0NzBjbSJU2tQwkf8/0TzLoUlHGCVazw+r4tWU
 pX5uwDfDOF+1CirbySA==
X-Proofpoint-ORIG-GUID: zwBmYozWhQ2glz4g6f4vCYsEZZsazMJw
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=69fc0534 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=6u_XfHm06m7VSS-ZnyoA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: zwBmYozWhQ2glz4g6f4vCYsEZZsazMJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070029

dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
However, pfn_valid() only checks for availability of the memory map for a
PFN but it does not ensure that the PFN is actually backed by RAM. On
ARM64 with SPARSEMEM (128MB section granularity), MMIO addresses that
share a section with RAM will falsely trigger the WARN_ON_ONCE.

This causes a WARNING on Raspberry Pi 4 during spi_bcm2835 probe because
the SPI FIFO register (0xfe204004) falls in the same sparsemem section as
the end of RAM (0xf8000000-0xfbffffff), both in section 31
(0xf8000000-0xffffffff).

The pfn_valid() check was originally removed by commit a9c38c5d267c
("dma-mapping: remove bogus test for pfn_valid from dma_map_resource")
but was accidentally re-introduced by commit f7326196a781
("dma-mapping: export new dma_*map_phys() interface") during the
refactoring of dma_map_resource() into a wrapper around dma_map_phys().

Drop the pfn_valid() test from dma_map_resource() again.

Fixes: f7326196a781 ("dma-mapping: export new dma_*map_phys() interface")
Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
---
Hi,

I found the WARNING in dma_map_resource() on Raspberry Pi 4 when using the
downstream kernel from https://github.com/raspberrypi/linux, which calls
dma_map_resource() in bcm2835-dma.c (mainline uses the physical address
directly instead).

Although mainline bcm2835-dma does not call dma_map_resource(), the bogus
pfn_valid() check can still affect any other driver that does, so it
should be removed again.

Thanks,
Jianpeng

 kernel/dma/mapping.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 23ed8eb9233e..e6b07f160d20 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -365,10 +365,6 @@ EXPORT_SYMBOL(dma_unmap_sg_attrs);
 dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
-	    WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
-		return DMA_MAPPING_ERROR;
-
 	return dma_map_phys(dev, phys_addr, size, dir, attrs | DMA_ATTR_MMIO);
 }
 EXPORT_SYMBOL(dma_map_resource);
-- 
2.54.0

