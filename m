Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D8944C64D
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756003; cv=none; b=jEleiLNQAG0Fb0qwu2zNq8QbRqIBmQ2xgTN63bXMwBhtKmB9hvVIF45fheswJ7AQdPQAN8xSa49fzeHcJ7OhhpdxuYQPj+m0hPbSQt77E5bj0CkHCXQBca3ZTJnCk3RNVgT1wDQsqH0wS3rplTKD+rG8ECZGphipj6FwTPYNsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756003; c=relaxed/simple;
	bh=syYRdbVVbpsICnzaj0fGfFWk/HbaKoaDsoQSpJEVM2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=br752q6pEBSbEaUhfwZ+PCif758Oa8y6GO6yWqbY78r6+rEQFIfmno9PIz8gSQ1JSh/3TpPe+ImRFWMwsszZS+16n3L8QJlHEU01v05PuBS/UqzEHpfRomTvtO0m3pWi5Gm7N6t1Y3EZcfaG7P0oKp/G/diGOx8A3BCEPo1fEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GHgrOuQr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UH/sVae9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GHgrOuQr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UH/sVae9"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDukSm1120043
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JGkZKildlqj
	JzugtZJx0sJt2KViTlqK+7HFbST5CtPA=; b=GHgrOuQrx12JI3dvkUd/XPTKCfY
	IALq1lLbrVGoJR0O1xYm09NgiJatFXz4ivThTk/qgK8p2SIe4CBbONZlW65pwUOa
	YmVaAKoU8tqeO4eHOuufFNsFt05P1nuk1Uqpm4tXuI0rCDT/at6ThJGEDOrA66Ke
	Sbi1v+Y/WD8OaaQ1Iy2DRT7jyt1d2+jB8kERTB5HDnIUpDy7DY70wafZIbCrnAgv
	WS0vypH3PtTk7weN2pYLDwCzOrlgCPK65Kek9cbk1ISzp45xcuBlRmvC1D87M0Im
	8cfuv3vSYjrMWsrLo1LgGYh0sVv0VETS3FGvjxQwDG7Wb3PgFzvmy+vc7PA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k2p6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52e7a49452aso6020701cf.3
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787755997; x=1788360797; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JGkZKildlqjJzugtZJx0sJt2KViTlqK+7HFbST5CtPA=;
        b=UH/sVae9256soe+zKe980HXYAQHbLKe9dBNJ/FvQja8a0LcgGkDgl4xJLkbkNnL/mK
         Ovy/MsBG7zNasT/GJLfzM0WYIQhJ4BnzXqJ1Mwk9wsQDnfKzwiZvDgzqzMRSikTTmeDO
         3DXYM1WGY8gJ/NVt+gBka0yfpP0YuIr1wOEXaXn7ilB8IJvJMLue8uZC17q49ARbGrp5
         1c6xZEqm/6C56ZYZy/miqjl63VqFNnoISugc4n8wi8r8totEmM1OeA7TN888sm7StwmB
         EcvoNT19M1hBCu9zZFhCOhIZmFakjwgfLY4PhA1QRUnl5YMfCVZSgImKEPGtUcjqg+pE
         DR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787755997; x=1788360797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JGkZKildlqjJzugtZJx0sJt2KViTlqK+7HFbST5CtPA=;
        b=Hr/suzT6qSZSrd0dQMPZ1UPZypM33q7LgJg1tVK76hSEZMojgGdycgs2u9fzCShxqI
         OxoNCjrhoWNPqpyW2AEzsOVIXB+IqxRchr+Feg/pZo7rCPzN+20etUADETZAt4JakE/V
         nt1zUtiEBlgWeisOt8Lqdek0h/E8E3dGo1Mxc/IXng0xiadNOen1VQ9npkQHmoyTf3fM
         ckDZy1rQ2r7Ws3QRaqcpbxsXmYIQHSaKY++2DmrL6gecr8asu7dVlDKAha6E4/P68WV1
         KKYO5RCnOt8e0tJjiAowi7FlDbegWMRWF3hrAGakbqFNmv0Uc4oVUjVb38pA1gg8B5op
         56IA==
X-Gm-Message-State: AFuF++mR8bTS/04OWBjG7l0PHxKXYdFiyOM9mEcbb0CIF5gzEHljjOgw
	ukpB+048k1TAkAegjzMsgS3coE/f86nerAmkF3ifApDhdJo//JcUd/SzcbqbNo5GHRSUF/RYBoB
	xJTmgclSzhnRe2bMLh0vzsIb98Kzn4j+Nx5vqFvBWUGPxd9fyoeYcrbitmRmQEMAjHg==
X-Gm-Gg: AR+sD11gXmUmZwUcQxDwjBjuYSNtqBVOxKEcxy5AxeQqj8NzDW7ibyzJaHuIxAtTer9
	mTT0f9wV50ymXlxYCE1za8kQpo8+hTvjOgvDhp0pq5iyRv9raGQQLCdVZ1RzBUmhVBU8/MtEKK2
	qBoQou24dJkYfy8LZMzQdeFOrZICA9Gy/h1Vsyk7HSd5xGmzBEqN/0LiYg4QvFnjO3ulYuP+BZG
	TwWg11Rgoj73JPOh9FbImNaDBdVtN2kzMwjqNaN0jZR41En2vFSOzZZLhDEYInI4l7FUn9k9B9e
	1p5rAVhmvgoiLOCwDNB7q087ELkx4yaSh1tvZc4lbpEMZoes1mLXcCe3HmG/ee8B7+BV6LluzSa
	VFSuBV2f1
X-Received: by 2002:a05:622a:6106:b0:52d:c357:86b5 with SMTP id d75a77b69052e-52e4234d4ddmr70540591cf.20.1787755997138;
        Wed, 26 Aug 2026 07:53:17 -0700 (PDT)
X-Received: by 2002:a05:622a:6106:b0:52d:c357:86b5 with SMTP id d75a77b69052e-52e4234d4ddmr70539921cf.20.1787755996689;
        Wed, 26 Aug 2026 07:53:16 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499e7170b72sm13455975e9.0.2026.08.26.07.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:53:16 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca, kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
        will@kernel.org
Subject: [RFC PATCH v1 6/8] iommufd: Install software MSI map ranges atomically
Date: Wed, 26 Aug 2026 16:53:00 +0200
Message-ID: <20260826145302.449904-7-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826145302.449904-1-andrew.jones@oss.qualcomm.com>
References: <20260826145302.449904-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8efdde cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=0NqqyPg6VgUUedX_kk0A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfXyAttNsRXtac4
 ItNPHP/pzaCPVFmD4+KldnujOXPWn/nHWMuJtBzLvbzYU9sWEpw0Y33qda9jl68kzG/6+uDm/Ur
 gItfGeeDAlE8S1vtnnaY4C99LukkDDo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX0NXx38sMHq7f
 cvuSK4C5vSzfjnWVcR1BStrKGkGkYEV26hiQgYga4kx3F3w/+zUwnBLjREorVq6XsiX5uyu19Ih
 aWMDkthfxgnFxsYng64FROqEbJR+iH2450F0vdbzGSH8jCuxT1OsxHTAPwFSk0KyzrGXKCyr1rX
 ta6/r/aPm/0RCTnAI30B7Gk0P3w2Q+iimqMehZufNay1y+NaoTT2nrQWkVtNakhnCTU+HT4LF0p
 Jd6pUvshRMgcssmaM3c3BkWU5KwLF6I5/ceahDBG8x97GWe8jj6S0jNDXK6bnlRrlQzFuuLJnhE
 VbFWyf14nO5KoXpE3CBH19ElAl354di3ImDQUE6qTIgJPIPFr2YE58/ospJRJPG1qpDv7WFlSYQ
 MuqH80LACQeNKsSc0ZGiP7fXYwXLJEsZ/i1xX8balMCqvu/FM4i6e/JT4a1+BzUQJRzpYrbxjZ2
 pWCJ3d7UygxzuO9oTJA==
X-Proofpoint-ORIG-GUID: H2ZupFeWh0gEtuX7nXhC6LqnUXTCZQji
X-Proofpoint-GUID: H2ZupFeWh0gEtuX7nXhC6LqnUXTCZQji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260124

Add a range installation helper which installs every map in a contiguous
software MSI range and rolls back only mappings added by the failed
operation. Use the helper when replaying range mappings into a new
paging domain.

This prepares iommufd to publish and install physical address lists
without exposing partially installed ranges.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/iommufd/driver.c | 76 ++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 6a0527f4b058..a43a25078f87 100644
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

