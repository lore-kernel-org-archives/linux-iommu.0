Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1E41687F
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905948; cv=none; b=fhA4zBcWrPL8KdHHddSubYO5sT5y+O5/SOdqkTLjBsWyAra8Vv0QGE535eHK/CbbCOf7l/3nVc/JSjEcR5R2zG8i8780VaP3rg7I8GKOriElEFdBWwbIUWUxx4vi1aoSllJ1J0luR8kSjIZh0BtD8v02ec5xMyzWGAqRe6yzhuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905948; c=relaxed/simple;
	bh=QZbR80ntFkJlleXCtZ0dEb91PkUcyds2B1i9gby0hsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HO0TkWi5xOtRMWP+NLtCCWSf/XbHZhzYi7rL3w+TUpizNcVDbPKOqJFv2L1Wo1w+gu5qH94F+zYDDPthA4kkItFRFdaRkD2MfOYbPu+SOCK3I89WpG5ACHYIwFmhPFUkHt08E4L1BIMcqKgIqdFkNMYqlMquUfJGEXfnjX+FLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aEi66ybT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fSPxG8GZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aEi66ybT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fSPxG8GZ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbNSE3308097
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=I9ymIHqsyxx
	hhaBbMc+ImuwfKCQrL/f6dTJMEU/+0QI=; b=aEi66ybTT4gQcNl3Oh1l4ZbQZ+p
	DgBW4F7h2+QPUTtt7NYsLOycZOiW6LUsgczdW5qlOo/qMvwVIamGP3eSlYNwv7DH
	soEircOb2HBQM6ALLNoJA834Uxhq02RxzkCm3Ml0HPeybHrJsTrAGKVSYnpNRbqY
	6LZWB2cu4BXBeH01KgakefP/pH1F/MPjhDqn46+bIgwtS60UrahASDQJhoBKVZIA
	eZ+SKN10bGxFiEjrFTPE3rXbKS/KGhjWfYnPYjZpPhaZb4nMk0oILzjxlmXzKvJC
	jF0RAibKSahRCEFyFcLDRWiqiXGhYsMAgwVr55uWeiC7T+e34ms7nkqbhvA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fktahujfw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c12e43b98so9014941cf.1
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905943; x=1785510743; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I9ymIHqsyxxhhaBbMc+ImuwfKCQrL/f6dTJMEU/+0QI=;
        b=fSPxG8GZwlXMp2hcPUsHHHMukBGnV9GkBifZtZAWFfmYeir97r4GYG9hQDc7P2B6Mp
         6qAvf0d0eays/bWp8rYv5t1PAdNlzUHOieD1tFI7gffCpmoZStAsQ4be56HXJMf483Qv
         vebdcSvAys4Id/cvLpOVdEXIGawtLvTE9sWM+PqObLPsS1FnXRZJyiOlEiMF5QDDMrWq
         WuMmzQC8KmDuYbsxuaJL8zQItYKuuODCPWTyp8uMjDLDS3/zNj2qFj8g/9sO8c65s88i
         GUxCtEScE0QuIaVRv0Af+I9AF06xW1oZIvJ1lh5rBtK7N4jjJenJLRv8WM4aPEzbnGic
         P/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905943; x=1785510743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I9ymIHqsyxxhhaBbMc+ImuwfKCQrL/f6dTJMEU/+0QI=;
        b=aiZ80q+UFTWWGhC9NO5HY0cSEt5kWHR8GjyAVFz+8n6pu4yMWbPP24t7jTXN2IgEai
         N267HMwpoyDTLv/v5dII8ZAT5u/7LoxTJIR8Atu9971pbw17jMotyCdbrVmecTJ0GexB
         52dBem6x9Yz4YYiWxAqvu+UCmP86PctzJUK8g1yvaSTuDU8MAMeIVec19+W84DBtPA7c
         VLxNl254u5oRveWBQDCpMri9+RUCoQMR82UyDazly9/8IipV0bl+QaaNxcsvZa4rWuzw
         s04RLrNPTT0aWw12+hc4ek94C8EUqjp37PTb0ZsIC02zm9ZK3iwy9yGS5A7osCf4C0oP
         Dfkw==
X-Forwarded-Encrypted: i=1; AHgh+RpweVAsZNDzBNXpvhgJFRdD/anJZu1IS+Pv5JADwdW4Uvs2Z0um+cTmhcu7icuPfhwNHN06kg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFI7XVtyaLwc/UTm44AEKPKnPJkgbHt5VBSVypo3s2MadnhV0C
	q4Nldb3goMRbdUOzBtN0HpoEkWK4c5PNFEmycR9oe4YlQ6u7+u2D7MbonWaBDDGkkK4wU8nGFoU
	95z2SZ1061QyRS5zK84cJRzSsIMrWX8fRWviEiDTJXzDmMSUmNfWvXcouiA==
X-Gm-Gg: AR+sD10QT91eK3QsU/zLV0lw9JeztmAaO4BP+i+zIHkyKd2yTIx2aV2W9HlMcDOcLnV
	JWOdktEAu1YVKt7tIUKjrc5/lRefRwOAx/NMOJcVfI2fevtZqzdetR9ysryNAHmrTlewkOTb2uc
	smgeKAfvCI8jfsUnY8MAGVWBYkLaFCLsuVgYE4i5bFueD6gNqRr1YDhV9vevXd4eI60sWI69Uom
	aWZz2xCMHkNP3aBDPkmL0PDyWEKMpQZKN0i9/Idbc5T9MctMbaDHlz0xadlbXGg/LRK7+qqPUhM
	PQfywy7efPBZPTjiMmvVboj+JBpRvRFfCNi//nv2n3fVTlIg8z2Y/hfLarMcJ1zeIx4Jd1gHQmL
	v4FQHAznJLW3adQoMagh3mRzkWQ9zGIXhWMZ2
X-Received: by 2002:ac8:5a02:0:b0:517:8011:3a4d with SMTP id d75a77b69052e-5283de1c0ffmr71497741cf.20.1784905943402;
        Fri, 24 Jul 2026 08:12:23 -0700 (PDT)
X-Received: by 2002:ac8:5a02:0:b0:517:8011:3a4d with SMTP id d75a77b69052e-5283de1c0ffmr71496931cf.20.1784905942571;
        Fri, 24 Jul 2026 08:12:22 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1d0a73520csm74444366b.1.2026.07.24.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:21 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 01/14] iommufd: Convert struct iommufd_sw_msi_maps to a growable bitmap
Date: Fri, 24 Jul 2026 17:12:05 +0200
Message-ID: <20260724151218.965929-2-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
References: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfXy5Orb8VDgbot
 DPZUuqcmQ0ye0PcQWRpTZzYkJeiNpzvmOxC1rw40dZNL0s6SUmpobUshUTcDdOsu66yCDbbraRB
 8Xn6WhHavW/t+6LViatMsgTbXvQgVRY=
X-Authority-Analysis: v=2.4 cv=TvrWQjXh c=1 sm=1 tr=0 ts=6a6380d7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=GdI9VHRvGUSwsDbnIz4A:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 6qD4oV1x_QCXj9DBEG7gPpTEA6wSSgJt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX5JS2TJVBPrPV
 IApV+jgqakf6Hj4aeGFeV0/NhF0edU3QwQ1qLO/R5szuBsbsqB71Zd8GoY2Fk+Oqrtq052lHYbC
 XxHibsdVn3+RPlIlv7ZgaGLG7qNmMLRbc3vnb/yYW3LEK+7cJ5b3d2g26YGQGOq/2Ge5xE6lKpJ
 7aDLmDbLMGWYvCd0UJlbl8qB/Y3tSPsr43MQG+uNIulQ82Vw1qgDJagn6jtF3FDG9O5+QKfGhNP
 PwRdq10NI5UgEc87xkdAIwgA5/+I5iF3vFWdh1C1DvW1a9pT5C9VrXEevcEphYwBOR5vwQxoS9J
 4ZGsK9zISqMXBJ/v9s8UsdzKAKU2wzKgK6U1tDCRbN6+TCMWlJLrl2vRZnhuvCI7PdChEPhBq5v
 WJXAsOxzO9JyhbPpwnhzRp9NJbZwWVIcw4saN9Ki31VKGai4O5pxhMGhlULbFjjkFgMwI0VJ7JU
 YxUp4krBbgkVf0kks0g==
X-Proofpoint-ORIG-GUID: 6qD4oV1x_QCXj9DBEG7gPpTEA6wSSgJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

struct iommufd_sw_msi_maps currently uses a fixed 64-bit bitmap,
capping the number of distinct SW MSI mappings a context or hwpt can
track. An upcoming caller needs one mapping per possible CPU.

Convert the fixed bitmap to a pointer plus size that grows on demand
via iommufd_sw_msi_maps_ensure(). Add iommufd_sw_msi_maps_test_bit()
alongside it: unlike the __set_bit() call sites, which always follow
their own successful iommufd_sw_msi_maps_ensure() call on the same id,
iommufd_group_setup_msi() tests an id from the fd-global sw_msi_list
against a specific group's required_sw_msi map, which may not have
been grown to cover that id yet.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/iommufd/device.c          |  3 +-
 drivers/iommu/iommufd/driver.c          | 38 ++++++++++++++++---------
 drivers/iommu/iommufd/hw_pagetable.c    |  1 +
 drivers/iommu/iommufd/iommufd_private.h | 38 +++++++++++++++++++++++--
 4 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 170a7005f0bc..402251c7b887 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -34,6 +34,7 @@ static void iommufd_group_release(struct kref *kref)
 		   NULL, GFP_KERNEL);
 	iommu_group_put(igroup->group);
 	mutex_destroy(&igroup->lock);
+	kfree(igroup->required_sw_msi.bitmap);
 	kfree(igroup);
 }
 
@@ -384,7 +385,7 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 		int rc;
 
 		if (cur->sw_msi_start != igroup->sw_msi_start ||
-		    !test_bit(cur->id, igroup->required_sw_msi.bitmap))
+		    !iommufd_sw_msi_maps_test_bit(&igroup->required_sw_msi, cur->id))
 			continue;
 
 		rc = iommufd_sw_msi_install(ictx, hwpt_paging, cur);
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 3b8067976eac..3cd617dfc351 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -196,13 +196,15 @@ iommufd_sw_msi_get_map(struct iommufd_ctx *ictx, phys_addr_t msi_addr,
 	list_for_each_entry(cur, &ictx->sw_msi_list, sw_msi_item) {
 		if (cur->sw_msi_start != sw_msi_start)
 			continue;
+		if (cur->pgoff == UINT_MAX)
+			return ERR_PTR(-EOVERFLOW);
 		max_pgoff = max(max_pgoff, cur->pgoff + 1);
 		if (cur->msi_addr == msi_addr)
 			return cur;
 	}
 
-	if (ictx->sw_msi_id >=
-	    BITS_PER_BYTE * sizeof_field(struct iommufd_sw_msi_maps, bitmap))
+	if (ictx->sw_msi_id == UINT_MAX ||
+	    max_pgoff > (ULONG_MAX - sw_msi_start) / PAGE_SIZE)
 		return ERR_PTR(-EOVERFLOW);
 
 	cur = kzalloc_obj(*cur);
@@ -222,21 +224,26 @@ int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
 			   struct iommufd_sw_msi_map *msi_map)
 {
 	unsigned long iova;
+	int rc;
 
 	lockdep_assert_held(&ictx->sw_msi_lock);
 
+	if (iommufd_sw_msi_maps_test_bit(&hwpt_paging->present_sw_msi,
+					 msi_map->id))
+		return 0;
+
 	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
-	if (!test_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap)) {
-		int rc;
-
-		rc = iommu_map(hwpt_paging->common.domain, iova,
-			       msi_map->msi_addr, PAGE_SIZE,
-			       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
-			       GFP_KERNEL_ACCOUNT);
-		if (rc)
-			return rc;
-		__set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
-	}
+	rc = iommufd_sw_msi_maps_ensure(&hwpt_paging->present_sw_msi, msi_map->id);
+	if (rc)
+		return rc;
+
+	rc = iommu_map(hwpt_paging->common.domain, iova,
+		       msi_map->msi_addr, PAGE_SIZE,
+		       IOMMU_WRITE | IOMMU_READ | IOMMU_MMIO,
+		       GFP_KERNEL_ACCOUNT);
+	if (rc)
+		return rc;
+	__set_bit(msi_map->id, hwpt_paging->present_sw_msi.bitmap);
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi_install, "IOMMUFD_INTERNAL");
@@ -290,6 +297,11 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	if (IS_ERR(msi_map))
 		return PTR_ERR(msi_map);
 
+	rc = iommufd_sw_msi_maps_ensure(&handle->idev->igroup->required_sw_msi,
+					msi_map->id);
+	if (rc)
+		return rc;
+
 	rc = iommufd_sw_msi_install(ictx, hwpt_paging, msi_map);
 	if (rc)
 		return rc;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 623cc608ca0c..54873de43eb0 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -32,6 +32,7 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 	}
 
 	__iommufd_hwpt_destroy(&hwpt_paging->common);
+	kfree(hwpt_paging->present_sw_msi.bitmap);
 	refcount_dec(&hwpt_paging->ioas->obj.users);
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 43fbc5bed8de..44d6dc94fb6b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -29,11 +29,45 @@ struct iommufd_sw_msi_map {
 	unsigned int id;
 };
 
-/* Bitmap of struct iommufd_sw_msi_map::id */
+/* Bitmap of struct iommufd_sw_msi_map::id; starts empty, grows on demand. */
 struct iommufd_sw_msi_maps {
-	DECLARE_BITMAP(bitmap, 64);
+	unsigned long *bitmap;
+	unsigned int nbits;
 };
 
+/* Grow bitmap to accommodate id. Must be called under ictx->sw_msi_lock. */
+static inline int iommufd_sw_msi_maps_ensure(struct iommufd_sw_msi_maps *maps,
+					     unsigned int id)
+{
+	unsigned long *new_bitmap;
+	unsigned int new_nbits;
+
+	if (id < maps->nbits)
+		return 0;
+
+	new_nbits = ALIGN(max(maps->nbits ? maps->nbits * 2 : 64U, id + 1),
+			  BITS_PER_LONG);
+	if (new_nbits <= id)
+		return -EOVERFLOW;
+	new_bitmap = krealloc(maps->bitmap,
+			      BITS_TO_LONGS(new_nbits) * sizeof(unsigned long),
+			      GFP_KERNEL_ACCOUNT);
+	if (!new_bitmap)
+		return -ENOMEM;
+	bitmap_clear(new_bitmap, maps->nbits, new_nbits - maps->nbits);
+	maps->bitmap = new_bitmap;
+	maps->nbits = new_nbits;
+	return 0;
+}
+
+static inline bool iommufd_sw_msi_maps_test_bit(const struct iommufd_sw_msi_maps *maps,
+						unsigned int id)
+{
+	if (id >= maps->nbits)
+		return false;
+	return test_bit(id, maps->bitmap);
+}
+
 #ifdef CONFIG_IRQ_MSI_IOMMU
 int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
 			   struct iommufd_hwpt_paging *hwpt_paging,
-- 
2.43.0

