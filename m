Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CD648AE1F
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262150; cv=none; b=LW4AJd8MJsoVKn3fclh5lFRzpubeUOIehWXfMsin0fnwpUjzbJJQ6HUEyINTrFCYGO+zV8LkZl2PsHMQFafxpYNxspAkoqPyl+wQZqrg62f93LMwtN5e8cdHLjutpsQkqnSMAO7ciYt1LGmnMQkdy59Ak3VEqIxEadIs6e3Z41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262150; c=relaxed/simple;
	bh=+ofXmQ6aEwgY9wsAg+7EOB4x9r9B1VPmqlK+pXTFlrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TM8BeHGPTFI/LF6HboM0aBYIYtPIXSQPmIkmQylI8WsPDpILVPjFCU0EybIWaTl6OHFuU73zdL86KlXq8xSiZHhmsUUYZyas/kraJHR4rAVgdQHOaecfR+S/MhuqJ/jJnGzvzbdtrpd78IxdoQWj/3AYkGTo/O4Z8SoFizfUuhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CUGAGgRv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xz7plWc5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CUGAGgRv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xz7plWc5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7ZTM4012743
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CZ0/AJS5lrL
	G+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=; b=CUGAGgRvFVy+df2FR2GudC7qDr3
	bZHSzh90yvdM3rp0QVughv4VFZw0WtjfCvl0u234UND7xjwECczTKPCrIsX27jaM
	/yAxMmvakFAmCv5oiZp4JoW8X8959By2B54htLcrkTEOQ8UTtkq6dNVVL4jUIu1c
	FJa9k7CKodfFHyCfPrsUttSqL2mf2J/H4RFxS+SF+sUTLxXJtD5bD53s5t46FLFA
	dN/9C3Hcvmz+MUzSEcFOLofMH1ZfjjJBk5pCn5sKlem2ZKvUifecT+ViQb1OXG62
	juVFwI65vGaZtB1p9fcfKtT3NIPatqstMresG+Ko3pKei8YUH7fPG6W4JrA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29keep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e8004d60eso56129985a.1
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262147; x=1787866947; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CZ0/AJS5lrLG+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=;
        b=Xz7plWc5onYn5Mr83tggFWyOCDvdaO/vgTOfjk9g5Cs1srv/oTd3KNAzjUc+Q+i7km
         qSvzMtzEOJDiUdedhjxAjVAaL8LiRfUIFpK/9MfWSRIvfB++CxogXTOatVGOCeRDM0qH
         zHRWjZi6zD6qk/sdXEGm6Mr6eTYlhrEYE4A/c8RZ+oZhkMKN3WwxgRwR0q8TfmgdGshW
         FDnr8MKqzyneXdR/VmdhoSMm79yyLjDn9ou/A90eFi1A9FaJbPs63cba8xbL/QhDIn7K
         xDdj3NT4N2A8RfIJhPf5nVWuc4PM82I/+AvM7dViYTfYPDRBgoD8IwKiuiTpGCnjHuEm
         A5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262147; x=1787866947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CZ0/AJS5lrLG+aHvu4+7DfuUzkXUVTyUzcLulD7cZ8k=;
        b=b7byeWlv3bQGopp8+iUx300b2gFm5whWdS3j0s/mgeUV3TA8aQMXM+YJEcekOXC+5i
         +IOJyqqUMbZ9jy8cqgDyFr1D8MNjgAEtoRhl+nSDFOwoY3yW5w0nNpmuBaR9epiVGSET
         74Lvvl0wFrxX6vlxzpG7dFD8bL/k/mXxz0szv6Vw0FMD0ww4Dtg2rWm+/OZGNDnbuYzG
         lcoCbyfe9brxZxBipQIgdPyCV8C5rw6rDDoQsPejub9tGePQtn7SUZ3LI8u0S5U1ZrBY
         uOLW+CKWvpw8bdJaQDGfmahql5pgow+Ld1a3/K42g02OEOhSYliwpFxDPRqHA5Lvt4oq
         25qA==
X-Forwarded-Encrypted: i=1; AHgh+Rou+NycYoYEYmWNi3E3qPD8CaY/Bh/ecwCeHIrxK9B3ScQOvDWos3Rg6gSmE7V0SRBZmGk9sw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj3r6ZcYMAMLEDiz04ii7tuVPxSlfg/cod+KObKGtuag32CW8W
	In/ICdupVNuAJIYnA4OeGEWtfkYxxWskby+P4eLfrz6nXfqG5KtvdWHfClXk4xWOpjrrwTe3phq
	U+V51deXBiXb1BiJtflM1PqFr5FwqMgWeegdkkodibWYCYE1MJcRJiX7SiA==
X-Gm-Gg: AR+sD11MwKzmeKyXcc2OGRd8/4iiZRxPSuPGfTAov9vTdrOZ+uv9u8z8k2Q+HP2EIrO
	z6PM3edWL+u+trdsTvWSxJm4uM+NCVxenMmGsS19uei1Ttg7h/T3ASOmPpx2afhwX2kPzMpVnEq
	OQZ2dCbA7OSwWL0W/o3Xgl8PLvCakfkx1neBahLGpvhgEuvn06Ah+Zkd+YLtjum2Dv+xu5DUsh0
	UZPjjPSMXn2Xxs1PX2o/4/X6+fRo6rpKOAyOLhWG8CVYT2GKEz067zAPZT8zuJQfHRhJ0dClCTB
	U1cLWOx6kt+Zn7BRZOu2bCyeXXfPJI8vB0nzF72xqs/+8oXNF49bvw6oArR3CXWFAGv5nrZS3Pf
	UOa+u+BbJ
X-Received: by 2002:a05:620a:2416:10b0:936:e18d:763d with SMTP id af79cd13be357-937394328ecmr108388985a.8.1787262146994;
        Thu, 20 Aug 2026 14:42:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2416:10b0:936:e18d:763d with SMTP id af79cd13be357-937394328ecmr108386385a.8.1787262146672;
        Thu, 20 Aug 2026 14:42:26 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450e54sm16782055f8f.11.2026.08.20.14.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:25 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 16/21] iommu/dma: Enable IOMMU_DMA for 64-bit RISC-V
Date: Thu, 20 Aug 2026 23:41:45 +0200
Message-ID: <20260820214150.545737-17-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3wh8epqyYB9serffY2wlnHuPpDcV_Uab
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a8774c3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=vvBRGx3AIC5YeKHJuXcA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX/7z6+yw8JzMD
 Uyfn9BzZJZ/URxePOrDsw7Zu4TrW2y5AiZPnNUVjfa42Zy2fc7TWtPp1Lb+tuHwEPDTtSTCuX9L
 eTDDdOc+ZM5ZSiHjsQXpngR3alVFCQuBwmD75G63GoIhZ1lwovrvc5H3FpmJP8uEISP3ZSc3547
 S1ol78CW5iUBXmKJWciCDlPeXg27SJ1g01LoAhmAFfAUsXfKhbvdgA0WF47C8q0t8NPvJP0hAjj
 hd1uDuXvt9O4jPSTrrR6aFJgoJxQBcJddSsC+ihREsY43UGoAv2/acg6sNdINz+pBKO61Nyzkvg
 hbGk7Nq5IhtejPk4ElEUvIQeQHey8/Ts3yKOUX7rC7QnYROeP4BPlxWAIR2736ZhqXyP8JXBXqm
 747KsGJ6MK/K/FXOkD0jY2b044brk6ddL5/Zob2mWo7SRRtzTNrtDZ9xMr6Yzj1NhqBa9A8U7hV
 8J9sahFoUHxxYq+1xGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX15xjyiSHXM1H
 3FWYG5a6r2L09tH2gbRdVGHsc/E5L+HNYaN7/ezDgrctmMPTx8EpSR7Q6e2egMXpGM0qWFl5Aim
 2M1E7yg/1WKsWzEL2OqBDouJGvkrFz0=
X-Proofpoint-GUID: 3wh8epqyYB9serffY2wlnHuPpDcV_Uab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

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

