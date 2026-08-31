Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08D4A6CC9
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188398; cv=none; b=p7BGEFB12DRLlxYMvxmh7qye9JiCznNDprqhqnd5lTGWar9doib8d0en7mdTieenvsf+k+T3FmI98NzsgAPYPF4mcW7nfY2aXkgvSqZC/hI63sRcma74yEMqS3n1UIv45QG22n1Mt92z+cSL+AOk6cIPwqaRd2Vfw5+F6AMIOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188398; c=relaxed/simple;
	bh=LtlqMXm9zBkwSU5DtdkUgM+gIjTOqK4fl4LJf+WqFTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnDvOY9N07tMnuBLn6zhJDwEZYTJwjDcv59QmQNfoNId4h9txVJwBPZlN/JDS4CpFJY4VKPn/hCkn4gRMXTC1gVPGvgjUy0uAy7OmR3aWfIpvMgG2YPSB7z5R4cXDlPQ2cYRy3dhn4RwEY+uFEQR4P7ss19PUxT1DI1mmoLbQVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WWKFtOR3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MrLoirBS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WWKFtOR3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MrLoirBS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETVDM3807936
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4GHoWBlwh+Z
	DFPbKlbwwLkJp6XL3wIYVeEUFlrZWxZg=; b=WWKFtOR3UPCpEXNS/clvIkda4ms
	qH3YTzhPwYSzkDmsNy4hULkg6/anMEgbJeSZ5U4SnzkD71jbYGq6GrDFxYmXUd6y
	n6AH39e8p/HwrN9KJn7Pn91kFWEAaMbs2Z5X4jGfdNLUHPYaCIzC/+mKHwG5z9BN
	r+S0NCCoyZ/Dli083bJJz6L8GtcsddjiVdVw1RcwgQ2qA67i3dchTEB9vQ6Uz0GU
	hf3aVEgWMB4vnYcXuaiOBwtDeYrXWSlW/cMngcd1njtCGD4KFF/at2CgZPvi5dWH
	LUTFTP8I47c5h+poQ1hoO0YRRPL0qpuTbXaMi/H3q2HxWqQVY9HKRXj1eFA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7wbaj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 14:59:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9390ca1a9abso522275185a.2
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188394; x=1788793194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4GHoWBlwh+ZDFPbKlbwwLkJp6XL3wIYVeEUFlrZWxZg=;
        b=MrLoirBS+gwS7EdnAlRGVb4L2LuGktxRRSoMKaSkK6+grS6/ArT/JcQR0xpQuK5R88
         SxxJVki4fII4ABbpuEgG2bb6siJpgztrzUzDN6zagaEL1qhe7xmIS2oe8YUQA7QLaBgh
         bNSjl6m9gniouNnEgECQIRLb1bh9M8ZUEW8VhEFr14dlNXJ6qNUJPmCy13gaaOySmANq
         TLzKeP9jTcW/LGBQ3pAcElDiru1zcwuMIa7bY+SIc+Xu+YCeHJ6P87sIIuqBYbgTIlbG
         VQIz8venkQMbd3del5iibEp+pBHM020yVPM07O1w4q+QjCbilAU7GHOwgAd478xM5L+2
         lCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188394; x=1788793194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4GHoWBlwh+ZDFPbKlbwwLkJp6XL3wIYVeEUFlrZWxZg=;
        b=UPTYkBk96dE/udPK3+mi8900q5PXW1MS8FY5nrnH2bPrye/Ft19tI5ERYNCjiPm30C
         CnsBTSIjP3LyAWORiKOViQMxIYaDj5w5wbwg9PjlDyJq6nl34TCp9JAmRdwXgO71GVAf
         YkV1RIQDNK3U1D9/DC8bk0Hpyw0EgvI9KtZwlVFEILsg38PKcWDbeC7nyGX0prpgpajh
         Ath5/ejU1IuoTOusEKj/mhBuzTTgm5BAvEPV4d9mrMCylBL/nWKx81pxk6sSy3fyJ+61
         FdWNUdOTZGTNNBgpcb6PfIo8Jpg8erSmC0zM8Pu8+NHd1YQlfo0UKc4GRUDIPj5txRQN
         MDtw==
X-Forwarded-Encrypted: i=1; AHgh+RrbZMlGVZC3PYvDuzeUXwam6eJG8uhYNvnv2w0fatN2ZCk1hxKXz9CqnGuK0Hx7K1vEzoQKcA==@lists.linux.dev
X-Gm-Message-State: AFuF++nbLYWyVfyplXQjrxWsxxcrvdL26gK9RS/fjUV088lRHOqqR0VS
	aOtygltmPiDH1r5Yy0y61CldZ27NDksHmHVwCJzTynJEaxVJTtZ2dcPMhnFnsGM4AxKDRk0GgeS
	/XEPCdic5/0N0ZiN9gT1oeRR+Y0Z4H/HAmTmHHQEeALROxhz3vv0xXojEAw==
X-Gm-Gg: AR+sD11hosMAP65bkbe5Dnpk3L98jTExZr3girv4w9Ez58BMxh5jogU9403Se/50IIV
	KVmaFdc3V9tBM1j2eeUh0kinMBt19KB8y6nm5C16iLAJCk1B3UxFV6nv1Gik5x2EV43XSYl+L7M
	ikzW06DMfrYvLXauvttFye3PvItRapZ0ViJH4u8aB7depS/4cvQ2b5+bArGtwnGjod8F0IHfOq7
	+FU2Kw9vNY/DOvHGSg92u0dUk41BJX5AS8qeNtaDmWVYGFy0gUWQZIl0JFiMhIabN+/1rPGxDpB
	ht+jiOUGETGGHuYN+Iz1JFpmbG9utcw5hW8aGitzdnpT43ktTRB21n5M8ShYwQWlkNKNVVbUT5n
	VeGxxSwz2QYH4fZorDCz1Bh0V90upYF8t/lc=
X-Received: by 2002:a05:620a:8394:b0:92e:5cfd:154e with SMTP id af79cd13be357-93913801d90mr3156857385a.14.1788188393930;
        Mon, 31 Aug 2026 07:59:53 -0700 (PDT)
X-Received: by 2002:a05:620a:8394:b0:92e:5cfd:154e with SMTP id af79cd13be357-93913801d90mr3156788985a.14.1788188388672;
        Mon, 31 Aug 2026 07:59:48 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb20713sm22270269f8f.21.2026.08.31.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:47 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 02/17] iommufd: Convert struct iommufd_sw_msi_maps to a growable bitmap
Date: Mon, 31 Aug 2026 16:59:28 +0200
Message-ID: <20260831145943.313726-3-andrew.jones@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a9596eb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=8L5tTrZ4L9qXjquGIIcA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXwAvwY2FQ2DM/
 kv8kxg+bPyicmhmvqCkhmL8P6DfyFZIuRbFwAPhvRpNnsL8MgIkrj2/Q/EMgS2dQWfGIJW9XPjB
 3NK2qkE09Q/xDCjJdZ08K9/7OuI4YpM=
X-Proofpoint-ORIG-GUID: S3qOLZN2HLXlAdrb3EkuvhqfgCM7yxoA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX+4b1vkBotOjB
 g15JtUzZBdfloBYq/oeVh9tf6NAUaWfCKkYXLiuBII3CLp6MQSVKZpdYkqXZt2pw1aTgg0+0R5C
 l1vRhpPAJoX3RsPQEJJR2MkmEBc4+Gbhmc1Cq8BL8OADqOnStJh+e2AKYZjou6kZStMnsZApkGm
 U8J6/aZ6mxaKwUs6+zmVKkER5V/3qqO1H5UuvYkiq+D0ZP9TEAcDV4Pff2R1sgsOaYz57Hy/8ho
 iUeqmEeHwryaV00jijRvyBx9+Id59hR91mzXjuCXim93sr6EfwYWBpJQO7r/4/LNl8LAqDyevCw
 6TaQ51vOnK487P6u13dWzZ9RwppUoEZy18ReI3e3TudiNrd2p/+jTmuXeYeGUFuuWlhW80htIYE
 cgjeKyZhJ7eVlhF4sc71Yz/lTMo5RNNeipzHrjy+GVgmFQNBOI74y46MmNW8ncnKEjbjCp23WqB
 6lbIHG7c3iOVSLfNBBg==
X-Proofpoint-GUID: S3qOLZN2HLXlAdrb3EkuvhqfgCM7yxoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310129

struct iommufd_sw_msi_maps uses a fixed 64-bit bitmap, limiting each
group and hardware page table to 64 software MSI mappings. RISC-V
interrupt remapping needs a mapping for every possible CPU, so this
limit is insufficient.

Make the bitmap grow on demand and treat IDs beyond its current size
as absent. Cap it at 16K entries to bound allocation size while leaving
ample room for expected software MSI users.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/iommufd/device.c          |  3 +-
 drivers/iommu/iommufd/driver.c          | 37 ++++++++++++++--------
 drivers/iommu/iommufd/hw_pagetable.c    |  1 +
 drivers/iommu/iommufd/iommufd_private.h | 41 +++++++++++++++++++++++--
 4 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d488c23fd353..868f1e591208 100644
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
index 3b8067976eac..d0b05b1fda42 100644
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

