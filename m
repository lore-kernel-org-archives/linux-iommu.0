Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C2E4A6CED
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188401; cv=none; b=cwxivluyw8MDNGZryed7XDYk7knZ31gudUyN2C9hd8Ts12eoDEMnLFY929VcXPVAb8Yh58QByndFI/LDv6/yVfbvuzeFy0mpqMpCnrrz5uD2CFIWH1kLGvPs7CauWjJuTveXAadKW2gd5NsRvfET/WRMkVkuKKeHlhAYwKMrB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188401; c=relaxed/simple;
	bh=8HiNwjyq1vjwoAfAkbPp//4KpZ6m4wxpLdb5cYJtqFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mamXWuWsBDGG/g5xQvdM7S+BhDDlimkWh+t2aecGrReUz8t8xKi70fcTIzp0dj6rhAXNj6AUmZMNQlWHAXsuaz/hKNc5Rlp6YHQ6T20lJkZXg2CmjFDDHk1jn6HJXUm+5E9Cr+Qd6cvmMvZBqveqsXmK+3eiAKeKKLqW3S77lHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=glyLadnV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IkosCOGh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="glyLadnV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IkosCOGh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETWoK3296759
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=l+wO2YNnEaL
	XrAQk2P5XKsnRLtuMJ3Ijr8ghrcqISrk=; b=glyLadnVtfQteledri6mEzwwDiI
	IoRauTHIAyauECNeinQ0XUxMGZQ+4D/KatKY2W8rufK/AcaaDD+ndizr5cpduIsC
	EKgKkuOI/kWryKFRDFr+A6nNzpjyhcs5A5XHWeGeptpK+Cglihio3e1rPtJ+IvgK
	TPBgLqxYT2B33G2vVABNuSWKwGDo5s9ibfuv+urmokGcCMHJU5A9z6ljbnl9qv5j
	6jkVyagqkxLqiafR7U20ZmtLPE5UY/chTemyWZaCHUkpNctWXLVasoG0Ca4ldCzp
	WEePGIMyBPjbJga9BIrgbDG7Wo0A9PTrIjptJaSoUE4IPSQo4ArytbwW7GA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6ayhhxm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-938153538caso628939585a.1
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188398; x=1788793198; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+wO2YNnEaLXrAQk2P5XKsnRLtuMJ3Ijr8ghrcqISrk=;
        b=IkosCOGhp/V1+nnhTkVzxW2mYY0erBwO3WMLpkYCVqgzhEf5s/Hd9BO89j30h2eQ85
         ySi08zzz8nBowwOtJLHxJTiDrpfw/uCItcJq/Vyw5tCS8YwKKsFB9kJzJr4NIXca78bG
         zhCvALP1CgJDaB7NcG8VovnzhgqJy8xgdvZSwKnQJvEC0rsVfZ58xW7X+/AwUMGQsPXi
         tYBrG+aMw4jHMhALQsVXZLQ6qKJKLWs+BoI3Ug2HnNSb7DhzQjBV4GmyyIV60k6edzb4
         N23zyCqEI0+LmX+oT0Y3BVY9fXEnBtkuiYU/HjdyTDly4EdqpXFEe6HxyiA7SMAYEnQF
         Drtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188398; x=1788793198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+wO2YNnEaLXrAQk2P5XKsnRLtuMJ3Ijr8ghrcqISrk=;
        b=NcfLzBAb9pR6mZ32t+TyTo7kWP9rYvpsJ4zgxeqBnQLivn5MobDP8Pb3640HrFF0yb
         Nqnx5UIIKsu3nSedb5M+7rOt0g3We3KPK14mJOV0uO83cvCERp+fxd0XClF1LNvSybzX
         3Z787Wsjxs/hEuH1HXnLeQcFjFURNL6+8r++31DxCrjg41mbjAx7YJjJjKGcx7DVpEzP
         LPAGLUTJqNK890wIQsvpNdsjma1x5OufOj93xsp2Wtge6Z50TzDszPv3u+q/LgNy4WIm
         BPsG1NNPXBx1ltQiLsvgfK7KTM3OGK1rVBHrflPH3GKhE98kBoMvMxpqvDn+XIkhwGnc
         y+8g==
X-Forwarded-Encrypted: i=1; AHgh+Rp3ig9QqB814XBpztOzOhhggtDx6lkGVsji470R1t/FDj45AOabgM7b76CQ65TxJ/Rt1lzx2w==@lists.linux.dev
X-Gm-Message-State: AFuF++nsCMiLvorUFZxVdMQwYyocax0mt36eY627USXgYZCl+3p7+C05
	LsI1+JK5AuhCyi3l3jrn5b+Bsoa9E27OJ6LXwB0ZaAkcbjrLl+7mxAUa0rYOpih1SwW/9xK/dFB
	FURbQS3s8sHs1dydTBAap2bIufRRHBHKtkKvp/EblyAkuKvRU6yEIrmrEtw==
X-Gm-Gg: AR+sD12SgQa0+JzQcJeFlxgd15UK3EJQi1ZGGuFzD071tgQal0rc08/ULGhwkWLKTnM
	Oc1atPm53QfOzlnZLM7zG9bcUBgUNgITLf2efvYv+lLncZwldn2pkXIXNWU6YU/D6MkBPhHC14F
	oa+UTVRdt3pcWXArp2QVEV16Km6ka4pl3KNW/VFo/qws0vmbbBjCwpmS7z6qzF7pnC+VbBWrQAB
	gI+FIuBQGf5nEFx5E+OHTFEfbpbZrVa9IWUIPwM3RkJdbklKzAKpxru75ULeRZuR+VnQEHkS/lr
	3QTX49LfiFyj0mbwhJGVm92uM5eipr6yzn9ke1eNVk8thSfVeOy+q21BbEeI8R/n/czSQAknU37
	aux9It072JW6aBk2sZl7pW9ztW8nrkvleE6w=
X-Received: by 2002:a05:620a:a404:10b0:939:209:c805 with SMTP id af79cd13be357-939138015b1mr2421460485a.12.1788188397662;
        Mon, 31 Aug 2026 07:59:57 -0700 (PDT)
X-Received: by 2002:a05:620a:a404:10b0:939:209:c805 with SMTP id af79cd13be357-939138015b1mr2421451585a.12.1788188396956;
        Mon, 31 Aug 2026 07:59:56 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdb13f094sm40886845e9.3.2026.08.31.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:56 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 07/17] iommufd: Prepare software MSI installation for address lists
Date: Mon, 31 Aug 2026 16:59:33 +0200
Message-ID: <20260831145943.313726-8-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXxHCjfu4O0YWc
 gj29bNRe2gNWLVz9bnTF3SsDJ7YagKS0E3GJH/TywKs+Gyfz27uTGucHCiE5lelkTSeRg1FJjko
 tCPkEmo17cyrOuguFVZvG9SGMreW0Qw=
X-Proofpoint-GUID: qoUUwJfv4wIjLEOqIajLZRNsctZcsT-o
X-Authority-Analysis: v=2.4 cv=CYE4Irrl c=1 sm=1 tr=0 ts=6a9596ee cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=fyE6B5mSzfnmm1qxREQA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: qoUUwJfv4wIjLEOqIajLZRNsctZcsT-o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX4lIxuX4TxNGL
 Ns/kd47Zlfr6nXG8W9Q2m+YC6q55zVJ2vv6+noLONJZuX0M9C4x71Vml0TyWbd45V3nkhbAMYDj
 8/3JiF3y7Q9mAAAOjwylUplbGw6+4XbCnohISthWXsezeokBwQTfEItLKOryQ3plWZ0X3BvSjUi
 03120M1G871B2hxrLc29MtxnXwervR+6q/M54o8GYGOqldsf3qE8e1qes647DStHmMYWqPwhbwH
 saDxd82mfUd9aNqutkji4VdneDfEpL/APfOy9J1n+tyKxQ1kEeI1lZGcspGLxEWilFID9yEZ8uw
 QmpXvV1w6BjJrfULAmjPbHR3IytQmqKjYwO72QyGPZJSUpULupWpc5oBTZ1aPg59m51mdRKkf4c
 2GDQokm6TecBzDr2+fjMusNADC6h8goMuB9KpfNnuKCepBMZunKaJ0L+x3Ss7zBiG8lMNpod7NV
 8H4dHqSawd0RyQHEn5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

Teach the software MSI path to install every mapping in an address list
before publishing newly allocated maps. Mark the complete list as
required by the group and roll back mappings installed by a failed
operation.

Keep iommufd_sw_msi() as a one-address wrapper so existing callers
retain their current behavior.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/iommufd/driver.c | 101 +++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index a43a25078f87..45278c11c688 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -340,14 +340,14 @@ static int iommufd_sw_msi_install_one(struct iommufd_ctx *ictx,
 	return 0;
 }
 
-int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
-			   struct iommufd_hwpt_paging *hwpt_paging,
-			   struct iommufd_sw_msi_map *base_map)
+static int __iommufd_sw_msi_install_range(struct iommufd_ctx *ictx,
+					  struct iommufd_hwpt_paging *hwpt_paging,
+					  struct list_head *msi_maps,
+					  const struct iommufd_sw_msi_map *base_map,
+					  unsigned int nr_addrs)
 {
 	struct iommufd_sw_msi_map *msi_map;
-	struct list_head *msi_maps = &ictx->sw_msi_list;
 	unsigned long *newly_mapped;
-	unsigned int nr_addrs = base_map->range_size ? base_map->range_size / PAGE_SIZE : 1;
 	unsigned int nr_found = 0;
 	unsigned int index;
 	int rc = 0;
@@ -392,16 +392,36 @@ int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
 	bitmap_free(newly_mapped);
 	return rc;
 }
+
+int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
+			   struct iommufd_hwpt_paging *hwpt_paging,
+			   struct iommufd_sw_msi_map *base_map)
+{
+	unsigned int nr_addrs = base_map->range_size ? base_map->range_size / PAGE_SIZE : 1;
+
+	return __iommufd_sw_msi_install_range(ictx, hwpt_paging, &ictx->sw_msi_list, base_map,
+					      nr_addrs);
+}
 EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi_install, "IOMMUFD_INTERNAL");
 
-/*
- * Called by the irq code if the platform translates the MSI address through the
- * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
- * allocate a fd global iova for the physical page that is the same on all
- * domains and devices.
- */
-int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-		   phys_addr_t msi_addr)
+static void iommufd_sw_msi_set_required(struct iommufd_group *igroup,
+					struct list_head *msi_maps,
+					const struct iommufd_sw_msi_map *base_map,
+					unsigned int nr_addrs)
+{
+	struct iommufd_sw_msi_map *msi_map;
+	unsigned int index;
+
+	list_for_each_entry(msi_map, msi_maps, sw_msi_item) {
+		if (!iommufd_sw_msi_range_index(msi_map, base_map, nr_addrs, &index))
+			continue;
+		__set_bit(msi_map->id, igroup->required_sw_msi.bitmap);
+	}
+}
+
+static int iommufd_sw_msi_list(struct iommu_domain *domain, struct msi_desc *desc,
+			       const phys_addr_t *phys_addrs, unsigned int nr_addrs,
+			       size_t granule)
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	struct iommufd_hwpt_paging *hwpt_paging;
@@ -410,10 +430,19 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	struct iommufd_sw_msi_map *msi_map;
 	struct iommufd_ctx *ictx;
 	LIST_HEAD(new_msi_maps);
+	struct list_head *msi_maps;
 	unsigned long iova;
-	phys_addr_t phys_addr;
+	unsigned int i;
 	int rc;
 
+	if (granule != PAGE_SIZE)
+		return -EOPNOTSUPP;
+	if (!nr_addrs || nr_addrs > SIZE_MAX / PAGE_SIZE)
+		return -EINVAL;
+	for (i = 0; i < nr_addrs; i++)
+		if (!IS_ALIGNED(phys_addrs[i], PAGE_SIZE))
+			return -EINVAL;
+
 	/*
 	 * It is safe to call iommu_attach_handle_get() here because the iommu
 	 * core code invokes this under the group mutex which also prevents any
@@ -434,33 +463,33 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 
 	ictx = handle->idev->ictx;
 	guard(mutex)(&ictx->sw_msi_lock);
-	/*
-	 * The input msi_addr is the exact byte offset of the MSI doorbell, we
-	 * assume the caller has checked that it is contained with a MMIO region
-	 * that is secure to map at PAGE_SIZE.
-	 */
-	phys_addr = msi_addr & PAGE_MASK;
-	msi_map = iommufd_sw_msi_get_map(ictx, &phys_addr, 1, &handle->idev->igroup->sw_msi_range);
-	if (!msi_map)
-		msi_map = iommufd_sw_msi_alloc_map(ictx, &phys_addr, 1,
+	msi_map = iommufd_sw_msi_get_map(ictx, phys_addrs, nr_addrs,
+					 &handle->idev->igroup->sw_msi_range);
+	if (msi_map) {
+		msi_maps = &ictx->sw_msi_list;
+	} else {
+		msi_map = iommufd_sw_msi_alloc_map(ictx, phys_addrs, nr_addrs,
 						   &handle->idev->igroup->sw_msi_range,
 						   &new_msi_maps);
-	if (IS_ERR(msi_map))
-		return PTR_ERR(msi_map);
+		if (IS_ERR(msi_map))
+			return PTR_ERR(msi_map);
+		msi_maps = &new_msi_maps;
+	}
 
 	rc = iommufd_sw_msi_maps_ensure(&handle->idev->igroup->required_sw_msi,
-					msi_map->id);
+					msi_map->id + nr_addrs - 1);
 	if (rc)
 		goto err_free;
 
-	rc = iommufd_sw_msi_install(ictx, hwpt_paging, msi_map);
+	rc = __iommufd_sw_msi_install_range(ictx, hwpt_paging, msi_maps, msi_map, nr_addrs);
 	if (rc)
 		goto err_free;
-	__set_bit(msi_map->id, handle->idev->igroup->required_sw_msi.bitmap);
+
+	iommufd_sw_msi_set_required(handle->idev->igroup, msi_maps, msi_map, nr_addrs);
 
 	if (!list_empty(&new_msi_maps)) {
 		list_splice_tail_init(&new_msi_maps, &ictx->sw_msi_list);
-		ictx->sw_msi_id++;
+		ictx->sw_msi_id += nr_addrs;
 	}
 
 	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
@@ -475,6 +504,20 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	}
 	return rc;
 }
+
+/*
+ * Called by the irq code if the platform translates the MSI address through the
+ * IOMMU. msi_addr is the physical address of the MSI page. iommufd will
+ * allocate a fd global iova for the physical page that is the same on all
+ * domains and devices.
+ */
+int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		   phys_addr_t msi_addr)
+{
+	phys_addr_t phys_addr = msi_addr & PAGE_MASK;
+
+	return iommufd_sw_msi_list(domain, desc, &phys_addr, 1, PAGE_SIZE);
+}
 EXPORT_SYMBOL_NS_GPL(iommufd_sw_msi, "IOMMUFD");
 #endif
 
-- 
2.43.0

