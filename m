Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0632E54DC
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993821; cv=none; b=vETiUBaEq+Wp37iCsfI2ywqnU/fJYfQUBi3Ux3JSUIiZ4naS3gNHDbyMR9c8crgHPuf23kJaUeeXiiP4WqTHJkLI/e9o+UMnc6rNUelMMI5BsUsrU2zNVG6X+y9yD9s6l31JutGyQVb5aKAiVu9beQ9be14kjS97dzrapg6XvEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993821; c=relaxed/simple;
	bh=Jg6cutNa4wTuOT/R/PBaYwp8fpjwjRddjQ2/p/+s89Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b7vSIBdzOsgSXpEZ+zNZnboFBOR7TVpHsAQZ0xBOvrWGWvH2ihSAC8PsWa0dO1vb6AN+/3o6fwpyd7jzYrWhrAjP3/DTU/bnMy01q2r2mcLxNrdJVvbFfbxBxze+EYD+ewbVsqye+ZRqT2WNUEkazhPIQxHOPlDwkY47ByCTsBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iwiVprnC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iwiVprnC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAbc5017123
	for <iommu@lists.linux.dev>; Tue, 8 Jul 2025 16:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WUhkVAeGLeKaNSN8AVmxhb1CINCnyT16ePT
	Qp8qzBLo=; b=iwiVprnCBim/pwSuMC2ak0jO/SCNNEk1dfljlHQhWFV+RgIOSF4
	8x3VNb2cq8DoWzS89s3B6KkAcAl1ipKr3WKRXAIkHdGQpcQj3/jXijAW5hH5tWpG
	uBiRHMEW295kD/8BKmBk07afQsRghZbajQtd7fzdBoZwmUJpLqutx8nzlPtHxDPr
	bHOPEHbnJ25GctFoOxrFMhv1D1M/GunAJaav3VOwcTzCZyGe+sZ/JHjihnISRCEF
	l2ceBzAgFKx9WwXAr9gC+lpEzinunNt8OYtFgdfVfvzrLWEd0gVxB5eaEeXBLu05
	/k/Ek5M0xtlTYTnYlQMkttVxBHsyUcmIaqg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvtkqrnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 16:56:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2382607509fso25303715ad.3
        for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 09:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993818; x=1752598618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUhkVAeGLeKaNSN8AVmxhb1CINCnyT16ePTQp8qzBLo=;
        b=r06wOSwYqJ+Qwr5WGC7bcvl0F6zYEYu7u7plssvLJkWgK/1nGXT8ExMn9BeKyfhhaL
         ftqO8Ck9Zetlqni50/gZeY7x/kwMtdm+Dm8Mwu55l8tf4/6XdwJi/ddm5vgkvuj+kmka
         k38Vji5wNJvA8wdpfy65wcoXSvSDftuTtzzKifcG5lXz7rdEgv/mQBOD+hbXhhsMkBzS
         nre+a3lrnldo5tc71aw8A2AN9CClvUssPDbwySLWlPO1EOfs+A32eXcJTbnwLokY3Ssl
         CwZ0AiKKMXRn5q+wzbxSSh/sXoGBB0lbPW3EcxrRQWKr73WBhsD0cURfwElNH4kSpYE4
         39oA==
X-Forwarded-Encrypted: i=1; AJvYcCVBW6rMjOS5++KSN8flaKY/xnvoyfyvQ+40K3pKCqYqozKLo+MaVna6UXPE5yuHmB35u6JJNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPQGoLsSsXRAj5XELdx0Ue9jhqLZnloPjq5I79TcZJ5SZzo/8G
	b+bobLMpxHYGqwm0PO3C6zuDkBItdSemijc30ZmVw1JR4phW/349lXzEdFVPM8FLcREoi2Oe5pD
	tBRsqHpHPkC3QUPSYn/9FQh5qYtwgWzeo5qOGerd+t5TowahG75t5ilvG9Q==
X-Gm-Gg: ASbGncvAwr2ICtFN5EUzwNvMIhY8f5v8RY67WDHSYyO0rdukXr9nnfNM5vGGvPKwmKU
	OmpVFCyxRW0KK9pQLtmr7sbQQUq8allhSLnPkW3F5j6rBdeWbX22+QaPl50Z5VDg+DVPoG7ldMa
	LDyWIK97qT4D86oqDyW8Ym/orO0t2GXT/fht2ommxY0hU1nB1y+fbCxYaF3aBH9RqthzNHo+ZAK
	aTyE+9lE/N17kT+DMhZT4i6MwxxmrQhIAn6aPO/qKWLk7fUosSpvA45IrYcc8Dva13NYspzqNA2
	hfoYZYvaWrh5c23CkPFgIjDACVxRijQBLykjNK30lLWtossvxtlaMWWzY4XE22hKfmK23m1rTGL
	E5ZmpAAvQnw==
X-Received: by 2002:a17:903:2352:b0:234:bca7:292e with SMTP id d9443c01a7336-23dd982c7a1mr3703895ad.14.1751993818320;
        Tue, 08 Jul 2025 09:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZcNw1wDJD3D+XT0Ei373cW7Pc2/gf94PN0YMqeTOB1MGWQEUOYM3VpYyc41cGoWyfIaY6gg==
X-Received: by 2002:a17:903:2352:b0:234:bca7:292e with SMTP id d9443c01a7336-23dd982c7a1mr3703505ad.14.1751993817865;
        Tue, 08 Jul 2025 09:56:57 -0700 (PDT)
Received: from hu-obabatun-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431e4dasm124569365ad.30.2025.07.08.09.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:56:57 -0700 (PDT)
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
To: robh@kernel.org, m.szyprowski@samsung.com
Cc: saravanak@google.com, robin.murphy@arm.com, quic_obabatun@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, william.zhang@broadcom.com,
        kernel@oss.qualcomm.com, will@kernel.org, djakov@kernel.org,
        Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Subject: [PATCH] of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()
Date: Tue,  8 Jul 2025 09:56:27 -0700
Message-Id: <20250708165627.845295-1-oreoluwa.babatunde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0MyBTYWx0ZWRfX20acelQ1Pehu
 sAYq3yiTypNKOvTSGilmNdqiAujJsp9BMbMjTiAXieoPQ/tnJIXWq2s1ESBWS+4iEzbSiHw8FWW
 cns9gJUwd6u1DaflmjwGMgpdl94xWTyjjMr60IB/Zwn++rTKZw9cCSM9y7eJATikuleI8/CTK+6
 rHskv6NXzUbs9Pk7o8mKHnUSLpqxfMsto43YIJcRy4sy0iGfVGvgHE2YyNE5mYXyghaJwVOb2sT
 FzfZ1aFbZhk+ivzhN0FumkqxkJ58eD8l5iu6OXu8t7myl5vFsybcHeWFhnULNz9SCG3Q6sPjhEZ
 WBISjIHhcicg2TtSGMNef0ToU9nV/MusCO3WXbsZTTm9oW07IO2JALtG3hwVjj4OEhwMVOzTNqs
 U/HYbOtGHenN9htyZP9eRIbpo25F8nISx5dWXfIPnDyXK3UmYVEFXxPLIJWEu/r538v1s+0F
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=686d4ddb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=xFDPACk5BDkwkGjAhYwA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: I0bkXD3x1SXe4q6xEFZKXbSmTh0tG9Hg
X-Proofpoint-GUID: I0bkXD3x1SXe4q6xEFZKXbSmTh0tG9Hg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 mlxlogscore=761 impostorscore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080143

Restructure the call site for dma_contiguous_early_fixup() to
where the reserved_mem nodes are being parsed from the DT so that
dma_mmu_remap[] is populated before dma_contiguous_remap() is called.

Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
---
 drivers/of/of_reserved_mem.c | 14 +++++++++++---
 kernel/dma/contiguous.c      |  2 --
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 77016c0cc296..132d2c66cafc 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -25,6 +25,7 @@
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
 #include <linux/cma.h>
+#include <linux/dma-map-ops.h>
 
 #include "of_private.h"
 
@@ -175,13 +176,17 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
 		size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
-		if (size &&
-		    early_init_dt_reserve_memory(base, size, nomap) == 0)
+		if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
+			/* Architecture specific contiguous memory fixup. */
+			if (of_flat_dt_is_compatible(node, "shared-dma-pool"))
+				dma_contiguous_early_fixup(base, size);
+
 			pr_debug("Reserved memory: reserved region for node '%s': base %pa, size %lu MiB\n",
 				uname, &base, (unsigned long)(size / SZ_1M));
-		else
+		} else {
 			pr_err("Reserved memory: failed to reserve memory for node '%s': base %pa, size %lu MiB\n",
 			       uname, &base, (unsigned long)(size / SZ_1M));
+		}
 
 		len -= t_len;
 	}
@@ -472,6 +477,9 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
+	/* Architecture specific contiguous memory fixup. */
+	if (of_flat_dt_is_compatible(node, "shared-dma-pool"))
+		dma_contiguous_early_fixup(base, size);
 
 	/* Save region in the reserved_mem array */
 	fdt_reserved_mem_save_node(node, uname, base, size);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 8df0dfaaca18..9e5d63efe7c5 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -480,8 +480,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
 	}
-	/* Architecture specific contiguous memory fixup. */
-	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
 	if (default_cma)
 		dma_contiguous_default_area = cma;
-- 
2.34.1

