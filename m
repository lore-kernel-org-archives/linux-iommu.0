Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6474C6EEF
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001378; cv=none; b=KFCTV+9OG9e4lWG0o2oZDB3Ec9oaliB4JBR1WYy35b3B91MvILIElSBHIDvGPalKz69bJCPKRMrY7wwMvikLn7MOtoM6PqmTZokHmkCy/SUWDcbm+eC+eEltl5lV3cZi2fbKw3ux6ShiJSLWfsYdJFl1eK4fD0GstYP3xPq5UCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001378; c=relaxed/simple;
	bh=3z4XGfcMy7XMqBY7hm2g5kKiNmSrO4d0V2K7Zt7b0eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lu4G+9pa60HLfQgbYFcULSwzIoSwNlOsUL6L8pX6Y7Ym9WU4ImACl886t2Y9M1A2T1T9Pozc9BfB8Fy81SZk1L5VvxoLJ0QJ+KEkxobwPS50YgvokA/gygKmi4MbxGeOP31SO4Z59ylhYB3UpzNT5VbuZ3wODNPoPniqN4mNqIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M6K9hwAd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aQhU1yn0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M6K9hwAd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aQhU1yn0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662E3I96670824
	for <iommu@lists.linux.dev>; Thu, 2 Jul 2026 14:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ub4zSgemoanhIjfpzZ3REv
	aC3GS2BQ2cg0OZ+TgSOUY=; b=M6K9hwAdt3NhdOrXuvY4lR1JD+h6K0UE22k5zj
	RXYnv8lOwLJ/g2oPkQqCmLaQoScYAw4tGWmbLy1MNdfRBmYvhvkBYn+k/C9S+/Pa
	RhXCIPpccA+10Z3rtQdvhT4XJS35BG3TJSZ98E9sta+/aBa4UwmOM5NPKi3XC5On
	v/twd0aUPQxcpFSzNnCIg0//vfykkRyEwKLDIWZvf25QmcjvEi7FBdIHV0bFl1La
	VwP2edckO6rJQdkKLHIhi05BrHjqprMeb0nIMhBkMpj0KDyDlvwS9WLGjT0H+Cq2
	esBa6YA246eo7S3CLCccb9IKcTNcCuJhZQPKDX35Ox5PzO0w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7na43a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 14:09:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37fbdbc4d03so985470a91.1
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 07:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783001374; x=1783606174; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub4zSgemoanhIjfpzZ3REvaC3GS2BQ2cg0OZ+TgSOUY=;
        b=aQhU1yn0dxr/etggCPtVFX7J1opiHKMbnI57GlSdQ0KVwkE0IxwyCK4giowvxbO35j
         q9fPwEzCNn4wruNV4BE4UVHmXZJB4C86Fs5OUycazGQpt1kzbKZq+CQtAIhzhAmodfsC
         8tUkkb4FL9sOg0RnAcaJ0Wl+p49/rbdzZn07NYh94FC9zVGhrvC5JbbOdf5tbbg48HTy
         Sp71idTH6jOSChuw5MFw9U+j7MGFcbAVS1QXutsmUQIa1kGTrCnGLg7enqkL0D7xTphl
         wR0UfP8SuBh32pa/o0y7SS+nKw+aLHPgNsiEZFcBpHF2+zDYRiZXlaPToY5BwaS0RzZV
         y/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783001374; x=1783606174;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ub4zSgemoanhIjfpzZ3REvaC3GS2BQ2cg0OZ+TgSOUY=;
        b=L0493/AEUO5RuS8/Ju5CO+mkaJ9cDJLoMCJIJLujW1MMi6LRIJVC+mGvOu2iVhISyA
         PztyKNJLVRIwFoK4N1tJJjs4OhXpgqFGgHuleW5xLqp+wSgAHts6SbpEv/n+kELQzQ5O
         JuLWtRT3s9L7Kt4mcduW3x0+FuMMuG0RB4hmD8IAMpQzMqWuasaVnleEA4jBe5ww4I2p
         j0sqN7zQznfrkSgAXIpp6be2sIBWVZBC7kYzZGfosEr32mSuHC8ypzdO3yBB/i86Uzge
         OOzaNuhybYBVj180Jzo1hAnCgcLVLHHZI/Tgb2W6/3epZLOCH69mgaTVvBpCUVCn/2MJ
         fGxg==
X-Gm-Message-State: AOJu0Ywezy0gRdj3E5iQAUV8bC/zRUNUob6Y6ikr/BM2j0MIJsgMGrLP
	BVchSeYslta1BhlALaQXTRjogNPz9rRD+2NXS1pxbTf93yP4PfYPMhXb7VfvqmFDSQ3EKEWGXi0
	25aZ3mYAaSEHulqPMyJk5OEBrpu+Bij+VMDIVnEo8eanjr/KSuP0RA3n5tA==
X-Gm-Gg: AfdE7clsURN32vrqVEXnYvftGK3ydXQIPNN48ipRHPJ3W6TrNkkupvP1TtC6vVE6feN
	ZxhD4P0moDtcrNw8h6BYP6WMf5zciktNCheJqb6x0tLbn63VBLJb7Oewonj91CAHccsQDVx2YEh
	y9z1TRmHpxXSwYNIAOD/uBYcfKvvdvWh+/zEsNKW7TO4UctL0YqQdkQC1kurzuP6pWXjbIUolbd
	9xrayUzCHj92EFcRLPjgOWh0K+vxQ2n/zAcSUD78xstAXCJc2UuJFr54O1yBISk9PvlXGgj06Uc
	H5oimuQhfg2Q/Kk5NxVEvxokmJRprxrW5RnLR2CcMYFUoJGDXlMIWuem4NOGnU8N0Yhc96K5QM1
	Uj9BtM/1mPoL/IgnfH9FfoUoqVgkWIPLEatZreyDH+Q==
X-Received: by 2002:a17:90a:da83:b0:380:9052:f4b9 with SMTP id 98e67ed59e1d1-381122ebe5amr57021a91.11.1783001374413;
        Thu, 02 Jul 2026 07:09:34 -0700 (PDT)
X-Received: by 2002:a17:90a:da83:b0:380:9052:f4b9 with SMTP id 98e67ed59e1d1-381122ebe5amr56973a91.11.1783001373904;
        Thu, 02 Jul 2026 07:09:33 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd223esm10345928eec.21.2026.07.02.07.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:09:33 -0700 (PDT)
From: bibek.patro@oss.qualcomm.com
Date: Thu, 02 Jul 2026 19:39:02 +0530
Subject: [PATCH v2] swiotlb: introduce Kconfig option for compile-time
 default pool size
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-swiotlb-v2-1-9205f3ba5408@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAP1wRmoC/2WNwQ6CMBBEf4Xs2RJaFBJP/ofh0NatrAGKXUAN6
 b9b8Ohlkpe8mVmBMRAynLMVAi7E5IcE6pCBbfVwR0G3xKAKVRWVrAW/yE+dEVbJk8XCqNLVkOw
 xoKP3vnRtfsyzeaCdtvpmtMSTD5/9apGb97+6SCGFNg6xdNodUV88c/6cdWd93+cpoIkxfgFbZ
 1I9twAAAA==
X-Change-ID: 20260617-swiotlb-c215ce0b23f7
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michael Kelley <mhklinux@outlook.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783001370; l=6208;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=kVEbuoWJCcNQDz8pvT3LfzliuBTEakiXdTZHRmvxfbg=;
 b=TQ45i30a++5Dd9N3bkXoBr5oGg9ldelzZ4IQwDdX7HiG6PCwv2Cr6Kyqn4DwEqQfH6FT8Pg5G
 hdDvJDaSHjLBrnmoej2Sq1ZwDjp6wUurEKuhsRjorRrJYhqcdH9OkR5
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0OCBTYWx0ZWRfXxUy4x0yGmsw3
 MqnWreJb4xWUEzWA1/Z8cDLUOPnOZoIMgZFso7DFs6QYxvq6IdZHCos/M9rZm7gKj1QfGlpRadc
 VLU/5LuNxBlDJK02vNr07d/JG13hDLgLpk9izt1PAcHKCDDooyW0c4YNxHpsVPI5rV10jmA6f5H
 r8X0mg3wPgGNzrUdq7VbhhCHIP8x1YiUclQBr0oSYlbhJC5ITn8F1newWOoDoiXsf72CeG6lrsM
 wjzN5C6ZBrPYez/4WPlfEd1RDmukkKni3WIcQmoUmzDGMpT2Xpy+he2T+ICEeUz3W0vmb92KP8E
 Ma5HpGNKHfjf+EBARIYlbq6tNdsu7lLs6/pXRnFq+NQ7tPybmMBRKeU/RsJAh2kis7vLxsgPq0h
 2eoBxH5ygwV+Pbrv4nOVoHDvBfZHmViOJPFNovYve+5DCV9+DtmHJ4DkZXJfvgh5sBO5IK0JJAL
 NAyDOVOCI5JR8lWNuig==
X-Proofpoint-ORIG-GUID: VSOC6uycXeN7GtT-OUGKEIDHqZkiFDKp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0OCBTYWx0ZWRfX0uJbNBCW6pyt
 TjGHN30TJ0E7H/14f5SnGxeRGuwwe7V7Iel0RQDoY33owi8b+fz0cs5fbzZ0t+kP97PatV1PWFa
 Ov55bDHOBsJxG4F3rCPYQzuBgEvyWdY=
X-Proofpoint-GUID: VSOC6uycXeN7GtT-OUGKEIDHqZkiFDKp
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a46711f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=07d9gI8wAAAA:8 a=ag1SF4gXAAAA:8
 a=hD80L64hAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=SP_X4jjkrvL9e0aunNoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=e2CUPOnPG4QKp8I52DXD:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020148

From: Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>

The SWIOTLB bounce buffer pool size is hardcoded at 64 MB via
IO_TLB_DEFAULT_SIZE with no compile-time knob to adjust it. On
memory-constrained embedded or mobile platforms equipped with a
hardware IOMMU (e.g., ARM SMMU) covering most DMA-capable devices,
reserving 64 MB at boot is unnecessarily wasteful — the SWIOTLB is
only exercised for devices that bypass the IOMMU or have restricted
DMA address ranges.

Introduce CONFIG_SWIOTLB_DEFAULT_SIZE_MB, an integer Kconfig option
(range 1–64 MB, default 64) that allows platforms to set a smaller
compile-time default. IO_TLB_DEFAULT_SIZE is updated to derive from
this value when CONFIG_SWIOTLB is enabled, preserving the existing
64 MB default when the option is not configured.

The runtime "swiotlb=<nslabs>" kernel parameter override remains
fully supported and takes precedence over the compile-time default.

Signed-off-by: Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>
Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
The SWIOTLB bounce buffer pool size is hardcoded at 64 MB. On
memory-constrained platforms with a hardware IOMMU (e.g., ARM SMMU),
this reservation is wasteful as SWIOTLB is only needed for devices
that bypass the IOMMU or have restricted DMA address ranges.

Introduce CONFIG_SWIOTLB_DEFAULT_SIZE_MB (range 1–64 MB, default 64)
to allow a smaller compile-time default. The runtime "swiotlb="
parameter override remains supported and takes precedence.

Before (default 64 MB):
  [    0.000000] software IO TLB: area num 8.
  [    0.000000] software IO TLB: mapped [mem 0x00000000fbfff000-0x00000000fffff000] (64MB)

After (CONFIG_SWIOTLB_DEFAULT_SIZE_MB=1, 8 CPUs):
  [    0.000000] software IO TLB: area num 8.
  [    0.000000] software IO TLB: SWIOTLB bounce buffer size roundup to 2MB
  [    0.000000] software IO TLB: mapped [mem 0x00000000ffdff000-0x00000000fffff000] (2MB)

After (CONFIG_SWIOTLB_DEFAULT_SIZE_MB=2, 8 CPUs):
  [    0.000000] software IO TLB: area num 8.
  [    0.000000] software IO TLB: mapped [mem 0x00000000ffdff000-0x00000000fffff000] (2MB)
---
Changes in v2:
- Fix incorrect boot log label in cover letter: the roundup message is
  produced by CONFIG_SWIOTLB_DEFAULT_SIZE_MB=1 (not =2) with 8 CPUs.
- Update Documentation/core-api/swiotlb.rst to mention
  CONFIG_SWIOTLB_DEFAULT_SIZE_MB as per Michael's suggestion.
- Link to v1: https://patch.msgid.link/20260617-swiotlb-v1-1-abfee3faf4ea@oss.qualcomm.com

To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
---
 Documentation/core-api/swiotlb.rst |  7 +++++--
 include/linux/swiotlb.h            |  8 ++++++--
 kernel/dma/Kconfig                 | 22 ++++++++++++++++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
index 9e0fe027dd3b..71b4e4c27eb5 100644
--- a/Documentation/core-api/swiotlb.rst
+++ b/Documentation/core-api/swiotlb.rst
@@ -140,8 +140,11 @@ Data structures concepts
 ------------------------
 Memory used for swiotlb bounce buffers is allocated from overall system memory
 as one or more "pools". The default pool is allocated during system boot with a
-default size of 64 MiB. The default pool size may be modified with the
-"swiotlb=" kernel boot line parameter. The default size may also be adjusted
+default size of 64 MiB, which can be changed at compile time via
+CONFIG_SWIOTLB_DEFAULT_SIZE_MB. The default pool size may also be
+modified at runtime with the "swiotlb=" kernel boot line parameter,
+which takes precedence over the compile-time default. The default size
+may also be adjusted
 due to other conditions, such as running in a CoCo VM, as described above. If
 CONFIG_SWIOTLB_DYNAMIC is enabled, additional pools may be allocated later in
 the life of the system. Each pool must be a contiguous range of physical
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..1665a9ce8f94 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -32,8 +32,12 @@ struct scatterlist;
 #define IO_TLB_SHIFT 11
 #define IO_TLB_SIZE (1 << IO_TLB_SHIFT)
 
-/* default to 64MB */
-#define IO_TLB_DEFAULT_SIZE (64UL<<20)
+/* compile-time default; overridable via CONFIG_SWIOTLB_DEFAULT_SIZE_MB */
+#ifdef CONFIG_SWIOTLB
+#define IO_TLB_DEFAULT_SIZE ((unsigned long)CONFIG_SWIOTLB_DEFAULT_SIZE_MB << 20)
+#else
+#define IO_TLB_DEFAULT_SIZE (64UL << 20)
+#endif
 
 unsigned long swiotlb_size_or_default(void);
 void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 0a4ba21a57a7..3830a63ae032 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -86,6 +86,28 @@ config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
 
+config SWIOTLB_DEFAULT_SIZE_MB
+	int "Default SWIOTLB bounce buffer size in MB"
+	depends on SWIOTLB
+	range 1 64
+	default 64
+	help
+	  Sets the default size of the software IO TLB (SWIOTLB) bounce buffer
+	  pool allocated at boot time. The default is 64 MB.
+
+	  On memory-constrained embedded or mobile platforms (e.g., those with
+	  a hardware IOMMU such as ARM SMMU covering most DMA-capable devices),
+	  a smaller value such as 4 or 8 MB may be sufficient. The SWIOTLB is
+	  then only needed for devices that bypass the IOMMU or have restricted
+	  DMA address ranges.
+
+	  The minimum allowed value is 1 MB. This compile-time default can be
+	  overridden at runtime using the "swiotlb=<nslabs>" kernel command line
+	  parameter. Refer to Documentation/admin-guide/kernel-parameters.txt
+	  for details.
+
+	  If unsure, leave at the default value of 64.
+
 config SWIOTLB_DYNAMIC
 	bool "Dynamic allocation of DMA bounce buffers"
 	default n

---
base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
change-id: 20260617-swiotlb-c215ce0b23f7

Best regards,
--  
Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

