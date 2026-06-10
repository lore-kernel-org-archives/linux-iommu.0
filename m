Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE23EFD21
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124301; cv=none; b=ltRT+eUg9u9OC64buhLqcHZB4PCqDEciBlMJKRTA3XC3sShDQRmjInVp/f49l6ZPVs5t/06Y9mwa8h08qglrrv3Q5WYPEyJQcLL2JcJ63cG0cYkg1eu++XJYImX42Ts3wwbzYBkmv3PfvcixtXZED0q3ylvm1BtHvSoEjrBLBI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124301; c=relaxed/simple;
	bh=R67AcRpblotU3L8crGoc2LVkZrZx3YT15sU7R96KHgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=juW7YhQt3DYv9k33wKiYnGvISWP4o+aIFBWU9WfR3SsQNg8h145f1n+uanzunibVy4C3ixuaalxao+mJjxH6TOKkItH8fxDE6Rh9Ulqd+onIF45xNztZ8Q04YZ4J+8kW967H7/Cuwq5NzqIDvLftlyVvo3rcYs/JJ+BVywF9qyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=FrOphyqj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="FrOphyqj"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJZ9VM1447728;
	Wed, 10 Jun 2026 13:44:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=OpTomHEXw1QzlpOeYK
	Rn9JzGdCmvTV1650ciQ/ve/Po=; b=FrOphyqjKcEOeC2wQviIU6pxTrjArtaIaS
	oN2phIgI/JhNs1sIk2f3vmsgXlwKcoaLCg86hcerWLGOvfnE3JiqlxmbSxpWEuul
	SGNMCF50Dh5Gv5C6doSLJNV6Q7MMRRu+rxBzgDeg3u+mlkR69AT7gSNw5VjbTB1s
	Ik85UJbi/qRg+T5nfFSm5WxRKlUbZ+zKhG+dddgVE3gYUmUjRkqUJapK1nQJ59Gi
	Z43ln8c1oufmEnoNdfQquC4cJM/4b7emuGB+jSeJX6SaLiJNcEzzxzOelj/FEo36
	1Eh8qSJa/fMb6SEXRDHYQQCHGB2099/sBXFeRAVY72C/o8/isTRQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe788ep8-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 10 Jun 2026 13:44:56 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 10 Jun 2026 20:44:54 +0000
From: Alex Mastro <amastro@fb.com>
Date: Wed, 10 Jun 2026 13:44:41 -0700
Subject: [PATCH] iommufd: Clarify IOAS_MAP_FILE dma-buf support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260610-tmp-v1-1-b8ccbf557391@fb.com>
X-B4-Tracking: v=1; b=H4sIALjMKWoC/yXMQQ5FMBRG4a3c/GNNWkSiW3kx0LrlSnjSIhKxd
 8HwDL5zInEUTrB0IvIuSf4zLJmM4Id27llJB0vIdV7pymi1TotyRe3qkr0JoURGWCIHOd7Lr/k
 6bW5kvz4U13UD4KGnMGcAAAA=
X-Change-ID: 20260610-tmp-b39b94ec1ff4
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        "Nicolin Chen" <nicolinc@nvidia.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Alex Mastro
	<amastro@fb.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: Mm7YS-qetCs5kko5-KHMXQs_Ay2thPiz
X-Proofpoint-GUID: Mm7YS-qetCs5kko5-KHMXQs_Ay2thPiz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE5NyBTYWx0ZWRfX6MyyBfl+1x/o
 KsXPt0UAW1f8QOcc15/OxRwON5pGReVS/B1IkVz4os3uUhdebDIHtKhTvphTDVqY26eMoxYxrgV
 uN9he3n8nTA2cTaRHwfATzcMj5OHNTC9kEwWUBiI3BO+aJGPV/8V6o9sc4vvGzdtKeoUdR0WZD3
 YFRfjnznUNsjD4dpEjVGQvMspr6CCg4fHc6u8ivFbk4ofDgDabOrwD/YsWuYrtZfmeXgktWISpe
 lysRDCw1gV8a+F7CzJbX0F852x0o2q5HIUOZgTCXksyi4RZiFrzuZ5NubFR7oad/XIwIs5aSIoo
 XJk5AxX8KYG4spiBikZYNRzD0vJZQd6iJ1jP78lvNX9QDhS2kIm0SmkWvEkLlUxC58gC2f17CQq
 u/fCCyM32UfDPO/oLWSvkMKbtydNEG3cc+MJnw09Z3xnvRuEPmzX3dBMFxV4BUFuKujUidLBKWE
 tQ6m7MpR3loyon6awuA==
X-Authority-Analysis: v=2.4 cv=L98theT8 c=1 sm=1 tr=0 ts=6a29ccc8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22 a=FOH2dFAWAAAA:8
 a=GWgnRoNsezHk-5W0228A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDE5NyBTYWx0ZWRfX3mrfgfoKnly3
 CfrI3hKkc3KvB7pALR0ng9/AGrSB6T3HQKySW8lSp3M+7zhvE/gnaIjsXISeeviXsRZlNALaK1E
 pI/jEDdi1D7j6F3AuQ/jt09PrbpU+30=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01

IOMMU_IOAS_MAP_FILE is documented as mapping a memfd, but the
implementation first tries to resolve the fd as a dma-buf and has a
special path for supported dma-buf exporters. In particular, VFIO PCI
dma-bufs exported through VFIO_DEVICE_FEATURE_DMA_BUF can be mapped when
they describe a single DMA range.

Update the UAPI comment so userspace understands that certain kinds of
dma-buf are supported in addition to memfd.

Fixes: 44ebaa1744fd ("iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE")
Signed-off-by: Alex Mastro <amastro@fb.com>
Assisted-by: Codex:gpt-5.5-high
---
 include/uapi/linux/iommufd.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index e998dfbd6960..0425d452d41e 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -224,13 +224,17 @@ struct iommu_ioas_map {
  * @size: sizeof(struct iommu_ioas_map_file)
  * @flags: same as for iommu_ioas_map
  * @ioas_id: same as for iommu_ioas_map
- * @fd: the memfd to map
- * @start: byte offset from start of file to map from
+ * @fd: the memfd or supported dma-buf file to map
+ * @start: byte offset from start of the file to map from
  * @length: same as for iommu_ioas_map
  * @iova: same as for iommu_ioas_map
  *
- * Set an IOVA mapping from a memfd file.  All other arguments and semantics
- * match those of IOMMU_IOAS_MAP.
+ * Set an IOVA mapping from a memfd file. On kernels with dma-buf support,
+ * supported dma-buf files may also be accepted. This is not a generic
+ * dma-buf import path; currently supported dma-bufs include single-range
+ * VFIO PCI dma-bufs exported through VFIO_DEVICE_FEATURE_DMA_BUF, and
+ * other dma-bufs may be rejected. All other arguments and semantics match
+ * those of IOMMU_IOAS_MAP.
  */
 struct iommu_ioas_map_file {
 	__u32 size;

---
base-commit: 61d525d96ade3367ce65e340b33aa2f1fd5a3602
change-id: 20260610-tmp-b39b94ec1ff4

Best regards,
--  
Alex Mastro <amastro@fb.com>

