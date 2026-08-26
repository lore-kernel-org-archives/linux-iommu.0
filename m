Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175F44C518
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756005; cv=none; b=rGzNDGWPLI9S3TjGxyJjORLHcmy8Rcz1oRZuIMzsV9bGHXUTWlAj3q7pazHEmgndxy+0RqGkT4i2YIeNylxBjsRFBpkHfdWALomrpas2wDxp0EgTh9l9MQE70fJxS8nQneAcs6giJ6rI5WksPy++8mLoDgG0H6kTYQUIKuDm/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756005; c=relaxed/simple;
	bh=8HiNwjyq1vjwoAfAkbPp//4KpZ6m4wxpLdb5cYJtqFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZqhQc2DRPh738wmEkbKf37gnGYmFtwQfrUVnpaAkWGUmnB9nihOQqXGd933dgjgz13XoDJ+VKw2l+sgtrgoexAv01VSlM6DIAuAXd0OL0ImlER+otecr380Y16gXuwkG/NJfv6veFZFnP3LHtdinCWHQb36mCtX6bnUF6RYOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F4BQriiR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BytoTWeS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F4BQriiR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BytoTWeS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDv4Fk503650
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=l+wO2YNnEaL
	XrAQk2P5XKsnRLtuMJ3Ijr8ghrcqISrk=; b=F4BQriiRTl6H154dJwEadc43NPg
	gtvTEYHtbelPxHw24ruq9Za5cpT2bjw0Dz9BfV3dRq7bJvvlT4G8Cl0WyNOn4HsX
	AaUxENLmXigV2vcNe2FX9WqGbfxjxTYi+XBRihzeFk5hZpsFmUJm4UOfac2crsRp
	knP03cvWEku/kHf39X7rV7BUWGTPpQitQPbc55RmyaUqIxDpDXRWQ7fWOa3npr/B
	n4JdbkBvvRfE/+s5oPltDS6DuyUexgCQBYWpzm4X+4XDpiITAUxwdragP1hTvYNZ
	J0xFohQWWD0oXCd5nq/Mej7+60S0ipvB2owfX0ALuGqDWH1WkcTbqInhtbw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03u0kau-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:53:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52ee59064d2so4891011cf.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787755999; x=1788360799; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+wO2YNnEaLXrAQk2P5XKsnRLtuMJ3Ijr8ghrcqISrk=;
        b=BytoTWeS2JaSClc0Y1W1kg3tH+tzy9lFziAtW4/mGeQ40nQl7I8o4wEr3Km4ssXZJj
         8KW1LSoxQwLc9lhbyFTOVDBdhryKsZKjW290dM+nj9Qifp0tKIqKwFYi/mi8UIQiKBS7
         Aaq2Iq/+FU1s/q9/V5gpFMBQUVnyefbuT4r0Fj12QCLlzJsF+vf+egzM1c+7ukEJFafj
         FkoScA0smeLKBxOPKYS0stWmkNYPnzgPb/Hiw78vQpTaHh0mkB+E930ITHFvOgTifnPe
         c+WM24mGHnlR8Gpxu9dfkn4XhuLTU3z57qF9T1Et5ji/CyrnjUVbtdO/lM4dGx4QfMLg
         2azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787755999; x=1788360799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+wO2YNnEaLXrAQk2P5XKsnRLtuMJ3Ijr8ghrcqISrk=;
        b=ds38qymh3AcBSehh0wDuVL8pgBk49R3Bg+UH7hQnK9+ln1JTqrtw6xIeOLTpcMolia
         V2Ofe9CxGVTZl/3ooHiU0YKJOMPhg4+GxqxwK1MxXRhjYBsQdG1Wl9+auFzaP/LR01Bp
         nK+9xsW2N9UWZ5Pp1ZFswx+8Ji1dms+0CvksX00JwWSFA70e9VX225fUUnQ/LzWsPaDu
         DZlUYPlwB2SdeqK/EAGTGp7uSoNZCI9YXBOWNdFHOgeQpcBH33SMzKRmXhnmZFOZpt7J
         38bv30qZVHmZfwFHHFdAAm21iFrVIpKcbMqFOY8bJpmwv5GL7mWfpEJTb3QRxuYp3TnW
         4Ovg==
X-Gm-Message-State: AFuF++kl9z5uBvW1/Tmf+4GkO5bGpyEzpqWdXzkHXU+Oui99aLdkhIz1
	eyuJrA0TFgVIlHWNJ09CBo7zr6YCs8dNP7bs3J9kozwUZMT/I6HsMTaR40+eX2coQTbICK8LGKx
	Iudjm1RMxnlrpFLCLVMx8mdnkUo+7xnTyhxOQK4IAczJfFGiA008Zo2ibNao2NuQxeA==
X-Gm-Gg: AR+sD11yKWS0FIhYrMSYyR2+uh9j1G+HfZrGPvhc432/MAgttd9AQP+AjfBFcCA+qWH
	eNSRJVsQsXqdqjp9Ozhr9x7UVE29Aswi2bFonZuKX8gr4oWqJ+dNdWqiyYdH+afOZt9kbD8H8l4
	C/tGJFLPcKa751LdV1JInB+283Gi62Ao3oSpJ/8Opjqze253MrP42/n9HGJZrpdQTAbCShgOI+R
	ueYUQmUkdNgBRn/NPpZAbBAhOZprZyt0ilYedDYlGhdNDyhCEXSomFN/Qa4vj2dOOd/gNCLszU4
	CRzXpEXr7K1rZOm0ko3IoxR6gOxlLMtU7Pe9O8kP9FDJLNpyjYNgn5Cs3U6AlDwtArFIpX1SwU5
	wXRZy07J7
X-Received: by 2002:ac8:5c84:0:b0:51c:291:82eb with SMTP id d75a77b69052e-52e2ecc055bmr165468831cf.14.1787755999108;
        Wed, 26 Aug 2026 07:53:19 -0700 (PDT)
X-Received: by 2002:ac8:5c84:0:b0:51c:291:82eb with SMTP id d75a77b69052e-52e2ecc055bmr165468161cf.14.1787755998546;
        Wed, 26 Aug 2026 07:53:18 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8ea655sm4777485a12.12.2026.08.26.07.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:53:17 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca, kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
        will@kernel.org
Subject: [RFC PATCH v1 7/8] iommufd: Prepare software MSI installation for address lists
Date: Wed, 26 Aug 2026 16:53:01 +0200
Message-ID: <20260826145302.449904-8-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfXy1nDn9MD1gdh
 CICWs/348asOmlPr8BRvCGhdszfGyTC0Y9X4s/jW26OKRJWBByl52clWc+ee1aZHdSLV7StYo4o
 31m6vCo4RAPUGgMtX/ZfO+4qnnob07SslINwGNImMLL9idmlxVYZCPxneBeAJ6knJ7WJ8l2BGjD
 Pvo04Mok/5mUG+gitmEt55prEyrqdOnWAnMYU6K4oruOeLJakortXdetTMKM5/EnJVXmKSOrXre
 OJNRjwqHAQRYvJ5YOEtM4kbe1fp1yZpX2fa3aQ8K28ncsP8UwgaKQVlfIpzGSQ/YvdtDI1JpiSb
 QXO23JprIwtpPX4+fAAL5WciuX2buybp462RiQA4llApLENYeq26JFCWBz/LsX7Jeu/YjYl5SJ/
 Ul8uGqG9OloS9GJ+OvAmYek36BWSKidYZkkLl2TbQ/auaoKLVtWeDzPcZJBMdPuk2f2wn5sgix1
 KFGT/4IaKpdIK7dFYgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNCBTYWx0ZWRfX54sYhxvF+xo7
 XwUvNe3bGaSR3P+7CdEG5lROFm824qZ2QDp/vYgB320d249JGnhZFJ68e4kmgwY83dNkujrIkta
 jvzb11LQPV5kRa6FDvKSiWEYoCddM5I=
X-Proofpoint-ORIG-GUID: tqGXl5xdO_HpDpDU_ek7Ki61A859YoPJ
X-Authority-Analysis: v=2.4 cv=RcqgzVtv c=1 sm=1 tr=0 ts=6a8efde0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=fyE6B5mSzfnmm1qxREQA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: tqGXl5xdO_HpDpDU_ek7Ki61A859YoPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260124

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

