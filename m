Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EDC37AA79
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349816; cv=none; b=fGek7ONtaD98m0ZpNkc+UNlQ4+brrkqyX11LZbypi9T/YogtzctGF+WzijS0bfFXK02xjj8nd1YL2IzVonECjYa2dPhrvH5bCgKJuus8oN5uOEWxouY9kEOh0OFmb0WBsMJhD3Ev/BVzrG9jPpwMrc5nFhuEjxt9UzWhMaSrVNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349816; c=relaxed/simple;
	bh=j/AaTRyIG1jV1jycm423PVB7itVLLJ16S5Vn45gt3Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wr0DGS0Qc2dL3SSjjRwJMt+IomSov+/Jrapq5ZxR2ZINW+1g3FYfuQZDl1zd8DGaRqYELOuJmS5t8Fmomlc1n2USL+MuGsuAyV1EcHHMuJSZ5/zsJ9mjXvu+uCbbahSJzvjB/plIXYCegn7u+fbFvsrLpT5MTH0pNS/QxRyQo1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jtB4Ff7h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JS8+6PeN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jtB4Ff7h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JS8+6PeN"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PD4aI73532318
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=74iQNB8RUMX
	OEtUKhZVWnVdPbSa6Qnll3VofRt8K9nA=; b=jtB4Ff7hILDCdrFIrIiGa+IYf08
	sroVn2zma8vsUUe4ND6YKJDHHA3OK71vqB5blVOBaWdgT7pvvTT+0S0z1T9QHfVF
	06eZcYKc8ShCJEOS/1LCORUPez12OBfKFb82SzYnmBZBpq/AcGKUHVh7pQnLpzGg
	EUkAcvydKdRnsvawTxNjN5w0Fd9IXrqJoyIUckld7CAp3PSy2K1jFI7fNRYFBLLv
	gV9v8EtJJVhSaPSfd91W1iKvqQ+c39ochbHLhu4QTYU3xN1Sfuqjh9sm6aO9ZwvP
	RHRT16k5WeIai2mNMIg49I5gYLHlkvglGWuaUeNhTe/rlLhDc6QvPRWPHDA==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94kbssx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:23:33 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6b36cf0d9d3so1170213eaf.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349813; x=1790954613; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=74iQNB8RUMXOEtUKhZVWnVdPbSa6Qnll3VofRt8K9nA=;
        b=JS8+6PeNUlJaRZM5QPellwEXMtGUDWyFQc67Nax/OVRKMO+C4YlooIk5rUZfiF8BSN
         FQ1sKzjUoVaDeoa9fy4G9B/PmuyvRyHbOESCWxF88fuOo/whYKzWquloivWZHBxGD91m
         woiAusHepEbXfOXMovX2VHJ4ZWLcwa5dLcTps+bM1mAm6TJYAsZikpMNQ3EHuLO3etRm
         Ry2w+Ex9wZmgMn05y+XjOExLz+9nssCCpgGTJDzJntyiF7WkILHQnZK7owJDhQkJurJO
         azwNU/d9VCgZclb28tCQXcBZ1zCDhs/EMYp7dR+fqG9kkCRJHbP6nBr2W0jfvaxjW7ag
         TzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349813; x=1790954613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=74iQNB8RUMXOEtUKhZVWnVdPbSa6Qnll3VofRt8K9nA=;
        b=IamY/XxGhq+nJHDQw5IoTfwDcJ0EKD7eqVe+dhSAyJsfpJQIJCNtxTb+3ixz9spWBF
         9cgGSIHdYO8W7hF4Wi0JStz2Gar7ZImNeEvuU9qHc/CxyQKElLjpGKxTi+42dxyolUsN
         U+seXp9Vfiwzs0tYOpnRklS4ZF751u+yIOD37jBqb/lcIEnw40DV2QbEYmPTmEo1Sb4P
         tXyZWiLyS3qq4GIutjVqsZTDPYlfZ0AETTkznFuw4QGCkX9pat9bhEavg53TlxvDiWN+
         DIwhfWECRCJYDDSg+9Ltcyu9FxWPJdVo1IbAIpg+YEY9/TXVyex5UexRhya9pNTPFA1/
         cWvg==
X-Forwarded-Encrypted: i=1; AKwUvByymgDdYTLv6p8pAd7DuDHOyn9Mjeb6FP1AbE244TcgJ9m9nT3gSAAME0GXUCZxkrvW3EiXdQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nIngQTZ1as2GIj3jm+Vd/H0ME+BI8K5AiQawN0XDF5Oba21mA8
	aTXeao0mjX9kLBaVTAH2tMI+eUUUfc93Etaqn0Vfm98yjgGSpsKLXKm5p2MEyUUxclNPA52bLvC
	EXy8nXsZ8CUtqknWduHg7yw4y3PXKpdJuObUYpuoEVv9WCqC7i/zKh3gtNw==
X-Gm-Gg: AYBFou39aIRlO0buHbg3CcgphBfnQOJRgqinrGjF12PSsXLFPc3Mw0/nsGqV5i7vHHZ
	4rnih3A+7Iy9deCjLOiCY07Wb3AxfWAww0eq3YR5HicCEiGxH9dSFryoE3NkRbUiM9mXQ6XwtTW
	j7aJqOXcwUBRSB+kY7pX+6fWhz3o8P2m1smYRkoKfx+YZJjmth97sxLHzKBXfslWRuPVMOVQf24
	fJBBnPzq1ua8eln9LICHDHlXQ1z7ETDDpeWLhf2wENUt4KTBYL4VPfceMw2K24esBYJh7i57bPW
	k5p7IZd3RkhRDNNiJ3QVq3RLoN7cvI4au2vwJsKL/09pbfyB065+ADJs6aPSoMJ1fETIXKjh3bn
	HNmoyzcty8VoJ74pUuVwCxAHMemuV7DkqzPjoSQ==
X-Received: by 2002:a05:6102:3954:b0:7af:7d6c:495b with SMTP id ada2fe7eead31-7af7d6c4e35mr1497499137.1.1790349426970;
        Fri, 25 Sep 2026 08:17:06 -0700 (PDT)
X-Received: by 2002:a05:6102:3954:b0:7af:7d6c:495b with SMTP id ada2fe7eead31-7af7d6c4e35mr1497479137.1.1790349425890;
        Fri, 25 Sep 2026 08:17:05 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4c8dsm176766415e9.3.2026.09.25.08.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:05 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v6 02/16] iommufd: Convert struct iommufd_sw_msi_maps to a growable bitmap
Date: Fri, 25 Sep 2026 17:16:45 +0200
Message-ID: <20260925151659.419512-3-andrew.jones@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=aaj0Dhot c=1 sm=1 tr=0 ts=6ab691f6 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=69EAbJreAAAA:8 a=SRrdq9N9AAAA:8 a=8L5tTrZ4L9qXjquGIIcA:9
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-GUID: exYY7ZKCdH1tow16SXImi7dBjBeU0O2D
X-Proofpoint-ORIG-GUID: exYY7ZKCdH1tow16SXImi7dBjBeU0O2D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MSBTYWx0ZWRfX1LpbRbJqqn43
 1No/AXbY5RcX6hOWbwEh4hceqs1n7Tw8YPWLrkSeqydGIhdSrQgqI96ZbIlFZUXLqmr4aArN2K2
 4jqKo8psNvXg+GHEGORNKK5ln/uxAY7P9b2Cx4YaBUi0XU0DwO3OtMqF72QtJT6SU/0F6kJNc1/
 tVRy5RKb1K2d3rLSV0rxha2dK0DvrEMV6zJ3Qdniw1yk5leUeBYBLfxudBYpwENvrkgOqSNrzK6
 yd7t0Acwm1Otek31ZqhnoSmxUB/VajQQHJ0c9VvvMC+PicnC9REvYWR54EGJxq1CKRfXox5Md/l
 WYYGGjCw9Vrqeqvi3qf51zhi7wxR7XIv6B/eW8TNilK9qei0F1NeSR356H0/VWj/qr5kU9B2si6
 5L9CjFEbY0dq94gu3sY5RjewEf7tTcpNTpowtC7EOBWuQO7Vfe6YGUY6JIAoR8sA2Xl6exyJGoa
 IhKTjbMyDkUDOdd+evQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MSBTYWx0ZWRfXx/VovWilx4o1
 EwVfK3P5aCLXJRqzN3M0ZG309nfMAHTrCAv8LmfMKIxBKWauE3rgMuZ7iwyap4D+eMapMQKLkuF
 Q/zZXQEe5G6rCb4n/zePCti1hDcYyWI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250061

struct iommufd_sw_msi_maps uses a fixed 64-bit bitmap, limiting each
group and hardware page table to 64 software MSI mappings. RISC-V
interrupt remapping needs a mapping for every possible CPU, so this
limit is insufficient.

Make the bitmap grow on demand and treat IDs beyond its current size
as absent. Cap it at 16K entries to bound allocation size while leaving
ample room for expected software MSI users.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/iommufd/device.c          |  3 +-
 drivers/iommu/iommufd/driver.c          | 37 ++++++++++++++--------
 drivers/iommu/iommufd/hw_pagetable.c    |  1 +
 drivers/iommu/iommufd/iommufd_private.h | 41 +++++++++++++++++++++++--
 4 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a664c70a6fe7..28e2c98ef953 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -49,6 +49,7 @@ static void iommufd_group_release(struct kref *kref)
 		iommu_group_put(igroup->group);
 	}
 	mutex_destroy(&igroup->lock);
+	kfree(igroup->required_sw_msi.bitmap);
 	kfree(igroup);
 }
 
@@ -450,7 +451,7 @@ static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 		int rc;
 
 		if (cur->sw_msi_start != igroup->sw_msi_start ||
-		    !test_bit(cur->id, igroup->required_sw_msi.bitmap))
+		    !iommufd_sw_msi_maps_test_bit(&igroup->required_sw_msi, cur->id))
 			continue;
 
 		rc = iommufd_sw_msi_install(ictx, hwpt_paging, cur);
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index e4d17a748178..ea705e416139 100644
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
@@ -222,21 +224,25 @@ int iommufd_sw_msi_install(struct iommufd_ctx *ictx,
 			   struct iommufd_sw_msi_map *msi_map)
 {
 	unsigned long iova;
+	int rc;
 
 	lockdep_assert_held(&ictx->sw_msi_lock);
 
+	if (iommufd_sw_msi_maps_test_bit(&hwpt_paging->present_sw_msi, msi_map->id))
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
@@ -290,6 +296,11 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
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
index ef6e119c2a75..81f41d437c4c 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -41,6 +41,7 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 	}
 
 	__iommufd_hwpt_destroy(&hwpt_paging->common);
+	kfree(hwpt_paging->present_sw_msi.bitmap);
 	refcount_dec(&hwpt_paging->ioas->obj.users);
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index eb2e85b27e42..774cbe28cbaf 100644
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

