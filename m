Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AE449641
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752882347; cv=none; b=jWwImPoqh06KMck3npwKEV4EN9CV2jJkNcwpi1l35z4WBDP7foEVjrpGyTsJ3m067xokgK5d0buBkUip1Bpdy8inyaGdDJ7WxlPEISF1057Rbwg8auod0TtB3Y6tkatl7H2PlHcRox8rsVPIMXWPRXssb9JhcSIbe80VKeBPS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752882347; c=relaxed/simple;
	bh=0QofGAQMlO59BDn/yqU3QVVC/RYdZi+Gp9Dmsqgt9no=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oz8Wb3KpU1ajbUHqk9tyM7zdi8RorwXsI8FOhpxLJVXSuhvGzfFjbE+C1bBL+0liJdsHUn5eASpBZO2IGP7YTiwUuYZJQHmTX+d84JhnLhY1rMtOOyfuJ0ySxjKExoWw19nom4O9tApJOuATjTFxmrAOOwCqxG1U5SXCABQLdmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bhqyBXRq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bhqyBXRq"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IH6QaV000543
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 23:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=s2hFRW8d2TuQIx351Ymt58JAKUkqRkGljpI
	9CEDds04=; b=bhqyBXRqUtfPDZYNBh98+vqUDh9jRs/az8ULa3WMqEBqXNLRZz+
	l1kik6UNgg8nXFJtzneh43bfY8YBrrWMTXyHonxY2JKNzDxf3q9Xa3qvHjZKZjFi
	YPh6jQRVLNVOb51s/TezaVqZT498BMZIYnSzkcxJFxpN7c9ESPwsEYz/9hXSoHq7
	bUSiyei4uBbSf0AHmRT5mpCk9hx2XCsgNX8tUUfa0aJ97DlHfN9koEacdx7BtGW9
	B9R7U94ODEzqTlddwl9hlb/Z73+FBd7YcIdeFoPiFNdh0Dn5+uB4+JW6zWUYjgCD
	WGumBI/xK1WqLhQUPTUd8Xr/Px1vdZMPfYg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5ds090v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 23:45:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3132e7266d3so2758532a91.2
        for <iommu@lists.linux.dev>; Fri, 18 Jul 2025 16:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752882343; x=1753487143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2hFRW8d2TuQIx351Ymt58JAKUkqRkGljpI9CEDds04=;
        b=rB2HHVdq0Uj1bvjtYzLjDCkJ7jHzbTBuBR0kH84B5gake5LvozmIwbGy/2PHUTR995
         Nur1UI3mrU25xtXET9NjPy9gf+RZUe/w1lJeRGq7na4So45hgZSQ3F4DW9scr02GouD8
         PRsCpJWdjhC3QCpZ5D7Ss8aj3qmsW3KhXY5YvbViD7MDr3bLZLkiKYdmbYdnMGhRHWom
         PR4kGrQrr4NVE77xF3p5Te60mLJDRbaQw4bQHDYohiGPkb9BvYCXcrqWTlbWGzXE5w3B
         RuWqkfNWTydF0doMDF/f8u3aZBmmX3+dN1QlxYjnvUdKU5M8aJoi1t1MT5o2eR+eEx/j
         kSwg==
X-Forwarded-Encrypted: i=1; AJvYcCVkRWYzhnAbxhJqTi+9D/CUJ4bw4MPcEuISGdLjxTv0EYTJV+P1ph1lUPMsv1nL48YKaflvcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo7AGHx2Sf3/Y2Z27VHQ/Ql2qjNo+Js4MIqPQ7puJB/M80cqZH
	kbobd6ml1v2eqO9hSBVCQnvRX1blK7Y+krYs8iaH4YSpV0upRhhDYYZVqtgqO1zDvAlDfAqIqPn
	pAJAkEIrXDY42438rm3ousbyL6TaKQkq5kS97B7KMG/NclIqabfvg8Pz5vg==
X-Gm-Gg: ASbGnctkn47n011ZtaXJs3gO4jOVFNdMBqsfTz8N/Gj5VtOcyPf38sFZKulEdgk29tM
	UMfQKQsPpbPJUnTdIdX44GoUVtQMXYzsRVOTxGI1fH8ddnrU5hXQxPutSKLP3zbbIumvT3fEwbz
	L5AT6xvlVS84mDGJGGWK88klDwWye1MlNjHI88eXTAeUA54imZX9utDbeb4aj5bqFNlt4YzY718
	2ZOZSyPE9+nf92mvIDWk7fjBLNbfIhTSXZ15ybA20pJPXEsEW80MGyHvUIPaa8SE5xEimG6Z6J/
	Dg5rX7Zz9P644hO5uOpdm3HwBGqOTU5Xi7Im6RxIIN21IUJUBzbnPSb1zAcdsXS9rvgg3zjdEzD
	GVWXVlkDZTJpP6flP3egmiR4s+9k=
X-Received: by 2002:a17:90b:4985:b0:311:ea13:2e63 with SMTP id 98e67ed59e1d1-31c9f47c919mr16443478a91.13.1752882343124;
        Fri, 18 Jul 2025 16:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqKxGq9Un3H1awITtkW+25JkbHdED47p+uP+qJy4C8O68xs8XewgumeJVAl/pe8tZ0gC+WEQ==
X-Received: by 2002:a17:90b:4985:b0:311:ea13:2e63 with SMTP id 98e67ed59e1d1-31c9f47c919mr16443441a91.13.1752882342583;
        Fri, 18 Jul 2025 16:45:42 -0700 (PDT)
Received: from hu-obabatun-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f29e424sm5975609a91.40.2025.07.18.16.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 16:45:41 -0700 (PDT)
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
To: robh@kernel.org, m.szyprowski@samsung.com, robin.murphy@arm.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, william.zhang@broadcom.com,
        kernel@oss.qualcomm.com, will@kernel.org, djakov@kernel.org,
        Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
Subject: [PATCH v2] of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()
Date: Fri, 18 Jul 2025 16:45:04 -0700
Message-Id: <20250718234504.2702128-1-oreoluwa.babatunde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qjL47gIGGCbFMfFF1BfO5nIPLBZBx26Q
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=687adca8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=d8epbNILfmFvmG3XuFMA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: qjL47gIGGCbFMfFF1BfO5nIPLBZBx26Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE5NyBTYWx0ZWRfX3vnRsAgyjBL+
 r2c2nekqImBwYlbMzVvpbW+9urVIFFgsxhStWrTmxQFodkTThSkJGtm9WgyNYiCgDp6+wPFBDcQ
 K1URyhRq0GNSgfCxfbnsG9hdp0NKEnbYj2oV3IvV/Z8oC8pzuvjIzOkrUkd/oEOJRItPrQybn6m
 rn4WG239QTaQPhqFXRw/gfodS3pM24l8Chjc1wP4NQNI1H1PBy9EQoq2d/O5CuBYRp5EM4GvspG
 6uCoPJLMkhDzuPkfLjOjcsOnbPn7ekBmZvqVFTPq773FUceSpKQOUjEBSIj6s0vO2kGlE+9IStk
 sVjXO37jZsXMN0kf2nim12xCgcN2orUpAHnFvWyNVJvfzd8HAU0x38OGv93glE0zCPAhpe3CEO0
 Tx6aaasSlDZ/mitXiSX9w5RKl5e7azxL01Vl5Zs5vO51zJ4zNFVmTgIFJT9n4ZdTdcF5XYXv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=678 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180197

Restructure the call site for dma_contiguous_early_fixup() to
where the reserved_mem nodes are being parsed from the DT so that
dma_mmu_remap[] is populated before dma_contiguous_remap() is called.

Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
---
v2: Add a check for the "reusable" property to narrow things down to
    only cma regions.
    Also add __weak function definition for dma_contiguous_early_fixup()
    to avoid compile errors on architectures that do not define the
    function.

 drivers/of/of_reserved_mem.c | 21 ++++++++++++++++++---
 kernel/dma/contiguous.c      |  2 --
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 77016c0cc296..eee96172883a 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -25,6 +25,7 @@
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
 #include <linux/cma.h>
+#include <linux/dma-map-ops.h>
 
 #include "of_private.h"
 
@@ -147,6 +148,11 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
 	return memblock_reserve(base, size);
 }
 
+void __weak
+dma_contiguous_early_fixup(phys_addr_t base, unsigned long size)
+{
+}
+
 /*
  * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
  */
@@ -175,13 +181,18 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
 		size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
-		if (size &&
-		    early_init_dt_reserve_memory(base, size, nomap) == 0)
+		if (size && early_init_dt_reserve_memory(base, size, nomap) == 0) {
+			/* Architecture specific contiguous memory fixup. */
+			if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
+			    of_get_flat_dt_prop(node, "reusable", NULL))
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
@@ -472,6 +483,10 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
+	/* Architecture specific contiguous memory fixup. */
+	if (of_flat_dt_is_compatible(node, "shared-dma-pool") &&
+	    of_get_flat_dt_prop(node, "reusable", NULL))
+		dma_contiguous_early_fixup(base, size);
 
 	/* Save region in the reserved_mem array */
 	fdt_reserved_mem_save_node(node, uname, base, size);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 67af8a55185d..d9b9dcba6ff7 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -483,8 +483,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
 	}
-	/* Architecture specific contiguous memory fixup. */
-	dma_contiguous_early_fixup(rmem->base, rmem->size);
 
 	if (default_cma)
 		dma_contiguous_default_area = cma;
-- 
2.34.1

