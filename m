Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F04484257
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262119; cv=none; b=BzkhMw4LcNfLu6YccXDu4Dble6KMo7qhDZ6doTDP3GGGHzd+xMIpSgBlMItBjf7tN5ODPbzRw2wWjlDQ3LWhrw+cSYeGgK3mI2oRE4KtIKeArPmHu7KFru4KCEyECAM5vxnVcqeLRrw+bCjYzMpaKzwRHReKm1DRkInpUnqllQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262119; c=relaxed/simple;
	bh=hDCASb2QszCJtZ46ymXjW+uprvmUGOjM7wHcmbcONUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnGiUk4XNq7F0bRvxJouNgv2sFCCmraDEyw97+vqHxPm2V/3ES6wassFMHxLP/mhHyj7/ejA7BX5XfnNK7hWQ3y69oHjI4iZKDzCBnqJc62nfndGlhQfV7M+JL8hdXbWKBTk7bo9N4mWs6t1wfLD1Jbz3nNpSisUw6FJ+X84peU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d5TDpidI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WHcqQzB5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d5TDpidI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WHcqQzB5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK82vP588113
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ULD8UiC7UtV
	MR72OBgPjKW1Cvtm/Xs0kpr5dd9Tku68=; b=d5TDpidIHPHF3TYCLZeTHsdjKBc
	xjpvCnmRgV+ObcV6vcNs1GSDsLB8cU89SEyes5O2rs1BxTPG4QqRaqgIvzYNWHBA
	wkntASaM2d6BDBjZbrftfhB4naKD2FDXV1mulI4rkuivtxbOQbtqN0fdz1XFeEjH
	rSRaqdQ+fOLInGcJuhp6/tZ1BTk1rbsZ/9uq5rP/M5V33uBYFAdikzfDVXno8zDJ
	kuyFx8RmjO0Q7mItXRyz6BRIvbUpRtN8NB+BtH4stVtbTdPHFshMU+vAbCq7059v
	lggF8z0empP4czP5dtKCsSIPnEF8FG0ZzPyQ0/j4AFQW8OGYsG2Zl2aTm+w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg8b22x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:41:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52de05de414so3455091cf.2
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262116; x=1787866916; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULD8UiC7UtVMR72OBgPjKW1Cvtm/Xs0kpr5dd9Tku68=;
        b=WHcqQzB5//By3ci4cqygx8tBvsILU+Jg4ETTaKjJoFRiDeGIsOurD6JZowX8LbfKaQ
         kPZ5jPoyobi2ziEs80EIbw5bLod2ZE5w5gJXx0F6F4f8CYIrTh0B4kVhA8XrMyHZE6m4
         fF9CRdubUgm/NdcZYUTy3RbvncVqbLKBSsb9v3ydwdo/00AWcCeyRilwdgKGr/UmU9hb
         +7Z6eimNXyaXIuO5f/9wLNvZ6n9OZbI4dPsLN5uvdYTpBve//oGIqv70/vIsRCU1CC+q
         halbi9eEnRMp/FabicgKXwRHhzzB1bfbZM1wzNk6y2Odjzj44AjF4ayUq0SIfX9c9jsg
         qIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262116; x=1787866916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ULD8UiC7UtVMR72OBgPjKW1Cvtm/Xs0kpr5dd9Tku68=;
        b=fbR7GV5w2UV/KpLdgVOGNDYnl5An78bYHAE00UBiJiALtJPq4Bl20zXwPkTfWbwEXg
         FWRCt8IzcgBjCT2LyqxKElQrS3jcVC9polJsGT8uBdda5Yg5xpR/JclxZ7/cOsK4INEK
         ypCttYQSdGlSYisj9+N2mtOHOyufG/PbT0XMm+08rKniyUQH28WXIwtJa1qLrN0coXZ1
         DGnLXQBfqUUNA9fezea8kH20QpQI8Yc/V9rdhvxDc8S6IxoGY6ibsmN1AUm/j+phmL6R
         o2rUJTmHgNPuTcV9MI7Qy/ttzGtOOUsBscupkiT9t0uywKeBLYZbLuxid52Xf6lok5Nn
         or/w==
X-Forwarded-Encrypted: i=1; AHgh+RqCnRhkDDTMFifwb1xhd+ur4mnlRcqSQYTUjgXsoLBmnX7eYvOdekPcv/hoGxwvgBLRNHETvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3TtedQgSUpglWgHl712nNFzhrflxXRvNvoBkviwyQ0FVMVjAy
	2Z8nOMXcK5rx6PrQxi+2cJMHcAdcZZtWzZwL3u4HUSbMkb+QkyzBI97D882vzj1ZiFea+LgbhlW
	G0NRR9QnrUpOhOw/kiaL5YD0oe5S6JC05b7FX+8/o9SKNEnvNJzimH+I/cw==
X-Gm-Gg: AR+sD10Lx61SToHH3Izso0eM6jbTlBa4WmAo2L5froIPt4NY4bRvbN1xXTMM1vMDg7k
	Ur3f8RxBqQ1erAzDWzcQvXwK1pQByjhqszhikzXQ37tCZimdYxizVzAeTPodRbjix1/8a41cXnZ
	xVHgtl4zYpuIcZfDCesn7wbdA/RjeMBip4g6X++kVbqsmxQMdcEMlJQ/5XaU2NV/fRw+nulPpfc
	7nQVXDvf0BhiRrcUHPO+KJ5eookymDgXM8VimJU7nnMK/DpRFgBLyrEd8bvEASKqF0DXtSbd+b/
	bpfIbdC2UK35xEIcZFcFRQWeW4l3dTu/l7f3nmDzRRqsBlFWEBf6fXzi/rBa4j/UVwbXWXwmwpp
	NEpLn9v/Y
X-Received: by 2002:a05:622a:164f:b0:52d:3352:f7ac with SMTP id d75a77b69052e-52df5a15479mr14185871cf.28.1787262116216;
        Thu, 20 Aug 2026 14:41:56 -0700 (PDT)
X-Received: by 2002:a05:622a:164f:b0:52d:3352:f7ac with SMTP id d75a77b69052e-52df5a15479mr14185171cf.28.1787262115417;
        Thu, 20 Aug 2026 14:41:55 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d05a6sm16373207f8f.35.2026.08.20.14.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:41:54 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 01/21] iommufd: Convert struct iommufd_sw_msi_maps to a growable bitmap
Date: Thu, 20 Aug 2026 23:41:30 +0200
Message-ID: <20260820214150.545737-2-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX7FPDVVV5tyaP
 YjeCZugPkn9isyfA+ZEkY4EUewzdZBN48+3XV6pUubNgP0WpaLIMtUvXpNvzxh74Vit3qQbTjsI
 3KiwaQJciSML+lH67dN340+/9QTAeq8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfXyxr9g0MjbbLK
 G9jOoqTwOnOwXOOOa99p5l2L1BtFtDYTv/UiDypUolpDOvl7si6b9JncBKxAetclrUGbacYMf4W
 wZvPZSe+zRU3xoHQFzTH8dtByE9YQjxZGj2O6SaLbNQre8f2CPENAiNFsEnwBSL2ZYwrNbeB03H
 m+jXM66k4k5gc2QDm6qJoBrofuiNY25DUF+E2IJGNVMNrTKmnYDnM0npi8TaZfaGwpEwV2299ix
 3Xcvg0J/ZSvzWx95z53OSrrKQZsbXDY9TE/OGTRAAfN14gLl6y4WoViufKOQnl+n3PMjt9u0yMC
 hi4ql+WU+1PsQQb4PzCGfoju+RiaXIyDnvS2xuHgJho7eo4L02XmQRcjkGkobZyZ3TsGmOYVcJw
 ay+4pL21zoXWIv/asEuUQL8jBVQa+Z63ZdYo8FSjAj8+umR7ltNlMH8blXGTAnj3e6NUJprR/+w
 tfaKgkp+a94s3yQ16kA==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a8774a4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=8L5tTrZ4L9qXjquGIIcA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 39-x3kk_N3aX9kqsrp5Fh3K304PdcuQd
X-Proofpoint-ORIG-GUID: 39-x3kk_N3aX9kqsrp5Fh3K304PdcuQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

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
 drivers/iommu/iommufd/driver.c          | 38 +++++++++++++++--------
 drivers/iommu/iommufd/hw_pagetable.c    |  1 +
 drivers/iommu/iommufd/iommufd_private.h | 41 +++++++++++++++++++++++--
 4 files changed, 67 insertions(+), 16 deletions(-)

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

