Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9930155757
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765326052; cv=none; b=mcPmUlMlnLrtW2ssC7dltMqzFgE7Xu3dnTGyGwydwf1EkDwZlgaTA9eGwW2n69V7vA0qKZAiZvtbqnYYZPXQwPgPRghWTMOFIAji2807kreIZrKnGxcbfGM6Goyz0l3+JTl5IHOGp7mseg3GgFde8XNuoLlEfiGAKNueFnmmlsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765326052; c=relaxed/simple;
	bh=XUl+IMz7uUvH+MqMl2CaE7dyPDinPOet1+hqUWGDeMA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GpHdO/R+Tk6DVziNAc1fw1PahbydljzVBUl6ViZkRGyxK3brssUr1/Z987afP9XEptYkXfw+kgUcweAc+yqrUMGIRgg6hW+04emjc2JDqs5SG8XcA+slcg/DviFWf/MfDmOWyUTYzCzAf6WCGTnx+8kaob0lLXb/IzlYGwLmTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Andc+qDx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DZErasJn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Andc+qDx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DZErasJn"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B9NIrGo362329
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 00:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iHBwA4IfSbfg57hhtkGLsS9PBLgMplwjUcX
	E/vuBD94=; b=Andc+qDxHSt0WG+VzJdUdL+Fg/tBG89vPh8M5YeWLUE9dxrtnQm
	hCYQB2GhvmoyKChwoKWoL1PXDQjU3XYeGx230eVf2whf2R8R90jGAc21bmJru4ZV
	YnZm9BwxfvxIo9uMmFzx8B0ymQhdvWtMtnaOd74HIGlZIpDF1QwYh+gLNni6pHZV
	ah+bqFu+uCKIKCssGpAmsXyFC7/Kxtpy9Y+NN+vVVlSJP5iEFg2VUqax+Nb/NyXj
	pHc8qnC9ZYIrM+OXr0CWPK71NkECp8NNgvsXD53pmQ2cc6qW19TKqs5OHp25u0m1
	kQX8DtQg77Co7XKf5b1XLYOiA2ju7OL2B0w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axp4vsmdn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 00:20:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-342701608e2so7096116a91.1
        for <iommu@lists.linux.dev>; Tue, 09 Dec 2025 16:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765326046; x=1765930846; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHBwA4IfSbfg57hhtkGLsS9PBLgMplwjUcXE/vuBD94=;
        b=DZErasJnTKBQ7ex7Wy5fRn31RCOEjUeaigQg9oTmBlp9vkvi13SsjBY2DKivv7F0H2
         ZNpt07GnEp8eJ1YSjQMjPcI0LPudKrailDLkoaVvioVApOx3x7f4bqQ2UDR151aoAQe7
         bsn9GrONqbgTBaLWrbU7S3njJYcqynZMdrIzHZcyWEqLLHkdoZQ4hTL4D7H/g/X+hxp0
         fFfDVUvNlG++o6bylAlUb16a3tXB34cfeLeYqByYkMivgRuqLNBNgYdva/2nzEgulik6
         J88BtkDHBSIm9YIQ16+mApcxOfC5GFtNd+nhkAqhCInn43+7suEZi//Mr1clJlMiBcTJ
         o0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765326046; x=1765930846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHBwA4IfSbfg57hhtkGLsS9PBLgMplwjUcXE/vuBD94=;
        b=c39S+2fTlJtEoN1RzHavdGlqkIsXHwG2BWsrQPiF7s5QBBdyWq/539IDTcaUsHv2tj
         rewgsoDRRG+oG+/w1C187v5J3/rEAowNZAppReFUDv2s7xwx8uTwi7p0CDt517TxKhjK
         oGz7NMZmxTg0lRebdHAp3pXbUYZWxtHgXvl+MrLPgCs3tG7FY5GbvX+M6sU7A/FSsMvK
         lvOXuHnCisJsifgM17RFf+l4IltLSDbSj5gwGMOvVaSzfXWTYzTiLUnIOjy56xPtvkUK
         Lb8PyjQBZo43dVT8XPDPJA6NjdIvLdKH+bNqUhoRMv3+rehOCKNQ+Ln2Q2njADbiD8uO
         Ud6w==
X-Forwarded-Encrypted: i=1; AJvYcCXk1TTXyEFNMwmEoZL5c/oyF6kffd58MeUcZ/HY6Ii4bLx9A4BLVk27VTTZx6y3KkWL+Y9PMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yznqvu7/JY7e7yP8LrgteZI06ajwe7dmHCbyWysJtZL8CtlwwQy
	WMue9ZLY3tO5hARK288a8+IR/mWlyeN/VLpYvrSn5D3CnvdmzEFLjUoXTAgjbu4YFa4yDMl25LO
	81BBFfXTYJKD64rODbtUHseFRsCiOWkR5xHD/TqZgxc0fTyGbz9JmbdxkhA==
X-Gm-Gg: ASbGncu25X/lcSovs/FbrXdqoKUWUTrvwx8cV3qKMkWWj5S3W+/vgMMWe7Ij7gkvG0j
	zmJ2d6Ct7Suiv9yU+XpRvmBw4kfjxOcrO6JdhY/ul0U2/EVvTJ2vYvjnjTJJZqYtRr9rwlWdz9x
	50o5bBAdiLhJcYgcDnt+KkcaRRkgEDa5CedoE6/OuY0LoHwNQyJH0+PvHbCdoy2lBsDfniTidQD
	YKA024cxC/FAsIBiPfc/TPkwYevxUMov4XZ81jpU4ksFi9ENsZ+etoic7FIpn04R6N8UOmlnjdX
	fSqc49rA/m6a38nbfaQrUADsA7R3wREXU9rRESCdURhzmZla5j8ZnxibBUhxuKpHoH8QpIhoBQY
	rABiq3+u+Ms6h9PGg2/kIqARr1LNWVWBbZ2rQXHFaDxNaTIUXTcdCZaJQnFSveRc9w9aKo8cU
X-Received: by 2002:a05:7022:62b:b0:11b:ade6:45a7 with SMTP id a92af1059eb24-11f2966a03emr425012c88.1.1765326046092;
        Tue, 09 Dec 2025 16:20:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcLj2nkg82c0xX0uwbx/GB/IwXsGaN8dBi7OsSisu2MU6g5avYy1Et2uoitaYLu9zbKsRD9w==
X-Received: by 2002:a05:7022:62b:b0:11b:ade6:45a7 with SMTP id a92af1059eb24-11f2966a03emr424972c88.1.1765326045477;
        Tue, 09 Dec 2025 16:20:45 -0800 (PST)
Received: from hu-obabatun-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm79775745c88.6.2025.12.09.16.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 16:20:45 -0800 (PST)
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
To: robh@kernel.org, m.szyprowski@samsung.com, ye.li@oss.nxp.com
Cc: oreoluwa.babatunde@oss.qualcomm.com, kernel@oss.qualcomm.com,
        saravanak@google.com, akpm@linux-foundation.org, david@redhat.com,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        robin.murphy@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux.dev, quic_c_gdjako@quicinc.com
Subject: [PATCH] of: reserved_mem: Allow reserved_mem framework detect "cma=" kernel param
Date: Tue,  9 Dec 2025 16:20:27 -0800
Message-Id: <20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: z3tDrqJhPPr_YGdSTTjsqOcROt4a4R98
X-Proofpoint-ORIG-GUID: z3tDrqJhPPr_YGdSTTjsqOcROt4a4R98
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDAwMSBTYWx0ZWRfX78lC7EFDlMVD
 6+SuqF9ZbQlFvWnpHbXS6CRu0rYjkdG/Lsz9tqcw07c9PEiTrp5Xc1iGvSUea4ulusdrDSCttLf
 QdNoc9Ng0+qhjWyCjaDFDqX0sGfpD0hNjxelwdCYiq1lLt1WKzkv2udGWRKsO+p1ZRFWcqUS6y/
 1P7MKoGqaO+fk6P+soA7CXqnatyOlMJc/o0cj4QfVmcoEPGM1cfStHAg1hucrUCSAd5VDlgXLLo
 BEcrQEaj8fX5DiCKIXhJnPSR5xkHIpeYHkTGYBhXnztvUlinb41BSon1Tz3I4sob3IVT8K385a3
 8bbYHcaYEqWAuNsxdeYxg6EnPaIBay9T9tx/fysE7W8gZjSCneefpyWSPh5phOZrIsNPD3zkbUv
 480FdhqetwxvYlyssTBRTIhILsnzfw==
X-Authority-Analysis: v=2.4 cv=IoYTsb/g c=1 sm=1 tr=0 ts=6938bce1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DS4snQ7NONFh9zYVhi8A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512100001

When initializing the default cma region, the "cma=" kernel parameter
takes priority over a DT defined linux,cma-default region. Hence, give
the reserved_mem framework the ability to detect this so that the DT
defined cma region can skip initialization accordingly.

Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
---
 drivers/of/of_reserved_mem.c | 19 +++++++++++++++++--
 include/linux/cma.h          |  1 +
 kernel/dma/contiguous.c      | 16 ++++++++++------
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 2e9ea751ed2d..bef68a4916b5 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -158,7 +158,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	phys_addr_t base, size;
 	int len;
 	const __be32 *prop;
-	bool nomap;
+	bool nomap, default_cma;
 
 	prop = of_get_flat_dt_prop(node, "reg", &len);
 	if (!prop)
@@ -171,6 +171,12 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	}
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
+
+	if (default_cma && cma_skip_dt_default_reserved_mem()) {
+		pr_err("Skipping dt linux,cma-default for \"cma=\" kernel param.\n");
+		return -EINVAL;
+	}
 
 	while (len >= t_len) {
 		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
@@ -256,12 +262,15 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 
 	fdt_for_each_subnode(child, fdt, node) {
 		const char *uname;
+		bool default_cma = of_get_flat_dt_prop(child, "linux,cma-default", NULL);
 
 		prop = of_get_flat_dt_prop(child, "reg", &len);
 		if (!prop)
 			continue;
 		if (!of_fdt_device_is_available(fdt, child))
 			continue;
+		if (default_cma && cma_skip_dt_default_reserved_mem())
+			continue;
 
 		uname = fdt_get_name(fdt, child, NULL);
 		if (len && len % t_len != 0) {
@@ -406,7 +415,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 	phys_addr_t base = 0, align = 0, size;
 	int len;
 	const __be32 *prop;
-	bool nomap;
+	bool nomap, default_cma;
 	int ret;
 
 	prop = of_get_flat_dt_prop(node, "size", &len);
@@ -430,6 +439,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 	}
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
+	default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
+
+	if (default_cma && cma_skip_dt_default_reserved_mem()) {
+		pr_err("Skipping dt linux,cma-default for \"cma=\" kernel param.\n");
+		return -EINVAL;
+	}
 
 	/* Need adjust the alignment to satisfy the CMA requirement */
 	if (IS_ENABLED(CONFIG_CMA)
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 62d9c1cf6326..3d3047029950 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -47,6 +47,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
 					const char *name,
 					struct cma **res_cma);
+extern bool cma_skip_dt_default_reserved_mem(void);
 extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
 			      bool no_warn);
 extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index d9b9dcba6ff7..9071c08650e3 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -90,6 +90,16 @@ static int __init early_cma(char *p)
 }
 early_param("cma", early_cma);
 
+/*
+ * cma_skip_dt_default_reserved_mem - This is called from the
+ * reserved_mem framework to detect if the default cma region is being
+ * set by the "cma=" kernel parameter.
+ */
+bool __init cma_skip_dt_default_reserved_mem(void)
+{
+	return size_cmdline != -1;
+}
+
 #ifdef CONFIG_DMA_NUMA_CMA
 
 static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
@@ -463,12 +473,6 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	struct cma *cma;
 	int err;
 
-	if (size_cmdline != -1 && default_cma) {
-		pr_info("Reserved memory: bypass %s node, using cmdline CMA params instead\n",
-			rmem->name);
-		return -EBUSY;
-	}
-
 	if (!of_get_flat_dt_prop(node, "reusable", NULL) ||
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
-- 
2.34.1

