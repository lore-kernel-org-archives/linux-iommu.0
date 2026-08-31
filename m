Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D6F4A6CD0
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188399; cv=none; b=pS7x8XTZadBiphlNGf92+iQXbhiit1QQhU+bNox/N3RgzkMRk6jEevBmZ2muKb1vfQWJChBcPpq2pIrQdx1JlUFgYE/JYTAlZRf+MO6qPNSw0xDS2kpOPFo/spPK4aWKguPg9Y0NKvlc8cpVuOrs4rOKBPFuegcl7JDpqkFzs18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188399; c=relaxed/simple;
	bh=syYRdbVVbpsICnzaj0fGfFWk/HbaKoaDsoQSpJEVM2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUJLGUGtpMz7GQKjTHY90cXMNr373OzFP9wgIknGJB2xPYvNodmAwVtRCtjBrj2WrCi6Qa3kNlENQccgu4JbZfRxCgOFGEP3pgE45R3/4khcaLKJJuHtD0fDGoDMOKBRvydx49rwgIWzwJmHkQ8zBRu8R1n5e+NgpeXWsALcEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+DM60uH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j9rOgs2+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+DM60uH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j9rOgs2+"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETbJF4049756
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JGkZKildlqj
	JzugtZJx0sJt2KViTlqK+7HFbST5CtPA=; b=g+DM60uHpxeekSrflg4yvKHlEGa
	ZWi7Q4MlQE/a18400XJqMQEt0pByHjfxLDlZFQg1gyVuGsniSVM522acNP81EU71
	FKhFD7EzGDze1G7hGx6f+OCSg+f52ehzY9gIxZWFE8rhAGd/+2POPnVZjTkSVVEe
	0dWUGAqh2OKvHFRSTfr5Ct/3q0MsJt3XsJyFMKqzA3Ihpcglnk9SX9uel4trmJhn
	aoaawgoRNOjpcF6LHJH5WR0L0NZK6TCvjeDH9uVV3vgyo7E39cxb6JBfqX5r2C9y
	BcJ1PddrwVrRL/OVW6NASTt0Kz0NOg6FxC63mdm/qVNxZJC4RWCUx/EjRag==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6jghfx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93922c75037so242319385a.1
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188396; x=1788793196; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JGkZKildlqjJzugtZJx0sJt2KViTlqK+7HFbST5CtPA=;
        b=j9rOgs2+8JeERfAmomt2czFuE40TvUyaFF8MH5Tc9tgLyE1kon3Hd1aKd/aEPKW2zy
         LKH13f9sA35rWUFKGeFgOb6clSAsj7/weEjw7FdrZMI+cgx1Yr9RP0qUGMyTyzJQ4Jt/
         geC37t+XvNIp5AISxmONs+Vl1E9bwJxRcSabuzEKLpqWnOCBRiByUgfxI3QtZwq/mGyl
         wShKjgH/sAxiSsZCPtTHgJubOf6qqrNtjTV1BI5LuxRuajnTbIUstOtR5HyOIypXnHkm
         YgpFOkQ8EG6bP+oGgXVMNMdw1CEQPrQKltNFJzQd65vceUDRiV9Rn7P+4oRcKQNpe5KR
         yvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188396; x=1788793196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JGkZKildlqjJzugtZJx0sJt2KViTlqK+7HFbST5CtPA=;
        b=U57An7FLhpL6zvhcgzJNHc7xCqtyBrWPDdZgMKmUxUTRlx8iO3mZLZlfJhPWveemee
         nB39aYS6Qo4ir3SX+V3MK5I/VmrPaWa76UaXKDlfCVxmH2dRaTwtxfTxwQ5ad/qQL54G
         OofG6x/YDUsL7um+38/65z/Tl4JSJkGsyHFXr19AaEnMG3XeZd00rq3up2cKMnS6FoNq
         IxIa9yL2pH1PdiXejKSHgWeOrYzp4+350ssqFfK8MhQ5Hpmhx1YdVKbqVciN/iR+lAsQ
         /wIaP28Vt1F2zf9wdJ44Sy7+ooBPF1UNrwJKahdEcEtgvopnAqcFLxd9coH9xkoMBj8t
         vc1g==
X-Forwarded-Encrypted: i=1; AHgh+Rq6P7sBiyfsQk4QQ84HzX1+9KKgz1mF5ZArA4mQBke11CHqA/q0O6Vj1maYECkwKg0m0sW6+w==@lists.linux.dev
X-Gm-Message-State: AFuF++maGrf2uJRkMvN71PbMgamOaRh9ZgH1wiAtHXiZ0jNihlRKftjo
	UdukizfEYZNLvyFEuZYGaLoWTkzU7MYxYqrGZ143sjqDGsAIdQS7+DZ3sdLkJl9v+fe1STMGn6c
	Ll+A5ldN62YlHbQfsUw0m8MNP5Z1fxTYWvy+PC5julP6ZyqD5XcWNz48OGg==
X-Gm-Gg: AR+sD13miJlb5TI70nVSVmVUN48cTNFjFgMw0KR8tJYpATXv8zamvDy11q7rEvgeWQN
	prAfucyAkAPeexUHBqCT80FMZytXd8C4ks18Dbh0kRNzgc2bPbE+SwQT23fVeuFOPITWkbaVqDn
	CJiAFrVStnO/mYpCngdLUbJ9cQ9hTWVFM+4YcLbGZan0j1KlHNylvqG/2BONsOzraNuMy0a2tPQ
	5Nlv+byCwj2jMzAqSMM9xRqfZs7CnKSvAwSZJcb+xnNgyxzx9DbTPwISwosGHi2kLdI+vAu7APx
	Dca04kH7CgYVhOcJjrnICDnj+V/hbIn6YXYHkMDltuxrEyII130mABsKY0ACAOJXfvKtKNUPOgQ
	mn4S/7HstY72VRCNxkmYiBRrfLk+Enfi5e4I=
X-Received: by 2002:a05:620a:44cb:b0:939:15e:1a5 with SMTP id af79cd13be357-9391391a8a4mr3008740885a.35.1788188395792;
        Mon, 31 Aug 2026 07:59:55 -0700 (PDT)
X-Received: by 2002:a05:620a:44cb:b0:939:15e:1a5 with SMTP id af79cd13be357-9391391a8a4mr3008732885a.35.1788188395227;
        Mon, 31 Aug 2026 07:59:55 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843dcc00a6sm5323372f8f.33.2026.08.31.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:54 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 06/17] iommufd: Install software MSI map ranges atomically
Date: Mon, 31 Aug 2026 16:59:32 +0200
Message-ID: <20260831145943.313726-7-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-GUID: XDhGHv3WF1i6GaCUuPm9uWQkCVlvXkH1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX++yE0FOBSLbU
 l8sGa/nNqF+yjFLjdFcfisfFoDUE9kAuPJvmHZn6UFmtRgG9pHSwTeezVHVZyAC/Pc3Y5+MSkA9
 2bvurU9JyrPJZC6fpJD3pilKFyJKzkQ=
X-Proofpoint-ORIG-GUID: XDhGHv3WF1i6GaCUuPm9uWQkCVlvXkH1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX2WUwa1g6idyt
 +lWFEI8CQL6SqF+obuF8TKH4TGNPbDKOy9VXUE22vo3proUlZ/IIvcVBFTyIUp09b6tx2j9kZG8
 jFOCyO5Is8nEYiLmjO53ot8x0iDWoNFKddqa4bp0sH4p4OI+aNkPvp89zqtWxZGZsIxxeqmKRXI
 Fcn4hmOpPpCHynR0ecB4c7gyGDVm6M17+8luZ022xKdkml0vksmx7yoK3ETMzjkhdrS9wa5OBzK
 4ibSFan8WAgmbj85UR+C8Jz7e2YPrdSvhjGTpR6tuOkP6Vlfn6cZQtz3UIo1jY/hIiKKRccJt+p
 p67jxkLJnPLYjKECvynD7+NqvhywSNaJXkuqr+vYW3CGsFuHCx6oXnJKHesYElgn5mS4CfnCF4L
 1Toshxeumqak31oIfaFaPAicktCXR84zaIftZac5NLxqp+XULT8G2m+8GSmICRi/9UowCfshI3B
 W+4PPyZf7LeQumE0D7w==
X-Authority-Analysis: v=2.4 cv=YsY/gYYX c=1 sm=1 tr=0 ts=6a9596ec cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=0NqqyPg6VgUUedX_kk0A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

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

