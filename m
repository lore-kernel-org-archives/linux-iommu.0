Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97915428462
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511012; cv=none; b=Mx6Cqi3E/qCJ0EnifXAynWgXR3t4uAyV1feMrZ9rEJXlFGVwHMkzNHFDY6zqlkt88U/UMCvH8GoWd8Ajx4/6b35n9LzbRSWFe9b/pOIaXcvPoRijytycgz2g7u5vJ+3ofkVrNkHjoeCRnEDdZX6qsEZlfZrcTc6WUq31447UJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511012; c=relaxed/simple;
	bh=cYBjM+6JUbUWk9wD+XnEhHPnVniDXVmsFcLu4IVx7Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQ2DpCKrOVL7Q40Hc6ZL7RDTzxeIVdETsd2kUHlLy2LBOHWkXE2gQmmObHBrkHRhKb/FdtbiIxMSGiSUMrgM8liWPZ3YBx1iWa8S/uazHiQpZpQJh1xvXrAwud78LdsYcF3R8Whf7oojMqKEAg0thU+LG26FlUjMASUdLT/I8cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=At+bgtaT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="At+bgtaT"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668BSrg52637355;
	Wed, 8 Jul 2026 11:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=n4xUiTW+CHf35eqdhEgJ3yXNSJuJIczfbeD
	Ax06fgzs=; b=At+bgtaTRxYXf9MG0a6cXwyNHiByzZcrokBGKodSYiMhTZ5AKd8
	7tybyX8G4HtjRTbVfH2r/SstLxk2HFYf4G2IpEs4K0HW3KISWdIcq/hVvo74Ovj5
	PEI+ov9mCfvwUSlfVvxCAl6IBCNXpBhPJmL1aGgb4F1jnLKHh8YiYU3NROu5rKwi
	Cw/NPe7ssfm2p2b4U4J2ycfDtcS5Hl1xqqUyPFzl1HcTAkaOafrsvLn3wOyUSjKM
	HTlD25yaoa1DQL7kd4UDX41qaNgbJ4pEPoeu85BlMa3fjeEV8mUzUU5Lk2H2krqs
	OVXLfVtmdlGgJQcaVOuoRFNHagqWbfaP8vA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd48dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 11:42:51 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 668Bgl4m017613;
	Wed, 8 Jul 2026 11:42:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4f6u8k3w6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 11:42:47 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 668Bgle7017604;
	Wed, 8 Jul 2026 11:42:47 GMT
Received: from blr-ubuntu-283-g06.qualcomm.com (blr-ubuntu-283-g06.qualcomm.com [10.131.30.181])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 668BglBG017602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 11:42:47 +0000 (GMT)
Received: by blr-ubuntu-283-g06.qualcomm.com (Postfix, from userid 4791667)
	id 0FE45411C9; Wed,  8 Jul 2026 17:12:46 +0530 (IST)
From: Aakarsh Jain <aakarsh.jain@oss.qualcomm.com>
To: m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: corbet@lwn.net, skhan@linuxfoundation.org, akpm@linux-foundation.org,
        bp@alien8.de, rdunlap@infradead.org, peterz@infradead.org,
        feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
        elver@google.com, enelsonmoore@gmail.com, kuba@kernel.org,
        lirongqing@baidu.com, ebiggers@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        aneesh.kumar@kernel.org, alexey.kardashevskiy@amd.com,
        thomas.lendacky@amd.com, jeff.hugo@oss.qualcomm.com,
        thanson@qti.qualcomm.com, Aakarsh Jain <aakarsh.jain@oss.qualcomm.com>
Subject: [RFC PATCH] x86/pci-dma: add "any" keyword to swiotlb= kernel parameter
Date: Wed,  8 Jul 2026 17:12:44 +0530
Message-ID: <20260708114244.246176-1-aakarsh.jain@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDExMyBTYWx0ZWRfX4TXkTMCQNiuF
 s4ndd9JyVmOylo1pK8PI17K9qR0KBwyTL8PJ7oc9kRUBBkYDDgnoX7sWlKFy0ziI0Uqb7uW4CUp
 UbDM6zc2JQh5G+kZ7fu5rO3elpedwOAHbw1UtUiLRoI2WZQ+NzHw3HLu8O49TEyWxNMbsNDkBSi
 5WnccKJCTZMZ1CEwC+0mOgGj3HzccFEkv3nlHGQxetbd9NmZMAeuV2cgLMqTLeAkdByOT0SN2wh
 uODTY8/fAMGxYoRoUmJ6fuqJavCX0fsRFX5JqU9NwM7YX/xcZ4ppRRlFlYhNC1sY6Gd2JkcV3Jb
 0Zc4VtUmys7lXJtXXf5n5MNEElKpdmzuafYBmt3jqnPbzaev5nAgr63QS1vdRfPKEQpfekRf4ql
 jq3BvKtQWmX5JfF3LThoOAyGbvf8HgypReus5lLWeLrdER3NK8jZvHyeTiBLPYjQ98tTgbsWQr0
 ChgburvucqNqSpbuM5Q==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4e37bb cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pVVJNHN2wY_hqiUAWGQA:9
X-Proofpoint-ORIG-GUID: HHQIIRUIrqTv45gud0z-RZEU5dA_wkyV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDExMyBTYWx0ZWRfX7lF2DFSCKL9L
 2UWIG92n/ORia1QNoi2jSlKGWRJZqVp/9qcPUptpXcJ6hMmzZqtkxPCJuRC60s0Z+vPqsa7N3sS
 7xcaCVbe0EYH5OekBimRjbpcu850jKE=
X-Proofpoint-GUID: HHQIIRUIrqTv45gud0z-RZEU5dA_wkyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080113

CoCo guests (AMD SEV-SNP, Intel TDX) require large swiotlb pools for
streaming DMA workloads such as high-speed NIC and AI accelerator
inference. The existing swiotlb pool allocator restricts placement to
low memory (below 4GB by default), capping usable pool size at ~1GB even
when a larger pool is requested via swiotlb=<nslabs>.

The SWIOTLB_ANY flag already exists to lift this restriction, and
swiotlb_init_remap() already handles it correctly via the flags
parameter (see CONFIG_SWIOTLB_DYNAMIC path: io_tlb_default_mem.phys_limit
is set to virt_to_phys(high_memory-1) when SWIOTLB_ANY is set).

However, there is no way to set SWIOTLB_ANY from the command line. The
only existing mechanism was via arch-specific code (e.g. powerpc SVM sets
SWIOTLB_ANY in pci_iommu_init). x86 CoCo guests have no such path.

After Aneesh  series ("dma-mapping: Track shared DMA state through
direct, pool and swiotlb paths", https://patchwork.kernel.org/project/linux-arm-kernel/cover/20260701054926.825925-1-aneesh.kumar@kernel.org/)
removes SWIOTLB_FORCE, x86 pci_swiotlb_detect() leaves x86_swiotlb_flags = 0 for
CoCo guests. The pool falls back to low memory and caps at ~1GB:

  Without "any": pool at 0x35a9c000 (~900MB, below 4GB boundary)
  With    "any": pool at 0x1df9c00000 (~120GB, anywhere in RAM)
  [Tested on AMD SEV-SNP guest, swiotlb=4194304]

Add "any" as a new keyword to the swiotlb= kernel parameter. This is an
explicit, opt-in mechanism that sets SWIOTLB_ANY for the default pool at
boot time, without touching any arch-specific code.

Devices with 32-bit DMA masks are not affected, they still use the normal
low-memory bounce buffer path. The "any" option is only meaningful for
workloads where all active DMA devices have 64-bit masks.

Signed-off-by: Aakarsh Jain <aakarsh.jain@oss.qualcomm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 ++++-
 kernel/dma/swiotlb.c                            | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..8a1fccbd9b25 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7477,7 +7477,7 @@ Kernel parameters
 			Execution Facility on pSeries.
 
 	swiotlb=	[ARM,PPC,MIPS,X86,S390,EARLY]
-			Format: { <int> [,<int>] | force | noforce }
+			Format: { <int> [,<int>] | force | noforce | any}
 			<int> -- Number of I/O TLB slabs
 			<int> -- Second integer after comma. Number of swiotlb
 				 areas with their own lock. Will be rounded up
@@ -7485,6 +7485,9 @@ Kernel parameters
 			force -- force using of bounce buffers even if they
 			         wouldn't be automatically used by the kernel
 			noforce -- Never use bounce buffers (for debugging)
+			any --  Allow the swiotlb pool to be placed anywhere in
+				system RAM, lifting the default low-memory (4GB)
+				restriction.
 
 	switches=	[HW,M68k,EARLY]
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1abd3e6146f4..34773ae7c770 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -80,6 +80,7 @@ struct io_tlb_slot {
 
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
+static unsigned int swiotlb_param_flags __initdata;
 
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 
@@ -198,6 +199,8 @@ setup_io_tlb_npages(char *str)
 		swiotlb_force_bounce = true;
 	else if (!strcmp(str, "noforce"))
 		swiotlb_force_disable = true;
+	else if (!strcmp(str, "any"))
+		swiotlb_param_flags |= SWIOTLB_ANY;
 
 	return 0;
 }
@@ -445,6 +448,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 
 	io_tlb_default_mem.force_bounce = swiotlb_force_bounce;
 
+	flags |= swiotlb_param_flags;
+
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	if (!remap)
 		io_tlb_default_mem.can_grow = true;
-- 
2.43.0

