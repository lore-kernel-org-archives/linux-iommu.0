Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741B4CC624
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349451; cv=none; b=RqdQ3Hrk7cB88MUyyPO+OwWle/vn0MXzgFgA5y6U8e8OSjQhlw7cfqGUh1twdONIrsz64KHQ4+Krnsw+ySdkK22y97hniOs07sfj+EjgnxA97siFGUwwzNcAO0sWM+CtwxRABJxKy+1V4bQh8tmVasPEgtWSdRwh5ht+9sswuH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349451; c=relaxed/simple;
	bh=KxurCe6pgQSQsY1f+dOhy3ExgK0ecAyXvRk9c+RKIfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ3uzfWPFkSrV0B6lUxgYsJcnFjYLwl1Gpa4EGjWKX3ubgF3uoRowhv2c2CFeXmTkAy/2G59HCT6+Clfe+/7TsH+PitJyunR9eXBVBGvgv4RLFAmAm86VyG7F+qysMGWXyQLmnJnMoxD+O4NgDq74DJ1SLIUoJDim4va665RQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KcFLfWbn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hcj1UQIg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KcFLfWbn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hcj1UQIg"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PA4D0o609155
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=t1fCrnwj5QJ
	BWHsPw8FOuYqTuNXRMPlCtQWMjUzAOhM=; b=KcFLfWbnuA8QS9fwkAXrWsLhWHA
	8L11ss1tOZwqZoDQEkdlUaMj6ILXLvFhiMGGcfJcH6TCZ39qwC15MDV+IXpuKU0V
	AT6hPYLpK4ns1Bp/glA60FWSE734uatcUGc6OBmqb50icAAUGJGbn8BOc0f/EB87
	hGNkqDg5/mlblrpz0RKV09Y4PoUpwWkS6McAysrsqMt8ibuawQWSEfz/78Z/QOBE
	rMCNU4vQwu2wI9SyJt/YgP+huQOY38diVJpuOXDYIDkkhE0bORxHukeBeocmTOi0
	L4SRZAShrO9B9nvApSUvj5DyLvoN45VZ11ZX4bOyDv5VavXUFOXsbR3r6tQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvns172-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:16 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7a77961b860so232425137.3
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349436; x=1790954236; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t1fCrnwj5QJBWHsPw8FOuYqTuNXRMPlCtQWMjUzAOhM=;
        b=Hcj1UQIgd8ZGijzhV9YNyvErxgtG0Jc2c9i/lmFXiJ7b+U3l8NH8Nof+hbpehEVE7P
         6rQe6fSMwGLcEbYESTuHq47hv6N/bkIdg/OBPtUiyuh4/D+hqoNpEQuVDVH08YlSc/aw
         aa3XZgBDGN2jdpp20y6l5rbIhT7cm/qUbnMxERunSE0pO5R79HRzFocsZLJPBV7rK5X2
         NU2bVqolcYBobyrsFmFMJwRXwH46hx+fjVrbTtsKRTglAepjTuqrGdqDQg55NMPmHls2
         WfsG2gdEhiJSr72bcmvibTIe8E2ggzArEmu1AaWd3RxmEJiTbZpw0j0HM2J9GfjJGAyS
         IfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349436; x=1790954236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t1fCrnwj5QJBWHsPw8FOuYqTuNXRMPlCtQWMjUzAOhM=;
        b=NwghfUM4EF1OY+M4LDMk9TtKAz21I3G/n0O74az1K1qUgbduv14sn5iYDMT2Km/jAj
         8oBFWkTCgm/C1Frvr6bp3cLajGf5WpmITeL3mtDTn11YMzby4niDPt6Ggn5k7QXvpjJk
         P2dj46H+cbat03JEQ600cSrTv1hm1vaWDlMDlZlTGKL/vakxGcZKTZz55Grx/lzbCt8m
         jFKRp2e176r/UPxJ4hLCCbhyPV62KdAAu2ewA4vTEAbQG5rrOmV2TZ0n9eBtu+Xgw//I
         3y6RCW3fBOJ/oOakMVB8+ExtYHY7/YHHQQHk48nIvOt2EWO3w+9N8oIKsgDVIVEZPoIL
         eWlg==
X-Forwarded-Encrypted: i=1; AKwUvBxnsW0Axd0b7+cEKdfiHKd/VkHUhjXV5d3INPcrUExwFzkBeBtMZ73L0h5zEh/MYneLGRw9UQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kQYvzmKutZjPMuryxkQ8hPsV5HzalFSaoRC2KUtoHB3IlmRaZ/
	tJkMGo3AIYKY7LhTGkJR0Yjs9Qem/LoJSf/l4kACsMvLJR8zvxYosDD9elcYevjhsS/0xiS6SxF
	rURQWPdCUej5x3oAshlDmDIp5toWzVePwlx3MNygOTXMD1y2jF5S2jbJX+NEou6H+xA==
X-Gm-Gg: AYBFou2UBvF2OI4aqUz4WzLsnmJJ3ReB9MCZgZMLxAelsfazBOOIpq8/PpZ1Rw6BsZ3
	sUu4t/Lfd+KqBqF2+JrbleUJXHnrEPOE/mYdvBrdPWFguCpeRp9oh/a322R6UGp1ppUqnx4E1qi
	jX2WM50QYr1jMtKIw1VFEXDvTL/wKEKX29fO3ShWxZOtTbLQOCbfZkh9bcke8/g69EU5IfX91ui
	Aqa+jhnqdagixajNBWynDWkV0cne0ecsYIbN914fUTeXNNQMJJ33QxPn0eEUt8pLzv1RQT9w7xv
	ASb9VNGRj5ETJEELQCKmVZSoLV5wjMGdfZBf7qWLDcrRGx4jOQZnjObxYEvpjyFyEugZ9Hrz3d6
	1DSx27MXG3hc6vR5FmkKtxA5W9tFbfB9VzYWQcQ==
X-Received: by 2002:a05:6102:2910:b0:7b3:21da:d255 with SMTP id ada2fe7eead31-7b321dad719mr335049137.32.1790349435912;
        Fri, 25 Sep 2026 08:17:15 -0700 (PDT)
X-Received: by 2002:a05:6102:2910:b0:7b3:21da:d255 with SMTP id ada2fe7eead31-7b321dad719mr335034137.32.1790349435442;
        Fri, 25 Sep 2026 08:17:15 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de187asm153857745e9.7.2026.09.25.08.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:14 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v6 07/16] iommufd: Prepare software MSI installation for address lists
Date: Fri, 25 Sep 2026 17:16:50 +0200
Message-ID: <20260925151659.419512-8-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: XP3kRQgas-tP87LUmZ8Botjxw6MXe533
X-Proofpoint-GUID: XP3kRQgas-tP87LUmZ8Botjxw6MXe533
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX9P/j1urBOUvL
 aBNRXqixeEJl9s6SScocTGeltt6gY1PM/myLv4UYXhwKGRljvc3wyyYFx1Bh/5QIUPkIHvl7URL
 EAgEN/0P1grNvZ06h1izdGQczYwWW5M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXx5IiSorZ/+lV
 pmzwrrg5sJdDGTP1NkMKJIH9RS3YrYkEkGvMSsZLrjhoKu9KwgA2lXl5fnx7Dese1gRZRFxodz2
 l5YGyDni3cxin73A9D8PS0PrePrdx477qGUHgigvFR4BVelUZFNGjP6jheVb5gqpEbCIcP6sam0
 X/KLLlT1w6ejkaL6kYLJbr+keDV3mg5zGLKlSxVmTnsrRnKLDmuA8R/XpBf23Q9aDs7/48q19oR
 E4GaXnFU7Or0KK/ZyDC7fi9o/izw1l91cWBUmnX5eQbwe+j53zxbmRIvnCrUcPOfEliv7Hmn5ne
 tr4rsQ7RqeR8HSndn/o6jIunbRyYkDBZmwr7XEVMsgwEC9eX8rNlNm/I58BwzCmwWrnUl40JFeX
 P3x52mND6U43RLKafT+5TcKci1tCxy6VM3OkcFQcXIwU7Ls3DcV0sNKFxXKsQ6Le0WwE8F1oP6M
 OBJW+6WVTkcBJ/n9wqQ==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab6907c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=SRrdq9N9AAAA:8 a=fyE6B5mSzfnmm1qxREQA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250060

Teach the software MSI path to install every mapping in an address list
before publishing newly allocated maps. Mark the complete list as
required by the group and roll back mappings installed by a failed
operation.

Keep iommufd_sw_msi() as a one-address wrapper so existing callers
retain their current behavior.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/iommufd/driver.c | 101 +++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 3aff04d9dd04..f4e812e43822 100644
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

