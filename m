Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF04F55C3
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188404; cv=none; b=tSz7jwFh3pGs0Q41qukewwWEjLdRUBxDqapyG2i0zzywSi3PPpX+q9dz0Zwu6Z2rPaITrioV00BWeV2JSffP8vqlDTwKVJOSwCl95vSGLdDixaSr1w5zJOfmmKh8VGxHUrcAXTcbNAtzmVFFr7Gyee8p4ttLaTHArw0IobJt8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188404; c=relaxed/simple;
	bh=wvNLjAUKFK2bSs/ebUNhj1W8nRV1wVZBPvq7blsvyJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwD6nzMFwxfiwqGka4ERCuahWiYtDsyXHyoejt4gzlKxPbgD6tPdUD/ckqMnG/VylQC1xwqUp7cCB0bbsx3N5PrK8XkJQL4bTfEz+KCkH/eMqyEUWX6a5LFdPeMaYO0sC3hvf+sDRBJzadOqvRwlSMvFkfPfK7QnodlNx4icNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BbFOEZ/2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KOcdje23; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BbFOEZ/2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KOcdje23"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETSRf3703711
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=eiVni6GVMGT
	zz+EBs6k7T0jGsM2I7x+UuWedP57pHFA=; b=BbFOEZ/2MDMNRfK6RTgunAjE/Rf
	hU2CzD9dfAdJSkYUI2bek5twFcar/2eb3WWJgoYbwF9SQ3wauSG6U0lB/JCPsVhm
	foMLCoEiHj3Aus5LE0BWOWdHRfpvv3DFv7p9h2eogW9rsA3Gy8mkJwfc0fP1EB2a
	H4v5XOBYtoZdpriDVfY0VT/yBIMYGM8aDDIrAuWH/ngc2aSZ9xHYW1IJNAgPHPEO
	hpuEzU09vbccpG1noXSbAWgvxOCa9ksDnoeew7vgYTBI6fFDDaxnSowDRSp09x2l
	5wAOQq6beOhBSfclRCuz4HS+VgA6ag0gIRTLzZAqz9EkR/lxdD23qEPDXng==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6yasc8e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936aa34873bso461143685a.3
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188401; x=1788793201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eiVni6GVMGTzz+EBs6k7T0jGsM2I7x+UuWedP57pHFA=;
        b=KOcdje23j9PdUau50GGGQlDTIjavy0jJxk/jT9tE2cOp/AlekItaooP8Am6TiwfIjp
         WX2gD1noNuywRf4nrIIMHZ2QJbhC2KH9PR0ALm28vO3UzUYxPvSWfTInNAnaoK9L94QA
         s8BmyIJn056gyo5FQMuas7ne0Rc1taOfBp8NZE+FMrvdcJpgcdQHWTX3xvYqAcMb6uQ1
         1ILFn/5Gy3uKFTrnvOSIA+OozJlVvk6NCk3Wb9xnXBFtdgxEPJx1PTcrlrD8nP7V6pbf
         mB9e4T9VP70uBUc+UqnllgpQWY+3OYNO9r64xdDQxzAjS7/F/bO6Vh9xGINwUQmAjbHK
         m9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188401; x=1788793201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eiVni6GVMGTzz+EBs6k7T0jGsM2I7x+UuWedP57pHFA=;
        b=MHA8vmP0XCIMmLcGFd0vc4ucI9+geVexsc0Kz15YgiEAi4CE/YyIWAcRwPuXodODQ6
         lQOT0YNQmhwEdB8V9EyMqiE/OG0D+tzMLCcPl9WIPlcLFu7bAiN9D1yT1AKt29gMfRgV
         uyUwicyBRI4yvuH20qwPLI7XqsyWFXx60y9J9T45zqw6qgOcOTiesgaJDcN+M9+VHcYR
         58AOWMrCMvby+CYIftXKPrGZ6Qw/yB9EeyTsxrYt399SAhPkK7R/bG/ZQhw/3SZ6jdeB
         yGzBBKX/+IGSaJQneGj3xB2BQHmkEciOkPqMl5nNGKzBZZKMzMFKbAuk+EVUz60ZOZ7O
         U6Sw==
X-Forwarded-Encrypted: i=1; AHgh+RrETn9JkDV5TNviXMBR1fHjdYCN58mv+0DZJ8jZnv2wXPZILw47MyrUSiVTHZm3Ef2DquutYw==@lists.linux.dev
X-Gm-Message-State: AFuF++kdkdLs7knzaQIMemfzYeiU+qDRZswgEmxjls10EAgdX6AQZ3CL
	1EEBM8XuEVpxYDmNRxZcQgAXXsEtFLcIVdVOFamILEC+HJr/H6xLK1WkdiRLUOazhSbaNNmZ09p
	5IwI/aLVFJOJCCGM3CFz2KsqPLYDB8d7BxbPtnQeGM5O/TQKOw48r6n4ALA==
X-Gm-Gg: AR+sD12q34gem2IDdCaZI88xQ+J87c0TpO1rGBx4SONoW1vRs82Z80uNBhQzrckASfU
	9LnBvXu7Q1n341n1uQho/Cr7NxVMRhe7F7Jg3DCClQQbItTQ0nQTENzYIusYgyrkbZNIRmxtmgb
	EeUbG/FFXaSG+4oEp2mYile8mDE35C3ExBCsVm2QqZnDuThnUJlUH0xO8EJ0UHpNhOpEJwHb1a2
	08iM4tTJk6C16PLY0rAgmHsQHKrGXEztxdWR8QHt2XLTyFHyAxmuhLCrxTQacwaL/rDUJ1RAciu
	jDwBXWcPz+mCTxKUJEdl1oVLBpBzGvHiCIkNN6CCl27MFy6IuE9/HvMsCLrKIyorx1KwzZmgiV0
	dYAALRN74EVTTVuZ8FTHDEEJZcHJrtbjhCmA=
X-Received: by 2002:a05:620a:7103:b0:939:4890:98e1 with SMTP id af79cd13be357-9394890af20mr188723285a.42.1788188400530;
        Mon, 31 Aug 2026 08:00:00 -0700 (PDT)
X-Received: by 2002:a05:620a:7103:b0:939:4890:98e1 with SMTP id af79cd13be357-9394890af20mr188718485a.42.1788188400062;
        Mon, 31 Aug 2026 08:00:00 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4843dcc00a6sm5323903f8f.33.2026.08.31.07.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 07:59:59 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v5 09/17] iommu/riscv: Report cache coherency capability
Date: Mon, 31 Aug 2026 16:59:35 +0200
Message-ID: <20260831145943.313726-10-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXzNppk5/wre/b
 UaiWZgPM+YueDWg8ofZvcqzaJheqZYtCRfnKTrBlMQXkeScOJt1P8DGqJcYuYiR41mjwlSv8idv
 qYKyTHIePF0FK4FGwE8o/7KXeuY4Bt4=
X-Authority-Analysis: v=2.4 cv=CpaPtH4D c=1 sm=1 tr=0 ts=6a9596f1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Ikd4Dj_1AAAA:8 a=ITBYzW_wA1tX7bdzKc4A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXyy0OjlAzhoCg
 C+I/MjeOEdyAOkoeCf9K22LqZUnAADy6NAZMFyufS+LRg+VqfjYlt8CEzf0nPAMmfDhE4FMYYJt
 F8kEbSDvDFmmQjULzdbDr4VvOtnuDnkzCQEP49Z9p1JHj3UgtBZYrb/o2sBGbWy9o1Loi1w1Tgf
 Q77jom7CObz9dvtMiwEek9yw0YmdxlJKZjWWPpGRuDMa8i7jZBic1V8tTaHkXYTnpK1PM+2Gm4N
 kib9JXriuEO0YsJ2aLZrcRdgrQ8YAAWr/WJvxkHaVkOXwNSCxkO6SNZ2xWe+i6bXcWceGHHsz91
 njuBuoVqQDcrILBujEaeW554EkDm8ihpsQEktXKA0Hf/Gr8/K2jsrTY/28kYT2EyGDzx7hX4TSc
 NJ6D2rdmqcZ1YnbS4+zUfsMO/fkl8Y8Le4OrMFUEeCpptNl4jV0AhV3gQ3cBF1ZLIANc8TE3FjI
 WaHEsD77ODN/6qDvq9w==
X-Proofpoint-ORIG-GUID: izRoV0rRhSJZnB1CpUilf6sjvOylGMnb
X-Proofpoint-GUID: izRoV0rRhSJZnB1CpUilf6sjvOylGMnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

VFIO and iommufd require IOMMU_CAP_CACHE_COHERENCY because they use
IOMMU_CACHE mappings and have no userspace cache-maintenance path.

RISC-V page tables preserve physical memory attributes for IOMMU_CACHE
mappings. Svpbmt marks mappings without IOMMU_CACHE as non-cacheable,
but preserving physical attributes cannot make a noncoherent device
path coherent.

Report the capability only for devices marked DMA coherent. This limits
userspace assignment to paths that can honor cacheable mappings.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/riscv/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index cec3ddd7ab10..e5818ce44515 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -16,6 +16,7 @@
 #include <linux/acpi_rimt.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
+#include <linux/dma-map-ops.h>
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
@@ -1422,6 +1423,16 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
 	return generic_device_group(dev);
 }
 
+static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return dev_is_dma_coherent(dev);
+	default:
+		return false;
+	}
+}
+
 static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
 {
 	return iommu_fwspec_add_ids(dev, args->args, 1);
@@ -1483,6 +1494,7 @@ static void riscv_iommu_release_device(struct device *dev)
 
 static const struct iommu_ops riscv_iommu_ops = {
 	.of_xlate = riscv_iommu_of_xlate,
+	.capable = riscv_iommu_capable,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
-- 
2.43.0

