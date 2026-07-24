Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326E447809
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905967; cv=none; b=bl71iZZ1eqE690ut+lyFpOQa01AyEpjVnGuYjVHV8Kk8lRveWSw6HsTDJVc/MPEfB3BBxJqv9lfZ7TdNSuK0oJlvPu5VudkutWbCalBLRF7/kQo5oUsuW8UlStWUD8bu5orTHnl9iHp0PLuNXCQL/er029/CnxSrBiLAqki6gI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905967; c=relaxed/simple;
	bh=Hu2ytPWAa1mLThexByZ9xTaT/NGZLfvhm2Cwp+vuxSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtbDVIv4xAf0Q8beRbd+NxKwhjBaF1/eB8hJ2lof8QJLiB73LJvc3bb2SR9/Hj5g6B3zR3pKpv75KiFtEqY8pVEGhrvEuTrAHdcaImJGPIWCnA+SNBuOb8FgZ/FZfVMCdAXszmAojRPbeKiF4tLYTYfregUw8gu/DaIWSHhkTWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KxRtSikM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JPcmbKh3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KxRtSikM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JPcmbKh3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbMR83071684
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jLH2lzhcItT
	X3xUJhpiKzl44Klgt40OlAokl433kV9I=; b=KxRtSikMc85KdQljMZ2gL3bnETO
	+pWUI6DZohiMQnzOmFnh7b9Oawlg2oYUSKtIxvngky2j04LNqNjShCOHJxKqEU8p
	EXfhdpuWrOTuU2erIIVlrpd99CYIf93FmNKAxivnldcOzVHbZ0UaV9CaYsIhK/Xo
	S/QqQjVE3lAwcim5f2bigSbX3edhuri+FcBveeUr8gzWnV6vNt3Sb3Yx8VPHzJjT
	LRbnj6G+W0+JfoKRg20A801izYx7Yk4/k1Mnt4Tz/9xTNNNzHLKZa4oV1HbuX0Qt
	3+yvMLjLy+r5NOH2qE1LibZ+Lb+WiZOxodNM8pW/7qkYbrw/Vl4+X0rdaYA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0pwabyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1e6f602cso8752461cf.3
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905959; x=1785510759; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jLH2lzhcItTX3xUJhpiKzl44Klgt40OlAokl433kV9I=;
        b=JPcmbKh3nNf2KAdCX+QxfCnGs6aqxW0y/+Rf7PWYrha3ytkoKUg0SmY66NaqTv/LyO
         MSBgzGIyvRpxOHKxU8QFkiR1jbVUnvBZ6KBdBmnEJhqTvCHSec5BOP9BlvWHSTa5VAqa
         LvdvdfJT4xr5z682fioX2CO2+AEdbbsmrt183HE7lI4ee+5euKpV78OahcqjhJFadOJa
         or3mHKk5UDOd/tyJtmiPDpcjfE1Ekg80B62YVArRAKaTFRojweYoWTDfKwfRzrFKn4WQ
         LDs6Pn6+iwRX5he1Cb1/QNCBuHzhnwSvK12v+gY+ekNPZZZr9uf2U4Mw8nyBDjf1WrnX
         RLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905959; x=1785510759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jLH2lzhcItTX3xUJhpiKzl44Klgt40OlAokl433kV9I=;
        b=TSeD9yQ3IX/q2Ili851t5EV7MacALzJZzrfgtCthBUNdgJfBiMoEisXkwuEkpp3mEA
         zT7n+oSMmyA+lRHzwcUofP+ZO4+WGHYy3fDKvPc/uL904fuu7W9z8VzB4vKwDtOkfmjU
         vDTCj0TmO5HXPmhp/dSvST0RKFqtPWECn6I8MvjP75/gmQ/FBckmbWKh7qwbwofHsvSD
         lZzZNWk5KbZP8zxOm5sWuo11YHHI1/pN+zLXW1AzcXoyvQ0oGfVgBgST5Ln9ojgw70fV
         1Kmdo/VuWoFPZjP9NCM8UPqwghwzZWSAhN8Y55QAKMwhaEwo4RYYYKSrKBAplVUwWnh/
         VFfw==
X-Forwarded-Encrypted: i=1; AHgh+RrrAT0bGHjZnrhfqQPtc7yIc+jWAXHp6ks8PmIWLNQrbKkwWKYzd7r37YCDlNNBdHD6T3gwRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9hHt7VGitWYslr/ydwzE/kjzE+2KwBacZpS57Xjh1hEJK2rp3
	auzqaa1VeMud3EZ3K+3m3ozt6O3lwRG5OtgklUGI+I/g0qUtHkjBx0/EXhRFxwxjCrDflcUv8li
	Z/M8658ZL5w6xrAJMONNRVQ4W0XUgjLwUq8oqFdQCfoqq4jxwkkga4zGqJg==
X-Gm-Gg: AR+sD11lGrvkPCwrNkeKVte26In+hHwWvhxavJ1k1EZiCKb0tKHMZb/KcllFQgoncHY
	O3Mz3OGCG67yyJtpL0LQIn73AD8wrTvPoNVDb8FYClUIMXXi+/by/IPaNWKNRVbUOBujuxr1qDx
	+FT8XvfRzOvV3p4TPiIysVyY0Yi42veyTy0QTpel9Qnj+yrFBfZ3L+ylGM4wuPHix41gYu189VL
	2oeLEsndOwVfwylpFq/vQaktXXIeFg7AaEH48lfO8SIh+gciEYJq93L36KB7dakPhup076BAksB
	ACdf5zGZj5bjlVUyEpqjjpD7N7TrM649Suh7UN+rveYHrg3JAW7eeAUzwj7we/TdPKLP3T9J0YQ
	7QeF9zGXN09GlBLiTNLm4qMtDHV+O64dGMg1/
X-Received: by 2002:a05:622a:580f:b0:51b:ef2c:7bf0 with SMTP id d75a77b69052e-5283de597e6mr73886921cf.35.1784905958879;
        Fri, 24 Jul 2026 08:12:38 -0700 (PDT)
X-Received: by 2002:a05:622a:580f:b0:51b:ef2c:7bf0 with SMTP id d75a77b69052e-5283de597e6mr73886481cf.35.1784905958489;
        Fri, 24 Jul 2026 08:12:38 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb51c9691sm151975a12.7.2026.07.24.08.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:37 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 08/14] iommu/riscv: Prepare info->domain for concurrent RCU read access
Date: Fri, 24 Jul 2026 17:12:12 +0200
Message-ID: <20260724151218.965929-9-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX+spWJlJQtbXi
 7Xc4+ACutpo0bxGnMXmjNSMklaTfQ+3DaPT3hMNtswnWRAKU3dtgZyXs0Bd4JtrB0KkgZXzTl9N
 vu5pLm2GvECejicHKyRiOo8MVaIm12erh4xaj2Iy+vv6nEF9iY9bW1BDD00Xa+M3NuV4xZHKmK3
 Tqox6Dw0rnxMLshwqEx2/lR01CD9CJnnNYBQjUipxGgZxYXu+TsShhmUNcbDSSKYKFlR2W5vlY7
 lmXh+aLmGJh8l4VnXOQnza4SdZ4QtH6cK5P3Fq2yKdIOsuYKSAZf73pJZ4AVyZ9QV61ojTlPoED
 QkANimKPV31dZ78MvpAjfx/Y7Vxtv5aZWJWpUJGijKkKJEZ29iKrqwlpTTBsCMayjbcC3rZv16L
 DNWBt43tamtqdoVQ/lZsqofmp6tDbQRsvZstOJIFW6rw3HAQ9S5YUzf5r/A/rWkK8ybS75mpRXM
 Cxx5kgecUK+p4IQ5ugg==
X-Authority-Analysis: v=2.4 cv=RJeD2Yi+ c=1 sm=1 tr=0 ts=6a6380e7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=j3M2sUOd0rYxyD8OH6gA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: b3ttVVy08YnnNMF8c47iwLBJvTP6uWd1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX3ZZzyjKF/r5G
 wHLpPCX5fmHEWPnyd4ctlr8RCTCJc5bCWqZ4tLPYnq6hO6KnDEiiNyY4TPOOMSfo99nhDzti0nT
 pA5EaT1VIhuXFM8w7O6xgM15C8qxlGw=
X-Proofpoint-GUID: b3ttVVy08YnnNMF8c47iwLBJvTP6uWd1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240137

An upcoming compose_msi_msg() implementation reads info->domain from
potentially atomic context, concurrent with domain switches. Apply
RCU in preparation.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 14 ++++++++------
 drivers/iommu/riscv/iommu.h |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index bfe606a0cb9a..27dfd60834ac 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1241,6 +1241,8 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 
 	WARN_ON(!list_empty(&domain->bonds));
 
+	synchronize_rcu();
+
 	riscv_iommu_ir_free_paging_domain(iommu_domain);
 
 	if ((int)domain->pscid > 0)
@@ -1296,8 +1298,8 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	}
 
 	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = domain;
+	riscv_iommu_bond_unlink(rcu_access_pointer(info->domain), dev);
+	rcu_assign_pointer(info->domain, domain);
 
 	return 0;
 }
@@ -1373,8 +1375,8 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
+	riscv_iommu_bond_unlink(rcu_access_pointer(info->domain), dev);
+	rcu_assign_pointer(info->domain, NULL);
 
 	return 0;
 }
@@ -1394,8 +1396,8 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
+	riscv_iommu_bond_unlink(rcu_access_pointer(info->domain), dev);
+	rcu_assign_pointer(info->domain, NULL);
 
 	return 0;
 }
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 5d83537911b6..ded18aec8010 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/iopoll.h>
 #include <linux/irqdomain.h>
+#include <linux/rcupdate.h>
 #include <linux/generic_pt/iommu.h>
 
 #include "iommu-bits.h"
@@ -33,7 +34,7 @@ PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
-	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_domain __rcu *domain;
 	struct irq_domain *irqdomain;
 };
 
-- 
2.43.0

