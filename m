Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D404CEE57
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349459; cv=none; b=nSOlaw5XC7ncVJzlRo2LYcLbHoIGpEk6nxDSWmGrTXhb+s9cnxX0pFCJH67HKld0l+68jij/pXsyq9lSKuOFqENsz+au9Oy8LimR6miB/Ce0cTKRmAVLkO2h9kHzJKR6EJMwJqHMh9jdZofkGI1JH/wzZg5wqnBoxOoNzvCg+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349459; c=relaxed/simple;
	bh=cJcMpcWue0tAmVioc9fHOu5EeC9vix9jxfaM5HnEBOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXrOH6R51Tq5Xn0ZrUt2+vYAGjrIgdNvcc7xZfyDps4kKGZepa3Ntj8gAC1GIvvRL95bGrhqAUTEMqIk9dtZxpnSRL6x1ZDuWkJ5Ou0ZljCI6LqP9cE8ux450sLTqqIABys4Nb7cpJA2pPbj06jeSUpsAWtrr0RViikI8V1atNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gzTD1SEY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=McV8NJO0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gzTD1SEY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="McV8NJO0"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA4B1a609087
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3xarg699YR5
	/SqvbYoFXYGmxgwGbRGBZnCFwVETijPs=; b=gzTD1SEYiy6iWVfEbP1Ntu8OQkz
	qVfpWPguU7mCPxdC9d5JTSfCd2BU2ro3PJy3kNrCa+J/ZOJ26U2A39pVJ2YduSLo
	2/GtfeGbyKnqpd6jd6zQxbhWLMHxPfL4LIvl1Hj2aYlOhTOwMAsDSGmj7EAgdtnZ
	kbbAjQ1FijfAPLP19KodWXDywETZo6P2hFLQmWLQKC543tNNffNCw7SLLMyziOAu
	jBrtWJZTn/HHan999D3irKgq972v+r3pW1y56t42VtOwi2lkdHmIMIWKPpUlnX3t
	dZU7/JcDHfA5lSvnMP2dEqOEZ5npbGMtAPgqCUb+flMPhEKOh6Sm+tnGV2A==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvns18e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:26 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7a10c3de1baso781547137.2
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349446; x=1790954246; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3xarg699YR5/SqvbYoFXYGmxgwGbRGBZnCFwVETijPs=;
        b=McV8NJO0F3iaLnERZCzZIwbDsFSNj9Uu98haXuxvxeeO1SHxwVqVajaLV+q/f7eYnl
         lE0QZ4fdb7/U4vF4tooTe5YSg4ryZvczrPEvNkAPIM94KPgdjP55DNMVIdIL3F0TUZe/
         6ue0mcpgNN5LtT815BiNpR3Gp1RUju3U4o1nIuC6K7KMTPTjbYQL3HkicyvQdfOTl847
         QC1UJoKyMdsREjO00IFtlEQx9k6I+zo6kNifVN3BoaWk9+6BPQ+Cllddbv5MZbt+WuJJ
         6sZhfE6Hpst/mQLGwKaycGMo+uBW/1fZTI9pLfMm9wHKF4Sg6aTMz0XcvwHHNvYpRkNZ
         W49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349446; x=1790954246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3xarg699YR5/SqvbYoFXYGmxgwGbRGBZnCFwVETijPs=;
        b=fgvvbywlH9deXALaezQejDQVR6KlIdzc3FKqlAMD8lVXHfNAtm6s+UoBAjzCQjkQrZ
         /QVmUywbbEcldVTLMRZGQPeT/rFqP51Z+1CfOPtPpNx1kRJSCFfiNRFA6HiHgOREqjCN
         0/pZs4TeaE6l6MzWvePDpHq3MxQIpGUW7AFXc5W4rioW9HDlk8Rzcs4d/E6jxV+asT8T
         zep+Wa+ODYrsKlnqHGEPFvBOjaGQ9+NFBTLaKdPeoIfGcaCHEJMGfJCbWrzbC+VXNTl+
         yP7A0pTuEBiX5X6nk8lj4+yaX2itakbrtcd2yu3r1phRiyzLCC/L8Q7jO99nwKofARuk
         yZLA==
X-Forwarded-Encrypted: i=1; AKwUvBwdi0C623TXoCrCAaZfmkLfGW2pSNpOAMDvSeuDqrLaH/fYIORmK2EPuCFGFgbZV/yydSgcAw==@lists.linux.dev
X-Gm-Message-State: AFuF++kGemyu2jvcoZ3InrpDHGwBSD9tj3f32Ld6cpqgAUT+6AHVYhkB
	zm5zfIZ/Pql2zYNCNwOGkbvoBEVsnMp+R2VRBCSFqX5rHi3gu6JQ2SVjz1G4T5OQ4rU8w8j6PnY
	LYci5H1+B4fmddwurcNqtxmnrMZwRDFtYJmNbSPxzKJSi+ClFYMqP2ycFiw==
X-Gm-Gg: AYBFou0ciTO9MQ3ChSAZWJPbvxYSglQFFyFDZCiCPZt2G5f5NZa8sM2KDRFlt3WI1Gb
	R/fqJJQjS/nlLH3kzMRyHIFOR+Jw8umhcyNYOxqTBKPBeGHq6qaTUyXRxBQZkLzVT8TgX0hLt3i
	UIWC74HSAVizSVIuSB9OKHbtO8Z3w/eYqudBsL/IY7S1OPpJIFWu6qdRTgaTyd6jiqDdzgLRWq4
	kHCwHwBUCnPhzq2YUzorDgINgUpgJPQhvb5ynovhsFPxSHPgg1czHLvwMzdXfLTMquBDunZE4Y6
	irRsATDlDghYhHSfFq/8MaS+HVAHWeUJ7pOM0flStmX8bUGK2vswfL1MX0LeDzep/C+HxqkmS0w
	yk65V0aJii56PdkoGR/iDoz4o+HIq7x+sbc5Zmg==
X-Received: by 2002:a05:6102:8092:b0:7a1:3d97:fa91 with SMTP id ada2fe7eead31-7af1b96bb69mr2829764137.4.1790349445679;
        Fri, 25 Sep 2026 08:17:25 -0700 (PDT)
X-Received: by 2002:a05:6102:8092:b0:7a1:3d97:fa91 with SMTP id ada2fe7eead31-7af1b96bb69mr2829749137.4.1790349445137;
        Fri, 25 Sep 2026 08:17:25 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a648895sm7632913f8f.28.2026.09.25.08.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:24 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 12/16] iommu/dma: Enable IOMMU_DMA for 64-bit RISC-V
Date: Fri, 25 Sep 2026 17:16:55 +0200
Message-ID: <20260925151659.419512-13-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DtW0NCEFKSvlTeQ74UwVPhuaZJue4I2V
X-Proofpoint-GUID: DtW0NCEFKSvlTeQ74UwVPhuaZJue4I2V
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX3nOKMJhOhD4A
 K0AdT0km/IB4tto4KUxAWg2IFklrufCgUCJvHLA4YoYDzRF9qt/JxgenV2Soc2Y0+VCSx9dSAko
 MgGi9Tn+BrAWRs3PbDGDl640PO4gli4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXwHo/Wncn+ZF6
 duhAd7ha//cDvwdjVtMvvPoobr++YcvR8clKhQpvMIO3jHcdFSuhTmu2kHzRDd133bYe1M9gVcK
 sZnZr3Vwhs/hWso6pyWIa6Ff7W+niVXUP4kV1bkCOb52gp6bVvXrBPwQ8FiaXHWX2KNed9Ldy23
 ACEz64f6hWIEMBytczEs850gk1fTsf13zeVZFNk4p4WX9xIuRptt5N48i+HGu+BiPvCOxhWzhMB
 Myka1QHVr+xVxv7EwEz6S1QAv87i6h6apzTDopVsNl/adw08+/0WNBGr3c01p5v0IPKlLUaMhrJ
 G+xfgKyepkRfEFmFpE8dxoUvCcaINvOYncVFaG7bdtL7Pz49u6KxTEGDyMaROD/de9VCvxlFoM+
 Caj/xJV9+0lJ5E3a6GmBwURJqNo/mf4z/I/lqvEMjL48q7k4c+pZ1HgUB0ZW7i+LrJnAzcveAc4
 WNHB5k8Hwe6taxAOrfw==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab69086 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=SRrdq9N9AAAA:8 a=vvBRGx3AIC5YeKHJuXcA:9
 a=gYDTvv6II1OnSo0itH1n:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250060

From: Tomasz Jeznach <tomasz.jeznach@linux.dev>

Enable IOMMU_DMA for 64-bit RISC-V now that the RISC-V
IOMMU driver supports MSI remapping.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 27954f462582..2d38d5b5accd 100644
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

