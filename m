Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71955353A8A
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126642; cv=none; b=gfh9oYoTvYyvxlEoRRaCeEOZZhp898WUSaR4fydmQ5bjEWFSCR6jZvKgGOkB89Tg1igHtgyeO2cN3OOsynGFSvuC+R0witL7n2sh8iGNOO7Jejr2zooP//AozUClSJfubhdkQS48z3c220AOhjviBfjoPBC+Y5sOG+qpj7yIZRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126642; c=relaxed/simple;
	bh=cs8xqe5jTSTMP/cRFiAHim9r9cnzCfBWDanSTu/cBjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJLhO6G1lxNAyDVQC9Rsg/FEKJwe6dXr9yoeu263V3EhVenJAqVWRVvTjEchjqOV2GGrpMTVtbZwi1s/eF979c5MZL9fhDTogSy8uuyJwDY/GHM489f+cgcXcSsohTzKtILfYS55ammv7ouoZppCBNO6fvXLyGr2Liu5gnjucxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jSTHZsQN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XNUCkMuH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jSTHZsQN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XNUCkMuH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GOGtv769888
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=x4BbeW4tbgB
	s5QyG02520XP2wqPwKgkuyyfFvzacp9M=; b=jSTHZsQNCDus3Y1t7VZCEp9azzF
	69zt/DYBg9EUlNYPu2zli6aNtxnqU8B5fSpbW2tCsPXPmyRfMq8VndH/qm13Rz7e
	jirJWPIFU3VUq8KLI/U1iSaleJ9O2xsvHWlq1jb5NoDmZDtbrkLUf1B3cfecnfnP
	bs7AxK4bli6sKg6bTr6NuCS1vAueYZSku/TihPYrazQvKt2kM/ADBNYkQE7f0O5B
	sKbmnjKytU4a+oEHkcvIwghLnCMo/Vx1SZAJFnsOAaVv0AYxN6jCxTZ9Pj3aOPVn
	P+Nx3kysuGL+ufNDih1r5cU56rZNx0WPtB1E6lzLeq6OEZAvNKjFYhNfaRA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fw9vu2uy6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:19 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0f0a0760so62193961cf.2
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126639; x=1786731439; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4BbeW4tbgBs5QyG02520XP2wqPwKgkuyyfFvzacp9M=;
        b=XNUCkMuHnmTcHyDvFaDdxpgPKPINcLXwwvFlNXIQhsht9QEgZo/m/Qz5sNEEKdq0qK
         SZcrgf3NuEoupGJ2fXtgYquRCMkXSLi7+IPXvTzDP/RymLyDb8+UFSgkxCAp/VcxgJso
         tGVpuW8jieiBw0XB8Lrmcf0WuZclviCrsJel/Td9vmdvIFqV72w0K1GGMqwRyyL5iT0O
         o5Sn+6dkTR7bMS478naMIPxq03zrWN3kpYzIxZrrydyB/W7uQajkz/SAgfT+t310Jvrz
         TwXHxOK6LJKLBTn72HJ2b6MK5UoYgty4QXqtVO8LCH9Xwj62mMVPS5/hrtHBv6fO/Cv0
         m7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126639; x=1786731439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x4BbeW4tbgBs5QyG02520XP2wqPwKgkuyyfFvzacp9M=;
        b=fG8vIbrqHvI+EwXbHUc6E3HKuQSVJwDxApjg81Ge3vkAYKtP6L9ffe4QFgvNoXdm46
         7E1jGyjrL2ZAWwiavpGoiGy/d4MILi202QOmUjhxm7n73TjRMsoZC5bQXXS3Tj3bmbFl
         J9Y/8PviMoKpMcLJSiX2ronIGn+QYTYApVs/dHUeHV5AFhG8567nlwvs5yqYabyX1pyw
         K5IQs4DnbxWSbmiHQN9desxHK2wG2+liCx7tBCBOFqcxJCxE36gQuxPZPI2wMlsRR78b
         WWo/amExK3CNGTMY3913zCKgNWI3aEw0RWJSWEuL1D+Qf2oJXacpcY2EoIC4rP+VuD4J
         qRmw==
X-Forwarded-Encrypted: i=1; AHgh+RoXEFmwHF9YfsVIqZFxjhY6Y19pqQI9erEPVh2AN2MZgh6POyxtXq0dOz/1TICNtMIloPfC+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzT7G/fM02WjEU2mv7PqAiZOuXhqlxZwQKVYvGpD3MmPzq71205
	yYXnh6xFieixH8l7CZZ0LpabT816Pp/B5WE8VJAzm+QbNMJrIsHwlxmhyq6eQjWDF1741FPecht
	nLNcCR+1u/eDjvOjE4xr/Kl9GDFimv0nfkG66dX1lpPCe4xESF64aLwPltQ==
X-Gm-Gg: AR+sD134xJ42AHHdm1w4UH4si1dpW7W6k3WzHRa0xNCvZpfUfKF8TZFlVfEB+lcUxWx
	yH2cON9OfPfEuGXN2ht6ownQQ8Pt911bKMkAAW5p2BScWxQgsQVxy7kAjbI8R+rF0B4eEuI7NDx
	2NuDIFpi6AW+BANevcb/VfywidoG6zpRCHKTiekhv/MO4cJzYQLQtmP/I7hJ2nUX2OPgQASXLnf
	RF7Vr/tNdJq5AUh7KnMlWSnYNv2mY8KvUn2pSK/zyDkiZ3/RG0HiwQ2vLn/MdE0SX3AMr/EIVpE
	1ztGwgvwTvrvltOkVAa802Xkdy2Wyk4ETHR+GOXM/Dt7FWDfLiU3QRB8imoyEafDg1AmbIZzZh8
	vxkzhq9lV1FuqxU+56FNEw2dtf81LAxZGGMRu/F8=
X-Received: by 2002:a05:622a:451:b0:51c:1006:a024 with SMTP id d75a77b69052e-52d20a9abe2mr32327261cf.43.1786126638642;
        Fri, 07 Aug 2026 11:17:18 -0700 (PDT)
X-Received: by 2002:a05:622a:451:b0:51c:1006:a024 with SMTP id d75a77b69052e-52d20a9abe2mr32326551cf.43.1786126638220;
        Fri, 07 Aug 2026 11:17:18 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7cae4d1sm857274a12.11.2026.08.07.11.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:17 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 01/19] iommufd: Convert struct iommufd_sw_msi_maps to a growable bitmap
Date: Fri,  7 Aug 2026 20:16:55 +0200
Message-ID: <20260807181713.228535-2-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: r63wTQ-bOXNBWfLUNQhUS7ALHQHlv3Ue
X-Authority-Analysis: v=2.4 cv=SYbHsPRu c=1 sm=1 tr=0 ts=6a76212f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=sJeJdZliiPf9M_nNF58A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX2gElbc3p+K3D
 XqSafUDTpIipzEEClUCPymQOKNe6s/4SH1No2TpyzeJpyT6B9HSxTethQSfG0bZX9CK4LyWeH3N
 loqmqjrF21FbuZRCkVEd4UH7/twDwnE=
X-Proofpoint-GUID: r63wTQ-bOXNBWfLUNQhUS7ALHQHlv3Ue
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXyKGe04T89tGZ
 sdCBcp+hS5RRoOwRS8v1Hrux9hkKZLSlwtMpMrB/aaZCiAVUAh+NnGOBHb7S0fkNHCsclRWrSY4
 IULYWiMYCcGP+QrBPoJ8CWGBLgLdSVXnO7jHV+L0QdPen4pqyhPnOBcKQRpNVi4e6tbhORYJ4vr
 qOeUQo0pWm3Mb3qHCfe2NAlIvBgWDI66slQtv0n1nbdKr/lSvAl3jHwxhAbBmWFpE8NvbXz2Wup
 ptkCYs6GVtnILFonpamr+0JAhjsLuwLsf7gDHhH+5ed/sKAn4AQxAG2VbScH5jdDxIh+jvMabHm
 vC5VHJveLdrYTlg+unQwEWgkPblE3kZhngwdpVOX/t9CMKHaUeWCTOD4X9IBEKO12ZE69KIbVUX
 aMN9QEagc6Q7kYZlOx6yCW5fqxL2VM5sJV2RTDS7f6llMZ5GfkK3MPsVMPkovfVVCWjUFtV0jf1
 qDf++6TwbAJ1GLXqEgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

struct iommufd_sw_msi_maps currently uses a fixed 64-bit bitmap,
capping the number of distinct SW MSI mappings a context or hwpt can
track. An upcoming caller needs one mapping per possible CPU.

Convert the fixed bitmap to a pointer plus size that grows on demand
via iommufd_sw_msi_maps_ensure(). Add iommufd_sw_msi_maps_test_bit()
alongside it: unlike the __set_bit() call sites, which always follow
their own successful iommufd_sw_msi_maps_ensure() call on the same id,
iommufd_group_setup_msi() tests an id from the fd-global sw_msi_list
against a specific group's required_sw_msi map, which may not have
been grown to cover that id yet. The bitmap is arbitrarily capped at
16K entries in order to simplify arithmetic validation (i.e. simple
bounds checks vs. integer wrap control).

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/iommufd/device.c          |  3 +-
 drivers/iommu/iommufd/driver.c          | 38 +++++++++++++++--------
 drivers/iommu/iommufd/hw_pagetable.c    |  1 +
 drivers/iommu/iommufd/iommufd_private.h | 41 +++++++++++++++++++++++--
 4 files changed, 67 insertions(+), 16 deletions(-)

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
index 3b8067976eac..9b9316ae4266 100644
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
+	if (ictx->sw_msi_id > IOMMUFD_SW_MSI_MAX_ID ||
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
index 43fbc5bed8de..9ca5f9f92cdf 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -9,6 +9,7 @@
 #include <linux/iova_bitmap.h>
 #include <linux/maple_tree.h>
 #include <linux/rwsem.h>
+#include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/xarray.h>
 #include <uapi/linux/iommufd.h>
@@ -29,11 +30,47 @@ struct iommufd_sw_msi_map {
 	unsigned int id;
 };
 
-/* Bitmap of struct iommufd_sw_msi_map::id */
+/* Bitmap of struct iommufd_sw_msi_map::id; starts empty, grows on demand. */
 struct iommufd_sw_msi_maps {
-	DECLARE_BITMAP(bitmap, 64);
+	unsigned long *bitmap;
+	unsigned int nbits;
 };
 
+/* Large enough for foreseeable SW MSI users while bounding bitmap growth. */
+#define IOMMUFD_SW_MSI_MAX_ID	(16U * 1024 - 1)
+
+/* Grow bitmap to accommodate id. Must be called under ictx->sw_msi_lock. */
+static inline int iommufd_sw_msi_maps_ensure(struct iommufd_sw_msi_maps *maps,
+					     unsigned int id)
+{
+	unsigned long *new_bitmap;
+	unsigned int new_nbits;
+
+	if (id < maps->nbits)
+		return 0;
+	if (id > IOMMUFD_SW_MSI_MAX_ID)
+		return -EOVERFLOW;
+
+	new_nbits = max(ALIGN(id + 1, BITS_PER_LONG), 64U);
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

