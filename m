Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30094FB9A6
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188411; cv=none; b=aIUZAQYlZ381II+T03/W8lO1rpfp/jXNuwSX+xgwcCXPIpbhuj2RcbxHrpk6qWl162XDWIsUrNZPUdzXRanXnbZigD4ISd5OvgiATCz7G2hbh/WwwWn2jId+nRdR7lTnYfORVYSn5ooxqlwmF0A0SXRS5BVDpxEX+Y59Iifwe3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188411; c=relaxed/simple;
	bh=+ofXmQ6aEwgY9wsAg+7EOB4x9r9B1VPmqlK+pXTFlrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syR4SLsBIGIVRuOanZIPsGPmBH9gBqINrPEgORR2s2VQAAFJIMelALAFs167N6S0p+k6I8JfrZI8nx5PKNwGLU0IIDIdow7+M13RKFjH0keaP2wZZjyVicR7Zjj402+3bCbuyyE/kqEOGk4FK68sIej27EZ5idBLRYUYgwT3lNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZHmmwZ55; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AcIrE/8o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZHmmwZ55";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AcIrE/8o"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETSMt3969243
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CZ0/AJS5lrL
	G+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=; b=ZHmmwZ55ZkWxUUGmJr6kRIKil/f
	olLP59mQRyaxFb4gJ9UAzYLH4//NXYQWlNIf+R043iOWSmX2VKC/nQ3hBvEdjjCR
	bpGG4SlGH9/6+VhDwY3i4npiEZ4eGAjZhNH8MAISVd4j1XjbN0Tw3nNlurDM7sOm
	LpTwpWBQALIrAbmeBY/F83cFUT523ZnKZXsWsLPAWR0klxXt32Hr240nTlk+BSIQ
	KFM+kd+sC7u+bVKncLCyrMTXCqsx4lMGY5lQ8bUax8KOkkCectd9CO67yLA2tHeL
	nxdgKKUK7Y9iR+UwBMkgbKZrI/kpyNOph2mz2QZQKhS8oz2wM/o4djz9I+Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6h91gxp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9375d92d8cdso640368585a.2
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188408; x=1788793208; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CZ0/AJS5lrLG+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=;
        b=AcIrE/8odcXCNR7288wccDPyeH6oE6uZvgPJLulkJEt/rGvIaYH4TpObk4hMQC8rmv
         3M6dnZctIUDXnReAUWebzu5b+4y0WV/M/9GlWgEya/kyORqUQVRB3fqcz1hewNQilGOY
         q2xTzPdxV5lxkhbD6FpYN0YzvZqJapZ7JJkDBowL32zgLeDtLf8ILO4/p4Vhu4zL1a6M
         yx0tGRb0nAHkIdNo2Df7XE8EsKSlR6ByGnqVPUjBN8IWYMrYyOLIspCtPnLjksVxB1lL
         7fo6xxk2gEhr9Xqmfznou0fwm1ExkjfLzxQZsb2ChiT8QcXiqPEIe27B3f/W4FKEvCeo
         xlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188408; x=1788793208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CZ0/AJS5lrLG+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=;
        b=N8LtFiLus9FrCEGSoMPE9Wu8cUNmAUaOunJb5ctVH3smhUNHBD9kL+t6VnSojEQPUx
         TEXHFxCflJ0Co73FnzEtI2GHMfLAK7Nx3fHBKIlsisn3+dLDyY9tTelxf91rHwXKSGsG
         l7VMlDaHUNTVnEEE2b36iR0Aer9VNjsvnlBCrawp72/8lYxG0t4FsMiCPBI/dXuECRHo
         gh3oZFyc2HynQXMFFMK4zeuY4516MPJ71Vq+2gTtITgOoqjlNfGfq9453dE01n3NKQVK
         Up6/WM7J59LLWO6PlU1RZfrvvUU7LijZ0fnKRimBu9p3vBvAFRST/qUwXKy9RyekQkoE
         m2Og==
X-Forwarded-Encrypted: i=1; AHgh+RrLZFA2ZOXacbjyqULAiCp/MqKDmb1ls0mwUST2mhsG5iFMPbAu4MMX78Ey69vVPHA6oJ1VgQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lHu5XFvdCv6FbTgXrBG/hVQ4KNLuHDyKTBSOX2iGiwrT52Jfca
	Zyps2HeD22mVsZ8yh7z81IP7gX9Rxd4cBGYhkUI4GWggInq6Gon5rRFYqr4owrUaZX2HxCHwRDT
	HixLkfnyftQZbAnHF/2s1d5U0j3agJt8JQpzMokahMk9n+BbISeIgTcQHQw==
X-Gm-Gg: AR+sD11TL8lzwen6QBoT1krTh3IImcaQ1maIh3KeNDDMiirJA2dChJfy7OV5r5uDa3G
	LBRTh4EDnZz67IGmWK/yAsM0ay/hylJRiY4bUTSfnWxJDZYcHr6b+qsm1u3Q4Nxj30oYJmH+Nvc
	0yY5MUr7ErecOJbJRwt/iFcu534lzUKOgzH5XPr2Qp6eFsq5oBkL/ranEDeP+KbF8kncsRyq9F3
	mCF9aZqsIF1Aj2/9Io4a3Xm4uWzB/Scx0NQRhEo0pUmcmlT6B445GaIZgXazU2XDwqudiZH07l8
	w7PK7eisLIJvaXOGclIGh6XQF1VsHeVzJrc5LitSmPMeoH5EyOWyGnW6LrxwiGMe+Gg/xLYGUvh
	AVBMQT+T087m16lZKtakowfHbkfUNscOKjPo=
X-Received: by 2002:a05:620a:aa15:b0:92e:8310:7369 with SMTP id af79cd13be357-9391398cfd0mr2651616785a.37.1788188407718;
        Mon, 31 Aug 2026 08:00:07 -0700 (PDT)
X-Received: by 2002:a05:620a:aa15:b0:92e:8310:7369 with SMTP id af79cd13be357-9391398cfd0mr2651604585a.37.1788188407117;
        Mon, 31 Aug 2026 08:00:07 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb32d30sm24100210f8f.34.2026.08.31.08.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:06 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 13/17] iommu/dma: Enable IOMMU_DMA for 64-bit RISC-V
Date: Mon, 31 Aug 2026 16:59:39 +0200
Message-ID: <20260831145943.313726-14-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W6UIkxWk c=1 sm=1 tr=0 ts=6a9596f8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=vvBRGx3AIC5YeKHJuXcA:9 a=NFOGd7dJGGMPyQGDc5-O:22
 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-ORIG-GUID: IR6HaXwlK_8hNDHRXyRxEIKRkrH-Jzuo
X-Proofpoint-GUID: IR6HaXwlK_8hNDHRXyRxEIKRkrH-Jzuo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXyazsypPWuONj
 5RYXI3m6f20wP5zPO2wPn9oKlr19iJG+QbooWnVLd1/vieYQK1CZlo/KtKCSy2pulTuZDBgX/DL
 qUOeKYu9QlAypIqUvUrmP0/D8pATtRo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXzuK/eqyQUR9N
 EDUCVGW24hKTT7cydmHXX5ijmmschtqmFd+YZ7N3hmsfv3TeW+qNigleWJ7t/5581hddn5r6oEG
 /sclKAKItTUZxcgyiJjsqqNYIsNwVcYOpzDsCpP61o4C9cG0ZyydPoF0mGNaLqxfCgYcKUliDbG
 6kqB4IkDX3T575XkWBIRUTQTO6Ypcg2Y3bCCxcgFtw9sVJT/KJedVX/SSNZPoiEakfHl8EoQgHS
 U5Yn37L6dQzPVWmZXHR/IeEdi2mkNj25j0qBZOfiW6jCdKnv/bVTPDb9vJYjwwIc5FPZVE5Hj/X
 MaEU39BnHTJqvWBLGn02OeIPupb/tvw950iLQ7ZrKRhjFitfPBDhVcMK/T23PhnQiG0j5LmfKw1
 WofER6Gh2eVidlHZAAIt6koBMWWRTS4/w2wZi1LHqBgvo4DlY6yOFYTz0MecoTYraMTMhuoBr0v
 nQH44Bsq/W1CE8/RuHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

From: Tomasz Jeznach <tomasz.jeznach@linux.dev>

Enable IOMMU_DMA for 64-bit RISC-V now that the RISC-V
IOMMU driver supports MSI remapping.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6e07bd69467a..1c9f2ad10f36 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -151,7 +151,7 @@ config OF_IOMMU
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
-	def_bool ARM64 || X86 || S390
+	def_bool ARM64 || X86 || S390 || (RISCV && 64BIT)
 	select DMA_OPS_HELPERS
 	select IOMMU_API
 	select IOMMU_IOVA
-- 
2.43.0

