Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F52AD0C
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774996234; cv=none; b=W5YUcH9bC7T1YvAUHazWjux6v7GDdyx77lQZcs57vIInwQopIaW5SLAsyN/VcCALmMDihJ8q13NIk3wO98N19qSc6BqY2LhKtpZVS0v/1UH/vbdxlpOPq1OGDncOpIjwbhXAYW0rDtwFlpZ4OnRhQ7qhFFWHyc4a7QMn1GmYXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774996234; c=relaxed/simple;
	bh=3F5hTAr3dNnsOQEA70YwfQx4srWxOYQ6cnkVeZQNl7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=InKjnmnJ8CxvEDFCUWgxeAU0RpbSzIySbp0n/PTePVa5ilB9DdGO5LN1Jh6MwMIQnZ6oTSBP8E5tg2lq+fP639XSyldHO5QzLL3jZ/cp4SFpckjIt551+IN50xieoluSmm84uSdv0/3y11LBN2BBYnQb3tRmWI+omT1XXEej1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AS9uxFxg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AS9uxFxg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VDjGWZ2879954;
	Tue, 31 Mar 2026 22:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=CMVP/9ZOXOYmJTk1EpvOMW/bvzKT
	JcSubSUjhS7p/fU=; b=AS9uxFxgLBe0RPLdIc5lb33B2BvPRQad79SfBxSb3sVX
	fMjdgX/vbjJloka1sc33Qc32+QAnfAaYicYQIOauvLTUCdTMLeyd9v1Dm3sVPjOA
	h/9ogP6Xw1BZoAEU85PwWFvuxf+eRAgPJhq+KdwZhuvzxydJgp44u/BiFo/hzhRa
	f/RRu1VYcB9/9OPNfqXg8PuwL8ZCzlnML+ztcMg5QztTVqut5IqpeokT26zK/bCB
	welTskFYLDbz8nAcC1bInVwzyExwAQjlF/eJw7//m8J4R9Q57OegfsiKe7WvDWKj
	DCso/OWZQsGWYooPOK1YT6C8m/b5ExOZ1YQsZWRedg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66q35k78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 22:30:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VJo9ii013919;
	Tue, 31 Mar 2026 22:30:27 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkk2sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 22:30:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VMUNKO57999852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 22:30:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52F4B58061;
	Tue, 31 Mar 2026 22:30:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 255215805E;
	Tue, 31 Mar 2026 22:30:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.241.75])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 22:30:23 +0000 (GMT)
From: Gaurav Batra <gbatra@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gaurav Batra <gbatra@linux.ibm.com>,
        =?UTF-8?q?Dan=20Hor=C3=A1k?= <dan@danny.cz>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH] powerpc/powernv/iommu: iommu incorrectly bypass DMA APIs
Date: Tue, 31 Mar 2026 17:30:22 -0500
Message-ID: <20260331223022.47488-1-gbatra@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _fFAo6qfGRaGlLCbBrYAdpr7fQd6ao8X
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=69cc4b05 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=e5mUnYsNAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=jgozE7b-QqKo_AkqVKQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: UOrbby6Wz-GXax-J-mH2U2QZrhg8FaZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDIxNiBTYWx0ZWRfX8nfxoPgPROHD
 D2OIuolOTwj00byMLOMSyr4zGMpIEEq2yist7uVhHBkZhhX/l+eZPG8h3s8mUhQG3NNxG1M8lti
 9IEB1DxlxMx/hAQZNxqoMZXfa7QVw07ZjZM4j6IfoGZKU1lvHfVO0TMMZDpJdHUnfd338qzbGKA
 r1a76NNkmJ+RsV8vbTAJjs+z6icLO8aO8v1NxFK9zakHOtQj2fiKIzS+C7T9cZARpvSuhb0EH8R
 k8gi9XMzPcy2m/TgNiojl92YtJ/ipgAcwE9jv9RpLACArHi/+xurtYMW8FT42ND8JuvUmlNfJRo
 D4eOX7tH49Ate2bsU61ookE+rbcJfQW8BDsPktVFrX2+Qeoowhqod/qtYHcakwOnVB2GdJwclpA
 Nxts8PawogyECoZ76ncQbePMS2X2JAl50zurYGHcUUy4zC7yBqxLGgx6R65T0nXhbN2gI951Zji
 dgE8QJ7x0mLR12QrG2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_05,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310216

In a PowerNV environment, for devices that supports DMA mask less than
64 bit but larger than 32 bits, iommu is incorrectly bypassing DMA
APIs while allocating and mapping buffers for DMA operations.

Devices are failing with ENOMEN during probe with the following messages

amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
amdgpu 0000:01:00.0:  4096M of VRAM memory ready
amdgpu 0000:01:00.0:  32570M of GTT memory ready.
amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
amdgpu 0000:01:00.0: (-12) create WB bo failed
amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
amdgpu 0000:01:00.0: Fatal error during GPU init
amdgpu 0000:01:00.0: finishing device.
amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
amdgpu 0000:01:00.0:  ttm finalized

Fixes: 1471c517cf7d ("powerpc/iommu: bypass DMA APIs for coherent allocations for pre-mapped memory")
Reported-by: Dan Horák <dan@danny.cz>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5039
Tested-by: Dan Horak <dan@danny.cz>
Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>
Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
---
 arch/powerpc/kernel/dma-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 73e10bd4d56d..8b4de508d2eb 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
 }
 bool arch_dma_alloc_direct(struct device *dev)
 {
-	if (dev->dma_ops_bypass)
+	if (dev->dma_ops_bypass && dev->bus_dma_limit)
 		return true;
 
 	return false;
@@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
 
 bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
 {
-	if (!dev->dma_ops_bypass)
+	if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
 		return false;
 
 	return is_direct_handle(dev, dma_handle);
-- 

I am working on testing the patch in an LPAR with AMDGPU. I will update the
results soon.
