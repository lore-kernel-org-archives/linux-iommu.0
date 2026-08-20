Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A13485CCF
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262139; cv=none; b=B1088PZ7p+loctrtKbn2nJphlAIjTV3XSIUipxSxBTiGD56wURQlLkZ/MY5nc7vuYGPTA6KgkRlj3QHmDug1kZmSZK5wA6jQJowOkLuOXWAOL/cSfI/pS4x9dK2WuYDkFtTGlBF4M9CI+fTohGqXoyse57p6mt+yagnP+e8x9ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262139; c=relaxed/simple;
	bh=6LhTUQC9AegowoeMdmRSNjd64XC43UGJC4HdSOARlJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=me4OGWHDWoV3dTG3kkDWpv9DMF7U8G73Mrcu/6pu+wXLVTk4idCUCX2d+DaSWWU0eACHm+EWPidhrbjEZTcinLal34i/5RBbEFlPWcVfY0N9+iPGTO+3M/ffQ0UaZMFHzb1rL0snxIy7cEyJLoWUnKRJzYJrJeTOrhtG7eP1fhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWjBBWRr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KHuSfgrB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWjBBWRr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KHuSfgrB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK82vR588113
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=P/zqvE9ElCl
	TLoXgDLGZyTryGyE4Ywyz/R9X/x/PjNY=; b=bWjBBWRrIGVwvDsvZhUcx5jRwNN
	06jN7SGtaH8qjX1rwmqRLU6+A/EAunLMkylupjENk44H/LsTtWq3h+SWO4CBW6v5
	UUmmcryQk1sXSW3l/KgJ7GeOlrwFVzqYkTELAl7HKlxVSywXEspoPk48ubSRyHEx
	cSnE4GnNK35nXeY1L7kLUUhmJr8RUy3iGnL9nNbDkmNg3UM9O+PtLlNdf4uQpWrZ
	C51aB7une3p787gJeOogdurCaVml9YHlq8LGhUpd1qcuu6UQ0y+o6qq8jBODgol1
	CwZf/pnGxqm0l3e4PFvtzbknPXnqDXG8cqPqsgpuSF6LVZiCtzLwSFL/a/g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg8b24d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e52306621so31807485a.1
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262133; x=1787866933; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P/zqvE9ElClTLoXgDLGZyTryGyE4Ywyz/R9X/x/PjNY=;
        b=KHuSfgrB1QnxOqwUr9yup+YwUrL1DDZWvUtm5ypvYfHAA1uYz+r2tqf3ld6CH59Ex2
         ch+FuADHzq8EkhDbIES/TSzGlzHP4MDiL3w96ltvdKP0aQcWN92B5Fcxz7UE/cgKID+q
         7Ee/vIluhQ0tYKltBFPBQGwdFWHqVrqdrfnKy9NqMp8RTkvkmLdmet9mP6jRfXI+QF1t
         fgQlv1PNkbDSM+w/QFh/6VcIoDDtBAzaMFSXjOPr42YOgLMwg5v6h1I2dqRONeGuZPK+
         bJiAHbtNVGWebk7OjMKFWhlV0m7Q/p29ve9DmtYELwGYShOVvvkxZGzSc/ayPri3bdo0
         iumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262133; x=1787866933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P/zqvE9ElClTLoXgDLGZyTryGyE4Ywyz/R9X/x/PjNY=;
        b=MgeWH+I9fZdB6IqGmn4DM6b8igjusvHSiOxXEgHrQVO0R3DEEUL34GBFGNXAdwu/Q2
         pQQhAyV+p3nJOemSvWH/yKBMzLEw+UH45znJW5RRDFkfEI47ax1Ap8XUKnKVhYpQnaSl
         ebDy39iZQc5+P90NJLSbvzznYAkDVCRFySn8F0IwWf02yYGMEsoBIbBWsyApotzylA0Y
         DlY7gHeq5d7RMTrUQtkOLlHbit/PWoZInL/5obyEorvGpVjpzJIhuoXcocL8JjZE3pmj
         CNNk79/yZgj6UjPdkFIX84aqYVB5nngwRr8Y8POTiwhtfw0lAq0MNYdBPn7AZMQfA+17
         kdVw==
X-Forwarded-Encrypted: i=1; AHgh+RqfNXFPWChFVN4OU/+fKO3ROeMFo2JEI6evGt/S1ryDn9QshQ1mic1N7AeRkVZLW0P2KR49uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJiAKw+8S/8SvMO2ANPC08H6PttLlII+o6AaSyS9csFQ7HpvbO
	Qje0zGhX5v/CCWvvBx5NYkhP+8zAI+oBqUdx5QS0quYrEds45iqqf5a7czwSBEtQX+1/yTSVXEP
	/dTcjaVFNviZdJDuwL4ivBswKcWx6hSVq8i+y2DOdxsvtDwKWN4+6Erbxlw==
X-Gm-Gg: AR+sD12rYEfBD/nuaMLxe92x84VS+bztMklte6wh1apmtqUjbtOul89Iei2kJ0phHFX
	LNyKATDIEQZpM3saEkLsJAqAaYiI6X+c7pcRW087wJ5OyWAExyhFYfuh1+kQYlYH8kQby4FsraM
	TD/syCLc9hEzV8Sg8iRgEqAdfGHvqBaYOif2LhrflqXQR0xr4B+vn0PqDWZ1MTNFV2LtKjuvTX9
	Cv8aDq184jUQStNSN6GFSEdaUa+XBf842LyoiehIYHyvcN45GFz19GXelPMxO45xBsFhpLgJVo5
	VqzcV7gX3bVahwdstlpPbIsDaNJAYjTMN+HK6uskpq/jvCO6vr/fZ8nQRbnkpdJm3xkutIryFvV
	q84Jmtjws
X-Received: by 2002:a05:620a:472a:b0:936:cd1a:41c5 with SMTP id af79cd13be357-937392b190dmr138761585a.0.1787262132999;
        Thu, 20 Aug 2026 14:42:12 -0700 (PDT)
X-Received: by 2002:a05:620a:472a:b0:936:cd1a:41c5 with SMTP id af79cd13be357-937392b190dmr138756985a.0.1787262132540;
        Thu, 20 Aug 2026 14:42:12 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c338dsm12494474f8f.25.2026.08.20.14.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:11 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 10/21] iommu/riscv: Prepare info->domain for concurrent RCU read access
Date: Thu, 20 Aug 2026 23:41:39 +0200
Message-ID: <20260820214150.545737-11-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX1fdUG8FLAu1Y
 kGDAr4FQmz18Fhw5B8Hv7vOp+HWbf32NEM49Zyp9QJERC+2iz8O2D3bBV+gswJC9b+I6b1FzX0s
 1xdPrIlmwyOY5gEelMeInX5CmgKylGw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX6vDhLdlFJTm9
 cF22/IugEf7sC0q5uxopk8oQHCKJHOxOWySnaRyprg4riU4+qTRvY5ReiSGjfdCV7hPZFqj5g7N
 lhk35sMTehBZINlTdCYVrepSqBOXYcTMwIZbu2029HfpP16zRUoXOTEZzT6eT+KgwCWOqTx3A3x
 nBGrPFO/F+QWmNavvBSSaYSTHj8kpAmU85S45Dh4SnftILmY0mCFWoh/GU57DMACbj/q9hiK82x
 /B/OisdKDzXdfA2mlhDDHrPFVtugBbvWkjMBK4Tmmpjt5f1s4z+NFbjH1RXU7y6P723sEQLLjSa
 ZWQDWeoym8e8ulediQLndQRgeb/0TEumtxzkuXJIoCMyQjR4PNGZZygwyrsFAdPoG/EXTlG5hTm
 l0Ln//+j7ZsLlRh5RkP75hlGcKnZkIald9q5/iUxMiH/N63GuqUV/ULrX6E9g7JGF8hX+dpYCqM
 kmU4ddK5dY+Yt6KjW7Q==
X-Authority-Analysis: v=2.4 cv=Y7/IdBeN c=1 sm=1 tr=0 ts=6a8774b5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VmW0014DqEszS8sibs8A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 9EYI0vLtUZDnPNDRdi4OEU4C_bzDMZQM
X-Proofpoint-ORIG-GUID: 9EYI0vLtUZDnPNDRdi4OEU4C_bzDMZQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

An upcoming compose_msi_msg() implementation reads info->domain from
potentially atomic context, concurrent with domain switches. Apply
RCU in preparation.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 26 ++++++++++++++++----------
 drivers/iommu/riscv/iommu.h |  3 ++-
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index bfe606a0cb9a..4e14c8412abc 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -865,17 +865,21 @@ static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
 	return 0;
 }
 
-static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
+static void riscv_iommu_bond_unlink(struct iommu_domain *iommu_domain,
 				    struct device *dev)
 {
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_device *iommu;
 	struct riscv_iommu_bond *bond, *found = NULL;
 	struct riscv_iommu_command cmd;
 	int count = 0;
 
-	if (!domain)
+	if (!iommu_domain || !(iommu_domain->type & __IOMMU_DOMAIN_PAGING))
 		return;
 
+	domain = iommu_domain_to_riscv(iommu_domain);
+	iommu = dev_to_iommu(dev);
+
 	spin_lock(&domain->lock);
 	list_for_each_entry(bond, &domain->bonds, list) {
 		if (found && count)
@@ -1241,6 +1245,8 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 
 	WARN_ON(!list_empty(&domain->bonds));
 
+	synchronize_rcu();
+
 	riscv_iommu_ir_free_paging_domain(iommu_domain);
 
 	if ((int)domain->pscid > 0)
@@ -1291,13 +1297,13 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 
 	ret = riscv_iommu_ir_attach_paging_domain(iommu_domain, dev, old);
 	if (ret) {
-		riscv_iommu_bond_unlink(domain, dev);
+		riscv_iommu_bond_unlink(iommu_domain, dev);
 		return ret;
 	}
 
 	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = domain;
+	riscv_iommu_bond_unlink(old, dev);
+	rcu_assign_pointer(info->domain, domain);
 
 	return 0;
 }
@@ -1373,8 +1379,8 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
+	riscv_iommu_bond_unlink(old, dev);
+	rcu_assign_pointer(info->domain, NULL);
 
 	return 0;
 }
@@ -1394,8 +1400,8 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
-	riscv_iommu_bond_unlink(info->domain, dev);
-	info->domain = NULL;
+	riscv_iommu_bond_unlink(old, dev);
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

