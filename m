Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6A4CC600
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349453; cv=none; b=GgHhFaNA0ojpGiHhvjFPDVqT2g90OM4d1slt3rtsh2AvPpF92LRrB89OZWyxJM0NhlAgFNDKc/76lKheXOTyISfHTZG5euOXz/hGwEx3MhTmoDtXqGShQ7ofK4FZhxAZo96Xvgwqjh3t2pc/9RxcUg7haocAG2ECrYAvVvDk074=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349453; c=relaxed/simple;
	bh=LvZhH5njK4fSFRkj4zzE8p8wLm7oRw4kD4otyjMdQj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTEhRggiTgtzm4X/VYyA0gFTo0et9KdDh+PDpZsJLziD6fqFQr3fcgFwL1+lFi0vs5svt4vAmyb0hqF37vN//AzjxvmFICscg9FylO/ETumbsRawWEI4KAjTcED8nJhQfKuTWjq9j2dnQzV4tIRFhkDAefJBu/dDQcyYtjC6Ocs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CBTDVzkw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SKYConcJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CBTDVzkw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SKYConcJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PD2v2e1056570
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GkUPFWh53t5
	B1pacQo9bQeDytgQRc2XAp9x9CQAXz9M=; b=CBTDVzkwbQvAmJVtPNFkvezmnAF
	cY0gxD0kp2Z2yKyr5/zpv+w3B99pFhxzDOSl76QAvgtLwiaDG+/V41OOSBmgf4ZI
	TekBJlY8Ul2m/k+hxOQt9XnturdAl6OJaLKDLwPjpjW9X1wHkP+EgsHg2Z3XI8Qo
	Td6knKbLuBwiFle5O3s2qqObgumkEt+LLqPeV/uZqHy6ttgvKNdhNCxwkyItC1dm
	kzdU6uop9nagF0hiBuSiek00bBOSMsasXFngjCLzPzeqWWdYCjCT0e36tjIEdVho
	KbdHTJ+RHZzGya6N82W9HSVgC662cOwc22BLmcj6NL18IJIldd56FbQvMLg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7b0f9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:15 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7b2e69f3023so294618137.2
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349434; x=1790954234; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GkUPFWh53t5B1pacQo9bQeDytgQRc2XAp9x9CQAXz9M=;
        b=SKYConcJXUkf1Ae0Th5tpDzEtdyzTvmDDchMWV2abVJw52dzkZj5P47USkgC1mYAug
         SKwc0yR1E3izTMoAW/ms/cYcNLjzgvwqf+pW6EbmZ6ak50UZnXGOPMSSob6m0kBqszu5
         pBWljTOE9OJRXlT0x4qH1iKzhtLJ0g+ME8N+uWoI64r0QPAPMcMDR9cmL034+eYWRaDR
         AKFK9UbYeo/F/UPFP0r6ziyGZb3Tip3CN/1TdpF51erQgojiafzqNOWTaTmt+wxsd/Cz
         R896YZKx14LaWBbv5dgnt2QzySEXouESl7q2WzDm1yCFUL1ZdG29679GhzVwaYg9/UCS
         jU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349434; x=1790954234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GkUPFWh53t5B1pacQo9bQeDytgQRc2XAp9x9CQAXz9M=;
        b=FrnBsq1UMxbkMif5qk0D2HRAMDHxT5hdA3Ee4ckJZMPwBUXVOAU91cLVnkUWePAXDP
         WBGIXZuGBzSE7zvqmGsLNaI2YyIqvSSxTJUnNE3Kbr61+4GSXeGDcgXXl+rN5Gt9XxO7
         dGbBaFZKSUL1AkrnpOD5gZ7oPaAgcwjklg4rtxYu2o0yZqoylbOnqaSenpsBEg2sSCyR
         PpDzpaZoKM1FeCZzUSUpAthU7kkLPEpYybwn1IJOMegx06LnKvewETvDwwD5KWJlAs6m
         tdXdBVIkdJOfz0yLviCHsSiGv7tjyAZTk9BAwlGEBHF1RyiXCufWBvGvg8I1uLz3yI0m
         Sj1w==
X-Forwarded-Encrypted: i=1; AKwUvBwgQfgupLIX3h+bC2ogzmVwmyRwuB79XS1M/rKZN2whr4mFhbqOjoSDdY/+vDyW1jDwuKqGdA==@lists.linux.dev
X-Gm-Message-State: AFuF++nBCdANTOANJ3oc52B9W3jbJKXmOjZd4VQHTfyGxEa3J0Rh2H8c
	yaqxHn4MkUPDWW+7LoSt35mZZk4FypmQF24uovm6IsJYKhzwWexgY3pac0KxPcantjHJDVK7FGv
	M6u761g8zgZ6C/BZP6G7OFjEXdpscWU0crgX8iz7vNPuBXYJiwozpkA0tww==
X-Gm-Gg: AYBFou3snA+cAHuePsdmzCtxHeTDTFaUrLFdP2AYJaVEG2pKF6rNLXiHUI3iV8w5I7o
	WPL3SEkPXwmXF8qcO/sLaOSKpFn2eSGIKkNQ3XqgyyyxfZeU7w57RlQmEjXAIn4TwJcc71UiV9A
	Uz4j6Gu6DwmECyMzhCakkOjlml6a+jCGyPIjNwgNpy5Gxng9c37J3mO/B3EFXT+mzfvSIW59NMN
	gnn6fMR5YdUT4Tl/aN8bG+6h9+iW3txUcFl/tUylWvn44RKV4k78Vz18ck8aIu/V3U8Je1VtNeq
	/vz3ePRlwPSFZJfh/BT6ap2yMmn/YfuKxNP+iHCmOgAwl8H60R+av9+L3le0rWPPMCCvQPMADRd
	WO51Xd4jS1QivGuyfk1MYM7nrNCXGn25N6IbOh6ew0wccOqPb
X-Received: by 2002:a05:6102:160d:b0:7a1:f7e2:aae1 with SMTP id ada2fe7eead31-7af1e6f3633mr2841431137.19.1790349434313;
        Fri, 25 Sep 2026 08:17:14 -0700 (PDT)
X-Received: by 2002:a05:6102:160d:b0:7a1:f7e2:aae1 with SMTP id ada2fe7eead31-7af1e6f3633mr2841410137.19.1790349433786;
        Fri, 25 Sep 2026 08:17:13 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4c8dsm176773155e9.3.2026.09.25.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:13 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 06/16] iommufd: Install software MSI map ranges atomically
Date: Fri, 25 Sep 2026 17:16:49 +0200
Message-ID: <20260925151659.419512-7-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: dHxznw8_sKAPL4uFqRP7XF35zxCUOfo2
X-Proofpoint-ORIG-GUID: dHxznw8_sKAPL4uFqRP7XF35zxCUOfo2
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab6907b cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=SRrdq9N9AAAA:8 a=0NqqyPg6VgUUedX_kk0A:9 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX7Nm+cATX9RB4
 eBOdWr55ZKy9L3egxBZpqklBT+hKc67S1ehuFHZQ24cTZDVBIGY/7HuB/x2KlDREsSa83bNXLre
 QsvFxVegG2rPjdpFLwDvMXtn7pB7CUu2mtmZVWArclnDQvTVQ/yS/sb2c2Tvt4PCt7HsmAqcrQh
 VJ1Xl9nBBFal3/YYylkmDq6kjPY03LsWYLvzcy/t/uCfzHUw04zVLaeNqD6QCNduhYoYtf1oLr7
 ASkqHlmKhWpbU1XgiUdO1M3ppdcvFdmehkJKbuWCyDUP/CdbiDPWo0E4qWZq/+gRwHRqen9g1HF
 xtpL1UItmSB5BiyneEMvkn1nr8MWljy/XAFqW8ocm3noD2cx6IUkoVuzPisvZR5/g7rRMpO4n8d
 ZjzuQeqUb25xhoA00VbNRE2KnUwTsDzRvQca+ghr5gooIOUt6o791mm3aqMRokTAxT8xYDdcxpn
 AEv7vRJDtuWmpybii7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX8UlQ33HWln2s
 ZzeEV89AVJkzkq5hw1fukC3Q2kTbxoduQtdT7DOYByyu85B+VrHIMp5Iih+hzQpkuUnlvjMMYbk
 28UiyFcxgtOX8BGkGhN2LLwWQjO7wmU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060

Add a range installation helper which installs every map in a contiguous
software MSI range and rolls back only mappings added by the failed
operation. Use the helper when replaying range mappings into a new
paging domain.

This prepares iommufd to publish and install physical address lists
without exposing partially installed ranges.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/iommufd/driver.c | 76 ++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 8b8f132ef3c5..3aff04d9dd04 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -178,6 +178,17 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_report_event, "IOMMUFD");
 
 #ifdef CONFIG_IRQ_MSI_IOMMU
+static bool iommufd_sw_msi_range_index(const struct iommufd_sw_msi_map *map,
+				       const struct iommufd_sw_msi_map *base_map,
+				       unsigned int nr_addrs, unsigned int *index)
+{
+	if (map->sw_msi_start != base_map->sw_msi_start || map->pgoff < base_map->pgoff)
+		return false;
+
+	*index = map->pgoff - base_map->pgoff;
+	return *index < nr_addrs;
+}
+
 /*
  * Get an iommufd_sw_msi_map for the msi physical addresses requested by the irq
  * layer. The mapping to IOVA is global to the iommufd file descriptor, every
@@ -207,11 +218,7 @@ iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, const phys_addr_t *phys_addrs,
 		list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
 			unsigned int index;
 
-			if (cur->sw_msi_start != sw_msi_range->start ||
-			    cur->pgoff < msi_map->pgoff)
-				continue;
-			index = cur->pgoff - msi_map->pgoff;
-			if (index >= nr_addrs)
+			if (!iommufd_sw_msi_range_index(cur, msi_map, nr_addrs, &index))
 				continue;
 			if (cur->msi_addr != phys_addrs[index])
 				break;
@@ -306,9 +313,9 @@ iommufd_sw_msi_alloc_map(struct iommufd_ctx *ictx, const phys_addr_t *phys_addrs
 	return ERR_PTR(-ENOMEM);
 }
 
-int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
-			   struct iommufd_hwpt_paging *hwpt_paging,
-			   struct iommufd_sw_msi_map *msi_map)
+static int iommufd_sw_msi_install_one(struct iommufd_ctx *ictx,
+				      struct iommufd_hwpt_paging *hwpt_paging,
+				      struct iommufd_sw_msi_map *msi_map)
 {
 	unsigned long iova;
 	int rc;
@@ -332,6 +339,59 @@ int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
 	__set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
 	return 0;
 }
+
+int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
+			   struct iommufd_hwpt_paging *hwpt_paging,
+			   struct iommufd_sw_msi_map *base_map)
+{
+	struct iommufd_sw_msi_map *msi_map;
+	struct list_head *msi_maps = &ictx->sw_msi_list;
+	unsigned long *newly_mapped;
+	unsigned int nr_addrs = base_map->range_size ? base_map->range_size / PAGE_SIZE : 1;
+	unsigned int nr_found = 0;
+	unsigned int index;
+	int rc = 0;
+
+	newly_mapped = bitmap_zalloc(nr_addrs, GFP_KERNEL_ACCOUNT);
+	if (!newly_mapped)
+		return -ENOMEM;
+
+	list_for_each_entry(msi_map, msi_maps, sw_msi_item) {
+		if (!iommufd_sw_msi_range_index(msi_map, base_map, nr_addrs, &index))
+			continue;
+		if (iommufd_sw_msi_maps_test_bit(&hwpt_paging->present_sw_msi, msi_map->id)) {
+			nr_found++;
+			continue;
+		}
+		rc = iommufd_sw_msi_install_one(ictx, hwpt_paging, msi_map);
+		if (rc)
+			goto err_unmap;
+		__set_bit(index, newly_mapped);
+		nr_found++;
+	}
+	if (nr_found != nr_addrs) {
+		rc = -EINVAL;
+		goto err_unmap;
+	}
+
+	bitmap_free(newly_mapped);
+	return 0;
+
+err_unmap:
+	list_for_each_entry(msi_map, msi_maps, sw_msi_item) {
+		unsigned long iova;
+
+		if (!iommufd_sw_msi_range_index(msi_map, base_map, nr_addrs, &index) ||
+		    !test_bit(index, newly_mapped))
+			continue;
+
+		iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
+		WARN_ON_ONCE(iommu_unmap(hwpt_paging->common.domain, iova, PAGE_SIZE) != PAGE_SIZE);
+		__clear_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
+	}
+	bitmap_free(newly_mapped);
+	return rc;
+}
 EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi_install, "IOMMUFD_INTERNAL");
 
 /*
-- 
2.43.0

