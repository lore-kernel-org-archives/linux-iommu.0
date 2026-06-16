Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83C33F583
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781645791; cv=none; b=meARh4yVICqTsHCJdJdU6/wfRD+eB85Cdkq2UoiyAMGsX3UG2N8nTuEkQip//e88hBMns0T7vrFCfd1SvAxE265eclxksOtBjymq8alcsRN51z36P6rG1OdJgC0DG0Yr87vhUQcBi5aCgs9BIdZszN5RxIHuQkaoveYCBPRv9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781645791; c=relaxed/simple;
	bh=dMAa0lMZQHy2xhe786esDuwgTFtUSFOG4b9Cn+RGMVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dy4Ea9FRtp0MrTTHjJeNw9m9vL0yM7mG3SxQQdrrA76OWC/NTheSsQKGq6REwRtgVnnzkk4XD0lF7ZIXmVuLMCkD0zuGtbFyp0zmN3Vvb0aN1ABj+kq/2FLMZukWNrpK2VQuB+ups1Ri/V99bQjdhhAvHLV/wik60P6WiO6xENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YLcv1NO0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rky0j1ha; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YLcv1NO0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rky0j1ha"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLTi9G769082
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 21:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UM/HZFMqB+zIF0jwzbcnZk
	JT4T2NJ0NDWIq/TcaFL/Q=; b=YLcv1NO07ha3D2aN6fh3fGAS2U5t9ZbMhWBQF6
	jx9f4v2bO8l0lpGbJlVMjFcrOwlpGN7l1sEo7uy5f/wkz6IZ2HoeRX+AG982m34M
	twOSAAPENEWFzy8JE6pcKHVEaC2E88QBETKcdUV2IfmsTi3RhFNMurn41KrTwPkN
	CqOS8mG2XYDYEAWVlxrpgqIHum463aRI7zLcl2z01EaYSKPKYdfeNoZTaSCmAFLg
	JUUJGtHzu0FvwvT++wBCHwCCafnc8ATU0UjdSY8wOQdV+OF6vAWeyADSDauydmpA
	7+5Qo4PxSqeechUvIPqYYFEy2mF5IBueP4i7ymHhxKjosYjw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueer810c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 21:36:28 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c6a3ece0d8so6822195ad.3
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781645788; x=1782250588; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UM/HZFMqB+zIF0jwzbcnZkJT4T2NJ0NDWIq/TcaFL/Q=;
        b=Rky0j1hap5c1pB7Fhgeb53cL8zzlti559JwbGMDMj1Pv0o9LvCmzEouQQ5lyI65R5W
         kSvcAHOsEFkvS64t7N/EimlIe9xZCfdbq1z4ji68St1E7Qvb4Hv9pecZZENYwGPqLh3I
         seh+XxPx+Pg4j5zp2FqpXHwIT/yLEiLYwWN1DQ376b1Pzj58B+lfgVx7UBoa0gCzH7zK
         TPEs5Tk/x5U990DHwPwKRPgDjGoGhToWFNb6RKe+JUIXUHUj+eeqmGfL6RpIZw3MBqye
         EnH2HJqwTwQ0VLCy1ZJVG88z978dv5zKCfKRzvRrqzt+T3TBTTvaaLiQLy4b9hANm6rl
         IB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781645788; x=1782250588;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM/HZFMqB+zIF0jwzbcnZkJT4T2NJ0NDWIq/TcaFL/Q=;
        b=X3MSuedThvVgpBODdqrwas+o3IHErY6ezWGRcUJZ6TDtgCWAxf44IqVD/JyOuXGJH4
         SEK68vxcgpK2zkV3Nrh8zryAkN8vAWij7m6seYk7M7nHWVYpwO54/r17QzQK5g4p8rpT
         M0nCah3K6yCXUxZGAYy94iHnig+yHTWrHXLBHxRwWcm2/3f8ESmzomZEtAh9k0sjMe+U
         vX0RKYLH3mqZyp8eWEIkj7WowLRBaxw47bRZYLkiOFO6OMh79RUf4ukOY1f2b0B0BFcN
         g7jDVod/NcWaRN2MG35woh9v2LNPJs1EOTtSv3vfagZBIe1zv21HeWM8eB7QhBBxPMEU
         TnRA==
X-Gm-Message-State: AOJu0YydVWc+Vn25XGs+7QEyoLrCVOfn/pmEol2wkZPBAHoFuVq/HCYE
	A+LQZ8vrJ52T1Og9uIBy45pSMyO4vtdCpJNadVA4AXqx3745pmgPvSxFZFIYh0M20o3kHKL5JB3
	+iirI+fTOeCHeHlOe2Ogu6C359MABgPiFlwLlpWFHbXY0FGNCfeZIBUrLvw==
X-Gm-Gg: Acq92OEXFLrBWcXcXnoaotYP3fILjkQYlrNTn4Cet8MwKR9nwmGt3dajJ69lki7m1xa
	ni+5fV2w/gY9CLZAxVb9Mhac51F0rIjjQVKEI0MYgfdez+LV5EA/zx3pO5KHWJK4bxJlCOQN3g9
	oDJmBF9qQMgEHEm+2vIEErVMBTCN+5DlwhPuK6fQlaAls9TSORTtyAtCwQzt3wMyb9eLQyySYt4
	pYJfebSWiZVhzWJ9+YX/DbbKZHCACSCYF2yv3Cp0254l3DsgOoxukSHu3o7OFfV+07bdqY2S1er
	SH9f4NBYuEUKO6BsEPOawddXQArpyFdqeA22mAwXhCAPa8knzQMzxKANcm/fzCysPQ8+y7IuxL3
	MNn9y2fSKW3ZpKIyEVpLesu1e0/vnaV5W57YZadEVuIpkFyj7YAkp
X-Received: by 2002:a17:902:d58a:b0:2b7:a350:463f with SMTP id d9443c01a7336-2c6bc0ac89cmr6838465ad.10.1781645787575;
        Tue, 16 Jun 2026 14:36:27 -0700 (PDT)
X-Received: by 2002:a17:902:d58a:b0:2b7:a350:463f with SMTP id d9443c01a7336-2c6bc0ac89cmr6838295ad.10.1781645787119;
        Tue, 16 Jun 2026 14:36:27 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb50e5sm144656455ad.35.2026.06.16.14.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 14:36:26 -0700 (PDT)
From: bibek.patro@oss.qualcomm.com
Date: Wed, 17 Jun 2026 03:06:14 +0530
Subject: [PATCH] swiotlb: introduce Kconfig option for compile-time default
 pool size
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-swiotlb-v1-1-abfee3faf4ea@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAM3BMWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0Nz3eLyzPySnCTdZCND0+RUgyQj4zRzJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAPGK9pZrAAAA
X-Change-ID: 20260617-swiotlb-c215ce0b23f7
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jpagadal@qti.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781645783; l=4160;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=biUpv0v/raB0ry81iTQUQsSlaCD7MoXOz2McxRdy54g=;
 b=Hpfq42ccEfgUhZtGglP5JBIqFZoTVat7MaEsWAoAp+Zv2ppEtKJtomn7XqEVXdnV0MYCt3PZY
 WBf5VSNoc7SBUpQzQPW/N5hCf13VQqrz+8rw6K4sFcUP1VWpJVQf6VD
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX4P1ijY/IOmzX
 vcnDHMKGfklFr8FgYR3Vzn/FJJ+fcTHoxGoP9QU2B+crcFg8Ih1bIdNIeV610veiAtk5/wFUlUm
 pU/QvuUDx6qJ4KbgyIymMmAA9WvuK+M=
X-Proofpoint-GUID: sz69aaZUe_NS9FyWtCNN3JrD2P3lHSSR
X-Authority-Analysis: v=2.4 cv=d4fFDxjE c=1 sm=1 tr=0 ts=6a31c1dc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=AkeLPVSRdpAbCyO8xMUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX6mVGBGSRg3Uy
 OwncXcYFPc08ACbAu3FaedBjnWFYKNIL3X/7PMDL3uBRUZampmaUCR0Kqcru2YDePi8rzrjsUAL
 kf20YBc9SOvitJGQo2YO2QFaU2vFlAV4mZ3C3LTo7+DSXyunPUr9pLM0LJ5MQio0zZLss2kmYRD
 QDzyDR0Kiwf6iUYdi1tYQcySHJZazx8PYvSn7vXiqJnAkMxkz+yUPETuA5I25UpW8+dD5uq8UC0
 X/j/PsZ0ze6AOoIK8fknPUV9vxCKhPZp4peARUWpodPYC7rVttqCg82aebRlkdtDI+LRdRBIMaw
 TyflQI88r7DhiErinNbmNqLOYrGFiNLugqXtRaemi69QAePaPIJjL3jXhcfzTp7oBamg6+gD/5D
 mCzgUi9kd3d3fpPnMb2JH3v299SfCmfEhRwDNa3lENzBU4PXvxp5jiyDox/Gl/xgTlGTBg4Hgtz
 1x9X5Q7ZtAVmEYXm+Tg==
X-Proofpoint-ORIG-GUID: sz69aaZUe_NS9FyWtCNN3JrD2P3lHSSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606160218

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

After (CONFIG_SWIOTLB_DEFAULT_SIZE_MB=2):
  [    0.000000] software IO TLB: area num 8.
  [    0.000000] software IO TLB: SWIOTLB bounce buffer size roundup to 2MB
  [    0.000000] software IO TLB: mapped [mem 0x00000000ffdff000-0x00000000fffff000] (2MB)
---
 include/linux/swiotlb.h |  8 ++++++--
 kernel/dma/Kconfig      | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

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

