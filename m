Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E7248124C
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787311269; cv=none; b=G41LvI/nNTKW6CwVtR1ZirAt7dtIYldpst3a/3D4+EOmuCCsqLrSBaXExOBaeARCvOf/JK31rvRKHpre71NbsMIUV7XnZrgXbJuf19b+IhWC0FGyETBLEBMWq41D3TXHchbnA/1r01nizyO4eGPvuZVH5VQbnK3kaS7tRhdNmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787311269; c=relaxed/simple;
	bh=2Ehhxr5sZt1etqrPz40lBO3pcztuZGvMX3uBN50/GPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGvMEzeuxSE5SekAzJ4DEZHQjitdx+5l0ov6pWOZ3fBZLpZ8Cd3+gOnHypjYXErjmp7kePSbaK4vhCkeBgfaj3TslmFUViL0nHOvm/vw7RlxwhTI/+hs3DvJna5ppKZoe7rDTcdiD8KDyv8Om6V/IZb0OnD0/q6JlT0Hu7SFQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ko5RYagc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GVquNeB7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ko5RYagc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GVquNeB7"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9Lt8P2006077
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5l6M9iiZG4HxQZx3hP6MptgfUIGjm2MZVOi
	Lw3ukGRs=; b=Ko5RYagcamr0fiRE24YDV9mACZ4Zdm2AG4zoj9AN9YsXNprSvts
	oqgVhhtXi9wpZop2/8RFRv4/mgH/He2KbRrvwa8ivXaO/6gWhcb024qveT2GsBTz
	ilRgPKGinggBaqRB22VIOHdAmUAIw1E2QHOPobFBT6OmKDYRxxNgMBD805B/d7FL
	F0eCjgFL9V8z6Ds+3iFd1cJvCKHVslII4SgSWe78cbAhgp/pGTI1PWENJ7iEoHXO
	M06JqjSeMQdcA1xwE7dZqInbbl9j84MmoCJCmogLPN4Ktg9aC2avRI47MfDJbGSa
	DN16eCnLRazRtRFLpf+sDfxURIOHCkQ9NVA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gddh9er-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 11:21:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e62e3459fso88963385a.0
        for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 04:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787311263; x=1787916063; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5l6M9iiZG4HxQZx3hP6MptgfUIGjm2MZVOiLw3ukGRs=;
        b=GVquNeB7KN+ETWT8xoFVHAX7yshFjduHyf7fkgA9cZHwYRP2X0zbvYQbr2zGCnVHiU
         +u9TIu4yf71oR9mrRM2MQnAkKZm5dUSC8OmTXp5PMK7S3mWj8PsaJqFLUONXLGvCjBLR
         7b4tbwqXIGzxvZZeW/iSV1ka4hRIvjByVMaXWG98zNLq1YB04F14JFLHR4r3RqHPe2eF
         qAhzJJp0Y6cjzL3jm/O0b2RnhBGOIGVR6rcTOu+hE2TTF/MfkBS80hD4BRdRAouP8lJm
         PCK8yEGbE+iRycbzNOlbjEzkCoekhIyL1T7kDF/sjXx3/Z0wwTIEgj3EKJ4ppOucFDFp
         3FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787311263; x=1787916063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5l6M9iiZG4HxQZx3hP6MptgfUIGjm2MZVOiLw3ukGRs=;
        b=p/baim7+7cVWKGgc6nyrvdbLdpFuLm+n6Q4qIEjWGBqg8dn8woFLgYC2xpu4iAEgBh
         feZsS5Gm3COiNGxyg1ZlXLBNTEmp68hvco0lCbr0qkeRvflwQkNKb4i/Y6QJwIWJ2z5I
         dNPV8LVQrDoptZdut5RN4jrW5dsva52GwH4DpDoT1zvOrjK2BI7DMdy20pVBKIHvBW7G
         +7v9IwyPn0RARYWnhPv/cu+9XGGiUuKXV7YPdkjj/srGq8/ZFn6Ut+KJKkP99eg0ez4R
         BvGmPbEYZxIkj2B8ILVA+zXzaOJ1mA5m25iFSrplxbRKOcrEZ8Y85akz+Mk6tgRp0Pjc
         ulPQ==
X-Gm-Message-State: AOJu0YwPE+Y2cUoww/re4XXFHptTY0y31VJspbH3hKpFohOleO92awf0
	RdFB+5/Dz8Fr7IGlwm4EQM46gORQT0i4nbSZfQ31q1EEzF7nNchzAf/U8F7bLBe5EYrWC/kPX/v
	t92t2lmGJ3gMTHU6albRiKdo2uy99paEVwmEjMZ7vWTmi3CFU1xWXofujjw7osnG4Vw==
X-Gm-Gg: AR+sD13zmkWXO17LAYi/nzMbPkCinV5gIv+Hjm4CRhUHvBG1B/AOWC9aZjvvEu7TFLl
	j+4Ma7SGrkjKrZcrgJ2Jm0m5zAwMtTYzULE9nSR6YU7PDoSge4qyoXp0mSUxXZAoUgwZHwtOIob
	Cl0nR3/+PQD8GwjoPM4y4OwaSzbhwdEw58r8VWi74I/TKi9bqu08aidVpLkokNmt2pzAkQ2+xkN
	h0F4H7lHBlU7cqe1mD7rhpc2GkwBkPw5tozmpDWqD/1mZEHEEzTT0uV/3ypFL64TZQQIr1CWCU/
	lLAJosbNRwrLaXg8biWYHf/ja/O8cL/OXauqthE9SMYxXUF2hmJKQzGQhuUTxYwkXpABEuAwVkO
	Dms7FEhbaPLhgTlDCavgrDqCWaaf221ZWkcc=
X-Received: by 2002:a05:620a:2b8e:b0:92e:f372:7b5b with SMTP id af79cd13be357-9373942f05bmr482727385a.10.1787311262845;
        Fri, 21 Aug 2026 04:21:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8e:b0:92e:f372:7b5b with SMTP id af79cd13be357-9373942f05bmr482721685a.10.1787311262450;
        Fri, 21 Aug 2026 04:21:02 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9b81602sm15837745e9.3.2026.08.21.04.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:21:01 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com, tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com
Subject: [PATCH] iommu/riscv: Report cache coherency capability
Date: Fri, 21 Aug 2026 13:21:00 +0200
Message-ID: <20260821112100.572037-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NSBTYWx0ZWRfX0hr84xiynq/j
 xejK0Ac3KFZi6e23WtKO8YADXlaqGfkOlappHBBY0mDXmK5F9V2ys2xqvSGSKJoy61QyOXIUYiQ
 689n7Ey9h+Vh97lzmJnaEzrTcy2Tn7k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NSBTYWx0ZWRfXzTXjYs9+XP+B
 hAelAmfk2m6XyctKA5zZBcRs6Ax7AAyf94TLfWe80CzQbiTCEJ/AkNR7/looiUmKY2Xlasmyjhm
 D7emGz6ykZ4lB7LOqm2wUbbisg/80sRCNDGP3M+Iu7f5Woqjd8/fGPkKuzaTLL/LVT6k+hklT+l
 cDee6QQIfbYlFPt/Ct33oMG4+J8SyWJW9u7qYJTFhhfO97i1w1bqWw7M9KfYPlIIALk8Y+8fYmI
 NZem4dtE64czG4jW82j+EwkUVj1A1sgxRe+V64v5xSqr+6xaC1N/2r310658vKN0IQDG+VnNXN3
 DQ89hvQt3IiySjWg4XmgUX6nYpwAVSzk1gAa6GiZSHzkPSRWe5aQgd/FluUZsq54FC/+9MY1hSn
 NJxnc+Eu9Jbgld/RfIkUsOKPN89h2AqfsPxbN5ZSvBkMIT+cldra9YvdkamSPRwVbftbDaDPZcg
 NahnGSlOi4RPlTNAoDw==
X-Authority-Analysis: v=2.4 cv=ApHeGu9P c=1 sm=1 tr=0 ts=6a8834a2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Ikd4Dj_1AAAA:8 a=ITBYzW_wA1tX7bdzKc4A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 2iGZ9VWEp-4F-dHA2wy2OfbU6-k0f1jN
X-Proofpoint-ORIG-GUID: 2iGZ9VWEp-4F-dHA2wy2OfbU6-k0f1jN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210085

VFIO and iommufd require IOMMU_CAP_CACHE_COHERENCY because they use
IOMMU_CACHE mappings and have no userspace cache-maintenance path.

RISC-V page tables preserve physical memory attributes for IOMMU_CACHE
mappings. Svpbmt marks mappings without IOMMU_CACHE as non-cacheable,
but preserving physical attributes cannot make a noncoherent device
path coherent.

Report the capability only for devices marked DMA coherent. This limits
userspace assignment to paths that can honor cacheable mappings.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/riscv/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 22cccc69bd2c..161093b1d9c5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -16,6 +16,7 @@
 #include <linux/acpi_rimt.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
+#include <linux/dma-map-ops.h>
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
@@ -1429,6 +1430,16 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
+static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return dev_is_dma_coherent(dev);
+	default:
+		return false;
+	}
+}
+
 static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -1520,6 +1531,7 @@ static void riscv_iommu_get_resv_regions(struct device *dev, struct list_head *h
 
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
+	.capable = riscv_iommu_capable,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
-- 
2.43.0

